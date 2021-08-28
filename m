Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15470C432BE
	for <linux-serial@archiver.kernel.org>; Sat, 28 Aug 2021 16:59:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE73A601FA
	for <linux-serial@archiver.kernel.org>; Sat, 28 Aug 2021 16:59:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbhH1RAf (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 28 Aug 2021 13:00:35 -0400
Received: from mail-eopbgr1310129.outbound.protection.outlook.com ([40.107.131.129]:30144
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229518AbhH1RAf (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Sat, 28 Aug 2021 13:00:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=HCL.COM; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CpY73cD77DdeWwXPO2hV8v8E/EhfcjiPxkpHBsYSyx4=;
 b=fWJN9h8sAL44hgd0Fq38txSZUqgKHQuK3acJnxaexFRTk5e3OMf7CQxQTNXfApsAq81kBj2KXgxZl3dN9wzew4oRYRZIxmY9n+VGg9rutgEargrz2RKuUZHB9ZGOjaZ4ZcnRtx4Tst88KmwU1VeLSf4xO9Rk+nmZtswFxu9lOw1uJUkXNNgj5M+qVVeTo/G7FTnbdDA3kzg3mRNo+yQo4XqGNB6UuhsPRHkPuW8O77WfPpLxvTlF54QNkonvoSbSp/3OiXiY0OroXrJJy22+pDRGDY695HAgoFTDJFY0wk7JFWdtdsOvZzvTK4ag4sj/uE0+CgD0qVcR2edKAW1CoA==
Received: from SG2PR04CA0157.apcprd04.prod.outlook.com (2603:1096:4::19) by
 HK0PR04MB2834.apcprd04.prod.outlook.com (2603:1096:203:53::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4457.21; Sat, 28 Aug 2021 16:59:36 +0000
Received: from SG2APC01FT061.eop-APC01.prod.protection.outlook.com
 (2603:1096:4:0:cafe::39) by SG2PR04CA0157.outlook.office365.com
 (2603:1096:4::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.19 via Frontend
 Transport; Sat, 28 Aug 2021 16:59:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.8.195.59)
 smtp.mailfrom=hcl.com; kernel.org; dkim=pass (signature was verified)
 header.d=HCL.COM;kernel.org; dmarc=pass action=none header.from=hcl.com;
Received-SPF: Pass (protection.outlook.com: domain of hcl.com designates
 192.8.195.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.8.195.59; helo=APC01-SG2-obe.outbound.protection.outlook.com;
Received: from APC01-SG2-obe.outbound.protection.outlook.com (192.8.195.59) by
 SG2APC01FT061.mail.protection.outlook.com (10.152.251.65) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4457.17 via Frontend Transport; Sat, 28 Aug 2021 16:59:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nmf4C6H/On1fVSZuFIoCp8Miql+vIF02XWM6HxGEJohctk+eOq+38i2axscIXeHqEWly2DKeE5BYViZBs1alqxkmn93fsNEHlYVqjkVnVv0yTAV8Dha4NDs3cVG2pm8Rn1mlnuJnJASOVrNseV6HqmGWVJLwZRaeqBIoCMvAUbyBXOhnQeHSDM8+VluliCGo4aTuL7Iy6i9SnaEzVoYiOCAEOHftgrEE0YFd33x/bn/Lh7DpWsfR4/I87NWKMP6N/+NS5p8sidz9Z6EJ2FeHMRgggkfG2a6uI03dwC/JRO7h/cE2zV+fAVtXAd632Gm2lUdqNIbKmkdEOa0BVfsxoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CpY73cD77DdeWwXPO2hV8v8E/EhfcjiPxkpHBsYSyx4=;
 b=aRCdCzEKFHgQVM2dbUhigJ6M7UbbbsUGjjyj5CgNvk/NMqd7FzhaXFCw4XoO2TNFWv0qiY1ZCsLvwsEl7GFxGimWYgqZYvfc7oPIM/GLyn6s9dfUdH9t5fEEt5kl8miT1yScYTHTvgZSi2LB4RjlUVbjPi1WyN2x+gMECEJkZaj5W6s6PQcv+/agKfuMlwhJvfMgBDsPnNiGqVdm7AFRLDWhVW+cGf9BKHQuqdsxm5juEIbkCWEP2y6XLUAAAnfdP2JLcxpIzBqJ5aywZzPCZVp/uJoo8HBQ/rEiu7RFPgYzR1VIL2AP6FE9jkz/RM5p14WBT1+vrrh6FGci4SM1hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hcl.com; dmarc=pass action=none header.from=hcl.com; dkim=pass
 header.d=hcl.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=HCL.COM; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CpY73cD77DdeWwXPO2hV8v8E/EhfcjiPxkpHBsYSyx4=;
 b=fWJN9h8sAL44hgd0Fq38txSZUqgKHQuK3acJnxaexFRTk5e3OMf7CQxQTNXfApsAq81kBj2KXgxZl3dN9wzew4oRYRZIxmY9n+VGg9rutgEargrz2RKuUZHB9ZGOjaZ4ZcnRtx4Tst88KmwU1VeLSf4xO9Rk+nmZtswFxu9lOw1uJUkXNNgj5M+qVVeTo/G7FTnbdDA3kzg3mRNo+yQo4XqGNB6UuhsPRHkPuW8O77WfPpLxvTlF54QNkonvoSbSp/3OiXiY0OroXrJJy22+pDRGDY695HAgoFTDJFY0wk7JFWdtdsOvZzvTK4ag4sj/uE0+CgD0qVcR2edKAW1CoA==
Received: from SG2PR04MB3820.apcprd04.prod.outlook.com (2603:1096:4:94::15) by
 SG2PR04MB3595.apcprd04.prod.outlook.com (2603:1096:4:a3::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4457.23; Sat, 28 Aug 2021 16:59:31 +0000
Received: from SG2PR04MB3820.apcprd04.prod.outlook.com
 ([fe80::91d9:e218:9129:b23b]) by SG2PR04MB3820.apcprd04.prod.outlook.com
 ([fe80::91d9:e218:9129:b23b%5]) with mapi id 15.20.4457.023; Sat, 28 Aug 2021
 16:59:31 +0000
From:   "Sathish Kumar Balasubramaniam -ERS, HCL Tech" 
        <b-sathishkumar@hcl.com>
To:     Jiri Slaby <jirislaby@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
Subject: RE: [PATCH] tty: serial: UART driver for RISC-V based Chromite SoC
 family
Thread-Topic: [PATCH] tty: serial: UART driver for RISC-V based Chromite SoC
 family
Thread-Index: AdebX37+Hfqi9SPcR72EV2N1dxhcdwAAY8PQACA8jgAAEt2rEA==
Date:   Sat, 28 Aug 2021 16:59:30 +0000
Message-ID: <SG2PR04MB3820A1CDCC0EBFCDC04B6D1181C99@SG2PR04MB3820.apcprd04.prod.outlook.com>
References: <SG2PR04MB382047047E75CF30B8E8EA0B81C89@SG2PR04MB3820.apcprd04.prod.outlook.com>
 <SG2PR04MB3820B2DED21B7B5DB868A18F81C89@SG2PR04MB3820.apcprd04.prod.outlook.com>
 <c5ef817e-7ae9-ae93-a3c4-08fecb943c53@kernel.org>
In-Reply-To: <c5ef817e-7ae9-ae93-a3c4-08fecb943c53@kernel.org>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL2hjbCIsImlkIjoiOTg5NzVkMTYtYjY4ZS00ZjI5LWI4MmYtODdlNWIxZDcyNjQwIiwicHJvcHMiOlt7Im4iOiJIQ0xDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiSENMX0NsYTVzX1B1YmwxYyJ9XX1dfSwiU3ViamVjdExhYmVscyI6W10sIlRNQ1ZlcnNpb24iOiIxOC40LjE4NDMuMTIzIiwiVHJ1c3RlZExhYmVsSGFzaCI6IngzZ1c4cUFzbVUrN1QwQlNLVTNOc3hRb2JDN2RXZTVqQVU5M1Z0VmlvdFlCVFwvVUVTUG92QjRGYStGMjdZTFFvIn0=
x-hclclassification: HCL_Cla5s_Publ1c
Authentication-Results-Original: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=hcl.com;
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: 33bad8b4-3f36-4daf-ecb9-08d96a453709
x-ms-traffictypediagnostic: SG2PR04MB3595:|HK0PR04MB2834:
X-Microsoft-Antispam-PRVS: <HK0PR04MB2834EC79E336426B980EE31A81C99@HK0PR04MB2834.apcprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: s44uCNjPX6dGTe8gz0LYpqZKFVKmSqJDthhA1xr/dDeHkMIU08ugEroSnKhHEB0CczAVlTxk9rORLgqa+6/trBbjuSE22R3dPNgiU4u+PI/BBMBE5wsbMjhl2HJtpqIr6rCONStY+5gtkI3r0ccpVbwTdRaY6cuTqmfpZkZ3VXBxrfzv+FCtfudixQsMfynkU1hBfN0oHUkS9HRoDx+7PDlT7qA0QtrZzkydQEVXYf92Py9Kj1st2l/TbQ38TxdfPc+98+/+Uwh+1P05cP0XdAg9l4EOrdvXQHxLSayi6Wo4Cdh7jfuDU5Xo+tyMO3KLM/O+RmX8L5V0Xrn/vXlJgJfVWLbNmrKRiAHwmKvyunQ8nQUazzPOgU6QuY8lCLRtQk3z6jbR11S1tRVYOyzExW/B2RIXyzOlGDtB+A8uaX0oGmq/6pNgBpd1dg9z8yAXH65Fy+66h6eUa09UtgPD2Eson9i4c/C0sbdFlJ5u9gcKH7LcVzOtQS4gWHflU973kR7SRg3q+mw3xMexB6ltfXP9sXTPxhlmWLGLD0z8kbc87Jb5XgbsoIzdP1wkm5MpvVk0IhpIHaT5isKojih31ZnqsPGQETQMILS4aXybq58Xtk1Ab1F+hLaVirrSvUuuG+6eFjR0WdSYJZKZQMqS9/AoRFWKSlUDpN3z4Rq62NqQvT6aqitoGKfHBEhQ+Bm5ja/zz/eceSyx55XMegQY/w==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR04MB3820.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(136003)(346002)(396003)(376002)(5660300002)(33656002)(66946007)(76116006)(2906002)(66446008)(110136005)(4326008)(9686003)(66556008)(66476007)(64756008)(55016002)(316002)(52536014)(86362001)(186003)(83380400001)(478600001)(71200400001)(26005)(6506007)(38070700005)(122000001)(8676002)(38100700002)(7696005)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OWtTY1Z4a1hiN0I1OWljWkhMd3JFMjFWY1U5U1g1NXlpK2U2c3Z0QlRrMFpT?=
 =?utf-8?B?cW1rejYvUVlEQkFoR085UEJNMnZxN0phNVpwa2xOcTllM3l2U2ZBRzVpajBP?=
 =?utf-8?B?bnpoYzFzekpoT2laQkoxbmVPMWo1VnJmSXRFay83U1ZodDBJeUlXdXNqbDE3?=
 =?utf-8?B?aE5QMC9kTHloYmhwbHc2WkRCZllmMkgzUzNNdEpvTG9NbGU1UERXdk0zSmdC?=
 =?utf-8?B?a0RwOWZSdVR4Vk1FMWlEQ3BKNU4xeVZDa0cxNFVnekp4UzBVRjBlSVcyb2pu?=
 =?utf-8?B?YWtLRlNNSzZ0ZFdnajNhMlI3UHlLbC9hSTQ2RktGc0J1bER1QUJCZ2IyYjNG?=
 =?utf-8?B?VkJHallXamNCbzV5YTdRcktzZWQ2NjdZQWxvdFZKQ2N2eW5VeWtxTEVHaU0y?=
 =?utf-8?B?SEtWK09qdzZKV1gwaVB5MUFCNGZxRnpMODUwNkk4bzlmaGdjUVFpSFY0NVRR?=
 =?utf-8?B?b1k0T2p1M1NkOHB1TWN2Skxta3IxOGxRYnY2blNXRUNyS1M3c1BZRlpEbnN6?=
 =?utf-8?B?ZU1IVHlhTmJPSVF2NURyTGRXSFNIcHdYQmcrb1dwN1FNbElrcmdPdjYzcktO?=
 =?utf-8?B?TlJ1Q1UvTGUyWmZNcWlUcUlaSStmL2FhckE2VFMvWVR2Y1pPRDVRcmMvV2lq?=
 =?utf-8?B?QjJUdDBNTzRPc08wSGZSV0FGdmI2cXU4WGVhT0NJS1dFUmFGWXRUVStGMWJI?=
 =?utf-8?B?cmMrUkpyc0N1TlZGRThwMEg4M0JlN2JqVVpHT3M4U2MyTVBSalJ2WEJoTit5?=
 =?utf-8?B?bWNaTTIveG5Qa2ovOU40UVMwVDVUUm9ZbWNac081bjV0d2NseG9ZajloSVFj?=
 =?utf-8?B?bjJMYXhnMFg0dUpDbnNKMUJWWFFCek01ckp1ZmhQZTMvdFA1Qm1TWU9jYjJ2?=
 =?utf-8?B?YVVJdmZ4bHRUZjNObDQ4K2drQ0VXYWdNT2hOMDhwdU1TZkJ3V1NveENPcHlV?=
 =?utf-8?B?ckZGR201OTdVcEx0bXNVK3NBck51SHR6SjVSVFVCMkpJTnV5UGR0ZTI3dm1q?=
 =?utf-8?B?L3FpcGR2TFFacWFuL1NTUHBPYU9PSTFnUzdWcFBHOS9TNjhSNlZRVVNHOGlt?=
 =?utf-8?B?Yk5BeEp5dFdMSjFCR0R6aGVteFhqMHJBbWNoS040bTZvUkJFUk5zSFRERWY2?=
 =?utf-8?B?Wk1JQkhadm1GcGl5RFJnUXREVHJNMnVJZnVLOFZ3TEZPRXV1OWNPM0hDcmlm?=
 =?utf-8?B?Z25KemxxdC9YcXFJeGVnUTZ2STZldnBVUFh0UGlQeUh6d3Z3enJpdlAwanZ1?=
 =?utf-8?B?dnRnTVg4TTZUM3FZbE9QL2pDWkUxcTNlZGNpREJVdE53dE1EVTlnMGZpbTRG?=
 =?utf-8?B?ZTFIRmI5QTRGZTZGQ2cwU0x0WHp6QzZMa1hoM3RBQzBpSDhsUUpYeURzS25Q?=
 =?utf-8?B?QUZtZzZjeG56TlZVZ2VlMStObHh2cGEvTldrSHBhQ1lJU0dNdlNQRVBDU3du?=
 =?utf-8?B?ZE05TE5kVzEvZStNYTZpb2c4Wmpxb1F6UmhHZkp4bnA2RDFvWE91dVVMcllJ?=
 =?utf-8?B?Tm1ubE9oVTBVTUZWNmt3ZmtXZERPR1lhaVJXUDFCZXpoaDVweVJJdTZ0OERJ?=
 =?utf-8?B?OGxMRW5hbTdrNyt0b0NndWQwNzBQRENYRHY4aVhnS3IvdjRrcUNTZ21zZHB3?=
 =?utf-8?B?S25XeHNaaFZpSmJ1NE14STI3WnFJdlEzSFVvOEZpampla2syUzJTK2RoRW4z?=
 =?utf-8?B?QzFmRit4cEJUWFU2TCtYUmJXUXJDTU8wdlZWdEh0OElVVWZHOFNmSEVkRTJH?=
 =?utf-8?Q?H8qpWlkAPXNuTbjZnp1+TCl1aN01T/SEl+osria?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR04MB3595
X-DLP:  MSGProcess
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: SG2APC01FT061.eop-APC01.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: 66d5970e-554b-4729-8eb4-08d96a45343f
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vfaeAjv6ZIhDRQIKofdEIUe54GwNIpLwIPkxpsQT3EpazqBcup/5jLzvhlp7OkB+8p9pWf47ulI4wv9H9acDg1O1A94ahJ258p00ID0ow7QQM7+niACPnsVooDXtzOodEIQMOOMgnjT2XM7VNBDrgxeAWAkQu6j9TBRICUFBkKPrA0r6kWtAST0ONICfOMrtJ8GH4mwkPJYFqeyJXtBotzmgabepClRtihs9Zv5I8M6nuzjN6uiX8w3p9CUeAHhO4kNqeEHe35xrRULOxHgHWtjIu4UamkzCSvRJ/tR1U8WY+rs3izRdBO2OUTgOtYcicQYQh2do36k11Wje3LPGg6c8efbIMq0tXObL5lruxwGJQIBRMDJscziq5RsX5r/UzkFoncgk/+PQXvjv7zYHPy7mHiCiAdUayisjwS+VLLbJgSKM+AcIstdtbBYlMH0YbfTITH7WS0Lwl3oqoE9+MZHKWeYehPt19gSwxS/Oi5hZejm5gKRdem0I7J2Yl7BA7bvJNn6OqROhDptpdn+ijeaG6DHjSQ/ufzgsFnzRMeIa3seTrzKY1T7Ph9SXl5VmmeFGbxrthaWwhTUL+tbXc38Xzr8FtkTUMOAKOh4aQ3Tzp6dfMv9YKu+JCxriqVKaFiq1GZUZsbNtY96lyc9fKniV/LlGJgq1Q/RXgLDdHrTqoCfHmDVMfH+aHRupgm25/XcZ5UyixHxYJMB+/ARzv/Wlb0IxfD3Ar39kFEQPIrUZj1HyPKp1KjAXlOZwRDcOpUd1S389j+ZBhk7/gawtGQ==
X-Forefront-Antispam-Report: CIP:192.8.195.59;CTRY:IN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:APC01-SG2-obe.outbound.protection.outlook.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(396003)(346002)(136003)(39860400002)(376002)(46966006)(36840700001)(81166007)(4326008)(82310400003)(8676002)(8936002)(7696005)(356005)(83380400001)(70586007)(82740400003)(47076005)(52536014)(36860700001)(86362001)(5660300002)(34020700004)(36906005)(186003)(9686003)(26005)(316002)(70206006)(2906002)(33656002)(110136005)(336012)(6506007)(478600001)(55016002)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: HCL.COM
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2021 16:59:35.2703
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 33bad8b4-3f36-4daf-ecb9-08d96a453709
X-MS-Exchange-CrossTenant-Id: 189de737-c93a-4f5a-8b68-6f4ca9941912
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=189de737-c93a-4f5a-8b68-6f4ca9941912;Ip=[192.8.195.59];Helo=[APC01-SG2-obe.outbound.protection.outlook.com]
X-MS-Exchange-CrossTenant-AuthSource: SG2APC01FT061.eop-APC01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR04MB2834
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Q2xhc3NpZmljYXRpb246IFB1YmxpYw0KDQpTdXJlLCBJIHdpbGwgZG8gdGhpcyBjaGFuZ2Ugd2hp
bGUgc2VuZGluZyBteSB2MiBwYXRjaC4NCg0KVGhhbmsgeW91Lg0KDQoNCk9uIDI3LiAwOC4gMjEs
IDE4OjMyLCBTYXRoaXNoIEt1bWFyIEJhbGFzdWJyYW1hbmlhbSAtRVJTLCBIQ0wgVGVjaCB3cm90
ZToNCj4gK3N0YXRpYyB2b2lkIGNocm9taXRlX3NlcmlhbF9zZXRfdGVybWlvcyhzdHJ1Y3QgdWFy
dF9wb3J0ICpwb3J0LA0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBzdHJ1Y3Qga3Rlcm1pb3MgKnRlcm1pb3MsDQo+ICsgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCBrdGVybWlvcyAqb2xkKSB7DQo+ICsg
ICAgICAgc3RydWN0IGNocm9taXRlX3NlcmlhbF9wb3J0ICpjc3AgPSBwb3J0X3RvX2Nocm9taXRl
X3NlcmlhbF9wb3J0KHBvcnQpOw0KPiArICAgICAgIHVuc2lnbmVkIGxvbmcgZmxhZ3M7DQo+ICsg
ICAgICAgaW50IHJhdGU7DQo+ICsNCj4gKyAgICAgICBpZiAoKHRlcm1pb3MtPmNfY2ZsYWcgJiBD
U0laRSkgIT0gQ1M4KQ0KPiArICAgICAgICAgICAgICAgZGV2X2Vycl9vbmNlKGNzcC0+cG9ydC5k
ZXYsICJvbmx5IDgtYml0IHdvcmRzIHN1cHBvcnRlZFxuIik7DQo+ICsgICAgICAgaWYgKHRlcm1p
b3MtPmNfY2ZsYWcgJiBDU1RPUEIpDQo+ICsgICAgICAgICAgICAgICBkZXZfZXJyX29uY2UoY3Nw
LT5wb3J0LmRldiwgIm9ubHkgMSBzdG9wLWJpdCBpcyBzdXBwb3J0ZWRcbiIpOw0KPiArICAgICAg
IGlmICh0ZXJtaW9zLT5jX2lmbGFnICYgKElOUENLIHwgUEFSTVJLKSkNCj4gKyAgICAgICAgICAg
ICAgIGRldl9lcnJfb25jZShjc3AtPnBvcnQuZGV2LCAicGFyaXR5IGNoZWNraW5nIG5vdCBzdXBw
b3J0ZWRcbiIpOw0KPiArICAgICAgIGlmICh0ZXJtaW9zLT5jX2lmbGFnICYgQlJLSU5UKQ0KPiAr
ICAgICAgICAgICAgICAgZGV2X2Vycl9vbmNlKGNzcC0+cG9ydC5kZXYsICJCUkVBSyBkZXRlY3Rp
b24gbm90DQo+ICsgc3VwcG9ydGVkXG4iKTsNCg0KTWFueSBtYW5nbGVkIGxpbmVzIGxpa2UgdGhp
cy4gUGxlYXNlIGZpeCB0aGVzZSB1cCBpbiB2Mi4gQW5kIGFsc28gdXNlIGNoZWNrcGF0Y2guIFRo
ZSBmdW5jdGlvbi1vcGVuaW5nIHsgYWJvdmUgc2hvdWxkIGJlIG9uIGEgc2VwYXJhdGUgbGluZSAo
b24gbWFueSBsb2NhdGlvbnMpLg0KDQp0aGFua3MsDQotLQ0KanMNCjo6RElTQ0xBSU1FUjo6DQpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0KVGhlIGNvbnRlbnRzIG9mIHRoaXMgZS1t
YWlsIGFuZCBhbnkgYXR0YWNobWVudChzKSBhcmUgY29uZmlkZW50aWFsIGFuZCBpbnRlbmRlZCBm
b3IgdGhlIG5hbWVkIHJlY2lwaWVudChzKSBvbmx5LiBFLW1haWwgdHJhbnNtaXNzaW9uIGlzIG5v
dCBndWFyYW50ZWVkIHRvIGJlIHNlY3VyZSBvciBlcnJvci1mcmVlIGFzIGluZm9ybWF0aW9uIGNv
dWxkIGJlIGludGVyY2VwdGVkLCBjb3JydXB0ZWQsIGxvc3QsIGRlc3Ryb3llZCwgYXJyaXZlIGxh
dGUgb3IgaW5jb21wbGV0ZSwgb3IgbWF5IGNvbnRhaW4gdmlydXNlcyBpbiB0cmFuc21pc3Npb24u
IFRoZSBlIG1haWwgYW5kIGl0cyBjb250ZW50cyAod2l0aCBvciB3aXRob3V0IHJlZmVycmVkIGVy
cm9ycykgc2hhbGwgdGhlcmVmb3JlIG5vdCBhdHRhY2ggYW55IGxpYWJpbGl0eSBvbiB0aGUgb3Jp
Z2luYXRvciBvciBIQ0wgb3IgaXRzIGFmZmlsaWF0ZXMuIFZpZXdzIG9yIG9waW5pb25zLCBpZiBh
bnksIHByZXNlbnRlZCBpbiB0aGlzIGVtYWlsIGFyZSBzb2xlbHkgdGhvc2Ugb2YgdGhlIGF1dGhv
ciBhbmQgbWF5IG5vdCBuZWNlc3NhcmlseSByZWZsZWN0IHRoZSB2aWV3cyBvciBvcGluaW9ucyBv
ZiBIQ0wgb3IgaXRzIGFmZmlsaWF0ZXMuIEFueSBmb3JtIG9mIHJlcHJvZHVjdGlvbiwgZGlzc2Vt
aW5hdGlvbiwgY29weWluZywgZGlzY2xvc3VyZSwgbW9kaWZpY2F0aW9uLCBkaXN0cmlidXRpb24g
YW5kIC8gb3IgcHVibGljYXRpb24gb2YgdGhpcyBtZXNzYWdlIHdpdGhvdXQgdGhlIHByaW9yIHdy
aXR0ZW4gY29uc2VudCBvZiBhdXRob3JpemVkIHJlcHJlc2VudGF0aXZlIG9mIEhDTCBpcyBzdHJp
Y3RseSBwcm9oaWJpdGVkLiBJZiB5b3UgaGF2ZSByZWNlaXZlZCB0aGlzIGVtYWlsIGluIGVycm9y
IHBsZWFzZSBkZWxldGUgaXQgYW5kIG5vdGlmeSB0aGUgc2VuZGVyIGltbWVkaWF0ZWx5LiBCZWZv
cmUgb3BlbmluZyBhbnkgZW1haWwgYW5kL29yIGF0dGFjaG1lbnRzLCBwbGVhc2UgY2hlY2sgdGhl
bSBmb3IgdmlydXNlcyBhbmQgb3RoZXIgZGVmZWN0cy4NCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fDQo=
