Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6201EC41513
	for <linux-serial@archiver.kernel.org>; Wed, 16 Aug 2023 08:42:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239444AbjHPIlt (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 16 Aug 2023 04:41:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243202AbjHPIlG (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 16 Aug 2023 04:41:06 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BB981BDA
        for <linux-serial@vger.kernel.org>; Wed, 16 Aug 2023 01:41:04 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-41-4ygLBWawPZGHmbHVD3A7_Q-1; Wed, 16 Aug 2023 09:41:02 +0100
X-MC-Unique: 4ygLBWawPZGHmbHVD3A7_Q-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 16 Aug
 2023 09:40:59 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Wed, 16 Aug 2023 09:40:59 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Jiri Slaby' <jirislaby@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-staging@lists.linux.dev" <linux-staging@lists.linux.dev>
Subject: RE: [PATCH 34/36] tty: gdm724x: convert counts to size_t
Thread-Topic: [PATCH 34/36] tty: gdm724x: convert counts to size_t
Thread-Index: AQHZ0A2Smc/5XT+NnUuSfmLwyiVGwq/smYqg
Date:   Wed, 16 Aug 2023 08:40:59 +0000
Message-ID: <bdbdfdaad3a842d2837ac9d15ef2ab25@AcuMS.aculab.com>
References: <20230810091510.13006-1-jirislaby@kernel.org>
 <20230810091510.13006-35-jirislaby@kernel.org>
 <20230815172247.GA1690054@dev-arch.thelio-3990X>
 <937e14c1-d884-0b6e-595a-e8aaa3d09025@kernel.org>
In-Reply-To: <937e14c1-d884-0b6e-595a-e8aaa3d09025@kernel.org>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

RnJvbTogSmlyaSBTbGFieQ0KPiBTZW50OiBXZWRuZXNkYXksIEF1Z3VzdCAxNiwgMjAyMyA3OjQ3
IEFNDQo+IA0KPiBPbiAxNS4gMDguIDIzLCAxOToyMiwgTmF0aGFuIENoYW5jZWxsb3Igd3JvdGU6
DQo+ID4gT24gVGh1LCBBdWcgMTAsIDIwMjMgYXQgMTE6MTU6MDhBTSArMDIwMCwgSmlyaSBTbGFi
eSAoU1VTRSkgd3JvdGU6DQo+ID4+IFVuaWZ5IHRoZSB0eXBlIG9mIHR0eV9vcGVyYXRpb25zOjp3
cml0ZSgpIGNvdW50ZXJzIHdpdGggdGhlICdjb3VudCcNCj4gPj4gcGFyYW1ldGVyLiBJLmUuIHVz
ZSBzaXplX3QgZm9yIHRoZW0uDQo+ID4+DQo+ID4+IFRoaXMgaW5jbHVkZXMgY2hhbmdpbmcgY29u
c3RhbnRzIHRvIFVMIHRvIGtlZXAgbWluKCkgYW5kIGF2b2lkIG1pbl90KCkuDQo+ID4NCj4gPiBU
aGlzIHBhdGNoIGFwcGVhcnMgdG8gY2F1c2UgYSB3YXJuaW5nL2Vycm9yIG9uIDMyLWJpdCBhcmNo
aXRlY3R1cmVzIG5vdw0KPiA+IGR1ZSB0byB0aGlzIHBhcnQgb2YgdGhlIGNoYW5nZSwgYXMgc2l6
ZV90IGlzICd1bnNpZ25lZCBpbnQnIHRoZXJlOg0KPiANCj4gUmlnaHQsIHRoaXMgaXMgbXkgYnJh
aW4gZmFydCB0aGlua2luZyB1bG9uZyBpcyB0aGUgc2FtZSBhcyBzaXplX3QNCj4gZXZlcnl3aGVy
ZS4gTm8sIHNpemVfdCBpcyB1aW50IG9uIDMyYml0Lg0KPiANCj4gSSB3aWxsIGZpeCB0aGlzIC0t
IGtlcm5lbCBidWlsZCBib3Qgc2VlbXMgdG8gYmUgc2xvdyAtLSBpdCBkaWRuJ3QgZmluZA0KPiB0
aGUgaXNzdWUgb3V0IGluIG15IHF1ZXVlLCBub3IgaW4gdHR5LXRlc3RpbmcuDQoNCidWb3RlIHVw
JyBteSBwYXRjaGVzIHRvIG1pbm1heC5oIHRoYXQgbWFrZSB0aGlzIGFsbCB3b3JrLg0KVGhlbiBp
dCB3b24ndCBjYXJlIHByb3ZpZGVkIGJvdGggdmFsdWVzIGhhdmUgdGhlIHNhbWUgc2lnbmVkbmVz
cy4NCihvciwgd2l0aCBwYXRjaCA1LCBhcmUgbm9uLW5lZ2F0aXZlIDMxYml0IGNvbXBpbGUgdGlt
ZSBjb25zdGFudHMuKQ0KDQpQcmV0dHkgbXVjaCB0aGUgb25seSBvdGhlciBwYXRjaCBpcyBjYXN0
aW5nIHRoZSBjb25zdGFudHMgdG8gKHNpemVfdCkuDQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVk
IEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5l
cywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=

