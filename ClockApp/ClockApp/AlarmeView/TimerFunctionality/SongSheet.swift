//
//  SongSheet.swift
//  ClockApp
//
//  Created by Clissia Bozzer Bovi on 24/05/23.
//

import SwiftUI

struct SongSheet: View {
    
    let songList: Array<String> = ["Ascensão Lenta", "Boletim", "Constelação", "Cristais", "Coruja"]
    var body: some View {
        List {
            ForEach(songList, id: \.self) {
                Text("\($0)")
            }
        }
    }
}

struct SongSheet_Previews: PreviewProvider {
    static var previews: some View {
        SongSheet()
    }
}
