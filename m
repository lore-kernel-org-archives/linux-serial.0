Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0CC7C433F5
	for <linux-serial@archiver.kernel.org>; Mon, 25 Apr 2022 07:05:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234687AbiDYHIC (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 25 Apr 2022 03:08:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234269AbiDYHIA (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 25 Apr 2022 03:08:00 -0400
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (mail-eopbgr10077.outbound.protection.outlook.com [40.107.1.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF40E1CB09
        for <linux-serial@vger.kernel.org>; Mon, 25 Apr 2022 00:04:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E6iBL1toZs4/eUpHoleRZV5axR7wPsG8KbM2iI4jbV9PwE0v1aGW1nTf+oCo9fHyJI8wG61NGLtyb8nUtM4kKAzayTPu7aq6kjSljxwF7MLmXBM1+F2KZpRp6X+MU6MHbxVk/4GaW/yOfInuvJt3LOJgN/JcLCmMRtahDxxAUPZfBotLfQunym/NHU9uyOfDxnb3DyhyuI3YJMLLPSf18ozyAMRmy+LQ527KGZbe/VgSGMUjRXu89xNUUEOm/RM/9EgIGuflto0/kj+9dX5K7eMERmI+IjhvEtVKfpS8kq3D5+/OKv2JuY/1Q75ftM1g99zguH4T/OAvpMXxVHQEHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KXPatEnpVbo30t9SNk0Fqkqd832XZII/T/MekWtid+I=;
 b=moJ/hIkTeRI1oJBUumezGz8fdbWdY39AGjcfTZBMLhSoz93Jjx2GAOdoODHq2WCxrIwz5zN363Yfs/y/2SgqnfrHEQjKtoo9GQ8sRYAD6TkWn7x+4c5E+2cwm6sbzSF1GQFiy+japBccWSNh5fpEjj3nbwbryMyhNMMxnQiIfY3kMhgPfInHd572BWAdduqnBf4vAJqjsZIRqNt13JlcaEz0Uh3fX9GlWJiSepX4xzqE6DNpZh3tuE6Bjk6eRVBDRDp0eNL0BChZd/aMI9Cq9PUvC7r480xJdpjyOtDaoKqf9Eh4d2jYQ6qpMNg4cSLqqqQyuEX8QzuOjHkUYyCwkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KXPatEnpVbo30t9SNk0Fqkqd832XZII/T/MekWtid+I=;
 b=qbM69DkR4I2KqLsnSm0h1453R1HWPqe4OHemtPua6rlC/yId6TdOuKIRmJUXJKL+K3xBCKS+8f5DcogL1sFHguZkMQ6Yob0JL2aliMKsyxogMaZK/SaojB3XArotGAZm3M+OptdrBDrWusu6S7mGJ6styjDU3NUsLL1Eno87rS3e53kQ33Jh99qyj8fNmpF6v1sRRU9BQL96e+7QSyoSZOpVo/8l+gb0oRLMau0MpeFCnu8i1vnFC/M+BQHTigvg/S3vrX1JD9nt2evwsXPUsUqcp0j2g7PzHsquo9mFZocX9BqLTYow7909zPJiVxXWmxm5g9WztFQvVvChKWHfTw==
Received: from AM4PR1001MB1378.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:200:98::12) by DB9PR10MB5427.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:334::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Mon, 25 Apr
 2022 07:04:55 +0000
Received: from AM4PR1001MB1378.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::750a:d1ed:d78b:5fa2]) by AM4PR1001MB1378.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::750a:d1ed:d78b:5fa2%3]) with mapi id 15.20.5186.021; Mon, 25 Apr 2022
 07:04:55 +0000
From:   "Starke, Daniel" <daniel.starke@siemens.com>
To:     Nathan Chancellor <nathan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     kernel test robot <lkp@intel.com>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
Subject: RE: [tty:tty-linus 23/26] drivers/tty/n_gsm.c:939:13: warning:
 variable 'size' is used uninitialized whenever 'if' condition is false
