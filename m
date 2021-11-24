Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B03DC433EF
	for <linux-serial@archiver.kernel.org>; Wed, 24 Nov 2021 10:56:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240521AbhKXK74 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 24 Nov 2021 05:59:56 -0500
Received: from mail-am6eur05on2073.outbound.protection.outlook.com ([40.107.22.73]:31264
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233895AbhKXK7z (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 24 Nov 2021 05:59:55 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JUAxQnInith0h2VAulWhe6Ulf8xTNx2wbTrCAPACWHuAcOBtBvIHFKCixy+fHO3YoqFHAj3MkCYUL3Nqyp+esSwk2wzzuLuLdpsLNj05DAhy7Ng0D3CTx/ECV4cwCmRRTHlH8H1pYpS2Z9Q7GTh4d2F6TxexGaiaOg+jZEbQyJ3kHLPchOesC+hgUH7Y/G2SUd7Xy+5sit8g+8rpYU/pLolw41WaS/ywYojTR9+pzs4CrP5n4wXyGfPrr+rpKb9OPhxLJzx8Y5MPpXLnO7xrfzgPX52E8LUbi9ws1SQdbFY2NNPKx1MhYWMEUa2eIgiDv+6QLgfSv9ZsExh+pfoRxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d2x4xAkQLJP64N39x3gE486tYyhoznfVoC2/TzVMg5s=;
 b=FmRuNX8c+73jVU37/NJ/XrV76JgcHRZXmqW0TgnraD4i5C+53ilLf/AsvjhyLg+FSFGzyJKP80ptgH17F6zEHOeKwwLQgt7Hgsdt5k4kITkQBGjQaiOEfcqvV4Yf4qZ+BLbqHOCZuyRZT0c5sG2bq7TE3zRo2GugX8wrZxnCBGNrInjjzOb3jTaYR61k64HeT5C6VDxz2Uu8L4M2BAfIKTgGSAlTaMST9LXfiZkOTLbrjBct2rGzs3JrvH2w/rvfCoog6tGPpwxTTY92vLeQ6y40YXU8AHKgklvcQqK7nK4wXWtZaf/gXOBnvByaLiLasaiOEUiktgxTBGDzGReR6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d2x4xAkQLJP64N39x3gE486tYyhoznfVoC2/TzVMg5s=;
 b=Qsjv98cHcSXfRK7QntkXdJI4Nk/GxNFD99hnexR4/G+6e6u86h7RbqY1c3oimuDpQuD/6Eh4edr4TeCkKQ6v/A+8JQFouZD6H9vIURzm3goIFgXhQeuAZ217nD04Va2sW//zFRqtwTHUmX2q4EywhOahobvQxHSbnoJ2VXJW6xU=
Received: from DB9PR04MB8411.eurprd04.prod.outlook.com (2603:10a6:10:24c::9)
 by DB6PR0401MB2664.eurprd04.prod.outlook.com (2603:10a6:4:39::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22; Wed, 24 Nov
 2021 10:56:44 +0000
Received: from DB9PR04MB8411.eurprd04.prod.outlook.com
 ([fe80::199a:adba:b7de:cf8d]) by DB9PR04MB8411.eurprd04.prod.outlook.com
 ([fe80::199a:adba:b7de:cf8d%5]) with mapi id 15.20.4713.027; Wed, 24 Nov 2021
 10:56:44 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "jirislaby@kernel.org" <jirislaby@kernel.org>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V2] tty: serial: imx: disable UCR4_OREN in .stop_rx()
 instead of .shutdown()
Thread-Topic: [PATCH V2] tty: serial: imx: disable UCR4_OREN in .stop_rx()
 instead of .shutdown()
Thread-Index: AQHX4FiQNZ4EhBh7xE206RassKu55awScyOAgAAEUVA=
Date:   Wed, 24 Nov 2021 10:56:43 +0000
Message-ID: <DB9PR04MB841142300744686983652AB992619@DB9PR04MB8411.eurprd04.prod.outlook.com>
References: <20211123105122.7913-1-sherry.sun@nxp.com>
 <YZ4M6aM6lGxTi2y7@kroah.com>
In-Reply-To: <YZ4M6aM6lGxTi2y7@kroah.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 41557316-bc9d-4541-31b4-08d9af391a6a
x-ms-traffictypediagnostic: DB6PR0401MB2664:
x-microsoft-antispam-prvs: <DB6PR0401MB26640047BE00582BF631BE1A92619@DB6PR0401MB2664.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: z/Vpig2Y2Df8D0xDRu3OPbPhH0L4VitSz1FvGA/BUT3mDObWle9X1DG6wWLSsFxQsfXBJb4YkAbMnPajCvoX7TNV65Lh1g67sopFp36TaZ1ZdFfgnYcQwzwr/AWmEq75twtZ55aaQ48Cpb110hz8gdJiynO9n4LM1qpFmBuIxU8peh9ecVUzfEGjADjbhOn/gdW9BR2KNCfqiUWUJ2LejQJsEfAdNWayWOj6I5H9eODt8+V60yCbm944QpWL6pXmTMzkRMYdIw/rPs8F1/PqJNb3Jq9qEfWWfSUZcYsG5rZYU8sfJSHJqJzY8vUwGMXg4I1gs8r+PuM/wmKE6345Fuud2LYZwYvfy5A4NnTqYU5V4t3wAW/YuZAYtLbgwjcoAAUa735l5OMnE/hQR9l8eKhPK7DEdVGCTUXFoNHhCt9s2XVtAm8q2Hd4Z8rS2wZuif6cpI5JwntU+9hqXn1oJaFJYnX+1j3PFgJfELOkh/AbRGY46HlP25+gKMzJlqdsAjRaDw9ENrZ8Sbg+/LH71RwwlryjZuBGR3nWFCfe2ijv9Oe99+dLGWNxufXOu7KLhBw3fJld4glPJ1jgk80b/94bhQv0GeAaVAgT3+HOieCIlax+nb0zIaKUX+xvSEwb3WdODTEyNqNX/V6FqQS3D7g9y+puWpFxQUza+YiaMNCe2rYEk+yhGcIZFsOjQNs+Xqw8hkxSWZ5S7FtXSgfagn+cm7rEnjWQTdKWaXEoBpI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8411.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(508600001)(4326008)(53546011)(6506007)(186003)(7696005)(33656002)(83380400001)(52536014)(316002)(38100700002)(38070700005)(122000001)(26005)(2906002)(54906003)(5660300002)(64756008)(66476007)(66946007)(66446008)(66556008)(76116006)(8676002)(9686003)(44832011)(86362001)(6916009)(71200400001)(55016003)(8936002)(142923001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?MS8wQmlZUk5QZ2RYWXlicU5RUlg3Y3lScTRIclVzNE9GS3UrRWRDWjVZMDdU?=
 =?gb2312?B?WVhybzhMRmVESTFrcEY2RGZKVWluWEFTT2d5cjRabDNpZ25TUFdtVzQwN0RO?=
 =?gb2312?B?ZVk4K2E1dWlsSDhhTGZwK2djbnRkRHh2R2lJcVExRmRiN1FaM0pJUXkwams2?=
 =?gb2312?B?Z2c5UHdoNnNsTmdsWG5yOXZDK0JRV3lhUmdveUFYR2VZZnJzYXJaOFdzemJX?=
 =?gb2312?B?NFFtMVg5MEtGZFNhcGxJSFQ5YmRidk1DZlpBTzhSL3U0ZVFQQTNGUUNET1Nl?=
 =?gb2312?B?WndQVFpLdVRDQ2tRby9XMHNLWVUwak15SHlvdjZ2Z1htS3ZGcUl1eG9yT0JL?=
 =?gb2312?B?M1BlcWtEVm1tclQ1aWtaNTU3dkZQVVo3MGhWc3JDc01tTTZDalpyTldYQ2pO?=
 =?gb2312?B?eVY5ZnlQOStITVc1TmVXWDJ5dDNhdGNFMG1CNmZjRlBOc0ZJU3RSNTYwOW1s?=
 =?gb2312?B?WkZjampGbUZJU1lqVWZzYmV3bHIzWWs0eFhWM3plUFFMVWdqMlFiZHBEMks4?=
 =?gb2312?B?WndndldGWjNHR1lxdnROSVZ3TGFtZ2htRTlRcy9STkdnN2k3ZndEN0RsQU5v?=
 =?gb2312?B?Z2J4RHgzUGFxS2lySHJYM01iZEFKV0crbzloOEthTERNN3VJUytFRHlyczQv?=
 =?gb2312?B?aVB1VDVXZGpSWVNnVmlHWEk5YWFrOUNwQXVJMExkZksyK1dxMEJSN2tiQXFW?=
 =?gb2312?B?RDhhQU1BMVk2eUFVUVFqd3Zkb3Yrakt4bnBkc283M1FMTEdzbE56Y21yZDRZ?=
 =?gb2312?B?SjNzVnhnVWo1TzlOYTEzNEFxUVRmaWNhVk5MVFZJdTYwTUIvQi8wY3BXdUpE?=
 =?gb2312?B?eDNXd2ZHbHNOQk05Y1pkRHZzQnIzb29DSzhONCtzSlNPcld4K0JxSU9SbDdr?=
 =?gb2312?B?Q2hhL2tCOTYrOWdoWjdENmI0MDRvOGVENkVwZGNhL2pGaGJmNTZQTWtiWjNr?=
 =?gb2312?B?YVUzWGJHWXNjL0J0c3BqWDZEYzZpUVhSNE9pcDJMNWY3WFJnbnR2akJHRG5H?=
 =?gb2312?B?OGwwNmdSdm1HUGxVMGpiSHdrS2tMQWxlSWdyVGc0ajBCSHp5RVc4RlRMRWxh?=
 =?gb2312?B?WGtEN0x2ZG8wUlNKOWlTSTRLMHFMQ1BjVnZKOHFRQzNtTDhCN3YxRnVRTWty?=
 =?gb2312?B?Znh2RHFacU1hSGJoMVlDd0YzYzRZRTdwc1FKRWIyMjA0Ym1sb1kwcWNkT3Vl?=
 =?gb2312?B?ZU9VMWZWWkFVOFY1Z3FMckVXNHhtNEs3djJVMFgyWW1xa0pLdDVzL0tlZkpa?=
 =?gb2312?B?dHlFL3lXVmJYNWdwblNiUkJhUTRSWkE0UCtXOGFDRzJSOUhRc3VFNXhwblpk?=
 =?gb2312?B?aFlqQ3dGODB0dDhNa2t4QVVZTE9UdVpPdjArQnFDdFdmMDNRcTliVFZWcHV1?=
 =?gb2312?B?R0l2ZkRFaXZGWmRSNnZuRmdpc1J4Z1l2VjRrVkJzaFBLSnRLZEVXZ0pEcUpY?=
 =?gb2312?B?UWIzOEdsNHVVb3VGUS9HemZDSElHWHQ0bUdHOGlsUDBjNUV3aDNPSHg5Ulgz?=
 =?gb2312?B?NFNyZFR1Q0RzZWJoU2pKNnZXY2hsVmZiRkl3Z2tJWi9PK1JRbHJWUVVyZDM3?=
 =?gb2312?B?aXhXNVk2SVFJR241MEdpQkdtcFJVekZHSVVuOEtGTWVjLys5Tmwrbm9qNDlI?=
 =?gb2312?B?VDlrQk01YUxEaCtmQ05CY1JnbVZHWWFmZFhiMjA3OTJ6bFpoSVdMZ0pDRnhB?=
 =?gb2312?B?Nk5CNUNXYlhLckhhNXMwL1BzL3c2UldIbENzakxNenQra0VweGxKV0FnVVIv?=
 =?gb2312?B?Rkh1ZlVxYkxPN1VVYTJZdnhFcVRPdUZrSWJqSmhOWktjNTZGMzVyY1pwNTVr?=
 =?gb2312?B?Vm1paEVEb1RCZ2h6WHFSb2FJS1R0SmhjdXhrWTB1eG9pdklNNmpsOTZXekpK?=
 =?gb2312?B?SnY4cjQ2dlBQTG9mTEJKeTJXRThESnRMci94WGU4UkdXeUxxRCsrdWlYRk9I?=
 =?gb2312?B?Q09YMGpTZ0NDYVBOWWNIMlVFY1dJeERjcXFZcXJQbGJmd0NESzVBb1NlV1E2?=
 =?gb2312?B?QlI0OXkwOG92UFhzMFZmWUt6amZoUXgvQlJOUXl2cWdEUDExdkVDUmo5RlF6?=
 =?gb2312?B?VElBSElVbkE2cm9sc1hqMDFBSmQ4dGVjUWUwWk4wR050c0JSd3J3c2p3MlVn?=
 =?gb2312?B?QUtTaHJ2bHRPOFFiclpCOTRmQ0pJdW5nRGtDaWZ1clNpS3N6SENEeG13b21L?=
 =?gb2312?B?RVE9PQ==?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8411.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41557316-bc9d-4541-31b4-08d9af391a6a
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2021 10:56:43.9664
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7hjMtRUBM3699xgF4aRyifl3SdmL6Of443+XV8ziskpbGpuX3TpO2o20x5bEQwzM3w+OT91JWWntA7rDPq0SIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0401MB2664
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

SGkgR3JlZywNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBHcmVnIEtI
IDxncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZz4NCj4gU2VudDogMjAyMcTqMTHUwjI0yNUgMTc6
NTkNCj4gVG86IFNoZXJyeSBTdW4gPHNoZXJyeS5zdW5AbnhwLmNvbT4NCj4gQ2M6IGppcmlzbGFi
eUBrZXJuZWwub3JnOyB1LmtsZWluZS1rb2VuaWdAcGVuZ3V0cm9uaXguZGU7IGxpbnV4LQ0KPiBz
ZXJpYWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBkbC1s
aW51eC1pbXggPGxpbnV4LQ0KPiBpbXhAbnhwLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCBW
Ml0gdHR5OiBzZXJpYWw6IGlteDogZGlzYWJsZSBVQ1I0X09SRU4gaW4gLnN0b3BfcngoKQ0KPiBp
bnN0ZWFkIG9mIC5zaHV0ZG93bigpDQo+IA0KPiBPbiBUdWUsIE5vdiAyMywgMjAyMSBhdCAwNjo1
MToyMlBNICswODAwLCBTaGVycnkgU3VuIHdyb3RlOg0KPiA+IEZyb206IEZ1Z2FuZyBEdWFuIDxm
dWdhbmcuZHVhbkBueHAuY29tPg0KPiA+DQo+ID4gRGlzYWJsZSB0aGUgVUNSNF9PUkVOIGJpdCBp
biAuc3RvcF9yeCgpIGJlZm9yZSB0aGUgdWFydCByZWNlaXZlciBpcw0KPiA+IGRpc2FibGVkIG1h
eWJlIGJldHRlciB0aGFuIGluIHRoZSAuc2h1dGRvd24oKSBmdW5jdGlvbi4NCj4gDQo+IFdoeSBp
cyBpdCBiZXR0ZXI/ICBXaGF0IGRvZXMgdGhpcyAiZml4Ij8NCg0KU2luY2UgSSBhbSBub3QgY2xl
YXIgYWJvdXQgdGhlIGhpc3Rvcnkgb2YgdGhpcyBwYXRjaCwgc28gSSBoYXZlbid0IGZvdW5kIGFu
eSBvYnZpb3VzIGlzc3VlcyB3aXRob3V0IHRoaXMgcGF0Y2ggc28gZmFyLg0KDQpCdXQgYWZ0ZXIg
ZGlzY3Vzc2luZyB3aXRoIHRoZSBJUCBvd25lciwgaXQgaXMgc3RpbGwgcmVjb21tZW5kZWQgdG8g
ZGlzYWJsZSB0aGUgcmVjZWl2ZXItcmVsYXRlZCBpbnRlcnJ1cHRzIGxpa2UgT1JFTiBiZWZvcmUg
ZGlzYWJsaW5nIHRoZSByZWNlaXZlci4NCg0KSWYgbm90LCB3aGVuIHdlIGhhdmUgdGhlIG92ZXJy
dW4gZXJyb3IgZHVyaW5nIHRoZSByZWNlaXZlciBkaXNhYmxlIHByb2Nlc3MsIHRoZSBvdmVycnVu
IGludGVycnVwdCB3aWxsIGtlZXAgdHJpZ2dpbmcgdW50aWwgd2UgZGlzYWJsZSB0aGUgT1JFTiBp
bnRlcnJ1cHQgaW4gdGhlIC5zaHV0ZG93bigpLCBiZWNhdXNlIHRoZSBPUkUgc3RhdHVzIGNhbiBv
bmx5IGJlIGNsZWFyZWQgd2hlbiByZWFkIHRoZSByeCBGSUZPIG9yIHJlc2V0IHRoZSBjb250cm9s
bGVyLiAgQWx0aG91Z2ggdGhlIGNhbGxlZCB0aW1lIGJldHdlZW4gdGhlIHJlY2VpdmVyIGRpc2Fi
bGUgYW5kIE9SRU4gZGlzYWJsZSBpbiAuc2h1dGRvd24oKSBpcyB2ZXJ5IHNob3J0LCB0aGVyZSBp
cyBzdGlsbCB0aGUgcmlzayBvZiBlbmRsZXNzIGludGVycnVwdCBkdXJpbmcgdGhpcyBzaG9ydCBw
ZXJpb2Qgb2YgdGltZS4gU28gaGFkIGJldHRlciB0byBkaXNhYmxlIE9SRU4gYmVmb3JlIHRoZSBy
ZWNlaXZlciBiZWVuIGRpc2FibGVkIGluIC5zdG9wX3J4KCkuDQoNCkJlc3QgcmVnYXJkcw0KU2hl
cnJ5DQo=
