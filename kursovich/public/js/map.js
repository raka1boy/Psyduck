ymaps.ready(init);

function init() {
    var myMap = new ymaps.Map("map", {
            center: [55.398881, 37.773134],
            zoom: 16
        }, {
            searchControlProvider: 'yandex#search'
        }),
        myGeoObject = new ymaps.GeoObject({
            geometry: {
                type: "Point",
                coordinates: [55.398881, 37.773134]
            },
            properties: {
                iconContent: 'Магазин канцтоваров - psyduck',
                hintContent: 'Работаем без выходных, с 08:00 до 22:00'
            }
        }, {
            preset: 'islands#blackStretchyIcon',
            draggable: false
        })
    myMap.geoObjects
        .add(myGeoObject);
}