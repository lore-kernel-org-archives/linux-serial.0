Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 053D0C4338F
	for <linux-serial@archiver.kernel.org>; Thu, 19 Aug 2021 01:27:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE38D610E8
	for <linux-serial@archiver.kernel.org>; Thu, 19 Aug 2021 01:27:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234618AbhHSB2b (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 18 Aug 2021 21:28:31 -0400
Received: from mail-eopbgr40059.outbound.protection.outlook.com ([40.107.4.59]:52318
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234194AbhHSB2a (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 18 Aug 2021 21:28:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I8Hjfgrn3MQtAGCXtUnN3Lz13O/5elhp1mnl611DbLWdKnpkdldDbW7HlHqNnlVdOUMu/MfVAX32URc1h24F3sZHuy6FXxWnNi7B+Bwg9lWmLymsr9qyUQMMeL0t5IgagfGSX2gNSZ0O8AK+dnn65qg8yFdjpiVA6STZemPMgnWNmKJn7BqfZOledz0hh9fRUFict0rSqs7Os1hxPO6v8/68YVhGVPv9CO9p0Jz19SYdiiWRUzJit5kfvAzVv6cZLpx5Y5qfv+CTraWC8Suls8n7nMrAV8zGve2c/s57iv6eyNClIJjezFQ3xFebrkrpJzVzmQwkOwKdRKlK2Kee4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aqnEogQNhfcHXQg0hPqVsA6Drpa84oGDLfHmdIUUBOo=;
 b=iSJATWONIbL3FqjHOzaxBj53KTXSEbOIl0HBuOEU/47IjuzNQx2EXmFt9bcTt8SULHZysnjVRPAY5b1dtNsJSVNOKZdvF/8IaVxUcaIhV9WaRVtar2LkXNl+gwq734EmTMMK4G2gZXIKHh9xgCFuk7bpavpqrd6wLvQ1Y5MPmhbzjyuRE7Xg+cEsYmzIA0tbzlnhwnP733JUHf8RcDu1qT1Fza8zXEOEOSJ+srF3OvIifBfqzoXubrRZ+CgvwHOPRjF+DzuotzXZZcTFv+qBskDG/GWNWZFXXlFW0AxOSdgEX2jhrmgLC5qb7Wq/tTt1vIvt3+k7XFhd+rOrmGAMyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aqnEogQNhfcHXQg0hPqVsA6Drpa84oGDLfHmdIUUBOo=;
 b=NmvKy+hNaVXXMyR5Fvp0RJyiJtTfB3y6/fxP617Y/hileg0gv6jRaMrQNOoH+A0Y4ptHRwn8XDd8FeYfr1o7yfVd1NW+dfOsa0iWzjkN8r0YGCYDt2OGMnIKhZEqYbJgcGlfcT1Oe7NRhbap/WL8heMHbItvCP+tQ8t+A+L4u+I=
Received: from DB9PR04MB8411.eurprd04.prod.outlook.com (2603:10a6:10:24c::9)
 by DB6PR0402MB2837.eurprd04.prod.outlook.com (2603:10a6:4:98::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.19; Thu, 19 Aug
 2021 01:27:51 +0000
Received: from DB9PR04MB8411.eurprd04.prod.outlook.com
 ([fe80::45d9:aada:5e1f:db81]) by DB9PR04MB8411.eurprd04.prod.outlook.com
 ([fe80::45d9:aada:5e1f:db81%6]) with mapi id 15.20.4415.024; Thu, 19 Aug 2021
 01:27:51 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "jirislaby@kernel.org" <jirislaby@kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH] tty: serial: fsl_lpuart: fix the wrong mapbase value
Thread-Topic: [PATCH] tty: serial: fsl_lpuart: fix the wrong mapbase value
Thread-Index: AQHXkzGZ2pnho/XCxk+AK2PI+8qIXqt5TbsAgAC+gtA=
Date:   Thu, 19 Aug 2021 01:27:51 +0000
Message-ID: <DB9PR04MB8411835BFAE26A3E1C4681F892C09@DB9PR04MB8411.eurprd04.prod.outlook.com>
References: <20210817063058.4718-1-sherry.sun@nxp.com>
 <YR0TmJJ/WkfE2zkR@kroah.com>
In-Reply-To: <YR0TmJJ/WkfE2zkR@kroah.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3e76cc6c-29ce-4ee3-d9ce-08d962b08fa1
x-ms-traffictypediagnostic: DB6PR0402MB2837:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB6PR0402MB2837E9B3F8C2FA7299A74F0D92C09@DB6PR0402MB2837.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kbuEoCivi6HOZnXD0vi9eaGD2RMM6VUSJvOTK0YASGHy65wCtVAIj6BnSsZBBBDGhu508ISowQfqWCYkHWcXuUHcyBtQ+cRB6nKG5WgoIRKmO02d49gHQgvecRm9fB+6yEpp3RsWb1F2ub2Z/Q+SMTZUlt7oonB4BZgab21YXQBARk2uk7uxlQTwRF4yzWxv3ZNOi76EG13RKmkQaNnRuG8nijA/GV/5Cy65E8yA1bwJmCZxb60howmxI5m4PSrqvYsaH4DxbZwQN5/NQgvHUrQTRxugx5YTEIAeg8/du0bVLNaGSMHg7bUhW+aneoxDjLONlSZnfnG6rbXJHRFd1zr01BFRR6jAAVaR8fZx5YkHebX7p6cgRGkMFfesHSbfZ1tPoQGFUbczQsO7kQ/ClfNT2qIv8DsHM72Y4EUmwn8ketq/Ry69clf4wvTIK31i3ZhE/tUqxWGehUzLHSa7N2fFZcmWK6CkiAb96BH3GYWVR1VVRQDi81K6/bwa6IxX0DmFV0BW8sO2mBlpMv/UVVaVrdRxfbSt58ZbXilI39cn44EVQqF2Kt06FScEFccetpdrr1ggIeXgKSv62FMAnTri+K+2iFOiNvvlFI506bvo5WG6U+sMqjDSx2CB8jDx5FzeZ1FEFHq+SYIJG/H/Ne839nQqF3kURIkCPEmPIzU4HG4UlrNKdE2AcX5R08Q/LvivO100ieWrrkKkjMfB1A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8411.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(39860400002)(346002)(376002)(396003)(86362001)(54906003)(26005)(6916009)(2906002)(9686003)(66946007)(186003)(66446008)(66556008)(66476007)(64756008)(71200400001)(76116006)(4744005)(38070700005)(6506007)(83380400001)(55016002)(53546011)(8936002)(44832011)(8676002)(316002)(478600001)(5660300002)(38100700002)(122000001)(52536014)(33656002)(4326008)(7696005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?dGRvYnF3cmJWaVNQWWtHT1Z2R3JoK0RHMGNrUG1qcWlaUU9nK1U5YkwxMXQx?=
 =?gb2312?B?MWp4dk9UeXg4VkFpdEVTUEtGNHZkQVJ5OVkvOTRTYzQwSkVsNG5UcXJLbTU3?=
 =?gb2312?B?RENoUzVid1UrbzJyUUVGam9Td01FbGdkN0o1Q25ZLzZTOENHV2RpNFpWdWtE?=
 =?gb2312?B?UjlxSUxLQmRPQUJML05NNyt1bUJVWXhMUUJhNVVrSUNUa2x1L3dLZVN2RGho?=
 =?gb2312?B?eDdHOTdrZGwxWEdDaFZMakxiU256Vm02ZHo3S2tlbHJNNlVvNmNZcVl1QW9M?=
 =?gb2312?B?LzV3WUE3clVOZFRwUjZLN05DalhhTkxHVS95cUc3eEpWTU03ZWRlRjBRcUJB?=
 =?gb2312?B?emM0NGgwS1dSNkdvWEhMK0xOV1VvNmlqMklzakVHbTVXYVFBQ29LK2ZYakdr?=
 =?gb2312?B?UzlqODdhUjRrb1F6NGFHQkRXQlg3Sjdpa1pjSjA3M0ZKWEFFUVNHdldZVkha?=
 =?gb2312?B?bTFnd0F2ajhXYzYzdFMvUStBb0pLdzROMHAzNm9hbWtteGdsT3NhaFBxV0dq?=
 =?gb2312?B?ZkQ4SUIzRjhwMDhnMXR3U1MzSnpheU5PQVJKVTRrRVc3WHBGVlFQOG9vbkN6?=
 =?gb2312?B?clI1cVlLd2ZrOXJGT0kwWGp2Qi9ML2pPNjA2M3p2bEpEbWVib1BZRVM2Njgx?=
 =?gb2312?B?NWp4U0RCYTFNaW51c2JxRTY3RTdFaXU3d3d4VW0yMU43MmFIOExKaDJkTFhW?=
 =?gb2312?B?eWtSZnpmQTltQm0yeE5zNUJUR0tyWUZHM3ZWVkdtbFdDaFprakJ6Y3U4R3JG?=
 =?gb2312?B?QThYWXhLOE5sdVlQU1Nqa2UyNTFNMmxZTnB3R01rbHhGTnVVSzVQSGN0Vkpa?=
 =?gb2312?B?YnNoRUpPZ1dZa0laVDFaUTc4ZGRDejI1d0RkVmlGZWZiVVJGVGZjTmprUjhj?=
 =?gb2312?B?WUFsbVkyZTczK1ViTUxldzRZMXNMUVlGZlh5a3JzN09ISHBUczhNRnJpdWNM?=
 =?gb2312?B?THVGZjJ2bmFhQVNJNnhqUklMNHoyWE1paStkeWhYKzFoQWo2Mk5CNjNudm9r?=
 =?gb2312?B?djQvcENUR0Q3dlBkSXF6VzM4ZWhLT0dLSzA2Sm5rZFhueTdLZ1B2NjFRQ2dr?=
 =?gb2312?B?ZzdJT1RDL2RMYUZMTVNUaTdkY0t3SS8xQ05ZT2pBc1NGV2ZERHIyVzlKVTJK?=
 =?gb2312?B?SHdpeEVqMXY0eXAxWElFTWoxL0orOVpJc3MxUDhFVFNjVkp6c3pYREJHdHU5?=
 =?gb2312?B?Z3JPYzRIZCtobEJSNHlDcHNaY3B5cWVpQ1Z3cVRWTWRvSzRRZmdNdkNDbHRT?=
 =?gb2312?B?ZkJGZy96RE5lQy9CazRZVWFLdHRlSE1zVmR0Y3kxSm4zN01Xbm1kRW1rMXJs?=
 =?gb2312?B?NlArYkVIU3V4R0tJSzRIdERzKzhGTEN5a3VOZXdLSXhiRWhkUEY1R0VtQVZz?=
 =?gb2312?B?aHV1Z3RIdjNnNGZVbW95b2JsNk94elpXMFBwalVWS0ZzMWppTElMZkdvUzhq?=
 =?gb2312?B?UUE5ckpKOVVaWjRmSEM1MVlSVVRDVVdrWkJUcnN4VkRHR21PVUtpM3dEaUd5?=
 =?gb2312?B?YTVCYVpsWERqdnNHSXJyVURVQzZOUFA1S09ZRnRTWG5OY2JHRkVoQk9UUFhE?=
 =?gb2312?B?TldqdjJCQTNBQ0dDMmFQdm55NjZXaFRKQkgvUzRlMjloQmZvaktnbGZFYmpJ?=
 =?gb2312?B?RUhhb1RUTW5pMGNjRktRU1AxdVZLQ0thREt6L1QvaUNtVC94S3pFVkEwakR6?=
 =?gb2312?B?QnVaMmNRTXRtSXJKY1UvVmNSUjVKNTlkMnVjLzBJN3ZWNnNKSXlZelpwb0dM?=
 =?gb2312?Q?Ob7fUes+ZjfoK1e7bk94P8GdT7k4plrB8i62+aP?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8411.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e76cc6c-29ce-4ee3-d9ce-08d962b08fa1
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2021 01:27:51.1866
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UNkotSN+OpItrqtC7oKUp2XyWm78ZLN6F1/dGJ0WAYRbB9vd3ilskVtOEH3Lo6nYL3H+mhGfTkk0JI0LvtINSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0402MB2837
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

SGkgR3JlZywNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBHcmVnIEtI
IDxncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZz4NCj4gU2VudDogMjAyMcTqONTCMTjI1SAyMjow
NQ0KPiBUbzogU2hlcnJ5IFN1biA8c2hlcnJ5LnN1bkBueHAuY29tPg0KPiBDYzogamlyaXNsYWJ5
QGtlcm5lbC5vcmc7IGxpbnV4LXNlcmlhbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LQ0KPiBrZXJu
ZWxAdmdlci5rZXJuZWwub3JnOyBkbC1saW51eC1pbXggPGxpbnV4LWlteEBueHAuY29tPg0KPiBT
dWJqZWN0OiBSZTogW1BBVENIXSB0dHk6IHNlcmlhbDogZnNsX2xwdWFydDogZml4IHRoZSB3cm9u
ZyBtYXBiYXNlIHZhbHVlDQo+IA0KPiBPbiBUdWUsIEF1ZyAxNywgMjAyMSBhdCAwMjozMDo1OFBN
ICswODAwLCBTaGVycnkgU3VuIHdyb3RlOg0KPiA+IEZyb206IEFuZHkgRHVhbiA8ZnVnYW5nLmR1
YW5AbnhwLmNvbT4NCj4gPg0KPiA+IFJlZ2lzdGVyIG9mZnNldCBuZWVkcyB0byBiZSBhcHBsaWVk
IG9uIG1hcGJhc2UgYWxzby4NCj4gPiBkbWFfdHgvcnhfcmVxdWVzdCB1c2UgdGhlIHBoeXNpY2Fs
IGFkZHJlc3Mgb2YgVUFSVERBVEEuDQo+ID4gUmVnaXN0ZXIgb2Zmc2V0IGlzIGN1cnJlbnRseSBv
bmx5IGFwcGxpZWQgdG8gbWVtYmFzZSAodGhlDQo+ID4gY29ycmVzcG9uZGluZyB2aXJ0dWFsIGFk
ZHIpIGJ1dCBub3Qgb24gbWFwYmFzZS4NCj4gPg0KPiA+IFJldmlld2VkLWJ5OiBMZW9uYXJkIENy
ZXN0ZXogPGxlb25hcmQuY3Jlc3RlekBueHAuY29tPg0KPiA+IEFja2VkLWJ5OiBGdWdhbmcgRHVh
biA8ZnVnYW5nLmR1YW5AbnhwLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBBZHJpYW5hIFJldXMg
PGFkcmlhbmEucmV1c0BueHAuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFNoZXJyeSBTdW4gPHNo
ZXJyeS5zdW5AbnhwLmNvbT4NCj4gPiAtLS0NCj4gDQo+IFdoeSBpcyB0aGVyZSBubyBzaWduZWQt
b2ZmLWJ5IGZyb20gdGhlIGF1dGhvcj8NCj4gDQo+IFBsZWFzZSBmaXggdXAuDQoNClN1cmUsIHdp
bGwgYWRkIGl0IGluIFYyLCB0aGFua3MhDQoNCj4gDQo+IHRoYW5rcywNCj4gDQo+IGdyZWcgay1o
DQo=
