Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E0EBC433ED
	for <linux-serial@archiver.kernel.org>; Tue, 20 Apr 2021 19:02:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6734613C2
	for <linux-serial@archiver.kernel.org>; Tue, 20 Apr 2021 19:02:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233675AbhDTTD0 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 20 Apr 2021 15:03:26 -0400
Received: from outbound-ip24a.ess.barracuda.com ([209.222.82.206]:56478 "EHLO
        outbound-ip24a.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233548AbhDTTD0 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 20 Apr 2021 15:03:26 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2046.outbound.protection.outlook.com [104.47.74.46]) by mx-outbound10-213.us-east-2a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Tue, 20 Apr 2021 19:02:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GaBabiOyVI5f/E9WND8EJ5gR6lvLDAkd6116vI+SwvKLhm3Nw7UVSQl4xHI+HiSFTBTjYfH5eVZS7uh9X/GCBAsXZaLdR9WamoENFeuUxiekXky7uDCi3Ar4FwemywjKGNBx8nn6BtvuKRtffeWUBWEdwdMLVJjSkAG6gQr5MxNnlx/b9azTB1M5hgiGOpS/bEKDyhmU5coMPytzPEMF0ETLwy52dwr9AYoCT7Qwrwq33mozN2WkYkZwWf9j4KCsjPoo77jgRsAWrPRunw58oygu+k90ONo9Hn3HkKHeiIWjF+XeiCRNwTok2JYuAqXgfyRJ1MGhPtRAbjJF5xVv5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XCVVwNQJbJNehT0mGAPBJQYMzI95puiBOtjKjCs7zec=;
 b=UTB2zAFx5BwKe4SOqvZ9e6y8vW1yuQDEAjy7CgEF783yXh+aQB63RtCmYjSrN2efKb0vQW+PftxcVdq1z83S/0GrjMy5QN5iU6zLbkatLjLaNZx+UiQAbxriSFxBpAB/BBgx258DK8XW8/j8YEFBbfP03C5P+Sc3nB3079C3bQPlIwOjKuq8FfyxM7oJaeSLx04IpL8/RwCWOMAMmHD8u1oewU6Sc13qbm8uE1z0eg6pcH9dqVtaGO1SYgClgm99986d5b2dMIs4Efl6KuE3SS1qjCnSzGlrSBhq0RFrhbbiRsxMeFK6ToeGfaJhylWpIKnzynVSBZxFBHbwyzbOzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=digi.com; dmarc=pass action=none header.from=digi.com;
 dkim=pass header.d=digi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digi.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XCVVwNQJbJNehT0mGAPBJQYMzI95puiBOtjKjCs7zec=;
 b=WCIUw9cyInkzqtKR/IlV7JiFOKtDUbGWXvO25T1yP2lJmPGx2JcANfnUpAwxq8bgMZStXHWLj/6YpmsCUnQClQ/YarIBn6OdGycohHwPW3k98u4XN4C+SE6t1WSr8bkfWq0t+wpg+K+v62Xa520X+wfTdVxPm+dxgiRYQX6Bh30=
