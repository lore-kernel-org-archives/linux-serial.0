Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0690DC7EE25
	for <linux-serial@archiver.kernel.org>; Thu,  8 Jun 2023 02:20:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231368AbjFHCU0 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 7 Jun 2023 22:20:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232920AbjFHCUZ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 7 Jun 2023 22:20:25 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2043.outbound.protection.outlook.com [40.107.21.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4F851BCE
        for <linux-serial@vger.kernel.org>; Wed,  7 Jun 2023 19:20:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RTzcvs43oPSdDVZcFS/UtMoXZOLvuYu5lzhyTj2baaZ5+nzEGZ7zg3ne/THajZ6tgfa7gWzJMfYJhzBMVv7/nKtznLggOVPpbzb0SUgiJTJZ7JFuvFfwJC6G2jOgsz861gRa17Qb+5ppKg146piUOqz8TvaQxXdH4EjKUcD1NmrsPjTNfp/Taf/wM2jOIVNyLwJuEgLUt2Km0paX+EEDJdx9zbetoZZO40sukZpCBfPCVgSFAJb/Z1PppINr2u9WXtaXTJGPPcrUoua2jIDK2kYWQvIUUIfWh/9A03ExA86w1o4Fw9QX88gMqOrvFNq0io/3zi3bOCjIzC3HiMAoeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+uu4hQ5fqJLTlTQrr5JvKT80AtJhQYrGJwyrQRAah3U=;
 b=mKgfsVZdwoBAgnFuMv17BPLczII6xJEFiXWLZcsP5Gf0Y2GRmAX0GHUBosqvlsl6nwRbfCy7ul/fVyfA9el9w4MYN5pGgtTud4LX7J1IEbLjf/3xGh6ndanvzDHUC+VmKl3IBuzlvsdDlSWPy2CkrOoGfi8KjsVzb/xIoQJWwihXf7KPmWWeLefgIjQQYRuLF0gNCN2zoYw1t1XM9BBWK3qTEpD89whrXE5fnymqOayhHlAEhw/lDNFu1Xi4DFL8LvzNqwyWIaU2SnI+Bai8Gxuj/uGgObeVFCCM2ZtpRKVMgQ+1DL07iudRUf866oRXstEBpuMk1WwBakvizjMrYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+uu4hQ5fqJLTlTQrr5JvKT80AtJhQYrGJwyrQRAah3U=;
 b=jAtWibjeSz9xlRhSRVPe4fBGoZNAlNTz9PvlboAMqYZ4bCFBG9+PRhOTDxD+gKd/qigwmsUCepUMGzIIdgsjaEiiKzJXvz93fyArlU36QuAicRn+AUU8COxLOxR/5axNHPgBkx1+D+TCrlc2zLtrl9p1VMquBXqqE1ouFj2zWQ0=
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by DB9PR04MB9990.eurprd04.prod.outlook.com (2603:10a6:10:4ee::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Thu, 8 Jun
 2023 02:20:18 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::ef9f:1e01:e8a:6a4a]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::ef9f:1e01:e8a:6a4a%3]) with mapi id 15.20.6477.016; Thu, 8 Jun 2023
 02:20:18 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     Robert Hodaszi <robert.hodaszi@digi.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "jirislaby@kernel.org" <jirislaby@kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
Subject: RE: [PATCH] Revert "tty: serial: fsl_lpuart: Fix the wrong RXWATER
 setting for rx dma case"
Thread-Topic: [PATCH] Revert "tty: serial: fsl_lpuart: Fix the wrong RXWATER
 setting for rx dma case"
Thread-Index: AQHZmSvTxz5ihqCiWk2vZTPVoQT3dq9/Q3MggAAcbwCAAMuvwA==
Date:   Thu, 8 Jun 2023 02:20:18 +0000
Message-ID: <AS8PR04MB84042413F6C9ECD80A1E87639250A@AS8PR04MB8404.eurprd04.prod.outlook.com>
References: <20230607103459.1222426-1-robert.hodaszi@digi.com>
 <AS8PR04MB84040A92A1FBFE8177CF08D59253A@AS8PR04MB8404.eurprd04.prod.outlook.com>
 <347fc250-ed9e-b448-2ff8-b604faa14e7b@digi.com>
