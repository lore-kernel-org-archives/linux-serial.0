Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5732BC433EF
	for <linux-serial@archiver.kernel.org>; Fri,  5 Nov 2021 10:37:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 361EB60E97
	for <linux-serial@archiver.kernel.org>; Fri,  5 Nov 2021 10:37:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbhKEKkV (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 5 Nov 2021 06:40:21 -0400
Received: from mail-dm6nam12on2040.outbound.protection.outlook.com ([40.107.243.40]:46817
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229471AbhKEKkV (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 5 Nov 2021 06:40:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ny8L6FkiPnqRMJvrD0gYyxKbMTEVzUjrVJgtkLmtH81+EkWoBNFu49/44JDeQclhndk7NA1IIX3xkfinYdIOjysDJnIjw7waO9sl7rrM4VAfgkX1i4hRDpzqCr/+Ig9HHmzHFwfxAx4DfGaF9McwcGcryufqJkA/+54uZ5zZtRPrjz9yO6rZ+JHDwBGLL7LHMEsX0/YP8djYzeataY90cMHRYBkPTH5ZMpsmOVGZWzBfqkYzAOArHiSTf9YhN6L2E1YaIJPXgX2cB3BPBoGeFjGmsPCeBFvLCERzxr+7zpJEQ0pqOdgqxq660/vRqyF8EPiA5VG/yySRZvwH6VdfRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=StNgZwrqtldl0ge3lcVpUSMzPJI4kQf8OgKWaD5tEM0=;
 b=JmNEi7uqcLjJwo7iw+lDArSd3Mf5P9bp4J1plg3xVw5gffGsr3cmRQJgubbxQf3pWf2hjIWBnPt6bnn89WuJ63pcNOZuM+bhteCdpLJdVuSoYdbPWjz/FnpygEbUP5owPjLoM+Jc07wSofzv9D4D2TgwWttayrrPVLakbCilWase9BFd9Y7Ke0xPWr6D7/pJtGyTUnZvfIoBqtuhUhmMR9kRClH6XggwQeCKGeGP5vB5Qk4VzYERl3rxVAf2fRzOT0YJF1M+0rs7ei55vXhLjcRWl7UBIq/WKDh93lTiY73ONrheoPhCp6WddbIOD3GS65dBq9Qoy6vLJ6n0VgMQ+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=StNgZwrqtldl0ge3lcVpUSMzPJI4kQf8OgKWaD5tEM0=;
 b=elnNmBkzRZSZP+XKpmA8mFIc6xiHAVALb9+nRueShmQ8k2ucMNKEIE35wb9hLoLCH8hDzd2ID8xCV1QKGa7ptSYXhEwm0ujM7JJdcpdRBDMPnorbkRnX38wWtHL8lcVY3Itt52aur9QeRI91ijvjfUtp9Q2cvBoVAsABPbJ43aY=
Received: from DM6PR02MB6635.namprd02.prod.outlook.com (2603:10b6:5:221::18)
 by DM5PR02MB3831.namprd02.prod.outlook.com (2603:10b6:4:b4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11; Fri, 5 Nov
 2021 10:37:40 +0000
Received: from DM6PR02MB6635.namprd02.prod.outlook.com
 ([fe80::987b:184a:b206:565e]) by DM6PR02MB6635.namprd02.prod.outlook.com
 ([fe80::987b:184a:b206:565e%5]) with mapi id 15.20.4669.013; Fri, 5 Nov 2021
 10:37:33 +0000
From:   Shubhrajyoti Datta <shubhraj@xilinx.com>
To:     Michal Simek <michals@xilinx.com>,
        Anssi Hannula <anssi.hannula@bitwise.fi>,
        Michal Simek <michals@xilinx.com>
CC:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] serial: xilinx_uartps: Fix race condition causing stuck
 TX
Thread-Topic: [PATCH] serial: xilinx_uartps: Fix race condition causing stuck
 TX
Thread-Index: AQHXzxvoczEnA2WEsEyUk6uhlE5L3Kv0w5UQ
Date:   Fri, 5 Nov 2021 10:37:33 +0000
Message-ID: <DM6PR02MB6635D726C2E585AEE32AE832AA8E9@DM6PR02MB6635.namprd02.prod.outlook.com>
References: <20211026102741.2910441-1-anssi.hannula@bitwise.fi>
 <685e4187-d2cf-4468-ded3-cca0e8bf35b4@xilinx.com>
In-Reply-To: <685e4187-d2cf-4468-ded3-cca0e8bf35b4@xilinx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: xilinx.com; dkim=none (message not signed)
 header.d=none;xilinx.com; dmarc=none action=none header.from=xilinx.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3b1e60f1-4620-4833-779f-08d9a0484701
x-ms-traffictypediagnostic: DM5PR02MB3831:
x-microsoft-antispam-prvs: <DM5PR02MB38316E96EFEDC1352230239BAA8E9@DM5PR02MB3831.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7IwNYYxIgUzFYf1LnKlH2+6vqJkAdRySyrdS2t4NckG39Cwl5JF/aEHLeRWc4fdF5uM0/NHuwKJY5EhxmMMBMvkNq5GhESkq20cFg+EEr17IGYhdPToF+Q0/HW8h+39qOOMMb+PANOVgD8GbY02qK7dERZ+5mJwua+4rdFX1YtqVXaZlGF+Q17xp2y1x4Gh6PJKRE6p02MmPToeuNNGZfGl1BlMUpUwK5Si31rN29+1I9BoAINXUGF873xGv4e1pCpTp/vJJVXLamIGlpUrgdrQ/0MwE9svTSGpIu6dLQSFULAUOuzbDyzKxtEF44ROyzV1WM/F0OhgqUPsn7T4mu72XEu+x7IsO98W+nPRgjd2ufx5k5LrbKUkOsH8vwyMqthQyMGesy30EaTOVc3vRrlIFPWLmvqHa+7ub9MdNC+++31IEnQQan2uADmYxEUQgCBbJUNS3BOh46i/pYD7/mUQLjFVzqvOe/bDDy1ayMdmDRRnxe+eahdyJnfKz4entA9CNX8lkLlSxu7kS5UJBRNcDK5pCiRI/fz0ozv0Z6VlsUx5IpKBNrMcycvfZfXQ2qwPSaTenSdkGeBluZj0FCYSZabKDJLRVhxbNMMSxxx/1btlNrZmEvqUC+OEBmDD3b0Yyz0F9oNhKNeaAE7ZEc0I+SDFMCSeR5ieREhkCgUp46EJCh4wSVw1qqOcxBzrATzoAkypiTTecvgXAH8LO+w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR02MB6635.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(508600001)(86362001)(64756008)(122000001)(55236004)(66446008)(66476007)(38100700002)(53546011)(6506007)(66946007)(66556008)(4326008)(76116006)(71200400001)(26005)(186003)(5660300002)(316002)(6636002)(2906002)(54906003)(7696005)(83380400001)(52536014)(38070700005)(33656002)(8676002)(8936002)(9686003)(110136005)(55016002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NXJuQlJ3OXRkWEdtekwybHRnQkIxYVhNQnVFcjdwV1c1MGlaOVJobzcyNytL?=
 =?utf-8?B?dThwWENiTkQyclpvZWIxcWE0V1Z1TXMzejVvaE42QTBWeXNDRmJGdTNaVW1Y?=
 =?utf-8?B?MndlSUlMNFk3RkdFZUwzbXZqZkdHQXFnOWF4LytEVWJRZ3ZPV0d1ZURwb2N3?=
 =?utf-8?B?V3ZRemExZ2k5UWJJVmhxVklva1lkNWdqMEFyUVhoc2thMlYrVVVwbEd0LzND?=
 =?utf-8?B?VGNEeHJLRlU1bDNLWTg2YW5lbGw4bVMyblFOdXVNdmt1WDE0MEQyZ01VRlp0?=
 =?utf-8?B?ZElObkVtQlNjc1VFWk5IcDZqSjBCZERHcndxU1RiOEVLQzNaNzFGU3BlcThY?=
 =?utf-8?B?VUYvM2l6eU5QWWxXTi9NRWJQQlppVldOKzhTL0Z5RWtMTkZyUThXMjJqV2FQ?=
 =?utf-8?B?OUNkWk9CV0ZIR1hJcHdIRDBRdzVHRmtiTzN3UThYdjRWZVMxU0x0OUZhcFE3?=
 =?utf-8?B?SHZUYWp0QUJ1bGcycHRMOEhWcURMbGM5M1dxdGtuZXFEVW85RlRMamlzNWR6?=
 =?utf-8?B?L0h0SmVDa2sxemEwckd0UUp4VStMQ0ljY1VaZ2ZtclZTaVVxeSs4cVl2SDdn?=
 =?utf-8?B?NnFJaXNPYm0zMEdaTlU3RnQwQUpmbVhZSktyRGRobW5xUmNkaHJXVmxGOWRp?=
 =?utf-8?B?cy9TNStsNHBPNkNxeWJVeFYwY2xZM3RXeHhwWllsSk9MeDkwY3gvV3pCVVp5?=
 =?utf-8?B?UHpWaEh4d1hxVEo2MWFCRHNhRHBBdEk0WjVEb2JleHd4K25yZ2paZ2Y3TFds?=
 =?utf-8?B?Z1JJU29DaUkzdlI1cXpCaU5BdndTQllqUzhld1A4bkVWQjJKSGpUMlpaR3JW?=
 =?utf-8?B?WDZBS2t1QjFibFRnNjNkblc2NGZ5WFA4STMrdHQ1OG56a1pNUGZLZUM3OXVi?=
 =?utf-8?B?aDNyY1JGa2U2MVJzL3N3Z2d2bEhtZGtkcUpoMDY0Sm1QcDhoS1E5RUQyR3dh?=
 =?utf-8?B?WUJURlYwN2MrbTdCS0luOTNXd0hmWStzeVk1ZjhUVjZIWFQ5N2E5UDBENlRj?=
 =?utf-8?B?YnlERnNzNUp0ck1HN091V1B0UEhWSnZuRjgxdlp3UWhRRlBDS0hBcXlyK21U?=
 =?utf-8?B?VzFQVGV2UlVBS25rSVpldVlSRWxjR2JmNWxkanIwT054SG1VQ3RkeGpFdng2?=
 =?utf-8?B?RXdOVHcrd1p2UVpRREh5ZEN5dG4zMUI4dTdBREY3eCtSNXlCYzF5SUpzbXNx?=
 =?utf-8?B?dmpOd01kVFVMcWFHTTZIVlRnVDdRSnU2dzRubVZLR1lsM242M0s4MkFlMk11?=
 =?utf-8?B?ckY5dm5DVloxbDBnMkZyNW1sSzZWUjc4VGplL0xmRXlsZC9ZQVN1UUNnUTFw?=
 =?utf-8?B?ajdJSzNlekQwaHl4RUFncERaL0YxTGVLZDZ3TEtpYlhySzZwaGhRMllWcWp0?=
 =?utf-8?B?bkdGSHZ5UUtqekk4Q1BqS0k4VHBteThGcFIxZGcxUWhtaEVNZlRzSUxLdlBh?=
 =?utf-8?B?VEVDaENnKzlDOHE2cStiMWY2K1h3VDFNU3lsRk5CRXMrWmtYZFhkVTJpajBk?=
 =?utf-8?B?dXZBQTZOUlpBVXRrQVE2WDlVbVMwdmh4QXU5SkM4VzhMTkRFbFFFdmtjVkRF?=
 =?utf-8?B?M3BsODVEMWFkelJQU25lekhiQVJZMDk2cURpTW9NKy9hY2dvR0I3dkliZmlH?=
 =?utf-8?B?OWRmK1hDNlh3elVBVjdUMzQ1NnF4MjU3MU5UZENKcVFpc3J2NGlWZ1Y4Z29z?=
 =?utf-8?B?RmtqamtYVnVRSmtQWUZjSllVU0VPdi9FT05YQU9xN2dvVXk5NmVZdHRpTFpT?=
 =?utf-8?B?YTd1VEtnTXN2WjR2MHFweDhvRkNqWFdjS0FmOVFvQk5qRHRsWnNrZUpERm1i?=
 =?utf-8?B?azRVWThLNVlOMTNtT2U1WEltNUsxbVZGL0RicmpiZzJwNS83V2wxbHJpSmt3?=
 =?utf-8?B?alAyakdlUEhuOTZnU09RdFR1MnkrT3FCSTVuZlpuRWhBRjM1ZkU0c2xXdzZK?=
 =?utf-8?B?L0ZHd1F1K3hMOXBEVHZoQWRCV1FMN095V1lYUGQ5a3VZN0ZPZ2o0QzdYb0dG?=
 =?utf-8?B?UHRwZEM0NGRiNm5Qa3lSTWc2d2hvay9WRlU4cE52YlcyODhrOG5KK3NEbUg2?=
 =?utf-8?B?SG55MXhPTmFPS0tMM0M5VFNQU2hUS290STR0a1pzZ2NNUmV5SVI1WnMrcTVZ?=
 =?utf-8?B?dDhqeEhMWXNFU2FkWGNqTXlUVnF2OGxQOC80c09xY2k0WHRYOTBVZTQxWitF?=
 =?utf-8?B?S2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR02MB6635.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b1e60f1-4620-4833-779f-08d9a0484701
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2021 10:37:33.7271
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9gjuQaiDDytK380vajeVUC+aSnx4ADwu7/UXpDsHUvjXZaoIviYSU5cB6hfgcih+P1P36BcHwRX8CK1ojt0JIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR02MB3831
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWljaGFsIFNpbWVrIDxt
aWNoYWwuc2ltZWtAeGlsaW54LmNvbT4NCj4gU2VudDogTW9uZGF5LCBOb3ZlbWJlciAxLCAyMDIx
IDU6NTggUE0NCj4gVG86IEFuc3NpIEhhbm51bGEgPGFuc3NpLmhhbm51bGFAYml0d2lzZS5maT47
IE1pY2hhbCBTaW1law0KPiA8bWljaGFsc0B4aWxpbnguY29tPjsgU2h1YmhyYWp5b3RpIERhdHRh
IDxzaHViaHJhakB4aWxpbnguY29tPg0KPiBDYzogbGludXgtc2VyaWFsQHZnZXIua2VybmVsLm9y
ZzsgR3JlZyBLcm9haC1IYXJ0bWFuDQo+IDxncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZz47IGxp
bnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgtDQo+IGtlcm5lbEB2Z2Vy
Lmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSF0gc2VyaWFsOiB4aWxpbnhfdWFydHBz
OiBGaXggcmFjZSBjb25kaXRpb24gY2F1c2luZyBzdHVjayBUWA0KPiANCj4gDQo+IA0KPiBPbiAx
MC8yNi8yMSAxMjoyNywgQW5zc2kgSGFubnVsYSB3cm90ZToNCj4gPiB4aWxpbnhfdWFydHBzIC5z
dGFydF90eCgpIGNsZWFycyBUWEVNUFRZIHdoZW4gZW5hYmxpbmcgVFhFTVBUWSB0bw0KPiA+IGF2
b2lkIGFueSBwcmV2aW91cyBUWEVWRU5UIGV2ZW50IGFzc2VydGluZyB0aGUgVUFSVCBpbnRlcnJ1
cHQuIFRoaXMNCj4gPiBjbGVhciBvcGVyYXRpb24gaXMgZG9uZSBpbW1lZGlhdGVseSBhZnRlciBm
aWxsaW5nIHRoZSBUWCBGSUZPLg0KPiA+DQo+ID4gSG93ZXZlciwgaWYgdGhlIGJ5dGVzIGluc2Vy
dGVkIGJ5IGNkbnNfdWFydF9oYW5kbGVfdHgoKSBhcmUgY29uc3VtZWQNCj4gPiBieSB0aGUgVUFS
VCBiZWZvcmUgdGhlIFRYRU1QVFkgaXMgY2xlYXJlZCwgdGhlIGNsZWFyIG9wZXJhdGlvbiBlYXRz
DQo+ID4gdGhlIG5ldyBUWEVNUFRZIGV2ZW50IGFzIHdlbGwsIGNhdXNpbmcgY2Ruc191YXJ0X2lz
cigpIHRvIG5ldmVyDQo+ID4gcmVjZWl2ZSB0aGUgVFhFTVBUWSBldmVudC4gSWYgdGhlcmUgYXJl
IGJ5dGVzIHN0aWxsIHF1ZXVlZCBpbiBjaXJjYnVmLA0KPiA+IFRYIHdpbGwgZ2V0IHN0dWNrIGFz
IHRoZXkgd2lsbCBuZXZlciBnZXQgdHJhbnNmZXJyZWQgdG8gRklGTyAodW5sZXNzDQo+ID4gbmV3
IGJ5dGVzIGFyZSBxdWV1ZWQgdG8gY2lyY2J1ZiBpbiB3aGljaCBjYXNlIC5zdGFydF90eCgpIGlz
IGNhbGxlZCBhZ2FpbikuDQo+ID4NCj4gPiBXaGlsZSB0aGUgcmFjeSBtaXNzZWQgVFhFTVBUWSBv
Y2N1cnMgZmFpcmx5IG9mdGVuIHdpdGggc2hvcnQgZGF0YQ0KPiA+IHNlcXVlbmNlcyAoZS5nLiB3
cml0ZSAxIGJ5dGUpLCBpbiB0aG9zZSBjYXNlcyBjaXJjYnVmIGlzIHVzdWFsbHkgZW1wdHkNCj4g
PiBzbyBubyBhY3Rpb24gb24gVFhFTVBUWSB3b3VsZCBoYXZlIGJlZW4gbmVlZGVkIGFueXdheS4g
T24gdGhlIG90aGVyDQo+ID4gaGFuZCwgbG9uZ2VyIGRhdGEgc2VxdWVuY2VzIG1ha2UgdGhlIHJh
Y2UgbXVjaCBtb3JlIHVubGlrZWx5IGFzIFVBUlQNCj4gPiB0YWtlcyBsb25nZXIgdG8gY29uc3Vt
ZSB0aGUgVFggRklGTy4gVGhlcmVmb3JlIGl0IGlzIHJhcmUgZm9yIHRoaXMNCj4gPiByYWNlIHRv
IGNhdXNlIHZpc2libGUgaXNzdWVzIGluIGdlbmVyYWwuDQo+ID4NCj4gPiBGaXggdGhlIHJhY2Ug
YnkgY2xlYXJpbmcgdGhlIFRYRU1QVFkgYml0IGluIElTUiAqYmVmb3JlKiBmaWxsaW5nIHRoZQ0K
PiA+IEZJRk8uDQo+ID4NCj4gPiBUaGUgVFhFTVBUWSBiaXQgaW4gSVNSIHdpbGwgb25seSBnZXQg
YXNzZXJ0ZWQgYXQgdGhlIGV4YWN0IG1vbWVudCB0aGUNCj4gPiBUWCBGSUZPICpiZWNvbWVzKiBl
bXB0eSwgc28gY2xlYXJpbmcgdGhlIGJpdCBiZWZvcmUgZmlsbGluZyBGSUZPIGRvZXMNCj4gPiBu
b3QgY2F1c2UgYW4gZXh0cmEgaW1tZWRpYXRlIGFzc2VydGlvbiBldmVuIGlmIHRoZSBGSUZPIGlz
IGluaXRpYWxseQ0KPiA+IGVtcHR5Lg0KPiA+DQo+ID4gVGhpcyBpcyBoYXJkIHRvIHJlcHJvZHVj
ZSBkaXJlY3RseSBvbiBhIG5vcm1hbCBzeXN0ZW0sIGJ1dCBpbnNlcnRpbmcNCj4gPiBlLmcuIHVk
ZWxheSgyMDApIGFmdGVyIGNkbnNfdWFydF9oYW5kbGVfdHgocG9ydCksIHNldHRpbmcgNDAwMDAw
MA0KPiA+IGJhdWQsIGFuZCB0aGVuIHJ1bm5pbmcgImRkIGlmPS9kZXYvemVybyBicz0xMjggb2Y9
L2Rldi90dHlQUzAgY291bnQ9NTAiDQo+ID4gcmVsaWFibHkgcmVwcm9kdWNlcyB0aGUgaXNzdWUg
b24gbXkgWnlucU1QIHRlc3Qgc3lzdGVtIHVubGVzcyB0aGlzIGZpeA0KPiA+IGlzIGFwcGxpZWQu
DQo+ID4NCj4gPiBGaXhlczogODViYWY1NDJkNTRlICgidHR5OiB4dWFydHBzOiBzdXBwb3J0IDY0
IGJ5dGUgRklGTyBzaXplIikNCj4gPiBTaWduZWQtb2ZmLWJ5OiBBbnNzaSBIYW5udWxhIDxhbnNz
aS5oYW5udWxhQGJpdHdpc2UuZmk+DQo+ID4gLS0tDQo+ID4gICBkcml2ZXJzL3R0eS9zZXJpYWwv
eGlsaW54X3VhcnRwcy5jIHwgMyArKy0NCj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlv
bnMoKyksIDEgZGVsZXRpb24oLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3R0eS9z
ZXJpYWwveGlsaW54X3VhcnRwcy5jDQo+ID4gYi9kcml2ZXJzL3R0eS9zZXJpYWwveGlsaW54X3Vh
cnRwcy5jDQo+ID4gaW5kZXggOTYyZTUyMmNjYzQ1Li5kNWUyNDM5MDhkOWYgMTAwNjQ0DQo+ID4g
LS0tIGEvZHJpdmVycy90dHkvc2VyaWFsL3hpbGlueF91YXJ0cHMuYw0KPiA+ICsrKyBiL2RyaXZl
cnMvdHR5L3NlcmlhbC94aWxpbnhfdWFydHBzLmMNCj4gPiBAQCAtNjAxLDkgKzYwMSwxMCBAQCBz
dGF0aWMgdm9pZCBjZG5zX3VhcnRfc3RhcnRfdHgoc3RydWN0IHVhcnRfcG9ydA0KPiAqcG9ydCkN
Cj4gPiAgIAlpZiAodWFydF9jaXJjX2VtcHR5KCZwb3J0LT5zdGF0ZS0+eG1pdCkpDQo+ID4gICAJ
CXJldHVybjsNCj4gPg0KPiA+ICsJd3JpdGVsKENETlNfVUFSVF9JWFJfVFhFTVBUWSwgcG9ydC0+
bWVtYmFzZSArIENETlNfVUFSVF9JU1IpOw0KPiA+ICsNCj4gPiAgIAljZG5zX3VhcnRfaGFuZGxl
X3R4KHBvcnQpOw0KPiA+DQo+ID4gLQl3cml0ZWwoQ0ROU19VQVJUX0lYUl9UWEVNUFRZLCBwb3J0
LT5tZW1iYXNlICsgQ0ROU19VQVJUX0lTUik7DQo+ID4gICAJLyogRW5hYmxlIHRoZSBUWCBFbXB0
eSBpbnRlcnJ1cHQgKi8NCj4gPiAgIAl3cml0ZWwoQ0ROU19VQVJUX0lYUl9UWEVNUFRZLCBwb3J0
LT5tZW1iYXNlICsgQ0ROU19VQVJUX0lFUik7DQo+ID4gICB9DQo+ID4NCj4gDQpSZXZpZXdlZC1i
eTogU2h1YmhyYWp5b3RpIERhdHRhIDxTaHViaHJhanlvdGkuZGF0dGFAeGlsaW54LmNvbT4NCg==
