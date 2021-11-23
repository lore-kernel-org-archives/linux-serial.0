Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C97BBC433F5
	for <linux-serial@archiver.kernel.org>; Tue, 23 Nov 2021 08:41:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234938AbhKWIo3 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 23 Nov 2021 03:44:29 -0500
Received: from mail-eopbgr00065.outbound.protection.outlook.com ([40.107.0.65]:9093
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233911AbhKWIo2 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 23 Nov 2021 03:44:28 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gv/wINgNDTxRBlwzIC9tczjkklbTmG2utjJuz19SE8FewlbToJhRd1DISSPa8aKmBaQ5kduL/Guoy3R/Z6UD7Vov4MPU/4IPBfVOqpnD+tR5+UhPIZUILHsXVC+jpuookDta4Dx2Ek2bT42jU+wdkHevdnfW9a52B6JchB2Hg4QYowWlcMCWvZDU4wwzt3AA/gejZek6Z6W6FWQIGc4iE8ZpBPsYgggOvmW1tVtq8JMk5kqq8QDu2xL2jperlgLDJcrCHvK4mKN0ZiGQy5Va63cvhest9rkT/HW2L3Ysn2iewhIdkHs6HMj2Ir1IuXTPyEZAf+QCH63LmXRrjf/QcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nHURb7XGk7QW6qMwbh5za5BcybAi0gOkwQqvvSHgNCo=;
 b=P7BibolIkBVsa0Zso4FwG0624acskudpAs8Fn+BF9ePIHb9pwR4IixX64oak3uysTrJrkYOUw1ffK0X+mgeb/Y4iNnrZWhfphDuBMzWTvSZKjlOLTf1MyHlBPragAVaGyQcK0tuL4Yq2ybJA3/ohhfVv82yRpK3fT05vBYGorgX075rRIIcAW6O66Yp41/PwpmlnXqOJpEiqJCEniyue5CinmgZDIgBNc/Nq4O24703z0du2tbq9wSqWR6+5EzmyfwISFxttShSDNPEWq7DE/m69uonfpqmzbKKexL+LqjgELhu6JbF+LIQzFs9hV+Q1d8j1efLmQgrU2lpFOqYd1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nHURb7XGk7QW6qMwbh5za5BcybAi0gOkwQqvvSHgNCo=;
 b=M0wgOJbctvF6tFtlmFECHXQS9HdRLo8fQHXra+ksWIsnrh7fU5gfg+1GYgGaRASfeAVz3BVHQIg61ZVjTjql1ZPcrtTB+KSMADS+P0RbJwDJqfVuqVNAfbTdgGp1JWkghB5YHMicywtkpU3K7x4dS+/xZ6BgLQIA/5nyEv6UCow=
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by AM6PR0402MB3687.eurprd04.prod.outlook.com (2603:10a6:209:19::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.24; Tue, 23 Nov
 2021 08:41:18 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::c9fe:7982:c657:b423]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::c9fe:7982:c657:b423%9]) with mapi id 15.20.4713.025; Tue, 23 Nov 2021
 08:41:18 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= 
        <u.kleine-koenig@pengutronix.de>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "jirislaby@kernel.org" <jirislaby@kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH] tty: serial: imx: clear RTSD status before suspend
Thread-Topic: [PATCH] tty: serial: imx: clear RTSD status before suspend
Thread-Index: AQHX4Di5uwn240l5kk6yGHp0V2/UCKwQuteAgAAOOFA=
Date:   Tue, 23 Nov 2021 08:41:18 +0000
Message-ID: <AS8PR04MB84047408AEC087EB16B6981F92609@AS8PR04MB8404.eurprd04.prod.outlook.com>
References: <20211123070349.20099-1-sherry.sun@nxp.com>
 <20211123074219.wn5jfjr6ph7uutyo@pengutronix.de>
