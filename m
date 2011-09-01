From: Mikael Starvik <mikael.starvik@axis.com>
Subject: RE: [PATCH] cris: lower the printk level in cris serial driver
Date: Thu, 1 Sep 2011 10:34:28 +0200
Message-ID: <4BEA3FF3CAA35E408EA55C7BE2E61D055C652CFE5D@xmail3.se.axis.com>
References: <1314857640-6623-1-git-send-email-xiyou.wangcong@gmail.com>
	<CAMuHMdWSm2bQQpdM1OM=6+17CeNikn9RYm_BpFmEV7jD4sAPig@mail.gmail.com>
 <20110901090930.064c2775@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from ra.se.axis.com ([195.60.68.13]:36242 "EHLO ra.se.axis.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756447Ab1IAIog (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 1 Sep 2011 04:44:36 -0400
In-Reply-To: <20110901090930.064c2775@lxorguk.ukuu.org.uk>
Content-Language: en-US
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, Geert Uytterhoeven <geert@linux-m68k.org>
Cc: WANG Cong <xiyou.wangcong@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, Jesper Nilsson <jespern@axis.com>, Alan Cox <alan@linux.intel.com>, linux-cris-kernel <linux-cris-kernel@axis.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>

QXMgYSBzaWRlIG5vdGUgY3Jpc3YxMCBpcyBvbGQgc3R1ZmYuIElmIHlvdSB3YW50IHRvIGNoYW5n
ZSBhbnl0aGluZyBrZWVwIGl0IHNpbXBsZSAobGlrZSBjaGFuZ2luZyBsb2cgbGV2ZWwpLiBGaW5k
aW5nIHNvbWVvbmUgdG8gdmVyaWZ5IG1vcmUgY29ycmVjdCBtb2RpZmljYXRpb25zIGFzIEFsYW4g
cHJvcG9zZXMgbWF5IGJlIGRpZmZpY3VsdC4NCg0KL01pa2FlbA0KDQotLS0tLU9yaWdpbmFsIE1l
c3NhZ2UtLS0tLQ0KRnJvbTogQWxhbiBDb3ggW21haWx0bzphbGFuQGx4b3JndWsudWt1dS5vcmcu
dWtdIA0KU2VudDogZGVuIDEgc2VwdGVtYmVyIDIwMTEgMTA6MTANClRvOiBHZWVydCBVeXR0ZXJo
b2V2ZW4NCkNjOiBXQU5HIENvbmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGFrcG1A
bGludXgtZm91bmRhdGlvbi5vcmc7IE1pa2FlbCBTdGFydmlrOyBKZXNwZXIgTmlsc3NvbjsgQWxh
biBDb3g7IGxpbnV4LWNyaXMta2VybmVsOyBsaW51eC1zZXJpYWxAdmdlci5rZXJuZWwub3JnDQpT
dWJqZWN0OiBSZTogW1BBVENIXSBjcmlzOiBsb3dlciB0aGUgcHJpbnRrIGxldmVsIGluIGNyaXMg
c2VyaWFsIGRyaXZlcg0KDQo+ID4gwqAgwqAgwqAgwqBpZiAoaW5mby0+cmVjdl9jbnQgKyByZWN2
bCA+IDY1NTM2KSB7DQo+ID4gLSDCoCDCoCDCoCDCoCDCoCDCoCDCoCBwcmludGsoS0VSTl9DUklU
DQo+ID4gKyDCoCDCoCDCoCDCoCDCoCDCoCDCoCBwcmludGsoS0VSTl9JTkZPDQo+ID4gwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgIiVzOiBUb28gbXVjaCBwZW5kaW5nIGluY29taW5n
IHNlcmlhbCBkYXRhISBEcm9wcGluZyAldSBieXRlcy5cbiIsIF9fZnVuY19fLCByZWN2bCk7DQo+
ID4gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByZXR1cm4gMDsNCj4gPiDCoCDCoCDCoCDCoH0NCj4g
DQo+IEkgdGhpbmsgZHJvcHBlZCBkYXRhIHdhcnJhbnRzIEtFUk5fV0FSTi4NCg0KSWYgeW91IGhh
dmUgYW4gb3ZlcmZsb3cgeW91IHdhbnQgdG8gcHVzaCB0aGUgcmVsZXZhbnQgdHR5IGZsYWcgaW50
byB0aGUNCnF1ZXVlLiBJJ20gbm90IHN1cmUgYSBwcmludGsgaXMgdGhhdCB1c2VmdWwgLSBlbmQg
dXNlcnMgb2YgZW1iZWRkZWQNCmRldmljZXMgKG9yIGV2ZW4gUEMgZGVza3RvcHMpIHdvbid0IHNl
ZSBpdCBhbnl3YXkgYW5kIGlmIHlvdSBoYXZlIHNlcmlhbA0KY29uc29sZSBpdCBjYW4gYWN0dWFs
bHkgbWFrZSB0aGluZ3Mgd29yc2UNCg0KUGx1cyBvZiBjb3Vyc2UgaXQncyBub3QgcmF0ZSBsaW1p
dGVkIGhlcmUgc28gaXRzIGEgbG9nIHdpcGluZyB2ZWN0b3IgLi4uDQo=
