# skeleton

This project acts like a skeleton project with all the barely minimum needed plugins

1. Get it -> For singleton services
2. pretty_dio_logger -> For API logs
3. dio -> For API Call
4. shared_preferences -> For Local key value pair storage
5. flash -> For Snackbar
6. permission_handler -> For Runtime permission
7. cached_network_image -> For cached imageview
8. firebase_messaging -> For push notification (Please check branch named ```firebase_setup```)
9. easy_localization -> For Translations (Please check branch named ```translations```)
10. shimmer -> For shimmer effects
11. firebase_core -> For firebase core library (Please check branch named ```firebase_setup or null_safety```)
12. eraser -> To clear try notifications (Please check branch named ```null_safety```)

Note : 

1. This project is compatible with flutter 2.0 & up. Also please let me know if any more things required.
2. This project is unsound null safety.
3. In pagination listview while passing is last page do this check for proper endless loader rendering
   ```isLastPage : page >= (isPaginating ? totalPages + 1 : totalPages)```
