From: "Shevchenko, Andriy" <andriy.shevchenko@intel.com>
Subject: Re: [PATCH v6] serial: 8250_uniphier: add UniPhier serial driver
Date: Tue, 26 May 2015 15:08:27 +0000
Message-ID: <1432652906.8736.44.camel@intel.com>
References: <1432525477-14051-1-git-send-email-yamada.masahiro@socionext.com>
	 <1432545245.8736.5.camel@intel.com>
	 <1432650518.13900.72.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1432650518.13900.72.camel@linux.intel.com>
Content-Language: en-US
Content-ID: <FB92BF499CCECA49AA97A00CE467B76D@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "alan@linux.intel.com" <alan@linux.intel.com>
Cc: "manabian@gmail.com" <manabian@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "blogic@openwrt.org" <blogic@openwrt.org>, "bigeasy@linutronix.de" <bigeasy@linutronix.de>, "alan@lxorguk.ukuu.org.uk" <alan@lxorguk.ukuu.org.uk>, "ricardo.ribalda@gmail.com" <ricardo.ribalda@gmail.com>, "yamada.masahiro@socionext.com" <yamada.masahiro@socionext.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "jslaby@suse.cz" <jslaby@suse.cz>, "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>, "peter@hurleysoftware.com" <peter@hurleysoftware.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

T24gVHVlLCAyMDE1LTA1LTI2IGF0IDE1OjI4ICswMTAwLCBBbGFuIENveCB3cm90ZToNCj4gPiA+
ICsNCj4gPiA+ICsjZGVmaW5lIFVOSVBISUVSX1VBUlRfQ0hBUl9GQ1IJMwkvKiBDaGFyYWN0ZXIg
LyBGSUZPIENvbnRyb2wgUmVnaXN0ZXIgKi8NCj4gPiA+ICsjZGVmaW5lIFVOSVBISUVSX1VBUlRf
TENSX01DUgk0CS8qIExpbmUvTW9kZW0gQ29udHJvbCBSZWdpc3RlciAqLw0KPiA+ID4gKyNkZWZp
bmUgICBVTklQSElFUl9VQVJUX0xDUl9TSElGVAk4DQo+ID4gDQo+ID4gSW5kZW50YXRpb24gcHJv
YmxlbSwgbmVlZHMgdG8gYmUgZml4ZWQuDQo+IA0KPiBJZiB5b3UgYXJlIGdvaW5nIHRvIHJldmll
dyBhIHBhdGNoIHNldCBhdCBsZWFzdCBsb29rIGF0IHRoZSBwcmV2aW91cw0KPiByZXZpZXdzIC0g
dGhlIGluZGVudGF0aW9uIHdhcyBhbHJlYWR5IGRpc2N1c3NlZCBhbmQgaXMgZG9uZSB0aGF0IHdh
eSB0bw0KPiBzaG93IChhcyBtYW55IGRyaXZlcnMgZG8pIHdoaWNoIGFyZSBmaWVsZHMgZm9yIHdo
aWNoIHJlZ2lzdGVycw0KDQpUaGlzIGlzIG5vdCBleGFjdGx5IHRoZSBmaWVsZCwgdGhlIHdheSBo
b3cgdG8gZ2V0IHRoZSBmaWVsZC4NCkluIHNvbWUgY2FzZXMgaXQgaXMgZXZlbiBiZXR0ZXIgdG8g
ZGVmaW5lIHNvbWV0aGluZyBsaWtlDQpfTENSKHgpICAoKHgpIDw8IDgpDQoNCg0KPiANCj4gPiA+
ICtzdGF0aWMgdW5zaWduZWQgaW50IHVuaXBoaWVyX3NlcmlhbF9pbihzdHJ1Y3QgdWFydF9wb3J0
ICpwLCBpbnQgb2Zmc2V0KQ0KPiA+ID4gK3sNCj4gPiA+ICsJaW50IHZhbHNoaWZ0ID0gMDsNCj4g
PiANCj4gPiBQZXJoYXBzIHVuc2lnbmVkIGludD8NCj4gDQo+IFdoeSA/IGV2ZW4gaWYgaXQgbWF0
dGVyZWQgZ2NjIGlzIGFscmVhZHkgcmVhbGlzaW5nIHRoYXQgdGhlIHZhbHVlIGNhbg0KPiBvbmx5
IGJlIDAgb3IgOCBhbmQgd2lsbCBiZSBnZW5lcmF0aW5nIHdoYXRldmVyIHdvcmtzIGJlc3QgZm9y
IHRoYXQuDQoNCkl0J3Mgbm90IGFib3V0IGhvdyBnY2MgZG9lcywgaXQncyBhYm91dCB3aGF0IGFz
c3VtcHRpb25zIGNhbiBiZSBtYWRlDQpmcm9tIHRoZSByZWFkaW5nIG9mIHRoZSBzb3VyY2UgY29k
ZS4gSSB0aGluayBpZiB3ZSBkbyBhIGNvdW50ZXIgb2Ygc2hpZnQNCnZhbHVlIGl0IHdvdWxkIGJl
IG5pY2UgdG8gc2V0IGFuIHVuc2lnbmVkIHR5cGUgZXhwbGljaXRseS4NCg0KLS0gDQpBbmR5IFNo
ZXZjaGVua28gPGFuZHJpeS5zaGV2Y2hlbmtvQGludGVsLmNvbT4NCkludGVsIEZpbmxhbmQgT3kN
Ci0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLQpJbnRlbCBGaW5sYW5kIE95ClJlZ2lzdGVyZWQgQWRkcmVzczogUEwgMjgx
LCAwMDE4MSBIZWxzaW5raSAKQnVzaW5lc3MgSWRlbnRpdHkgQ29kZTogMDM1NzYwNiAtIDQgCkRv
bWljaWxlZCBpbiBIZWxzaW5raSAKClRoaXMgZS1tYWlsIGFuZCBhbnkgYXR0YWNobWVudHMgbWF5
IGNvbnRhaW4gY29uZmlkZW50aWFsIG1hdGVyaWFsIGZvcgp0aGUgc29sZSB1c2Ugb2YgdGhlIGlu
dGVuZGVkIHJlY2lwaWVudChzKS4gQW55IHJldmlldyBvciBkaXN0cmlidXRpb24KYnkgb3RoZXJz
IGlzIHN0cmljdGx5IHByb2hpYml0ZWQuIElmIHlvdSBhcmUgbm90IHRoZSBpbnRlbmRlZApyZWNp
cGllbnQsIHBsZWFzZSBjb250YWN0IHRoZSBzZW5kZXIgYW5kIGRlbGV0ZSBhbGwgY29waWVzLgo=
