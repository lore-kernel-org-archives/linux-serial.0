Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AEA8C48BDF
	for <linux-serial@archiver.kernel.org>; Tue, 15 Jun 2021 13:32:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50A1A61474
	for <linux-serial@archiver.kernel.org>; Tue, 15 Jun 2021 13:32:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231286AbhFONe6 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 15 Jun 2021 09:34:58 -0400
Received: from mail-eopbgr1320047.outbound.protection.outlook.com ([40.107.132.47]:62880
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230146AbhFONe6 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 15 Jun 2021 09:34:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ii2pCObDVSJc2hrHHHZ5qccs3GQnXDQp9HeGWBvb40kvEDNbUvR4AtM8jN2GfNik+t23MA4BUJxWBuCch0DNYqZnWMjTM6MSfUtGTX4W/+FJvr0BYMR3LAL7RV0J9BFvEbA4KOMNy4hJrBiR0Vq/HgOf//XmHe31yc87MeBfLpNtIOIi2ww5gztS/5dN6PnGhNIyGvJ0ryohrtGqHm4lA5zUqILqiWos2tQX+j/4Ohk6dejbyMrnEYB5aki6iDDqIor4muvzuDRvukAXLnkbybD2ljvSH2MIjGit9f5AndfnGrOnHzjkkw1rfenncVTTvyjmw9TtwsHxejq5kqPGhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xPxolNtmm7L/1VJmxYw70HQQOqB0h+kcG0FIFeVGSM0=;
 b=dKb2KwzuW/5sBI8TKfq7hM4cSjYojHCppJWiNBPvJrBYf2FWqPtkCC0BKaagtEN3Zg6Uz3KwKtYS+0hxCnmTG2v8SW4WueoVdehih9XoHgaANnKQE82zDhW071jBlQjrmfTL/ZUL+OcM+HYzr/ajnnb98zKWrjNOCvw5zR+5fM82mpK/6aA8p3CWRYnfVj9YNmJdYicxNVYIRo4UPwO4gXpFerUITbNm+Phb5BcaAdzUTvgE2RdvK1MdBu6HrALaz3HFdKY8llBBhB/Nv/XMnETyw6zRuyV57ex+10S8knLhivN3V5lYeV3cAfKYOVjyFcsAyyNGA44GR+Uj0mm4xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cortina-access.com; dmarc=pass action=none
 header.from=cortina-access.com; dkim=pass header.d=cortina-access.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CortinaAccess.onmicrosoft.com; s=selector2-CortinaAccess-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xPxolNtmm7L/1VJmxYw70HQQOqB0h+kcG0FIFeVGSM0=;
 b=NWnmPf5+6Q/+039Yd6W7IRMrU3gAxJVys1Gm2fW1mVlcA/x8KH7FBGa2CJs/AN2ZdMBgTAk1+X16uU/xGG1SyG2XSc7iV5RNxUWSNaCSq4nhd14bQJ8bAflrlassnYGM60xVVNy4KT03BEc6kB+BV25uexOpiZpqmePw8kAzy78=
Received: from PS2PR01MB2504.apcprd01.prod.exchangelabs.com
 (2603:1096:300:3e::11) by PSBPR01MB3687.apcprd01.prod.exchangelabs.com
 (2603:1096:301:b::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.24; Tue, 15 Jun
 2021 13:32:51 +0000
Received: from PS2PR01MB2504.apcprd01.prod.exchangelabs.com
 ([fe80::e9b5:6b16:ec29:6101]) by PS2PR01MB2504.apcprd01.prod.exchangelabs.com
 ([fe80::e9b5:6b16:ec29:6101%2]) with mapi id 15.20.4195.032; Tue, 15 Jun 2021
 13:32:51 +0000
From:   Alex Nemirovsky <Alex.Nemirovsky@cortina-access.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Jiri Slaby <jirislaby@kernel.org>,
        Jason Li <jason.li@cortina-access.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
Subject: Re: [PATCH v4 1/3] tty: serial: Add UART driver for Cortina-Access
 platform
Thread-Topic: [PATCH v4 1/3] tty: serial: Add UART driver for Cortina-Access
 platform
Thread-Index: AQHXRQOE/WvPoJrMTEyo68j2OIxsw6sVL9QAgAAcBAA=
Date:   Tue, 15 Jun 2021 13:32:51 +0000
Message-ID: <DA86E839-4208-4535-B70C-ACFC94438BEB@cortina-access.com>
References: <20210509184519.15816-1-alex.nemirovsky@cortina-access.com>
 <YMiUgpRbfwMHCqD+@kroah.com>
In-Reply-To: <YMiUgpRbfwMHCqD+@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=cortina-access.com;
x-originating-ip: [70.58.207.205]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d18faee2-cffd-4530-525b-08d930021301
x-ms-traffictypediagnostic: PSBPR01MB3687:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PSBPR01MB36874289C06AFEA1D708234BCB309@PSBPR01MB3687.apcprd01.prod.exchangelabs.com>
x-ld-processed: 0694623c-6669-497c-89c3-3a32a9934313,ExtAddr
x-ms-oob-tlc-oobclassifiers: OLM:2331;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 83OjHLdhrl2c4yRZMK5q3HXI7N4Mzl8lCabSEjiKEq+5tIirDvXmB8QzaYSBIXoMtxGrdgBxHOdx8aBf3iBjotvLDb8XY+Up/TxuBOBYfGwzKapJSOziWABzB7D7TgWqBX5WFqUwsJVO5WtGSXGZlActmeNh3CYrBzJ0+6JFm7ru8ty5skoCrk6yMVZioGpL5QWvOXaLErtuknBzeuLesFV0FuZrtHjkfSEVWOYMpnMW5u9eEBLuQByvEhmzer4/qkN6jFzTaNDzXtlWLlN8IJmPuNPXuJgUTdd/dxworpH4OGqgFpCyaoCHXCKAXQIs7A262WkVRt5qosFwk9O1J1SWQb3D/DxhMhgBCwtXT0a49cGmTT3i548yGNjANbkGGuygBCrINjf/1N10WUd6Wk7hF1sRx/HqqFYNJOaJoBuwdPUs3wR1uJ1H+qI1R+tsoDwiV8pbITUJFBt9eVNfcWuTuY0sB4pmoWoyhzlwea4HbFR6wijvI8jMzQAT8rIVfHY/JPMK2RxUoa28gkd3u1mK1J3W4xa60w5LjhMpjbZHI5jPkZzOfCvb+Bj7AFxW0fxxUt5hpAAPip5IGpmJRZGVaLsPfUQzFe8RPR9MpYg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PS2PR01MB2504.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(53546011)(2906002)(4326008)(6506007)(54906003)(76116006)(8676002)(26005)(83380400001)(66946007)(6512007)(91956017)(5660300002)(64756008)(66476007)(66556008)(66446008)(71200400001)(6486002)(6916009)(86362001)(498600001)(8936002)(4744005)(36756003)(186003)(33656002)(2616005)(38100700002)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OUZxNmRsQW5DV2dWK2Y2STJyMGE5UzdOdVdTa2x3K3R1NitFei9DckU3Z1Bo?=
 =?utf-8?B?c0JzUWpNMW1VVWhBNU1KWE40bU9QUzRKMndrVDAxeTJSRFZYZ3FvWHplSGFC?=
 =?utf-8?B?NVRYbnZnL014eTJraWxiWTI3N1IxbmwvamNMK3pHNmR0aFpEakd6WFVkQVFZ?=
 =?utf-8?B?ZFovNU1UVklWNndVRmhXS0F1N2x5YzBkcjVIM0pVWlBUY1Ixcmd2NmRYckta?=
 =?utf-8?B?c2JrZE1IWnVDRkNjMXZsTnA5UlVyVkYzNVhXbHl4T2krYVRPZXhlN1lBUkNJ?=
 =?utf-8?B?NzRYdTFwRTNBRVBNdFdaQzdjOHNMd2JCNlp1VnJRRE9JcFZaMzI2RzJydFBK?=
 =?utf-8?B?NlpFWmljV3lsb0M3YiszekhpdDFxSXoxTVh5dDFyNnVTbWVwNCtjem9uTGp3?=
 =?utf-8?B?TkhTcDlINGM2K0kwc2pmYnhNVU51UHJXNGV6QlU5cjNZSmlONkZuTS9pbWwz?=
 =?utf-8?B?SzRyOFpnczdPeURSb0xFNWxicWhlWmF3Ym4rWitzY3FEMFN2dTdFYTczVkVF?=
 =?utf-8?B?M0h3S1hJdG4wYlNpeFBhZk13b3NQandXR2hjdFBCdVljSU91WkIwRzUvUEFl?=
 =?utf-8?B?M1pjd1hJR3FYck9HVWJjNm4wYnlvSFBMdXlDWlNldWtzSzlZUzhMZkNkZEJB?=
 =?utf-8?B?azRGNldmaWgrbmNhbWVzL2Jsc0xzZ1prUXRzUTRrYWphcTdhQXRpMml6M2Fn?=
 =?utf-8?B?TExjcWdWbCt0MnA5Y3NZUUdQR2VzaWltL1RLZlRBUzJOdVZJdEdSMmtUSjM1?=
 =?utf-8?B?UWVsWi9iWkhZaVVCRjFya05XYzFmYndMaWRRUmYyM29ia1RJWXhOYi9MeXhR?=
 =?utf-8?B?QUpuTXBseTFIVEV0YTVHMTlqeTY2OW1CRExXWElJdDFEeHZBMVh5bVdKa2V4?=
 =?utf-8?B?YXRZelJ6NXNMV25nSmFNTUhJemxybnBoa3ZTVSt1R1U2eWdjNlA0NENFVGNs?=
 =?utf-8?B?Y2pTZVhpa01ReVRBY29oalV1RVdvVy90L2tEdk1YSnNuQWloeHZtSlVuVVp5?=
 =?utf-8?B?dTN0YVZZSDBQSHpPalhsNnlFNDFLNWI1d3ZUc0NhZFZLKzJCb0ZpdGx1bjAr?=
 =?utf-8?B?WWdITUdFcTU0VEhNZER6THNFcndiODVoMFJZZW1sUkpGYnpWVGZYSEQyYUdK?=
 =?utf-8?B?WDhTL1pmZnI2bUxvdEZDN3I1bjNRMUdna3V2VDh2LzRIRVBTUk02QkdaeUN4?=
 =?utf-8?B?eFpiVDJmYU9MMk04QVhacXRmU2dQZW5hMWNFY044M0E3cXNDSG5RRy9kVWV2?=
 =?utf-8?B?Z3I5bGQ0czZ0YmFIR3pORFNDeVl0bTdQL2ZaTVZmQzQrTlBtTGJtYzJ5WGdE?=
 =?utf-8?B?aWtTRjNVMlBoVmFNWEQ1SW9DbWh1eGhpK3QyemZCSndYVVBlRGEzZG0ySW5R?=
 =?utf-8?B?ZFJEOFovNGxOMzFTNG5uTjFnQXUzdXU2MHFUL3YzbW1ZOW9McWFVRmhqRlI4?=
 =?utf-8?B?VGdSRWJxTWFxM0x3MUZEc2tKOEtwZElrZ2JhMGRiaDF1d2JqMTJiYkdQaUNC?=
 =?utf-8?B?SjhZMzRrVlc2cUQySDVhTmdnSEU1bzJaUzdQN1E5WFZNaFNYOTRxUFYwWTh0?=
 =?utf-8?B?cE5qZC9FTzI2aThHaTUyVjZwU2ZQcnlOMmZadGlsdXhncEJ1YzFqNWFEUEcw?=
 =?utf-8?B?TTJZUFUxRDhINW5Wb1R6Kzh0RFhPd09yT24rYmV1RDdqb3VPcCt6Z2tEaWFY?=
 =?utf-8?B?a2c4TmpMK3JNbHlOd0c5V3J0akl5MnFkWlJKanBEY0RMM3A3YjRiaTQ1WmE1?=
 =?utf-8?Q?VznThvhdFrwXN5mP6VBK1qxqKmk6BioNcJgSdHJ?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5A9DCB8864F97C47849F52448DCEAD8F@apcprd01.prod.exchangelabs.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: CORTINA-ACCESS.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PS2PR01MB2504.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d18faee2-cffd-4530-525b-08d930021301
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2021 13:32:51.3389
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0694623c-6669-497c-89c3-3a32a9934313
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0GZf267+6GuLarQO7Xqo0gWfarcgX0gdO7iBOO6/lkb6/yp6wIPredGPwefPX3lI7TgPtR6i9IoiplAU0y7JfG6YxeOzNGpXkC0t8QrqnVaImMGXB7jbSy02LUIz+I1e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSBPR01MB3687
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

VGhlIERUIG1haW50YWluZXJzIHdlcmUgQ0PigJllZCBmb3IgdGhlIERUIHJlbGF0ZWQgZmlsZXMu
ICBIb3dldmVyLCBJIHN1c3BlY3QgdGhleSB3b27igJl0IA0KQUNLIGl0IHVudGlsIHlvdSBBQ0sg
dGhlIGFjdHVhbCBzZXJpYWwgcG9ydCBkcml2ZXIuDQoNCj4gT24gSnVuIDE1LCAyMDIxLCBhdCA0
OjUyIEFNLCBHcmVnIEtyb2FoLUhhcnRtYW4gPGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnPiB3
cm90ZToNCj4gDQo+IE9uIFN1biwgTWF5IDA5LCAyMDIxIGF0IDExOjQ1OjE2QU0gLTA3MDAsIEFs
ZXggTmVtaXJvdnNreSB3cm90ZToNCj4+IEZyb206IEphc29uIExpIDxqYXNvbi5saUBjb3J0aW5h
LWFjY2Vzcy5jb20+DQo+PiANCj4+IFRoaXMgZHJpdmVyIHN1cHBvcnRzIENvcnRpbmEgQWNjZXNz
IFVBUlQgSVAgaW50ZWdyYXRlZA0KPj4gaW4gbW9zdCBhbGwgQ0FYWFhYIGxpbmUgb2YgU29Dcy4g
RWFybHljb20gaXMgYWxzbyBzdXBwb3J0ZWQNCj4+IA0KPj4gU2lnbmVkLW9mZi1ieTogSmFzb24g
TGkgPGphc29uLmxpQGNvcnRpbmEtYWNjZXNzLmNvbT4NCj4+IC0tLQ0KPiANCj4gSSBjYW4ndCB0
YWtlIHRoaXMgd2l0aG91dCB0aGUgRFQgbWFpbnRhaW5lcnMgYWNraW5nIHRoZSBEVCBjaGFuZ2Vz
Lg0KPiANCj4gU28gY2FuIHlvdSByZXNlbmQgdGhpcyBzbyB0aGF0IHRoZXkgY2FuIG5vdGljZSB0
aGF0IGl0IHJlcXVpcmVzIHRoZWlyDQo+IHJldmlldz8NCj4gDQo+IHRoYW5rcywNCj4gDQo+IGdy
ZWcgay1oDQoNCg==
