From: "Shevchenko, Andriy" <andriy.shevchenko@intel.com>
Subject: Re: [PATCH v2 10/11] tty: serial: 8250: Replace printk by pr_*
Date: Fri, 18 Dec 2015 12:42:08 +0000
Message-ID: <1450442546.30729.217.camel@intel.com>
References: <1450437723-2978-1-git-send-email-anton.wuerfel@fau.de>
	 <1450437723-2978-11-git-send-email-anton.wuerfel@fau.de>
	 <1450441926.30729.208.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1450441926.30729.208.camel@linux.intel.com>
Content-Language: en-US
Content-ID: <D5138F88F01CC442A0FE8033D57E7980@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "anton.wuerfel@fau.de" <anton.wuerfel@fau.de>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "mail@maciej.szmigiero.name" <mail@maciej.szmigiero.name>, "desmondl@broadcom.com" <desmondl@broadcom.com>, "Zha, Qipeng" <qipeng.zha@intel.com>, "heikki.krogerus@linux.intel.com" <heikki.krogerus@linux.intel.com>, "long.wanglong@huawei.com" <long.wanglong@huawei.com>, "soeren.grunewald@desy.de" <soeren.grunewald@desy.de>, "deller@gmx.de" <deller@gmx.de>, "jslaby@suse.com" <jslaby@suse.com>, "phillip.raffeck@fau.de" <phillip.raffeck@fau.de>, "paul.burton@imgtec.com" <paul.burton@imgtec.com>, "hpeter@gmail.com" <hpeter@gmail.com>, "ralf@linux-mips.org" <ralf@linux-mips.org>, "linux-kernel@i4.cs.fau.de" <linux-kernel@i4.cs.fau.de>, "mans@mansr.com" <mans@mansr.com>, "adam.lee@canonical.com" <adam.lee@canonical.com>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "jejb@parisc-linux.org" <jejb@par>
List-Id: linux-serial@vger.kernel.org

T24gRnJpLCAyMDE1LTEyLTE4IGF0IDE0OjMyICswMjAwLCBBbmR5IFNoZXZjaGVua28gd3JvdGU6
DQo+IE9uIEZyaSwgMjAxNS0xMi0xOCBhdCAxMjoyMiArMDEwMCwgQW50b24gV3VlcmZlbCB3cm90
ZToNCj4gDQo+IA0KPiA+IMKgVGhpcyBjb21lcyB3aXRoIGEgc2xpZ2h0IGNoYW5nZSBpbiBiZWhh
dmlvdXIgYXMNCj4gPiBwcl9kZWJ1ZyBpcyBjb25maWd1cmFibGUgdmlhIENPTkZJR19EWU5BTUlD
X0RFQlVHLCB3aGVyZWFzDQo+ID4gcHJpbnRrKEtFUk5fREVCVUcgLi4uKSBpcyBub3QuDQo+IA0K
PiAtLS0gYS9kcml2ZXJzL3R0eS9zZXJpYWwvODI1MC84MjUwX3BucC5jDQo+ID4gKysrIGIvZHJp
dmVycy90dHkvc2VyaWFsLzgyNTAvODI1MF9wbnAuYw0KPiA+IEBAIC00NjUsOSArNDY1LDkgQEAg
c2VyaWFsX3BucF9wcm9iZShzdHJ1Y3QgcG5wX2RldiAqZGV2LCBjb25zdA0KPiA+IHN0cnVjdCBw
bnBfZGV2aWNlX2lkICpkZXZfaWQpDQoNCk9uZSBtb3JlIHRoaW5nIGp1c3Qgbm90aWNlZCB0aGF0
IGlzIC0+cHJvYmUoKSBmdW5jdGlvbiB3aGVyZSB5b3UgaGF2ZQ0Kc3RydWN0IGRldmljZSBkZWZp
bmVkLCBpdCBtaWdodCBiZSB3b3J0aCB0byBjaGFuZ2UgdG8gZGV2XyogbWFjcm9zDQppbnN0ZWFk
IG9mIHByXyBhdCB0aGUgc2FtZSB0aW1lIGZvciBzb21lIGZ1bmN0aW9ucy4NCg0KU28sIGhlcmUg
aXQgd291bGQgYmUgZGV2X2RiZygmZGV2LT5kZXYsIOKApikgSSBzdXBwb3NlLg0KDQoNCi0tIA0K
QW5keSBTaGV2Y2hlbmtvIDxhbmRyaXkuc2hldmNoZW5rb0BpbnRlbC5jb20+DQpJbnRlbCBGaW5s
YW5kIE95DQotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0KSW50ZWwgRmlubGFuZCBPeQpSZWdpc3RlcmVkIEFkZHJlc3M6
IFBMIDI4MSwgMDAxODEgSGVsc2lua2kgCkJ1c2luZXNzIElkZW50aXR5IENvZGU6IDAzNTc2MDYg
LSA0IApEb21pY2lsZWQgaW4gSGVsc2lua2kgCgpUaGlzIGUtbWFpbCBhbmQgYW55IGF0dGFjaG1l
bnRzIG1heSBjb250YWluIGNvbmZpZGVudGlhbCBtYXRlcmlhbCBmb3IKdGhlIHNvbGUgdXNlIG9m
IHRoZSBpbnRlbmRlZCByZWNpcGllbnQocykuIEFueSByZXZpZXcgb3IgZGlzdHJpYnV0aW9uCmJ5
IG90aGVycyBpcyBzdHJpY3RseSBwcm9oaWJpdGVkLiBJZiB5b3UgYXJlIG5vdCB0aGUgaW50ZW5k
ZWQKcmVjaXBpZW50LCBwbGVhc2UgY29udGFjdCB0aGUgc2VuZGVyIGFuZCBkZWxldGUgYWxsIGNv
cGllcy4K
