Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 937ADC433F5
	for <linux-serial@archiver.kernel.org>; Sat,  6 Nov 2021 16:40:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C4BA61165
	for <linux-serial@archiver.kernel.org>; Sat,  6 Nov 2021 16:40:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234570AbhKFQnD (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 6 Nov 2021 12:43:03 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:20390 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230232AbhKFQnC (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 6 Nov 2021 12:43:02 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-279-Uuiy6FHeNDuYeQdc0PaFdQ-1; Sat, 06 Nov 2021 16:40:17 +0000
X-MC-Unique: Uuiy6FHeNDuYeQdc0PaFdQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.24; Sat, 6 Nov 2021 16:40:16 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.024; Sat, 6 Nov 2021 16:40:16 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Pavel Skripkin' <paskripkin@gmail.com>,
        Ajay Garg <ajaygargnsit@gmail.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] tty: vt: keyboard: do not copy an extra-byte in
 copy_to_user
Thread-Topic: [PATCH] tty: vt: keyboard: do not copy an extra-byte in
 copy_to_user
Thread-Index: AQHX0wDMp45dq2RRKUOAel7eGWdnJqv2s61A
Date:   Sat, 6 Nov 2021 16:40:16 +0000
Message-ID: <868025b485b94480ad17d0ec971b3ee9@AcuMS.aculab.com>
References: <20211106092041.43745-1-ajaygargnsit@gmail.com>
 <9eafae1f-d9f0-298d-cf20-212865d0becc@gmail.com>
In-Reply-To: <9eafae1f-d9f0-298d-cf20-212865d0becc@gmail.com>
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

RnJvbTogUGF2ZWwgU2tyaXBraW4NCj4gU2VudDogMDYgTm92ZW1iZXIgMjAyMSAxMToyNA0KPiAN
Cj4gSGksIEFqYXkhDQo+IA0KPiBPbiAxMS82LzIxIDEyOjIwLCBBamF5IEdhcmcgd3JvdGU6DQo+
ID4gQm90aCAoc3RhdGljYWxseS1hbGxvY2F0ZWQpICJ1c2VyX2tkZ2tiLT5rYl9zdHJpbmciIGFu
ZA0KPiA+IChkeW5hbWljYWxseS1hbGxvY2F0ZWQpICJrYnMiIGFyZSBvZiBsZW5ndGggImxlbiIs
IHNvIHdlIG11c3QNCj4gPiBub3QgY29weSBtb3JlIHRoYW4gImxlbiIgYnl0ZXMuDQo+ID4NCj4g
PiBTaWduZWQtb2ZmLWJ5OiBBamF5IEdhcmcgPGFqYXlnYXJnbnNpdEBnbWFpbC5jb20+DQo+ID4g
LS0tDQo+ID4gICBkcml2ZXJzL3R0eS92dC9rZXlib2FyZC5jIHwgMiArLQ0KPiA+ICAgMSBmaWxl
IGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4NCj4gPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy90dHkvdnQva2V5Ym9hcmQuYyBiL2RyaXZlcnMvdHR5L3Z0L2tleWJvYXJk
LmMNCj4gPiBpbmRleCBjN2ZiYmNkY2MzNDYuLmRmZWY3ZGU4YTA1NyAxMDA2NDQNCj4gPiAtLS0g
YS9kcml2ZXJzL3R0eS92dC9rZXlib2FyZC5jDQo+ID4gKysrIGIvZHJpdmVycy90dHkvdnQva2V5
Ym9hcmQuYw0KPiA+IEBAIC0yMDcwLDcgKzIwNzAsNyBAQCBpbnQgdnRfZG9fa2Rna2JfaW9jdGwo
aW50IGNtZCwgc3RydWN0IGtic2VudHJ5IF9fdXNlciAqdXNlcl9rZGdrYiwgaW50IHBlcm0pDQo+
ID4gICAJCWxlbiA9IHN0cmxjcHkoa2JzLCBmdW5jX3RhYmxlW2tiX2Z1bmNdID8gOiAiIiwgbGVu
KTsNCj4gDQo+IAkJXl5eXl5eXl5eDQo+IA0KPiBsZW4gaXMgcmVpbml0aWFsaXplZCBoZXJlLCBp
LmUgbGVuIHBhc3NlZCB0byBrbWFsbG9jIGFuZCBsZW4gcGFzc2VkIHRvDQo+IGNvcHlfdG9fdXNl
cigpIGNhbiBiZSBkaWZmZXJlbnQuDQo+IA0KPiBzdHJsY3B5KCkgcmV0dXJucyBzdHJsZW4oKSBv
ZiBzb3VyY2Ugc3RyaW5nICgybmQgYXJndW1lbnQpLCB0aGF0J3Mgd2h5DQo+IHdlIG5lZWQgKzEg
aGVyZSB0byBwYXNzIG51bGwgYnl0ZSB0byB1c2VyLg0KPiANCj4gQW0gSSBtaXNzaW5nIHNvbWV0
aGluZz8NCg0KWW91IHdhbnQgc3Ryc2NweSgpIC0gcmV0dXJucyB0aGUgbnVtYmVyIG9mIGNoYXJh
Y3RlcnMvYnl0ZXMgaXQgY29waWVkLg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNz
IExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAx
UFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

