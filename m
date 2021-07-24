Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3083BC4320A
	for <linux-serial@archiver.kernel.org>; Sat, 24 Jul 2021 11:38:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1219060F23
	for <linux-serial@archiver.kernel.org>; Sat, 24 Jul 2021 11:38:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234162AbhGXK5q (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 24 Jul 2021 06:57:46 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:29089 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234060AbhGXK5n (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 24 Jul 2021 06:57:43 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-91-0CBdJO-pOeK0UdyG1Gricw-1; Sat, 24 Jul 2021 12:38:13 +0100
X-MC-Unique: 0CBdJO-pOeK0UdyG1Gricw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.23; Sat, 24 Jul 2021 12:38:11 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.023; Sat, 24 Jul 2021 12:38:11 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     =?utf-8?B?J1BhbGkgUm9ow6FyJw==?= <pali@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Vladimir Vid <vladimir.vid@sartura.hr>,
        =?utf-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>, Willy Tarreau <w@1wt.eu>
Subject: RE: [PATCH v3 1/5] math64: New DIV_U64_ROUND_CLOSEST helper
Thread-Topic: [PATCH v3 1/5] math64: New DIV_U64_ROUND_CLOSEST helper
Thread-Index: AQHXf0SdmxMmh7k2XUK/jOFZBX3u3qtSAERA
Date:   Sat, 24 Jul 2021 11:38:11 +0000
Message-ID: <1e1b44b0a26746278c3ee4fec5c93d68@AcuMS.aculab.com>
References: <20210624224909.6350-1-pali@kernel.org>
 <20210717123829.5201-1-pali@kernel.org>
 <20210717123829.5201-2-pali@kernel.org>
 <CAHp75VeCC3cYu3RZPxuRN4iaM+vxp2rX+E4z+ZxzRGM8oHaMkw@mail.gmail.com>
 <20210722215743.gtwccvokecvoocmm@pali>
In-Reply-To: <20210722215743.gtwccvokecvoocmm@pali>
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

RnJvbTogUGFsaSBSb2jDoXINCj4gU2VudDogMjIgSnVseSAyMDIxIDIyOjU4DQo+IA0KPiBPbiBN
b25kYXkgMTkgSnVseSAyMDIxIDE1OjQ3OjA3IEFuZHkgU2hldmNoZW5rbyB3cm90ZToNCj4gPiBP
biBTYXQsIEp1bCAxNywgMjAyMSBhdCAzOjM5IFBNIFBhbGkgUm9ow6FyIDxwYWxpQGtlcm5lbC5v
cmc+IHdyb3RlOg0KPiA+ID4NCj4gPiA+IFByb3ZpZGUgRElWX1U2NF9ST1VORF9DTE9TRVNUIGhl
bHBlciB3aGljaCB1c2VzIGRpdl91NjQgdG8gcGVyZm9ybQ0KPiA+ID4gZGl2aXNpb24gcm91bmRl
ZCB0byB0aGUgY2xvc2VzdCBpbnRlZ2VyIHVzaW5nIHVuc2lnbmVkIDY0Yml0DQo+ID4gPiBkaXZp
ZGVuZCBhbmQgdW5zaWduZWQgMzJiaXQgZGl2aXNvci4NCj4gPg0KPiA+IC4uLg0KPiA+DQo+ID4g
PiArLyoNCj4gPiA+ICsgKiBESVZfVTY0X1JPVU5EX0NMT1NFU1QgLSB1bnNpZ25lZCA2NGJpdCBk
aXZpZGUgd2l0aCAzMmJpdCBkaXZpc29yIHJvdW5kZWQgdG8gbmVhcmVzdCBpbnRlZ2VyDQo+ID4N
Cj4gPiA+ICsgKiBAZGl2aWRlbmQ6IHVuc2lnbmVkIDY0Yml0IGRpdmlkZW5kDQo+ID4NCj4gPiBI
ZXJlIHlvdSBpbnNpc3QgdXNlcnMgdG8gcHJvdmlkZSBhIHU2NCAob3IgY29tcGF0aWJsZSkgdHlw
ZS4NCj4gPg0KPiA+ID4gKyAqIEBkaXZpc29yOiB1bnNpZ25lZCAzMmJpdCBkaXZpc29yDQo+ID4g
PiArICoNCj4gPiA+ICsgKiBEaXZpZGUgdW5zaWduZWQgNjRiaXQgZGl2aWRlbmQgYnkgdW5zaWdu
ZWQgMzJiaXQgZGl2aXNvcg0KPiA+ID4gKyAqIGFuZCByb3VuZCB0byBjbG9zZXN0IGludGVnZXIu
DQo+ID4gPiArICoNCj4gPiA+ICsgKiBSZXR1cm46IGRpdmlkZW5kIC8gZGl2aXNvciByb3VuZGVk
IHRvIG5lYXJlc3QgaW50ZWdlcg0KPiA+ID4gKyAqLw0KPiA+ID4gKyNkZWZpbmUgRElWX1U2NF9S
T1VORF9DTE9TRVNUKGRpdmlkZW5kLCBkaXZpc29yKSAgICAgICBcDQo+ID4NCj4gPiA+ICsgICAg
ICAgKHsgdTMyIF90bXAgPSAoZGl2aXNvcik7IGRpdl91NjQoKHU2NCkoZGl2aWRlbmQpICsgX3Rt
cCAvIDIsIF90bXApOyB9KQ0KPiA+DQo+ID4gSGVyZSBpcyB0aGUgY2FzdGluZyB0byB1NjQuIFdo
eT8gKFllcywgSSBoYXZlIHJlYWQgdjEgZGlzY3Vzc2lvbiBhbmQgSQ0KPiA+IGp1c3Qgd2FudCB0
byBjb250aW51ZSBpdCBoZXJlKS4NCj4gDQo+IFNlZSBhbHNvIFdpbGx5J3MgcmVzcG9uc2U6IGh0
dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvMjAyMTA2MjUxNTUwMDguR0IxNjkwMUAxd3QuZXUv
DQo+IA0KPiBNYWNybyBkb2VzIG5vdCBlbmZvcmNlIHR5cGUgYXMgb3Bwb3NpdGUgdG8gZnVuY3Rp
b24uDQo+IA0KPiBUaGVyZSBpcyBubyBjb21waWxlIHRpbWUgY2hlY2sgZm9yIGNvcnJlY3QgdHlw
ZSBhbmQgbmVpdGhlciBjb21waWxlIHRpbWUNCj4gd2FybmluZyBpZiBzbWFsbGVyIHR5cGVkIHZh
bHVlIGlzIHBhc3NlZC4NCj4gDQo+IEFuZCBlLmcuIHBhc3NpbmcgY29uc3RhbnQgd2l0aCBleHBs
aWNpdCBVTEwgc3VmZml4IG9yIGNhc3RpbmcgZXh0ZXJuYWwNCj4gY29uc3RhbnQgdG8gNjRiaXQg
dHlwZSBpcyBpbXByYWN0aWNhbC4NCg0KV2hhdCBpcyB3cm9uZyB3aXRoOg0KCSh7IHUzMiBfdG1w
ID0gKGRpdmlzb3IpOyBkaXZfdTY0KChkaXZpZGVuZCkgKyAodTY0KTAgKyBfdG1wIC8gMiwgX3Rt
cCk7IH0pDQpPcjoNCgkoeyB1MzIgX3RtcCA9IChkaXZpc29yKTsgZGl2X3U2NCgoZGl2aWRlbmQp
ICsgKHU2NCkoX3RtcCAvIDIpLCBfdG1wKTsgfSkNCkJvdGggd2lsbCBlbnN1cmUgYSAzMmJpdCAn
ZGl2aWRlbmQnIGlzIHByb21vdGVkIHRvIDY0IGJpdHMgYmVmb3JlIHRoZSAnKycuDQpCb3RoIHdp
bGwgZmFpbCBpZiAnZGl2aWRlbmQnIGlzbid0IGFuIGludGVnZXIgdHlwZS4NCk9uIDMyYml0IHN5
c3RlbXMgdGhlIGNvbXBpbGVyIHdpbGwgYWxzbyBrbm93IHdoZW4gdGhlIGhpZ2ggYml0cyB2YW4g
YmUgaWdub3JlZC4NCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwg
QnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVn
aXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==