Thread-Topic: [tty:tty-linus 23/26] drivers/tty/n_gsm.c:939:13: warning:
 variable 'size' is used uninitialized whenever 'if' condition is false
Thread-Index: AdhYcsFv40aeHEZHTZaZ/bzqqB6EUw==
Date:   Mon, 25 Apr 2022 07:04:55 +0000
Message-ID: <AM4PR1001MB1378B3A6E8E2AB8A11E48C64E0F89@AM4PR1001MB1378.EURPRD10.PROD.OUTLOOK.COM>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_Enabled=true;
 MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_SetDate=2022-04-25T07:04:53Z;
 MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_Method=Privileged;
 MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_Name=restricted-default;
 MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;
 MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_ActionId=bd1ecf24-2384-4557-926d-33c62ca2bdda;
 MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_ContentBits=0
document_confidentiality: Restricted
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bff793a3-4ec8-4513-6939-08da2689e6d0
x-ms-traffictypediagnostic: DB9PR10MB5427:EE_
x-microsoft-antispam-prvs: <DB9PR10MB54273060948EED7C954F31D1E0F89@DB9PR10MB5427.EURPRD10.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Cg9jmLMGJKn/GhAiUMO1xGruZTWyx/G6JsjJs2Vt3OL+mZMgU447q5HGCQQmasTrVvID5cQMgPlQmkOG4hjOsuSR0jDe462j4dt2ADgVYkrGCQmggEgZrWcUo01eswOT7mJQsC5yIhUmYAVZlKVdMunDWUmiQE8FTcHMqZl+yzKvl05VhY4wGCmdpXv7DyP17TrGN0ytnGvKho4ij7Y2g0MY6tGL1SBlY7WKU2xzaHDuBtLUq6TjObshyZWEzJ9ok8/Pn9MLfE+MqrQitgUDvLZpXaUzzg4z4oSFL+HE65Lnrd8eggJQhHNr4bRhnuhDHPkUHvp2lIDlqjMsMX4v0H8E59z3nwr7MT77DH9hElIqzQumaGFGp+ZOTQVQC06BxR7BMyAt2PCagV30jsnMDnu3JKM2+8r+OhWEPLLd5CCN6Jb5EoncbUCY0ajG/6v8iR35Fwon2GAJRR/cpoRhpgxqrTdrWuHI6s1a7ir0iCoEjUIKGSoPTVggIuwevQBzQ7e50gBpS6z1qsAWDu13oyCUZ6gW2pwKaVfAFz25ADjA8Mu7SLLZwgaqUVEqi8UbTpSP84DXdy3ZX//wADr1y3JiUGFKpXXflpKfJou6CeSPrHhH2sr70CMnIbaGneDXE244QFBT+Iwt1UF/qr16oxoagEb0cAvOE6682axZlzTBRADiADCiGd+R6LcDacihbjiTyDBOgcH75zx6+Xl+ww==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM4PR1001MB1378.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(86362001)(122000001)(54906003)(110136005)(33656002)(5660300002)(8936002)(71200400001)(508600001)(52536014)(82960400001)(2906002)(55016003)(83380400001)(8676002)(186003)(4326008)(66946007)(66556008)(66476007)(66446008)(64756008)(76116006)(26005)(6506007)(316002)(55236004)(9686003)(7696005)(38100700002)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MDR4YnN0eXZzRUZVYzdlTHZhRFFBVHg2NVJPSGpXQXFmSjdkU1Q5TjdEclh4?=
 =?utf-8?B?ZWhtKzFLdlhrb3diRnRIeXprNC9mS2FUMVN2Vi9xb1p0TDlTQ3J3WVFTcHFn?=
 =?utf-8?B?N2w2bXdSYTlrV2pzZ2I0bjRPVk5zbnl1T3pHMWJLSTdjUkFybkVWZWNlTzEy?=
 =?utf-8?B?QzVZZVVYeTYrNENXbExRb2tCcW13SkU2cWhZTFZJZmw2RDRmWlhKMWpsZ2xD?=
 =?utf-8?B?aWN2c3YyaS81U3NRdGw0OUttUXM5UU9uM0lrd3g0cFFPbzVXTzhyOUpsMjJp?=
 =?utf-8?B?L3ZrL2ppY2RTcFVia2xOckw4cHprZWRJTXRZTVhOMFRGNTZuL3NaUlg5YUJV?=
 =?utf-8?B?aS9MRGFGZStYME9BbCtBNlJub1dyREVQVTdFcTRnOXpWK3BqQ0V0QmFxdDA2?=
 =?utf-8?B?MVF5dEUya201WmtSRTFaem52NkdhR1FVZnV6NGFtZi9qVjZlNXZHUURTUk91?=
 =?utf-8?B?ODAzUzFFUFg1V2RHN0ZwdlhBTkpuQytPYVNiZWFTeVRsOXdpRHBMeDBaTkQy?=
 =?utf-8?B?ZGJLSWl4TklQWHFZMjFHa1VKTFB1NmVSSlk5K3BqTmR6Y0djeTFyMHdBU01K?=
 =?utf-8?B?cHFJRVBoRk0vSnJIN05rS1hBNzRIL25EelplYXpsb0p1cWFqYm51cDVoMXE2?=
 =?utf-8?B?WnFEY0RmdWRxT09lRXFNbjBzcm1wcmFBY2owazZkbDl3YWFBVEdoU2pnaHVh?=
 =?utf-8?B?UFNMSkk4aXVkRmRXb3FRam40OU1yTjFOZjd4VmtSRTVjNm52cGphYURZaG11?=
 =?utf-8?B?S0pRUzFMZnJvN0wvU2FuQmFrNWtUZkpSODE1ZVh6UnRLckwzR2FVZmZUbTRv?=
 =?utf-8?B?bG02WkJENVBjTFRmWDVxOE9YWVN1ZlVLNTlCZEY2T25YLzNXYkJQRXZHazYr?=
 =?utf-8?B?Ym9zUi9Fc1ptVG5hZnZBalNwUDNWdUE3T0R0NG9TY2U0YkhXbmloUkNqZ3ZS?=
 =?utf-8?B?eVZpUE5HNi9jZFluSms4QzQwOVBGSDYzVnNKQ3lJdkhFRnMzMDdVNjh3Vjg0?=
 =?utf-8?B?ejlqNTRLMEZaaElKLzVxaWMvVXAzOW15VVlNSDZZblp0T1ZJeFVmU2dJb3Nh?=
 =?utf-8?B?ZHROYzBONFJ0TWRCeGt6azJNY0tNVVZyckxDczh0M3RnRUhNd1B0RnlyVW1U?=
 =?utf-8?B?bUhDMlgzVkdvamJvdzRWd2owVWNWcldJU3VDVmJzTytad3BybDF0UlFGR2Jr?=
 =?utf-8?B?aTl2N1Vkb2p2UDdvdGhzZHdEVGNrV2U4OExOYW9FTHdwMURzMzA3VXJqSjB1?=
 =?utf-8?B?eGh3VE00Qm9Bd3lEWXNYRy9mWlF0SjhKM1I0M3FFdEJHd3RwUkw2NWFoRWVl?=
 =?utf-8?B?endWMEplQUlJWjJWa2d4VnZLWGJUSkNUbkZseFlTdTh6NHJuMzk1cDQvOEZW?=
 =?utf-8?B?cjhkdTllRVRaejBZektRNVg1UW1HM0RKQ1M0M2JmMU0vUFRnYXpIQTVrRnhj?=
 =?utf-8?B?eFJRT0FCOEVrVUw4bXNpNkhFTTNQQmpLcXlpeDhVRWtKMDJkK3U5d2g4MFFR?=
 =?utf-8?B?dURZek9oZjE2RnNma0l0Y3RhWmJpMzg3alZJMmR3RUQ2NHppUHdpTG51cXNJ?=
 =?utf-8?B?WnVySDlLZE9BRXdlenZWTG5sa042Y3lNTHR0NHlNM1d0UTUzSXdXZnZmWHl5?=
 =?utf-8?B?QUxLMzUxRWNEdXVZdVFyRVpzUEZoanEzQVhsSGJPRDBHd1dLUTVqdnRUU0px?=
 =?utf-8?B?TWMzWFY0cG1SRzA2TFZzSHBFbXpRbjlnejVzUVpqR0lJTFYxaFRFalV1SHpk?=
 =?utf-8?B?cmwyOUxHd2pFS3o4QzhsQit5UGk1b2tUNFhaTFJpNUV3eVU2V1ZtQkRRSFNI?=
 =?utf-8?B?NVRqRVFoM3IvMlNxelJwVXlId25zRVF2UTB1VVc1cEo5eXNNc2NqSHBQRmZy?=
 =?utf-8?B?a2NhRFdUNDZHbkhySkRjSlMzMSs3ZS9vVDdKc1duYkR5cy9YWUVKM0tXaTRi?=
 =?utf-8?B?OG9kakN4dmtPKzY1ZDFnUERxcE9Rcy9pTE1zWm9xNWkrc1ZWSTJvVEtTYUxT?=
 =?utf-8?B?dVlHVUtKd3M5bVRucGdKT1NENzdRVWp2SHhhNHYwdUFWV0NQVjR2YjlEd3NQ?=
 =?utf-8?B?T3VyWFVoMVB1aEwzS3NlcjVLVHNGdy8rT3R5M2J2cjJWN2Zoa2xpREV0SzVn?=
 =?utf-8?B?NVZpNlpLdlRtM2pLZjFiRmFoeFkrK2w0YkYyVkdNYzdzL2Z5cDRCb3ZNRjRG?=
 =?utf-8?B?YjVVRTB0MWFoS09xYzl1ZlBuNENwaWlVbW16RXdlbzVBVXdxbVNwWTdnc3Za?=
 =?utf-8?B?bVJmOVJpRkpEa0lDTEQzTEN6czNnVHJjT0ZMd2cvRW5PYWFtSS85M2lJbGlZ?=
 =?utf-8?B?QituK3poV2dOTURBUEJVWE9sd2hwbkxsYktwb0NBODVCdUJ3MDAzcHc3M0tR?=
 =?utf-8?Q?7GIBwgHRZBgcxoWk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM4PR1001MB1378.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: bff793a3-4ec8-4513-6939-08da2689e6d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2022 07:04:55.0670
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PTmJG2Ir30+1JVkQ6fB1OUkloNLbbVy3HfKkS1a2HZ/xp+/5XqLPuSoE2y0WFz1T3F7klRr2Qck08i6rHxjSMYnQPRpIVjlYMERPtJkdb+E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5427
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

