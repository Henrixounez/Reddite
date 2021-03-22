// Function to flatten array of arrays
List<T> flatten<T>(List arr) => 
  arr.fold([], (value, element) => 
   [
     ...value, 
     ...(element is List ? flatten(element) : [element])
   ]);

// Get the String for Duration since a DateTime
String timeAgo(DateTime time) {
  Duration diff = (DateTime.now()).difference(time);
  
  if (diff.inSeconds < 60) {
    return '${diff.inSeconds}s';
  } else if (diff.inMinutes < 60) {
    return '${diff.inMinutes}min';
  } else if (diff.inHours < 24) {
    return '${diff.inHours}h';
  } else if (diff.inDays < 365) {
    return '${diff.inDays}d';
  } else {
    return '${(diff.inDays / 365.25).floor()}y';
  }
}