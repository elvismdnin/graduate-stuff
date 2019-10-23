function onMousePress(e) {
    let point = new THREE.Vector3();
    point.set(
        (e.clientX / window.innerWidth) * 2 - 1,
        - (e.clientY / window.innerHeight) * 2 + 1,
        0
    );
    point.unproject(camera);
    point.z = 0;

    var geometry = new THREE.Geometry();
    geometry.vertices.push(point);
    scene.add( new THREE.Points( geometry, pointMaterial) );
}

function reset() {
    while(scene.children.length > 0){
        scene.remove(scene.children[0]);
    }
    scene.add( generateAxis(windowWidth, 0, 0, lineMaterial) );
    scene.add( generateAxis(0, windowHeight, 0, lineMaterial) );
}

window.addEventListener( 'contextmenu', reset, false );
window.addEventListener( 'mousedown', onMousePress, false );