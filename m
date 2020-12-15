Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10FC5C2BB9A
	for <linux-serial@archiver.kernel.org>; Tue, 15 Dec 2020 15:09:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD43722255
	for <linux-serial@archiver.kernel.org>; Tue, 15 Dec 2020 15:09:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730123AbgLOPHi (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 15 Dec 2020 10:07:38 -0500
Received: from smtp.asem.it ([151.1.184.197]:58421 "EHLO smtp.asem.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730120AbgLOPHa (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 15 Dec 2020 10:07:30 -0500
Received: from webmail.asem.it
        by asem.it (smtp.asem.it)
        (SecurityGateway 6.5.2)
        with ESMTP id SG000670825.MSG 
        for <linux-serial@vger.kernel.org>; Tue, 15 Dec 2020 16:06:23 +0100S
Received: from ASAS044.asem.intra (172.16.16.44) by ASAS044.asem.intra
 (172.16.16.44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 15
 Dec 2020 16:06:21 +0100
Received: from ASAS044.asem.intra ([::1]) by ASAS044.asem.intra ([::1]) with
 mapi id 15.01.1979.003; Tue, 15 Dec 2020 16:06:21 +0100
From:   Flavio Suligoi <f.suligoi@asem.it>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Jiri Slaby <jirislaby@kernel.org>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Ji-Ze Hong <hpeter@gmail.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: R: R: R: [PATCH v1] serial: 8250_fintek: Print Fintek chip name
Thread-Topic: R: R: [PATCH v1] serial: 8250_fintek: Print Fintek chip name
Thread-Index: AQHW0hsm4LBjpzgBaEuoNhCE3PXG1an2iQoAgAGZwAD///h9AIAAFBzA///7boCAABURgA==
Date:   Tue, 15 Dec 2020 15:06:21 +0000
Message-ID: <08c7185573314b5ba622e5a872defd33@asem.it>
References: <20201214131445.954822-1-f.suligoi@asem.it>
 <X9dr2IvOgPyhsalE@kroah.com> <ff8f6af85d27448d93d1220545f163be@asem.it>
 <X9i9RKAbpoR0F7Y+@kroah.com> <178bf34c76184d39b6b17d5e54133821@asem.it>
 <X9jKTZoX9Se+Ghn/@kroah.com>
In-Reply-To: <X9jKTZoX9Se+Ghn/@kroah.com>
Accept-Language: it-IT, en-US
Content-Language: it-IT
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.17.208]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SGHeloLookup-Result: pass smtp.helo=webmail.asem.it (ip=172.16.16.44)
X-SGSPF-Result: none (smtp.asem.it)
X-SGOP-RefID: str=0001.0A782F1B.5FD8D0EE.001C,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0 (_st=1 _vt=0 _iwf=0)
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

SGkgR3JlZywNCg0KPiA+ID4gRmludGVrIEY4MTIxNkFEDQo+ID4gPiA+IDAwOjAyOiB0dHlTMyBh
dCBJL08gMHgyZTggKGlycSA9IDExLCBiYXNlX2JhdWQgPSAxMTUyMDApIGlzIGEgMTY1NTBBDQo+
IC0NCj4gPiA+IEZpbnRlayBGODEyMTZBRA0KPiA+ID4gPg0KPiA+ID4gPiB3aGVyZSB0aGUgImV4
dHJhX25hbWUiLCBpZiBub3QgZW1wdHksIGlzIHByaW50ZWQNCj4gPiA+ID4gYXQgdGhlIGVuZCBv
ZiB0aGUgbGluZS4NCj4gPiA+ID4gRm9yIHByYWN0aWNhbCBzcGFjZSByZWFzb25zLCB0aGUgImV4
dHJhX25hbWUiIGxlbmd0aA0KPiA+ID4gPiBjYW4gYmUgbGltaXRlZCB0byAxNiBjaGFycy4NCj4g
PiA+DQo+ID4gPiBXaHk/ICBXaGF0IHRvb2wgd2lsbCB1c2UgdGhpcywgYW5kIHdoeSB3b3VsZCB1
c2Vyc3BhY2UgY2FyZSBhYm91dCBpdD8NCj4gPiA+DQo+ID4gPiBXaGF0IHByb2JsZW0gYXJlIHlv
dSB0cnlpbmcgdG8gc29sdmUgaGVyZT8NCj4gPg0KPiA+IEkgdHJ5IHRvIGV4cGxhaW4gbXkgcmVx
dWlyZW1lbnQ6DQo+ID4NCj4gPiB3ZSBwcm9kdWNlIHNvbWUgeDg2IGJvYXJkcyB3aXRoIG11bHRp
c3RhbmRhcmQgUlMyMzIvNDIyLzQ4NSBwb3J0cw0KPiA+IGFuZCwgdG8gaGF2ZSB0aGlzIGZlYXR1
cmUsIGluIHNvbWUgb2YgdGhlc2UgYm9hcmRzLCB3ZSB1c2UgYQ0KPiA+IEZpbnRlayB1YXJ0IG9y
IHN1cGVySU8uDQo+ID4gU28gdGhpcyBhZGRpdGlvbmFsIGluZm8gImV4dHJhX25hbWUiIGNhbiBi
ZSB1c2VmdWwgZm9yDQo+ID4gYSBxdWljayBjaGVjayBpZiB0aGUgc2VyaWFsIHBvcnRzIGFyZSBt
dWx0aXN0YW5kYXJkIG9yIG5vdCwNCj4gPiB3aXRob3V0IGFueSBvdGhlciBpbnZlc3RpZ2F0aW9u
cywgYnV0IHVzaW5nIG9ubHkgYSBzaW1wbGUgY29tbWFuZA0KPiA+IGxpa2U6DQo+ID4NCj4gPiBk
bWVzZ3wgZ3JlcCB0dHlTDQo+IA0KPiBCdXQgYXMgdGhleSB3b3JrIHRoZSBzYW1lLCB3aHkgZG9l
cyBpdCBtYXR0ZXI/DQoNClllcyB5b3UgYXJlIHJpZ2h0LCBieSB0aGUgdXNlciBwb2ludCBvZiB2
aWV3LCB0aGV5IGFyZSB0aGUgc2FtZS4NCg0KPiANCj4gVXNlcnNwYWNlIHNob3VsZCBub3QgY2Fy
ZSBoZXJlLiAgSXNuJ3QgdGhlcmUgc29tZSBvdGhlciBpZCB5b3UgY2FuDQo+IHJlYWQvcXVlcnkg
Zm9yIGEgaGFyZHdhcmUgZGF0YWJhc2UgdG9vbCB0byBkZXRlcm1pbmUgdGhpcz8NCg0KWWVzLCB0
aGVyZSBpcy4gSSBjYW4gYWRkIHRoaXMgaW5mbyBpbiB0aGUgQklPUywgaW4gU01CSU9TIHRhYmxl
DQp0eXBlIDggZm9yIGV4YW1wbGUsIG9yIEkgY2FuIHJlYWQgdGhlIGJvYXJkIG5hbWUgYW5kIHRo
ZW4NCnNlYXJjaCBpbiBhIGN1c3RvbSBkYXRhYmFzZSB0b29sIHdoYXQgcGVyaXBoZXJhbHMgYXJl
IHByZXNlbnQgaW4gdGhlIGJvYXJkLiANCg0KPiANCj4gUHJpbnRpbmcgYSByYW5kb20gc3RyaW5n
IHRvIHRoZSBrZXJuZWwgbG9nIGlzIG5vdCBhIGdvb2Qgd2F5IHRvIGRvDQo+IGhhcmR3YXJlIGRl
c2NyaXB0aW9ucyBpbiBhIGZvcm1hdCB0aGF0IGV2ZXJ5b25lIGNhbiBlYXNpbHkgcGFyc2UgdGhl
bSA6KQ0KDQpPaywgcmlnaHQhIFRoYW5rcyB2ZXJ5IG11Y2ggZm9yIHlvdXIgdGltZSBHcmVnISDw
n5iKDQoNCj4gdGhhbmtzLA0KPiANCj4gZ3JlZyBrLWgNCg0KQmVzdCByZWdhcmRzLA0KRmxhdmlv
DQo=
