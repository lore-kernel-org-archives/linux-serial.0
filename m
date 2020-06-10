Return-Path: <SRS0=uqjK=7X=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96219C433DF
	for <linux-serial@archiver.kernel.org>; Wed, 10 Jun 2020 07:34:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50488207ED
	for <linux-serial@archiver.kernel.org>; Wed, 10 Jun 2020 07:34:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=infinera.com header.i=@infinera.com header.b="NM5g/QiD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726105AbgFJHek (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 10 Jun 2020 03:34:40 -0400
Received: from mail-mw2nam12on2075.outbound.protection.outlook.com ([40.107.244.75]:25032
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726081AbgFJHej (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 10 Jun 2020 03:34:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RdWGuT2E+nBdYl7Y4w1Np9LC4yTVNUeiQYeo2wdy7tER8jUeaqNStwvvT7V1HEUC8a9G9cZJ54FKdOmtDd5n+v7FK9iu/ROxieKiAXYjojqZ0fU2fMKvhg2C2proXuZHIpSSrLXaBfg+opSwmrTzFa5dJd+IM4b1WYnbFBC19D4V0nQ3sIXbC7OJkdfR2TQ83WAbXhysFE1jYgOJ8c7bWpaMaZOYm78ICfg3BqdIyYOOmxJIcxc0AH/0ezsEwqn2AqzEZBWspVEnJ5lrD9kTrR+tXXuzthE+NdLikWZp7DHDzscMz5ofJ5dxPiO1apYxxe9hZ3I6c70rYID3o0lNOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uz10I+3UqnSLq075CYp2prM4g/BcD8S4ge40MYti4no=;
 b=c2/SvXbfgEgwjv9qxMpBmgoLUWFXImLUxL7CJz2ux4AGdn3K9tu2Vfh1yLGxG8d88ePKCEeiOSOIrLNtmkF/LRPGIm1vBVELf3cHR03YAK6u5NEg4Qzs9dNWYliWgj7WIlz8Y3nTytSa6xSgxuyH+JXFCsLQaDzLrCEdnXja5fLHYkojxPqET1aIYvRagMQhSayDi7g7253br1aJhXs4LQ0GYjhhJl3HlyWReHIHrn8sMD3cu+7NuKODlpH1iOfqt3WcyqudjpWPFRUpf9BL6BMe6JyZy7fk1q8i+t0BYOHrzYDBtIfOFkPaM1wdq7Pb96iC0dzl3OPHjFcR7l7UzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=infinera.com; dmarc=pass action=none header.from=infinera.com;
 dkim=pass header.d=infinera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infinera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uz10I+3UqnSLq075CYp2prM4g/BcD8S4ge40MYti4no=;
 b=NM5g/QiD/kHPKJTMsTtWynuRj05Gduip5PpMRmSWwH70kKMlZiNdBKg6ckUD88PhAVH+JhAyCunz0H/Hz2C6rvf5DdauImwYWut/8ZFuYfSynw5ZfCFXjIE1ohyxagTfniG/sLBkBycn4yO0xtA5yBiY39s90FrS7kgQDjwGc1g=
Received: from BN8PR10MB3540.namprd10.prod.outlook.com (2603:10b6:408:ae::24)
 by BN8PR10MB3252.namprd10.prod.outlook.com (2603:10b6:408:ca::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.18; Wed, 10 Jun
 2020 07:34:34 +0000
Received: from BN8PR10MB3540.namprd10.prod.outlook.com
 ([fe80::c158:d59f:e3bc:1941]) by BN8PR10MB3540.namprd10.prod.outlook.com
 ([fe80::c158:d59f:e3bc:1941%2]) with mapi id 15.20.3066.023; Wed, 10 Jun 2020
 07:34:34 +0000
From:   Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
To:     "m.brock@vanmierlo.com" <m.brock@vanmierlo.com>
CC:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "oneukum@suse.com" <oneukum@suse.com>,
        "linux-serial-owner@vger.kernel.org" 
        <linux-serial-owner@vger.kernel.org>
Subject: Re: Default ECHO on TTYs causes unwanted garbage chars
Thread-Topic: Default ECHO on TTYs causes unwanted garbage chars
Thread-Index: AQHWPlKKxJr0ir3sA0SM2brkyH1CUqjQLZMAgAAVM4CAABNYgIAACuAAgABrtoCAAKnRgA==
Date:   Wed, 10 Jun 2020 07:34:34 +0000
Message-ID: <2d765bffa769f0ccf8e9ef668f7fdbae5c3dbf0e.camel@infinera.com>
References: <d6d376ceb45b5a72c2a053721eabeddfa11cc1a5.camel@infinera.com>
         <20200609115712.GD819153@kroah.com>
         <984225ab9969a18fc67244a69b71c1534174d4f9.camel@infinera.com>
         <20200609142219.GB831428@kroah.com>
         <d2428c7b828d24fe1eb9b05e2d0d1af52edef846.camel@infinera.com>
         <3ca5a08d5858cf7f170046122c04313c@vanmierlo.com>
In-Reply-To: <3ca5a08d5858cf7f170046122c04313c@vanmierlo.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.3 
authentication-results: vanmierlo.com; dkim=none (message not signed)
 header.d=none;vanmierlo.com; dmarc=none action=none header.from=infinera.com;
x-originating-ip: [88.131.87.201]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 02f20ef1-70da-4b5a-217d-08d80d10b8ea
x-ms-traffictypediagnostic: BN8PR10MB3252:
x-microsoft-antispam-prvs: <BN8PR10MB325278D518FC63BE1D62790AF4830@BN8PR10MB3252.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0430FA5CB7
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3TNfX9FX0OJe5lDdESwmbmwHIrAC/+R094kHrd7GLAgSoc7HciTFh3TiL/tWDyZpnrNS1GYqHE5EjEZ2TB4RdHoa+bVRQDfScOeood8I4UiwFrKuGrUeI3WlZaDW1QU3fATgdIQPqmHK0WqpNZurGousRc9SR2qOYDiUdqz9NU2y9zoL+8f9Ru4T1dWksodwsVX6609CajNm2Unyn7+Rj9HGStEaQqC4UIjWHc8ohoZ+KFlkywgyjxfJH6yyHovN8H9BSpzjSvyU+AMlK0NmfRyoaeKW2WH58Opq9lb2ErchGl1qY3osfdu4UX4SBRF2qTQLgw/q5x8mHuztszT1580fMru1oVi6Gik4hRiY78bJI0HxUeNrKL+DDHwVC1Df
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR10MB3540.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(346002)(366004)(136003)(39860400002)(376002)(71200400001)(36756003)(6486002)(8676002)(316002)(2906002)(54906003)(8936002)(186003)(86362001)(6916009)(478600001)(53546011)(4326008)(76116006)(6506007)(26005)(91956017)(64756008)(5660300002)(6512007)(66556008)(66476007)(2616005)(66446008)(83380400001)(66946007)(26123001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: qLnr3cFGU4Vj+wTEVrNS9ruCBDqae/SIAM3UdBVp9fhelGYqWlbrA3EmqDBjDHm4EaLlSsYVpp7FmZ9A4oJ0DjJC3pPbWlpZ1jeR7jUN+sRfH5FQjwyAHIREPekoqzm2d1YIE51Njy3r+VqkNj70tgh6bFc7xsi0sLuBSZIND6qqIccLWYv/n0fA15ssXFlZNUc4rS8iX7WQwh6cV1drdB8dK/3cVj7jqYBV6OdOLCUd5YsaOuuhlMlRuwMgysVWVVvFDhI3gdBYdv9Ztmcxp5K+tkqJg/XY9OkE/AYMPDEd0w7clHYl2WFLLJ1gbMPYZrVsJ8KPyVassgfON/hHmPWZBarTqfQ3K7M71jQpGQwF5kTfJAvlS+X53ZYM1jSUQOHCSZu3YAwm4375Dv1J8r9JFivINs9d44pLnN1/ysVhSIKYHR22Yd5q4AY4qdtpUCxohMYEby2EOzBlnbvbgcIw47z/6u8R8lV5MWyyO0I=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <3D1E4611E4B0C94BB5917132287859EA@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: infinera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02f20ef1-70da-4b5a-217d-08d80d10b8ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2020 07:34:34.3706
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 285643de-5f5b-4b03-a153-0ae2dc8aaf77
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: But77j9HmodTPrzJvDV2YPGmY62W7qNC0MToiRoqfSgTqyiaROe5+dZjY2pwM8O5JwtPUhAe27YLVqg8/81cZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR10MB3252
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

T24gVHVlLCAyMDIwLTA2LTA5IGF0IDIzOjI2ICswMjAwLCBNYWFydGVuIEJyb2NrIHdyb3RlOg0K
PiANCj4gT24gMjAyMC0wNi0wOSAxNzowMSwgSm9ha2ltIFRqZXJubHVuZCB3cm90ZToNCj4gPiBP
biBUdWUsIDIwMjAtMDYtMDkgYXQgMTY6MjIgKzAyMDAsIGdyZWdraEBsaW51eGZvdW5kYXRpb24u
b3JnIHdyb3RlOg0KPiA+ID4gT24gVHVlLCBKdW4gMDksIDIwMjAgYXQgMDE6MTM6MDZQTSArMDAw
MCwgSm9ha2ltIFRqZXJubHVuZCB3cm90ZToNCj4gPiA+ID4gT24gVHVlLCAyMDIwLTA2LTA5IGF0
IDEzOjU3ICswMjAwLCBHcmVnIEtIIHdyb3RlOg0KPiA+ID4gPiA+IE9uIFR1ZSwgSnVuIDA5LCAy
MDIwIGF0IDExOjM4OjQ5QU0gKzAwMDAsIEpvYWtpbSBUamVybmx1bmQgd3JvdGU6DQo+ID4gPiA+
ID4gPiBIaSBMaXN0DQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IEkgd2FzIGFkdmlzZWQgdG8g
Y29tZSBoZXJlIHdpdGggdGhpcyBwcm9ibGVtKHN0YXJ0ZWQgb24gdGhlIFVTQiBsaXN0KS4NCj4g
PiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gV2UgaGF2ZSBhIFVTQiB0byBSUzIzMiBicmlkZ2Ugd2hp
Y2ggcHJlc2VudHMgaXRzZWxmIGFzIGFuIHR0eUFDTSBhbmQgdGhlIGZpcnN0IGNvbm5lY3QgYWZ0
ZXIgcG93ZXIgb24sDQo+ID4gPiA+ID4gPiB3ZSBzZWUgc29tZSBnYXJiYWdlIGNoYXJzIHRyYW5z
bWl0dGVkIGJhY2sgZnJvbSBVU0IgaG9zdChQQykgdG8gb3V0IGRldmljZSB3aGljaCBiZWNvbWVz
IGlucHV0IHRvDQo+ID4gPiA+ID4gPiB0aGUgZGV2aWNlLg0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+
ID4gPiBBZnRlciBtdWNoIGRlYnVnZ2luZyBJIGZvdW5kIHRoYXQgdGhpcyBhcmUgY2hhcnMgc2Vu
dCBlYXJseSBpbiB0aGUgYm9vdCBwcm9jZXNzIHdoaWNoIHRoZW4NCj4gPiA+ID4gPiA+IGFyZSBi
dWZmZXJlZCBhbmQgdGhlIFRUWXMgZGVmYXVsdCB0byBFQ0hPIGNoYXJzIGlzIHRoZSBjYXVzZS4N
Cj4gPiA+ID4gPiANCj4gPiA+ID4gPiBTbyBzb21lIHByb2dyYW0gaW4gdGhlIGJvb3Qgc2VxdWVu
Y2UgaXMgdHJ5aW5nIHRvIHNlbmQgZGF0YSBvdXQgdGhlDQo+ID4gPiA+ID4gZGV2aWNlPyAgV2h5
IG5vdCBqdXN0IG5vdCBkbyB0aGF0Pw0KPiA+ID4gPiANCj4gPiA+ID4gVGhpcyBpcyB0aGUgYm9v
dCBjb25zb2xlLiBCb3RoIHUtYm9vdCBhbmQgTGludXggcHJpbnRzIGEgbG90IHRoZXJlLCB0aGVu
IGluaXQgcHJpbnRzIHdoaWxlIHN0YXJ0aW5nIHNlcnZpY2VzDQo+ID4gPiANCj4gPiA+IFNvIHRo
ZSBzYW1lIGRldmljZSBpcyB1c2VkIGZvciBib290IGNvbnNvbGUgYXMgd2VsbCBhcyBhIHR0eUFD
TSBkZXZpY2UNCj4gPiA+IGxhdGVyIG9uPw0KPiA+IA0KPiA+IE5vdCBxdWl0ZSwgdGhlIFVTQiB0
byBSUzIzMiBjaGlwIGlzIGludGVncmF0ZWQgb24gdGhlIGRldmljZSBhbmQgaXMNCj4gPiBjb25u
ZWN0ZWQgdGhlIENQVXMgUlMyMzIsDQo+ID4gdGhlcmUgaXMgbm8gb3RoZXIgcG9ydC4NCj4gPiBJ
IHRoaW5rIHlvdSBjb3VsZCBjb21wYXJlIHdpdGggYW4gZXh0ZXJuYWwgVVNCIHRvIFJTMjMyIHB1
Y2suIFNlbmFyaW86DQo+ID4gLSBDb25uZWN0IHRoZSBwdWNrIHRvIGJvdGggY29tcHV0ZXIgYW5k
IHlvdXIgZGV2aWNlIHdpdGggYW4gUlMyMzIgcG9ydC4NCj4gPiAtIFBvd2VyIG9uIHRoZSBkZXZp
Y2Ugd2l0aCB0aGUgUlMyMzIgcG9ydC4NCj4gPiAtIERldmljZSAiYm9vdHMiIGFuZCBwcmludHMg
c3R1ZmYgb24gaXRzIFJTMjMyIHBvcnQsDQo+ID4gDQo+ID4gc29tZSB0aW1lIHBhc3Nlcw0KPiA+
IA0KPiA+IC0gT3BlbiB0dHlBQ00gaW4gUEMgdXNpbmcgbWluaWNvbS9jdQ0KPiA+IE5vdyBlYXJs
eSBoaXN0b3J5IG9mIHRoZSBib290IHByaW50cyBhcmUgZWNob2VkIGJhY2sgZnJvbSBQQyB0byBk
ZXZpY2UNCj4gPiB3aXRoIFJTMjMyDQo+IA0KPiBJdCBzb3VuZHMgbGlrZSBlaXRoZXIgdGhlIFVT
Qi1SUzIzMiBkZXZpY2Ugb3IgdGhlIHR0eUFDTSBkcml2ZXIgYXJlDQo+IGhvbGRpbmcNCj4gdGhl
IGluY29taW5nIGRhdGEgb3ZlciBSUzIzMiBldmVuIHRob3VnaCB0aGVyZSBpcyBubyBvcGVuIGNv
bm5lY3Rpb24NCj4gb3Zlcg0KPiBVU0IuIE15IGZpcnN0IHN1c3BpY2lvbiB3b3VsZCBiZSB0aGUg
VVNCLVJTMjMyIGRldmljZS4NCg0KSW4gdGhlb3J5IGl0IGNvdWxkIGJlIFVTQi1SMjMyIGNoaXAg
YnV0IEkgdGhpbmsgbm90LCBJIHRoaW5rIFVTQi1SUzIzMiBzZW5kcw0Kb3ZlciBjaGFycyBvbmNl
IHRoZSBjYWJsZSBpcyBjb25uZWN0ZWQgYW5kIGl0IGdldHMgc3RvcmVkIG9uIHRoZSBQQyBUVFkg
b3IgVVNCDQpkcml2ZXJzLg0KDQpJZiBJIGhhcmRjb2RlIEVDSE8gdG8gb2ZmIG9uIHRoZSBQQyBz
aWRlIGl0IHdvcmtzLCBidXQgdGhhdCBpcyBub3QgYSB2ZXJ5IHZpYWJsZSBzb2x1dGlvbi4gDQoN
Ckl0J3MgaXMgbm90IHRoZSBVU0IgQUNNIGRyaXZlciwgdGFsa2VkIHdpdGggT2xpdmVyKHRoZSBV
U0IgY2RjX2FjbSBtYWludGFpbmVyKSBhbmQgaGUNCmFza2VkIG1lZCB0byBnbyBoZXJlIGFzIGl0
IGxvb2tzIGxpa2UgYSBnZW5lcmFsIFRUWSBpc3N1ZS4NCg0KPiANCj4gQWxzbywgZG9lc24ndCBp
dCBoZWxwIHRvIG9wZW4gbWluaWNvbSB3aXRoIGVjaG8gb2ZmPw0KDQpObywgYmVjYXVzZSB0aGlz
IGhhcHBlbnMgYXQgb3BlbigpIGJlZm9yZSBvbmUgaGFzIGEgY2hhbmNlIHRvIHR1cm4gb2ZmIEVD
SE8uDQoNCj4gDQo+IE1hYXJ0ZW4NCj4gDQo+ID4gUFM6DQo+ID4gICAgIE9saXZlciwgcGxlYXNl
IGhlbHAgbWUgbWFrZSB0aGlzIGNsZWFyLiBZb3Ugc2VudCBtZSBoZXJlIDopDQo+ID4gDQo+ID4g
PiA+ID4gPiBXaGVuIHRoZSBUVFkgaXMgb3BlbmVkLCBhbnkgY2hhcnMgaW4gdGhlIHRoaXMgYnVm
ZmVyIGlzIEVDSE9lZCBiYWNrIG92ZXIgVVNCIHRvIHRoZSBkZXZpY2UsDQo+ID4gPiA+ID4gPiBi
ZWZvcmUgb25lIGhhcyBhIGNoYW5jZSB0byBkaXNhYmxlIEVDSE8uIFRoZSBkZXZpY2UgdGhlbiB0
aGlua3MgdGhlc2UgY2hhcnMgYXJlIHJlZ3VsYXIgaW5wdXQuDQo+ID4gPiA+ID4gDQo+ID4gPiA+
ID4gV2FpdCwgeW91IHNhaWQgc29tZXRoaW5nIGluIHRoZSBib290IHByb2Nlc3MgZGlkIHdyaXRl
IHRvIHRoZSBkZXZpY2UsDQo+ID4gPiA+ID4gd2hpY2ggd291bGQgaGF2ZSBjYXVzZWQgdGhlIHR0
eSB0byBiZSBvcGVuZWQgdGhlbiwgcmlnaHQ/DQo+ID4gPiA+IA0KPiA+ID4gPiB3ZWxsLCBib290
IHByb2Nlc3Mgb2YgdGhlIGRldmljZSBwcmludHMgYW5kIGl0IGlzIGVub3VnaCBmb3IgdGhlIFVT
QiBjYWJsZSB0byBiZSBhdHRhY2hlZCBidXQgbm90IG9wZW5lZCBieSBhbnkgYXBwLg0KPiA+ID4g
PiBUaGUgZGV2aWNlIGp1c3Qgc2VlIGFuIFVBUlQgYW5kIHByaW50cyB3aGVuIFVBUlQgaXMgaW5p
dGlhbGl6ZWQuDQo+ID4gPiANCj4gPiA+IFdoYXQgdG9vbCBkb2VzIHRoYXQ/ICBXaHkgbm90IGZp
eCB0aGF0Pw0KPiA+ID4gDQo+ID4gPiA+ID4gPiBTZWVtcyB0byBtZSB0aGF0IHRoaXMgYmVoYXZp
b3VyIGlzIHVud2FudGVkIGluIGdlbmVyYWwgYW5kIGFuZCBhcHAuIHNob3VsZCBnZXQgYSBjaGFu
Y2UgdG8gZmx1c2gvZGlzY2FyZA0KPiA+ID4gPiA+ID4gYW55IGNoYXJzIHNvIHRoaXMgZG9lcyBu
b3QgaGFwcGVuLg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IFdoZXJlIGFyZSB0aGUgY2hhcmFjdGVy
cyBjb21pbmcgZnJvbSB0aGF0IHdvdWxkIG5lZWQgdG8gYmUgZmx1c2hlZD8NCj4gPiA+ID4gDQo+
ID4gPiA+IEVhcmx5IG91dHB1dCBmcm9tIGJvb3QsIGJhc2ljYWxseSB3aGF0ZXZlciBwcmludHMg
anVzdCBhZnRlciBjb25uZWN0aW5nIHRoZSBVU0IgY2FibGUuDQo+ID4gPiANCj4gPiA+IFRoZW4g
ZG9uJ3QgaGF2ZSBib290IHByaW50IHRvIHRoYXQgZGV2aWNlIDopDQo+ID4gPiANCj4gPiA+ID4g
PiBXaGVuIHNob3VsZCBjaGFyYWN0ZXJzIGJlIGZsdXNoZWQgZXhhY3RseT8NCj4gPiA+ID4gDQo+
ID4gPiA+IFdoYXRldmVyIGlzIGluIHRoZSBidWZmZXJzIGJlZm9yZSBvcGVuaW5nIHRoZSB0dHku
DQo+ID4gPiANCj4gPiA+IEJ1dCB3aGF0IGlzIHN1cHBvc2VkIHRvIGhhcHBlbiB0byB0aGUgZGF0
YSB0aGF0IHdhcyBzZW50IHRvIGl0IHdoaWxlDQo+ID4gPiBpdA0KPiA+ID4gd2FzICJjbG9zZWQi
Pw0KPiA+ID4gDQo+ID4gPiA+IFRoZSB0ZXJtaW5hbCBhcHAobGlrZSBjdSkgdHJpZXMgdG8gZmx1
c2ggYW55IGlucHV0IHdoZW4gaXQgc3RhcnRzLCBqdXN0IHRvIGF2b2lkIGFueSBvbGQgY2hhcnMg
aW4gdGhlDQo+ID4gPiA+IHF1ZXVlIGJ1dCBpdCBpcyB0byBsYXRlIHRoZW4uDQo+ID4gPiANCj4g
PiA+IEkgc3Ryb25nbHkganVzdCBzdWdnZXN0IGhhdmluZyB1c2Vyc3BhY2Ugbm90IHdyaXRlIHRv
IHRoZSBkZXZpY2UgdG8NCj4gPiA+IHN0YXJ0IHdpdGgsIHRoYXQgd291bGQgc29sdmUgdGhpcywg
cmlnaHQ/DQo+ID4gDQo+ID4gSXQgaXMgbm90IHVzZXIgc3BhY2UsIGl0IGlzIHRoZSBzZXJpYWwg
ZHJpdmVyIGluIGtlcm5lbCB3cml0aW5nIHRoaXMNCj4gPiBiYWNrIGF1dG9tYXRpY2FsbHkuDQo+
ID4gDQo+ID4gIEpvY2tlDQo+ID4gDQo+ID4gPiB0aGFua3MsDQo+ID4gPiANCj4gPiA+IGdyZWcg
ay1oDQoNCg==