PiA+ID4gSWYgeW91IGZpeCB0aGUgaXNzdWUsIGtpbmRseSBhZGQgZm9sbG93aW5nIHRhZyBhcyBh
cHByb3ByaWF0ZQ0KPiA+ID4gUmVwb3J0ZWQtYnk6IGtlcm5lbCB0ZXN0IHJvYm90IDxsa3BAaW50
ZWwuY29tPg0KPiA+ID4gDQo+ID4gPiBBbGwgd2FybmluZ3MgKG5ldyBvbmVzIHByZWZpeGVkIGJ5
ID4+KToNCj4gPiA+IA0KPiA+ID4gPj4gZHJpdmVycy90dHkvbl9nc20uYzo5Mzk6MTM6IHdhcm5p
bmc6IHZhcmlhYmxlICdzaXplJyBpcyB1c2VkIA0KPiA+ID4gPj4gdW5pbml0aWFsaXplZCB3aGVu
ZXZlciAnaWYnIGNvbmRpdGlvbiBpcyBmYWxzZSANCj4gPiA+ID4+IFstV3NvbWV0aW1lcy11bmlu
aXRpYWxpemVkXQ0KPiA+ID4gICAgICAgICAgICB9IGVsc2UgaWYgKGRsY2ktPmFkYXB0aW9uID09
IDIpIHsNCj4gPiA+ICAgICAgICAgICAgICAgICAgICAgICBefn5+fn5+fn5+fn5+fn5+fn5+DQo+
ID4gPiAgICBkcml2ZXJzL3R0eS9uX2dzbS5jOjk0ODo0MDogbm90ZTogdW5pbml0aWFsaXplZCB1
c2Ugb2NjdXJzIGhlcmUNCj4gPiA+ICAgICAgICAgICAgbXNnID0gZ3NtX2RhdGFfYWxsb2MoZ3Nt
LCBkbGNpLT5hZGRyLCBzaXplLCBnc20tPmZ0eXBlKTsNCj4gPiA+ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBefn5+DQo+ID4gPiAgICBkcml2ZXJzL3R0
eS9uX2dzbS5jOjkzOTo5OiBub3RlOiByZW1vdmUgdGhlICdpZicgaWYgaXRzIGNvbmRpdGlvbiBp
cyBhbHdheXMgdHJ1ZQ0KPiA+ID4gICAgICAgICAgICB9IGVsc2UgaWYgKGRsY2ktPmFkYXB0aW9u
ID09IDIpIHsNCj4gPiA+ICAgICAgICAgICAgICAgICAgIF5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn4NCj4gPiA+ICAgIGRyaXZlcnMvdHR5L25fZ3NtLmM6OTM0OjEwOiBub3RlOiBpbml0aWFsaXpl
IHRoZSB2YXJpYWJsZSAnc2l6ZScgdG8gc2lsZW5jZSB0aGlzIHdhcm5pbmcNCj4gPiA+ICAgICAg
ICAgICAgaW50IHNpemU7DQo+ID4gPiAgICAgICAgICAgICAgICAgICAgXg0KPiA+ID4gICAgICAg
ICAgICAgICAgICAgICA9IDANCj4gPiA+ICAgIDEgd2FybmluZyBnZW5lcmF0ZWQuDQo+ID4gPiAN
Cj4gPiANCj4gPiBJdCdzIG5vdCBvYnZpb3VzLCBidXQgdGhpcyBzaG91bGQgYmUgZmluZSBhcyBh
ZGFwdGlvbiBpcyBvbmx5IDEgb3IgMiANCj4gPiBmcm9tIHdoYXQgSSBjYW4gdGVsbC4NCj4gPiAN
Cj4gPiBUbyBtYWtlIHRoZSBjb21waWxlciB1bmRlcnN0YW5kIHRoaXMgZWFzaWVyLCB0aGlzIHNo
b3VsZCBwcm9iYWJseSBiZSANCj4gPiBhbiBlbnVtIGFuZCB1c2Ugc3dpdGNoIHN0YXRlbWVudHMu
ICBEYW5pZWwsIHdhbnQgdG8gbWFrZSB0aGF0IGNoYW5nZT8NCj4gDQo+IEFsdGVybmF0aXZlbHks
ICdyZXR1cm4gLUVJTlZBTCcgb3Igc29tZXRoaW5nIHNpbWlsYXIgaW4gdGhlICdlbHNlJw0KPiBi
cmFuY2ggb2YgdGhlIGZpcnN0IGlmIHN0YXRlbWVudD8gVGhlIGVycm9yIG1lc3NhZ2UgbWFrZXMg
aXQgc2VlbSBsaWtlIHRoZSBmdW5jdGlvbiBzaG91bGRuJ3QgY29udGludWUgYnV0IGl0IGRvZXMu
DQoNClRoYW5rIHlvdSBmb3IgdGhlIGhpbnQuIEkgd2lsbCBjcmVhdGUgYW4gYXBwcm9wcmlhdGUg
cGF0Y2guDQoNCkJlc3QgcmVnYXJkcywNCkRhbmllbCBTdGFya2UNCg==
