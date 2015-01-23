module PostsHelper
  def divide_into_col(arr, col = 2)
    slice_size = (arr.length / Float(col)).ceil
    arr.each_slice(slice_size).to_a
  end
end
