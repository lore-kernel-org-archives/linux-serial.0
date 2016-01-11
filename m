From: "Wang, Annie" <Annie.Wang@amd.com>
Subject: RE: [PATCH 1/6] 8250/Kconfig: add config option
 CONFIG_SERIAL_8250_AMD
Date: Mon, 11 Jan 2016 07:26:39 +0000
Message-ID: <BLUPR12MB043368006316A2FB11A0DE8B81C90@BLUPR12MB0433.namprd12.prod.outlook.com>
References: <1451885501-2710-1-git-send-email-annie.wang@amd.com>
 <1451885501-2710-2-git-send-email-annie.wang@amd.com>
 <20160104144118.GJ22941@pd.tnic>
 <BLUPR12MB0433ABAC5C5D27D3FD0F4BF381F40@BLUPR12MB0433.namprd12.prod.outlook.com>
 <20160106104602.GA19507@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20160106104602.GA19507@pd.tnic>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
To: Russell King <linux@arm.linux.org.uk>, Borislav Petkov <bp@alien8.de>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, Vinod Koul <vinod.koul@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Huang, Ray" <Ray.Huang@amd.com>, "Wan, Vincent" <Vincent.Wan@amd.com>, "Xue, Ken" <Ken.Xue@amd.com>, Robin Murphy <robin.murphy@arm.com>, Graeme Gregory <gg@slimlogic.co.uk>, "Li, Tony" <Tony.Li@amd.com>, "Yu, Xiangliang" <Xiangliang.Yu@amd.com>
List-Id: linux-serial@vger.kernel.org

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEJvcmlzbGF2IFBldGtvdiBb
bWFpbHRvOmJwQGFsaWVuOC5kZV0NCj5TZW50OiBXZWRuZXNkYXksIEphbnVhcnkgMDYsIDIwMTYg
Njo0NiBQTQ0KPlRvOiBXYW5nLCBBbm5pZQ0KPkNjOiBBbmR5IFNoZXZjaGVua287IFZpbm9kIEtv
dWw7IE1pa2EgV2VzdGVyYmVyZzsgR3JlZyBLcm9haC1IYXJ0bWFuOyBSYWZhZWwNCj5KLiBXeXNv
Y2tpOyBsaW51eC1hY3BpQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVs
Lm9yZzsgbGludXgtDQo+c2VyaWFsQHZnZXIua2VybmVsLm9yZzsgZG1hZW5naW5lQHZnZXIua2Vy
bmVsLm9yZzsgSHVhbmcsIFJheTsgV2FuLCBWaW5jZW50Ow0KPlh1ZSwgS2VuOyBSb2JpbiBNdXJw
aHk7IEdyYWVtZSBHcmVnb3J5OyBMaSwgVG9ueTsgWXUsIFhpYW5nbGlhbmcNCj5TdWJqZWN0OiBS
ZTogW1BBVENIIDEvNl0gODI1MC9LY29uZmlnOiBhZGQgY29uZmlnIG9wdGlvbg0KPkNPTkZJR19T
RVJJQUxfODI1MF9BTUQNCj4NCj5PbiBXZWQsIEphbiAwNiwgMjAxNiBhdCAwMjowODoxOEFNICsw
MDAwLCBXYW5nLCBBbm5pZSB3cm90ZToNCj4+IEhvdyBhYm91dCBJIGFkZCBzZWxlY3QgQVJNX0FN
QkEgYW5kIFNFUklBTF84MjUwIGluIGFyY2gveDg2L0tjb25maWc/DQo+DQo+WWVhaCwgc2VsZWN0
IHNvdW5kcyBnb29kIGluIHRoYXQgY2FzZSwgZXhjZXB0IGluIHRoYXQgcGFydGljdWxhciBjYXNl
IC4uLg0KPg0KPj4NCj4+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9LY29uZmlnIGIvYXJjaC94ODYv
S2NvbmZpZyBpbmRleA0KPj4gZGIzNjIyZi4uMGZlNjY1NyAxMDA2NDQNCj4+IC0tLSBhL2FyY2gv
eDg2L0tjb25maWcNCj4+ICsrKyBiL2FyY2gveDg2L0tjb25maWcNCj4+IEBAIC01MzcsMTEgKzUz
NywxNSBAQCBjb25maWcgWDg2X0FNRF9QTEFURk9STV9ERVZJQ0UNCj4+ICAgICAgICAgZGVwZW5k
cyBvbiBBQ1BJDQo+PiAgICAgICAgIHNlbGVjdCBDT01NT05fQ0xLDQo+PiAgICAgICAgIHNlbGVj
dCBQSU5DVFJMDQo+PiArICAgICAgIHNlbGVjdCBTRVJJQUxfODI1MA0KPj4gKyAgICAgICBzZWxl
Y3QgQVJNX0FNQkENCj4NCj4uLi4gdGhhdCdzIGEgWDg2X0FNRF9QTEFURk9STV9ERVZJQ0Ugd2hp
Y2ggc2VsZWN0cyBBUk0gdGhpbmc/IGkuZS4sDQo+QVJNX0FNQkEuIENhbiB0aGF0IGV2ZW4gd29y
az8NCj4NCj5bIFJhbnQgb24gdGhlIHNpZGU6IEFuZCB0aGF0IEFSTV9BTUJBIHRoaW5nIGhhcywg
b2YgY291cnNlLCBubyBlZmZpbmcNCj4gIGhlbHAgdGV4dC4gRGFtbWl0LCBwZW9wbGUgbmVlZCB0
byBzdGFydCBleHBsYWluaW5nIHRob3NlIGNyeXB0aWMNCj4gIGFiYnJldmlhdGlvbnMuIFNvbWV3
aGVyZSBpbiB0aGUgY29kZSBJIGZvdW5kICJBZHZhbmNlZCBNaWNyb2NvbnRyb2xsZXINCj4gIEJ1
cyBBcmNoaXRlY3R1cmUiLiBUaGlzIGlzIGNsZWFybHkgc3Vib3B0aW1hbC4gXQ0KPg0KPlNvIHdo
eSBkb2VzIHRoZSBYODYgcGxhdGZvcm0gZGV2aWNlIG5lZWQgdG8gc2VsZWN0IHRoZSBBTUJBIGNy
YXA/DQoNCg0KUnVzc2VsbCwgDQoNClRoZSBBTUJBIGJ1cyBpcyBhbHJlYWR5IGxldmVyYWdlZCAg
aW4gQU1EIFg4NiBhcmNoIGhhcmR3YXJlIGRlc2lnbiBmb3IgVUFSVA0KY29udHJvbGxlciBhbmQg
VUFSVCBETUEuIEFuZCBtYXkgd2lsbCBiZSB1c2VkIGluIG90aGVyIGFyY2ggYXMgd2VsbCwgaG93
ZXZlciwNCml0IGlzIHJhdGhlciBjb25mdXNpbmcgaWYgd2Ugc2VsZWN0IEFSTV9BTUJBIGluIG90
aGVyIGFyY2gsIHN1Y2ggYXMgWDg2Lg0KDQpIb3cgYWJvdXQgcmVuYW1lICBDT05GSUdfQVJNX0FN
QkEgdG8gQ09ORklHX0FNQkE/IFNvIGRpZmZlcmVudCBhcmNoDQpjYW4gc2VsZWN0IGl0IHdpdGhv
dXQgY2F1c2luZyBtaXN1bmRlcnN0YW5kaW5nLiANCg0KVGhhbmsgeW91IHZlcnkgbXVjaC4NClJl
Z2FyZHMsDQpIb25nY2hlbmcoQW5uaWUpDQo=
