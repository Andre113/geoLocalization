//
//  ViewController.m
//  GeoLocation
//
//  Created by Andre Lucas Ota on 26/02/15.
//  Copyright (c) 2015 Andre Lucas Ota. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize locationManager, painel, onOff;

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
    [self.painel isOn];
    
    [_map setShowsUserLocation:YES];
    
}

//CLLicationManager envia a mensagem locationManager:didUpdateLocations: locations ao seu delegate
- (void) locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    NSLog(@"%@", [locations lastObject]);
    
    //Encontrar as coordenadas de localiação atual
    CLLocationCoordinate2D loc = [[locations lastObject] coordinate];
    
    //Determinar região com as coordenadas de localização atual e os limites N/S e L/O no zoom em metros
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(loc, 250, 250);
    
    //Mudar a região atual para a vizualização de forma animada
    [_map setRegion:region animated:YES];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
