From: Yao Yuan <yao.yuan@freescale.com>
Subject: RE: [PATCH v3 2/2] serial: fsl_lpuart: add DMA support
Date: Thu, 16 Jan 2014 06:54:24 +0000
Message-ID: <b55917fd1b664ebeaeb135330ff806bd@DM2PR03MB349.namprd03.prod.outlook.com>
References: <1389763265-27300-2-git-send-email-yao.yuan@freescale.com>
 <1389763265-27300-3-git-send-email-yao.yuan@freescale.com>
 <20140115110537.GA25824@e106331-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-bl2lp0203.outbound.protection.outlook.com ([207.46.163.203]:40922
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750960AbaAPGyj (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 16 Jan 2014 01:54:39 -0500
In-Reply-To: <20140115110537.GA25824@e106331-lin.cambridge.arm.com>
Content-Language: en-US
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "shawn.guo@linaro.org" <shawn.guo@linaro.org>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "arnd@arndb.de" <arnd@arndb.de>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>

SGksIG1hcmsNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+ICsjaWZkZWYgQ09O
RklHX1NFUklBTF9GU0xfTFBVQVJUX0RNQQ0KPiA+ICsgICAgICAgc3RydWN0IHBsYXRmb3JtX2Rl
dmljZSAqcGRldiA9IHRvX3BsYXRmb3JtX2RldmljZShwb3J0LT5kZXYpOw0KPiA+ICsgICAgICAg
c3RydWN0IGRldmljZV9ub2RlICpucCA9IHBkZXYtPmRldi5vZl9ub2RlOw0KPiA+ICsNCj4gPiAr
ICAgICAgIGlmIChvZl9nZXRfcHJvcGVydHkobnAsICJkbWFzIiwgTlVMTCkpIHsNCj4gPiArICAg
ICAgICAgICAgICAgc3BvcnQtPmxwdWFydF9kbWFfdXNlID0gdHJ1ZTsNCj4gPiArICAgICAgICAg
ICAgICAgbHB1YXJ0X2RtYV90eF9yZXF1ZXN0KHBvcnQpOw0KPiA+ICsgICAgICAgICAgICAgICBs
cHVhcnRfZG1hX3J4X3JlcXVlc3QocG9ydCk7DQo+ID4gKyAgICAgICAgICAgICAgIHRlbXAgPSBy
ZWFkYihwb3J0LT5tZW1iYXNlICsgVUFSVENSNSk7DQo+ID4gKyAgICAgICAgICAgICAgIHdyaXRl
Yih0ZW1wIHwgVUFSVENSNV9URE1BUywgcG9ydC0+bWVtYmFzZSArIFVBUlRDUjUpOw0KPiANCj4g
UmF0aGVyIHRoYW4gcmVhZGluZyB0aGUgcmF3IGR0IHRvIGZpbmQgb3V0IGlmIHlvdSBoYXZlIGRt
YXMsIGNhbiB5b3Ugbm90DQo+IGp1c3QgYXR0ZW1wdCB0byByZXF1ZXN0IHRoZSBkbWFzIGFuZCBp
ZiBlaXRoZXIgZmFpbCBnaXZlIHVwIG9uIHVzaW5nIHRoZW0/DQoNClllcywgdGhlIGRtYSByZXF1
ZXN0IGZ1bmN0aW9uIGNhbiBhbHNvIGNvbmZpcm0gaXQuIEJ1dCBtYXliZSBpdCdzIGJldHRlciB0
aGF0IGFkZCB0aGUganVkZ2UNCmFzIGEgZG1hIGVudHJhbmNlIGZpcnN0Pw0KSSB0aGluayBpZiB0
aGUgZG1hcyBpcyBiZSB3cml0dGVuIGl0IG1lYW5zIGRtYSB3YW50IGJlIHN1cHBvcnQuIEF0IHRo
aXMgdGltZSwgcmF0aGVyIHRoYW4gDQpzaWxlbnRseSBjaGFuZ2UgdG8gbm8gZG1hIG1vZGVsLCB3
ZSBtYXkgdGhyb3cgdGhlIGVycm9yIHdoZW4gc29tZSBlcnJvcnMgaGFwcGVuZWQuDQpCdXQgZG1h
IHJlcXVlc3QgZmFpbGVkIG1heSBoYXZlIG1hbnkgb3RoZXIgcmVhc29ucy4gQWxzbyB0aGUganVk
Z2Ugd2lsbCBqdXN0IHJ1biBvbmx5IG9uY2UsIA0KaXQgd2lsbCBub3Qgd2FzdGUgb2YgcGVyZm9y
bWFuY2UuDQpJZiB0aGUgZG1hcyBpcyBub3QgYmUgd3JpdHRlbiwgd2UgZG9uJ3QgbmVlZCB0byBk
byBhbnl0aGluZyBhYm91dCBkbWEuDQo=
