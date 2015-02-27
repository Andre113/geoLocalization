//
//  ViewController.m
//  GeoLocation
//
//  Created by Andre Lucas Ota on 26/02/15.
//  Copyright (c) 2015 Andre Lucas Ota. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () {
    //Para o rememberIt
    BOOL marcar;
}

@end

@implementation ViewController

@synthesize locationManager, painel, onOff;

NSMutableArray *locais;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Não apertou o botão para marcar
    marcar = NO;
    
    self.view.backgroundColor = [UIColor colorWithRed:1.0 green:0.972 blue:0.862 alpha:1];
    
    //Alocar memória para o location manager
    locationManager = [[CLLocationManager alloc]init];
    
    //Mostrar ao locationManager o quão exata deve ser a localização encontrada
    [locationManager setDesiredAccuracy: kCLLocationAccuracyBest];
    
    //Determinar que a propriedade delegate do locationManager seja a instância da ViewController
    [locationManager setDelegate: self];
    
    [locationManager requestAlwaysAuthorization];
    
    //Dizer ao locationManager para começar a procurar pela localização imediatamente
    [locationManager startUpdatingLocation];
    
    //[_map setShowsUserLocation:YES];
    
    locais = [[NSMutableArray alloc]init];
    
}

//CLLicationManager envia a mensagem locationManager:didUpdateLocations: locations ao seu delegate
- (void) locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    NSLog(@"%@", [locations lastObject]);
    
    //Encontrar as coordenadas de localiação atual
    CLLocationCoordinate2D loc = [[locations lastObject] coordinate];
    [locais addObject:[locations lastObject]];
    
    if (marcar) {
        CLLocationCoordinate2D last = [[locais lastObject] coordinate];
        MKPointAnnotation *pm = [[MKPointAnnotation alloc]init];
        //Determinar a localização do MKPointAnnotation
        pm.coordinate = last;
        
        //Outra forma de Determinar a localização do MKPointAnnotation
        [pm setCoordinate:last];
        
        //Adicionar pm ao mapa
        [_map addAnnotation:pm];
        
        //Retorna o valor do marcar para NO
        marcar = NO;
    }
    
    
    if([self.painel isOn]){
        //Determinar região com as coordenadas de localização atual e os limites N/S e L/O no zoom em metros
        MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(loc, 250, 250);
        
        //Mudar a região atual para a vizualização de forma animada
        [_map setRegion:region animated:YES];
    }
    else{
        [locationManager stopUpdatingLocation];
    }
}

-(void) locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    //Tratar erro
}

- (IBAction)autoUpdate:(id)sender{
    if([self.painel isOn]){
        [locationManager startUpdatingLocation];
        [onOff setText:@"Auto Update - ON"];
    }
    else{
        [locationManager stopUpdatingLocation];
        [onOff setText:@"Auto Update - OFF"];
    }
}

- (IBAction)point:(id)sender {
    //Marcar é YES, então o didUpdateLocations irá marcar
    marcar = YES;
    [locationManager startUpdatingLocation];
    /*
    //Instanciar o MKPointAnnotation
    MKPointAnnotation *pm = [[MKPointAnnotation alloc]init];
    CLLocationCoordinate2D last;
    
    if([self.painel isOn]){
        
        last = [[locais lastObject] coordinate];
    
        //Determinar a localização do MKPointAnnotation
        pm.coordinate = last;
        
        //Outra forma de Determinar a localização do MKPointAnnotation
        [pm setCoordinate:last];

        //Adicionar pm ao mapa
        [_map addAnnotation:pm];
    }
    else{
        
        [locationManager startUpdatingLocation];
        last = [[locais lastObject] coordinate];
        
        //Determinar a localização do MKPointAnnotation
        pm.coordinate = last;
        
        //Outra forma de Determinar a localização do MKPointAnnotation
        [pm setCoordinate:last];
        
        //Adicionar pm ao mapa
        [_map addAnnotation:pm];
    }*/
 }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
