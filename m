From: MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: Re: Re: [PATCH] Serial: BUGFIX: uart_resume_port has an omitted
 condition.
Date: Fri, 15 Oct 2010 05:10:24 +0000 (GMT)
Message-ID: <15814028.20691287119419827.JavaMail.weblogic@epv6ml08>
Reply-To: myungjoo.ham@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset=euc-kr
Content-Transfer-Encoding: base64
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:48983 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753232Ab0JOFKZ (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 15 Oct 2010 01:10:25 -0400
Received: from epms1.samsung.com (mailout4.samsung.com [203.254.224.34])
 by mailout4.samsung.com
 (Sun Java(tm) System Messaging Server 7u3-15.01 64bit (built Feb 12 2010))
 with ESMTP id <0LAB00FLFFPC5010@mailout4.samsung.com> for
 linux-serial@vger.kernel.org; Fri, 15 Oct 2010 14:10:24 +0900 (KST)
Received: from epv6spt2 ("port 49022"@[203.254.225.172])
 by ms1.samsung.com (Sun Java(tm) System Messaging Server 7u3-15.01 64bit
 (built Feb 12 2010)) with ESMTP id <0LAB00HEYFP7C3I0@ms1.samsung.com> for
 linux-serial@vger.kernel.org; Fri, 15 Oct 2010 14:10:24 +0900 (KST)
MIME-version: 1.0
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Stanislav Brabec <sbrabec@suse.cz>, Greg KH <greg@kroah.com>
Cc: Greg KH <gregkh@suse.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, =?euc-kr?Q?=B9=DA=B0=E6=B9=CE?= <kyungmin.park@samsung.com>, Alan Cox <alan@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>, Andr Goddard Rosa <andre.goddard@gmail.com>, Jason Wang <jason77.wang@gmail.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>

PiBHcmVnIEtIIHdyb3RlOiANCj4gPiA+IFRoaXMgZGlzcGFyaXR5IGFwcGVhcmVkIGRlbGliZXJh
dGVseSBpbiA0NTQ3YmU3OC4gSWYgeW91IG5lZWQNCj4gPiA+IG5vX2NvbnNvbGVfc3VzcGVuZCBh
bmQgdGhlIGhhcmR3YXJlIGxldHMgdGhlIGRldmljZSBpbiBhbiB1bmRlZmluZWQNCj4gPiA+IHN0
YXRlIGFmdGVyIHJlc3VtZSAoaS4gZS4gUFhBMjcwKSwgeW91IG5lZWQgdG8gY2FsbCBzdWJzZXQg
b2YgdGhlDQo+ID4gPiByZXN1bWUsIGV2ZW4gaWYgdGhlIHN1c3BlbmQgY291bnRlcnBhcnQgd2Fz
IG5vdCBjYWxsZWQuIFllcywgSSBjYW4NCj4gPiA+IGltYWdpbmUgdGhhdCBpdCBtYXkgYmUgYSBz
b3VyY2Ugb2YgcHJvYmxlbXMuDQo+IA0KPiA+ID4gSXQgc2VlbXMgdGhhdCBzdXBwb3J0IGZvciBu
b19jb25zb2xlX3N1c3BlbmQgZm9yIGFsbCBkZXZpY2VzIGlzIGJlY29taW5nDQo+ID4gPiBtb3Jl
IGNvbXBsaWNhdGVkLiBJIGd1ZXNzIHRoYXQgYSBuZXcgZHJpdmVyIGNhbGxzIChtYXliZSAic2F2
ZV9zdGF0ZSINCj4gPiA+IGFuZCAicmVzdW1lX3N0YXRlIikgb3Igc3VwcG9ydCBmb3Igbm9fY29u
c29sZV9zdXNwZW5kIGRpcmVjdGx5IGluDQo+ID4gPiBkcml2ZXJzIG1heSBiZSB1c2VmdWwuDQo+
ID4gDQo+ID4gT2ssIHNvIEknbSBndWVzc2luZyB0aGF0IHRoaXMgcGF0Y2ggaXMgbm90IHRvIGJl
IGFwcGxpZWQgdGhlbiwgY29ycmVjdD8NCj4gDQo+IEkganVzdCBjb21wYXJlZCBpdCB3aXRoIEph
c29uIFdhbmcncyBwYXRjaGVzLiBNeXVuZ0pvbyBIYW0ncyBwYXRjaCBpcw0KPiBleGFjdGx5IGVx
dWFsIHRvIHRoZSBQQVRDSCAxLzIuIFNvIGl0IGFscmVhZHkgaGFzIG15IEFDSyBhbmQgaXQgaXMN
Cj4gcGVuZGluZyBhczoNCj4gDQo+IHNlcmlhbC1jb3JlOiBza2lwIGNhbGwgc2V0X3Rlcm1pb3Mv
Y29uc29sZV9zdGFydCB3aGVuIG5vX2NvbnNvbGVfc3VzcGVuZA0KPiANCj4gUmVsYXRlZCB0aHJl
YWQgY2FuIGJlIGZvdW5kIGluIGxpbnV4LXNlcmlhbCBhcmNoaXZlcyBmcm9tIEF1Z3VzdCAyMDEw
Og0KPiBbUEFUQ0ggUkVTRU5EIDAvMl0gdHdvIHNlcmlhbF9jb3JlIHN1c3BlbmQvcmVzdW1lIGZp
eGVzDQo+IA0KPiBUbyBNeXVuZ0pvbyBIYW06IENvdWxkIHlvdSB2ZXJpZnksIHRoYXQgSmFzb24g
V2FuZydzIHBhdGNoIDIvMiBkb2VzIG5vdA0KPiBicmVhayB5b3VyIHN5c3RlbT8gTXkgcGF0Y2gg
dG8gZml4IFBYQTI3MCBkb2VzIG5vdCBleGlzdCB5ZXQuIEknbGwgYXNrDQo+IHlvdSBpbiBmdXR1
cmUgZm9yIHRlc3RpbmcuDQoNCldpdGggSmFzb24gV2FuZydzIHBhdGNoLCBpdCB3b3JrcyBmaW5l
LiBJJ20gYXBwbHlpbmcgV2FuZydzIDEvMiBhbmQgMi8yIHRvIG1pbmUuDQoNClRoYW5rIHlvdS4N
Cg0KPiANCj4gLS0gDQo+IEJlc3QgUmVnYXJkcyAvIFMgcG96ZHJhdmVtLA0KPiANCj4gU3Rhbmlz
bGF2IEJyYWJlYw0KPiBzb2Z0d2FyZSBkZXZlbG9wZXINCj4gLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+IFNVU0Ug
TElOVVgsIHMuIHIuIG8uICAgICAgICAgICAgICAgICAgICAgICAgICBlLW1haWw6IHNicmFiZWNA
c3VzZS5jeg0KPiBMaWhvdmFyc2thIDEwNjAvMTIgICAgICAgICAgIHRlbDogKzQyMCAyODQgMDI4
IDk2NiwgKzQ5IDkxMSA3NDA1Mzg3NDcNCj4gMTkwIDAwIFByYWhhIDkgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgZmF4OiArNDIwIDI4NCAwMjggOTUxDQo+IEN6ZWNoIFJlcHVibGlj
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaHR0cDovL3d3dy5zdXNlLmN6Lw0K
PiANCg0KDQoNCg0KDQogTXl1bmdKb28gSGFtICjH1LjtwdYpDQpNb2JpbGUgU29mdHdhcmUgUGxh
dGZvcm0gTGFiLA0KRGlnaXRhbCBNZWRpYSBhbmQgQ29tbXVuaWNhdGlvbnMgKERNQykgQnVzaW5l
c3MNClNhbXN1bmcgRWxlY3Ryb25pY3MNCmNlbGw6ICs4Mi0xMC02NzE0LTI4NTggLyBvZmZpY2U6
ICs4Mi0zMS0yNzktODAzMw==


