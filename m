Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96484C432BE
	for <linux-serial@archiver.kernel.org>; Sat, 28 Aug 2021 16:55:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81C8B60EAF
	for <linux-serial@archiver.kernel.org>; Sat, 28 Aug 2021 16:55:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbhH1Qz4 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 28 Aug 2021 12:55:56 -0400
Received: from mail-eopbgr1290120.outbound.protection.outlook.com ([40.107.129.120]:6322
        "EHLO KOR01-SL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229518AbhH1Qzz (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Sat, 28 Aug 2021 12:55:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=HCL.COM; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KcT4vZfpfBnLMSFVfSBjwHgOYZIo7W1tGd5TbKro23Y=;
 b=KkIKxGDwhtVXTZq9cn7O4umqhCGOxkXYn/okP/ttcMXUvM2mhQ7zdxzOz9WcGoYM2c4mJiZ1YXHJGnhv49sUi7WIgMKzAdENU4HMfe6cmV42pLJplrX1bUuDSHk9U6Nn/dnoNXOzDckIua6RQVolnk/3doo21wQzT5agoZVsrEqzPnYSFZ9ovMHvniq2lALP+3ezM4AUqt4mPBHadkPP9dgGyMyY+hD4yLozodI65ISD1+xQx+qIpPwRCAsbNyCAx0IcNvFi4o8FTvfkT5fIgwIiF/B3AD+UqJuC0wvbcwRFOaBizQpWeY+vKSIIY6v54YlNKy1etSywWr6kbyBKKw==
Received: from SG2PR02CA0013.apcprd02.prod.outlook.com (2603:1096:3:17::25) by
 PS2PR04MB3861.apcprd04.prod.outlook.com (2603:1096:300:69::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4457.17; Sat, 28 Aug 2021 16:55:01 +0000
Received: from SG2APC01FT028.eop-APC01.prod.protection.outlook.com
 (2603:1096:3:17:cafe::bf) by SG2PR02CA0013.outlook.office365.com
 (2603:1096:3:17::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.18 via Frontend
 Transport; Sat, 28 Aug 2021 16:55:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.8.245.54)
 smtp.mailfrom=hcl.com; linuxfoundation.org; dkim=pass (signature was
 verified) header.d=HCL.COM;linuxfoundation.org; dmarc=pass action=none
 header.from=hcl.com;
Received-SPF: Pass (protection.outlook.com: domain of hcl.com designates
 192.8.245.54 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.8.245.54; helo=APC01-HK2-obe.outbound.protection.outlook.com;
Received: from APC01-HK2-obe.outbound.protection.outlook.com (192.8.245.54) by
 SG2APC01FT028.mail.protection.outlook.com (10.152.250.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4457.17 via Frontend Transport; Sat, 28 Aug 2021 16:54:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aAWS+3fYgtyym00OKp/9sCqRFcwnwhQa/jJ+Je9EAn2LLWsPKj9Rb0842NF4VZ52/9BaqGu0++nYCQjeeFVm8rU94eDDMs1AgxP+YurHnHCJ6mIIY6Losb3yadSItUYPNVEmDL2wdjD2BdVP60C+VOt3PEQVvWgMPyrK6US2xg7ubNx4tK6QKVkAYNZ/Ei9ONGWb8PVKq3j+woqsPTni9lRRHBHEOIh2C6+jI/ERpvCC/86nVD3EiXOtkaF/c/1yCrZWZb1TRlLSDIro4gRzEfmC3r3Pmwq6ez4lt4Bq76HA9f1BELo7bvqSUuz/KJ/WA6H6dTsXNEgcBMxlR5agDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KcT4vZfpfBnLMSFVfSBjwHgOYZIo7W1tGd5TbKro23Y=;
 b=RRwrqS+1Fa8PKg6P0BzY387VLpShhIUnUNuM2qTDt+GltdDC68wVz9DlF4xbJGgP72dYaylpvt5+qr9aDdDvVk6+Z9CXQayrJ1EiayVzrVaqQSbLwgoGXrWTB/vzpXS8TnWJspCsLJO8CvJ6inm4IKI8mbC1tVCNk7j2v9onG5DnukkvbStNHU0FKPbRiQVdP92Qsa6JFRCF2T4Wzr0HwJ1yv0EIQjO/p7MdJ70yEiRHXVJ13Pa3GAh/nE7xWM2LxKAtKEDViQMBG0MYB2hU2zIpFqlgpshBHDdbhm2qTRkeL6V91Mg5tPWl2X7Qy9A4eG3won505eih8UFaqCPKOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hcl.com; dmarc=pass action=none header.from=hcl.com; dkim=pass
 header.d=hcl.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=HCL.COM; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KcT4vZfpfBnLMSFVfSBjwHgOYZIo7W1tGd5TbKro23Y=;
 b=KkIKxGDwhtVXTZq9cn7O4umqhCGOxkXYn/okP/ttcMXUvM2mhQ7zdxzOz9WcGoYM2c4mJiZ1YXHJGnhv49sUi7WIgMKzAdENU4HMfe6cmV42pLJplrX1bUuDSHk9U6Nn/dnoNXOzDckIua6RQVolnk/3doo21wQzT5agoZVsrEqzPnYSFZ9ovMHvniq2lALP+3ezM4AUqt4mPBHadkPP9dgGyMyY+hD4yLozodI65ISD1+xQx+qIpPwRCAsbNyCAx0IcNvFi4o8FTvfkT5fIgwIiF/B3AD+UqJuC0wvbcwRFOaBizQpWeY+vKSIIY6v54YlNKy1etSywWr6kbyBKKw==
Received: from SG2PR04MB3820.apcprd04.prod.outlook.com (2603:1096:4:94::15) by
 SG2PR04MB2636.apcprd04.prod.outlook.com (2603:1096:4:5c::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4436.19; Sat, 28 Aug 2021 16:54:57 +0000
Received: from SG2PR04MB3820.apcprd04.prod.outlook.com
 ([fe80::91d9:e218:9129:b23b]) by SG2PR04MB3820.apcprd04.prod.outlook.com
 ([fe80::91d9:e218:9129:b23b%5]) with mapi id 15.20.4457.023; Sat, 28 Aug 2021
 16:54:57 +0000
From:   "Sathish Kumar Balasubramaniam -ERS, HCL Tech" 
        <b-sathishkumar@hcl.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Jiri Slaby <jirislaby@kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
Subject: RE: [PATCH] tty: serial: UART driver for RISC-V based Chromite SoC
 family
Thread-Topic: [PATCH] tty: serial: UART driver for RISC-V based Chromite SoC
 family
Thread-Index: AdebX37+Hfqi9SPcR72EV2N1dxhcdwAAY8PQAAHqigAAMK3wYA==
Date:   Sat, 28 Aug 2021 16:54:57 +0000
Message-ID: <SG2PR04MB3820BCE0081CA82968776AE381C99@SG2PR04MB3820.apcprd04.prod.outlook.com>
References: <SG2PR04MB382047047E75CF30B8E8EA0B81C89@SG2PR04MB3820.apcprd04.prod.outlook.com>
 <SG2PR04MB3820B2DED21B7B5DB868A18F81C89@SG2PR04MB3820.apcprd04.prod.outlook.com>
 <YSkgWpZnZXhv6PYD@kroah.com>
In-Reply-To: <YSkgWpZnZXhv6PYD@kroah.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL2hjbCIsImlkIjoiYzQyYTE2MzItZjA0OC00NWNjLWI2Y2ItMDkxMTE2ZjY3OWVmIiwicHJvcHMiOlt7Im4iOiJIQ0xDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiSENMX0NsYTVzX0MwbmYxZGVudDFhbCJ9XX1dfSwiU3ViamVjdExhYmVscyI6W10sIlRNQ1ZlcnNpb24iOiIxOC40LjE4NDMuMTIzIiwiVHJ1c3RlZExhYmVsSGFzaCI6Ijg3UFB0bTNyT25UNm1XUHFYMVZCaDhXc0U3MnUrSGFlRFVGS2ZJSUpEYXFIWHJWT1h6Z1pZeGFPTGlxTFg0YSsifQ==
x-hclclassification: HCL_Cla5s_C0nf1dent1al
Authentication-Results-Original: linuxfoundation.org; dkim=none (message not
 signed) header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=hcl.com;
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: e12efd73-6249-4dcf-448a-08d96a449300
x-ms-traffictypediagnostic: SG2PR04MB2636:|PS2PR04MB3861:
X-Microsoft-Antispam-PRVS: <PS2PR04MB386142E56CA6D5F81C624A6A81C99@PS2PR04MB3861.apcprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: YS5lOs0k5jgbaWPTkPu6d2eKZ4T7ejWaKrBAtImSA6Z7SsZssI6V1j+fjP16a5CayBhkzxg3JqkAci+Y0dar91uA75/wd/npL4VMb5xAWVvApfghv/Az7FBQWr4FgckPcyHCf1D9O4iBivrgdXDkQlTLeVx4RzN2SSCdeSFye7KylzJ16JvfUhKj6PGTvtPUGjkBFcSu5rEJumTmvAP6q0Po9Mc9oba7s1ZIf/YEi90JRtmv02yGbsPRNAg+yZR7qyDPMrqdafejr5DmLZKaOrLoiIBfMoSIjCFcDFF2qsnb3HyjFU87a2aIwkwqrGdNzeQvoQTOm4VxDpFyirJI/cBEuvypwSVYaX7ijqNEJJvMr4yQdJ4zaIRTMIAKtixbNu8KHHzthDIsKpZY0cadoIRsidz3bLG2/A0m5Y3C2V6mzMeqs0LocOFZwPohu+q2rvLfLgze8IdfQ5aKJpcJrSBi4BxU58uTGxuJPYi+g+O757wMQoFA8e49lJXx4UBOHyMysvdRMXGRKbPzPl9yMB7V25UEubjynlgZVlkdvzBCVmcUh7fRIEsQgT4zhJgrsubOWD81kOQ732VSS8j/zcj+TVoXm0A55/ZrFbEPEIue88GtqQVT/6QaUrYCMpesJiv65osFhelwnoFqltlFSlb1eJRdmKlRUIHDkHp3TpV7xC+kxMde1Psz2lvVqNOzxk2QNqwJDjVHqVKPv0+xRA==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR04MB3820.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(376002)(39860400002)(136003)(366004)(9686003)(26005)(66946007)(8676002)(71200400001)(53546011)(7696005)(33656002)(2906002)(66476007)(76116006)(5660300002)(64756008)(6916009)(316002)(54906003)(4326008)(6506007)(8936002)(186003)(55016002)(83380400001)(38070700005)(52536014)(86362001)(478600001)(66556008)(122000001)(66446008)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R3pSRlFhMmE3OER3aUlkODl0aXh1Q2NtWFlXcWZjMkJZWlp4Y1pUVDhWU1hI?=
 =?utf-8?B?WHhPODhPbWlJbUpMSTIwN0FMZGV3SUcwWWN0QmU1Y2kzbUw3cjNhYU1rMktK?=
 =?utf-8?B?bUNXdFYvbkU2STdiakdxUDJ3NDNZcnZvTVlJZ0lpNVRpa2JLeFBSRUNUVks2?=
 =?utf-8?B?U1RpaVpNSXpGd20wRXFPTi9kZkNyWE5BbVVXWkVwcmY4T0kycDJoOG9EWnRM?=
 =?utf-8?B?Vkxlb3Q5bGRaUytxeVVBKy9kZ1Jjd3RkKy9xTm1MaXNoM2VoMEh3N3dUbUdE?=
 =?utf-8?B?cUZYVlFUcEpsYWJNNnFPQ1V3NUx6Q1FEUzNaMnlFQXRoZ1krMGc5LzBBLzdB?=
 =?utf-8?B?UmRWb1Z6VzcwdUVQVkNLYmZQaHdvdHE2OVBrSkZUTWE5ZStkMnUyQXNzRXFT?=
 =?utf-8?B?WmxHYkFabTRScFdxQXNDak1iQTdkbERSMnRzV04rVGg0bks2cm1lNThUenll?=
 =?utf-8?B?YXpXaWMwZXVRdVBwUlZuKzMyOG9tTEZuNFhwN1B4S2R1b0RiY3pEUHN4aitP?=
 =?utf-8?B?RzYvbjlsRDhUcnJkNDBENWVVbnR1OWEyUTJvbzZlYlRiK2ZNTlhYRk1wU1JH?=
 =?utf-8?B?VmhIdGlUQTNwUzFRa0t2NnYzWXdxNEpRS1l4WkJFb2VLL1MxaFBVMDBURXVX?=
 =?utf-8?B?VlFkcC93cjRTb3pOcjhDOUdTd1dyMzU3bENmbmVna255YllkQUp1dFdnaW9X?=
 =?utf-8?B?ZytKSk5HU1Jha2poWjVnd1FCMUMyVXg0cEJVR0lJUWoydkNZaHdNNkZBZkRQ?=
 =?utf-8?B?ZGUvaE8rN3F2OXQvUFNIQmdvbVVxNnpMWkttenpEVUFDZFFaUmVxMDk1c0FT?=
 =?utf-8?B?Zlhsazdxa1ZSRVhLb21xQWErSWhGK0t1dDFmOG5RVzZuRWx1emZXc3ZtSm9O?=
 =?utf-8?B?Wk5wR2Q2Z3VFVnhjWHN1OHhXaTFNUmVrUUtGdGNRNk1tNWE0MEJHc1lydVNw?=
 =?utf-8?B?NVpIZTI3dXkxSW5rSWo1QnluUkQvQzJuajBFOXlyZDd2WmQxN0tPTDhzcDVL?=
 =?utf-8?B?WGFRWWxpdGxYTzdNSTBxa0pTUkFBdFlybW91Mk9sb1pQK1ovTHVUQ0paWlow?=
 =?utf-8?B?Z0lQT3VkY1hUaG9UamptSkVhY1Y2cE96UVMva0Z2T3l1ODI1UnhicmpPeVdq?=
 =?utf-8?B?SFI4UkJNTFE3WkJlZWR3dW5DOVVUbjZDeTcyc0s4aFNLWldCaWQyQ1JwSk1p?=
 =?utf-8?B?d1l2ZkVrMURIaGtLZVFHYXNJaWN1SXBDNHIvNk0zTEdHYnQ4aHF4UXBaZWZh?=
 =?utf-8?B?TnJreDFoUDBtcW1jQlhvd1pocFNMclhhY3c0K1dSNXA3WVB5SEVUekt6eU1y?=
 =?utf-8?B?OG5zYjdkNHhLTFhOZVhGLytUQkFUaGpxemlwdENPbDFvU3BHR1piN0RtQmtJ?=
 =?utf-8?B?YVZIVFZ2L2VVUGQyanBrUU9zU0dpeXVmbmlaUUU1RFBEbFpYTDFBOEJJcWEv?=
 =?utf-8?B?TmdwL2M0WlpsZkRVanNmN0xON3RHYlBxTXJTKzhMeU5QWUtCV1dpUFBBV1l6?=
 =?utf-8?B?WEs1ZWZCMHRQSE5OMUZMamZCRHhtOE11R0JXU1Q3d0FqRHhCMmpKSGhoV1Nu?=
 =?utf-8?B?eFNPVlFXR2RlcXJIT0NQTDl6Um9qWGVNZHZJeDJBMDJlNlY1Mm13b2J0eUFx?=
 =?utf-8?B?b1ZkZnBSWmNmbzhVTDgwUWVKTU5YMThQdHdkaUtnVyt5Y21sZXdEcFRnQzJR?=
 =?utf-8?B?VHppekRCNGp0NWVkUEVSZEl6OXpmdWFuai8yT3E3ekZIY2dmdW0wa1owcnlo?=
 =?utf-8?Q?2/qypoKWfDHVBy5rW825RccpbnmBMALqjpXKg8Z?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR04MB2636
X-DLP:  MSGProcess
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: SG2APC01FT028.eop-APC01.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: 180ace54-d938-4af2-025f-08d96a44915d
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uM0AcHwpbHaWxnUAOWQ0t1QD1wj5gi8R2d6YxNnmVjnNtAEdAQustue4CFNb+mdJw055tt9OVaYHnPnbIT/rYaqPdsK3iB3ns7CPm8W4ZVc9FhL6JxUWOX1X/Xm4emAPwBySpJybg8e1OpSXJLLfqFQ662rTdYQcICw3LaI8BECP+vb4x/MsgUsxIOYR/12HoHL5bCrvw+18WCKa4C1Yxv2tMBnG1ogRBi2p8HwwfkIGHhlhgud8ccQYd0Vbg1Jj+mFDBn4P+oMiJ3keE6Nt4zxRqMQJRqisvqej5Ly7zM38u+620grjawUo1NjoSTJfdJL6zWL2k8n6ii7xBM1kt3mJBNkdEYklPJqDFE4g3VgOSJGW1JhjbiCS7ThmiMStmWnVeNHqef9evpH/CaFMb5oFG+lun5WVGdtvQqJ7mm59FEaYQj1rA4TN/12/01mXqT0xW8jajNmrMCISclkjJ8Q5FWnGOre0vofk25oOeFD1jdTEFV3QUYjZ7PzvdTD4f+eneNx/xnezQoivGks/vnptmr/9pNjx1LPCRI1R862oaV7j9vOA5TobRizvkkfTZSr8XonhivXMYMMO63rVa24b5t+7u7X0uN2MLI9XA7oyK0pSaJT7ld4q/3mG10/SG2PTT0HeyP6CYII1Scwo7vIX5Z15lUJtjzWnUpscSvvnuv+4CYuI+TMoCQB8pZxKkanGIwTcIVDr/HZzQSUg8o9o/HBZvoHjR6qgPAlIThytofGvKh/8oxadwjrzi+byIKUfmFq7e7R1KFNZsZ24KQ==
X-Forefront-Antispam-Report: CIP:192.8.245.54;CTRY:IN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:APC01-HK2-obe.outbound.protection.outlook.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(39860400002)(136003)(346002)(376002)(396003)(36840700001)(46966006)(6506007)(4326008)(7696005)(83380400001)(52536014)(2906002)(82310400003)(53546011)(8676002)(478600001)(86362001)(33656002)(336012)(70206006)(186003)(81166007)(9686003)(47076005)(70586007)(82740400003)(5660300002)(54906003)(26005)(55016002)(34020700004)(356005)(36906005)(6916009)(36860700001)(8936002)(316002)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: HCL.COM
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2021 16:54:59.9034
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e12efd73-6249-4dcf-448a-08d96a449300
X-MS-Exchange-CrossTenant-Id: 189de737-c93a-4f5a-8b68-6f4ca9941912
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=189de737-c93a-4f5a-8b68-6f4ca9941912;Ip=[192.8.245.54];Helo=[APC01-HK2-obe.outbound.protection.outlook.com]
X-MS-Exchange-CrossTenant-AuthSource: SG2APC01FT028.eop-APC01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PS2PR04MB3861
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Q2xhc3NpZmljYXRpb246IENvbmZpZGVudGlhbA0KDQpTb3JyeSBmb3IgdGhlIGluY29udmVuaWVu
Y2UuIFRoZXNlIGNsYXNzaWZpY2F0aW9uIGFuZCBkaXNjbGFpbWVyIGFyZSBhdXRvbWF0aWNhbGx5
IGFwcGVuZGVkIHRvIHRoZSBtYWlsIHdoaWxlIHNlbmRpbmcgd2l0aG91dCBteSBjb250cm9sLg0K
SSB3aWxsIGNoZWNrIGZvciB3YXlzIHRvIGF2b2lkIHRoaXMgKG9yIHdpbGwgdHJ5IHNlbmRpbmcg
dGhlIHBhdGNoIGZyb20gbXkgZ21haWwgaWQpIGFuZCByZXNlbmQgdGhlIHBhdGNoLg0KDQpUaGFu
ayB5b3UuDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBHcmVnIEtyb2FoLUhh
cnRtYW4gPGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnPg0KU2VudDogRnJpZGF5LCBBdWd1c3Qg
MjcsIDIwMjEgMTA6NTcgUE0NClRvOiBTYXRoaXNoIEt1bWFyIEJhbGFzdWJyYW1hbmlhbSAtRVJT
LCBIQ0wgVGVjaCA8Yi1zYXRoaXNoa3VtYXJAaGNsLmNvbT4NCkNjOiBKaXJpIFNsYWJ5IDxqaXJp
c2xhYnlAa2VybmVsLm9yZz47IGxpbnV4LXNlcmlhbEB2Z2VyLmtlcm5lbC5vcmcNClN1YmplY3Q6
IFJlOiBbUEFUQ0hdIHR0eTogc2VyaWFsOiBVQVJUIGRyaXZlciBmb3IgUklTQy1WIGJhc2VkIENo
cm9taXRlIFNvQyBmYW1pbHkNCg0KW0NBVVRJT046IFRoaXMgRW1haWwgaXMgZnJvbSBvdXRzaWRl
IHRoZSBPcmdhbml6YXRpb24uIFVubGVzcyB5b3UgdHJ1c3QgdGhlIHNlbmRlciwgRG9u4oCZdCBj
bGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIGFzIGl0IG1heSBiZSBhIFBoaXNoaW5nIGVt
YWlsLCB3aGljaCBjYW4gc3RlYWwgeW91ciBJbmZvcm1hdGlvbiBhbmQgY29tcHJvbWlzZSB5b3Vy
IENvbXB1dGVyLl0NCg0KT24gRnJpLCBBdWcgMjcsIDIwMjEgYXQgMDQ6MzI6NThQTSArMDAwMCwg
U2F0aGlzaCBLdW1hciBCYWxhc3VicmFtYW5pYW0gLUVSUywgSENMIFRlY2ggd3JvdGU6DQo+IENs
YXNzaWZpY2F0aW9uOiBQdWJsaWMNCg0KVGhpcyBkb2VzIG5vdCBiZWxvbmcgaW4gYSBjaGFuZ2Vs
b2cgY29tbWVudCwgcGxlYXNlIHJlbW92ZS4NCg0KPg0KPiBUaGlzIGRyaXZlciBwYXRjaCBhZGRz
IHRoZSBVQVJUIFRUWSBzZXJpYWwgc3VwcG9ydCBmb3IgdGhlIFJJU0MtViBiYXNlZCBJbkNvcmUg
U2VtaWNvbmR1Y3RvcidzIENocm9taXRlIFNvQyBmYW1pbHkgbGlrZSBDaHJvbWl0ZSBNLCBDaHJv
bWl0ZSBILg0KDQpQbGVhc2UgbGluZSB3cmFwIHlvdXIgY2hhbmdlbG9nIGNvbW1lbnRzIHByb3Bl
cmx5Lg0KDQpJJ2xsIHdhaXQgZm9yIGEgdjIgYmVmb3JlIHJldmlld2luZyB0aGUgY29kZS4uLg0K
DQp0aGFua3MsDQoNCmdyZWcgay1oDQo6OkRJU0NMQUlNRVI6Og0KX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18NClRoZSBjb250ZW50cyBvZiB0aGlzIGUtbWFpbCBhbmQgYW55IGF0dGFj
aG1lbnQocykgYXJlIGNvbmZpZGVudGlhbCBhbmQgaW50ZW5kZWQgZm9yIHRoZSBuYW1lZCByZWNp
cGllbnQocykgb25seS4gRS1tYWlsIHRyYW5zbWlzc2lvbiBpcyBub3QgZ3VhcmFudGVlZCB0byBi
ZSBzZWN1cmUgb3IgZXJyb3ItZnJlZSBhcyBpbmZvcm1hdGlvbiBjb3VsZCBiZSBpbnRlcmNlcHRl
ZCwgY29ycnVwdGVkLCBsb3N0LCBkZXN0cm95ZWQsIGFycml2ZSBsYXRlIG9yIGluY29tcGxldGUs
IG9yIG1heSBjb250YWluIHZpcnVzZXMgaW4gdHJhbnNtaXNzaW9uLiBUaGUgZSBtYWlsIGFuZCBp
dHMgY29udGVudHMgKHdpdGggb3Igd2l0aG91dCByZWZlcnJlZCBlcnJvcnMpIHNoYWxsIHRoZXJl
Zm9yZSBub3QgYXR0YWNoIGFueSBsaWFiaWxpdHkgb24gdGhlIG9yaWdpbmF0b3Igb3IgSENMIG9y
IGl0cyBhZmZpbGlhdGVzLiBWaWV3cyBvciBvcGluaW9ucywgaWYgYW55LCBwcmVzZW50ZWQgaW4g
dGhpcyBlbWFpbCBhcmUgc29sZWx5IHRob3NlIG9mIHRoZSBhdXRob3IgYW5kIG1heSBub3QgbmVj
ZXNzYXJpbHkgcmVmbGVjdCB0aGUgdmlld3Mgb3Igb3BpbmlvbnMgb2YgSENMIG9yIGl0cyBhZmZp
bGlhdGVzLiBBbnkgZm9ybSBvZiByZXByb2R1Y3Rpb24sIGRpc3NlbWluYXRpb24sIGNvcHlpbmcs
IGRpc2Nsb3N1cmUsIG1vZGlmaWNhdGlvbiwgZGlzdHJpYnV0aW9uIGFuZCAvIG9yIHB1YmxpY2F0
aW9uIG9mIHRoaXMgbWVzc2FnZSB3aXRob3V0IHRoZSBwcmlvciB3cml0dGVuIGNvbnNlbnQgb2Yg
YXV0aG9yaXplZCByZXByZXNlbnRhdGl2ZSBvZiBIQ0wgaXMgc3RyaWN0bHkgcHJvaGliaXRlZC4g
SWYgeW91IGhhdmUgcmVjZWl2ZWQgdGhpcyBlbWFpbCBpbiBlcnJvciBwbGVhc2UgZGVsZXRlIGl0
IGFuZCBub3RpZnkgdGhlIHNlbmRlciBpbW1lZGlhdGVseS4gQmVmb3JlIG9wZW5pbmcgYW55IGVt
YWlsIGFuZC9vciBhdHRhY2htZW50cywgcGxlYXNlIGNoZWNrIHRoZW0gZm9yIHZpcnVzZXMgYW5k
IG90aGVyIGRlZmVjdHMuDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0K
