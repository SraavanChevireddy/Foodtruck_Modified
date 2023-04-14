/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
The sidebar and the root of the navigation interface.
*/

import SwiftUI
import FoodTruckKit

/// An enum that represents the person's selection in the app's sidebar.
///
/// The `Panel` enum encodes the views the person can select in the sidebar, and hence appear in the detail view.
enum Panel: Hashable {
    /// The value for the ``TruckView``.
    case truck
    /// The value for the ``SocialFeedView``.
    case socialFeed
    #if EXTENDED_ALL
    /// The value for the ``AccountView``.
    case account
    #endif
    /// The value for the ``OrdersView``.
    case orders
    /// The value for the ``SalesHistoryView``.
    case salesHistory
    /// The value for the ``DonutGallery``.
    case donuts
    /// The value for the ``DonutEditor``.
    case donutEditor
    /// The value for the ``TopFiveDonutsView``.
    case topFive
    /// The value for the ``CityView``.
    case city(City.ID)
}

/// The navigation sidebar view.
///
/// The ``ContentView`` presents this view as the navigation sidebar view on macOS and iPadOS, and the root of the navigation stack on iOS.
/// The superview passes the person's selection in the ``Sidebar`` as the ``selection`` binding.
struct Sidebar: View {
    /// The person's selection in the sidebar.
    ///
    /// This value is a binding, and the superview must pass in its value.
    @Binding var selection: Panel?
    
    /// The view body.
    ///
    /// The `Sidebar` view presents a `List` view, with a `NavigationLink` for each possible selection.
    var body: some View {
        List(selection: $selection) {
        
            Section {
                NavigationLink(value: Panel.socialFeed) {
                    Rectangle().foregroundColor(.green)
                        .frame(width: 30, height: 30)
                }
                #if EXTENDED_ALL
                NavigationLink(value: Panel.account) {
                    Label("Account", systemImage: "person.crop.circle")
                }
                #endif
                NavigationLink(value: Panel.salesHistory) {
                    Rectangle().foregroundColor(.pink)
                        .frame(width: 30, height: 30)
                }
            } header: {
                HStack {
                    NavigationLink(value: Panel.truck) {
                        Rectangle().foregroundColor(.pink)
                            .frame(maxWidth: .infinity)
                            .frame(height: 100)
                            .contextMenu {
                                Text("I'm Not the context")
                            }
                    }

                    NavigationLink(value: Panel.orders) {
                        Rectangle().foregroundColor(.yellow)
                            .frame(maxWidth: .infinity)
                            .frame(height: 100)
                            .contextMenu {
                                Text("I'm the Context")
                            }
                    }
                }
            }.listStyle(.plain)

            

         
            
            Section("Donuts") {
                NavigationLink(value: Panel.donuts) {
                    Label {
                        Text("Donuts")
                    } icon: {
                        Image.donutSymbol
                    }
                }
                
                NavigationLink(value: Panel.donutEditor) {
                    Label("Donut Editor", systemImage: "slider.horizontal.3")
                }
                
                NavigationLink(value: Panel.topFive) {
                    Label("Top 5", systemImage: "trophy")
                }
            }.listStyle(.sidebar)

            Section("Cities") {
                ForEach(City.all) { city in
                    NavigationLink(value: Panel.city(city.id)) {
                        Label(city.name, systemImage: "building.2")
                    }
                    .listItemTint(.secondary)
                }
            }
        }
        .navigationTitle("Food Truck")
        #if os(macOS)
        .navigationSplitViewColumnWidth(min: 200, ideal: 200)
        #endif
    }
}

struct Sidebar_Previews: PreviewProvider {
    struct Preview: View {
        @State private var selection: Panel? = Panel.truck
        var body: some View {
            Sidebar(selection: $selection)
        }
    }
    
    static var previews: some View {
        NavigationSplitView {
            Preview()
        } detail: {
           Text("Detail!")
        }
    }
}
