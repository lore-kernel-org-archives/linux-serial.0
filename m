Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51F21C4320A
	for <linux-serial@archiver.kernel.org>; Sat, 28 Aug 2021 17:16:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 395EE60E77
	for <linux-serial@archiver.kernel.org>; Sat, 28 Aug 2021 17:16:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbhH1RRq (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 28 Aug 2021 13:17:46 -0400
Received: from mail-eopbgr1410109.outbound.protection.outlook.com ([40.107.141.109]:40256
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229672AbhH1RRo (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Sat, 28 Aug 2021 13:17:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=HCL.COM; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4bRNwDWCnwddl9hlS0GFjA+hPJvQaNHsNWAGsz7AJ/s=;
 b=YVNua0XBXyPTS1dRLo0Tv2x4HveZbTpyRHHJYLdw6j5fJmZp72QJSDrMtR3nVNDUk5yjlrzI0DVAslPtf0PNzJqkB36wTChtKiIJSKYNecDCgIhxwiEyB6wcSm4gaRpUQtmYrKQTjEDe0pKZs27SEeK7Y2q/W649OazkjsGq8X7rTk7TFE/1xGwCBX+DltqJ7oztN+9uxZ1fjXplZT6Qnp9kjAuLvTj+s3iLZAaCc82bqkaxkTjZjl9ISBfJF0hgMyA65D8znZ+TUtQrwYpJu+2/NNCr6elaAKYKXrn/bKOj9TarkPWnwRn3q1ixBo7baDRrDXmH1ufdV55JGpB+2Q==
Received: from SGAP274CA0006.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::18) by
 TYAPR04MB2384.apcprd04.prod.outlook.com (2603:1096:404:22::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4457.17; Sat, 28 Aug 2021 17:16:51 +0000
Received: from SG2APC01FT013.eop-APC01.prod.protection.outlook.com
 (2603:1096:4:b6:cafe::b3) by SGAP274CA0006.outlook.office365.com
 (2603:1096:4:b6::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.19 via Frontend
 Transport; Sat, 28 Aug 2021 17:16:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.8.245.52)
 smtp.mailfrom=hcl.com; kernel.org; dkim=pass (signature was verified)
 header.d=HCL.COM;kernel.org; dmarc=pass action=none header.from=hcl.com;
Received-SPF: Pass (protection.outlook.com: domain of hcl.com designates
 192.8.245.52 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.8.245.52; helo=APC01-SG2-obe.outbound.protection.outlook.com;
Received: from APC01-SG2-obe.outbound.protection.outlook.com (192.8.245.52) by
 SG2APC01FT013.mail.protection.outlook.com (10.152.250.186) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4457.17 via Frontend Transport; Sat, 28 Aug 2021 17:16:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P3F/XNSWVSyrNBzqDLpZzD1A1rRgK3+rFCmXuzjezmWcc4+KHCOWNQnlrSf6K322wxWqMMlBdh7rfbAIugSX7j/iq0JFSrVTeKQyOMIkO5pd66uhVWdYihrak6gWj4FJdf+o1+5A2aIwtyr+OHZ4f6Gy25xtkVS9ltRL0jJiKqtyC/8xnckJwYzyU4lTzWg82xLle87N02VVxaAG4EDK793w7ZNCxnf/jDx2sBdzpyYZ+LE3XyNwEmcNRGNuatmd6r209nPPHnfXvlyoXHnS5w9+smkhSAl9sILS7Dh7VrSlCyNqrOXdR+Z16DVB4GAnhVFncFvIjON0R1eTGxEW3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4bRNwDWCnwddl9hlS0GFjA+hPJvQaNHsNWAGsz7AJ/s=;
 b=EHH2Y5c2e1d4fC60FwlQaS2+t7R+HGhnWYK+qsEGhcmN1KLhOC+OU08gUVhGCRKMdQOouezbm/oJYLzM7m1HPu4uqXQNqfvSS12DgVtyJ+ysCb+EVg6f4kf+gcNHaMb6ocfVPqCMZA7rvR97TvGTaMr/EelD7XZPWmr76mMNy3OBU7BUqKkRb0Y7c0qPV5NFzQRJPqBZ/L0yR1fekj0YWDAVm2xGZT3N3ZdpFHx8NjCMrIIw0PpSUHrGnaGt6nzwYYrxUftJiOXCn8DCFK0JHlb+6nn9NuN9qG5tPtWWJmqwluXjcVVUvfvrMBIH3M0IJUN2sVw46EJEBp0LJ1oi8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hcl.com; dmarc=pass action=none header.from=hcl.com; dkim=pass
 header.d=hcl.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=HCL.COM; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4bRNwDWCnwddl9hlS0GFjA+hPJvQaNHsNWAGsz7AJ/s=;
 b=YVNua0XBXyPTS1dRLo0Tv2x4HveZbTpyRHHJYLdw6j5fJmZp72QJSDrMtR3nVNDUk5yjlrzI0DVAslPtf0PNzJqkB36wTChtKiIJSKYNecDCgIhxwiEyB6wcSm4gaRpUQtmYrKQTjEDe0pKZs27SEeK7Y2q/W649OazkjsGq8X7rTk7TFE/1xGwCBX+DltqJ7oztN+9uxZ1fjXplZT6Qnp9kjAuLvTj+s3iLZAaCc82bqkaxkTjZjl9ISBfJF0hgMyA65D8znZ+TUtQrwYpJu+2/NNCr6elaAKYKXrn/bKOj9TarkPWnwRn3q1ixBo7baDRrDXmH1ufdV55JGpB+2Q==
Received: from SG2PR04MB3820.apcprd04.prod.outlook.com (2603:1096:4:94::15) by
 SG2PR04MB3819.apcprd04.prod.outlook.com (2603:1096:4:96::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4457.23; Sat, 28 Aug 2021 17:16:46 +0000
Received: from SG2PR04MB3820.apcprd04.prod.outlook.com
 ([fe80::91d9:e218:9129:b23b]) by SG2PR04MB3820.apcprd04.prod.outlook.com
 ([fe80::91d9:e218:9129:b23b%5]) with mapi id 15.20.4457.023; Sat, 28 Aug 2021
 17:16:46 +0000
From:   "Sathish Kumar Balasubramaniam -ERS, HCL Tech" 
        <b-sathishkumar@hcl.com>
To:     Jiri Slaby <jirislaby@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
Subject: RE: [PATCH] tty: serial: UART driver for RISC-V based Chromite SoC
 family
Thread-Topic: [PATCH] tty: serial: UART driver for RISC-V based Chromite SoC
 family
Thread-Index: AdebX37+Hfqi9SPcR72EV2N1dxhcdwAAY8PQACA8jgAAEt2rEAAAlBSw
Date:   Sat, 28 Aug 2021 17:16:45 +0000
Message-ID: <SG2PR04MB3820E80B2501990F1B906E8581C99@SG2PR04MB3820.apcprd04.prod.outlook.com>
References: <SG2PR04MB382047047E75CF30B8E8EA0B81C89@SG2PR04MB3820.apcprd04.prod.outlook.com>
 <SG2PR04MB3820B2DED21B7B5DB868A18F81C89@SG2PR04MB3820.apcprd04.prod.outlook.com>
 <c5ef817e-7ae9-ae93-a3c4-08fecb943c53@kernel.org>
 <SG2PR04MB3820A1CDCC0EBFCDC04B6D1181C99@SG2PR04MB3820.apcprd04.prod.outlook.com>
In-Reply-To: <SG2PR04MB3820A1CDCC0EBFCDC04B6D1181C99@SG2PR04MB3820.apcprd04.prod.outlook.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL2hjbCIsImlkIjoiOTg5NzVkMTYtYjY4ZS00ZjI5LWI4MmYtODdlNWIxZDcyNjQwIiwicHJvcHMiOlt7Im4iOiJIQ0xDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiSENMX0NsYTVzX1B1YmwxYyJ9XX1dfSwiU3ViamVjdExhYmVscyI6W10sIlRNQ1ZlcnNpb24iOiIxOC40LjE4NDMuMTIzIiwiVHJ1c3RlZExhYmVsSGFzaCI6IngzZ1c4cUFzbVUrN1QwQlNLVTNOc3hRb2JDN2RXZTVqQVU5M1Z0VmlvdFlCVFwvVUVTUG92QjRGYStGMjdZTFFvIn0=
x-hclclassification: HCL_Cla5s_Publ1c
Authentication-Results-Original: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=hcl.com;
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: 4b97eb7e-935e-4240-9fbc-08d96a479fc8
x-ms-traffictypediagnostic: SG2PR04MB3819:|TYAPR04MB2384:
X-Microsoft-Antispam-PRVS: <TYAPR04MB23847CA54F558A7D8529194C81C99@TYAPR04MB2384.apcprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 3TYrHlfSQURYWW2ZauiGmor/BsoBtFMfMvwRaIqyBluJJVXbtHTQSNlL3JLTsYEwhD9QyK+9JBw3TAKWTJJUEK9snCIB3RsYmokGFuK7V6bXX2Ou+7JM5JwEwq0f4QqXEfTbhQmLl1nlCtAG8v8EEGa8d5g5lyM06loPddekSGZ/6JcLEVzM3jLukCc1aV/eFL6OPxtgIIJhosu2gRhiMcAJ/kHGTa579P+rrS5BcidHttEk8OFARvGrekoH86e8XiemsZhCnb1xBXCXtUyJ3J6gDzXBbDWsj1XN+z45ta3I5wFOtA+5bNMO5EF0rDoGPpQ9YbuS/fVIgLULkDxeQK+S9S8fQm8vHyrrlkF4HHoDIoy355nNLRTiN9+VNptMrs53FC4rNha4esTdk8tVxmNoT4gtRGgXLiz2MFvSVvvjZJ14i1ZhnfUTbL/ghte4DmFLJKQr7W83xQIgkLgQrIhAIuNz0VA1r2d/bQMqELfoN+tItUFiRws/TtzbSVA9UnK8vXUgbwZu/+3vUtLLmICAWl4arSMgj+UvdNbHV3NG/YgBulnfb58MOO0QY/flEsQ8OuVtOdwpZbwBIXW0qS7xPAhrDzma72frKOa/ZEWwInt0WRPApXgXzxrc3ZgebBuMFrCpVOiGmTyMKvkI0P23VzwydxJMXzOXHf1Ra2twEWN6embKfoGVSDH3zFXOXh8KTOEiPyXpRELvuTZzVg==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR04MB3820.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(346002)(366004)(376002)(39860400002)(316002)(9686003)(66476007)(66946007)(76116006)(64756008)(66556008)(66446008)(7696005)(2940100002)(71200400001)(83380400001)(122000001)(52536014)(38070700005)(26005)(8936002)(110136005)(86362001)(6506007)(5660300002)(33656002)(4326008)(2906002)(478600001)(186003)(8676002)(38100700002)(55016002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a2d1NHdNcXl6WVNYeWpXMXdqY0NKSWVkcGZQMldIM0VCd2RsNVpXWlhETnZr?=
 =?utf-8?B?K09McXBvd3lQRmc3aExjQU82V2EvaHZXQURkUGF1MVBPYTVneXlFa0RpaS81?=
 =?utf-8?B?TUJJbngxVTI4M1dKQngrVkduWCtGZTluSjdxM3crODNWWTR1eU44T3crbkdU?=
 =?utf-8?B?eHljNlR6a2oxc3B6NVNraUUwTWJDYldtL3EvSVR0OCtiRjZHdDJTOS9kS2o0?=
 =?utf-8?B?NkdFUUZRd21zaW1nYnU0RGFNNmxMemd0d2lFdHp5Ry8ybWdabEVDdWU4QUZM?=
 =?utf-8?B?cFd1N2dpeWlpdVREaDB1TWxsUjd2bXI0SzdhdTBHY25RWVRLbWM1THMwaTNH?=
 =?utf-8?B?ckpMSEhEa0dVYkpGMEhCcjF5Vmx0RWhpM1drREdLMGIvSmZxa3k5azd6dCtO?=
 =?utf-8?B?MWJhQ0NPVFA1cW1yb21ybWdrUVhUc0ZKMHpnSmRpT2ZJWVpOdmxVLzVueVRE?=
 =?utf-8?B?YWlyMmMxYlhsbFFjRW13RFRiUmZjbzY1K3JHVUhUQ0p1cjZqT3JhVmJtWENP?=
 =?utf-8?B?Q3VmOHFIUDY5REZKVFEvRHlPVkZvQWRnYzNrWElkZVpiYlpjU3BOaXBtWis0?=
 =?utf-8?B?QmhQeXY2TEVTcm0xSVhRK05WWW8yL0s2RGdSaExCVjBpZVdKOU10V0dEck9q?=
 =?utf-8?B?dXY0bkdNYXRJYWRxdGRBZitYZG1FWDVvWFJuNGxMS0RHeTI1UXRBM3pZYjFh?=
 =?utf-8?B?Qlk3ZUw5SjhNdFduZEdZd25ES2pRNmI4MW1HWm1PYVY5a2JqejFQRTluNDBW?=
 =?utf-8?B?Z2huelZEay82QXNkZjJPZHB0N0g5SGtrQk1YWkdDYndFbGRlODgzQmV3RS9w?=
 =?utf-8?B?NkQrTHQvaC9UZTZBMHlTUVRxazFWdXoweXEwQ3huZkUvZmJ2U1VHU3V6OTF6?=
 =?utf-8?B?TzZSc2lhdHhNNTVMWi96MnNzYVFKZGVPM3psdS8xb1BDek12bVRrTW5VVWxL?=
 =?utf-8?B?cmwvWVM5czBYWmpEK2dXYWZ5VXZXeVVYckJXOGt1U1lwOWRnZy9EclVWLzha?=
 =?utf-8?B?VXZhZ0VBcDNwRndxMmJ1cEl4b0pJcWJtSExVaW5BSFJwTXlWMEhJb0Vzamg4?=
 =?utf-8?B?ZnZPdDNoOVVNZlBJdkNPVkdMMERLd3o3VzUrT1hVdmMwVkR4S2ZuWURTRWgz?=
 =?utf-8?B?dWNnSkRUU05DMFV2L3pqb1UwbWVFL0NDM25RSklXM3pwZmZXY0NQcmlwc3h5?=
 =?utf-8?B?SkdCUWF1MGwwKzdzSTdNVVJubW50djlpUHVJL2NlVWJZelJMc05haElCREVC?=
 =?utf-8?B?NERwWGZKeWRpN1RHWUdJd29ucDhyd2VJZmtzeVJkekNTcEZ6V3FsODVnYy9a?=
 =?utf-8?B?UmdZVlBabHB3UlJiUnRSMGtaN0hKOWdvQzVYb1JRWlJFcm1lN0VmYTNTRVgy?=
 =?utf-8?B?TG52RmNScS9KUzkzVXdHRGY2Mkg3ME9HbFcveUVwbm9UdG1WSzZpWEJvaGQv?=
 =?utf-8?B?YVdsd3pjTDRnOUFvSE1FWkpldXdpS3I0QW16VXpBOEZWUFh6UkdPNjF2VmNu?=
 =?utf-8?B?TURXR05PMHY4S0ZJOWliYi9QeWp5VmMvLzVzMnVQcm05OWVOWjJwaHE1RDZ6?=
 =?utf-8?B?STA4YkhVVVZZYzBYR0Fpdm9sYzhDNnhJZ2pRNk4zU3EyV1gya2dUT01tL3Zp?=
 =?utf-8?B?YXJ6Y3ZSKzczMCtBOGZYRjlObWl3R0pjaTBJSXZvSWZDMnJNOUVrbi91Vk5o?=
 =?utf-8?B?T21pakNHY1NqQWJSTkZnKzZQcDlERGNWTXNjZVhsR2pEQXZlVjdDTlJLN0hB?=
 =?utf-8?Q?RPaBhvM12BegIJQBFujAX/iTOPQP6MEUPpsWPnJ?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR04MB3819
X-DLP:  MSGProcess
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: SG2APC01FT013.eop-APC01.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: 3ec7c0a0-ad91-4f9c-72da-08d96a479d27
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8pcsfEpA+WsJkuszexJGnH6/nuNq2or+HKhh/hdDE6qttpkR4YYdHkxdA+lPxDQcZl+PA7PyoO0x8rUtTFyHwL4AcUapFTQK8spbPrRV3k+8DDNRwAVn+LuMkSTFK03RLf19lkhRvctdk2AC8UO3BXQ0D/1ZFwbftJ4+tXxEZFO0l5dzU23fVwfknQs7lF6UapRUDvvFOppcYWUKNOmmToQYLEUnm9qM0ZNIoDTZ/pzVCI7tEambndSfgboBeJbqLzP0GESINsKcV15Djs3VHyJnVUdSmStlMZVQLQY+NlquZU0IrWdgt2PTxoJr9bSFUSHJAL9ws85Yilo4l+PCIHfTjdi2PBN+lCvBZZUAb1vYj7hkRHfgrFh2nQGsbn2+pL9lV8yrugtzUFNfcT5XBCNnyh+6DuRZ+7+6z6RcokDKxSh5Ld6y/Vyix+hityVtFv+MKEWROezmKyvATgZZ0uKMtNAIEukQy4ETklTGJ1kU9DNu1Pespl51U76im4/P6sJgMqUGQYu3vpS6mfnj/5LAnVmWEHWNK/aG5q3gGtxxrO0C5ZE5BWUyXTnailZPhkmdSu/Qb/uvQKcGpeIbmvCmXO926fJwpDRuao1wLWZvSNYWtTL1iOARxbngO9A038p3xfAidpgDR7KJgoN0CRAj3SnemfRGIFaWQYIfO6VOI5STVByGO/UPAdTMtc0cinYvpKXf6jejJFaCm0XLDjRzuoMaRe0dqQxFiXKdAm+P2EXiAWKqsyymiog332KuRbZ11qPfQ6eBDMBLl+/vrA==
X-Forefront-Antispam-Report: CIP:192.8.245.52;CTRY:IN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:APC01-SG2-obe.outbound.protection.outlook.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(396003)(39860400002)(136003)(346002)(376002)(36840700001)(46966006)(33656002)(36906005)(83380400001)(6506007)(82310400003)(81166007)(4326008)(9686003)(5660300002)(2940100002)(55016002)(7696005)(70206006)(70586007)(2906002)(47076005)(186003)(36860700001)(8676002)(316002)(478600001)(52536014)(82740400003)(26005)(86362001)(8936002)(110136005)(336012)(356005)(34020700004)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: HCL.COM
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2021 17:16:50.3814
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b97eb7e-935e-4240-9fbc-08d96a479fc8
X-MS-Exchange-CrossTenant-Id: 189de737-c93a-4f5a-8b68-6f4ca9941912
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=189de737-c93a-4f5a-8b68-6f4ca9941912;Ip=[192.8.245.52];Helo=[APC01-SG2-obe.outbound.protection.outlook.com]
X-MS-Exchange-CrossTenant-AuthSource: SG2APC01FT013.eop-APC01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR04MB2384
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Q2xhc3NpZmljYXRpb246IFB1YmxpYw0KDQpIaSBKUywNCg0KR290IHRoZSBmdW5jdGlvbiBvcGVu
aW5nIGNoYW5nZSBhbmQgd2lsbCBkbyBpdC4NCkJ1dCBjb3VsZCBub3QgdW5kZXJzdGFuZCB0aGUg
bWVhbmluZyB3aGljaCB5b3UgYXJlIHJlZmVycmluZyBieSBtYW5nbGVkIGxpbmVzLg0KUGxlYXNl
IGNhbiB5b3UgZXhwbGFpbiB0aGUgaXNzdWUgZm9yIG9uZSBwbGFjZSBzbyB0aGF0IEkgd2lsbCBk
byBmb3IgYWxsDQoNClRoYW5rIHlvdS4NCg0KDQpPbiAyNy4gMDguIDIxLCAxODozMiwgU2F0aGlz
aCBLdW1hciBCYWxhc3VicmFtYW5pYW0gLUVSUywgSENMIFRlY2ggd3JvdGU6DQo+ICtzdGF0aWMg
dm9pZCBjaHJvbWl0ZV9zZXJpYWxfc2V0X3Rlcm1pb3Moc3RydWN0IHVhcnRfcG9ydCAqcG9ydCwN
Cj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0
IGt0ZXJtaW9zICp0ZXJtaW9zLA0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBzdHJ1Y3Qga3Rlcm1pb3MgKm9sZCkgew0KPiArICAgICAgIHN0cnVjdCBj
aHJvbWl0ZV9zZXJpYWxfcG9ydCAqY3NwID0gcG9ydF90b19jaHJvbWl0ZV9zZXJpYWxfcG9ydChw
b3J0KTsNCj4gKyAgICAgICB1bnNpZ25lZCBsb25nIGZsYWdzOw0KPiArICAgICAgIGludCByYXRl
Ow0KPiArDQo+ICsgICAgICAgaWYgKCh0ZXJtaW9zLT5jX2NmbGFnICYgQ1NJWkUpICE9IENTOCkN
Cj4gKyAgICAgICAgICAgICAgIGRldl9lcnJfb25jZShjc3AtPnBvcnQuZGV2LCAib25seSA4LWJp
dCB3b3JkcyBzdXBwb3J0ZWRcbiIpOw0KPiArICAgICAgIGlmICh0ZXJtaW9zLT5jX2NmbGFnICYg
Q1NUT1BCKQ0KPiArICAgICAgICAgICAgICAgZGV2X2Vycl9vbmNlKGNzcC0+cG9ydC5kZXYsICJv
bmx5IDEgc3RvcC1iaXQgaXMgc3VwcG9ydGVkXG4iKTsNCj4gKyAgICAgICBpZiAodGVybWlvcy0+
Y19pZmxhZyAmIChJTlBDSyB8IFBBUk1SSykpDQo+ICsgICAgICAgICAgICAgICBkZXZfZXJyX29u
Y2UoY3NwLT5wb3J0LmRldiwgInBhcml0eSBjaGVja2luZyBub3Qgc3VwcG9ydGVkXG4iKTsNCj4g
KyAgICAgICBpZiAodGVybWlvcy0+Y19pZmxhZyAmIEJSS0lOVCkNCj4gKyAgICAgICAgICAgICAg
IGRldl9lcnJfb25jZShjc3AtPnBvcnQuZGV2LCAiQlJFQUsgZGV0ZWN0aW9uIG5vdA0KPiArIHN1
cHBvcnRlZFxuIik7DQoNCk1hbnkgbWFuZ2xlZCBsaW5lcyBsaWtlIHRoaXMuIFBsZWFzZSBmaXgg
dGhlc2UgdXAgaW4gdjIuIEFuZCBhbHNvIHVzZSBjaGVja3BhdGNoLiBUaGUgZnVuY3Rpb24tb3Bl
bmluZyB7IGFib3ZlIHNob3VsZCBiZSBvbiBhIHNlcGFyYXRlIGxpbmUgKG9uIG1hbnkgbG9jYXRp
b25zKS4NCg0KdGhhbmtzLA0KLS0NCmpzDQo6OkRJU0NMQUlNRVI6Og0KX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18NClRoZSBjb250ZW50cyBvZiB0aGlzIGUtbWFpbCBhbmQgYW55IGF0
dGFjaG1lbnQocykgYXJlIGNvbmZpZGVudGlhbCBhbmQgaW50ZW5kZWQgZm9yIHRoZSBuYW1lZCBy
ZWNpcGllbnQocykgb25seS4gRS1tYWlsIHRyYW5zbWlzc2lvbiBpcyBub3QgZ3VhcmFudGVlZCB0
byBiZSBzZWN1cmUgb3IgZXJyb3ItZnJlZSBhcyBpbmZvcm1hdGlvbiBjb3VsZCBiZSBpbnRlcmNl
cHRlZCwgY29ycnVwdGVkLCBsb3N0LCBkZXN0cm95ZWQsIGFycml2ZSBsYXRlIG9yIGluY29tcGxl
dGUsIG9yIG1heSBjb250YWluIHZpcnVzZXMgaW4gdHJhbnNtaXNzaW9uLiBUaGUgZSBtYWlsIGFu
ZCBpdHMgY29udGVudHMgKHdpdGggb3Igd2l0aG91dCByZWZlcnJlZCBlcnJvcnMpIHNoYWxsIHRo
ZXJlZm9yZSBub3QgYXR0YWNoIGFueSBsaWFiaWxpdHkgb24gdGhlIG9yaWdpbmF0b3Igb3IgSENM
IG9yIGl0cyBhZmZpbGlhdGVzLiBWaWV3cyBvciBvcGluaW9ucywgaWYgYW55LCBwcmVzZW50ZWQg
aW4gdGhpcyBlbWFpbCBhcmUgc29sZWx5IHRob3NlIG9mIHRoZSBhdXRob3IgYW5kIG1heSBub3Qg
bmVjZXNzYXJpbHkgcmVmbGVjdCB0aGUgdmlld3Mgb3Igb3BpbmlvbnMgb2YgSENMIG9yIGl0cyBh
ZmZpbGlhdGVzLiBBbnkgZm9ybSBvZiByZXByb2R1Y3Rpb24sIGRpc3NlbWluYXRpb24sIGNvcHlp
bmcsIGRpc2Nsb3N1cmUsIG1vZGlmaWNhdGlvbiwgZGlzdHJpYnV0aW9uIGFuZCAvIG9yIHB1Ymxp
Y2F0aW9uIG9mIHRoaXMgbWVzc2FnZSB3aXRob3V0IHRoZSBwcmlvciB3cml0dGVuIGNvbnNlbnQg
b2YgYXV0aG9yaXplZCByZXByZXNlbnRhdGl2ZSBvZiBIQ0wgaXMgc3RyaWN0bHkgcHJvaGliaXRl
ZC4gSWYgeW91IGhhdmUgcmVjZWl2ZWQgdGhpcyBlbWFpbCBpbiBlcnJvciBwbGVhc2UgZGVsZXRl
IGl0IGFuZCBub3RpZnkgdGhlIHNlbmRlciBpbW1lZGlhdGVseS4gQmVmb3JlIG9wZW5pbmcgYW55
IGVtYWlsIGFuZC9vciBhdHRhY2htZW50cywgcGxlYXNlIGNoZWNrIHRoZW0gZm9yIHZpcnVzZXMg
YW5kIG90aGVyIGRlZmVjdHMuDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0K
