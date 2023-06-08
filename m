Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66886C7EE23
	for <linux-serial@archiver.kernel.org>; Thu,  8 Jun 2023 09:58:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235200AbjFHJ6r (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 8 Jun 2023 05:58:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231439AbjFHJ6q (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 8 Jun 2023 05:58:46 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2063.outbound.protection.outlook.com [40.107.20.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8B9726BB
        for <linux-serial@vger.kernel.org>; Thu,  8 Jun 2023 02:58:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z0YyE0t+00VKmeFow2rNDIcE/Vgvy+ztIvjltN67qJ3ZeoKI7QVWe5ZoDk1i4yTldjqNRf2Oq0LzfRjMDCVQ3kY8n+MmgrQpBksVIgQfJXXPfnnVPLlOy/4Rgkd/Ps0+uBtDwpSEXiJtIEVEZZ8HFOoOWNgUQDnnYYU/yVVMtXdnjnQ5v57gdVUOhEbV2vgT93qCTmMbWida9ggQpM0FnA2HiIeqbnaPhMDPavk4Np94XDC8GMsw9oDxv/l/tcbJx/suLHfZlrdmDKttHDBYojiqMDSr0a3rPXZBVq/4DrF9NIgN7JCC96/o5X3BqW34d/jEyStxFkLGWt5ozVakTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=azAj2tHya4WZmxF4SCpdsFN2ALajhn+suTj/DGpBRMY=;
 b=iNu36L9I81PsFZK6r2mn2PQpqpjcIW4kro8++9+oomDj37JWB6MTFTviNdWAqMJ5l++Zn6rjkMmr0e6es/gf3TvevlmzpibCuk8OVjRuOKTPDiRNtR1HRNG7CAbn8XKvOAYMQVmga4un/mdT/rQTOUKZRt8HcVVbD5VtKBvA2KCwKsA4s1sFNtQTQ83l6JZZg4hMWGXdF4oHBMOylXPq1IgQpA4YU1Vdi5Ke4FIGrs/ALYkNihBqahssIQfmArER9op5OcwG+ExQGGDvM7wKxeSLHCuX5hKkI0+SkZS+eSzMYrUM9ykEVJKqzdvGLIdrQmKmCXHP13NOkT9s8QRgQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=azAj2tHya4WZmxF4SCpdsFN2ALajhn+suTj/DGpBRMY=;
 b=VPNCQtJLY4sUiNNB4qgqtoWrKl+JOk9mv8lwNcMgvhit0g0Q5xPJXO47lOSDb6USh/1foVmr9eFbfQoCRoDYbfoDcoDmPvFtIM6TGon3X++3srikXiev2gC/NmGaUbfgO4nBcSHsiEnDcAO5x2FEnQDEfa9bNN+zSi7gm7QkN68=
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by AM9PR04MB8873.eurprd04.prod.outlook.com (2603:10a6:20b:408::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Thu, 8 Jun
 2023 09:58:42 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::ef9f:1e01:e8a:6a4a]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::ef9f:1e01:e8a:6a4a%3]) with mapi id 15.20.6477.016; Thu, 8 Jun 2023
 09:58:42 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     Robert Hodaszi <robert.hodaszi@digi.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "jirislaby@kernel.org" <jirislaby@kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
Subject: RE: [PATCH] Revert "tty: serial: fsl_lpuart: Fix the wrong RXWATER
 setting for rx dma case"
Thread-Topic: [PATCH] Revert "tty: serial: fsl_lpuart: Fix the wrong RXWATER
 setting for rx dma case"
Thread-Index: AQHZmSvTxz5ihqCiWk2vZTPVoQT3dq9/Q3MggAAcbwCAAMuvwIAAezoAgAAFkQA=
Date:   Thu, 8 Jun 2023 09:58:42 +0000
Message-ID: <AS8PR04MB840416EB91176287C91C88BE9250A@AS8PR04MB8404.eurprd04.prod.outlook.com>
References: <20230607103459.1222426-1-robert.hodaszi@digi.com>
 <AS8PR04MB84040A92A1FBFE8177CF08D59253A@AS8PR04MB8404.eurprd04.prod.outlook.com>
 <347fc250-ed9e-b448-2ff8-b604faa14e7b@digi.com>
 <AS8PR04MB84042413F6C9ECD80A1E87639250A@AS8PR04MB8404.eurprd04.prod.outlook.com>
 <76357719-c5df-6c15-add7-a955c7d106ed@digi.com>
In-Reply-To: <76357719-c5df-6c15-add7-a955c7d106ed@digi.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8404:EE_|AM9PR04MB8873:EE_
x-ms-office365-filtering-correlation-id: 35eca182-fd10-4371-7281-08db6806f0ff
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6MR5bpVTRupwrqI/pfbmqWfsqR2lfWpcqbwsAA5vamwJsXlt65R0euF5gFs3qnK3+PW6F9rCjhqqdPgdlLirIBqPFxoF9gQ6BQsPLXJUE8/RMW/9h0IKZLjj8gYNs0kkiyEwIHKFGhxtL88huieSJr5cgSvR9OG/tWO/daJ7z43W6FUeF4vDgZDYpIOnnaMgOkteB0PVfOo9+vNgazp0tN3c5bq3X9ok7WJ/XeNtzXN8g6LEG2y47CQAImk5w3YUL2pk9tkct2g6VWz17pjbUIjkY0Anh/UREYSgQceLkRbEiDHcxAjsuPePIGtcVtm/u9L0rMbYBY8q0EagPAEkhN3/BElrtKBBF3t/z3Q+39kIHyBu7mzWhmyDuyA6f7yUw9KCvmKXxIObelNpu7VvakdzKKdfojvrRUR3e45cpGalFzsy7+9uQqK1SC/OFxioaTTfoLEbkUHFTEdXqzKM1fsrE4dGpI57tELOKSVz8HZUsU85/vuoPmYYQk/P2+DOPFcf70o0YNr+7MiAAXIfACJog6Yu5i8oPMMZpdsb0ubbWu6w5Dpw3BLdctpLDIiHlhxnhB6vfOoyQVc2idshWyVczRVWXvDoxin2mUYxMTI0lyXhoYkPOpwrQsGCTnkO
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(39860400002)(346002)(376002)(366004)(451199021)(8676002)(66946007)(8936002)(66556008)(66476007)(76116006)(86362001)(478600001)(7696005)(64756008)(316002)(41300700001)(66446008)(52536014)(83380400001)(44832011)(5660300002)(55016003)(110136005)(2906002)(4744005)(71200400001)(33656002)(186003)(38070700005)(53546011)(38100700002)(122000001)(9686003)(6506007)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N2VkNzkxUzQxRWNibWRoNWZZY2djaTJINU9xNWFzOHhOWEdRcXNlZEZXdE0w?=
 =?utf-8?B?eUpTVnBnMlFjUFRsUjhLSjdsTWhLeFFNdTFsUkFQRjVNcjZEN0NxdjFkVHVU?=
 =?utf-8?B?OS94ZC8zK3FkUzZsb21ZamlaRHJ5bTNzMmdja1FTeWlJWDYxOHRoNC9hbk1O?=
 =?utf-8?B?ZDNQOUE3Nk4vUFQxMjlLckZiTmptYzMweTUzaDZYa1FOcUJxM01ZWGZuVk00?=
 =?utf-8?B?NEJsSDRHemhYblp6cnp3dENaWnhhVmRrbmh4U3MyejNYdnp2WW0yckdaNnZR?=
 =?utf-8?B?OVg1cjBlUzRMT1RqQ1JRdmxpbHpjYytrN0dZdEhGTURDVjQycGtNY2NqRFAy?=
 =?utf-8?B?UkJzcXVXRjJXRk1JYmZBb0Q0cE9uTDRrZ0tVSmlaWGFmNGlHTU4waDY0MEs1?=
 =?utf-8?B?elVVT2lkcXg0YitXemcrSG5Uc3UzWFhiSzJRMVk1ZTlzUDVNaTRPYVhpSjRB?=
 =?utf-8?B?emhkeHlqcmlCcmpBdGFNMkZkWFVNTGQ4TkJJRlZPQXJqSXhOYndoQzNUMExY?=
 =?utf-8?B?Nmt0c3ZxOEQ1RzJPbXZtVHk2WkZJQmUzNk1sRzVoNUI2dkRvaUxwZ0FsTUt3?=
 =?utf-8?B?U05UZFgwclJzMFZiRVgxMUhoMzlBWmdHTzZyY2pXcFBCLzM0eGZsVldSOFVz?=
 =?utf-8?B?bDNSV25DeUpWb1VtRER5RXdaczV3aVpTVS9jQUJxUTQ3T09XOTRDbi9RQ0xO?=
 =?utf-8?B?bjQ0QTVWeTB2VlVVbWlsSmU0ODE5dktaUmF5d25ja0tMVTgvdnRXcFAvTkVT?=
 =?utf-8?B?YlV2bjQ0cTk3bDNZWGl1NG9DSmQzbjhTcXJIRVR2U2wxeGVNZkE4V3FJbzBr?=
 =?utf-8?B?NHdnUlJHQ0luMmREMmF0K2xPcGtLaURHQzd0akMyay82SmtSdlFESWxUcE5B?=
 =?utf-8?B?NkllbUlLS0VOajYyZHRSLzlLT2ZqK3k1UDRDTTJYK01RTTRLM1I0TmhsSVBX?=
 =?utf-8?B?MnhmeGxSMVJ3bHk3RlV1cGw5N1VTeUdzdXM1SmhmY3R2ek1ENmswZ1B1QnRD?=
 =?utf-8?B?b0M3eFVVZmxxWWVSUk5ZSUtQNHhwTlV0RkVTRzdpNzlqLzk1Smw2TkZYTVRW?=
 =?utf-8?B?TEFzODY3SThSaFRMeW8zVHpNUkk1aXdvbXR1dGhBY2hoNEcvZmpPa1hkQWN2?=
 =?utf-8?B?TnVnVThPNTRLelF4NkZ0bFhiUHdhLzNqdmdyR293YUJVR1JvbExCREdBdmpZ?=
 =?utf-8?B?a0NTN1NOajJrd0NEVlovTUkvQzhRbGgzNmxFQ3ZBUVRrUzd3ZG5uSjBqbGtm?=
 =?utf-8?B?TFRIWFVzSjJxUm1GQndvemNnTGxaVFhZZzdSQk1oOFBGeDFkditqNHAyNnUr?=
 =?utf-8?B?SVBnSmkrK21zUWUxUytsZWl0cWoyNEpJdEhJSlRYeGdScHQxQjVlUjltRURh?=
 =?utf-8?B?TG15TDZUT2ROWmphM1dtZW13clpubGI5eGRmbElZeXZQVGcxV0RsL2FvQnQ1?=
 =?utf-8?B?ZEFPc0ZZTTVyVmszV0VIRitRdzdwYVpSMHFFUGRqMDlHOVVXdyswUGpHVnB1?=
 =?utf-8?B?OFB2LzVqV0FMMC9zU251L3RxZ0RBVVhpdGd5ZEF6RWUzUncwSVJLL0R1ODQ4?=
 =?utf-8?B?UG1rRzVDYTRoRXhLUzAveFBWRldrMjZKcDA4ZG9lOFd3bE11VXFEWmwyb1Ez?=
 =?utf-8?B?ODlnOCtRT01ueU8rVVQzOFlia1RTcVJBSjFCcU4zM0krdkFXMTBoUnh0UktJ?=
 =?utf-8?B?bDhwREQ0NkdHN09IL0pIcG13Tmt4NDZiUGdnU2tWWnVLaGtoY1RNMVEwYUQ2?=
 =?utf-8?B?RVRuVWx3c1E0M2ZwSFNSRkt5cTBXRTlJVHBKRWxUV3BNbk56NmxFT3IxMHB1?=
 =?utf-8?B?SEFySURUeENROTZDdnVZNjBkQTdzd20zbVNSUzRacVdBWjVlVkdlbzllSjZL?=
 =?utf-8?B?dnpWc0JRZDBHRDFFY1J0Nk9sVURQdldqc3hvQk9hcUt0aEtjblFBczkzSFBQ?=
 =?utf-8?B?Q2xQVEJaWTE0NFRjeE1OaUF2aVA4bkZSM2tFOHEvb0RrNm1SNm5yZ0JKbmpv?=
 =?utf-8?B?K0MwRWx4d3pjZ0Y0VjlNWFNWN1hoY0NhZm9EdU80L2Y5ajIwMGcwZ2ZSWDB5?=
 =?utf-8?B?SlNsa1dLK3dJZWxnN1dPZndSdkhUdkNKVzVyUTl5WnlQb1lMUVdpaUdwS0ZU?=
 =?utf-8?Q?H+mI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35eca182-fd10-4371-7281-08db6806f0ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2023 09:58:42.5401
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EdyUHYYE4x8iAJER3FVCFrnBvs1S/JloQPcfd1oTxsZMWvnXgF+ohsTZm/J+QZc0qG7HioFuyp6h2krs7YSV7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8873
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUm9iZXJ0IEhvZGFzemkg
PHJvYmVydC5ob2Rhc3ppQGRpZ2kuY29tPg0KPiBTZW50OiAyMDIz5bm0NuaciDjml6UgMTc6MzYN
Cj4gVG86IFNoZXJyeSBTdW4gPHNoZXJyeS5zdW5AbnhwLmNvbT47IGdyZWdraEBsaW51eGZvdW5k
YXRpb24ub3JnOw0KPiBqaXJpc2xhYnlAa2VybmVsLm9yZzsgbGludXgtc2VyaWFsQHZnZXIua2Vy
bmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBSZXZlcnQgInR0eTogc2VyaWFsOiBmc2xf
bHB1YXJ0OiBGaXggdGhlIHdyb25nIFJYV0FURVINCj4gc2V0dGluZyBmb3IgcnggZG1hIGNhc2Ui
DQo+IA0KPiBPbiAyMDIzLiAwNi4gMDguIDQ6MjAsIFNoZXJyeSBTdW4gd3JvdGU6DQo+ID4gSGkg
Um9iZXJ0LA0KPiA+IEkgdW5kZXJzdGFuZCB5b3VyIGNvbmNlcm4sIGZvcnR1bmF0ZWx5LCBMUFVB
UlQgSVAgcHJvdmlkZXMgdGhlIFJlY2VpdmVyDQo+IElkbGUgRW1wdHkgZnVuY3Rpb24sIHdoaWNo
IGNhbiBhdm9pZCB0aGUgcmVjZWl2ZSBkYXRhIGJlaW5nIHRyYXBwZWQgaW4gdGhlIFJYDQo+IEZJ
Rk8uIEZvciBtb3JlIGRldGFpbHMgeW91IGNhbiBjaGVjayBteSBwYXRjaCBiZWxvdy4NCj4gPg0K
PiBIaSwNCj4gDQo+IEFsdGhvdWdoIEkgY2FuIHNlZSBSWElERU4gaW4gdGhlIGkuTVg4IFJNLCBp
dCdzIG5vdCBpbiBMUzEwMjhBJ3MgTFBVQVJUIEZJRk8NCj4gcmVnaXN0ZXIuIFNlZW1zIG5vdCBh
bGwgTFBVQVJUIElQcyBoYXZlIHRoaXMuDQo+IA0KT2gsIG1heWJlIExTMTAyOCB1c2UgdGhlIG9s
ZCBJUCB2ZXJzaW9uIExQVUFSVC4NCklmIHRoaXMgaXMgdGhlIGNhc2UsIEkgc3VnZ2VzdCB0aGF0
IHlvdSBjYW4gc2V0IHRoZSByeF93YXRlcm1hcmsgb2YgbHMxMDI4IHRvIDAuDQoNCnN0YXRpYyBj
b25zdCBzdHJ1Y3QgbHB1YXJ0X3NvY19kYXRhIGxzMTAyOGFfZGF0YSA9IHsNCiAgICAuZGV2dHlw
ZSA9IExTMTAyOEFfTFBVQVJULA0KICAgIC5pb3R5cGUgPSBVUElPX01FTTMyLA0KICAgIC5yeF93
YXRlcm1hcmsgPSAwLA0KfTsNCg0KQmVzdCBSZWdhcmRzDQpTaGVycnkNCg==