Received: from CO1PR10MB4561.namprd10.prod.outlook.com (2603:10b6:303:9d::15)
 by CO1PR10MB4578.namprd10.prod.outlook.com (2603:10b6:303:9e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.18; Tue, 20 Apr
 2021 19:02:33 +0000
Received: from CO1PR10MB4561.namprd10.prod.outlook.com
 ([fe80::75d6:e217:6181:f5a5]) by CO1PR10MB4561.namprd10.prod.outlook.com
 ([fe80::75d6:e217:6181:f5a5%5]) with mapi id 15.20.4042.024; Tue, 20 Apr 2021
 19:02:33 +0000
From:   "Hodaszi, Robert" <Robert.Hodaszi@digi.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= 
        <u.kleine-koenig@pengutronix.de>,
        "Hodaszi, Robert" <Robert.Hodaszi@digi.com>
Subject: [PATCH v2] serial: imx: fix TX stop function not setting state to OFF
Thread-Topic: [PATCH v2] serial: imx: fix TX stop function not setting state
 to OFF
Thread-Index: AQHXNhe4tcX1Da9600Oe4OMrG+B/AQ==
Date:   Tue, 20 Apr 2021 19:02:33 +0000
Message-ID: <25c1a28dfb7f892a5c214ba7d8489879d7c0e4be.camel@digi.com>
Accept-Language: hu-HU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.4-0ubuntu1 
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=digi.com;
x-originating-ip: [81.183.32.32]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c3a990bc-d4dd-4a60-2610-08d9042edac9
x-ms-traffictypediagnostic: CO1PR10MB4578:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO1PR10MB457878A27B0949924785184CE6489@CO1PR10MB4578.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uCrKcwLiTGbvwxiCFvm8MdzCgPNqY5tAtV1vreVIT/7Ytmus4B6biD8yhTJEB1fjmDbjGOVaWchKx5YDo+c05E7MfyaYqI+8NsTqpyI+MLRKg2knDSDy4M6jrURXvVAiJvzeUYpbtenQtbA3flRbjM59tf8Xd2pyh7TxTkSqMptrD1qGhAjZxNh4CRjtSw+cQ4WbD5UdMLjzS3Ol0Qt8UC/wRdtbwkLJoTpo8qv7/gXU2dtykud6QWCzTRRLuD+jDxx4HM2rlDOnLvWcZvhRZ02XGbHrOHfpmbotMC1dbczn4mASy7R6qj/YqSAuUOShh7qN72gyp8wIJW01ViJyFojIwiNUhmAPGXrR8vEZbm8TgcVq5QCaHTcbQIuG8Hl2ug2NhpNBMdXOdf/lfvjY9wDyORKY3QQD207SFeTTGPQOSTOG4DkPT1J+hrOSM311c3nVGfYIMs4K/gXvirlC0yDb2ehSQ/j3d9Pe4gO4DhE9pUC/6nrqIVC7l+aTU6m80baW6Sh6OZ6glMNNv4ABnWVj0X8YTbtaNkVUr5zv/KLHUrmljGU95P/FkDA9KYhItWhZ04QmRmDEW3EgIOTrqa5PutinhNVQcAI6DMA3paQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4561.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(366004)(396003)(39850400004)(346002)(5660300002)(316002)(8676002)(478600001)(83380400001)(38100700002)(54906003)(66476007)(71200400001)(6916009)(66556008)(64756008)(76116006)(4326008)(2616005)(6512007)(26005)(8936002)(6506007)(66946007)(66446008)(91956017)(107886003)(186003)(6486002)(36756003)(86362001)(122000001)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?cmFzVTJ0K3Vadi9vQ09ncDB3bjd6dkRYbWIwV2ZxME1MV3dXYXBkcUtiWWZ2?=
 =?utf-8?B?MzdFRXpIOE5vL2cxNGRQK2JFaHF6Q1dvTXNZdDN0VFVLbXlQSFZocFcrVVdC?=
 =?utf-8?B?di9DSVRTdC9RNjhIT3JoaWZQemo0blVEYmJJMm8zeDJZdGRUcklDc2t0Q1E4?=
 =?utf-8?B?SGpVZnJVSGRzRnVuMUxycVY5RmRuVm9wcHh6T2lWeU1iTkkyaGQ4MHlNMklN?=
 =?utf-8?B?aHdIMWdNNWgrQ0dnU3d4eXkrQnVrV3F6bnFEb1lOQWFQV2hsN0p3RnEyUDlT?=
 =?utf-8?B?aUgyZ284eHlRelR5ZXBZdDNFWUFWNkFEemJ0RmVrZVpLVXdMRGpkQ1B6Z0JE?=
 =?utf-8?B?d1J5d2ZKRGhZVEVNSElEY0dNRWc3WkdHNzJwQlBDcENxQlZOTmNudnF6STlk?=
 =?utf-8?B?MnBIRGVPaTd3WGt3TzJDSUdiQ3RKSis0SGlHdXZ2OHQ3UlRKamNhSVgrMytH?=
 =?utf-8?B?SW9WN2hDSkZvYWNpNXRHOFBqZDRRZkxoS1lmcE1LQmhBaFA5aElyMkp5MUQ4?=
 =?utf-8?B?QWM4ZjFWbUcvRmFtZ0puZ1FjR2dPSzgyTVZoNDVWL3Bva0NQTjVENW1kZzRV?=
 =?utf-8?B?VlpuWXJDRkNyWnFUOUF6T1ZWZTJLTC9YbHdMZHc4SjBCRTNtVVNOYlhtem16?=
 =?utf-8?B?MVFBdXhSclBGaEQwUWtOcTJyS1RtZ2k4WXprQkR2N1VQZTlhMk9DME40MlRz?=
 =?utf-8?B?NHdSSHRDVG5GYmw5SW9qNGQ3NWl0MHdpQVExQWd2VUd5WU9GWUVRMkR1S3ZD?=
 =?utf-8?B?MU5EOGlWVzM1d0Yzd3lZSVlwVkNqNGZzYTJsSGZ2cE03eFVtYmc2dG5xOUtR?=
 =?utf-8?B?dk5HMDJxQzVyM1pPQzRZM2ZDL2duaENjY3VKL3A1alhBVSszREVmR0hFdkR6?=
 =?utf-8?B?L0hVUXFCS2V4dEhQUWVYVk9tUEw1NjRjajlJdmdJOWxoSXdwdnFDTGJEWDhy?=
 =?utf-8?B?VXJIQ3BFMDl4SUh3bE5qUFlmZXQrNC90eDlxdURUVXFRSHh4c0I4d1liaWFK?=
 =?utf-8?B?aE0xUlRCVUUwbWRUdElkZWVMd0l2SmtrQ2JVUzZBL3dmY2pDdU93N3J0bnow?=
 =?utf-8?B?VEMyMzREVEtRY01ZeTZvVkxpS00vTEpUZm9mSUNDYnZ2MWdlNEJUNGdubngz?=
 =?utf-8?B?ei9JUUZTUWF4bXo2RnBWZ3ZSYmlkRURTcWRKTGQ0OXhURDl3aTk3cGJhS05n?=
 =?utf-8?B?L1pvaTBPOWNxNnp1TkpueDVmL1dwWXM1Vmh5M3FTRk4vN1JJR1NCTVAxMXFx?=
 =?utf-8?B?MFFCZW15bnJsUTZaZzljbTlHbkRuUTJoZHQ5Ym1aN2MySzRhcDBrUmN1ZHZs?=
 =?utf-8?B?YlBnUVRLa01pUXU2dGhqQTFkbUxaOFArcEYzZGU4SWtqTVF1c2s0T1g1UjB1?=
 =?utf-8?B?cXNkaTNLTW11dVJoNGpJT2p0WkpOWXJzRksydUxiVG1meS9OMjhqV0ZnWWhQ?=
 =?utf-8?B?K2Z6ZGhPVUswZHU2QVVVUFJvYzAvU0tYUHgxQ2NUVFZuUFVPN1gxNXFGRFNE?=
 =?utf-8?B?MDVTdXlvM3hjTTZlOWo0Y25jMEdNK0JSR2xiSTcyNTd3U0lLMFdTRk95QVRT?=
 =?utf-8?B?cU15QVZiL2Zpang0U0dLS0lIZUFIcnFIYnFWUysvdzRSNzBNaksxRXBYeWRB?=
 =?utf-8?B?alFHM2JudEtOOGVtRXVsUUVkT29vVGpGSGFucHA0bXZJOGRqUGYxY3UzaWFh?=
 =?utf-8?B?L21oRnpyL3ZMMGVDN1ZkL2paaVo2dWlIVHpZMUsvcUlOSEJpSkR3RmlQWnhK?=
 =?utf-8?Q?63/hbSLV6wkZcrwobvAUFCkc0YKJs9Wp5T9xwfX?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <26FA231F7E4D444C8F7AA6FC732A4FB2@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: digi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4561.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3a990bc-d4dd-4a60-2610-08d9042edac9
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2021 19:02:33.3744
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: abb4cdb7-1b7e-483e-a143-7ebfd1184b9e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5vbPUH6PscsB6yRB9H1jPnX2EI2ELOYYtksUcHc450JpAwrHKn018KMQqhu/Qe/MMYysH6VNGVj7rzQsdBurng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4578
X-BESS-ID: 1618945357-102773-14008-5075-1
X-BESS-VER: 2019.1_20210420.1810
X-BESS-Apparent-Source-IP: 104.47.74.46
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.231691 [from 
        cloudscan20-226.us-east-2b.ess.aws.cudaops.com]
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS112744 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

SWYgdGhlIG1vZGUgaGFkIGJlZW4gY2hhbmdlZCB0byBSUy00ODUgYWZ0ZXIgYXQgbGVhc3Qgb25l
IGNoYXJhY3RlciBoYWQNCmJlZW4gc2VudCBpbiBSUy0yMzIgbW9kZSwgdGhlIFJTLTQ4NSB0cmFu
c21pc3Npb24gd2FzIG5vdCB3b3JraW5nLg0KDQpDb21taXQgY2IxYTYwOTIzNjA5NmMyNzhlY2Jm
YjdiZTY3OGE2OTNhNzAyODNmMSAoInNlcmlhbDogaW14OiBpbXBsZW1lbnQNCnJ0cyBkZWxheWlu
ZyBmb3IgcnM0ODUiKSBhZGRlZCBhIFRYIHN0YXRlIHZhcmlhYmxlIHRvIGtlZXAgdHJhY2ssIHdo
ZW4NCml0IG5lZWRzIHRvIGVuYWJsZSAvIGRpc2FibGUgdGhlIFJTLTQ4NSB0cmFuc21pdHRlci4N
Cg0KSW4gUlMtMjMyIG1vZGUsIHRoZSBzdGFydCBUWCBmdW5jdGlvbiBqdXN0IHNldHMgdGhlIHN0
YXRlIHRvIFNFTkQsIGFuZA0KdGhlIHN0b3AgZnVuY3Rpb24gc3VwcG9zZWQgdG8gc2V0IGl0IHRv
IE9GRi4NCg0KSW4gUlMtNDg1IG1vZGUsIHRoZSBzdGFydCBUWCBmdW5jdGlvbiBleHBlY3RzIHRo
ZSBzdGF0ZSB0byBiZSBlaXRoZXINCk9GRiwgV0FJVF9BRlRFUl9TRU5ELCBvciBXQUlUX0FGVEVS
IFJUUy4gSXQgY2Fubm90IGRvIGFueXRoaW5nIGlmIHRoZQ0Kc3RhdGUgaXMgc2V0IHRvIFNFTkQs
IGV4cGVjdHMgYSBzdG9wIGZpcnN0Lg0KDQpCdXQgc3RvcCBUWCBmdW5jdGlvbiBpbiBSUy0yMzIg
bW9kZSB1c3VhbGx5IGRpZG4ndCBzZXQgdGhlIHN0YXRlIHRvIE9GRiwNCmFzIGl0IGZpcnN0IGNo
ZWNrZWQgaWYgdGhlIHNoaWZ0ZXIgaXMgZW1wdHksIGFuZCBpZiBub3QsIGl0IGp1c3QNCnJldHVy
bmVkLCB3YWl0aW5nIGZvciBhIFRyYW5zbWl0Q29tcGxldGUgaW50ZXJydXB0LCB3aGljaCBpcyBv
bmx5DQplbmFibGVkIGluIFJTLTQ4NSBtb2RlLiBTbyB0aGUgc3RvcCBmdW5jdGlvbiB3YXMgbmV2
ZXIgY2FsbGVkIGFnYWluLg0KDQpUaGF0IGNoZWNrLCBhbmQgdGhlIHN1YnNlcXVlbnQgY29kZSBw
YXJ0IGlzIG5vdCBuZWVkZWQgZm9yIFJTLTIzMiwgaXQNCmp1c3QgaGF2ZSB0byBzZXQgdGhlIFRY
IHN0YXRlIHRvIE9GRi4NCg0KU2lnbmVkLW9mZi1ieTogUm9iZXJ0IEhvZGFzemkgPHJvYmVydC5o
b2Rhc3ppQGRpZ2kuY29tPg0KLS0tDQoNCkNoYW5nZXMgaW4gdjI6DQogLSBGaXhlZCBpbmNvcnJl
Y3QgdGFicw0KDQogZHJpdmVycy90dHkvc2VyaWFsL2lteC5jIHwgNDYgKysrKysrKysrKysrKysr
KysrKysrLS0tLS0tLS0tLS0tLS0tLS0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCAyNCBpbnNlcnRpb25z
KCspLCAyMiBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvdHR5L3NlcmlhbC9p
bXguYyBiL2RyaXZlcnMvdHR5L3NlcmlhbC9pbXguYw0KaW5kZXggODI1NzU5N2QwMzRkLi41MTFi
YWRjZTNlZGQgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL3R0eS9zZXJpYWwvaW14LmMNCisrKyBiL2Ry
aXZlcnMvdHR5L3NlcmlhbC9pbXguYw0KQEAgLTQ0Myw2ICs0NDMsMTIgQEAgc3RhdGljIHZvaWQg
aW14X3VhcnRfc3RvcF90eChzdHJ1Y3QgdWFydF9wb3J0ICpwb3J0KQ0KIAl1Y3IxID0gaW14X3Vh
cnRfcmVhZGwoc3BvcnQsIFVDUjEpOw0KIAlpbXhfdWFydF93cml0ZWwoc3BvcnQsIHVjcjEgJiB+
VUNSMV9UUkRZRU4sIFVDUjEpOw0KIA0KKwlpZiAoIShwb3J0LT5yczQ4NS5mbGFncyAmIFNFUl9S
UzQ4NV9FTkFCTEVEKSkgew0KKwkJLyogU2V0IHRoZSBUWCBzdGF0ZSBpbiBub24tUlM0ODUgbW9k
ZSwgbm90aGluZyBlbHNlIHRvIGRvICovDQorCQlzcG9ydC0+dHhfc3RhdGUgPSBPRkY7DQorCQly
ZXR1cm47DQorCX0NCisNCiAJdXNyMiA9IGlteF91YXJ0X3JlYWRsKHNwb3J0LCBVU1IyKTsNCiAJ
aWYgKCEodXNyMiAmIFVTUjJfVFhEQykpIHsNCiAJCS8qIFRoZSBzaGlmdGVyIGlzIHN0aWxsIGJ1
c3ksIHNvIHJldHJ5IG9uY2UgVEMgdHJpZ2dlcnMgKi8NCkBAIC00NTMsMzMgKzQ1OSwyOSBAQCBz
dGF0aWMgdm9pZCBpbXhfdWFydF9zdG9wX3R4KHN0cnVjdCB1YXJ0X3BvcnQgKnBvcnQpDQogCXVj
cjQgJj0gflVDUjRfVENFTjsNCiAJaW14X3VhcnRfd3JpdGVsKHNwb3J0LCB1Y3I0LCBVQ1I0KTsN
CiANCi0JLyogaW4gcnM0ODUgbW9kZSBkaXNhYmxlIHRyYW5zbWl0dGVyICovDQotCWlmIChwb3J0
LT5yczQ4NS5mbGFncyAmIFNFUl9SUzQ4NV9FTkFCTEVEKSB7DQotCQlpZiAoc3BvcnQtPnR4X3N0
YXRlID09IFNFTkQpIHsNCi0JCQlzcG9ydC0+dHhfc3RhdGUgPSBXQUlUX0FGVEVSX1NFTkQ7DQot
CQkJc3RhcnRfaHJ0aW1lcl9tcygmc3BvcnQtPnRyaWdnZXJfc3RvcF90eCwNCi0JCQkJCSBwb3J0
LT5yczQ4NS5kZWxheV9ydHNfYWZ0ZXJfc2VuZCk7DQotCQkJcmV0dXJuOw0KLQkJfQ0KKwlpZiAo
c3BvcnQtPnR4X3N0YXRlID09IFNFTkQpIHsNCisJCXNwb3J0LT50eF9zdGF0ZSA9IFdBSVRfQUZU
RVJfU0VORDsNCisJCXN0YXJ0X2hydGltZXJfbXMoJnNwb3J0LT50cmlnZ2VyX3N0b3BfdHgsDQor
CQkJCQlwb3J0LT5yczQ4NS5kZWxheV9ydHNfYWZ0ZXJfc2VuZCk7DQorCQlyZXR1cm47DQorCX0N
CiANCi0JCWlmIChzcG9ydC0+dHhfc3RhdGUgPT0gV0FJVF9BRlRFUl9SVFMgfHwNCi0JCSAgICBz
cG9ydC0+dHhfc3RhdGUgPT0gV0FJVF9BRlRFUl9TRU5EKSB7DQotCQkJdTMyIHVjcjI7DQorCWlm
IChzcG9ydC0+dHhfc3RhdGUgPT0gV0FJVF9BRlRFUl9SVFMgfHwNCisJCXNwb3J0LT50eF9zdGF0
ZSA9PSBXQUlUX0FGVEVSX1NFTkQpIHsNCisJCS8qIGluIHJzNDg1IG1vZGUgZGlzYWJsZSB0cmFu
c21pdHRlciAqLw0KKwkJdTMyIHVjcjI7DQogDQotCQkJaHJ0aW1lcl90cnlfdG9fY2FuY2VsKCZz
cG9ydC0+dHJpZ2dlcl9zdGFydF90eCk7DQorCQlocnRpbWVyX3RyeV90b19jYW5jZWwoJnNwb3J0
LT50cmlnZ2VyX3N0YXJ0X3R4KTsNCiANCi0JCQl1Y3IyID0gaW14X3VhcnRfcmVhZGwoc3BvcnQs
IFVDUjIpOw0KLQkJCWlmIChwb3J0LT5yczQ4NS5mbGFncyAmIFNFUl9SUzQ4NV9SVFNfQUZURVJf
U0VORCkNCi0JCQkJaW14X3VhcnRfcnRzX2FjdGl2ZShzcG9ydCwgJnVjcjIpOw0KLQkJCWVsc2UN
Ci0JCQkJaW14X3VhcnRfcnRzX2luYWN0aXZlKHNwb3J0LCAmdWNyMik7DQotCQkJaW14X3VhcnRf
d3JpdGVsKHNwb3J0LCB1Y3IyLCBVQ1IyKTsNCisJCXVjcjIgPSBpbXhfdWFydF9yZWFkbChzcG9y
dCwgVUNSMik7DQorCQlpZiAocG9ydC0+cnM0ODUuZmxhZ3MgJiBTRVJfUlM0ODVfUlRTX0FGVEVS
X1NFTkQpDQorCQkJaW14X3VhcnRfcnRzX2FjdGl2ZShzcG9ydCwgJnVjcjIpOw0KKwkJZWxzZQ0K
KwkJCWlteF91YXJ0X3J0c19pbmFjdGl2ZShzcG9ydCwgJnVjcjIpOw0KKwkJaW14X3VhcnRfd3Jp
dGVsKHNwb3J0LCB1Y3IyLCBVQ1IyKTsNCiANCi0JCQlpbXhfdWFydF9zdGFydF9yeChwb3J0KTsN
CisJCWlteF91YXJ0X3N0YXJ0X3J4KHBvcnQpOw0KIA0KLQkJCXNwb3J0LT50eF9zdGF0ZSA9IE9G
RjsNCi0JCX0NCi0JfSBlbHNlIHsNCiAJCXNwb3J0LT50eF9zdGF0ZSA9IE9GRjsNCiAJfQ0KIH0N
Ci0tIA0KMi4yNy4wDQoNCg==
