Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B7ABC3DA78
	for <linux-serial@archiver.kernel.org>; Tue, 17 Jan 2023 10:20:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236100AbjAQKUY (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 17 Jan 2023 05:20:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236569AbjAQKUO (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 17 Jan 2023 05:20:14 -0500
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2088.outbound.protection.outlook.com [40.107.241.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F4BDCC29
        for <linux-serial@vger.kernel.org>; Tue, 17 Jan 2023 02:20:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vin9zXXmzmVOUJBqdAL17vz93Fjs4P0DwcpEPJdGg0txqhZcEEIuJfap+Z6TFq54D0fo69uUiVmNqcr2rf1ayap9SSfldO3elE/sJI2XmEV1DlnVh30qLuF/f9zHl3ON9RYLPMCZYigEEQEjVOVwbWVtkfMdXnXJfkCpxFgV5c0ifQqR33MHLvfjWP6OuS88pF9SUfUZwJ33YuBTIDBPiAm3a1Bp/WX8IERTufQltBo9MgEEmHWwaE3MpSwvPgNPDdwYo3QuHiaoz9StmKbWmzQVJR1fvIioIVWrGdeDNuM1tGICyQTtaMck+LDJckBKFn1UPA2aH9/ZfH8M9zG2+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KMIrZZtBJ7p0ERyx+f8ciFwwOtacVXCBv+viZsASGOc=;
 b=ZZstwJKRfrxhOKFFLqk5YWOlbHl0Ylk33z2LTwEIHQdYbEuo8eyMhnFt8wVw17+1c0/IjouR08QiSdudmhd0EzY6mmcjo8vlU+HB1DFupV3NJNK+LcPVrwDbEP/Sy2Ky/EP5pyziH+DHX1jsDqr8GT+CdWHlYuBs4Rf1/jkDhclAyQr2dU/dIGWD2lD/Cgpw39B63zYOe/sB3AU3qRlXPsrWjSbCJAz5bD3FGbfQVVWzDND1kZuP2lOyARDdXfWQ+TP8OljINWOiNLng+dIEeU7wcnZwbAHdLN89XxQ1Py7ChxRUC2hgFPyJHNhKXE2anKxPBKW1LBv1maediUhRPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KMIrZZtBJ7p0ERyx+f8ciFwwOtacVXCBv+viZsASGOc=;
 b=HgIFSaO/w1ST9eDrbXVgjPUKZwQuWltssOAwEM7fmu6iCTrmbRtkTmYTAVcWhCQZk/vnHaY/PzN+dKxNZWxUYuDpPlNhSA9SuXN4wsWdWq70MXDCrnsu1G/tC/vE76DjEvt+QvZnrBqUwmsef2uMvvhYcHTUj2nwvMDClgwocEo=
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by AM9PR04MB8162.eurprd04.prod.outlook.com (2603:10a6:20b:3e3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.12; Tue, 17 Jan
 2023 10:20:08 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::1bd9:bd4d:663d:a73f]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::1bd9:bd4d:663d:a73f%4]) with mapi id 15.20.6002.013; Tue, 17 Jan 2023
 10:20:08 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     Sergey Organov <sorganov@gmail.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
CC:     Fabio Estevam <festevam@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Richard Genoud <richard.genoud@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        "tharvey@gateworks.com" <tharvey@gateworks.com>,
        =?gb2312?B?VG9tYXN6IE1vqL0=?= <tomasz.mon@camlingroup.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: RE: [PATCH 7/8] serial: imx: use readl() to optimize FIFO reading
 loop
Thread-Topic: [PATCH 7/8] serial: imx: use readl() to optimize FIFO reading
 loop
Thread-Index: AQHZJ377s5uy5hHEhEC66kkm4V2Odq6ias1Q
Date:   Tue, 17 Jan 2023 10:20:08 +0000
Message-ID: <AS8PR04MB8404679A61FA6BB7D913C3E192C69@AS8PR04MB8404.eurprd04.prod.outlook.com>
References: <87bko4e65y.fsf@osv.gnss.ru>
 <20230113184334.287130-1-sorganov@gmail.com>
 <20230113184334.287130-8-sorganov@gmail.com>
In-Reply-To: <20230113184334.287130-8-sorganov@gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8404:EE_|AM9PR04MB8162:EE_
x-ms-office365-filtering-correlation-id: 540a8e98-7b67-4db9-6ffa-08daf874690d
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: x1g+z1uGiRBoA3QzdZ/9V69bZrSTlrmorOQvCrTTh+ukfK6n5HpaXVEgIOqfZcVltVIY1oi9uN11v/lsnJOZG+JpG7ngikHowMHiER+6TMfhlrYl5Hl7gI6Qlz6JON2yfHxsxt+HuHXbrymsCfJj692Ay7ycJ7QIqJNZMyLpE1de5LTZTsvWmzdZ3es0lB1KnTxsdiOKBkzFYcdBZbA3L5yk5EYhfS++B9PYTPclM2rKVxL1lZxytEoMFLqT3y+i9IwP827k4CydQ0dRGlBi8qMthV9TrI6PEdFDYHOfHhnIfiuENiuuhFvzERPTgIGIKf6XeOFdQmkFFFM89ckKVcXp5at6roZ/9PB3+1qvUu0Xmd7UZp6+ZTyzeCN722I44w0QLyC/79fminCPDqIFX5DHPhlDQSRRJyD294O1L5s4RiiGGCz3gfxrHtQBdfjnaDDPZeeQSIVqwXyFdc/v5wApA80QYkwumPHzpXoYJ9Fzqwe12ZYiNlw6SQhD7Ii9Gj1MqdzDPN2WAXMq/34v/pnjn30yPWxIPybA+oMMPvVfayhzoybarJqNPVXkzARO3hQWX89jrchXRAl3FLW1y5B30SuVT6vBooymPDHE+0IqCdbN0h4QkXH4elbECrLRl4AR7qLJGKZSEtTnYs3S+UFZlm8VNXkWDFyqUEmIi/cRjGaKsJZJvwHieucnR/uh7W1huDdBEnPYjbjJ89jaY8EyENY+Xz0V82g+hplNukTmqdrbCohcPOT2nmcW7oPk
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(366004)(39860400002)(136003)(376002)(451199015)(83380400001)(122000001)(38100700002)(86362001)(2906002)(52536014)(7416002)(55016003)(41300700001)(5660300002)(8936002)(66556008)(53546011)(6506007)(478600001)(8676002)(4326008)(26005)(9686003)(186003)(76116006)(66946007)(316002)(64756008)(7696005)(66446008)(54906003)(110136005)(38070700005)(44832011)(71200400001)(66476007)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?eHIvS2FVU3dTNHkwUjhlQW1WUzUzMVR4S2lLVDFWTUxjblExOU8vQm5GVDJl?=
 =?gb2312?B?QVZDZW11cWV4dW5SdFd1UklyWmlaTkNsekJkbWxRZDU3U283VUtpWVBVYkhj?=
 =?gb2312?B?OXhEZk5Dd0c2VDQrSVBlR1FLYnd4V1VxVFMzdlJma09yenBIaWhnRW9QbVFQ?=
 =?gb2312?B?MWtrOXcwZDRDN1hUQzVUNUFpUzlZT3drTG9QMVBScnJlRVFnM1g2UEgwRGMv?=
 =?gb2312?B?U1Q0OEdFR250eDlSNzYzb2JMWDdHelV5amg4MHRaU01tRXUrOGVBZENTREZS?=
 =?gb2312?B?aVpsTDlOS2lFK2w5S1hBbTd5bUNtR21HN1AxcmxmSnBDUytyR1dzQjRNQ1h5?=
 =?gb2312?B?RWxzL3dxRHo1UTVSalZrUmFGUFFqYUVOMDNpYWJnNDdWdS91emVyVUx5REJu?=
 =?gb2312?B?eUptcENjTVJOQlQ0MXdBUXFtYUJmKzNtSlRTVWllS2JZM2VxZEZkUTEwZk9p?=
 =?gb2312?B?Z0VVUGNZMHA4REVZaEFhcGdlTFM5ZHcwQ29yUEJueUNadnZiRWtsT2JzYVM4?=
 =?gb2312?B?cDhKU0IwZFNSTGZFaFVQcWlxck94eVZwVjMvTnkvSldBdlFiNHFqeWU2dnI0?=
 =?gb2312?B?RU8rYWcwWmZrd0lhNkpqVnBNRVRsV3dUd2VDb09wOWFYTldhZG1oYVpxWFMx?=
 =?gb2312?B?MTd2ODZ3MFg3Z1g1V3AxUjQxNlVSMG1La2t5WGNCd3NxOUh1NmJFeitUbzls?=
 =?gb2312?B?NFFiOENyTDgvM000UEgvZ1JqaEpaNTNmVGFqWHlTYzlqM1dGN2lnR3B0eWdR?=
 =?gb2312?B?SDJaWHV6dkg1YXdoVCtmaTF5cDQrL0JuWjltbUxmS0VobE13RHI3WHhZTnJ4?=
 =?gb2312?B?WEk3eHp4ZlNpSEZYRlRiR0oxYndNMUNDRDYrQ2pDd1dYS1JkcEhvaGo0Wlk3?=
 =?gb2312?B?YmY1MUpxR3REWGxTR2tvS2lpcERFN2FvN0tlSnpMTlRQWXY4VlBicVlwenF3?=
 =?gb2312?B?WldwWGNrUWlOMXoyTVhoYzlVQXBHZ1YxVm1hTDdxQWx4UEwvOGRiL3JmdUVK?=
 =?gb2312?B?VU5GbStjZ1gvbDBKQ3JLZmpPS0puWGY1WjQ1Z3NMczhobDV2STZ3TnZOendt?=
 =?gb2312?B?aWdmdEVaYmk1Sy9XRzh0cnQ4YTB2K3dkcTlWYURsMFNlOEFoa1c1QThSbWJv?=
 =?gb2312?B?TzVhQzVNRFUyM2hFSWQ5Wk5XYzRkT3c0MFgydkpiekFYM3g5Vkg5d083MGpI?=
 =?gb2312?B?UmRWdndlZlgxL21IYzNEaXpZL0xINWFnL29mV0NqYWNIeEVkUWowelpETXVi?=
 =?gb2312?B?Ni91ckQ1QWVKdy9wUHdVbWJJMlVlTERQdzMrMWZ6R01nbWl3VytIcjVGMjFV?=
 =?gb2312?B?dUp4U29KVTE0ZGE5bmNGbGUvL1JxT0YrMFFpZUZ6TVQySEZuU0JyK0FpZHBZ?=
 =?gb2312?B?eUVwL0ZyVFF6SzAvby9GZDM1eGNwY2ZUMG5uU2FwTWF5b3ZLUEJhenZWY283?=
 =?gb2312?B?RjlsYktENmgwOVlYMVdlOXhsRjVYbHMrME9HUWFsTnVGVzF1dllMZ1h3Umpx?=
 =?gb2312?B?aWd1QWNsVjIwMFNBbm9GVDI1dGw4VnlwOFViMXlwQW1SWHV2ZHN3bmJkWmRT?=
 =?gb2312?B?S0dIdDNWTDdMRzljeEdRSTFTczhJUGNJS1JuMi9QOE90QzZvaGtRWnA3Z0Ex?=
 =?gb2312?B?NFV0bWVKRmhTS0M1cEhIYWViaVFtejEwUWRrY1JFWmZjbWpNODVQRWRlZWxG?=
 =?gb2312?B?T2V1aEliN1BIRmNDalBNRDkvcEVPUllSWUhlRzVCOEIrODFHU0RFY2g5ZXlR?=
 =?gb2312?B?Q2tGdVo1WUdyempSUmpqWnA3ZDc2Vlh6Z0crRUU1bjY4N3FvVWlDdlpoY2gv?=
 =?gb2312?B?dmszSDViYVNOenB0NGxWQXViRUt3V2szTHZrcmF6MUwwRExaRjV5eHFRblJz?=
 =?gb2312?B?THlrK2wrbHB6dzB5ZnduZEc3b1pWb1ZCb0RpZmpkV21xMGpWaGxpQklNOWVx?=
 =?gb2312?B?aGxKSHBIODJLUm1MNlMrMDMxOVBTT0s1dmdCY3M4dXhBamFrZnhlRzhacHha?=
 =?gb2312?B?WStzRzJ6NmJvOXJ5ak5XZERWaitTZm5Uekd6c3g3YWFiOXJzSEN3YVM2WkxN?=
 =?gb2312?B?K3ZpbDI3ZURkTUVPeEdtcXdWQzNKZG9wSGxMWVhOSi9QMTl6REc5SHVSYnFE?=
 =?gb2312?Q?coZ8agXRYgRiOD5UjAiamNrKQ?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 540a8e98-7b67-4db9-6ffa-08daf874690d
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2023 10:20:08.8417
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WYlMQx8P14/8vY1Bcpf6Pn6fPs9BAxoT5Gxhxrena6QVnD9S1ej5K6s+uHGtAW+k/VnI2bmlzFhtQ6guZzKvBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8162
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU2VyZ2V5IE9yZ2Fub3Yg
PHNvcmdhbm92QGdtYWlsLmNvbT4NCj4gU2VudDogMjAyM8TqMdTCMTTI1SAyOjQ0DQo+IFRvOiBs
aW51eC1zZXJpYWxAdmdlci5rZXJuZWwub3JnDQo+IENjOiBGYWJpbyBFc3RldmFtIDxmZXN0ZXZh
bUBnbWFpbC5jb20+OyBHcmVnIEtyb2FoLUhhcnRtYW4NCj4gPGdyZWdraEBsaW51eGZvdW5kYXRp
b24ub3JnPjsgSmlyaSBTbGFieSA8amlyaXNsYWJ5QGtlcm5lbC5vcmc+OyBSaWNoYXJkDQo+IEdl
bm91ZCA8cmljaGFyZC5nZW5vdWRAZ21haWwuY29tPjsgU2FzY2hhIEhhdWVyDQo+IDxzLmhhdWVy
QHBlbmd1dHJvbml4LmRlPjsgU2hhd24gR3VvIDxzaGF3bmd1b0BrZXJuZWwub3JnPjsNCj4gdGhh
cnZleUBnYXRld29ya3MuY29tOyBUb21hc3ogTW+ovSA8dG9tYXN6Lm1vbkBjYW1saW5ncm91cC5j
b20+Ow0KPiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGRsLWxpbnV4LWlt
eCA8bGludXgtaW14QG54cC5jb20+Ow0KPiBQZW5ndXRyb25peCBLZXJuZWwgVGVhbSA8a2VybmVs
QHBlbmd1dHJvbml4LmRlPjsgU2VyZ2V5IE9yZ2Fub3YNCj4gPHNvcmdhbm92QGdtYWlsLmNvbT4N
Cj4gU3ViamVjdDogW1BBVENIIDcvOF0gc2VyaWFsOiBpbXg6IHVzZSByZWFkbCgpIHRvIG9wdGlt
aXplIEZJRk8gcmVhZGluZyBsb29wDQo+IA0KPiBVc2UgcmVhZGwoKSBpbnN0ZWFkIG9mIGhlYXZp
ZXIgaW14X3VhcnRfcmVhZGwoKSBpbiB0aGUgUnggSVNSLCBhcyB3ZSBrbm93IHdlDQo+IHJlYWQg
cmVnaXN0ZXJzIHRoYXQgbXVzdCBub3QgYmUgY2FjaGVkLg0KPiANCj4gU2lnbmVkLW9mZi1ieTog
U2VyZ2V5IE9yZ2Fub3YgPHNvcmdhbm92QGdtYWlsLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL3R0
eS9zZXJpYWwvaW14LmMgfCA1ICsrKy0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25z
KCspLCAyIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdHR5L3Nlcmlh
bC9pbXguYyBiL2RyaXZlcnMvdHR5L3NlcmlhbC9pbXguYyBpbmRleA0KPiBiZTAwMzYyYjhiNjcu
LmY0MjM2ZTg5OTVmYSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy90dHkvc2VyaWFsL2lteC5jDQo+
ICsrKyBiL2RyaXZlcnMvdHR5L3NlcmlhbC9pbXguYw0KPiBAQCAtODkwLDE0ICs4OTAsMTUgQEAg
c3RhdGljIGlycXJldHVybl90IF9faW14X3VhcnRfcnhpbnQoaW50IGlycSwgdm9pZA0KPiAqZGV2
X2lkKQ0KPiAgCXN0cnVjdCBpbXhfcG9ydCAqc3BvcnQgPSBkZXZfaWQ7DQo+ICAJdW5zaWduZWQg
aW50IHJ4LCBmbGc7DQo+ICAJc3RydWN0IHR0eV9wb3J0ICpwb3J0ID0gJnNwb3J0LT5wb3J0LnN0
YXRlLT5wb3J0Ow0KPiArCXR5cGVvZihzcG9ydC0+cG9ydC5tZW1iYXNlKSBtZW1iYXNlID0gc3Bv
cnQtPnBvcnQubWVtYmFzZTsNCj4gIAl1MzIgdXNyMjsNCj4gDQo+ICAJLyogSWYgd2UgcmVjZWl2
ZWQgc29tZXRoaW5nLCBjaGVjayBmb3IgMHhmZiBmbG9vZCAqLw0KPiAtCXVzcjIgPSBpbXhfdWFy
dF9yZWFkbChzcG9ydCwgVVNSMik7DQo+ICsJdXNyMiA9IHJlYWRsKG1lbWJhc2UgKyBVU1IyKTsN
Cj4gIAlpZiAodXNyMiAmIFVTUjJfUkRSKQ0KPiAgCQlpbXhfdWFydF9jaGVja19mbG9vZChzcG9y
dCwgdXNyMik7DQo+IA0KPiAtCXdoaWxlICgocnggPSBpbXhfdWFydF9yZWFkbChzcG9ydCwgVVJY
RDApKSAmIFVSWERfQ0hBUlJEWSkgew0KPiArCXdoaWxlICgocnggPSByZWFkbChtZW1iYXNlICsg
VVJYRDApKSAmIFVSWERfQ0hBUlJEWSkgew0KDQpBY3R1YWxseSBpbXhfdWFydF9yZWFkbCgpIG9u
bHkgc2V0IHNoYWRvdyByZWdpc3RlcnMgZm9yIFVDUnggYW5kIFVGQ1IsIGZvciB0aGUgVVNSMiBh
bmQgVVJYRDAgdGhhdCB5b3UgdXNlZCBoZXJlLCB0aGV5IHdpbGwgbm90IGJlIGNhY2hlZC4NCg0K
QmVzdCBSZWdhcmRzDQpTaGVycnkNCg0K
