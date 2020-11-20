Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E531C2D0E4
	for <linux-serial@archiver.kernel.org>; Fri, 20 Nov 2020 20:00:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 163592240A
	for <linux-serial@archiver.kernel.org>; Fri, 20 Nov 2020 20:00:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729633AbgKTUAK (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 20 Nov 2020 15:00:10 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:27269 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728590AbgKTUAK (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 20 Nov 2020 15:00:10 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-57-DKzvyGEWO86tzjNp9HgpTA-1; Fri, 20 Nov 2020 20:00:06 +0000
X-MC-Unique: DKzvyGEWO86tzjNp9HgpTA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Fri, 20 Nov 2020 20:00:05 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Fri, 20 Nov 2020 20:00:05 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Johan Hovold' <johan@kernel.org>,
        "tiantao (H)" <tiantao6@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     Tian Tao <tiantao6@hisilicon.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "jirislaby@kernel.org" <jirislaby@kernel.org>,
        "afaerber@suse.de" <afaerber@suse.de>,
        "manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] tty: serial: replace spin_lock_irqsave by spin_lock in
 hard IRQ
Thread-Topic: [PATCH] tty: serial: replace spin_lock_irqsave by spin_lock in
 hard IRQ
Thread-Index: AQHWvzvedNBRKBahtEqDJHaWmtJ6SqnRaVoQ
Date:   Fri, 20 Nov 2020 20:00:05 +0000
Message-ID: <40a52ea2273146b98b3ae3439a22d1eb@AcuMS.aculab.com>
References: <1605776489-16283-1-git-send-email-tiantao6@hisilicon.com>
 <X7d85DKvisjA3nYv@localhost>
 <9ce93d7b-f769-58ed-e6bf-95c34bd0123e@huawei.com>
 <X7e7dYlYxPDsj71G@localhost>
In-Reply-To: <X7e7dYlYxPDsj71G@localhost>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=C51A453 smtp.mailfrom=david.laight@aculab.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

RnJvbTogSm9oYW4gSG92b2xkDQo+IFNlbnQ6IDIwIE5vdmVtYmVyIDIwMjAgMTI6NTANCj4gDQo+
IE9uIEZyaSwgTm92IDIwLCAyMDIwIGF0IDA3OjI1OjAzUE0gKzA4MDAsIHRpYW50YW8gKEgpIHdy
b3RlOg0KPiA+IOWcqCAyMDIwLzExLzIwIDE2OjIzLCBKb2hhbiBIb3ZvbGQg5YaZ6YGTOg0KPiA+
ID4gT24gVGh1LCBOb3YgMTksIDIwMjAgYXQgMDU6MDE6MjlQTSArMDgwMCwgVGlhbiBUYW8gd3Jv
dGU6DQo+ID4gPj4gVGhlIGNvZGUgaGFzIGJlZW4gaW4gYSBpcnEtZGlzYWJsZWQgY29udGV4dCBz
aW5jZSBpdCBpcyBoYXJkIElSUS4gVGhlcmUNCj4gPiA+PiBpcyBubyBuZWNlc3NpdHkgdG8gZG8g
aXQgYWdhaW4uDQo+ID4gPj4NCj4gPiA+PiBTaWduZWQtb2ZmLWJ5OiBUaWFuIFRhbyA8dGlhbnRh
bzZAaGlzaWxpY29uLmNvbT4NCj4gPiA+PiAtLS0NCj4gPiA+PiAgIGRyaXZlcnMvdHR5L3Nlcmlh
bC9vd2wtdWFydC5jIHwgNSArKy0tLQ0KPiA+ID4+ICAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0
aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4gPiA+Pg0KPiA+ID4+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL3R0eS9zZXJpYWwvb3dsLXVhcnQuYyBiL2RyaXZlcnMvdHR5L3NlcmlhbC9vd2wtdWFydC5j
DQo+ID4gPj4gaW5kZXggYzE0OWY4YzMuLjQ3MmZkYWYgMTAwNjQ0DQo+ID4gPj4gLS0tIGEvZHJp
dmVycy90dHkvc2VyaWFsL293bC11YXJ0LmMNCj4gPiA+PiArKysgYi9kcml2ZXJzL3R0eS9zZXJp
YWwvb3dsLXVhcnQuYw0KPiA+ID4+IEBAIC0yNTEsMTAgKzI1MSw5IEBAIHN0YXRpYyB2b2lkIG93
bF91YXJ0X3JlY2VpdmVfY2hhcnMoc3RydWN0IHVhcnRfcG9ydCAqcG9ydCkNCj4gPiA+PiAgIHN0
YXRpYyBpcnFyZXR1cm5fdCBvd2xfdWFydF9pcnEoaW50IGlycSwgdm9pZCAqZGV2X2lkKQ0KPiA+
ID4+ICAgew0KPiA+ID4+ICAgCXN0cnVjdCB1YXJ0X3BvcnQgKnBvcnQgPSBkZXZfaWQ7DQo+ID4g
Pj4gLQl1bnNpZ25lZCBsb25nIGZsYWdzOw0KPiA+ID4+ICAgCXUzMiBzdGF0Ow0KPiA+ID4+DQo+
ID4gPj4gLQlzcGluX2xvY2tfaXJxc2F2ZSgmcG9ydC0+bG9jaywgZmxhZ3MpOw0KPiA+ID4+ICsJ
c3Bpbl9sb2NrKCZwb3J0LT5sb2NrKTsNCj4gPiA+DQo+ID4gPiBTYW1lIHRoaW5nIGhlcmU7IHRo
aXMgd2lsbCBicmVhayB3aXRoIGZvcmNlZCBpcnEgdGhyZWFkaW5nIChpLmUuDQo+ID4gPiAidGhy
ZWFkaXJxcyIpIHNpbmNlIHRoZSBjb25zb2xlIGNvZGUgY2FuIHN0aWxsIGVuZCB1cCBiZWluZyBj
YWxsZWQgZnJvbQ0KPiA+ID4gaW50ZXJydXB0IGNvbnRleHQuDQo+IA0KPiA+IEFzIHRoZSBmb2xs
b3dpbmcgY29kZSBzaG93cywgb3dsX3VhcnRfaXJxIGRvZXMgbm90IHJ1biBpbiB0aGUgaXJxDQo+
ID4gdGhyZWFkaW5nIGNvbnRleHQuDQo+ID4gICByZXQgPSByZXF1ZXN0X2lycShwb3J0LT5pcnEs
IG93bF91YXJ0X2lycSwgSVJRRl9UUklHR0VSX0hJR0gsDQo+ID4gICAgICAgICAgICAgICAgICAg
ICAgICAgICJvd2wtdWFydCIsIHBvcnQpOw0KPiA+ICAgICAgICAgIGlmIChyZXQpDQo+ID4gICAg
ICAgICAgICAgICAgICByZXR1cm4gcmV0Ow0KPiANCj4gSXQgc3RpbGwgcnVucyBpbiBhIHRocmVh
ZCB3aGVuIGludGVycnVwdHMgYXJlIGZvcmNlZCB0byBiZSB0aHJlYWRlZA0KPiB1c2luZyB0aGUg
a2VybmVsIHBhcmFtZXRlciAidGhyZWFkaXJxcyIuDQo+IA0KPiBXZSBqdXN0IGhhZCBhIHJldmVy
dCBvZiBhIGNoYW5nZSBsaWtlIHlvdXJzIGFmdGVyIGxvY2tkZXAgcmVwb3J0ZWQgdGhlDQo+IHJl
c3VsdGluZyBsb2NrIGludmVyc2lvbiB3aXRoIGZvcmNlZCBpbnRlcnJ1cHQgdGhyZWFkaW5nLg0K
PiANCj4gV2hldGhlciBkcml2ZXJzIHNob3VsZCBoYXZlIHRvIGNhcmUgYWJvdXQgInRocmVhZGly
cXMiIGlzIGEgc29tZXdoYXQNCj4gZGlmZmVyZW50IHF1ZXN0aW9uLiBOb3Qgc3VyZSBob3cgdGhh
dCdzIGV2ZW4gc3VwcG9zZWQgdG8gd29yayBnZW5lcmFsbHkNCj4gdW5sZXNzIHdlIG1hc3MtY29u
dmVydCBkcml2ZXJzIHRvIHNwaW5fbG9ja19pcnFzYXZlKCkgKG9yIG1hcmsgdGhlaXINCj4gaW50
ZXJydXB0cyBJUlFGX05PX1RIUkVBRCkuDQoNCklzbid0IHRoYXQgYmFja3dhcmRzPw0KDQpZb3Ug
bmVlZCB0byB1c2UgdGhlICdpcnFzYXZlJyB2YXJpYW50IGluIGNvZGUgdGhhdCBtaWdodCBydW4g
d2l0aA0KaW50ZXJydXB0cyBlbmFibGVkIGJlY2F1c2UgYW4gaW50ZXJydXB0IG1pZ2h0IHRyeSB0
byBhY3F1aXJlIHRoZQ0Kc2FtZSBsb2NrIGhhdmluZyBpbnRlcnJ1cHRlZCB0aGUgY29kZSB0aGF0
IGFscmVhZHkgaG9sZHMgdGhlIGxvY2suDQoNCklmIGludGVycnVwdHMgcnVuIGFzIHNlcGFyYXRl
IHRocmVhZHMgdGhhdCBjYW4gbmV2ZXIgaGFwcGVuLg0KU28gaW4gdGhhdCBjYXNlIGFsbCBjb2Rl
IGNhbiB1c2UgdGhlIG5vbi1pcnFzYXZlIGNhbGwuDQoNClNvIGVpdGhlciBsb2NrZGVwIGlzIGJy
b2tlbiBvciB5b3UgaGF2ZSBhIGRpZmZlcmVudCBidWcuDQoNCk9UT0ggdGhlIGFkZGl0aW9uYWwg
Y29zdCBvZiB1c2luZyB0aGUgJ2lycXNhdmUnIGZvcm0gaW5zaWRlDQphbiBJU1IgaXMgcHJvYmFi
bHkgbWluaW1hbC4NClNvIHdoaWxlIG5vdCBuZWNlc3NhcnkgaXQgZG9lcyBubyBoYXJtIGFuZCBz
YXZlcyB0aGUgcmVhZGVyDQpoYXZpbmcgdG8gd29ycnkgYWJvdXQgd2hldGhlciBhIHBhcnRpY3Vs
YXIgZnVuY3Rpb24gbWlnaHQNCmJlIGNhbGxlZCBmcm9tIGFuIElTUi4NCg0KCURhdmlkDQoNCi0N
ClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBN
aWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxl
cykNCg==

