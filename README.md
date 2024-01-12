# cuda_torch.unique
A c++ and cuda implement scripts of torch.unique

## Torch.unique()
Official documents: [**torch.unique()**](https://pytorch.org/docs/stable/generated/torch.unique.html#torch.unique)
```python
def torch.unique(input, sorted=True, return_inverse=False, return_counts=False, dim=None) → Tuple[Tensor, Tensor, Tensor]
***
  Parameters:
    - input (Tensor) – the input tensor
    - sorted (bool) – Whether to sort the unique elements in ascending order before returning as output.
    - return_inverse (bool) – Whether to also return the indices for where elements in the original input ended up in the returned unique list.
    - return_counts (bool) – Whether to also return the counts for each unique element.
    - dim (int, optional) – the dimension to operate upon. If None, the unique of the flattened input is returned. Otherwise, each of the tensors indexed by the given dimension is treated as one of the elements to apply the unique operation upon. See examples for more details. Default: None

  Returns:
   A tensor or a tuple of tensors containing
    - output (Tensor): the output list of unique scalar elements.
    - inverse_indices (Tensor): (optional) if return_inverse is True, there will be an additional returned tensor (same shape as input) representing the indices for where elements in the original input map to in the output; otherwise, this function will only return a single tensor.
    - counts (Tensor): (optional) if return_counts is True, there will be an additional returned tensor (same shape as output or output.size(dim), if dim was specified) representing the number of occurrences for each unique value or tensor.
***
```


## Python example
```
python torch_unq.py

Input (PyTorch): tensor([1, 2, 3, 2, 1, 4, 5, 3, 2, 1])
Unique Coords (PyTorch): tensor([1, 2, 3, 4, 5])
Counts (PyTorch): tensor([3, 3, 2, 1, 1])
Inverse Indices (PyTorch): tensor([0, 1, 2, 1, 0, 3, 4, 2, 1, 0])

```
## C++ example
```
g++ torch_unq.cc -o torch_unq_c.o -std=c++17 && ./torch_unq_c.o

Input: 1 2 3 2 1 4 5 3 2 1 
Unique Value (C++): 1 2 3 4 5 
Unique Counts (C++): 3 3 2 1 1 
Inverse Indices (C++): 0 1 2 1 0 3 4 2 1 0 

```

## CUDA example
```
nvcc torch_unq.cu -o torch_unq_cu.o -std=c++17 && ./torch_unq_cu.o

Input: 1 2 3 2 1 4 5 3 2 1 
Unique Value (CUDA): 1 2 3 4 5 
Unique Counts (CUDA): 3 3 2 1 1 
Inverse Indices (CUDA): 0 1 2 1 0 3 4 2 1 0 

```
