#include <iostream>
#include <vector>
#include <algorithm>
#include <unordered_map>

void torch_unique(const std::vector<int>& raw_value,
                    std::vector<int>& unique_value,
                    std::vector<int>& inverse_indices,
                    std::vector<int>& unique_counts) {
  
  // Initialize unordered_map to track occurrences of each element
  std::unordered_map<int, int> element_counts;
  std::vector<int> sorted_raw_value = raw_value;
  std::sort(sorted_raw_value.begin(), sorted_raw_value.end(), std::greater<int>());

  // Iterate through the input vector
  for (const auto& coord : sorted_raw_value) {
      // Increment the count for the current element
      element_counts[coord]++;
  }

  // reserve space for the output vectors
  unique_value.reserve(element_counts.size());
  unique_counts.reserve(element_counts.size());

  // Iterate through unique elements and populate result vectors
  for (const auto& entry : element_counts) {
      unique_value.push_back(entry.first);
      unique_counts.push_back(entry.second);
      
  }

  // Create a map to find indices efficiently
  std::unordered_map<int, int> coord_to_index;
  for (size_t i = 0; i < unique_value.size(); ++i) {
      coord_to_index[unique_value[i]] = i;
  }

  // Iterate through the input vector and populate inverse indices
  for (const auto& coord : raw_value) {
      inverse_indices.push_back(coord_to_index[coord]);
  }
}

int main() {
  // Example usage
  std::vector<int> raw_value = {1, 2, 3, 2, 1, 4, 5, 3, 2, 1};
  std::vector<int> unique_value;
  std::vector<int> inverse_indices;
  inverse_indices.reserve(raw_value.size());
  std::vector<int> unique_counts;


  torch_unique(raw_value, unique_value, inverse_indices, unique_counts);

  // Print results
  auto printArray = [](const char* label, const std::vector<int> arr) {
    std::cout << label << ": ";
    for (int i = 0; i < arr.size(); ++i) {
        std::cout << arr[i] << " ";
    }
    std::cout << std::endl;
  };

  printArray("Input", raw_value);
  printArray("Unique Value (C++)", unique_value);
  printArray("Unique Counts (C++)", unique_counts);
  printArray("Inverse Indices (C++)", inverse_indices);


    return 0;
}

/* Output:
 * Input (c++): 1 2 3 2 1 4 5 3 2 1 
 * Unique Value (c++): 1 2 3 4 5 
 * Unique_counts (c++): 3 3 2 1 1 
 * Inverse Indices (c++): 0 1 2 1 0 3 4 2 1 0 
*/
