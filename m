Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D030EE6FE38
	for <linux-serial@archiver.kernel.org>; Fri, 22 Sep 2023 14:20:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234204AbjIVOUf (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 22 Sep 2023 10:20:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234186AbjIVOUe (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 22 Sep 2023 10:20:34 -0400
Received: from DM4PR02CU002.outbound.protection.outlook.com (mail-centralusazon11013012.outbound.protection.outlook.com [52.101.64.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48BD2AB
        for <linux-serial@vger.kernel.org>; Fri, 22 Sep 2023 07:20:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I6xZ0O+DApOGmQqX7LP2WV6KnSEAqnXh7IE23K1/UNW3N3KrgQbYdHwLuBBEaktn2HmoTZUGUHNl5wTGMqb+II/KHdGpdDQ/QL9Y21nS6up172NoOb2SyUT4rD+TxriOeCZjxVO7c3Dsq+dHTplPeWCiWjzexU/zKnSHk66QkTQgyv0CXpK4CA7MjjuWBR5cJ/fBMPMleNbFIg0aV1kKso6IY6l+NHdx6wYoxeo6iQObBTpdDl455QKVj+ydOWnGbWupJym4skqru51Njr91bS+XAntEvW5xugEqNuy0w5k/fDUpaf4RZVgfl4GptWtO5bwy87MIXhgykFuTb3G47w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hojaf7ce4SPrEbqpoOjQQQwLpo6IgEWi/w596gXtFgM=;
 b=i8yaH7cggBAZfSz3z1S2ADYUT5rtEiKciNaGAw5Zb/+/hrlCbSTAxEnQF5okzlF8RlHuxkHP6uCzogYb3DWgobbz9b1lLJUEgfgl/xJ/UkPsIkE6Kr3EKEGmeVma5gcLh26+gGx0EEsoHeZbuQdUCQiwtchbdVoVxEEE2kI1OqlLDGtPwJEZ0c/sSTI9aN+GSgHpYBHG+xdgcJPUgoJ0Zz7wz/4UzUPK+QpIm9jjv0Hvpq4u2YTT0NRbcNSEGvStBUueMfnSkJpArPdinjIlvL9sxQR3bFC6hziGu+E1VcWmb/sjk5d1wA4V1cetqi34Tg/K42IBvkMjXOLkZGKvGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sealevel.com; dmarc=pass action=none header.from=sealevel.com;
 dkim=pass header.d=sealevel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sealevel.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hojaf7ce4SPrEbqpoOjQQQwLpo6IgEWi/w596gXtFgM=;
 b=WStTtqg/x+5jFZENpFaX7rRnBsHkijlv38YaGLV4CuDrVLWH2uOS+H4exVjaNGIkfcZe6WW/sErccInPZSnSUI0r1OZ45TSS2k6icV8Hr/bM/CJSDOWId+N2vVEUDjBRA3Wm3O1eA5fJzfegyV16y2lEvaBdEdgw76Llb/PO8nzFThre1ZNTSFdRMpfE25uwhirkweqcPVhBJZ76lSbYH/wRygfgoXeKOKuYcvY8ndjORXG9Nj9dqXeC5dKFZZm2pM/I+EvbnAlstk90X6OI6ucwNXAGmgJQaC8JFxg6Jau1A1xr8XGh1T/QbRafaJ3v/sncNcfPdX/0y907m7acJw==
Received: from BY3PR05MB8419.namprd05.prod.outlook.com (2603:10b6:a03:3c6::10)
 by CO6PR05MB7713.namprd05.prod.outlook.com (2603:10b6:5:34a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Fri, 22 Sep
 2023 14:20:24 +0000
Received: from BY3PR05MB8419.namprd05.prod.outlook.com
 ([fe80::f4e4:1bc5:23f6:c9d4]) by BY3PR05MB8419.namprd05.prod.outlook.com
 ([fe80::f4e4:1bc5:23f6:c9d4%3]) with mapi id 15.20.6813.017; Fri, 22 Sep 2023
 14:20:23 +0000
From:   Matthew Howell <matthew.howell@sealevel.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     Darren Beeson <darren.beeson@sealevel.com>,
        "andriy.shevchenko@intel.com" <andriy.shevchenko@intel.com>,
        "ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>,
        Jeff Baldwin <jeff.baldwin@sealevel.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        Ryan Wenglarz <ryan.wenglarz@sealevel.com>,
        Matthew Howell <matthew.howell@sealevel.com>,
        James Olson <james.olson@sealevel.com>
Subject: [PATCH V8 1/2] serial: exar: Revert "serial: exar: Add support for
 Sealevel 7xxxC serial cards"
Thread-Topic: [PATCH V8 1/2] serial: exar: Revert "serial: exar: Add support
 for Sealevel 7xxxC serial cards"
Thread-Index: AQHZ7V/tlJUc5zv3CE6HU1a3mrR9mg==
Date:   Fri, 22 Sep 2023 14:20:23 +0000
Message-ID: <7f7016dbad5eb0770bf4653dcc87ae0f8963bf44.camel@sealevel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sealevel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR05MB8419:EE_|CO6PR05MB7713:EE_
x-ms-office365-filtering-correlation-id: 50945d31-a25c-4777-1781-08dbbb770f83
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vwX8BVyrW/6OOnDq6TYhwUQG4kq2NI+wGzLn+JvKvcfJJIneCCPaAEACIUqGxxxna/gKmlCTM/i1BnbkdBAl4yQEI9+q0P88n0sbasCpYhM4IF+pSsXZ3Z2gYpTuouQ8DwkKZAG7sBRi5eR4eU/SlTvAz4ap9nfIBTtgoNxgLVZxuPyQjVL1e2oj2dd1Mjd312AtbPPvJSjlJHf8bDT2wB31q3J6WLa+pSaX0YAhagFzcyy7USWsvKmlTVEwvDqt+ZPm5kPpjsgp/QsDIe1l4KlUnhx4KfpQq/3Srwv5ol4q6Tt8VGvq5nimyKQNAt/+m51QpAWBl6hE5f3aDAQErNWacp3v8kCuSSFsxM2rQ8BZZHA0cqm4cw4b10cu1oJBQQQ0jmq/xWVOHxkcKpdJka5fMUqxWbcO5JnjwalsMP7VLHXzUCGvJH6XM5q7XgmBu4SYq4rVcMjDDdkvPNYp69J9FURAaGcb6GFSHWqaCf5Pc05aCjalt9rOEC7pgqYrTTRre9/8wXDanXcbSUzJdxzcD9EkmUabRNhjezIKBeQOlYTvUnDs8bUdA1CwVuxOH8jhU4wk27t/kjw+zBpZV8fYQJ03cIYqchgJHVlOA3v79jQmEy/wpx32RbaTa9ir5V4MIL6TLWe3w1J8PeM9MzLvdwyaG/7f9C5nfL6Wk1U=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR05MB8419.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(39840400004)(136003)(376002)(346002)(186009)(1800799009)(451199024)(76116006)(66946007)(86362001)(6916009)(6486002)(66476007)(71200400001)(54906003)(26005)(91956017)(66446008)(316002)(2616005)(8676002)(66556008)(2906002)(8936002)(6512007)(4326008)(44832011)(41300700001)(38070700005)(5660300002)(38100700002)(122000001)(6506007)(36756003)(478600001)(64756008)(107886003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WVJGV3czWGJ1ZklNZ3VMT09WWiszWUVGaERQNmlKaGlyYzkzbk12UVdOVGFP?=
 =?utf-8?B?MTFXU1FjbmovNmJtcSsxZzE0YkxWQUtzcXJjQjNVTXl0aTBLSGV0RDZkMW1Y?=
 =?utf-8?B?bGh4MXpzRmxVejl0dkZrMTFIaFdMMFdjSlg2RnhCUFNOVmJlZU5NWklWTy9N?=
 =?utf-8?B?WG05QjhUWlVZWjFOR3dzNkROYlByU2R0cTB0c045ZXZqRVJZQ2U4M2NqMmZi?=
 =?utf-8?B?SXU0WVc2d25vbGs4YlFNQWN0ZnhqZkpUTis2RXJpM1V3djNvRzh5cWw2MXZa?=
 =?utf-8?B?YzNobHpMNHVMOFgwK2FjUDVYNjRFY3pwZWZVMyt5R0VjdExDd0NKdnlZYXA2?=
 =?utf-8?B?U3RtVENQVjhzL0hsUU1NOGVTNXZXZVJqK3dCT3JaVjM4VHNuRWR6d0RpVC9V?=
 =?utf-8?B?a0NiTDVsdzZSTnpJTlpMTHFhNjFGcWRsSWJ5UXpFbTZkOXdLM2FlT1ZNUHZV?=
 =?utf-8?B?ZStyRmhSWUxoZHB1YWlndHpjT0V5clRCblZTTmFkb0F6S09kSUFybU1mdHNr?=
 =?utf-8?B?VDJJSU5Mem00VHdiRWtXMlJqckNUeXZNbFUxTlJEbklzckR1a2ZhVFhxS1oy?=
 =?utf-8?B?a1o5bWpVMHNqL016T1R6Y3dRUDJGeTRMdldoU1lmU0dqeEt6ekcyamtvS0tq?=
 =?utf-8?B?ZWxuS1AvOEVUUlE1OUg0WXgzTDZCb1RXeW0vOHhVVk53alFIeG02ditBcWxK?=
 =?utf-8?B?Um5EcEhKNUdSejFjK2h3L3l2cmQwM2k5ejFxTGNpUUU3MFZXcUFxN0x6OTRZ?=
 =?utf-8?B?TWk5WFJ4akgyK2M4ODkrQ2MrdWNXNXVMejNnN2F6alpPRU9ncmZOL1ZvcGN3?=
 =?utf-8?B?Nmo4ay9wUzVrU0lVcXphSy9BSUJMbnE1YlNQWUpqN1JMcTNzb01WSWQzU1pI?=
 =?utf-8?B?K2Zsd0Z0bDRCVmtDemN1WllZY1JjK3RHaWdYejgrYlVDNk1oTkJPWllJcTZ0?=
 =?utf-8?B?UEd1Wm5XZ0pmdWhYTlI4WlgvaVdzUFRjaFptYXV5S0c2aDBYTkJuVWVOSDls?=
 =?utf-8?B?ZEYwNUoxWDBTdnQ1Sk1CSmNSamZ5SVJWWDJ6QkFrS3NpNjVEVGVuS1B2d2lI?=
 =?utf-8?B?cVlSRVlQUjZXVHVIQlJhdXQwSlcwbVk5OEJ1MmNFUTV2ZmJCaDRFMVRHd2lv?=
 =?utf-8?B?a3A0UlhON0VlZjhJQlA1MjJ4N3BJemJrV2Q4N0N2U0VtU3ZVdTFjalM0THZr?=
 =?utf-8?B?SVd6c0lYUVVseGhUKy9qUW51QXQzeWFFdElWaVBwc2Zxb1piMVJLVWE1a3Z6?=
 =?utf-8?B?ODR6cXIzUExxOVNLVUU3VFhLMDBqWlhGSDBqc1QwdTVsc3UwVTJKc3F1b3hp?=
 =?utf-8?B?aytHM25NL0FCUFRlYTlLSGFuanhVMmUwRzVmWFhUTG5nU0pYbTdFQmExVDRn?=
 =?utf-8?B?NFExa3E5Q1JpelZ5NFljR0F6b2gvRGxBZFo0RzNxVVA4bGNZNFYxWEVCNUox?=
 =?utf-8?B?ZVllY3hmUnVaM1ZkR01JVWh5YzZBVmpLUFFrTWVlVU1mTXB4bXpJSUp1MlFq?=
 =?utf-8?B?Q05Fa3dpVEFUZkI3cXl5MTVGcXhhTGg3YVlLTjh1MXJSbkNrMDB5NHhEQU1D?=
 =?utf-8?B?bkdxaTVqOG11YWhNRE5Fa0FQeERwWnRBMUczYmM4eWVqV3FqeCt5cVhuSFdC?=
 =?utf-8?B?M3U3eCtJeEl0QUF6dG9oWHk1bnJNRlRXaUY5VHVkRENVM1c5TjVNL3owZnUv?=
 =?utf-8?B?REtBYmZVd2p4bGx1YjVnbGhBQkd3ZEFueFB2NkEvbUpUV3NPK1JnOWxSYlJD?=
 =?utf-8?B?OHRGeFdONGExUHVJOUIxcEtNUVBnVitRQzNYblEweXlYRjgwbzlQcGs3cWxR?=
 =?utf-8?B?cUpHZHJ3TjFwVE1zT0tvQXcxNHpuT2hNQXVnMllnWWQxNEt1dTV6aGZjMjJp?=
 =?utf-8?B?VEorZHl0R1IyNE5CcWJPdFlvZnlEOE1pVW83VVpaekNrQllWcWlYYXA1eEkz?=
 =?utf-8?B?c2laRmlwc3Z0aHBUUkZHVFpFTjJkc2trUHhtcm4za0hlQ1dLeFhaL2ViUllm?=
 =?utf-8?B?SG0zSVRZaGZUYXQzSjJ5NFRvcllwanVjZDBkckVHdWVneWl1K0J6MmtKRzNT?=
 =?utf-8?B?VHFmcDljejVRMTZXZkhJSm1qQ0h1OW5qZ3Awc0xCSmgvUldjdXBjdldNY1J6?=
 =?utf-8?B?SWMrRkJSL25kUWRXeG85YlRxaStQYkdYcDZ3UjJxYTgrK2VKSExtY0NIWUlM?=
 =?utf-8?B?MGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <71F1A82149BC2F41B790F330ABE4CD8F@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sealevel.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR05MB8419.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50945d31-a25c-4777-1781-08dbbb770f83
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2023 14:20:23.8335
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e34c5615-b4e3-481c-abc8-602581f2e735
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z81XoSsppfXFiEaqgXvrBcOlgy7GF6FBrXWc/n1VYRK3g49TV4a7xzx6gQCQb4ENel1ZSad9JLqrnObUUenaJinWck8kcMUkqtk59lIbP9E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR05MB7713
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

RnJvbTogTWF0dGhldyBIb3dlbGwgPG1hdHRoZXcuaG93ZWxsQHNlYWxldmVsLmNvbT4NCg0KSGFy
ZHdhcmUgSUQgb2YgU2VhbGV2ZWwgN3h4eEMgY2FyZHMgY2hhbmdlZCBwcmlvciB0byByZWxlYXNl
Lg0KVGhpcyBoYXMgcmVuZGVyZWQgMTRlZTc4ZDU5MzJhIHJlZHVuZGFudC4NCg0KUmV2ZXJ0ICJz
ZXJpYWw6IGV4YXI6IEFkZCBzdXBwb3J0IGZvciBTZWFsZXZlbCA3eHh4QyBzZXJpYWwgY2FyZHMi
DQoNClRoaXMgcmV2ZXJ0cyBjb21taXQgMTRlZTc4ZDU5MzJhZmViNzEwYzgzMDUxOTZhNjc2YTcx
NWJmZGVhOC4NCg0KRml4ZXM6IDE0ZWU3OGQ1OTMyYSAoIkFkZCBzdXBwb3J0IGZvciBTZWFsZXZl
bCA3eHh4QyBzZXJpYWwgY2FyZHMiKQ0KU2lnbmVkLW9mZi1ieTogTWF0dGhldyBIb3dlbGwgPG1h
dHRoZXcuaG93ZWxsQHNlYWxldmVsLmNvbT4NClJldmlld2VkLWJ5OiBBbmR5IFNoZXZjaGVua28g
PGFuZHJpeS5zaGV2Y2hlbmtvQGxpbnV4LmludGVsLmNvbT4NCi0tLQ0KZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvdHR5L3NlcmlhbC84MjUwLzgyNTBfZXhhci5jIGIvZHJpdmVycy90dHkvc2VyaWFsLzgy
NTAvODI1MF9leGFyLmMNCmluZGV4IDA3N2MzYmEzNTM5ZS4uMzg4NmY3OGVjYmJmIDEwMDY0NA0K
LS0tIGEvZHJpdmVycy90dHkvc2VyaWFsLzgyNTAvODI1MF9leGFyLmMNCisrKyBiL2RyaXZlcnMv
dHR5L3NlcmlhbC84MjUwLzgyNTBfZXhhci5jDQpAQCAtNDcsMTIgKzQ3LDYgQEANCiAjZGVmaW5l
IFBDSV9TVUJERVZJQ0VfSURfVVNSXzI5ODAJCTB4MDEyOA0KICNkZWZpbmUgUENJX1NVQkRFVklD
RV9JRF9VU1JfMjk4MQkJMHgwMTI5DQoNCi0jZGVmaW5lIFBDSV9ERVZJQ0VfSURfU0VBTEVWRUxf
NzEweEMJCTB4MTAwMQ0KLSNkZWZpbmUgUENJX0RFVklDRV9JRF9TRUFMRVZFTF83MjB4QwkJMHgx
MDAyDQotI2RlZmluZSBQQ0lfREVWSUNFX0lEX1NFQUxFVkVMXzc0MHhDCQkweDEwMDQNCi0jZGVm
aW5lIFBDSV9ERVZJQ0VfSURfU0VBTEVWRUxfNzgweEMJCTB4MTAwOA0KLSNkZWZpbmUgUENJX0RF
VklDRV9JRF9TRUFMRVZFTF83MTZ4QwkJMHgxMDEwDQotDQogI2RlZmluZSBVQVJUX0VYQVJfSU5U
MAkJMHg4MA0KICNkZWZpbmUgVUFSVF9FWEFSXzhYTU9ERQkweDg4CS8qIDhYIHNhbXBsaW5nIHJh
dGUgc2VsZWN0ICovDQogI2RlZmluZSBVQVJUX0VYQVJfU0xFRVAJCTB4OGIJLyogU2xlZXAgbW9k
ZSAqLw0KQEAgLTY1Miw4ICs2NDYsNiBAQCBleGFyX3BjaV9wcm9iZShzdHJ1Y3QgcGNpX2RldiAq
cGNpZGV2LCBjb25zdCBzdHJ1Y3QgcGNpX2RldmljZV9pZCAqZW50KQ0KIAkJbnJfcG9ydHMgPSBC
SVQoKChwY2lkZXYtPmRldmljZSAmIDB4MzgpID4+IDMpIC0gMSk7DQogCWVsc2UgaWYgKGJvYXJk
LT5udW1fcG9ydHMpDQogCQlucl9wb3J0cyA9IGJvYXJkLT5udW1fcG9ydHM7DQotCWVsc2UgaWYg
KHBjaWRldi0+dmVuZG9yID09IFBDSV9WRU5ET1JfSURfU0VBTEVWRUwpDQotCQlucl9wb3J0cyA9
IHBjaWRldi0+ZGV2aWNlICYgMHhmZjsNCiAJZWxzZQ0KIAkJbnJfcG9ydHMgPSBwY2lkZXYtPmRl
dmljZSAmIDB4MGY7DQoNCkBAIC04OTMsMTIgKzg4NSw2IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3Qg
cGNpX2RldmljZV9pZCBleGFyX3BjaV90YmxbXSA9IHsNCiAJRVhBUl9ERVZJQ0UoQ09NTVRFQ0gs
IDQyMjRQQ0kzMzUsIHBibl9mYXN0Y29tMzM1XzQpLA0KIAlFWEFSX0RFVklDRShDT01NVEVDSCwg
MjMyNFBDSTMzNSwgcGJuX2Zhc3Rjb20zMzVfNCksDQogCUVYQVJfREVWSUNFKENPTU1URUNILCAy
MzI4UENJMzM1LCBwYm5fZmFzdGNvbTMzNV84KSwNCi0NCi0JRVhBUl9ERVZJQ0UoU0VBTEVWRUws
IDcxMHhDLCBwYm5fZXhhcl9YUjE3VjM1eCksDQotCUVYQVJfREVWSUNFKFNFQUxFVkVMLCA3MjB4
QywgcGJuX2V4YXJfWFIxN1YzNXgpLA0KLQlFWEFSX0RFVklDRShTRUFMRVZFTCwgNzQweEMsIHBi
bl9leGFyX1hSMTdWMzV4KSwNCi0JRVhBUl9ERVZJQ0UoU0VBTEVWRUwsIDc4MHhDLCBwYm5fZXhh
cl9YUjE3VjM1eCksDQotCUVYQVJfREVWSUNFKFNFQUxFVkVMLCA3MTZ4QywgcGJuX2V4YXJfWFIx
N1YzNXgpLA0KIAl7IDAsIH0NCiB9Ow0KIE1PRFVMRV9ERVZJQ0VfVEFCTEUocGNpLCBleGFyX3Bj
aV90YmwpOw0KDQo=
