From: "A.S. Dong" <aisheng.dong@nxp.com>
Subject: RE: [PATCH 6/6] tty: serial: lpuart: add a more accurate baud rate
 calculation method
Date: Mon, 12 Jun 2017 14:23:10 +0000
Message-ID: <AM3PR04MB30630CDA4E0FD2B5079072E80CD0@AM3PR04MB306.eurprd04.prod.outlook.com>
References: <1494316248-24052-1-git-send-email-aisheng.dong@nxp.com>
 <1494316248-24052-7-git-send-email-aisheng.dong@nxp.com>
 <CAHp75Vemc5qoD7gbc_sJBSasYTFYSYOuWZv4N-4X60arWX8aJg@mail.gmail.com>
 <AM3PR04MB3062F7BCE82860C377C214E80F10@AM3PR04MB306.eurprd04.prod.outlook.com>
 <CAHp75VcH0j3ddaZ3iStNO4QcAwJKZ7BAMwUTthum2no1ucs2ww@mail.gmail.com>
 <AM3PR04MB306214514B820D66535E28B80CE0@AM3PR04MB306.eurprd04.prod.outlook.com>
 <CAHp75VcSToSfbUZ2TP0OsLRjV4TNpq7D_=4tnB_+rDvS2jp22Q@mail.gmail.com>
 <AM3PR04MB30678CBD87777C6816DEFA580CE0@AM3PR04MB306.eurprd04.prod.outlook.com>
 <CAHp75VdgLoavZrf+T1-cyPj2A30mGeyDEgye3qZoWXJE6inE_Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHp75VdgLoavZrf+T1-cyPj2A30mGeyDEgye3qZoWXJE6inE_Q@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Andy Duan <fugang.duan@nxp.com>, Stefan Agner <stefan@agner.ch>, Mingkai Hu <mingkai.hu@nxp.com>, "Y.B. Lu" <yangbo.lu@nxp.com>, Dong Aisheng <dongas86@gmail.com>
List-Id: linux-serial@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBbmR5IFNoZXZjaGVua28gW21h
aWx0bzphbmR5LnNoZXZjaGVua29AZ21haWwuY29tXQ0KPiBTZW50OiBGcmlkYXksIEp1bmUgMDks
IDIwMTcgMTE6NDkgUE0NCj4gVG86IEEuUy4gRG9uZw0KPiBDYzogbGludXgtc2VyaWFsQHZnZXIu
a2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgtYXJtDQo+IE1h
aWxpbmcgTGlzdDsgR3JlZyBLcm9haC1IYXJ0bWFuOyBKaXJpIFNsYWJ5OyBBbmR5IER1YW47IFN0
ZWZhbiBBZ25lcjsNCj4gTWluZ2thaSBIdTsgWS5CLiBMdTsgRG9uZyBBaXNoZW5nDQo+IFN1Ympl
Y3Q6IFJlOiBbUEFUQ0ggNi82XSB0dHk6IHNlcmlhbDogbHB1YXJ0OiBhZGQgYSBtb3JlIGFjY3Vy
YXRlIGJhdWQNCj4gcmF0ZSBjYWxjdWxhdGlvbiBtZXRob2QNCj4gDQo+IE9uIEZyaSwgSnVuIDks
IDIwMTcgYXQgNToyMCBQTSwgQS5TLiBEb25nIDxhaXNoZW5nLmRvbmdAbnhwLmNvbT4gd3JvdGU6
DQo+ID4+ID4gSG93IGFib3V0IHlvdSBzZW5kIGEgc2VwYXJhdGUgYmF1ZCBhbGdvcml0aG0gaW1w
cm92ZW1lbnQgcGF0Y2ggbGF0ZXI/DQo+ID4+DQo+ID4+IFdoeSBub3QgdG8gZG8gaXQgcmlnaHQg
YSB3YXk/DQo+ID4+DQo+ID4NCj4gPiBCZWNhdXNlIEkgdGhvdWdodCB0aGF0IGNvdWxkIGJlIGEg
c2VwYXJhdGUgcGF0Y2ggd2hpY2ggaXMgZG9pbmcNCj4gPiBhbGdvcml0aG0gaW1wcm92ZW1lbnQs
IHRoZW4gd2UgY2FuIGhhdmUgdGhlIGZ1bGwgaGlzdG9yeSBhbmQgYSBjbGVhcg0KPiBjb21wYXJp
c29uLg0KPiA+DQo+ID4gQW5kIGFsc28gd2UgYXJlIHN0aWxsIG5vdCBzdXJlIHdoZXRoZXIgaXQg
d29ya3MsIHdlIGRvbid0IHdhbnQgdG8NCj4gPiBibG9jayBvbiBpdCB0b28gbG9uZy4NCj4gPg0K
PiA+IEJ1dCBpZiB5b3UncmUgcHJldHR5IHN1cmUgYWJvdXQgaXQsIEkgd291bGQgd2FpdCBmb3Ig
c29tZSBtb3JlIHRpbWUuDQo+ID4NCj4gPiBIb3dldmVyLCBwZXJzb25hbGx5IEkgd291bGQgc3Rp
bGwgcmF0aGVyIGtlZXAgdGhlbSBpbiB0d28gc2VwYXJhdGUNCj4gPiBQYXRjaGVzIGZvciBjbGVh
cmVyIGhpc3RvcnkgYW5kIGNvbXBhcmlzb24uDQo+IA0KPiBTaW5jZSB3ZSBhbHJlYWR5IG5lYXIg
dG8gLXJjNSwgSSB3b3VsZCByYXRoZXIgYWdyZWUgd2l0aCB5b3UuDQo+IFNvLCBwbGVhc2UgcHJv
Y2VlZCB3aXRoIHlvdXIgYXBwcm9hY2ggYW5kIHdlIGNhbiBtb2RpZnkgaXQgaW4gcmVsYXhpbmcN
Cj4gbW9kZSBsYXRlciBvbi4NCj4gDQo+IFRoYW5rcywgYW5kIHNvcnJ5IGZvciB0aGUgZGVsYXkh
DQoNCk5ldmVyIG1pbmQuDQpBIHByb2Zlc3Npb25hbCByZXZpZXcgaXMgYWx3YXlzIHJlc3BlY3Rh
YmxlIGFuZCBhcHByZWNpYXRlZC4NCg0KVGhhbmtzDQoNClJlZ2FyZHMNCkRvbmcgQWlzaGVuZw0K
