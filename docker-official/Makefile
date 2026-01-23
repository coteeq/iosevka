all:
	docker run --network host -it --rm -v $(PWD):/work -e "VERSION_TAG=v34.0.0" fontcc ttf::Uosevka2 ttf::Serifka
	
serifka:
	docker run --network host -it --rm -v $(PWD):/work -e "VERSION_TAG=v34.0.0" fontcc ttf::Serifka
uosevka:
	docker run --network host -it --rm -v $(PWD):/work -e "VERSION_TAG=v34.0.0" fontcc ttf::Uosevka2

image:
	docker build --network host -t fontcc .
