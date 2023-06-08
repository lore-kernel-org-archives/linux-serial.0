Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09169C7EE29
	for <linux-serial@archiver.kernel.org>; Thu,  8 Jun 2023 10:45:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235585AbjFHKpy (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 8 Jun 2023 06:45:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235624AbjFHKpx (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 8 Jun 2023 06:45:53 -0400
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2056.outbound.protection.outlook.com [40.107.241.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 258AF270D
        for <linux-serial@vger.kernel.org>; Thu,  8 Jun 2023 03:45:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gZ7wk4s55r2kDmOeZ2/QGHgV7WPAqgo+IqxlwlB6bdYd0pSideOmmHonh7+J749tLgjajiqY3BS0cU/tugWT4SyqYwz7B6MyAU/ML/qilvXpjYy2twYDKynFAi6LiWwelEmkHKYU7VUKOvT1XhmIylqYQZrhDC121QhA/THY7YVxD4Ejj1+RXHp+NoWiPNjw0M3BZ5B2NZcRui2V8pPYteUeQVUKMbaBgi3agC2Uo1z/pN/zYWbP2VQXmaePDUe7i0B9qhntype8LHTHKi+fdC+82G981R+s0+2Z5rJgbFUm+HZNUcl8vJfaznAWTQryOMz39ctyQulRYFcBfMCVDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9DfD57M805drOa5Xih5ZHK/pyNhkhaR97pc+pvzy5Aw=;
 b=OemUcQduO1BkaoMuHPg9KYRvDvGdJKTLb+6hJuG8npUsCfa/4l1sUDaRXzhRCAN68XipW9oaVwpZZ5Zrq+aWK0PWSk3Xxbn4u+nAkEmH+pCscKalUO3ishDVmS2BGujKXWiBTCbJOxUMmyrARrPi2IRgmY8hXbfH4LrAvEkwQZdKZd8geBI6VFoxIkwFw4JkEnBUMN9zo6M99fhcMDfQjxAjaWJ5PUc3/z3E+uLVtbuv+PF2tHSQXPfCEBq+2K3NmtJXXQ6E1wLq9UdfTV1H6H2sidAPM3/LYL928zCbUx9EQfVQE1rECJMsn9kGPQB88GivSLvvKM9rf10ypRDLKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9DfD57M805drOa5Xih5ZHK/pyNhkhaR97pc+pvzy5Aw=;
 b=hki75JkK1CBh9LdtyWnrpvcRCRUnf4FzpXDZV5CHZuttb3RG7tsODEgxFehZxO7eyNNAW95IRt9IaST/CxVHlg939xPUbxG2vkQj8WXlcplc1PVbVmUDCx7mEe535eoUqgDRlsLgXfNRIgzSQMCGFSwBtQruBylUK2nJwvcrN5g=
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by DU0PR04MB9671.eurprd04.prod.outlook.com (2603:10a6:10:317::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Thu, 8 Jun
 2023 10:45:49 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::ef9f:1e01:e8a:6a4a]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::ef9f:1e01:e8a:6a4a%3]) with mapi id 15.20.6477.016; Thu, 8 Jun 2023
 10:45:49 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     Robert Hodaszi <robert.hodaszi@digi.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "jirislaby@kernel.org" <jirislaby@kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
Subject: RE: [PATCH] Revert "tty: serial: fsl_lpuart: Fix the wrong RXWATER
 setting for rx dma case"
Thread-Topic: [PATCH] Revert "tty: serial: fsl_lpuart: Fix the wrong RXWATER
 setting for rx dma case"
Thread-Index: AQHZmSvTxz5ihqCiWk2vZTPVoQT3dq9/Q3MggAAcbwCAAMuvwIAAezoAgAAFkQCAAAWCAIAACC5g
Date:   Thu, 8 Jun 2023 10:45:49 +0000
Message-ID: <AS8PR04MB840494F96C9FC354827FB5579250A@AS8PR04MB8404.eurprd04.prod.outlook.com>
References: <20230607103459.1222426-1-robert.hodaszi@digi.com>
 <AS8PR04MB84040A92A1FBFE8177CF08D59253A@AS8PR04MB8404.eurprd04.prod.outlook.com>
 <347fc250-ed9e-b448-2ff8-b604faa14e7b@digi.com>
 <AS8PR04MB84042413F6C9ECD80A1E87639250A@AS8PR04MB8404.eurprd04.prod.outlook.com>
 <76357719-c5df-6c15-add7-a955c7d106ed@digi.com>
 <AS8PR04MB840416EB91176287C91C88BE9250A@AS8PR04MB8404.eurprd04.prod.outlook.com>
 <2e57e76d-c47c-8109-722f-224f9f9a1a42@digi.com>
In-Reply-To: <2e57e76d-c47c-8109-722f-224f9f9a1a42@digi.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8404:EE_|DU0PR04MB9671:EE_
x-ms-office365-filtering-correlation-id: 513cba4a-7a1f-4c38-bc30-08db680d85ee
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tHDZy5nOtUP8fu4KrpnsWL32pjgwEltxyTNyvo1BJ1lojshvlSKR+8hgB1P3072CLj+G76i1MNcUMorROdk98BrcsbOwSSbkLAQSm0E+7bHP21QgDM6/+V3233g03CZeOpiipFRE96pdICzHtr6UX9AVn9ej2Z7EulqO02dIBwI1CBUCwh2gwObpgyGpNDeRDDe28yLh1+KWuxEilr8D+l4jxVw/rKjj85xqdzKjgeDEroMoT17Uz0zC/ID4sh22fvt5ugBHVGP2dp1vQQIftuM1XhDt060bGt06XWTV2IFmvIphs947Gx38sRQlIimcwFV3vZVM//5XjMhhefXM+Q/p3WMsJg+eCyTHV+YRVQYjoKvq7A2os6HVswuWpGgq+NoYWgOANCgV+v7Kd+ZNMHTLEDXoe8AkZir+03R+OPikgxym7GXn0mQ77EP4YYeZ/sNCywhzyLjwilwU5HEkLbxjQS1ExycpzsQPvZxp3QqEgRw6+lvjk+Gpcj81k6Lc0eRS8ivHW3grbqaaIJZ/9B0vZ06Q8zBwsUFwAIOb1ZLc3VUj9we0AErs3WR7ReryYBFtttkVWiHboGMcdPFCzovaM+UYimyT0nvStou316QZJ5UzqR6IMTZ+3cuCVR0N
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(136003)(39860400002)(366004)(396003)(451199021)(110136005)(71200400001)(2906002)(38070700005)(478600001)(33656002)(8676002)(86362001)(52536014)(38100700002)(41300700001)(5660300002)(8936002)(55016003)(316002)(44832011)(66476007)(76116006)(66946007)(64756008)(66556008)(122000001)(83380400001)(6506007)(66446008)(26005)(53546011)(9686003)(186003)(7696005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OGNDZ0RXODJwdFcwS0EzYVdtYU9adWVhd3htTXNJdVZhTHcwdmZpZWRMUFEv?=
 =?utf-8?B?aEw5R3NCeGdKaUdSK0Q2eEdmNTNOYWJ5clJXR0gvSE8wUFBrT1NPMkxCMEFw?=
 =?utf-8?B?VjlkTEQ5MkVMT09LOWhpTUlMODU0SUprRWg5Sm1iaExTUXplaXN2bzFUMk92?=
 =?utf-8?B?NXF0OENGUThIYlhJNUU4M1JwaEdVWDJyT0cyZEpIZHE1WU5qVUxsZmNCcXpU?=
 =?utf-8?B?SkNmT3VKVTlyNW9WK2xXSG9DWnFkUjdscTh1V0FWeWcrUmFOMHRsN2ZOM0hh?=
 =?utf-8?B?SG52YzJyNFBpbklYWGlETVpRemI5eTN5cGNONlBrbmZXeFduZG1md3FuaG5l?=
 =?utf-8?B?enpiUTdPWU4ydFlzaTZsaFdUeEhBMkIxUzZtMjBpblViOFFxMVU1WlpsNGEr?=
 =?utf-8?B?L3BLN25JNUU4aTBoRjVlWU16RHJSc0U3VEhNZDhVbHJzOUFJQ0NER3RkMjN3?=
 =?utf-8?B?cEFtMVhYOS9TRWRoNkJDV2xGQ0NXL1doRVIyN1BNZ1FmRzJJUTk5ZW9Jc1pH?=
 =?utf-8?B?ZVFMZUxUc3czRDF4ZDFIdTZTRlJmUkNkeGFmUXVwYUpFeVltWWVtOEpxTzla?=
 =?utf-8?B?LzZVSmxBSzBPbDJlNGxmeksxWHpTZisrNXpkTWFjKzlLYlJ1TWRCSVZHVkc0?=
 =?utf-8?B?Q0t4c3ExdzNQMFdMZ1ZPOThVdTZoVkZDU2pJVld4dE05T1hZR0pXNCszQ25r?=
 =?utf-8?B?MmlZYzhNckwyZU5CNXV2WjdzMUtVQVlCckp5cHVabXg5Z0I3SHZKRU5uT3RR?=
 =?utf-8?B?S0xWRlRxWWgxRnU5TlFQL01mWlpYQzFiT2Izcm5kRnZSUUdEeEwweDFxSzQy?=
 =?utf-8?B?eDUxZnNIZEJsK1I4ZWZXeWFCOVM1cHV0dWpqU3RDK2pDZFJwL2NNQ3I5dEtD?=
 =?utf-8?B?cWlXMEFlMzgwNEhScldiTHNvWFZuNGxseDYzMnFhQkp3VkM0QTVYNEtKb0Zj?=
 =?utf-8?B?VjFWWTJxWU02SmU5TjNUaGFtSC80d1N0Q1lMS3JMRkVmSmxhd1Vjck1sY2lF?=
 =?utf-8?B?Y0RkbXduN2MvVG80RUpvTVBNRlkwKzBIbFZzejlYQ1hJNUd2UXR4RkRLZzJo?=
 =?utf-8?B?OG9MdTBFcE4zNm5GRUQwVWlnTVUyU3dScW9YamNBNVFMSnNXUitRV1pFZmY0?=
 =?utf-8?B?V0tQVnZrd0tnbW13VWU1cTFPVjdWZU1McERkYVhGdHNZUmhvTE9rQXVJQ1B6?=
 =?utf-8?B?TnhVcEZ5OGFJTERIOGZrakUyOWc5bU9BY1E4eHZ1eDNHMmJoR3NSamZEVVBQ?=
 =?utf-8?B?clRiSjA2Z3hGVmhUNU5aSVpSbTgvajhXalBsVFlFNjY3bVZCSUJrM2xtVDg5?=
 =?utf-8?B?YlRWK0VuL0NaVWFiT3NFUjZ3VlN4eFhnNURUUHRsQlVtWkdITGo5YlpzNGlN?=
 =?utf-8?B?QlhUUlYxWkpiYkRlUXVFb3JhK3d5L21ySlFwY1F6ZHI0a0lNMHBIcTQrb1RZ?=
 =?utf-8?B?VURYeEI5eVg0eDR6ZVBrNFAwQmVtME85MmJBNWpYa0YwQVhYTytYNUZiTWhF?=
 =?utf-8?B?VlJUWlZmeElQSGIydFZTVWVwdFMwRUh6N2lzbkFUNWVlUXQzZlBUdldoMEFp?=
 =?utf-8?B?bm9rc0hkUWN5VndPcGlTc1prTWhGOTBuN1JLT09Dd1llSmFNKzBKcEVyajFn?=
 =?utf-8?B?aU0vbVlCeXVXRkQxNEdHczBFODErRDdzZzVYbzl3NUNCY0ZEWmdWUy9ETGtr?=
 =?utf-8?B?ZVZNRzE0eUtYNmd1RHFCeDlpYndObWNYeENscERCVlpzb1VGbEJTVXRNaGdL?=
 =?utf-8?B?WGxIc2hlU3l0WEdjTXNXY0o0bFNlZU1IeVBBdWdnWEhZZmtvdk9FNU1SRFNl?=
 =?utf-8?B?QzdjalVpR09Zc05LZ1E2WU4xaGNkNGoyTzQvSjJYTDhrUm5sb0NXaDBnUlZV?=
 =?utf-8?B?OUlRb0JlSDgxbkpsZi9jZ3N3R2M2ODR4UlcyWi9tTjl5SjZGa2VHTytGTFp3?=
 =?utf-8?B?UFdOQmR4cHAxVzJoY1dncHRIRk80bkMrbFp4c3p4WWVQVmNMSFBSb2RDVmpM?=
 =?utf-8?B?dUtwU2JucWpUL0U1V0VXZHBObTFsd0FvVUdvSGk1UnAzeTcyQ3c4R1lGbEp2?=
 =?utf-8?B?andrMmN0WFFxdEdyU001T1hlMjJmczRubXZySU4zN3VWWTZ4VnZHM2JPS0RG?=
 =?utf-8?Q?Ef34=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 513cba4a-7a1f-4c38-bc30-08db680d85ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2023 10:45:49.3498
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wRgSNmyF/OMLo0mTtnbpTWHzUgjqVQ59/Ycz74zwXVXUTBZTOQI2MCUf9ZYDtuupnkHEeBmBsRJ4cGpZTudxBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9671
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUm9iZXJ0IEhvZGFzemkg
PHJvYmVydC5ob2Rhc3ppQGRpZ2kuY29tPg0KPiBTZW50OiAyMDIz5bm0NuaciDjml6UgMTg6MTUN
Cj4gVG86IFNoZXJyeSBTdW4gPHNoZXJyeS5zdW5AbnhwLmNvbT47IGdyZWdraEBsaW51eGZvdW5k
YXRpb24ub3JnOw0KPiBqaXJpc2xhYnlAa2VybmVsLm9yZzsgbGludXgtc2VyaWFsQHZnZXIua2Vy
bmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBSZXZlcnQgInR0eTogc2VyaWFsOiBmc2xf
bHB1YXJ0OiBGaXggdGhlIHdyb25nIFJYV0FURVINCj4gc2V0dGluZyBmb3IgcnggZG1hIGNhc2Ui
DQo+IA0KPiBPbiAyMDIzLiAwNi4gMDguIDExOjU4LCBTaGVycnkgU3VuIHdyb3RlOg0KPiA+IE9o
LCBtYXliZSBMUzEwMjggdXNlIHRoZSBvbGQgSVAgdmVyc2lvbiBMUFVBUlQuDQo+ID4gSWYgdGhp
cyBpcyB0aGUgY2FzZSwgSSBzdWdnZXN0IHRoYXQgeW91IGNhbiBzZXQgdGhlIHJ4X3dhdGVybWFy
ayBvZiBsczEwMjggdG8gMC4NCj4gPg0KPiA+IHN0YXRpYyBjb25zdCBzdHJ1Y3QgbHB1YXJ0X3Nv
Y19kYXRhIGxzMTAyOGFfZGF0YSA9IHsNCj4gPiAgICAgLmRldnR5cGUgPSBMUzEwMjhBX0xQVUFS
VCwNCj4gPiAgICAgLmlvdHlwZSA9IFVQSU9fTUVNMzIsDQo+ID4gICAgIC5yeF93YXRlcm1hcmsg
PSAwLA0KPiA+IH07DQo+ID4NCj4gPiBCZXN0IFJlZ2FyZHMNCj4gPiBTaGVycnkNCj4gDQo+IE9r
LCB0aGF0IHNob3VsZCB3b3JrIGluIG15IGNhc2UsIGFzIHRoYXQncyBiYXNpY2FsbHkgdGhlIHNh
bWUgYXMgcmV2ZXJ0aW5nIHRoZQ0KPiBwYXRjaC4gQW5kIEknbSBub3QgbG9zaW5nIGFueXRoaW5n
IG9uIG5vbi1ETUEgY2FzZSwgYXMgRE1BIGlzIGFsd2F5cyB1c2VkLg0KPiANCj4gQnV0IHRoZSBv
dGhlciBwbGF0Zm9ybXMgc2hvdWxkIGJlIGZpeGVkIGFzIHdlbGwsIGFzIGl0IGlzIGEgZ2xvYmFs
IGlzc3VlIGFjcm9zcw0KPiBwbGF0Zm9ybXMgdXNpbmcgRE1BIHdpdGggTFBVQVJULiBTbyBwbGVh
c2UgcHVzaCB1cCB0aGVuIHlvdXIgcHJldmlvdXMNCj4gcGF0Y2ggd2l0aCBSWElERU4gZm9yIHBs
YXRmb3JtcyBzdXBwb3J0aW5nIHRoYXQuDQo+IA0KWWVzLCB0aGUgUlhJREVOIHBhdGNoIGhhcyBh
bHJlYWR5IGJlZW4gdXBzdHJlYW1lZCwgeW91IGNhbiBjaGVjayB0aGUgbGF0ZXN0IGtlcm5lbC4N
Cg0KQmVzdCBSZWdhcmRzDQpTaGVycnkNCg==
