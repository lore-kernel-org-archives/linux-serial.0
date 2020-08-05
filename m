Return-Path: <SRS0=nzNS=BP=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89A99C433DF
	for <linux-serial@archiver.kernel.org>; Wed,  5 Aug 2020 03:52:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 550CB22B40
	for <linux-serial@archiver.kernel.org>; Wed,  5 Aug 2020 03:52:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="g3ycNW8+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726027AbgHEDwV (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 4 Aug 2020 23:52:21 -0400
Received: from mail-am6eur05on2078.outbound.protection.outlook.com ([40.107.22.78]:63616
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725904AbgHEDwT (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 4 Aug 2020 23:52:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VbC/wp+yQnk3yDUy/CR+4WMu8NAkfsXgyh9m4pmZUlfLde3IIA+tGHcs/NFQ1MANEd8cq4M6TbsCaSv6fGW3leIZZWKdfpLT/1PSstE5uef1hbV5TI2V7Nr++LZTuQsGGKCXknk+VtI20Sqgh+k1pDHaDWVU7FuwwSHQeylFr+NeR0m/s5GsBQtrx4TmcHTF5pKEnnB9mMTphZY4wEXL7u8ZMN85Z3e+WydeugbyqcOAHW9zP1ccjeACOJg8ns/JrxZXZbteO9FBz9YDf/0HItbWiNo/e4iDZ+0leDMWVy96wkX1JQs1+u82++ODQKjtq8UDhPUSM6Q/qkP6i8hPRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qR2SIJW/0ejMmyMoVERcDQ+8/sNa8UnFnUtJJ1Xp0ls=;
 b=g1SfelTOJfOSR+K1d6FnVQRwzO7f3k9ub0ukcP+hRqVD5BKTeN0rNBhb+tqljf+htZT/iJlTqw62ms4csQIMHsfS30Q0AoCIV0iIxuVB1eGD9Hik9KS0Rk9+pwuoZqbn/7x2ws4JbF5dfeZ10AEIitSuxXd63sk5TnrkLW3n6Mz3/XLXRshuRHkkKuPc1CfsmF1pAuD3qk5lOVHTvAkjUjuBppKEfqFna1LBgq4nDo05UzK/ZiXypENIpnagpTS2dPd34yUQBUeHYTsG7J1aTNKZlctYOce1AsbJAAtgX7edskgiwIKVPKgVCzTHyJpsVF9neH6ihCE90sps4ElPBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qR2SIJW/0ejMmyMoVERcDQ+8/sNa8UnFnUtJJ1Xp0ls=;
 b=g3ycNW8+Swr4JMCaGMCFaRhkR3PyjXz4hrgJME3HxH3ij49rfUEDRADTY8KH337QrS4sq7hsYhMsvxrLyNAgqcjepdG9rJXzqxMRufErIXSrTd67JXvbt8SkHyFf/j4jf+DQTmSURNLQYAWTOZXLPOQDeaJv2t1/KTixPyRqmPY=
Received: from AM6PR0402MB3607.eurprd04.prod.outlook.com
 (2603:10a6:209:12::18) by AM7PR04MB6968.eurprd04.prod.outlook.com
 (2603:10a6:20b:dc::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.20; Wed, 5 Aug
 2020 03:52:15 +0000
Received: from AM6PR0402MB3607.eurprd04.prod.outlook.com
 ([fe80::75d9:c8cb:c564:d17f]) by AM6PR0402MB3607.eurprd04.prod.outlook.com
 ([fe80::75d9:c8cb:c564:d17f%5]) with mapi id 15.20.3261.016; Wed, 5 Aug 2020
 03:52:15 +0000
From:   Andy Duan <fugang.duan@nxp.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Greg KH <gregkh@linuxfoundation.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Lukas Wunner <lukas@wunner.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Jiri Slaby <jslaby@suse.com>
Subject: RE: [EXT] Re: [PATCH tty/serial v3 2/2] tty: serial: imx: add imx
 earlycon driver
Thread-Topic: [EXT] Re: [PATCH tty/serial v3 2/2] tty: serial: imx: add imx
 earlycon driver
Thread-Index: AQHWYYpUoNUEN1E9XUm5EHAJWMHWnKkn9SYAgAD/PmA=
Date:   Wed, 5 Aug 2020 03:52:15 +0000
Message-ID: <AM6PR0402MB36079D1B1A77678BF3BD4367FF4B0@AM6PR0402MB3607.eurprd04.prod.outlook.com>
References: <20200724070815.11445-1-fugang.duan@nxp.com>
 <20200724070815.11445-3-fugang.duan@nxp.com>
 <CAMuHMdUJw1rqzNMUduE0qVO=f1dBuXGMf+vcgkhRkc-x-4TAvg@mail.gmail.com>
In-Reply-To: <CAMuHMdUJw1rqzNMUduE0qVO=f1dBuXGMf+vcgkhRkc-x-4TAvg@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux-m68k.org; dkim=none (message not signed)
 header.d=none;linux-m68k.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b3b4cca4-c011-4a66-b2cb-08d838f2f140
x-ms-traffictypediagnostic: AM7PR04MB6968:
x-microsoft-antispam-prvs: <AM7PR04MB69688EF7C5CCFF3AE4F0892AFF4B0@AM7PR04MB6968.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: P48Wbt+9Xmjo/P2TxHiliZWVJQwuDfOQxCTCyxwIqgO3Tk0UHWyqyrBEy2SAGg3l4dqHm5IK3GqSxX80+Gllg+GZQKoZUhA58xNTAC2ab7viipOh9ibob5KJxAdwrdMvKKGSnOT54UC2mtIt7vjnD1v4WM0NDvihLxj1sva9ZspATsS+Mgep5qR4bwFJR93BRYL2aEkZFuHbiNcDJmsw0xL5z6PS7oZg5oc3vfr7yuFgdT8ojsIsv6PIiz9l9tpImalrHeXKJzyZxv+UwuUMTtpRYDzFYf55E/cnYWXyxWlx7OUeoy+Sp8uvg+FDiJuvLhhYO8v4aRNe/iYXUT2zlQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR0402MB3607.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(396003)(39860400002)(346002)(376002)(366004)(9686003)(6506007)(7696005)(316002)(83380400001)(5660300002)(8676002)(76116006)(6916009)(66946007)(478600001)(71200400001)(55016002)(26005)(66446008)(4326008)(66556008)(8936002)(66476007)(53546011)(86362001)(33656002)(2906002)(186003)(64756008)(54906003)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 8SiCUvOA0ovOGO+b1k6AGykSW8SWXGu6hqgRchxS+PpPMKimjZ2pYy4KrPGUjGb4rAK33f+mjip87PIfE24L6DDL7D/s5ai9hNA/KxZw164jwSTDfXjpq2Hjv7sg9VxGviF5kjMQhX9gwbbdik6mLx/qSDRxEu2LNfVVOgvgHDFHbahU8F2gVXs/yup/vXlZfNdMYIu8SpCUmvrjAa0sNx5ul0lKWyElfY0kAYmPbtccKQERT1reCRVZXee//lHlQsbgwJqP6awKZ+ff7gX/KwlsXjbKNpPIuS66z/0BZBGWF2vbfITdKokfrAEbmZVlTZdyfAS//SpEfi3mGJ+UX7/xOd3fOGsMxRYSfUltCd8D0X7N/jp+G42lZU4GT45WXgZp3OglJQF5ZZzFcq5rOv0JwK8zxixSFUtUum0K6SoICymmfEmMxN9pmCHgrqFKMqD4DU7/5AnDrf7XDCuzmZfUUQjM/qu3ZC76lTLoFXvnKlKZ3eMbfVUijs+mzsYl/bj2IvNAV4XPsR9dD+F/H3gYv5wlLlFUILROGH4GXNF3aZRpidMMTUR+bHsu/2BK4WlhkhNNjuxkoK4nHKr0cJsHstswhub2CdLFXuZ+TOfKs/P9Ai7Xnyt1NXXINn4GasSBdhmajuqUsieYzJzWhg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR0402MB3607.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3b4cca4-c011-4a66-b2cb-08d838f2f140
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2020 03:52:15.3105
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5QmLJLfjNKXwSxuURhu/ksrVav0GC2CFik5c3dNa8Xsy254ibcFVGqwo4eriHhElDWO6HN8ahfdosl2bZxzP0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6968
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

RnJvbTogR2VlcnQgVXl0dGVyaG9ldmVuIDxnZWVydEBsaW51eC1tNjhrLm9yZz4NCj4gSGkgRnVn
YW4sDQo+IA0KPiBPbiBGcmksIEp1bCAyNCwgMjAyMCBhdCA5OjE3IEFNIEZ1Z2FuZyBEdWFuIDxm
dWdhbmcuZHVhbkBueHAuY29tPiB3cm90ZToNCj4gPiBTcGxpdCBpbXggZWFybHljb24gZHJpdmVy
IGZyb20gaW14IHNlcmlhbCBkcml2ZXIgImlteC5jIiBhcyBzZXBhcmF0ZWQNCj4gPiBkcml2ZXIu
IGlteCBzZXJpYWwgZHJpdmVyIGNhbiBiZSBidWlsdCBhcyBtb2R1bGUsIGJ1dCBlYXJseWNvbiBk
cml2ZXINCj4gPiBvbmx5IHN1cHBvcnQgYnVpbGQgaW4uDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5
OiBGdWdhbmcgRHVhbiA8ZnVnYW5nLmR1YW5AbnhwLmNvbT4NCj4gDQo+IFRoYW5rcyBmb3IgeW91
ciBwYXRjaCwgd2hpY2ggaXMgbm93IGNvbW1pdCA2OTljYzRkZmQxNDA3MWU0ICgidHR5OiBzZXJp
YWw6DQo+IGlteDogYWRkIGlteCBlYXJseWNvbiBkcml2ZXIiKSBpbiB0dHktbmV4dC4NCj4gDQo+
ID4gIGRyaXZlcnMvdHR5L3NlcmlhbC9LY29uZmlnICAgICAgICB8ICA4ICsrKysrDQo+ID4gIGRy
aXZlcnMvdHR5L3NlcmlhbC9pbXhfZWFybHljb24uYyB8IDUwDQo+ID4gKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKw0KPiANCj4gU2VlbXMgbGlrZSBpbXhfZWFybHljb24uYyBpcyBuZXZl
ciBidWlsdCwgYXMgbm8gTWFrZWZpbGUgdXBkYXRlIGlzIGluY2x1ZGVkPw0KPiBFbHNlIHRoaXMg
cGF0Y2ggaXMganVzdCBhbiBvYmZ1c2NhdGVkIHdheSB0byBlbmFibGUgU0VSSUFMX0VBUkxZQ09O
IGZvciBhbGwgT0YNCj4gcGxhdGZvcm1zPyA7LSkNCj4gDQo+ID4gLS0tIGEvZHJpdmVycy90dHkv
c2VyaWFsL0tjb25maWcNCj4gPiArKysgYi9kcml2ZXJzL3R0eS9zZXJpYWwvS2NvbmZpZw0KPiA+
IEBAIC01MTUsNiArNTE1LDE0IEBAIGNvbmZpZyBTRVJJQUxfSU1YX0NPTlNPTEUNCj4gPiAgICAg
ICAgICAgImNvbnNvbGU9dHR5bXhjMCIuIChUcnkgIm1hbiBib290cGFyYW0iIG9yIHNlZSB0aGUN
Cj4gZG9jdW1lbnRhdGlvbiBvZg0KPiA+ICAgICAgICAgICB5b3VyIGJvb3Rsb2FkZXIgYWJvdXQg
aG93IHRvIHBhc3Mgb3B0aW9ucyB0byB0aGUga2VybmVsIGF0DQo+ID4gYm9vdCB0aW1lLikNCj4g
Pg0KPiA+ICtjb25maWcgU0VSSUFMX0lNWF9FQVJMWUNPTg0KPiA+ICsgICAgICAgYm9vbCAiRWFy
bHljb24gb24gSU1YIHNlcmlhbCBwb3J0Ig0KPiA+ICsgICAgICAgZGVwZW5kcyBvbiBPRg0KPiAN
Cj4gT2J2aW91c2x5IHRoaXMgc2hvdWxkIGRlcGVuZCBvbiAiQVJDSF9NWEMgfHwgQ09NUElMRV9U
RVNUIi4NCg0KSSB3aWxsIHN1Ym1pdCBhbm90aGVyIHBhdGNoIGZvciBpdC4NClRoYW5rcyENCj4g
DQo+ID4gKyAgICAgICBzZWxlY3QgU0VSSUFMX0VBUkxZQ09ODQo+ID4gKyAgICAgICBoZWxwDQo+
ID4gKyAgICAgICAgIElmIHlvdSBoYXZlIGVuYWJsZWQgdGhlIGVhcmx5Y29uIG9uIHRoZSBGcmVl
c2NhbGUgSU1YDQo+ID4gKyAgICAgICAgIENQVSB5b3UgY2FuIG1ha2UgaXQgdGhlIGVhcmx5Y29u
IGJ5IGFuc3dlcmluZyBZIHRvIHRoaXMgb3B0aW9uLg0KPiA+ICsNCj4gPiAgY29uZmlnIFNFUklB
TF9VQVJUTElURQ0KPiA+ICAgICAgICAgdHJpc3RhdGUgIlhpbGlueCB1YXJ0bGl0ZSBzZXJpYWwg
cG9ydCBzdXBwb3J0Ig0KPiA+ICAgICAgICAgZGVwZW5kcyBvbiBIQVNfSU9NRU0NCj4gDQo+IEdy
e29ldGplLGVldGluZ31zLA0KPiANCj4gICAgICAgICAgICAgICAgICAgICAgICAgR2VlcnQNCj4g
DQo+IC0tDQo+IEdlZXJ0IFV5dHRlcmhvZXZlbiAtLSBUaGVyZSdzIGxvdHMgb2YgTGludXggYmV5
b25kIGlhMzIgLS0gZ2VlcnRAbGludXgtbTY4ay5vcmcNCj4gDQo+IEluIHBlcnNvbmFsIGNvbnZl
cnNhdGlvbnMgd2l0aCB0ZWNobmljYWwgcGVvcGxlLCBJIGNhbGwgbXlzZWxmIGEgaGFja2VyLiBC
dXQgd2hlbg0KPiBJJ20gdGFsa2luZyB0byBqb3VybmFsaXN0cyBJIGp1c3Qgc2F5ICJwcm9ncmFt
bWVyIiBvciBzb21ldGhpbmcgbGlrZSB0aGF0Lg0KPiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIC0tIExpbnVzIFRvcnZhbGRzDQo=
