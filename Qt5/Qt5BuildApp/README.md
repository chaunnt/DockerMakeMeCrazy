# How to use

change any docker to "Dockerfile" to release your madness

CREDIT !!

I'm coding for food, if this work helps you or your company, 
would you kind to send me some cup of noodles.
- give it via paypal: https://paypal.me/chaunnt


If you need any further development, feel free to drop me an issue or email to chaupad@gmail.com


# How to build

docker build -f Dockerfile -t dockerdrivemecrazy/qt5buildandrun:latest .

docker push dockerdrivemecrazy/qt5buildandrun

docker run -v -d -t dockerdrivemecrazy/qt5buildandrun:latest --restart unless-stopped


