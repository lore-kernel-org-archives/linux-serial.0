Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29AA2C48BDF
	for <linux-serial@archiver.kernel.org>; Tue, 15 Jun 2021 14:34:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A89261452
	for <linux-serial@archiver.kernel.org>; Tue, 15 Jun 2021 14:34:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231303AbhFOOgF (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 15 Jun 2021 10:36:05 -0400
Received: from mail-eopbgr1320047.outbound.protection.outlook.com ([40.107.132.47]:61305
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230321AbhFOOgE (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 15 Jun 2021 10:36:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bQcRnpxvRqUGtt7ez2E1Gad2znpAWqDA5ryt1F2wkv/wYRkQLXBs3sCRUlZ0wyP3uDczx0Hlklkex35JfhlQrfgRdI/DiDcn3To24S70kG9tVrAHLsgsXUDWQTYgxEOa3OqwYHOyIoM4whg80zlHiq46CiIdOy4hUepccwA5+vYfWXStNfnjHaR5+y4T8Uo536ytSNLt/7Dxe2LJVW17T2mptFKr5eZDBVJ2tltfCxWY5vM0dFwP7/8FRMOjLzTKKr0yPRisZ/IVGDoVPjmO4QGU0ZX/qvn51OjJe2HCpTSRUcHWrPkw+A1L5M36/zI43+GMQoCSKXv4VYsQJEdojA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ViLqjYKV/DkeJSRnZuZ6EXoZDVUbqQLdxiYM6EHDTxg=;
 b=mFYI6orOij/W6Xm8d4imDuSV3i5g+JAiaPpphbGv/ne4tWWAe5gD8fN8ugNMcoXLLLFQN1+8507GzCheeIx8zeKbYbpGcM0cUrhwp8hjI/Pgl7rozRwpADAE+QtFbJqbChkBlxCgEg1t+1AOBfXFtS7fXK8lglGhgI8e+3NaU1YOP1B/CTP8iRZfovMyrsdqSNsZp3Xc9W7Pk0bEBOJoxzKWUFqMtkaZlKbulOSOFV97gDq/VTra6J0MHRG1k0gO20g1TCNklTVPID0L+eeR+xeOB24g+vFGMYgWFmw1gNyQC43TGI2ctS8trANvebaUQgRaEKD8sRDMD6Rn0b7OMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cortina-access.com; dmarc=pass action=none
 header.from=cortina-access.com; dkim=pass header.d=cortina-access.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CortinaAccess.onmicrosoft.com; s=selector2-CortinaAccess-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ViLqjYKV/DkeJSRnZuZ6EXoZDVUbqQLdxiYM6EHDTxg=;
 b=Nfw23PEwHwVV6lsYyT5prooZAsriAVNQ/ZXpQ+tEH4fPQLK1fxFlXm/eaLoVtbJtYu+QpD/MrP3/l+HRjEIUNMWCBI3h6LmtzQ6hE2/P6VUIncCFVrQoubbZFjuOaskx66yGspSEBVAFGliUUqK9Mtbc+KBJviFY8FPGnkXoKvM=
Received: from PS2PR01MB2504.apcprd01.prod.exchangelabs.com
 (2603:1096:300:3e::11) by PSAPR01MB3925.apcprd01.prod.exchangelabs.com
 (2603:1096:301:42::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24; Tue, 15 Jun
 2021 14:33:57 +0000
Received: from PS2PR01MB2504.apcprd01.prod.exchangelabs.com
 ([fe80::e9b5:6b16:ec29:6101]) by PS2PR01MB2504.apcprd01.prod.exchangelabs.com
 ([fe80::e9b5:6b16:ec29:6101%2]) with mapi id 15.20.4195.032; Tue, 15 Jun 2021
 14:33:57 +0000
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
Thread-Index: AQHXRQOE/WvPoJrMTEyo68j2OIxsw6sVL9QAgAAcBACAAAttAIAABaUA
Date:   Tue, 15 Jun 2021 14:33:57 +0000
Message-ID: <49AAFE67-C151-4A7D-AE6D-E8981CBC9503@cortina-access.com>
References: <20210509184519.15816-1-alex.nemirovsky@cortina-access.com>
 <YMiUgpRbfwMHCqD+@kroah.com>
 <DA86E839-4208-4535-B70C-ACFC94438BEB@cortina-access.com>
 <YMi1mIwOTLYs8h8/@kroah.com>
In-Reply-To: <YMi1mIwOTLYs8h8/@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=cortina-access.com;
x-originating-ip: [70.58.207.205]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fb92df40-3a24-4d4a-c87f-08d9300a9c41
x-ms-traffictypediagnostic: PSAPR01MB3925:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PSAPR01MB392596DCBDB9E587AB51E44DCB309@PSAPR01MB3925.apcprd01.prod.exchangelabs.com>
x-ld-processed: 0694623c-6669-497c-89c3-3a32a9934313,ExtAddr
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KcTPdPGvhLx8NsgafBcjvQ9j+zz5qZbMys286PTClsbkqAbOFeAQeUASpmGYNdTbG8TVMMiE+zK7dOpJ38P45BDGZGIbpQ4X5VfZ69QlxJtb8Plo6jpnDXqCnYRtPsBwzVXllDcxTnbbwDJCap/qbFN81YpW9oVsiS3JcjQH0V386b3JNBirAmf9EnWN/wRYDzvb4IPUKRyItmlyUwezIM7+H+NSWsTlhfJHHMhoQzBi6E4xUhCxoHCL1YzhOoBljwnnHX2zzzDQNZuMmp+tzRV2yy0xeVlz6tn1I1wcp015yvBe6Ec6jxnJofX9W8/LgaZOzP74Gs8HYZNE5ZveRl+VmLEMyj9vas6bmUGO7IVtkOjPBi7HqVK/OfOVQot10K91lCmVAa5Rd/hJ+K76YTc8BbfFLeWF30RY+TjmXQPNkQAG1HLFRiUJskE02LRymN9P9kemrHOBnSm/mvrDtMGxNTNq4ODp3QKvzzz2WhfVKmkEZqwSZ1ky927CP1w9/x5mFEWQYtXPTrhEFNaPUtwiEhREWmi+yprZ/b/uRQLiAIySLXN/nCN8CovneKUiSQb3Ato4GTmE4KIz93EH6MpavK2ymD2ZaGAs+1uY7+k=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PS2PR01MB2504.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66946007)(4326008)(66476007)(498600001)(122000001)(66556008)(2906002)(66446008)(91956017)(76116006)(38100700002)(6916009)(64756008)(53546011)(186003)(5660300002)(6506007)(26005)(54906003)(33656002)(36756003)(2616005)(8676002)(8936002)(4744005)(6512007)(6486002)(71200400001)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eEt1TUdVZkRSQmhSaFB6cVQzNEdDY3VHb2NFNnZFQXdVVGdPdHBLVFBXcFpC?=
 =?utf-8?B?R3ZBVkR1aFRjR1EvZWRYZWNnNlpHU3RvN3YwckxIZGNRK2tSd216Rmp1QVI0?=
 =?utf-8?B?MmNoR0VCdjhpbERjMzJGdEZHaTV3OW5USHdYbXl5dElSR3hFeGRaVXNVQmFN?=
 =?utf-8?B?TnV4dkRDN2JqeFpwTTV5ckFSSU1GbUYybXJtOTZpL0NCN3pweTlsbWo4bSsv?=
 =?utf-8?B?SjdBVG1nQUg2NnNOdW9RUUhCL0QxL2IvMXUwTGhsTGRpYVYwbFpYNEVTT2l4?=
 =?utf-8?B?SUZsZHVQMkZnU3FUZUpuT0k4Vlg4eFNEczBlVjNqSGJYakNCSUlpcXZLcXhN?=
 =?utf-8?B?YnI2QkpXTnlDTzZ5ZDJiZm5Rb2RuZjI1NGlJVDVwaXVGYTFqRjQwV0pORlo5?=
 =?utf-8?B?c0ZRVzc3QmY2SWVuQW9JSFhONElpMlBFOUFtcVJxVDhTNmphQWxEZmFpRnFB?=
 =?utf-8?B?Mk4rQ2ljM1NxamRnRXNwQzEyT0p1dG5laDVMeUpVOSs2NzRFeFZSemloNkJG?=
 =?utf-8?B?L3paa2RLSTkrMmF5WWR4ZXNWODRYL0E5bk1uR1BPdXJSMnRmZXdLSStDUFZK?=
 =?utf-8?B?SnFQc0VmOFdKWnk1aUpuZkJEWVlWSmgyMkxuOW5vVXBHZ0sxQ0s0RTJoNjBt?=
 =?utf-8?B?bnFteUVXekw5SjJJWEZyVEF4QkF3d05EenR4Sjh3S005RWkwZGQ0c01WaTBL?=
 =?utf-8?B?WWxSY3dYQ0ZwcjBrM21HV3ZRU0tkMEhGSk5qZ1JrOU9BaTlKcUltR1U0elU0?=
 =?utf-8?B?TFdzNlZlemFkMGxsT1FCelBJSjJVNkw5b05WVFI5S01wc0RsNVRlVVIrdEkv?=
 =?utf-8?B?cVFobi9DZDEyWjRmOGs2SnhhZHgvOVlXMVZ0OW84dWNuTkFpZkR6Nnc0UTk2?=
 =?utf-8?B?R2NZVjZxSHVQZFJNSkxBZUliREc4eEpmZnlySXBvUE4vZ085RXVQazc1WDNE?=
 =?utf-8?B?eVlVNFpNNVFxYml1eHJiTlF5NjBrUHZ1eU1US1ZBNGc2MUsrSGtpUjRaa2Z1?=
 =?utf-8?B?V3BGU2VEMXd0ZzJ0RXh4N2lEZ0xuR0xLK3VmUHFaUExwV2QxOHNVb0JMNGYr?=
 =?utf-8?B?ZS9ZdnVydkZWWlJWUkIwaHo1enZyTFRndlFLdzNPR2JLLzJUc1hhSnN5R1hY?=
 =?utf-8?B?VUxDUzlmS0F2NnBOWUlBWDBKdmhQSHpEbmhNNUZUek1yWVE5RjZzdzBNV1d3?=
 =?utf-8?B?SkxnY3BZdWRLdDJ2SVlnQ1dMTEs3ZDVqdXpQb0tsQldiUmRSa3RMeVhqVWdC?=
 =?utf-8?B?SHNReUt5cnBWaFA0bTJBUXRxL0E0WVQxTnhxMW9GcWxVYllkblRIRGcwUWpt?=
 =?utf-8?B?V3o3bStSRzQ5SWJlZHVqNG9aMEdPbkF3L1JJZmRFYkxtYUxVOTdJUzZHL0Z4?=
 =?utf-8?B?bkdMK3ZxTmxVSmJveEg5OTVnMTJWYlg1c2pDN2svc1UrdENydEp6cjdvMlhz?=
 =?utf-8?B?SnpLR1V2Zi85aXNDUE9PcXo3Z1lmRXRGS1BLeTJPT04wYisyVm1XRGpGTnox?=
 =?utf-8?B?cThGR2ppRzVTdTVNOGloMmkwTCtHYWtidVg5UTc4cnBVSEFtQ0JUbVBxZDVq?=
 =?utf-8?B?U0hZZHR1b3Q5SGlFYkxmaDVmNkNmQnZ3WHRJZy92QTVKMEdDTEZYNWVydUpB?=
 =?utf-8?B?RGlLSTlrQWI1YVBWM2x1VExlcW1HQm9FREFSd2VURjFXYVhPK1N6L1VZdm5P?=
 =?utf-8?B?R2Y1SEpkWHN5Z0tqUDRETGxrTVdkUnl4RkFNRGZVUjg4ZUxnWlA2T0piWW5o?=
 =?utf-8?Q?pqQebVaAlL7VSGZk1IXTluf+PJQ/LRTUB0AeD8d?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <995A5E23001A0D4C9119A8995059BA10@apcprd01.prod.exchangelabs.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: CORTINA-ACCESS.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PS2PR01MB2504.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb92df40-3a24-4d4a-c87f-08d9300a9c41
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2021 14:33:57.8029
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0694623c-6669-497c-89c3-3a32a9934313
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H4oyeUZUEnRmHO8OLkmiM8vfM4wLYlrUKdn3nSwBQGIizyxTb1yw+3VECE6XYT1GKISyakAg9EcbFMStvqRG6HY9osIK/dBPbU+jHptRdp5ABC2W1az4sgcwst0joXch
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR01MB3925
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

RG9lcyB0aGUgc2VyaWFsIGRyaXZlciBwb3J0aW9uIGluIHRoZSBmaXJzdCBwYXRjaCwgcmVxdWly
ZSBhbnkgbW9yZSBjaGFuZ2VzIGZyb20geW91ciBwb2ludCBvZiB2aWV3DQphcyB0aGUgc2VyaWFs
IGRyaXZlciBtYWludGFpbmVyPyAgSWYgdGhlcmUgYXJlIG5vIGlzc3VlcyB3aXRoIHRoZSBkcml2
ZXIgaXRzZWxmLCB3ZSBjYW4gZW5nYWdlIHdpdGggdGhlIERUIHRlYW0gdG8gZmlndXJlIG91dCB3
aHkgdGhleSBoYXZlIG5vdCANCkFDSyBvciBwcm92aWRlZCBhbnkgZmVlZGJhY2sgb24gdGhlIERU
IHBvcnRpb24uICAgQXJlIHlvdSBnb29kIHdpdGggdGhlIGNvbnRlbnQgb2YgdGhlIHNlcmlhbCBk
cml2ZXIgaXRzZWxmIG1pbnVzIHRoZSBsYWNrIG9mIEFDSyBmcm9tIHRoZSBEVCB0ZWFtPw0KDQo+
IE9uIEp1biAxNSwgMjAyMSwgYXQgNzoxMyBBTSwgR3JlZyBLcm9haC1IYXJ0bWFuIDxncmVna2hA
bGludXhmb3VuZGF0aW9uLm9yZz4gd3JvdGU6DQo+IA0KPiBPbiBUdWUsIEp1biAxNSwgMjAyMSBh
dCAwMTozMjo1MVBNICswMDAwLCBBbGV4IE5lbWlyb3Zza3kgd3JvdGU6DQo+PiBUaGUgRFQgbWFp
bnRhaW5lcnMgd2VyZSBDQ+KAmWVkIGZvciB0aGUgRFQgcmVsYXRlZCBmaWxlcy4gIEhvd2V2ZXIs
IEkgc3VzcGVjdCB0aGV5IHdvbuKAmXQgDQo+PiBBQ0sgaXQgdW50aWwgeW91IEFDSyB0aGUgYWN0
dWFsIHNlcmlhbCBwb3J0IGRyaXZlci4NCj4gDQo+IEl0IGdvZXMgdGhlIG90aGVyIHdheSBhcm91
bmQgOikNCg0K
