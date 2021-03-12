List<T> flatten<T>(List arr) => 
  arr.fold([], (value, element) => 
   [
     ...value, 
     ...(element is List ? flatten(element) : [element])
   ]);
