From: Jingchang Lu <jingchang.lu@freescale.com>
Subject: RE: [PATCH 2/2] tty: serial: fsl_lpuart: add 32-bit register
 interface support
Date: Mon, 14 Jul 2014 10:16:12 +0000
Message-ID: <ea314532262d449aac50e4eb0a79f9f6@BL2PR03MB467.namprd03.prod.outlook.com>
References: <1405057302-26041-1-git-send-email-jingchang.lu@freescale.com>
 <1405057302-26041-3-git-send-email-jingchang.lu@freescale.com>
 <20140712005122.GA31974@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20140712005122.GA31974@kroah.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEdyZWcgS0ggW21haWx0bzpn
cmVna2hAbGludXhmb3VuZGF0aW9uLm9yZ10NCj5TZW50OiBTYXR1cmRheSwgSnVseSAxMiwgMjAx
NCA4OjUxIEFNDQo+VG86IEx1IEppbmdjaGFuZy1CMzUwODMNCj5DYzogbGludXgtc2VyaWFsQHZn
ZXIua2VybmVsLm9yZzsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnDQo+U3Vi
amVjdDogUmU6IFtQQVRDSCAyLzJdIHR0eTogc2VyaWFsOiBmc2xfbHB1YXJ0OiBhZGQgMzItYml0
IHJlZ2lzdGVyDQo+aW50ZXJmYWNlIHN1cHBvcnQNCj4NCj5PbiBGcmksIEp1bCAxMSwgMjAxNCBh
dCAwMTo0MTo0MlBNICswODAwLCBKaW5nY2hhbmcgTHUgd3JvdGU6DQo+PiBUaGlzIGFkZCB0aGUg
MzItYml0IHJlZ2lzdGVyIHZlcnNpb24gTFBVQVJUIHN1cHBvcnQgd2l0aCBiaWctZW5kaWFuDQo+
PiBieXRlIG9yZGVyLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IEppbmdjaGFuZyBMdSA8amluZ2No
YW5nLmx1QGZyZWVzY2FsZS5jb20+DQo+PiAtLS0NCj4+ICBkcml2ZXJzL3R0eS9zZXJpYWwvZnNs
X2xwdWFydC5jIHwgNjUzDQo+PiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KystDQo+PiAgMSBmaWxlIGNoYW5nZWQsIDY0MyBpbnNlcnRpb25zKCspLCAxMCBkZWxldGlvbnMo
LSkNCj4NCj5Zb3UgZGlkbid0IGV2ZW4gdGVzdCBidWlsZCB0aGlzIHBhdGNoOg0KPg0KPiAgQ0Mg
W01dICBkcml2ZXJzL3R0eS9zZXJpYWwvZnNsX2xwdWFydC5vDQo+ZHJpdmVycy90dHkvc2VyaWFs
L2ZzbF9scHVhcnQuYzogSW4gZnVuY3Rpb24g4oCYbHB1YXJ0X3N1c3BlbmTigJk6DQo+ZHJpdmVy
cy90dHkvc2VyaWFsL2ZzbF9scHVhcnQuYzoxODU2OjIyOiBlcnJvcjog4oCYbHB1YXJ0MzJfcmVn
4oCZIHVuZGVjbGFyZWQNCj4oZmlyc3QgdXNlIGluIHRoaXMgZnVuY3Rpb24pDQo+ICAgdWFydF9z
dXNwZW5kX3BvcnQoJmxwdWFydDMyX3JlZywgJnNwb3J0LT5wb3J0KTsNCj4gICAgICAgICAgICAg
ICAgICAgICAgXg0KPg0KPk5vIHF1aWNrZXIgd2F5IHRvIG1ha2UgbWUgZ3J1bXB5Li4uDQo+DQo+
UGxlYXNlIHRha2Ugc29tZSB0aW1lIHRvIGRvIHRoaXMgcmlnaHQuDQo+DQo+Z3JlZyBrLWgNCg0K
U29ycnkgZm9yIHRoZSBtaXN0YWtlLCBJIG9ubHkgdGVzdCB0aGUgZnVuY3Rpb25hbGl0eSB3aXRo
b3V0IG9wdGlvbiBvZiBDT05GSUdfUE1fU0xFRVAsDQpJIHdpbGwgZml4IHRoYXQgYW5kIHNlbmQg
dGhlIHBhdGNoIGFnYWluLiBUaGFua3MuDQoNCg0KDQpCZXN0IFJlZ2FyZHMsDQpKaW5nY2hhbmcN
Cg0KDQoNCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxp
bnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFk
ZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4
LWFybS1rZXJuZWwK
