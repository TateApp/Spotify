import Foundation

struct RecentlyPlayedResonse : Codable {
    let href : String
    let items: [RecentlyPlayedItem]
    let limit: Int
    let next : String

}

struct RecentlyPlayedItem : Codable {
    let track : AudioTrack
    
    let played_at : String
}
struct RecentlyPlayedItemTrack : Codable {
    let album : Album
    let artists : [Artist]
//    let available_markets : [Artist]
    let disc_number: Int
    let duration_ms: Int
    let explicit: Bool
    let name : String
    let popularity : Int
    let uri : String
}


struct Album : Codable {
    let album_type : String
    let available_markets: [String]
                            
    let id : String
    let images: [APIImage]
    let name : String
    let release_date: String
    let total_tracks : Int
    let artists: [Artist]
    
}

//{
//    cursors =     {
//        after = 1642594454001;
//        before = 1642593586479;
//    };
//    href = "https://api.spotify.com/v1/me/player/recently-played?limit=2";
//    items =     (
//                {
//            context =             {
//                "external_urls" =                 {
//                    spotify = "https://open.spotify.com/album/2nLOHgzXzwFEpl62zAgCEC";
//                };
//                href = "https://api.spotify.com/v1/albums/2nLOHgzXzwFEpl62zAgCEC";
//                type = album;
//                uri = "spotify:album:2nLOHgzXzwFEpl62zAgCEC";
//            };
//            "played_at" = "2022-01-19T12:14:14.001Z";
//            track =             {
//                album =                 {
//                    "album_type" = album;
//                    artists =                     (
//                                                {
//                            "external_urls" =                             {
//                                spotify = "https://open.spotify.com/artist/1Xyo4u8uXC1ZmMpatF05PJ";
//                            };
//                            href = "https://api.spotify.com/v1/artists/1Xyo4u8uXC1ZmMpatF05PJ";
//                            id = 1Xyo4u8uXC1ZmMpatF05PJ;
//                            name = "The Weeknd";
//                            type = artist;
//                            uri = "spotify:artist:1Xyo4u8uXC1ZmMpatF05PJ";
//                        }
//                    );
//                    "available_markets" =                     (
//                        AD,
//                        AE,
//                        AG,
//                        AL,
//                        AM,
//                        AO,
//                        AR,
//                        AT,
//                        AU,
//                        AZ,
//                        BA,
//                        BB,
//                        BD,
//                        BE,
//                        BF,
//                        BG,
//                        BH,
//                        BI,
//                        BJ,
//                        BN,
//                        BO,
//                        BR,
//                        BS,
//                        BT,
//                        BW,
//                        BY,
//                        BZ,
//                        CA,
//                        CD,
//                        CG,
//                        CH,
//                        CI,
//                        CL,
//                        CM,
//                        CO,
//                        CR,
//                        CV,
//                        CW,
//                        CY,
//                        CZ,
//                        DE,
//                        DJ,
//                        DK,
//                        DM,
//                        DO,
//                        DZ,
//                        EC,
//                        EE,
//                        EG,
//                        ES,
//                        FI,
//                        FJ,
//                        FM,
//                        FR,
//                        GA,
//                        GB,
//                        GD,
//                        GE,
//                        GH,
//                        GM,
//                        GN,
//                        GQ,
//                        GR,
//                        GT,
//                        GW,
//                        GY,
//                        HK,
//                        HN,
//                        HR,
//                        HT,
//                        HU,
//                        ID,
//                        IE,
//                        IL,
//                        IN,
//                        IQ,
//                        IS,
//                        IT,
//                        JM,
//                        JO,
//                        JP,
//                        KE,
//                        KG,
//                        KH,
//                        KI,
//                        KM,
//                        KN,
//                        KR,
//                        KW,
//                        KZ,
//                        LA,
//                        LB,
//                        LC,
//                        LI,
//                        LK,
//                        LR,
//                        LS,
//                        LT,
//                        LU,
//                        LV,
//                        LY,
//                        MA,
//                        MC,
//                        MD,
//                        ME,
//                        MG,
//                        MH,
//                        MK,
//                        ML,
//                        MN,
//                        MO,
//                        MR,
//                        MT,
//                        MU,
//                        MV,
//                        MW,
//                        MX,
//                        MY,
//                        MZ,
//                        NA,
//                        NE,
//                        NG,
//                        NI,
//                        NL,
//                        NO,
//                        NP,
//                        NR,
//                        NZ,
//                        OM,
//                        PA,
//                        PE,
//                        PG,
//                        PH,
//                        PK,
//                        PL,
//                        PS,
//                        PT,
//                        PW,
//                        PY,
//                        QA,
//                        RO,
//                        RS,
//                        RU,
//                        RW,
//                        SA,
//                        SB,
//                        SC,
//                        SE,
//                        SG,
//                        SI,
//                        SK,
//                        SL,
//                        SM,
//                        SN,
//                        SR,
//                        ST,
//                        SV,
//                        SZ,
//                        TD,
//                        TG,
//                        TH,
//                        TJ,
//                        TL,
//                        TN,
//                        TO,
//                        TR,
//                        TT,
//                        TV,
//                        TW,
//                        TZ,
//                        UA,
//                        UG,
//                        US,
//                        UY,
//                        UZ,
//                        VC,
//                        VE,
//                        VN,
//                        VU,
//                        WS,
//                        XK,
//                        ZA,
//                        ZM,
//                        ZW
//                    );
//                    "external_urls" =                     {
//                        spotify = "https://open.spotify.com/album/2nLOHgzXzwFEpl62zAgCEC";
//                    };
//                    href = "https://api.spotify.com/v1/albums/2nLOHgzXzwFEpl62zAgCEC";
//                    id = 2nLOHgzXzwFEpl62zAgCEC;
//                    images =                     (
//                                                {
//                            height = 640;
//                            url = "https://i.scdn.co/image/ab67616d0000b2734ab2520c2c77a1d66b9ee21d";
//                            width = 640;
//                        },
//                                                {
//                            height = 300;
//                            url = "https://i.scdn.co/image/ab67616d00001e024ab2520c2c77a1d66b9ee21d";
//                            width = 300;
//                        },
//                                                {
//                            height = 64;
//                            url = "https://i.scdn.co/image/ab67616d000048514ab2520c2c77a1d66b9ee21d";
//                            width = 64;
//                        }
//                    );
//                    name = "Dawn FM";
//                    "release_date" = "2022-01-06";
//                    "release_date_precision" = day;
//                    "total_tracks" = 16;
//                    type = album;
//                    uri = "spotify:album:2nLOHgzXzwFEpl62zAgCEC";
//                };
//                artists =                 (
//                                        {
//                        "external_urls" =                         {
//                            spotify = "https://open.spotify.com/artist/1Xyo4u8uXC1ZmMpatF05PJ";
//                        };
//                        href = "https://api.spotify.com/v1/artists/1Xyo4u8uXC1ZmMpatF05PJ";
//                        id = 1Xyo4u8uXC1ZmMpatF05PJ;
//                        name = "The Weeknd";
//                        type = artist;
//                        uri = "spotify:artist:1Xyo4u8uXC1ZmMpatF05PJ";
//                    }
//                );
//                "available_markets" =                 (
//                    AD,
//                    AE,
//                    AG,
//                    AL,
//                    AM,
//                    AO,
//                    AR,
//                    AT,
//                    AU,
//                    AZ,
//                    BA,
//                    BB,
//                    BD,
//                    BE,
//                    BF,
//                    BG,
//                    BH,
//                    BI,
//                    BJ,
//                    BN,
//                    BO,
//                    BR,
//                    BS,
//                    BT,
//                    BW,
//                    BY,
//                    BZ,
//                    CA,
//                    CD,
//                    CG,
//                    CH,
//                    CI,
//                    CL,
//                    CM,
//                    CO,
//                    CR,
//                    CV,
//                    CW,
//                    CY,
//                    CZ,
//                    DE,
//                    DJ,
//                    DK,
//                    DM,
//                    DO,
//                    DZ,
//                    EC,
//                    EE,
//                    EG,
//                    ES,
//                    FI,
//                    FJ,
//                    FM,
//                    FR,
//                    GA,
//                    GB,
//                    GD,
//                    GE,
//                    GH,
//                    GM,
//                    GN,
//                    GQ,
//                    GR,
//                    GT,
//                    GW,
//                    GY,
//                    HK,
//                    HN,
//                    HR,
//                    HT,
//                    HU,
//                    ID,
//                    IE,
//                    IL,
//                    IN,
//                    IQ,
//                    IS,
//                    IT,
//                    JM,
//                    JO,
//                    JP,
//                    KE,
//                    KG,
//                    KH,
//                    KI,
//                    KM,
//                    KN,
//                    KR,
//                    KW,
//                    KZ,
//                    LA,
//                    LB,
//                    LC,
//                    LI,
//                    LK,
//                    LR,
//                    LS,
//                    LT,
//                    LU,
//                    LV,
//                    LY,
//                    MA,
//                    MC,
//                    MD,
//                    ME,
//                    MG,
//                    MH,
//                    MK,
//                    ML,
//                    MN,
//                    MO,
//                    MR,
//                    MT,
//                    MU,
//                    MV,
//                    MW,
//                    MX,
//                    MY,
//                    MZ,
//                    NA,
//                    NE,
//                    NG,
//                    NI,
//                    NL,
//                    NO,
//                    NP,
//                    NR,
//                    NZ,
//                    OM,
//                    PA,
//                    PE,
//                    PG,
//                    PH,
//                    PK,
//                    PL,
//                    PS,
//                    PT,
//                    PW,
//                    PY,
//                    QA,
//                    RO,
//                    RS,
//                    RU,
//                    RW,
//                    SA,
//                    SB,
//                    SC,
//                    SE,
//                    SG,
//                    SI,
//                    SK,
//                    SL,
//                    SM,
//                    SN,
//                    SR,
//                    ST,
//                    SV,
//                    SZ,
//                    TD,
//                    TG,
//                    TH,
//                    TJ,
//                    TL,
//                    TN,
//                    TO,
//                    TR,
//                    TT,
//                    TV,
//                    TW,
//                    TZ,
//                    UA,
//                    UG,
//                    US,
//                    UY,
//                    UZ,
//                    VC,
//                    VE,
//                    VN,
//                    VU,
//                    WS,
//                    XK,
//                    ZA,
//                    ZM,
//                    ZW
//                );
//                "disc_number" = 1;
//                "duration_ms" = 214214;
//                explicit = 0;
//                "external_ids" =                 {
//                    isrc = USUG12106683;
//                };
//                "external_urls" =                 {
//                    spotify = "https://open.spotify.com/track/2Ghp894n1laIf2w98VeAOJ";
//                };
//                href = "https://api.spotify.com/v1/tracks/2Ghp894n1laIf2w98VeAOJ";
//                id = 2Ghp894n1laIf2w98VeAOJ;
//                "is_local" = 0;
//                name = "How Do I Make You Love Me?";
//                popularity = 88;
//                "preview_url" = "https://p.scdn.co/mp3-preview/a2608508a1f9eb16c30f989d3edf84c143330a51?cid=221b702aebea423e8c603f87f0959eed";
//                "track_number" = 3;
//                type = track;
//                uri = "spotify:track:2Ghp894n1laIf2w98VeAOJ";
//            };
//        },
//                {
//            context =             {
//                "external_urls" =                 {
//                    spotify = "https://open.spotify.com/playlist/37i9dQZF1Epn5fSfHmKrpX";
//                };
//                href = "https://api.spotify.com/v1/playlists/37i9dQZF1Epn5fSfHmKrpX";
//                type = playlist;
//                uri = "spotify:playlist:37i9dQZF1Epn5fSfHmKrpX";
//            };
//            "played_at" = "2022-01-19T11:59:46.479Z";
//            track =             {
//                album =                 {
//                    "album_type" = album;
//                    artists =                     (
//                                                {
//                            "external_urls" =                             {
//                                spotify = "https://open.spotify.com/artist/7t7KCNFOwuMChaQg6L8I69";
//                            };
//                            href = "https://api.spotify.com/v1/artists/7t7KCNFOwuMChaQg6L8I69";
//                            id = 7t7KCNFOwuMChaQg6L8I69;
//                            name = "Jacob Latimore";
//                            type = artist;
//                            uri = "spotify:artist:7t7KCNFOwuMChaQg6L8I69";
//                        }
//                    );
//                    "available_markets" =                     (
//                        AD,
//                        AE,
//                        AG,
//                        AL,
//                        AM,
//                        AO,
//                        AR,
//                        AT,
//                        AU,
//                        AZ,
//                        BA,
//                        BB,
//                        BD,
//                        BE,
//                        BF,
//                        BG,
//                        BH,
//                        BI,
//                        BJ,
//                        BN,
//                        BO,
//                        BR,
//                        BS,
//                        BT,
//                        BW,
//                        BY,
//                        BZ,
//                        CA,
//                        CD,
//                        CG,
//                        CH,
//                        CI,
//                        CL,
//                        CM,
//                        CO,
//                        CR,
//                        CV,
//                        CW,
//                        CY,
//                        CZ,
//                        DE,
//                        DJ,
//                        DK,
//                        DM,
//                        DO,
//                        DZ,
//                        EC,
//                        EE,
//                        EG,
//                        ES,
//                        FI,
//                        FJ,
//                        FM,
//                        FR,
//                        GA,
//                        GB,
//                        GD,
//                        GE,
//                        GH,
//                        GM,
//                        GN,
//                        GQ,
//                        GR,
//                        GT,
//                        GW,
//                        GY,
//                        HK,
//                        HN,
//                        HR,
//                        HT,
//                        HU,
//                        ID,
//                        IE,
//                        IL,
//                        IN,
//                        IQ,
//                        IS,
//                        IT,
//                        JM,
//                        JO,
//                        JP,
//                        KE,
//                        KG,
//                        KH,
//                        KI,
//                        KM,
//                        KN,
//                        KR,
//                        KW,
//                        KZ,
//                        LA,
//                        LB,
//                        LC,
//                        LI,
//                        LK,
//                        LR,
//                        LS,
//                        LT,
//                        LU,
//                        LV,
//                        LY,
//                        MA,
//                        MC,
//                        MD,
//                        ME,
//                        MG,
//                        MH,
//                        MK,
//                        ML,
//                        MN,
//                        MO,
//                        MR,
//                        MT,
//                        MU,
//                        MV,
//                        MW,
//                        MX,
//                        MY,
//                        MZ,
//                        NA,
//                        NE,
//                        NG,
//                        NI,
//                        NL,
//                        NO,
//                        NP,
//                        NR,
//                        NZ,
//                        OM,
//                        PA,
//                        PE,
//                        PG,
//                        PH,
//                        PK,
//                        PL,
//                        PS,
//                        PT,
//                        PW,
//                        PY,
//                        QA,
//                        RO,
//                        RS,
//                        RU,
//                        RW,
//                        SA,
//                        SB,
//                        SC,
//                        SE,
//                        SG,
//                        SI,
//                        SK,
//                        SL,
//                        SM,
//                        SN,
//                        SR,
//                        ST,
//                        SV,
//                        SZ,
//                        TD,
//                        TG,
//                        TH,
//                        TJ,
//                        TL,
//                        TN,
//                        TO,
//                        TR,
//                        TT,
//                        TV,
//                        TW,
//                        TZ,
//                        UA,
//                        UG,
//                        US,
//                        UY,
//                        UZ,
//                        VC,
//                        VE,
//                        VN,
//                        VU,
//                        WS,
//                        XK,
//                        ZA,
//                        ZM,
//                        ZW
//                    );
//                    "external_urls" =                     {
//                        spotify = "https://open.spotify.com/album/5d1olW0ik7vDNLDcKuRV4P";
//                    };
//                    href = "https://api.spotify.com/v1/albums/5d1olW0ik7vDNLDcKuRV4P";
//                    id = 5d1olW0ik7vDNLDcKuRV4P;
//                    images =                     (
//                                                {
//                            height = 640;
//                            url = "https://i.scdn.co/image/ab67616d0000b273a67c8a972344f63ba93ebf95";
//                            width = 640;
//                        },
//                                                {
//                            height = 300;
//                            url = "https://i.scdn.co/image/ab67616d00001e02a67c8a972344f63ba93ebf95";
//                            width = 300;
//                        },
//                                                {
//                            height = 64;
//                            url = "https://i.scdn.co/image/ab67616d00004851a67c8a972344f63ba93ebf95";
//                            width = 64;
//                        }
//                    );
//                    name = Connection;
//                    "release_date" = "2016-12-16";
//                    "release_date_precision" = day;
//                    "total_tracks" = 11;
//                    type = album;
//                    uri = "spotify:album:5d1olW0ik7vDNLDcKuRV4P";
//                };
//                artists =                 (
//                                        {
//                        "external_urls" =                         {
//                            spotify = "https://open.spotify.com/artist/7t7KCNFOwuMChaQg6L8I69";
//                        };
//                        href = "https://api.spotify.com/v1/artists/7t7KCNFOwuMChaQg6L8I69";
//                        id = 7t7KCNFOwuMChaQg6L8I69;
//                        name = "Jacob Latimore";
//                        type = artist;
//                        uri = "spotify:artist:7t7KCNFOwuMChaQg6L8I69";
//                    }
//                );
//                "available_markets" =                 (
//                    AD,
//                    AE,
//                    AG,
//                    AL,
//                    AM,
//                    AO,
//                    AR,
//                    AT,
//                    AU,
//                    AZ,
//                    BA,
//                    BB,
//                    BD,
//                    BE,
//                    BF,
//                    BG,
//                    BH,
//                    BI,
//                    BJ,
//                    BN,
//                    BO,
//                    BR,
//                    BS,
//                    BT,
//                    BW,
//                    BY,
//                    BZ,
//                    CA,
//                    CD,
//                    CG,
//                    CH,
//                    CI,
//                    CL,
//                    CM,
//                    CO,
//                    CR,
//                    CV,
//                    CW,
//                    CY,
//                    CZ,
//                    DE,
//                    DJ,
//                    DK,
//                    DM,
//                    DO,
//                    DZ,
//                    EC,
//                    EE,
//                    EG,
//                    ES,
//                    FI,
//                    FJ,
//                    FM,
//                    FR,
//                    GA,
//                    GB,
//                    GD,
//                    GE,
//                    GH,
//                    GM,
//                    GN,
//                    GQ,
//                    GR,
//                    GT,
//                    GW,
//                    GY,
//                    HK,
//                    HN,
//                    HR,
//                    HT,
//                    HU,
//                    ID,
//                    IE,
//                    IL,
//                    IN,
//                    IQ,
//                    IS,
//                    IT,
//                    JM,
//                    JO,
//                    JP,
//                    KE,
//                    KG,
//                    KH,
//                    KI,
//                    KM,
//                    KN,
//                    KR,
//                    KW,
//                    KZ,
//                    LA,
//                    LB,
//                    LC,
//                    LI,
//                    LK,
//                    LR,
//                    LS,
//                    LT,
//                    LU,
//                    LV,
//                    LY,
//                    MA,
//                    MC,
//                    MD,
//                    ME,
//                    MG,
//                    MH,
//                    MK,
//                    ML,
//                    MN,
//                    MO,
//                    MR,
//                    MT,
//                    MU,
//                    MV,
//                    MW,
//                    MX,
//                    MY,
//                    MZ,
//                    NA,
//                    NE,
//                    NG,
//                    NI,
//                    NL,
//                    NO,
//                    NP,
//                    NR,
//                    NZ,
//                    OM,
//                    PA,
//                    PE,
//                    PG,
//                    PH,
//                    PK,
//                    PL,
//                    PS,
//                    PT,
//                    PW,
//                    PY,
//                    QA,
//                    RO,
//                    RS,
//                    RU,
//                    RW,
//                    SA,
//                    SB,
//                    SC,
//                    SE,
//                    SG,
//                    SI,
//                    SK,
//                    SL,
//                    SM,
//                    SN,
//                    SR,
//                    ST,
//                    SV,
//                    SZ,
//                    TD,
//                    TG,
//                    TH,
//                    TJ,
//                    TL,
//                    TN,
//                    TO,
//                    TR,
//                    TT,
//                    TV,
//                    TW,
//                    TZ,
//                    UA,
//                    UG,
//                    US,
//                    UY,
//                    UZ,
//                    VC,
//                    VE,
//                    VN,
//                    VU,
//                    WS,
//                    XK,
//                    ZA,
//                    ZM,
//                    ZW
//                );
//                "disc_number" = 1;
//                "duration_ms" = 176151;
//                explicit = 0;
//                "external_ids" =                 {
//                    isrc = USUYG1117827;
//                };
//                "external_urls" =                 {
//                    spotify = "https://open.spotify.com/track/4dLOsDCJtv1HLaMj572BLB";
//                };
//                href = "https://api.spotify.com/v1/tracks/4dLOsDCJtv1HLaMj572BLB";
//                id = 4dLOsDCJtv1HLaMj572BLB;
//                "is_local" = 0;
//                name = "Remember Me";
//                popularity = 31;
//                "preview_url" = "https://p.scdn.co/mp3-preview/4dee07b008bbe5d6ceee2dd60cac50d9ee6562dc?cid=221b702aebea423e8c603f87f0959eed";
//                "track_number" = 9;
//                type = track;
//                uri = "spotify:track:4dLOsDCJtv1HLaMj572BLB";
//            };
//        }
//    );
//    limit = 2;
//    next = "https://api.spotify.com/v1/me/player/recently-played?before=1642593586479&limit=2";
//}