In-Reply-To: <20211123074219.wn5jfjr6ph7uutyo@pengutronix.de>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b2fbd679-8e86-4d56-0a80-08d9ae5d04d3
x-ms-traffictypediagnostic: AM6PR0402MB3687:
x-microsoft-antispam-prvs: <AM6PR0402MB3687F7E42DEF38FE930088CE92609@AM6PR0402MB3687.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tdr+t60wn1ppT89QV5UntxyHAe3OAPomnKq5CcTCzRsjVblCAPf8wyDC0cJgTTdcYq+kErCrHHPEzqVbigiDYV77wPDgmTbFh2jhQkE+cTdHQ3lXjdrGfp4YeurDDgPeA1+NIZnKEHievIuHuSpqnb23oGehBdr6q3RGxhf3MUWRkRL8rplGuRorGkZibrrBMrTM9k4wcHxRh7zjahC09LbR65MEBeW9OcdfWk5CRQoOVoh3tVhqXwesXDVGclgb6D7T54Bo/JBspmYc1Gk5hYoKyWf+Si5h3gGDon1zZC6DRe2mMk2R8s6V1HGq0siKZgQ6xQKuSyau80Y3UoZvTflzCkfVM6Oal/+DDsk8Uap5yQ3fC4PUpGFLDdkjDqOumrauuPR2pw96TX9zn7yNOf1stM5Ua0RUAPueNL8jHS2zDQs7y5e1nO0ukX5huxm4GYDgHnr8ePXc94xve2ajQsqcrnmMza3cTrkfdQsnwxrQZNm68cJRTam5wgTneJIE/XUQGyPUdxdIHTL14GZ1COGMsMsjWegX6C8IaXBpawelVgATVc1w98kt9sWt8rCkUQJPf1GUnA612+/8U5iQI+sbUouIxg0+nFpprOXPVJdnuiiAOxO7gbFtTYGcV6BURUMuI6t+EwV4J2by3CgjR49FUO0hf3vCJcxvOOKcR1dKZL0BP8h/ddlKXcacHonyXvFadGTmQy8h037Q7tpkm71pbA1ZpNZD1cj6jG7qlQNtl0dOPCcZESICiUMs3idXizKUtSYccyIfPLKtHh1jHVe2bsrzDiJz7Xi1/0ZdllsoM7UFA7SFUk0aAqsEMxVZW+KkQv2EWqxMSpHxu4E6Rg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8676002)(5660300002)(38100700002)(7696005)(66446008)(26005)(9686003)(76116006)(86362001)(122000001)(66946007)(15650500001)(38070700005)(66574015)(2906002)(83380400001)(55016003)(71200400001)(33656002)(6916009)(966005)(54906003)(508600001)(44832011)(8936002)(316002)(6506007)(52536014)(4326008)(64756008)(66556008)(186003)(66476007)(53546011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MzNUbmpmck8xcTNTMFppeEI2VkhwbkxVam1mTHpCRTBtL2RDMnNVRWVlQnha?=
 =?utf-8?B?T2FNckp6ai9wZUNTa0NNWUdteFozQ1I1SVNFRVpQalFJREhUb2xQUHl4MTdo?=
 =?utf-8?B?U0N6SkFCRDE4TkxwWkJJUlluVkZybFc4SitJM2pWQUNoUkg3Y2VZdXNabDFQ?=
 =?utf-8?B?L0hnMXc2UDB6MEdNKzEvOUkzekQ3b3JUWStXbkpsK3UrUW1uR1oxMzFvVE9p?=
 =?utf-8?B?YlVVNUhicjlQTDBlVlhjRFh6a0twc2x4Y1VHcUJlZUt3SGtEOVVwMFBHeDU2?=
 =?utf-8?B?TDEzYTNFMUc4TW9GSHhNcUpkVjZpcWtldUxpcERwSWJOWG1OWjFwMnhiSmVU?=
 =?utf-8?B?Y3M3bUVXZFpPcWFzL0QxRVN6cTBwYzBFWStEMU1TQytVRHJTaXFpTWV1Mzkw?=
 =?utf-8?B?bFRBRUFYYlBuVkV3c1BUK3c1Qi9NUHZ3aHVHTForQzBKREt5WlBFOS9wY0ly?=
 =?utf-8?B?VGc0dldEWmV5ZTN2V3lZK3RMYlZKd2lsYzNEOW5Gcms3cUdIN3RTSUJzU3gr?=
 =?utf-8?B?c3kxQjEyR0xBOTBId0tFUnc4UFlORnpvQS85algwNW5WbTljWGZ0MzZiSEFs?=
 =?utf-8?B?aUUxdzFRVjJhQk03TWtiM0dOeTE3TnpjNWErT2RSNU11SGFxNWR3bE95dkVy?=
 =?utf-8?B?YzZmVEpvQ0JIcG9YVlkrcFoxR2pDeHBWLzdQSExZalFFalBRTGE1Z2ZoNWNX?=
 =?utf-8?B?Zy92RTRLNE1ocVkvOFFUVWtqQ1Y4RDRHTThad3hmQWhFTGl1RGg4WjJLOWhY?=
 =?utf-8?B?WHJDQ1VRaWkxNnZzbnkwVloyY1Z0Ynh1SEFPOWNVRkd1WFBPNmtjWWIzOFZx?=
 =?utf-8?B?OTdWeXNoV3ZNaDV3TTBrYmV6WFJkRS9LaG1RbFNQS1R4SVN2clpybnNrRnNN?=
 =?utf-8?B?dE5IUzBnMmVvUjZNTVI5bm5KMTJWM3ZYZVpqNU4vWlJmbDJTanBMbDRaWmsw?=
 =?utf-8?B?T1U1dHRVdlRFNDRWZUpNZkpCUnRYSThFdmdnQUVya0JsNVN5WXRXTU5rRXRu?=
 =?utf-8?B?a0xBeWJ5dWhDTEM0Zmh0aHM3Z3FpbHYvdG1taUl5akdwUWFLbHFiOHFwbDVL?=
 =?utf-8?B?UERUUVJ1S2owenBXZndPR0hheEwydHQxcWNlZXVUQUpUZHVxYzZKbitHdG8x?=
 =?utf-8?B?MUE5OEJzVWdFMnFPaWwwcnZ4OGR5SHZJelgxYng2cm1ZSzhESUxrTEtqSDhz?=
 =?utf-8?B?d0ZacmlCZVBzMTJJc3ZZNVhSUzd0Q0ZrdVdmaW1DY2NyWFlnV1dqaW1tSTlo?=
 =?utf-8?B?VURCOStTS1k2MURHUEFQRVNHMS9CVWIrUDdVSUF2TDEvdGh1c0YrRGZqME4z?=
 =?utf-8?B?UXdtVkNGWno4RFVtL0x4N2c5eGNwbW56TG5qalpuUXBSWTFRbnA2ODFURkh2?=
 =?utf-8?B?R3U2NXJ3REptV1BZRExtNlBWWHZQOE8rRXJTdzVGNE5JRU5vTjBvdzd4eXI3?=
 =?utf-8?B?a1RVc1k5d0k0YWdKbTdrdW9tWDBqcWtRK2ZCOVdaNmdnd2xQcVI5dkZ6YVVy?=
 =?utf-8?B?YUVBOWNpMFdmc042SXUrdlJPdGVOcUVMV3BCU1N4RURtL0FYMk02ajlQdkM5?=
 =?utf-8?B?M0tiWm1IZXRNTkxPYi8yM1V4Vlczbkd3b09DcG41TzZNalpVaXdROXRNQU5S?=
 =?utf-8?B?S3ZMZHI3U1lwcTJ1T1dINTB3c1dGSWVDN3FPZHRvUVJLS25teEtxUG81YWlD?=
 =?utf-8?B?MFBKYkowMWw3YTg2REUvc1FYMW5lZUVZUzZmT1lvYWhISncyUmYzSy9oenVj?=
 =?utf-8?B?b25NekVOMG5FUStDdVVuRVRmclBtZG9adWhnSFQzYi9DelRMWmphL0RlUHVD?=
 =?utf-8?B?ZHNhVzBKSnFOenVzMjUrcGZ2S3kxcE5pRXh4bUp1dEhtem1qemcxUENEK2M3?=
 =?utf-8?B?a0Y3Z01hRXQyTHZmUTZHUlprSmhsbCtENEx2MCtMV2ltR1BRbC92QXhhczAw?=
 =?utf-8?B?ei9VRHFjSGQyUUtDd3FoMUk5TmpHN3VKWm1kNUFvU1BKcVZ3U3RQcngxVmtq?=
 =?utf-8?B?cld1YXpXeFpqa3dNbmxjK3dFTFh2Yk5HU0lxZ0VRNHpwVUpYUTgvS0tsNHB2?=
 =?utf-8?B?dDNNQVVoc1BUTGVhdFBWUVFYNlZMUzNSMmFEdWl4RmVkY29EQUl5VEszaUtS?=
 =?utf-8?B?aVU4V0pZVXp3dDFNbDl4WHdrOVNaV3docHU0NGFUYWN3QnZRVUZ2Nktib01T?=
 =?utf-8?B?bFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2fbd679-8e86-4d56-0a80-08d9ae5d04d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2021 08:41:18.4104
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kYEnQNbpYyUI+PsbJ1zoLX0UJa3s6hyXLWb/Rl1RmRtcmr6Z0BTyeaTqoKPtpK4YC5HEh91hfADjoFKHPeTycg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3687
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

SGkgVXdlLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFV3ZSBLbGVp
bmUtS8O2bmlnIDx1LmtsZWluZS1rb2VuaWdAcGVuZ3V0cm9uaXguZGU+DQo+IFNlbnQ6IDIwMjHl
ubQxMeaciDIz5pelIDE1OjQyDQo+IFRvOiBTaGVycnkgU3VuIDxzaGVycnkuc3VuQG54cC5jb20+
DQo+IENjOiBncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZzsgamlyaXNsYWJ5QGtlcm5lbC5vcmc7
IGxpbnV4LQ0KPiBzZXJpYWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJu
ZWwub3JnOyBkbC1saW51eC1pbXggPGxpbnV4LQ0KPiBpbXhAbnhwLmNvbT4NCj4gU3ViamVjdDog
UmU6IFtQQVRDSF0gdHR5OiBzZXJpYWw6IGlteDogY2xlYXIgUlRTRCBzdGF0dXMgYmVmb3JlIHN1
c3BlbmQNCj4gDQo+IE9uIFR1ZSwgTm92IDIzLCAyMDIxIGF0IDAzOjAzOjQ5UE0gKzA4MDAsIFNo
ZXJyeSBTdW4gd3JvdGU6DQo+ID4gRnJvbTogRnVnYW5nIER1YW4gPGZ1Z2FuZy5kdWFuQG54cC5j
b20+DQo+ID4NCj4gPiBDbGVhciBSVFNEIHN0YXR1cyBiZWZvcmUgc3VzcGVuZCBkdWUgdG8gdGhl
IHBvcnQgYWxzbyB1c2UgUlRTIHBpbiBhcw0KPiA+IHdha2V1cCBzb3VyY2UsIG5lZWQgdG8gY2xl
YXIgdGhlIGZsYWcgZmlyc3QuDQo+IA0KPiBJJ2Qgd3JpdGU6DQo+IA0KPiAJQ2xlYXIgUlRTRCBz
dGF0dXMgYmVmb3JlIGVuYWJsaW5nIHRoZSBpcnEgZXZlbnQgZm9yIFJUU0QuDQoNClRoYW5rcyBm
b3IgdGhlIHN1Z2dlc3Rpb24sIEkgd2lsbCByZW9yZ2FuaXplIHRoZSBjb21taXQgbWVzc2FnZSBh
bmQgc2VuZCBWMi4NCg0KPiANCj4gVGhhdCB0aGlzIGhhcHBlbnMgaW4gdGhlIGNvbnRleHQgb2Yg
c3VzcGVuZCBpc24ndCB0aGF0IGltcG9ydGFudC4NCg0KU29ycnkgSSBkaWRuJ3QgZ2V0IHRoZSBw
b2ludCBoZXJlLCBjYW4geW91IHBsZWFzZSBleHBsYWluIG1vcmU/DQpQZXIgbXkgdW5kZXJzdGFu
ZGluZywgdGhlIHdha2V1cCBzb3VyY2UgaW50ZXJydXB0IGlzIGhhbmRsZWQgaW4gdGhlIHN1c3Bl
bmQgY29udGV4dCwgc28gY2xlYXIgdGhlIGZsYWcgaW4gdGhlIHN1c3BlbmQgY29udGV4dCBpcyBh
bHNvIG5lY2Vzc2FyeS4NCg0KQmVzdCByZWdhcmRzDQpTaGVycnkNCg0KPiANCj4gPiBTaWduZWQt
b2ZmLWJ5OiBGdWdhbmcgRHVhbiA8ZnVnYW5nLmR1YW5AbnhwLmNvbT4NCj4gPiBTaWduZWQtb2Zm
LWJ5OiBTaGVycnkgU3VuIDxzaGVycnkuc3VuQG54cC5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZl
cnMvdHR5L3NlcmlhbC9pbXguYyB8IDYgKysrKy0tDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA0IGlu
c2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy90dHkvc2VyaWFsL2lteC5jIGIvZHJpdmVycy90dHkvc2VyaWFsL2lteC5jIGluZGV4DQo+ID4g
OTBmODJlNmM1NGU0Li5mYjc1ZTNlMGQ4MjggMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy90dHkv
c2VyaWFsL2lteC5jDQo+ID4gKysrIGIvZHJpdmVycy90dHkvc2VyaWFsL2lteC5jDQo+ID4gQEAg
LTI0ODIsMTAgKzI0ODIsMTIgQEAgc3RhdGljIHZvaWQgaW14X3VhcnRfZW5hYmxlX3dha2V1cChz
dHJ1Y3QNCj4gPiBpbXhfcG9ydCAqc3BvcnQsIGJvb2wgb24pDQo+ID4NCj4gPiAgCWlmIChzcG9y
dC0+aGF2ZV9ydHNjdHMpIHsNCj4gPiAgCQl1MzIgdWNyMSA9IGlteF91YXJ0X3JlYWRsKHNwb3J0
LCBVQ1IxKTsNCj4gPiAtCQlpZiAob24pDQo+ID4gKwkJaWYgKG9uKSB7DQo+ID4gKwkJCWlteF91
YXJ0X3dyaXRlbChzcG9ydCwgVVNSMV9SVFNELCBVU1IxKTsNCj4gPiAgCQkJdWNyMSB8PSBVQ1Ix
X1JUU0RFTjsNCj4gPiAtCQllbHNlDQo+ID4gKwkJfSBlbHNlIHsNCj4gPiAgCQkJdWNyMSAmPSB+
VUNSMV9SVFNERU47DQo+ID4gKwkJfQ0KPiA+ICAJCWlteF91YXJ0X3dyaXRlbChzcG9ydCwgdWNy
MSwgVUNSMSk7DQo+ID4gIAl9DQo+IA0KPiBUaGUgY2hhbmdlIGxvb2tzIGZpbmUuDQo+IA0KPiBC
ZXN0IHJlZ2FyZHMNCj4gVXdlDQo+IA0KPiAtLQ0KPiBQZW5ndXRyb25peCBlLksuICAgICAgICAg
ICAgICAgICAgICAgICAgICAgfCBVd2UgS2xlaW5lLUvDtm5pZyAgICAgICAgICAgIHwNCj4gSW5k
dXN0cmlhbCBMaW51eCBTb2x1dGlvbnMgICAgICAgICAgICAgICAgIHwgaHR0cHM6Ly93d3cucGVu
Z3V0cm9uaXguZGUvIHwNCg==
