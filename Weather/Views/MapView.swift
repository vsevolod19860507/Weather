//
//  MapView.swift
//  Weather
//
//  Created by Vsevolod R on 17.07.2022.
//

import SwiftUI
import MapKit

struct MapView: View {
    @EnvironmentObject private var locationViewModel: LocationViewModel
    
    var body: some View {
        VStack {
            GeometryReader { proxy in
                Map(
                    coordinateRegion: $locationViewModel.currentRegion,
                    showsUserLocation: true,
                    annotationItems: [locationViewModel.selectedLocation],
                    annotationContent: {
                        MapMarker(coordinate: $0)
                    }
                )
                .gesture(
                    LongPressGesture(minimumDuration: 0.25)
                        .sequenced(
                            before: DragGesture(
                                minimumDistance: 0,
                                coordinateSpace: .local
                            )
                        )
                        .onEnded { value in
                            switch value {
                            case .second(true, let drag):
                                locationViewModel.setSelectedLocation(at: drag!.location, for: proxy.size)
                            default:
                                break
                            }
                        }
                )
                .highPriorityGesture(DragGesture(minimumDistance: 10))
            }
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
