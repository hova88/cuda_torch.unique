#include <iostream>
// why thrust need so much headers -_-!!!
#include <thrust/unique.h>
#include <thrust/binary_search.h>
#include <thrust/functional.h>
#include <thrust/execution_policy.h>
#include <thrust/copy.h>
#include <thrust/device_ptr.h>
#include <thrust/device_vector.h>
#include <thrust/sort.h>
#include <thrust/iterator/constant_iterator.h>

void torch_unique(const int* raw_value, const int size,
                  int* unique_value, int* inverse_indices, int* unique_counts, int& num_unique) {
    // Allocate device memory and copy raw_value to device
    thrust::device_vector<int> d_raw_value(raw_value, raw_value + size);
    thrust::device_vector<int> d_unique_value(size);
    thrust::device_vector<int> d_unique_counts(size);
    thrust::device_vector<int> d_inverse_indices(size);

    // Init a new device_vec to store sorted values
    thrust::device_vector<int> sorted_values = d_raw_value;
    thrust::sort(sorted_values.begin(), sorted_values.end());

    // Use thrust::reduce_by_key to get unique elements and their counts
    auto new_end = thrust::reduce_by_key(sorted_values.begin(), sorted_values.end(),
                          thrust::make_constant_iterator(1),
                          d_unique_value.begin(),
                          d_unique_counts.begin());
    num_unique = new_end.first - d_unique_value.begin();

    // Use thrust::lower_bound to get inverse indices
    thrust::lower_bound(d_unique_value.begin(), d_unique_value.begin() + num_unique,
                        d_raw_value.begin(), d_raw_value.end(), d_inverse_indices.begin());

    // Copy results back to host
    thrust::copy(d_unique_value.begin(), d_unique_value.begin() + num_unique, unique_value);
    thrust::copy(d_inverse_indices.begin(), d_inverse_indices.end(), inverse_indices);
    thrust::copy(d_unique_counts.begin(), d_unique_counts.begin() + num_unique, unique_counts);
}

int main() {
    // Example usage
    int raw_value[] = {1, 2, 3, 2, 1, 4, 5, 3, 2, 1};
    int size = sizeof(raw_value) / sizeof(int);

    // Allocate host memory for results
    int unique_value[size], inverse_indices[size], unique_counts[size];

    // Call CUDA function
    int num_unique = 0;
    torch_unique(raw_value, size, unique_value, inverse_indices, unique_counts, num_unique);

    // Print results
    auto printArray = [](const char* label, const int* arr, int size) {
      std::cout << label << ": ";
      for (int i = 0; i < size; ++i) {
          std::cout << arr[i] << " ";
      }
      std::cout << std::endl;
    };

    printArray("Input", raw_value, size);
    printArray("Unique Value (CUDA)", unique_value, num_unique);
    printArray("Unique Counts (CUDA)", unique_counts, num_unique);
    printArray("Inverse Indices (CUDA)", inverse_indices, size);
    return 0;
}

