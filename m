Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18675C433F5
	for <linux-serial@archiver.kernel.org>; Fri,  6 May 2022 12:22:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356018AbiEFM0D (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 6 May 2022 08:26:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243253AbiEFM0D (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 6 May 2022 08:26:03 -0400
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-eopbgr20052.outbound.protection.outlook.com [40.107.2.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD84927B07
        for <linux-serial@vger.kernel.org>; Fri,  6 May 2022 05:22:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RW5HfyYV+9I5dw5aV425hXiaf+8PH3u/KzXL6E4Ysd7zM9hPE76njNTWry64qp15ehrfVIOoIrUjR7ko3SCmIlKX/tfL2ilQGnlsIqdzWHnZDSN++/psk4Dkci0uWfLK4J4urR0zmV3rCoXlRG9+PV2rRm1xDo5BF1KYGdxLmRB9AIgQS0FWRkilzR5ELF+Zx4jkpaCWWhJWT/26+tQ2ylZJvKbzhXt2Qf8tBX+JOoun2cGIX4jw7+efQ/K2vANL1X64PfUEysV/jdFkiJmY03J9aX37B3UoCE+ivLZsObyUA9h6NpxKEEJEedwwSGCr4aK9BxfDYcTSp53ZHPTYLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l9TXqpktHjQMmuBLVetnEuO7XBlIqHP6tsLgIdpfl8I=;
 b=hmiPhy6W0zPdi2dIPxaRQ8bELCMcJvFrnWMvUZ3MG0/s+IMT8Ye/K1j0iOC3CQvQwUTU64VQFNWy3y0J/xf/mj4bThY6UCLRL4/URiJQMgl86S0kVoSxw7NEj/xMose876jLqnW6nV1StLhdes0uv4QQEcko0ZRr8aseMKTvrRjV+DTGqbkyZ0fgCGQPB0x/kOBeuXo1d4LHeC0Xbwmk5BezNGNnfGfYkx4l2qxIaRoM9mA0hHfxrwcb8iUfgCHS/TrVqDgj48Eugh6g20O6vqyhbuzwuFshZPeP3rL7MKxsotFu5zT+eP2NLIPHVGpjSkeDjejeqUV+j6nZzwyWag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l9TXqpktHjQMmuBLVetnEuO7XBlIqHP6tsLgIdpfl8I=;
 b=dx+xyZyBQiDSqF2YSp94qCeCU2hLG1I4v5OPefN9BT3CPEyqvVxZJAmbv0cQCGWqbctdcoJ7J4lMZT/LNuUEFTwwDcSdC+xolR5OucveXQRAh2Ecf2CcaiBUYAw41Bc4exsEo66KCejUq8O6ZLgLCEjbRXURI0JSUW2mgcXX4To=
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by AM0PR04MB6962.eurprd04.prod.outlook.com (2603:10a6:208:188::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.18; Fri, 6 May
 2022 12:22:16 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::881e:9703:7584:80d5]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::881e:9703:7584:80d5%6]) with mapi id 15.20.5227.018; Fri, 6 May 2022
 12:22:16 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     Indan Zupancic <Indan.Zupancic@mep-info.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "jirislaby@kernel.org" <jirislaby@kernel.org>
Subject: RE: [PATCH] fsl_lpuart: Don't enable interrupts too early
Thread-Topic: [PATCH] fsl_lpuart: Don't enable interrupts too early
Thread-Index: AQHYYHYJyutbBS0lkUSU3h0HcV+V+q0Rxbvw
Date:   Fri, 6 May 2022 12:22:15 +0000
Message-ID: <AS8PR04MB8404BB0414AD81827BD559B292C59@AS8PR04MB8404.eurprd04.prod.outlook.com>
References: <20220505114750.45423-1-Indan.Zupancic@mep-info.com>
In-Reply-To: <20220505114750.45423-1-Indan.Zupancic@mep-info.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bcd457c3-6b81-4119-9ae8-08da2f5b0eba
x-ms-traffictypediagnostic: AM0PR04MB6962:EE_
x-microsoft-antispam-prvs: <AM0PR04MB696220F73C97FD67F6D422BA92C59@AM0PR04MB6962.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ja5Rw+jW318GugfmM9HTUstbfBnlgBQjPJ5hY+3VSOYOYQTAfZdXy2vFrT8zBf7kJfEKDX+gdM1cTwoIcwXBTULyXKDJveul7zkfWxkmokTmfZRr4UoB+8E96Cf4DVV+U8CfJQCTvdBG3K+6LIVWCaw7G/+FhG7Z9NrsHLMWxZjJARqsWO+RNxiZHIS3rNaKaCHzoq14vDewfG58qCcq+Tumb7SwHCJVnWzinNB9h2J3XYgLtaXw1m/SanunGN88Oi9f0GowxgB1DTlmRiHNDEcXLbO01/hlzDVqqIV6B5lnDSxTuHhp0eO5wkHEWTMoT97Hy+ta4cT7cgzyt0RbpXHOaOmT38Cj/tgZ1qeigj4aAgPeTYxJ0ORkXWGYq23MPtX2xQ64CqjaTpoBgWA5b9KeO7DrdGgCAPAYvA2aCsqKKeXmctqOqpB5xgXbgoLcwz1xBIk1OOU9BL0FvCZTF2rIavCX8PY1wz8hvCMboQdWIqIOfvnJgiiU+xFj1hLijx9RULidirlQ3XjoZUmv9kpji/cubYNrc6v3JgOgKhpqIKqoG7L3pMm9aAxxGc3xZfCYnWjEUp+5T0yNgcal4z6nfKH1KOQQ8W3xDd7nSc/SJWFtLjPhErl1SaojvGVvPZYAY3vSOebcYirPCgsc2bgFJViXv2l+FxEkGhwCr+p8q5NIN70mtjQEz2dFRECVCb2WoFE4Dx9M2mPEL22/mg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8676002)(4326008)(33656002)(76116006)(66556008)(110136005)(64756008)(66946007)(8936002)(55016003)(508600001)(26005)(9686003)(54906003)(316002)(66446008)(66476007)(7696005)(6506007)(53546011)(44832011)(71200400001)(86362001)(83380400001)(186003)(2906002)(52536014)(122000001)(5660300002)(38100700002)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?N3AyMUtWdldJYVNZeWIvYldIbndXSmZBRCtkMjByUk0vWk9teTZDR3hPUzYy?=
 =?gb2312?B?Y1BzRnprZW1yV2pYdElwM3pXZWtmK0Y5VXd4a0t3ZWZRTXR3dVlRYTJxZGlW?=
 =?gb2312?B?YnlBYks0OXZuRnFVeFhHVnpIWGo1REI1d1ZmNHRuTUk3Qm91WmdzVVNka3dR?=
 =?gb2312?B?UW5vRmlLL3NmK1NRVTlKc2Fvdk9uMHoxTnVGbGhpU2xvNDhQc2VOV2lMOVhS?=
 =?gb2312?B?Nk5JNy9lM2lxWTIzWHROTllaT1ZGRm1tMFphalJMcmRuYjRaVXZ1dEpUeG5t?=
 =?gb2312?B?cHJILzlwKzFkTDNpTmZFQkZoUFo3ZFdwR0tpR0dPTlBuYlZuNFlxTmdUU29K?=
 =?gb2312?B?K1UybUFTSXVuQ3duWHNGYjJucytUMmlYY0RrSkFGdTViVmtWcEpMUC9JK0li?=
 =?gb2312?B?cTdPR3l4TE8yQ3MrV3NBUG8zNGtaeHFnbHgydlZBK1hCcWErRXY5L2RJVkRE?=
 =?gb2312?B?VWNBRXhzRnNEaExjbnJCTmdXRFFwcnYrRVBMV0pmbjZaVG5kTTNqbEt1ZlFk?=
 =?gb2312?B?R1k1dFF4cHYrWkV0eGpSLzVWSXVMRmNrZVBVNmloVG5PTWdTbTh2eGNjYTRs?=
 =?gb2312?B?RzBCbVZEN21lNjJhdWlWS3JDQWIveVJrNGZNUVIwZVpBVEI2VW9xUk5pR1N2?=
 =?gb2312?B?RUVxR2dvN3ZDSGY5Q0NBRzBxdFRGc0twdkM4SDFnaHZwVzdoUzh0QUlwVEda?=
 =?gb2312?B?RGwzTnhxekFkSHBrWTVSUnk1ZG5FQjRjTktKUjZ1UG8wdFpGVXVxdlk5RkUr?=
 =?gb2312?B?QThrckIyTzl6MkFseXZOWFFJOHdEQ3Q3eGNkcHEzN3R0ejRTQmVMSEZ6cThB?=
 =?gb2312?B?V3FhZUljS0pCNlB6NzVtM3E0ZDFPTWc3ZnhKdzh1alhVYXVONmR3YlB1OEhL?=
 =?gb2312?B?Mnh4RG5aVUlKaTNnRm5rRGJFLzRIeDVpbC9XbWJNblByQUdBaUhDcXM4b3NT?=
 =?gb2312?B?OXVTazYvQk5aL1NaMUFxdnVnclhPa3h0NkgvbjJlbnZCbk91RkYvS2dqVS9t?=
 =?gb2312?B?WXowSWVhVk0wc08xS2VlUU9XQ2pvd29nZ3BQMm93YzhjdTE3TmJlNzUyOFJw?=
 =?gb2312?B?Z1l3NU8xdzJEdWdwSkF3RGE1RGNtcCtiUEVEa29HdGNIc0tFMmRZNERDdjhK?=
 =?gb2312?B?N3htTnpJWlRGN2tHN0FpUCsxaGVuWFY2L3o2YXdveWo2L1diaVdQem9WMWJY?=
 =?gb2312?B?OXRRSG4rN05WaHQwMGFIc0tiZUZMblV4RkE3NkJVaHBTVTU2Y1YxV2k3YUJy?=
 =?gb2312?B?bmZLR25KYkd1enRRZ0FtTVlFSmQ4Qk5qOXdHajc4SHBaZ20vdSt6STdBWjhz?=
 =?gb2312?B?RG9vL0JWRGtSTVgxeGFzTnNTb3FjY0FkZDNRQ3JYeENOM2VZVmpXU0xEbElV?=
 =?gb2312?B?dHNnMFhxWnRPMnEzK2tMMHBYSDlhTGloWXJqYytCeUduN1JBTFEyUjhlSGQy?=
 =?gb2312?B?RHBFRGpCM0VqYiszTUVyLzM0dlpyQ2poeDdNeTh4U09PYW91ZTZacGJ1M2JW?=
 =?gb2312?B?MXJPdzFUQ3FYTTI0NXNPazY5U3psVEhOQU9ZbDhWNFBjNlVRcXhSRUpvS21Y?=
 =?gb2312?B?bnNaYlQrdDNWaHFYNGdNTElvVnJ2eXBYb0p1aWlMS09PVG9YdC9jbDJ3L1ZE?=
 =?gb2312?B?ODJNbldZN3Rkd0hpaVFDZXVHWU5HTGJMMzNnSGg3Nll4WGVsNWVablJCdEtL?=
 =?gb2312?B?c0JIU3NtSUg2WGFiRmFka0NsTGlPV2VtL3FMcEpRaGp0VzVLazdpdkZLUnNq?=
 =?gb2312?B?VXAwMFEzTnFhWWVlbDdHWjYzaC85NlNMQlQ0ZlZkT2twaHZhZmI3UStYaWlG?=
 =?gb2312?B?Szl4bU85TlhTVXpHSXFtZFNFb3BIZEl4SW9FamlwTWlUUUx2cko0ZEorbHBY?=
 =?gb2312?B?ZUxtcHMyNE14SzlJV0FJbnRJZWkrVnZOTmNJSzRqWFhMYXhSOXdyZ21ZY1Z4?=
 =?gb2312?B?WDhWd1M5WTA4Y01Da1NvRkFvZzRYZDI5eFRPYzY3SWgrUk5STDFoVzA1d1Zw?=
 =?gb2312?B?YUoza0U1UC9nenZmUDZWRDZ5YjBqb0w0aEFSNlRnYTdrOGVPMVdHQWZQTGx2?=
 =?gb2312?B?Ym1HTlpuQW1ZVXdDRFVyYkMxTGpjMUQxVm5IdnpZRWVqTitXVEZPekZSK1VG?=
 =?gb2312?B?SEs0dmFNelZsZ0M1REEyY3lGL3VmUDZraDFPdjdwZEJhdnYwRUdmaU8vTGp4?=
 =?gb2312?B?dDVJUGpXa2tDYVFnNVNhN3JvSGZiQjQ5aksvOWY3YTFyTnE0Q2dOYWd3QjYx?=
 =?gb2312?B?N3NmUTFQZFgxcEI1Q3kyVDZTRUdWVWRBTTd5dHg1YzF0bWp2MVZ0a2l5M2Nu?=
 =?gb2312?B?RWxndTNsMFVFREZBSHhLSTBETEIzV2F0cFNTeEtGQmJtTjAyWGxEUT09?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcd457c3-6b81-4119-9ae8-08da2f5b0eba
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2022 12:22:16.1673
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LNH08S/g8UNLBzAn8Bo65HMR7OkIsRKuAkhazefVLQkfShSdwHauEKyGx+kUtWje3jm/tbJBJXrPMQ2nLHnjwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6962
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSW5kYW4gWnVwYW5jaWMg
PEluZGFuLlp1cGFuY2ljQG1lcC1pbmZvLmNvbT4NCj4gU2VudDogMjAyMsTqNdTCNcjVIDE5OjQ4
DQo+IFRvOiBHcmVnIEtyb2FoLUhhcnRtYW4gPGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnPg0K
PiBDYzogU2hlcnJ5IFN1biA8c2hlcnJ5LnN1bkBueHAuY29tPjsgZGwtbGludXgtaW14IDxsaW51
eC1pbXhAbnhwLmNvbT47DQo+IGxpbnV4LXNlcmlhbEB2Z2VyLmtlcm5lbC5vcmc7IGppcmlzbGFi
eUBrZXJuZWwub3JnOyBJbmRhbiBadXBhbmNpYw0KPiA8SW5kYW4uWnVwYW5jaWNAbWVwLWluZm8u
Y29tPg0KPiBTdWJqZWN0OiBbUEFUQ0hdIGZzbF9scHVhcnQ6IERvbid0IGVuYWJsZSBpbnRlcnJ1
cHRzIHRvbyBlYXJseQ0KPiANCj4gSWYgYW4gaXJxIGlzIHBlbmRpbmcgd2hlbiBkZXZtX3JlcXVl
c3RfaXJxKCkgaXMgY2FsbGVkLCB0aGUgaXJxIGhhbmRsZXIgd2lsbA0KPiBjYXVzZSBhIE5VTEwg
cG9pbnRlciBhY2Nlc3MgYmVjYXVzZSBpbml0aWFsaXNhdGlvbiBpcyBub3QgZG9uZSB5ZXQuDQo+
IA0KPiBGaXhlczogOWQ3ZWUwZTI4ZGE1OSAoInR0eTogc2VyaWFsOiBscHVhcnQ6IGF2b2lkIHJl
cG9ydCBOVUxMIGludGVycnVwdCIpDQo+IFNpZ25lZC1vZmYtYnk6IEluZGFuIFp1cGFuY2ljIDxJ
bmRhbi5adXBhbmNpY0BtZXAtaW5mby5jb20+DQoNClJldmlld2VkLWJ5OiBTaGVycnkgU3VuIDxz
aGVycnkuc3VuQG54cC5jb20+DQoNCkJlc3QgcmVnYXJkcw0KU2hlcnJ5DQoNCj4gLS0tDQo+ICBk
cml2ZXJzL3R0eS9zZXJpYWwvZnNsX2xwdWFydC5jIHwgMTggKysrKysrKysrLS0tLS0tLS0tDQo+
ICAxIGZpbGUgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCspLCA5IGRlbGV0aW9ucygtKQ0KPiANCj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvdHR5L3NlcmlhbC9mc2xfbHB1YXJ0LmMgYi9kcml2ZXJzL3R0
eS9zZXJpYWwvZnNsX2xwdWFydC5jDQo+IGluZGV4IDc1YjNjMzZjMTNiYy4uN2I0NmI5N2E2ZGRk
IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3R0eS9zZXJpYWwvZnNsX2xwdWFydC5jDQo+ICsrKyBi
L2RyaXZlcnMvdHR5L3NlcmlhbC9mc2xfbHB1YXJ0LmMNCj4gQEAgLTI2MjksNiArMjYyOSw3IEBA
IHN0YXRpYyBpbnQgbHB1YXJ0X3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UNCj4gKnBkZXYp
DQo+ICAJc3RydWN0IGRldmljZV9ub2RlICpucCA9IHBkZXYtPmRldi5vZl9ub2RlOw0KPiAgCXN0
cnVjdCBscHVhcnRfcG9ydCAqc3BvcnQ7DQo+ICAJc3RydWN0IHJlc291cmNlICpyZXM7DQo+ICsJ
aXJxX2hhbmRsZXJfdCBoYW5kbGVyOw0KPiAgCWludCByZXQ7DQo+IA0KPiAgCXNwb3J0ID0gZGV2
bV9remFsbG9jKCZwZGV2LT5kZXYsIHNpemVvZigqc3BvcnQpLCBHRlBfS0VSTkVMKTsgQEANCj4g
LTI3MDEsMTcgKzI3MDIsMTEgQEAgc3RhdGljIGludCBscHVhcnRfcHJvYmUoc3RydWN0IHBsYXRm
b3JtX2RldmljZSAqcGRldikNCj4gDQo+ICAJaWYgKGxwdWFydF9pc18zMihzcG9ydCkpIHsNCj4g
IAkJbHB1YXJ0X3JlZy5jb25zID0gTFBVQVJUMzJfQ09OU09MRTsNCj4gLQkJcmV0ID0gZGV2bV9y
ZXF1ZXN0X2lycSgmcGRldi0+ZGV2LCBzcG9ydC0+cG9ydC5pcnEsDQo+IGxwdWFydDMyX2ludCwg
MCwNCj4gLQkJCQkJRFJJVkVSX05BTUUsIHNwb3J0KTsNCj4gKwkJaGFuZGxlciA9IGxwdWFydDMy
X2ludDsNCj4gIAl9IGVsc2Ugew0KPiAgCQlscHVhcnRfcmVnLmNvbnMgPSBMUFVBUlRfQ09OU09M
RTsNCj4gLQkJcmV0ID0gZGV2bV9yZXF1ZXN0X2lycSgmcGRldi0+ZGV2LCBzcG9ydC0+cG9ydC5p
cnEsDQo+IGxwdWFydF9pbnQsIDAsDQo+IC0JCQkJCURSSVZFUl9OQU1FLCBzcG9ydCk7DQo+ICsJ
CWhhbmRsZXIgPSBscHVhcnRfaW50Ow0KPiAgCX0NCj4gLQ0KPiAtCWlmIChyZXQpDQo+IC0JCWdv
dG8gZmFpbGVkX2lycV9yZXF1ZXN0Ow0KPiAtDQo+ICAJcmV0ID0gdWFydF9hZGRfb25lX3BvcnQo
JmxwdWFydF9yZWcsICZzcG9ydC0+cG9ydCk7DQo+ICAJaWYgKHJldCkNCj4gIAkJZ290byBmYWls
ZWRfYXR0YWNoX3BvcnQ7DQo+IEBAIC0yNzMzLDEzICsyNzI4LDE4IEBAIHN0YXRpYyBpbnQgbHB1
YXJ0X3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UNCj4gKnBkZXYpDQo+IA0KPiAgCXNwb3J0
LT5wb3J0LnJzNDg1X2NvbmZpZygmc3BvcnQtPnBvcnQsICZzcG9ydC0+cG9ydC5yczQ4NSk7DQo+
IA0KPiArCXJldCA9IGRldm1fcmVxdWVzdF9pcnEoJnBkZXYtPmRldiwgc3BvcnQtPnBvcnQuaXJx
LCBoYW5kbGVyLCAwLA0KPiArCQkJCURSSVZFUl9OQU1FLCBzcG9ydCk7DQo+ICsJaWYgKHJldCkN
Cj4gKwkJZ290byBmYWlsZWRfaXJxX3JlcXVlc3Q7DQo+ICsNCj4gIAlyZXR1cm4gMDsNCj4gDQo+
ICtmYWlsZWRfaXJxX3JlcXVlc3Q6DQo+ICBmYWlsZWRfZ2V0X3JzNDg1Og0KPiAgZmFpbGVkX3Jl
c2V0Og0KPiAgCXVhcnRfcmVtb3ZlX29uZV9wb3J0KCZscHVhcnRfcmVnLCAmc3BvcnQtPnBvcnQp
Ow0KPiAgZmFpbGVkX2F0dGFjaF9wb3J0Og0KPiAtZmFpbGVkX2lycV9yZXF1ZXN0Og0KPiAgCWxw
dWFydF9kaXNhYmxlX2Nsa3Moc3BvcnQpOw0KPiAgCXJldHVybiByZXQ7DQo+ICB9DQo+IC0tDQo+
IDIuMzAuMg0KDQo=
