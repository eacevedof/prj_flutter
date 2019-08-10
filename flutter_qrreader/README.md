## QR Reader Capitulo 9
- 9.4. Inicio de proyecto - QRScanner
- 9.5. BottomNavigationBar - QRScanner
    - No se puede hacer una navegación por páginas en un StatelessWidget
    - Tenemos que transformar a un StatefulWidget (con estado)
    - Se hace que la barra de navegación envie su posición y en base a esta se devuelva la pág correspondiente
    ```dart
    //home_page.cart
    class _HomePageState extends State<HomePage> {

        int iCurrPage = 0;  

        @override
        Widget build(BuildContext context) {
        
            return Scaffold(      
            body: _get_page_wg(iCurrPage),
            bottomNavigationBar: _get_bottom_navbar(),
            );

        }//build

        Widget _get_bottom_navbar(){

            return BottomNavigationBar(
            //que posicion de botón está activa (se colorea en azul)
            currentIndex: iCurrPage, 

            onTap: (index){
                setState(() {
                iCurrPage = index; 
                });
            },
            
            items: [
                BottomNavigationBarItem(
                icon: Icon(Icons.map),
                title: Text("Mapas"),
                ),

                BottomNavigationBarItem(
                icon: Icon(Icons.brightness_1),
                title: Text("Direcciones"),
                ),
            ],//los botones
                
            );

        }//_get_bottom_navbar

        Widget _get_page_wg(int iPagActual){
            switch(iPagActual){
                case 0: return MapasPage();
                case 1: return DireccionesPage();
                default: return MapasPage();
            }
        }//_get_page_wg
        
    }// HomePage
    ```