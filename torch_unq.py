import torch
# Example usage
raw_value = torch.tensor([1, 2, 3, 2, 1, 4, 5, 3, 2, 1]).reshape(10,)

unique_value, inverse_indices, unique_counts = torch.unique(raw_value, 
                                                     return_inverse=True, 
                                                     return_counts=True, 
                                                     dim=0)
# Print results
print("Input (PyTorch):", raw_value)
print("Unique Coords (PyTorch):", unique_value)
print("Counts (PyTorch):", unique_counts)
print("Inverse Indices (PyTorch):", inverse_indices)


"""
Output:
Input (PyTorch): tensor([1, 2, 3, 2, 1, 4, 5, 3, 2, 1])
Unique Coords (PyTorch): tensor([1, 2, 3, 4, 5])
Counts (PyTorch): tensor([3, 3, 2, 1, 1])
Inverse Indices (PyTorch): tensor([0, 1, 2, 1, 0, 3, 4, 2, 1, 0])
"""
