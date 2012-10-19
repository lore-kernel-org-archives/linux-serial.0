From: "Liu, Chuansheng" <chuansheng.liu@intel.com>
Subject: RE: [PATCH] serial: ifx6x60: del_timer_sync must not be called in
 interrupt context.
Date: Fri, 19 Oct 2012 06:47:59 +0000
Message-ID: <27240C0AC20F114CBF8149A2696CBE4A1A4EFB@SHSMSX101.ccr.corp.intel.com>
References: <1350654690.4332.12.camel@chenjun-workstation>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:17990 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752267Ab2JSGsT (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 19 Oct 2012 02:48:19 -0400
In-Reply-To: <1350654690.4332.12.camel@chenjun-workstation>
Content-Language: en-US
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: "Chen, Jun D" <jun.d.chen@intel.com>, "alan@linux.intel.com" <alan@linux.intel.com>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "Gorby, Russ" <russ.gorby@intel.com>, "Bi, Chao" <chao.bi@intel.com>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQ2hlbiwgSnVuIEQNCj4g
U2VudDogRnJpZGF5LCBPY3RvYmVyIDE5LCAyMDEyIDk6NTIgUE0NCj4gVG86IGFsYW5AbGludXgu
aW50ZWwuY29tDQo+IENjOiBsaW51eC1zZXJpYWxAdmdlci5rZXJuZWwub3JnOyBHb3JieSwgUnVz
czsgTGl1LCBDaHVhbnNoZW5nOyBCaSwgQ2hhbw0KPiBTdWJqZWN0OiBbUEFUQ0hdIHNlcmlhbDog
aWZ4Nng2MDogZGVsX3RpbWVyX3N5bmMgbXVzdCBub3QgYmUgY2FsbGVkIGluIGludGVycnVwdA0K
PiBjb250ZXh0Lg0KPiANCj4gDQo+IFRoaXMgcGF0Y2ggbWFrZSB1c2Ugb2YgZGVsX3RpbWVyIGlu
c3RlYWQgb2YgZGVsX3RpbWVyX3N5bmMgaW4gdGhlDQo+IGludGVycnVwdCBjb250ZXh0Lg0KPiBU
aGUgc3BpX3RpbWVyIGZ1bmN0aW9uIGRvbid0IHVzZSBhbnkgcmVzb3VyY2VzIHRoYXQgbWF5IHJl
bGVhc2UgYWZ0ZXINCj4gcnVubmluZyBkZWxfdGltZXIsDQo+IHNvIHVzaW5nIHRoZSBkZWxfdGlt
ZXIgaXMgYWxzbyBzYWZlIGFuZCBlbm91Z2ggaW4gdGhpcyBjb250ZXh0Lg0KPiANCj4gU2lnbmVk
LW9mZi1ieTogQ2hlbiBKdW4gPGp1bi5kLmNoZW5AaW50ZWwuY29tPg0KSXQgaGFzIGJlZW4gdGVz
dGVkIG9uIG91ciBtZWRmaWVsZCBwbGF0Zm9ybS4NCg==
