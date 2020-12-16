Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6A43C2BBCD
	for <linux-serial@archiver.kernel.org>; Wed, 16 Dec 2020 09:45:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B58A523124
	for <linux-serial@archiver.kernel.org>; Wed, 16 Dec 2020 09:45:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726141AbgLPJpJ (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 16 Dec 2020 04:45:09 -0500
Received: from smtp.asem.it ([151.1.184.197]:61271 "EHLO smtp.asem.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725889AbgLPJpJ (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 16 Dec 2020 04:45:09 -0500
Received: from webmail.asem.it
        by asem.it (smtp.asem.it)
        (SecurityGateway 6.5.2)
        with ESMTP id SG000672439.MSG 
        for <linux-serial@vger.kernel.org>; Wed, 16 Dec 2020 10:44:09 +0100S
Received: from ASAS044.asem.intra (172.16.16.44) by ASAS044.asem.intra
 (172.16.16.44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 16
 Dec 2020 10:44:08 +0100
Received: from ASAS044.asem.intra ([::1]) by ASAS044.asem.intra ([::1]) with
 mapi id 15.01.1979.003; Wed, 16 Dec 2020 10:44:08 +0100
From:   Flavio Suligoi <f.suligoi@asem.it>
To:     "Ji-Ze Hong (Peter Hong)" <hpeter@gmail.com>
CC:     Jiri Slaby <jirislaby@kernel.org>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: R: R: R: R: [PATCH v1] serial: 8250_fintek: Print Fintek chip name
Thread-Topic: R: R: R: [PATCH v1] serial: 8250_fintek: Print Fintek chip name
Thread-Index: AQHW0hsm4LBjpzgBaEuoNhCE3PXG1an2iQoAgAGZwAD///h9AIAAFBzA///7boCAABURgIAAlu+AgACkoLA=
Date:   Wed, 16 Dec 2020 09:44:08 +0000
Message-ID: <44e270c8097c4351a92885fc21793f8d@asem.it>
References: <20201214131445.954822-1-f.suligoi@asem.it>
 <X9dr2IvOgPyhsalE@kroah.com> <ff8f6af85d27448d93d1220545f163be@asem.it>
 <X9i9RKAbpoR0F7Y+@kroah.com> <178bf34c76184d39b6b17d5e54133821@asem.it>
 <X9jKTZoX9Se+Ghn/@kroah.com> <08c7185573314b5ba622e5a872defd33@asem.it>
 <47f3c665-df17-27ca-7835-5917f70a9665@gmail.com>
In-Reply-To: <47f3c665-df17-27ca-7835-5917f70a9665@gmail.com>
Accept-Language: it-IT, en-US
Content-Language: it-IT
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.17.208]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SGHeloLookup-Result: pass smtp.helo=webmail.asem.it (ip=172.16.16.44)
X-SGSPF-Result: none (smtp.asem.it)
X-SGOP-RefID: str=0001.0A782F26.5FD9D6E8.0104,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0 (_st=1 _vt=0 _iwf=0)
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

SGkgUGV0ZXIsDQoNCj4gPj4+DQo+ID4+PiBkbWVzZ3wgZ3JlcCB0dHlTDQo+ID4+DQo+ID4+IEJ1
dCBhcyB0aGV5IHdvcmsgdGhlIHNhbWUsIHdoeSBkb2VzIGl0IG1hdHRlcj8NCj4gPg0KPiA+IFll
cyB5b3UgYXJlIHJpZ2h0LCBieSB0aGUgdXNlciBwb2ludCBvZiB2aWV3LCB0aGV5IGFyZSB0aGUg
c2FtZS4NCj4gPg0KPiA+Pg0KPiA+PiBVc2Vyc3BhY2Ugc2hvdWxkIG5vdCBjYXJlIGhlcmUuICBJ
c24ndCB0aGVyZSBzb21lIG90aGVyIGlkIHlvdSBjYW4NCj4gPj4gcmVhZC9xdWVyeSBmb3IgYSBo
YXJkd2FyZSBkYXRhYmFzZSB0b29sIHRvIGRldGVybWluZSB0aGlzPw0KPiANCj4gDQo+IEFzIEdy
ZWcgbWVudGlvbnMsIFRoZSB1c2Vyc3BhY2UgZG9uJ3QgY2FyZSB3aGF0IElDIHRoZXkgYXJlIHVz
aW5nLg0KPiBXZSBjYW4gdXNlIExpbnV4IFJTNDg1IEFQSSB0byBjb250cm9sIG9yIGNoZWNrIHRo
ZSBzZXJpYWwgcG9ydC4NCj4gDQo+IGh0dHBzOi8vd3d3Lmtlcm5lbC5vcmcvZG9jL2h0bWwvbGF0
ZXN0L2RyaXZlci1hcGkvc2VyaWFsL3NlcmlhbC1yczQ4NS5odG1sDQoNClllcywgcmlnaHQhIA0K
VGhhbmtzIGZvciB5b3VyIGluZm8hDQoNCj4gDQo+IC0tDQo+IFdpdGggQmVzdCBSZWdhcmRzLA0K
PiBQZXRlciBIb25nDQoNCkJlc3QgcmVnYXJkcywNCkZsYXZpbw0K
