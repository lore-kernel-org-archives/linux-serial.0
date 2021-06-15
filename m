Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97B94C49EA2
	for <linux-serial@archiver.kernel.org>; Tue, 15 Jun 2021 16:01:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 782966148E
	for <linux-serial@archiver.kernel.org>; Tue, 15 Jun 2021 16:01:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231596AbhFOQDW (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 15 Jun 2021 12:03:22 -0400
Received: from mail-eopbgr1300082.outbound.protection.outlook.com ([40.107.130.82]:26741
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231880AbhFOQDN (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 15 Jun 2021 12:03:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fk/Jw0ZnSwR8iqkiYmgROg3Lw5gpzuSa1y0w2gQZGx1V2wOMIVKyhmqjT/Ng7iRSbJ/5UZrB3b8XguTv2RxxiXfg8BG8cjdzeQVt2Py2kGWiTR+NWiXauFHFfIhxx+VO6l8bpW0iIK8G+vKFIl4zfini3wkXxiH7okja0en8Wde7Wvk1t5HqWxGKXGroUR/OqPdscZcDZDyZ2gpSCoXqMsDXY3rwPfOALchcUdJqTDKda+6+BMst4AMVfQNtdSASLvK+RWQ0/KNp43RkSpTUtDylk9Gn0Rv8bWEy5E2jBsK35uBxPHH9F4N7a/hYgeHjOlFpg1eAYRrL3P3c2aZs+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4aGP/v6iy6DfD44L2Ui57sFSWJwR5wG1WcTyIT1dbSM=;
 b=H13qEP21M7vC3L+JN/DDJOiRTi0EvJ95HAEd/zVPoV0dwhK0Xo2DFxo8iPwxByUNleugvA7mnGa0QVeeUzedeyg1kJWd7/fYiBnuSBlhg6vj43O7FrPTXofhWRFUtzWcZiTuimDk9VJ7mxpDiuV7Awdmxspp1dUmVKl8W4VX7vh+VyZtX83kDSVNqbWZCDdMAiJ9+ey8jXEmpOZ1VHiuY/Iyux4KsOlzHWLmUuITQ32zykMP3X3WssZpYbdgQsjbgvmtLCCM0Pd2W+N+gBF+dz+n1TwldIXAhupBCWGJGUkhOGP1ExrYBhpP71jN8XMBm8l0nYozZj/WL3guOv3Rlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cortina-access.com; dmarc=pass action=none
 header.from=cortina-access.com; dkim=pass header.d=cortina-access.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CortinaAccess.onmicrosoft.com; s=selector2-CortinaAccess-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4aGP/v6iy6DfD44L2Ui57sFSWJwR5wG1WcTyIT1dbSM=;
 b=RbvXJNsH8pbL+tv7bzDixVMWhyc5+Ygo2KNcfIxnZqtv0wRWVSySuzopR0cdQxOiYNYKYS8UUDKi3KmivIEqFp+K1XnKlmMo9UIZcMOiteDsMYh22tDxJcV8tjMyjmPYi07TdquZ1uDoUyjqYBMX6WvD1LbGcTWuOcQwgmzKRNY=
Received: from PS2PR01MB2504.apcprd01.prod.exchangelabs.com
 (2603:1096:300:3e::11) by PSAPR01MB3925.apcprd01.prod.exchangelabs.com
 (2603:1096:301:42::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24; Tue, 15 Jun
 2021 16:01:03 +0000
Received: from PS2PR01MB2504.apcprd01.prod.exchangelabs.com
 ([fe80::e9b5:6b16:ec29:6101]) by PS2PR01MB2504.apcprd01.prod.exchangelabs.com
 ([fe80::e9b5:6b16:ec29:6101%2]) with mapi id 15.20.4195.032; Tue, 15 Jun 2021
 16:01:03 +0000
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
Thread-Index: AQHXRQOE/WvPoJrMTEyo68j2OIxsw6sVL9QAgAAcBACAAAttAIAABaUAgAASk4CAAAXDAA==
Date:   Tue, 15 Jun 2021 16:01:03 +0000
Message-ID: <85A4CDE8-F856-4EDD-936F-B3DF5AE4B1E4@cortina-access.com>
References: <20210509184519.15816-1-alex.nemirovsky@cortina-access.com>
 <YMiUgpRbfwMHCqD+@kroah.com>
 <DA86E839-4208-4535-B70C-ACFC94438BEB@cortina-access.com>
 <YMi1mIwOTLYs8h8/@kroah.com>
 <49AAFE67-C151-4A7D-AE6D-E8981CBC9503@cortina-access.com>
 <YMjJ6bWIGCUrhjfb@kroah.com>
In-Reply-To: <YMjJ6bWIGCUrhjfb@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=cortina-access.com;
x-originating-ip: [70.58.207.205]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3cb9c365-a4df-4f2c-60d0-08d93016c6f9
x-ms-traffictypediagnostic: PSAPR01MB3925:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PSAPR01MB39259F34934E6C8EF635B5FDCB309@PSAPR01MB3925.apcprd01.prod.exchangelabs.com>
x-ld-processed: 0694623c-6669-497c-89c3-3a32a9934313,ExtAddr
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8ncbJSN2muUghkiZnALfSUOQVGFBxrzlAEKOmluZ48SHRCjiqYmWQmNd7jnf+vhMLWWi1YyiZ9FZyWoGamrZOwHWgHPnejSNPaJSuRYXb4e4UqCkG7HsTvf/N9FNy6i8xm6bh3Qov7+DyJJMd/j3S5U/5tSqwYdql3BQnMYNAXDVnEGJJzg2c8e8W/HMgrLBIzrLFCXa2W0am0AX68UGsgphmFLZnTqSaImlLWQ/zqZdD9CHVnmlLhjjmJEHQJPZ5iFY8ZrVZ7/BhOcqDG/2zDBhfKV1G03a0eJlRIm6oh5ZkFNXPcwFtJ+cWkdDlKt90KvxUoYM1VJj/IT6ECzypZL7U+Htj0wLuspH37b2rhQarSbk026MjSTVuuSo6OyTH7ct6FvQjIXI2jdm44qWTa3+0Y77anBr9bG8O8b8GbPks4vPLELDNwWBkhael8FZhbqDmh45lP4YvABOWuBW3Xu/Gr+6ZHozTnAdwR7uExkCnmIOhN3qTvrbTMYFu3cpjSyZgbH3I4O1FYKTRrwlZ+aL1XEHwWcOZfkxY0oqLU2+c9u4hJBtaZ6cjwc2C8HtqAerzDvg0FxayKDf9UiyLgOP3EeXzpoqlnBvYQmSrjRJatiBGUNnbsETZV4Qffdc6xkvtD/c2jojLXohVrMlFIr7Ln2aCLOhWFrYABHjo5dURl+nkLieYLFuoHxshgqaAC/qJ33xCft4jx96gzW7Bg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PS2PR01MB2504.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(4326008)(8676002)(122000001)(5660300002)(6916009)(2616005)(8936002)(86362001)(38100700002)(83380400001)(19625735003)(6486002)(966005)(498600001)(6506007)(53546011)(71200400001)(33656002)(76116006)(91956017)(36756003)(2906002)(66446008)(64756008)(54906003)(186003)(26005)(66556008)(66476007)(66946007)(6512007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TW9PVDZ5ZTNxUEZCK21Say9GbW9CWnBEQ0RVOUQ0aU4yNjVRbGxpUnBSMzRs?=
 =?utf-8?B?c3pTS0RldmdzREZmNnR2bUJEWU92cFFtMmRYdDdlcVpZRmlYNXB1WW5wQ1Zr?=
 =?utf-8?B?cjEwQmI5d3FMMlZ4N2JUSGZYOEl1eUI2NGpQT0dWZmVIdStydjlacDRuUFJV?=
 =?utf-8?B?bFRBanIwdjFud1lLSWU2eVM3QjF6czZpdU56YmVWdVUrRUZZbjE4dDZjSTVO?=
 =?utf-8?B?czZ5akhjOWVaYW1CR0VzMTQ4NXpTN0lkaWtSQW8ycDdDZW9nczVuT2Y4blFx?=
 =?utf-8?B?Rkx1RFNIMGZPeVZQVjZ3bEY2ZU40MDFtNkkvMm00UmlHWEJsb1R6ZkVDNW5q?=
 =?utf-8?B?SXVZU0E1Yjg2elZudk9JOHpGemdqT2d1bjlCaHoyS0VEcHI1Yk9keEJReldm?=
 =?utf-8?B?U2swYVJFaHRWN1kwRE5ENEhlTTZGRTNkaDY4OUlZdDI0WmIxZjVEZzdRNDJ1?=
 =?utf-8?B?U3R5TXNXU2ljMFpDazFLb2JLUzAxd0c0aXBsS2pDQnUwTGptMzArcnBQTlda?=
 =?utf-8?B?QnU1cUVLWVlSdDl1Z24rc0VDaFhqd0ZJdlM4allQc1ZnL1BhSTk2RUR2UHRJ?=
 =?utf-8?B?d1RjUTZmRGRhbnozL2xmTHp1NEUwRHFoRE92alBqd01IMjFvdE5IcUIzYVZa?=
 =?utf-8?B?emhWbVpscTRnaHdjaldVL09rQkhSQ0dqemVSWkpNYUl6eENCRU91WkFLRkZp?=
 =?utf-8?B?TFBKVCtBeHg5K3ZjL0hiQW14emYzaVpYc0JGQzY1VjZ5MFh0Z0hjU1NsbldI?=
 =?utf-8?B?LzB1QVVidVdVMTZFcWJWVFVXREhUV3N4OGhOKzVabUJqdlQzUFhGeCtBN2dI?=
 =?utf-8?B?aVNGdlY2OTBqM0ZIOEtxWE8xRnhyZFFQQlBWVU1JYWpXM09EY3lqMEJ4eGVs?=
 =?utf-8?B?Ni94czk5SGNidFBDOEh1cnJUV05kcmdQR2hsZWZGeW8xYkN4MmJ6V3lzWUtT?=
 =?utf-8?B?QjNFcXdGYVBtTUhZRkJTakhVVWFKVi9uK0xwclFDVXZuUzRlWVNvdXZzbGhB?=
 =?utf-8?B?TElGR1A0dE91ZVpGUFZ1Mm5xNW5DemxXeFV0WDZlQUFUR2pONU1uNWpzakk5?=
 =?utf-8?B?QVpNdjFEK2ZxQ1I3ZlpuVXJZVjFtUFdINEk1NXhIRyt4Q3pWcWwwR2hqZXNB?=
 =?utf-8?B?cCs4aG8wcUVWS3l4M3pibFd6dHdhTUF1ZEdDNkJnejAveU5XMzI1VGQxRkJU?=
 =?utf-8?B?T01yVU1IdG8wWlU3RTJEQ2VmK3l1Vll6NGFtK3NMTEhjc2Zsd0NjZWpoYkxI?=
 =?utf-8?B?SUlSTFZMa2ZERlBCbGVtU09rRk1qUXRoMUI5N29oZmNzZWw2bkJUSCtpcWRS?=
 =?utf-8?B?eTErUTB2YjFjOXBYYndNcTlVRERPcG1Ka3JEVHRsYkdoOXVQaG1mVjVUaUFS?=
 =?utf-8?B?MWtsK2VwZ2pTdDZxUTZZamRLZHBUbERpbHI4bEFuYWtqZ1dWaU9hbU9ON3Ew?=
 =?utf-8?B?bXFaMjZWMkUzem8vZlJNMnhjQm5ac2dBbk4wVStrRXQ1cWR2ZCsxMkRadGN2?=
 =?utf-8?B?YTk2YUJFMVRUbDBJcUNYVzlyVEozeEJZblF3K05rdXBFbHRlZE1vazRDMVNp?=
 =?utf-8?B?VHd2ZlhHZGhCNmdBUHpJOU9RaWZHODFUTmg2cnk3TWtEU1pESTgwWXNBMkRF?=
 =?utf-8?B?RjFPZjhUR3djR0o0VEVYYkh4NHlIWkZrakRJYWxjcXY1aVVJQ1BVNVVYS2Vy?=
 =?utf-8?B?eXo4WEFIS3ZSSzd6S05mYmZreUd0SjJvUWh0MEF2bGgzRjZwdEdYd3Y4TFkx?=
 =?utf-8?Q?9agVPHNCRQzQU3339x1d5KSMcKwR8S/bulohwOd?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1CAB1360CC9B954D9F4B4BBE3911A11C@apcprd01.prod.exchangelabs.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: CORTINA-ACCESS.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PS2PR01MB2504.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cb9c365-a4df-4f2c-60d0-08d93016c6f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2021 16:01:03.4032
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0694623c-6669-497c-89c3-3a32a9934313
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KKg4txCuygo1qNJVabZvFXFF2gwC1dViYkSuPHdwPx+29sUXB6/Vtj2ft0upbTyvbzHftQv0Tw6xPJnLBnoDocHz3qwFQQDnBgZPa2Oqg80AzUsqWL3dh7ay+haHrVxU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR01MB3925
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

DQoNCj4gT24gSnVuIDE1LCAyMDIxLCBhdCA4OjQwIEFNLCBHcmVnIEtyb2FoLUhhcnRtYW4gPGdy
ZWdraEBsaW51eGZvdW5kYXRpb24ub3JnPiB3cm90ZToNCj4gDQo+IEE6IGh0dHA6Ly9lbi53aWtp
cGVkaWEub3JnL3dpa2kvVG9wX3Bvc3QNCj4gUTogV2VyZSBkbyBJIGZpbmQgaW5mbyBhYm91dCB0
aGlzIHRoaW5nIGNhbGxlZCB0b3AtcG9zdGluZz8NCj4gQTogQmVjYXVzZSBpdCBtZXNzZXMgdXAg
dGhlIG9yZGVyIGluIHdoaWNoIHBlb3BsZSBub3JtYWxseSByZWFkIHRleHQuDQo+IFE6IFdoeSBp
cyB0b3AtcG9zdGluZyBzdWNoIGEgYmFkIHRoaW5nPw0KPiBBOiBUb3AtcG9zdGluZy4NCj4gUTog
V2hhdCBpcyB0aGUgbW9zdCBhbm5veWluZyB0aGluZyBpbiBlLW1haWw/DQo+IA0KPiBBOiBOby4N
Cj4gUTogU2hvdWxkIEkgaW5jbHVkZSBxdW90YXRpb25zIGFmdGVyIG15IHJlcGx5Pw0KPiANCj4g
aHR0cDovL2RhcmluZ2ZpcmViYWxsLm5ldC8yMDA3LzA3L29uX3RvcA0KPiANCj4gT24gVHVlLCBK
dW4gMTUsIDIwMjEgYXQgMDI6MzM6NTdQTSArMDAwMCwgQWxleCBOZW1pcm92c2t5IHdyb3RlOg0K
Pj4gRG9lcyB0aGUgc2VyaWFsIGRyaXZlciBwb3J0aW9uIGluIHRoZSBmaXJzdCBwYXRjaCwgcmVx
dWlyZSBhbnkgbW9yZSBjaGFuZ2VzIGZyb20geW91ciBwb2ludCBvZiB2aWV3DQo+PiBhcyB0aGUg
c2VyaWFsIGRyaXZlciBtYWludGFpbmVyPyAgSWYgdGhlcmUgYXJlIG5vIGlzc3VlcyB3aXRoIHRo
ZSBkcml2ZXIgaXRzZWxmLCB3ZSBjYW4gZW5nYWdlIHdpdGggdGhlIERUIHRlYW0gdG8gZmlndXJl
IG91dCB3aHkgdGhleSBoYXZlIG5vdCANCj4+IEFDSyBvciBwcm92aWRlZCBhbnkgZmVlZGJhY2sg
b24gdGhlIERUIHBvcnRpb24uICAgQXJlIHlvdSBnb29kIHdpdGggdGhlIGNvbnRlbnQgb2YgdGhl
IHNlcmlhbCBkcml2ZXIgaXRzZWxmIG1pbnVzIHRoZSBsYWNrIG9mIEFDSyBmcm9tIHRoZSBEVCB0
ZWFtPw0KPiANCj4gSSB3YXMgd2FpdGluZyBmb3IgdGhlIERUIHJldmlldyBiZWZvcmUgSSBsb29r
ZWQgYXQgdGhlIHNlcmlhbCBkcml2ZXINCj4gYWdhaW4uDQo+IA0KPiB0aGFua3MsDQo+IA0KPiBn
cmVnIGstaA0KDQpTZWVtcyBsaWtlIHdlIG1pZ2h0IGJlIGluIGEgY2F0Y2gtMjIgc2l0dWF0aW9u
IGhlcmUuICBUaGlzIHBhdGNoIHNlcmllcyBoYXMgYmVlbiBpbiByZXZpZXcgYXJvdW5kIDYgbW9u
dGhzIG5vIGFuZCBJIGhhdmUgeWV0IHRvIHNlZSBhbnkgZmVlZGJhY2sgZnJvbSB0aGUgRFQgdGVh
bS4NCkRvIHlvdSBldmVyIHJlYWNoIG91dCB0byB0aGVtIHRvIHRyeSB0byBnZXQgY2xvc2VyPyAg
SWYgeW91IGhhdmUgaGFkIGx1Y2ssIHBlcmhhcHMgeW91IGNhbiBzZW5kIGEgcXVpY2sgZW1haWwg
dG8gdGhlbSB0byBnZXQgdGhpcyBkcml2ZXIgb2ZmIHlvdXIgcGxhdGUuIEnigJltIHN1cmUgeW91
DQp3b3VsZCByYXRoZXIgaGF2ZSB0aGlzIHJlc29sdmVkIG9uIG9mZiB5b3VyIHF1ZXVlIHNvIHlv
dSBjYW4gaGF2ZSBtb3JlIHRpbWUgZm9yIG90aGVyIG1vcmUgaW1wb3J0YW50IG1hdHRlcnMuDQoN
Cg==