In-Reply-To: <347fc250-ed9e-b448-2ff8-b604faa14e7b@digi.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8404:EE_|DB9PR04MB9990:EE_
x-ms-office365-filtering-correlation-id: 0cb04251-5950-4eb6-acf3-08db67c6e758
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6RtRzk7rkqH3GrBldVgq9hFMy3hy7Z27vvgHZFFtH2zmBGe2e9T+vGRZYn+GgFgLbtDKwfNWTCyyX/65i9kgklFEkPP6FR8GXkbUtpYZg4nBUWCHf1lxKQLg0QpmjTm/cqealLHEYmXkXjxI5X+xp4Kg02j9L86Ys0DO5EKwRiox5fTcKh4ubMvrZPVT+aDM49e7b5pMtpoWB8qmlK587quyXLfJhfttOwV+QklLJScb90ijDMqLeB0N+ngNB/+uMMJ6ZEAjBpz0jfBpwYvB2Y/xnaxv2H+noErv4j2N3y6MxI/CUxHHfvtGoGBsBGJk20yjLOM4tJPe3/DXBqfWi+sEsSeF7jC+AZAjAyUGTtg6a2lOLwm1jSkTmHZm0h7X2Y5Hz1Be3p7VzNajiiR8Zi9NP/CQsGy0sdpkTcslwCoL3Yds9sIaYUDj5+3jDNnMdJvsnzzc/9oaLCZSeZRwJDSalybSh8YzI96PwQgFSZ/aXZvRodtroxgRkb2o5LHD9zA2ipwdGGR3ngYislC8l3iJe5E8TlHytWMGLa+AhOEXWh1dmc/7C5upEbcbDKpkuerOv5wINjAyI5XwEsSLXAtpLmNg7X6AA+ctrn3x0GI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(346002)(366004)(396003)(136003)(451199021)(83380400001)(2906002)(38070700005)(86362001)(33656002)(38100700002)(122000001)(966005)(316002)(52536014)(55016003)(5660300002)(41300700001)(7696005)(8936002)(186003)(8676002)(110136005)(478600001)(64756008)(66556008)(71200400001)(66446008)(66476007)(6506007)(76116006)(53546011)(26005)(66946007)(9686003)(44832011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eTRvUXkzQlZreVUzaHNDSExyRmNsNDI3N1YybFR6cGhoNjZHQzlTNjEzcVJK?=
 =?utf-8?B?S2ZOOVpRNGtjUVA1MGsvdkZCMVp3REp1aCtTaTl1dnlnV1ZoSzJYc1dhcHBw?=
 =?utf-8?B?cEl2UlpIQmlWNXhoV3YxbEZCcVprYXVLZXFSQ1paQk1zUjc2SXY4UEpydUVr?=
 =?utf-8?B?WVJqR1FNQlNIc1JpdU9HMnhSU2RHdXFqVjNQZXNNZUNHTmxVeHA1b2plRXV6?=
 =?utf-8?B?dXVxNVhYV2toUm5xOGxOcXVzcUpJTWVXTjJMU3JCajRnU2pCRzVyemZNR25N?=
 =?utf-8?B?S2N2eGFNVW5NTng2RVk3MG9xb0hYL1NkbHA4U0lORXpqdmgwNGcyZXNkZVJ0?=
 =?utf-8?B?NUtkYTVyYVM3NFh5b1Z0N2Jibk90K0kxY0VUMk55U0VBcTdjRGI1cHdyRktC?=
 =?utf-8?B?YmdyTkNDREsvZkVRT0dudUJaOHlzYUk2VU5EMHdUd1RGY2VwWFlIY09LTjAw?=
 =?utf-8?B?OUV2WGdsbUR1enpWejlNVWV5T2hoUjhGTWwrYVd4d0I2Z1J2Zm5rd21sZ0Jv?=
 =?utf-8?B?QjQrYUprNTdQUm43dXV4UHVRaFVDSDlpOWh6dE9MRTRDSDVTMWVZM1lkTUth?=
 =?utf-8?B?UERvOExHNzZoUkU2ODZ1RjFaelFrSHBmV1pFcE8yNTFielh3Z01HMEtwMjQ3?=
 =?utf-8?B?V2ZOMlc0MDh4UXZGeXV3cHNEQm9tRnAxK1MzVkFReTEyY044aGlvR2kzQVBH?=
 =?utf-8?B?aUtZR1lvZ2w4enU5ZVZnNG9HN2xMT0dMRGxtd3J4TmkrczFxSVVOUVByWU9J?=
 =?utf-8?B?Vkh2MUFlMzlSaUR1WHJnaEJ6NEFJWWFEWU9UT2FQYjZEZlM4ZnNoMlluRGVa?=
 =?utf-8?B?eUhpa0FRMmFVTzhpdDF5WDgxaC9kRTRnbjl5aXJ5clArZXVjNXd6ZVlhWStq?=
 =?utf-8?B?TFpnR1RQMm1jcGorYlI1K2VLeFVXQjlNM1ZQOVB3WUhBZ1JuZWRnK0FnWmh1?=
 =?utf-8?B?VWlrVDl6dzdwZzJ3UUpCbWJXMlhNS1ZKZFhoMEVPMUF5djMybVVPQ3FKbjFW?=
 =?utf-8?B?TGR2RHpueGl1MTBLSjBaU2h4TkJLQ3BDenpyblJDU2NOS2pzSG9xQWk2dmpV?=
 =?utf-8?B?M3RoWWZFR2lUUUl2c3A1N1IrZ2hjSzB3NmNyNkNGVVZFWUFmeUdxU1pQSzhJ?=
 =?utf-8?B?THE2WWdiVElqTU9pSmlDTlZGYlcwbjFvVXVQcHdncnRZbWoxU1VGNm5PbHVa?=
 =?utf-8?B?azIrUHZwV3h2MFJzcFErR1FCNytyWmpkOXdxUlF6KzBGY0cxdlVtaGZmNEln?=
 =?utf-8?B?Y3NPd2FpNDRXcXNQSUVwQ1ViQ0EvUHBjZTc5cFVJaTg3V3lqcnlmM2UyYWRv?=
 =?utf-8?B?NW1LRDJ5SExnYy9mdkxkcURmUjVneHpUUzE3QURVSzJ3NGQvVzZIM1hyc3R4?=
 =?utf-8?B?RE1ML2t5a3RBYi81QWRFV2s2cERNcTFXcHdhazlMVmthS0E0Z1FFZVhLTS80?=
 =?utf-8?B?bkhoYkxaNTNNMWUxenpZbnBjWU9rVGdiOEYrNHorcEJNcUhMTkpHc1J0VTRY?=
 =?utf-8?B?ek84OUNyTkIwcVZReCtiSCt0dzh4dzhobDBQOGRpZ2ZzeVJJSHovTWlhb0hz?=
 =?utf-8?B?REhYbHR5RXZ3c3ltNVozWmQ1RnN0QTBZQ3BHYSsrdThyYUc5c202K0pmditF?=
 =?utf-8?B?d0tJcWM4dncvY2thdjA3d0haSDY2VVE3SGdGdXQ4YjJYVjZxN1ZtTXhycVJa?=
 =?utf-8?B?TEN6L3JidnduenNJNjBqYXVxUGxvaGlOTndKWDRzSjlVTmhHSHBOQ0xKbjBj?=
 =?utf-8?B?N0pna2xkdTdYdEo3eUdFUHFuM0czTm9qWVB0N2o0em11TG5YZ3p2K01HWGVx?=
 =?utf-8?B?VmlSMitLdWJCNEZVb0NzTkxmWmllcXNEeTA2NkVxUEpORnUxTUNWc2VwWWdW?=
 =?utf-8?B?UWF4Mzc4d21wVmpjNnd5YmVVZ2FHbXJZenhyUjFpQUp0UVNWOThZQWJndDg0?=
 =?utf-8?B?T3dUcVY4TmtHTzA5TXFrREpGM2x4c1Bnb3dyZWRoenZOMnNNOWsvMEpCcXdq?=
 =?utf-8?B?RUN3M3FHdzZkS0pmd3dFZnVBTHA2TTNFRE0rQlpoV09DMVlHd0hDbjBtRklk?=
 =?utf-8?B?N2s3bXBqYjNyeXF6ZmJuT2o5aUlKZmdzY2ozTDJSNU5YMmxoNzMwZFd5YWhI?=
 =?utf-8?Q?5688=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cb04251-5950-4eb6-acf3-08db67c6e758
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2023 02:20:18.4989
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: av3efdmoGBMXwaXv0BsTRYfe8LAusHaQOhMC01VLSoTvjj0UtCv+CF/DvbQtCqmK4FjyZ+mXcCJLLe9AJO2/vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9990
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUm9iZXJ0IEhvZGFzemkg
PHJvYmVydC5ob2Rhc3ppQGRpZ2kuY29tPg0KPiBTZW50OiAyMDIz5bm0NuaciDfml6UgMjI6MDUN
Cj4gVG86IFNoZXJyeSBTdW4gPHNoZXJyeS5zdW5AbnhwLmNvbT47IGdyZWdraEBsaW51eGZvdW5k
YXRpb24ub3JnOw0KPiBqaXJpc2xhYnlAa2VybmVsLm9yZzsgbGludXgtc2VyaWFsQHZnZXIua2Vy
bmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBSZXZlcnQgInR0eTogc2VyaWFsOiBmc2xf
bHB1YXJ0OiBGaXggdGhlIHdyb25nIFJYV0FURVINCj4gc2V0dGluZyBmb3IgcnggZG1hIGNhc2Ui
DQo+IA0KPiBPbiAyMDIzLiAwNi4gMDcuIDE0OjM5LCBTaGVycnkgU3VuIHdyb3RlOg0KPiA+IEhp
IFJvYmVydCwNCj4gPg0KPiA+IE5vLCBwbGVhc2UgZG9u4oCZdCBkbyB0aGF0Lg0KPiA+IEkgYWdy
ZWUgd2l0aCB5b3UgdGhhdCB0aGUgTFBVQVJUIFJNIGhhcyBhIGZhbHNlIHN0YXRlbWVudCwgdGhl
IFJlY2VpdmUNCj4gV2F0ZXJtYXJrIGFjdHVhbGx5IGNhbiBiZSBncmVhdGVyIHRoYW4gb3IgZXF1
YWwgdG8gMCwgYnV0IHRoaXMgZG9lc27igJl0IG1lYW4NCj4gdGhhdCBpdCBtdXN0IGJlIDAuDQo+
ID4gQW5kIHRoZSBmYWxzZSBzdGF0ZW1lbnQgIGhhcyBub3RoaW5nIHRvIGRvIHdpdGggdGhlIGNv
ZGUgaGVyZS4gVGhlIGNvZGUNCj4gaGVyZSBhaW1zIHRvIHNldCB0aGUgZGlmZmVyZW50IHZhbHVl
cyBmb3IgbHB1YXJ0IGludGVycnVwdCBjYXNlIGFuZCBkbWEgY2FzZSwNCj4gYW5kIGZvcmNlIHRo
ZSByeCB3YXRlcm1hcmsgZm9yIGRtYSBjYXNlIHRvIDAsIHdoaWNoIGlzIHVucmVhc29uYWJsZS4N
Cj4gPiBXZSBoYXZlIGFscmVhZHkgc2V0IHRoZSB3YXRlcm1hcmsgaW4gbHB1YXJ0MzJfc2V0dXBf
d2F0ZXJtYXJrKCksIGl0DQo+IHdvcmtzIGZvciBib3RoIGludGVycnVwdCBhbmQgZG1hIGNhc2Us
IHlvdSBjYW4gc2V0IHRoZSByeF93YXRlcm1hcmsgdmFsdWUNCj4gZm9yIGRpZmZlcmVudCBwbGF0
Zm9ybXMgYWNjb3JkaW5nIHRvIHlvdXIgcmVxdWlyZW1lbnRzLCBmcm9tIDAgfg0KPiBGSUZPW1JY
RklGT1NJWkVdLTEuDQo+ID4NCj4gPiBCZXN0IFJlZ2FyZHMNCj4gPiBTaGVycnkNCj4gPg0KPiBJ
J20gd29ya2luZyBvbiBhbiBMUzEwMjhBLWJhc2VkIChhY3R1YWxseSBMUzEwMjdBKSB1bml0LiBI
YXZpbmcgdGhlDQo+IHdhdGVybWFyayBzZXQgdG8gMSBpcyBiYXNpY2FsbHkgbWFraW5nIHRoZSBM
UFVBUlQgdW51c2FibGUuIERNQSBpcyBlbmFibGVkDQo+IG9uIHRoaXMgcGxhdGZvcm0uIFRoZSBs
YXN0IGNoYXJhY3RlciBhbHdheXMgZ2V0cyBzdHVjayBpbiB0aGUgcmVjZWl2ZSBidWZmZXIsDQo+
IGFuZCBJIHJlY2VpdmUgb25seSB0aGUgcHJldmlvdXMgb25lLiBTbyB0aGUgV0FURVIgcmVnaXN0
ZXIncyBjb250ZW50IGFmdGVyDQo+IHNlbmRpbmcgb25lIGNoYXJhY3RlciB0byB0aGUgdW5pdCAo
YnV0IG5vdCByZWNlaXZpbmcgaXQgaW4gTGludXggb24gdGhlIHVuaXQpIGlzDQo+IHRoZSBmb2xs
b3dpbmc6DQo+IA0KPiAgICAgMHgwMjI2MDAxYzogMDEwMTAwMDANCj4gDQo+IFdoaWNoIG1lYW5z
LCB3YXRlcm1hcmsgaXMgc2V0IHRvIDEsIHRoZXJlJ3Mgb25lIGNoYXJhY3RlciB3YWl0aW5nIGlu
IHRoZSBGSUZPLA0KPiBhbmQgdGhlcmUgd2FzIG5vIERNQSB0cmFuc2FjdGlvbiB0byBtb3ZlIG91
dCB0aGF0IGNoYXJhY3RlciBmcm9tIHRoZSBGSUZPDQo+IGludG8gdGhlIERNQSBSWCBidWZmZXIu
DQo+IA0KPiBUaGUgUk0gc2F5czogIldoZW4gdGhlIG51bWJlciBvZiBkYXRhd29yZHMgaW4gdGhl
IHJlY2VpdmUgRklGTy9idWZmZXIgaXMNCj4gZ3JlYXRlciB0aGFuIHRoZSB2YWx1ZSBpbiB0aGlz
IHJlZ2lzdGVyIGZpZWxkLCBhbiBpbnRlcnJ1cHQgb3IgYSBETUEgcmVxdWVzdCBpcw0KPiBnZW5l
cmF0ZWQuIiBTbyBpZiBJIGdldCBpdCByaWdodCwgaGF2aW5nIHRoZSB3YXRlcm1hcmsgc2V0IHRv
IDEsIHdpbGwgbmV2ZXINCj4gZ2VuZXJhdGUgYSBETUEgcmVxdWVzdCB3aGVuIG9ubHkgYSBzaW5n
bGUgY2hhcmFjdGVyIGlzIHNlbnQuIFRoZSBSWCB0aW1lb3V0DQo+IGZ1bmN0aW9uIHdpdGggRE1B
IHdpbGwgaGVscCBub3RoaW5nIGhlcmUsIGFzIHRoZXJlIHdpbGwgYmUgbm90aGluZyBpbiB0aGUg
UlgNCj4gYnVmZmVyLg0KPiANCj4gQnV0IGlmIERNQSBpcyBOT1QgdXNlZCAoaW50ZXJydXB0IGJh
c2VkIHJlY2VpdmUpLCB3ZSBjYW4gc2V0IHdoYXRldmVyIHdlDQo+IHdhbnQgdG8gd2F0ZXJtYXJr
LCBhcyB0aGUgdGltZW91dCBmdW5jdGlvbiB3aWxsIGNvbGxlY3QgdGhlIHJlY2VpdmVkIGJ5dGVz
DQo+IGZyb20gdGhlIEZJRk8uDQoNCkhpIFJvYmVydCwNCkkgdW5kZXJzdGFuZCB5b3VyIGNvbmNl
cm4sIGZvcnR1bmF0ZWx5LCBMUFVBUlQgSVAgcHJvdmlkZXMgdGhlIFJlY2VpdmVyIElkbGUgRW1w
dHkgZnVuY3Rpb24sIHdoaWNoIGNhbiBhdm9pZCB0aGUgcmVjZWl2ZSBkYXRhIGJlaW5nIHRyYXBw
ZWQgaW4gdGhlIFJYIEZJRk8uIEZvciBtb3JlIGRldGFpbHMgeW91IGNhbiBjaGVjayBteSBwYXRj
aCBiZWxvdy4NCg0KY29tbWl0IDk2ZjU0ZmQ0ODk0NzExYjBkY2U2YTFjOGMyNmM4ODIyOTVkYzky
MzQNCkF1dGhvcjogU2hlcnJ5IFN1biA8c2hlcnJ5LnN1bkBueHAuY29tPg0KRGF0ZTogICBNb24g
SmFuIDMwIDE0OjQ0OjQ3IDIwMjMgKzA4MDANCg0KICAgIHR0eTogc2VyaWFsOiBmc2xfbHB1YXJ0
OiBFbmFibGUgUmVjZWl2ZXIgSWRsZSBFbXB0eSBmdW5jdGlvbiBmb3IgTFBVQVJUDQoNCiAgICBX
aXRoIHRoZSBncm93dGggb2Ygcnggd2F0ZXJtYXJrLCBpdCdzIHVzZWZ1bCB0byBlbmFibGUgdGhl
IFJlY2VpdmVyIElkbGUNCiAgICBFbXB0eSBmdW5jdGlvbiwgaXQgY2FuIGFzc2VydCB0aGUgUkRS
RihSZWNlaXZlIERhdGEgUmVnaXN0ZXIgRnVsbCBGbGFnKQ0KICAgIHdoZW4gdGhlIHJlY2VpdmVy
IGlzIGlkbGUgZm9yIGEgbnVtYmVyIG9mIGlkbGUgY2hhcmFjdGVycyBhbmQgdGhlIEZJRk8NCiAg
ICBpcyBub3QgZW1wdHkuIEl0IHdpbGwgZ2VuZXJhdGUgYSBETUEgcmVxdWVzdCBvciBpbnRlcnJ1
cHQsIHdoaWNoIGNhbg0KICAgIGF2b2lkIHJlY2VpdmUgZGF0YSBiZWluZyB0cmFwcGVkIGluIHRo
ZSBSWCBGSUZPIHNpbmNlIHRoZSBudW1iZXIgb2YNCiAgICB3b3JkcyByZWNlaXZlZCBpcyBsZXNz
IHRoYW4gdGhlIHdhdGVybWFyay4NCg0KICAgIEhlcmUgc2V0IHRoZSBSWElERU4gYXMgMHgzIHdo
aWNoIGVuYWJsZSB0aGUgUkRSRiBhc3NlcnRpb24gZHVlIHRvDQogICAgcGFydGlhbGx5IGZpbGxl
ZCBGSUZPIHdoZW4gcmVjZWl2ZXIgaXMgaWRsZSBmb3IgNCBjaGFyYWN0ZXJzLg0KDQogICAgU2ln
bmVkLW9mZi1ieTogU2hlcnJ5IFN1biA8c2hlcnJ5LnN1bkBueHAuY29tPg0KICAgIExpbms6IGh0
dHBzOi8vbG9yZS5rZXJuZWwub3JnL3IvMjAyMzAxMzAwNjQ0NDkuOTU2NC01LXNoZXJyeS5zdW5A
bnhwLmNvbQ0KICAgIFNpZ25lZC1vZmYtYnk6IEdyZWcgS3JvYWgtSGFydG1hbiA8Z3JlZ2toQGxp
bnV4Zm91bmRhdGlvbi5vcmc+DQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL3R0eS9zZXJpYWwvZnNs
X2xwdWFydC5jIGIvZHJpdmVycy90dHkvc2VyaWFsL2ZzbF9scHVhcnQuYw0KaW5kZXggYmE2YWRl
Nzg0YWM1Li4yNzg5NzQ5ZDNkMGQgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL3R0eS9zZXJpYWwvZnNs
X2xwdWFydC5jDQorKysgYi9kcml2ZXJzL3R0eS9zZXJpYWwvZnNsX2xwdWFydC5jDQpAQCAtMjE0
LDYgKzIxNCw3IEBADQogI2RlZmluZSBVQVJURklGT19SWFVGICAgICAgICAgIDB4MDAwMTAwMDAN
CiAjZGVmaW5lIFVBUlRGSUZPX1RYRkxVU0ggICAgICAgMHgwMDAwODAwMA0KICNkZWZpbmUgVUFS
VEZJRk9fUlhGTFVTSCAgICAgICAweDAwMDA0MDAwDQorI2RlZmluZSBVQVJURklGT19SWElERU4g
ICAgICAgIEdFTk1BU0soMTIsIDEwKQ0KICNkZWZpbmUgVUFSVEZJRk9fVFhPRkUgICAgICAgICAw
eDAwMDAwMjAwDQogI2RlZmluZSBVQVJURklGT19SWFVGRSAgICAgICAgIDB4MDAwMDAxMDANCiAj
ZGVmaW5lIFVBUlRGSUZPX1RYRkUgICAgICAgICAgMHgwMDAwMDA4MA0KQEAgLTE1NjIsNiArMTU2
Myw3IEBAIHN0YXRpYyB2b2lkIGxwdWFydDMyX3NldHVwX3dhdGVybWFyayhzdHJ1Y3QgbHB1YXJ0
X3BvcnQgKnNwb3J0KQ0KICAgICAgICB2YWwgPSBscHVhcnQzMl9yZWFkKCZzcG9ydC0+cG9ydCwg
VUFSVEZJRk8pOw0KICAgICAgICB2YWwgfD0gVUFSVEZJRk9fVFhGRSB8IFVBUlRGSUZPX1JYRkU7
DQogICAgICAgIHZhbCB8PSBVQVJURklGT19UWEZMVVNIIHwgVUFSVEZJRk9fUlhGTFVTSDsNCisg
ICAgICAgdmFsIHw9IEZJRUxEX1BSRVAoVUFSVEZJRk9fUlhJREVOLCAweDMpOw0KICAgICAgICBs
cHVhcnQzMl93cml0ZSgmc3BvcnQtPnBvcnQsIHZhbCwgVUFSVEZJRk8pOw0KDQpCZXN0IFJlZ2Fy
ZHMNClNoZXJyeQ0K
