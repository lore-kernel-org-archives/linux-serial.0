Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07018C4320A
	for <linux-serial@archiver.kernel.org>; Fri, 27 Aug 2021 16:33:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE4FA60F25
	for <linux-serial@archiver.kernel.org>; Fri, 27 Aug 2021 16:33:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231862AbhH0QeA (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 27 Aug 2021 12:34:00 -0400
Received: from mail-eopbgr1320121.outbound.protection.outlook.com ([40.107.132.121]:31439
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229675AbhH0Qd7 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 27 Aug 2021 12:33:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=HCL.COM; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vmjDfBAZqjyDAwGxjx4FGo8ODTxr3wUf7jVkvo4rzHo=;
 b=jnNl4PFcaEWuRNgKOsbOH5hSDqk7+AqguOa7LGLEVYgqtZ2tQNMnFDtlr0+s0uzz8NGWX58mRoEfDzSaLsFoFNIDT4thivJm/iJBGlpfUD67YN6kxrOtoGvPDQ0xmxrcP9UucHwV77UZpwaVuAT9lRgI0SD93t62ici6VLyOuXKzlT85qUQtvZDr5gO+/l450TFgSY8LYoh11lYEozLBGkXXbDCnaHX8rtzzjfsDQV/PTCMqY79c/L4RcFjC83MmDNv2Mexd4HyaFv8aIkvhVr+ZWC7CS4R9mc6trq313701ZU2Y9TjraUHlmmI41M/BCK7D5mSE5Jiu6nOtIq34cg==
Received: from PS2P216CA0020.KORP216.PROD.OUTLOOK.COM (2603:1096:300:19::30)
 by SG2PR04MB2283.apcprd04.prod.outlook.com (2603:1096:4:3::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4436.24; Fri, 27 Aug 2021 16:33:06 +0000
Received: from HK2APC01FT058.eop-APC01.prod.protection.outlook.com
 (2603:1096:300:19:cafe::6) by PS2P216CA0020.outlook.office365.com
 (2603:1096:300:19::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.17 via Frontend
 Transport; Fri, 27 Aug 2021 16:33:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.8.245.51)
 smtp.mailfrom=hcl.com; linuxfoundation.org; dkim=pass (signature was
 verified) header.d=HCL.COM;linuxfoundation.org; dmarc=pass action=none
 header.from=hcl.com;
Received-SPF: Pass (protection.outlook.com: domain of hcl.com designates
 192.8.245.51 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.8.245.51; helo=APC01-PU1-obe.outbound.protection.outlook.com;
Received: from APC01-PU1-obe.outbound.protection.outlook.com (192.8.245.51) by
 HK2APC01FT058.mail.protection.outlook.com (10.152.249.150) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4457.17 via Frontend Transport; Fri, 27 Aug 2021 16:33:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EoEtIX0m8EDgaPV3scfy8sur9qFUx0yBK/SfPEjL4ewT+kKVPBcNyUVU+XIDkqhVWMLpwa7tHWV7HbabYU1IwRnEF29xDnZmYDoDwGquXC2RWbhqugn7D7/cpQBAPsK0rYQOnw1PXI/OGh1h3Oq9f9Lp8oUQkos2cdfhKXA97GMguajEaTHQEoklMsZ7wPYlRhp8NoEzGAwt7q1fCMJ9malf9APUBgSwUIW7tScwT2WZSs3I0+ibXZF6DS7CuGd4B7c/DUbhafZgFUxl/c7vTT96yN8EfRTuc76PIVf18u8HHukT7ZwX64010A1a3dE8kRq+ze2cEp6ReksZR7ROwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vmjDfBAZqjyDAwGxjx4FGo8ODTxr3wUf7jVkvo4rzHo=;
 b=gIUQ8aJ7mSmnXmv0NiR516X2VQLUc3f/TXuxTL6MSTkDs6Pe14/eqGbwU8Yk8PnOlUfpKzThpNTPs4N207T3HBHOLIQvZlRijtk4zfStZ+vMvrN8d8IzfG0jkQhglvW5gLm3A81U9bCuBTQj9Tg06Y1OvFnP2d+5cAcu9kwO7btCBcnwymMcvMGKNrSVOHhF91ekcegIvHQpI97JqUShW+UUUAZzP9rhgbCLpgjq1agbIUrSpR5KvWM7E7uV/usI0nBXb9i6FXR74/aMILDv9IBCuIhJlm/bBisgstw8HK829LETZk1Say18tfs0JKE0nvIMa+mQ6i7JrCcQVWe6xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hcl.com; dmarc=pass action=none header.from=hcl.com; dkim=pass
 header.d=hcl.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=HCL.COM; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vmjDfBAZqjyDAwGxjx4FGo8ODTxr3wUf7jVkvo4rzHo=;
 b=jnNl4PFcaEWuRNgKOsbOH5hSDqk7+AqguOa7LGLEVYgqtZ2tQNMnFDtlr0+s0uzz8NGWX58mRoEfDzSaLsFoFNIDT4thivJm/iJBGlpfUD67YN6kxrOtoGvPDQ0xmxrcP9UucHwV77UZpwaVuAT9lRgI0SD93t62ici6VLyOuXKzlT85qUQtvZDr5gO+/l450TFgSY8LYoh11lYEozLBGkXXbDCnaHX8rtzzjfsDQV/PTCMqY79c/L4RcFjC83MmDNv2Mexd4HyaFv8aIkvhVr+ZWC7CS4R9mc6trq313701ZU2Y9TjraUHlmmI41M/BCK7D5mSE5Jiu6nOtIq34cg==
Received: from SG2PR04MB3820.apcprd04.prod.outlook.com (2603:1096:4:94::15) by
 SG2PR04MB4105.apcprd04.prod.outlook.com (2603:1096:0:5::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4436.22; Fri, 27 Aug 2021 16:32:59 +0000
Received: from SG2PR04MB3820.apcprd04.prod.outlook.com
 ([fe80::1d10:8a18:f6e0:f513]) by SG2PR04MB3820.apcprd04.prod.outlook.com
 ([fe80::1d10:8a18:f6e0:f513%7]) with mapi id 15.20.4436.027; Fri, 27 Aug 2021
 16:32:59 +0000
From:   "Sathish Kumar Balasubramaniam -ERS, HCL Tech" 
        <b-sathishkumar@hcl.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
CC:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
Subject: [PATCH] tty: serial: UART driver for RISC-V based Chromite SoC family
Thread-Topic: [PATCH] tty: serial: UART driver for RISC-V based Chromite SoC
 family
Thread-Index: AdebX37+Hfqi9SPcR72EV2N1dxhcdwAAY8PQ
Date:   Fri, 27 Aug 2021 16:32:58 +0000
Message-ID: <SG2PR04MB3820B2DED21B7B5DB868A18F81C89@SG2PR04MB3820.apcprd04.prod.outlook.com>
References: <SG2PR04MB382047047E75CF30B8E8EA0B81C89@SG2PR04MB3820.apcprd04.prod.outlook.com>
In-Reply-To: <SG2PR04MB382047047E75CF30B8E8EA0B81C89@SG2PR04MB3820.apcprd04.prod.outlook.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL2hjbCIsImlkIjoiZDVkMWYwMWMtNWU3Ny00OTI4LTg3OGUtMTdhMjcwOWI3ZjBhIiwicHJvcHMiOlt7Im4iOiJIQ0xDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiSENMX0NsYTVzX1B1YmwxYyJ9XX1dfSwiU3ViamVjdExhYmVscyI6W10sIlRNQ1ZlcnNpb24iOiIxOC40LjE4NDMuMTIzIiwiVHJ1c3RlZExhYmVsSGFzaCI6IjFSdkpGXC9cL3JkamZBWVBZa2lhdmpweEp1WHNpT1FqZ1F5UUMycnBUT1wvYVhJRlNiZWtDK2dNUlRjbFhsV2RFeGgifQ==
x-hclclassification: HCL_Cla5s_Publ1c
x-hcl_cla5s_d6: True
Authentication-Results-Original: linuxfoundation.org; dkim=none (message not
 signed) header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=hcl.com;
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: 528e6ff1-3f43-40b5-b5c2-08d969785946
x-ms-traffictypediagnostic: SG2PR04MB4105:|SG2PR04MB2283:
X-Microsoft-Antispam-PRVS: <SG2PR04MB22833ED695FFA9426AEE8DCE81C89@SG2PR04MB2283.apcprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:357;OLM:397;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: PgHqHg3Yihp4U7bTJdMnodHeYcZzHUIeCzIia7f33D8erT3UY7jND7jpNCm99aK0d63FNAsYWlQqeJosJ0TLUei5tgAoudWisK0hA2zaYU1PpBP5b9iirEGsYERw/ulIaXEiFX+Vf2Gqv0RDJSEHTb22aw70ynF3TL5L/Qc7pKb1IaqhqgZ9YLVcwFMZccfzpfd9KnthusjC9LhoIwphy2s+X8qIKbjw23zBdqEJd0TDb0xIlbQ8/zqiAjxCUttrc9jUmFzK7tar0FSrxLx4F4XRJETsOkMPS1yPCnT+lU7xxp3RfBlGS5EdBU3klawYBOOTqG9/QrbOJ0LKaRDe9gOFAdwU42CAfpOTw/c/u0iAYb3BBrSpZ7YuDEwUVDs/yMB3TGzIGOolXFLaqEQc6iYeRH+eK/5UDdZ1E0CvnctX0irmZ3F+3cKONmETcIO8p+259jpZEmLg2qEQOXsWCLH8ij2fKQmqqJsj9J6LgqHCS2PbNFRTIjx9MY2Etaz00Lx06NmTWb+B0elf58w2ctarEBhZX4Wp85vSdGPiyKZd7kA3MvUX33U3LMjp0QlvNa0hujo6/knwYW1VA8yQIHZfiX9yVUK7wRbdPzz/49OEGW3zSfYFqfwQDtAngb6ZQ8oZMMRfLjhLOmEpTXiBOB8tkal5jvluxJ+RIzYawRI7uztEgoiR81iXJpsU8lnbObTijAu3pkKwqD9ZmF3ToOQKPR4G2Rzmr96GoYsxkvI=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR04MB3820.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(26005)(9686003)(966005)(86362001)(52536014)(4326008)(66476007)(7696005)(186003)(498600001)(38070700005)(55016002)(122000001)(76116006)(64756008)(66446008)(8676002)(33656002)(2940100002)(110136005)(30864003)(6506007)(38100700002)(83380400001)(5660300002)(55236004)(71200400001)(8936002)(66946007)(66556008)(2906002)(2004002)(579004)(559001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nHW+BSJ5S/FClZ80toed+6NjflqDJcfunHUWTxGT4e2rIzbLiXiP4+P4SCZO?=
 =?us-ascii?Q?lhoaKzWij3ZnUO+yKehINGdhkRtgaHwEJiNQS7MhmAb0lO/yhZHNt7WkmjJQ?=
 =?us-ascii?Q?YXcAFeIP6WflyfT6I/wUmeN7auvQ4nj7CTc4Mtf1l3lsulYZAM58qdR++rQj?=
 =?us-ascii?Q?Zvk8AmJTE5zL+4o4Uak5sy/45Jk/HMii7q0IEXJLjiCjDLs1TtmFzwAFG4MM?=
 =?us-ascii?Q?56wyWIzMj1N4KoqN5k6Ty2B2pmzIAQUK1sP8GKXyhwVGPs8rsUGYhU8/UnSP?=
 =?us-ascii?Q?0qdHK+SYNVz68n5KZB6M/pZGqlgWSNlIx0P45D8L7Qggd+uT9TtxiNesAuFn?=
 =?us-ascii?Q?MvvFx+iFg5llu6ESuJLt4SDOo+QSOUdedVEAMpSQigTNKZvysYAJPUINhgCQ?=
 =?us-ascii?Q?3wKXGPGkSwrum0b8AThGaVIFCj7BAFvgKDLZDdjNFKw3YCY9SQALb+1wstid?=
 =?us-ascii?Q?JcAkLXVukrEsQGLPLprbRbxH4xlE34qH/AckUoEgxXyEIZdwkxybQ4TE0/Dp?=
 =?us-ascii?Q?wPE8FJ73iBQf4KXLxmSmHFKI6h5iQaaDtKh5BvDxRU0y42XZcHoGwA0+gMFn?=
 =?us-ascii?Q?SRSXBTPw7zIutq8XRTZCGoCOB7VQbBxL4yjAVsLvhJZm1d/cZ0quVsmD06Tf?=
 =?us-ascii?Q?I8cGUMsJCn8yKea/ux5Xr0AZV0baI14DV2LU8S6bzbkI13IyfzR+DNgUqMEI?=
 =?us-ascii?Q?PnC7ZwFu40Yo2GkEhAnxqNmXR+is05d4EUsLIkq8sYapflpNrVrXBvNsx+pA?=
 =?us-ascii?Q?PGu1j/OOv9FuyYoWcuheNRsEkbaqzTQt6kep+IOSajOefWd9t6h3Iv01P642?=
 =?us-ascii?Q?Qq5ShHPZzzFomeatvVNaMKRQwQTB01+CXCylHPMhnUD+xDGkkGgQ/4U5SWnD?=
 =?us-ascii?Q?Sijvk4l6eSZbSmqO8fZANjlZQbECnGFQ45uay0ep852MQKgrnOfSZNCccwgz?=
 =?us-ascii?Q?QRL51/RymVm6IzFz5CbD2Xo75vNkA1MjqFTB/uwLXyUDAFHMkHrl7kY9WKQH?=
 =?us-ascii?Q?MI3qae38qZFfyDf2qXDeyEyidQgBRDPV+rr5P5ZxkVjloH4I1LR+nS8aF475?=
 =?us-ascii?Q?0dfYUSHJ6X9uHsAR7CXOGpqCy1CtKBsaikXXXT01bBuAp7ntXSpShG76q4tY?=
 =?us-ascii?Q?O/33WAaztOeuObQSKa0vBZRSnWcyZKmCIhXpyNgk0FU908c9lv0qFBAjqiNL?=
 =?us-ascii?Q?z3SaVGun6KiEY5Miu0GhOWT3kAaz2PqmEwGhWSF0dUU6gAut0/UkAgatHVwm?=
 =?us-ascii?Q?Bq6RtcNDY0gLwPk7JBPuueehVSJAw8muI/OzuAYvPluSGsALC7/8YLb4jfph?=
 =?us-ascii?Q?hjRRRTIX0XNT1dUsFlQJxrHk?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR04MB4105
X-DLP:  MSGProcess
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: HK2APC01FT058.eop-APC01.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: 4203d77f-8ec0-487f-9bc8-08d9697854e8
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oBkIE7j431ZFarK1vgYr4xfaskQa1ualaMnd5z9XWZaqCjAC5Z3VEaNbxD4QlFGetwm7meV1oUBBQDKysm3qxH/WN5jO8Ozpix64IiDCV6q4FgdcK2rIQI6XsQLiD0gSlc1rtm/iSFUb3/GbDUco/GW6dXTesZzBEGfXAtBEpmAPLBPFIr4oXXxZJUMiY+WZdgXEhfs70SwSKZsnFjOq0m+orA2BqELw+GwmoG8tr5bSQKHN65hypHvuCj5X44hNJjoYWYVuDqlbInrZ0pw/dciBUJ6LDP2vpNGtG/f1TpSCzszoFC7ILUsckXGK4jwlLdTMcn5ZOTvte71Gvi/OeC99cJ1/Q3DUdwVrZYUlhtBz+EorndzZNlscA7k469UIBsonLQpcR9+NDWu+Hxpo63gzDFLxYUQV4UE6h/pGNc4ZCHPWZpRgsG4ygsZ2yUP+LcgHHYdgFDP2RGWCtOOoSSniGZeeudXjVccrb/SA1P7Zd7OyDA/ADxrIeFnbKwMZeETSsD6OvOXbbfmPEyJ441D9rs111Dg/dBIpi11kz7zKDEwBdYatJoMaAv3R/dBLvWa8PhBKES1LqJqzKZ2c8o5UldCo1dggV6gouBolviur4gDEy0r2u07cy5q40iAod1+MDNT/opVNxtDvVBtDQVzh7EmOgguWZM3W2Pr5KqUkXYAgG2ZqVH+QLjSSW+yQgJnm7RxhuM2wl8RQGuxW+bYK137clQ8D4OersEZCgTnp8KYXwuzqPBXcy95slYvhcwlGnb/rI83tUe3dCHYqofYDEtxg2TrdUdwgqcVnojY=
X-Forefront-Antispam-Report: CIP:192.8.245.51;CTRY:IN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:APC01-PU1-obe.outbound.protection.outlook.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(376002)(136003)(346002)(39860400002)(396003)(36840700001)(46966006)(86362001)(82740400003)(55016002)(34020700004)(966005)(30864003)(70586007)(9686003)(478600001)(83380400001)(6506007)(4326008)(336012)(52536014)(356005)(186003)(2906002)(26005)(47076005)(81166007)(8676002)(110136005)(5660300002)(33656002)(36906005)(8936002)(7696005)(316002)(2940100002)(36860700001)(70206006)(82310400003)(2004002)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: HCL.COM
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2021 16:33:05.9966
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 528e6ff1-3f43-40b5-b5c2-08d969785946
X-MS-Exchange-CrossTenant-Id: 189de737-c93a-4f5a-8b68-6f4ca9941912
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=189de737-c93a-4f5a-8b68-6f4ca9941912;Ip=[192.8.245.51];Helo=[APC01-PU1-obe.outbound.protection.outlook.com]
X-MS-Exchange-CrossTenant-AuthSource: HK2APC01FT058.eop-APC01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR04MB2283
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Classification: Public

This driver patch adds the UART TTY serial support for the RISC-V based InC=
ore Semiconductor's Chromite SoC family like Chromite M, Chromite H.

Signed-off-by: Sathish Kumar Balasubramaniam <b-sathishkumar@hcl.com>
---
 drivers/tty/serial/Kconfig         |  25 +
 drivers/tty/serial/Makefile        |   1 +
 drivers/tty/serial/chromite_uart.c | 764 +++++++++++++++++++++++++++++
 include/uapi/linux/serial_core.h   |   3 +
 4 files changed, 793 insertions(+)
 create mode 100644 drivers/tty/serial/chromite_uart.c

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig index =
24282ad99d85..f238bdb04ba6 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -1009,6 +1009,31 @@ config SERIAL_SIFIVE_CONSOLE
          your boot loader about how to pass options to the kernel at
          boot time.)

+config SERIAL_CHROMITE
+       tristate "Chromite UART support"
+       depends on OF
+       select SERIAL_CORE
+       help
+         Select this option if you are building a kernel for a device that
+         contains a Chromite UART IP block.  This type of UART is present =
on
+         Chromite-H SoC, among others.
+
+config SERIAL_CHROMITE_CONSOLE
+       bool "Console on Chromite UART"
+       depends on SERIAL_CHROMITE=3Dy
+       select SERIAL_CORE_CONSOLE
+       select SERIAL_EARLYCON
+       help
+         Select this option if you would like to use a Chromite UART as th=
e
+         system console.
+
+         Even if you say Y here, the currently visible virtual console
+         (/dev/tty0) will still be used as the system console by default, =
but
+         you can alter that using a kernel command line option such as
+         "console=3DttyCRMTx". (Try "man bootparam" or see the documentati=
on of
+         your boot loader about how to pass options to the kernel at
+         boot time.)
+
 config SERIAL_LANTIQ
        tristate "Lantiq serial driver"
        depends on (LANTIQ || X86) || COMPILE_TEST diff --git a/drivers/tty=
/serial/Makefile b/drivers/tty/serial/Makefile index 7da0856cd198..dd0acc51=
2714 100644
--- a/drivers/tty/serial/Makefile
+++ b/drivers/tty/serial/Makefile
@@ -86,6 +86,7 @@ obj-$(CONFIG_SERIAL_OWL)      +=3D owl-uart.o
 obj-$(CONFIG_SERIAL_RDA)       +=3D rda-uart.o
 obj-$(CONFIG_SERIAL_MILBEAUT_USIO) +=3D milbeaut_usio.o
 obj-$(CONFIG_SERIAL_SIFIVE)    +=3D sifive.o
+obj-$(CONFIG_SERIAL_CHROMITE)  +=3D chromite_uart.o
 obj-$(CONFIG_SERIAL_LITEUART) +=3D liteuart.o

 # GPIOLIB helpers for modem control lines diff --git a/drivers/tty/serial/=
chromite_uart.c b/drivers/tty/serial/chromite_uart.c
new file mode 100644
index 000000000000..0e9da1d0d725
--- /dev/null
+++ b/drivers/tty/serial/chromite_uart.c
@@ -0,0 +1,764 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Chromite UART driver
+ * Copyright (C) 2021 Sathish Kumar Balasubramaniam
+<b-sathishkumar@hcl.com>
+ * Copyright (C) 2021 InCore Semiconductors
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * Based on:
+ * - drivers/tty/serial/sifive.c
+ *
+ * See the following sources for documentation
+ * - https://chromiteh-soc.readthedocs.io/en/latest/uart.html
+ * - https://chromitem-soc.readthedocs.io/en/latest/uart.html
+ *
+ * Presently the Chromite UART supports only the following configuration
+ *   8-N-1: 8 data bits, no parity and 1 stop-bit
+ *
+ * Presently the Chromite UART does not have support for hardware flow
+control or other modem control signals
+ *
+ *
+ */
+
+
+#include <linux/clk.h>
+#include <linux/console.h>
+#include <linux/delay.h>
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/irq.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_irq.h>
+#include <linux/platform_device.h>
+#include <linux/serial_core.h>
+#include <linux/serial_reg.h>
+#include <linux/slab.h>
+#include <linux/tty.h>
+#include <linux/tty_flip.h>
+
+
+#define CHROMITE_SERIAL_MAX_PORTS 1
+#define CHROMITE_DEFAULT_BAUD_RATE 115200 #define CHROMITE_TTY_PREFIX
+"ttyCRMT"
+#define CHROMITE_CLOCK 50000000
+#define TX_FIFO_DEPTH 16
+#define RX_FIFO_DEPTH 16
+
+#define BAUD_REG_OFF           0x00
+#define TX_DATA_REG_OFF                0x04
+#define RX_DATA_REG_OFF                0x08
+#define STATUS_REG_OFF         0x0C
+#define CONTROL_REG_OFF                0x10
+#define STATUS_CLEAR_REG_OFF   0x14
+#define INT_EN_REG_OFF         0x18
+
+#define STATUS_REG_TX_NOTFULL_MASK 0x02 #define
+STATUS_REG_RX_NOTEMPTY_MASK 0x08 #define STATUS_REG_TX_THLD_HIT_MASK
+0x10 #define STATUS_REG_RX_THLD_HIT_MASK 0x20
+
+#define CONTROL_REG_TX_THLD_AUTO_RST_SHIFT 10 #define
+CONTROL_REG_RX_THLD_AUTO_RST_SHIFT 11 #define CONTROL_REG_TX_THLD_MASK
+0xF0000 #define CONTROL_REG_RX_THLD_MASK 0xF00000 #define
+CONTROL_REG_STOP_BITS_MASK 0x3 #define CONTROL_REG_STOP_BITS_SHIFT 0
+
+#define STATUS_CLEAR_TX_THLD_HIT 0x10
+#define STATUS_CLEAR_RX_THLD_HIT 0x20
+
+#define INT_EN_TX_THLD_HIT_MASK 0x10
+#define INT_EN_RX_THLD_HIT_MASK 0x20
+
+
+struct chromite_serial_port {
+       struct uart_port        port;
+       unsigned long           clkin_rate;
+       unsigned long           baud_rate;
+       unsigned char           cread_flag;
+       struct device           *dev;
+};
+
+#define port_to_chromite_serial_port(p) (container_of((p), \
+                                               struct chromite_serial_port=
, \
+                                               port))
+
+static void chromite_serial_stop_tx(struct uart_port *port);
+
+static int chromite_serial_is_tx_fifo_full(struct chromite_serial_port
+*csp) {
+       u32 ret =3D 0;
+
+       ret =3D readl_relaxed(csp->port.membase + STATUS_REG_OFF);
+       if ((ret & STATUS_REG_TX_NOTFULL_MASK) =3D=3D 0)
+               return 1;
+
+       return 0;
+}
+
+static void chromite_serial_wait_for_xmitr(struct chromite_serial_port
+*csp) {
+       while (chromite_serial_is_tx_fifo_full(csp))
+               udelay(1);
+}
+
+static void chromite_serial_transmit_char(struct chromite_serial_port *csp=
,
+                                               unsigned char ch) {
+       writeb_relaxed(ch, csp->port.membase + TX_DATA_REG_OFF); }
+
+static void chromite_serial_transmit_chars(struct chromite_serial_port
+*csp) {
+       struct circ_buf *xmit =3D &csp->port.state->xmit;
+       int count =3D 0;
+
+       if (csp->port.x_char) {
+               chromite_serial_transmit_char(csp, csp->port.x_char);
+               csp->port.icount.tx++;
+               csp->port.x_char =3D 0;
+               return;
+       }
+       if (uart_circ_empty(xmit) || uart_tx_stopped(&csp->port)) {
+               chromite_serial_stop_tx(&csp->port);
+               return;
+       }
+       count =3D TX_FIFO_DEPTH;
+       do {
+               chromite_serial_transmit_char(csp, xmit->buf[xmit->tail]);
+               xmit->tail =3D (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
+               csp->port.icount.tx++;
+               if (uart_circ_empty(xmit))
+                       break;
+       } while (--count > 0);
+
+       if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
+               uart_write_wakeup(&csp->port);
+
+       if (uart_circ_empty(xmit))
+               chromite_serial_stop_tx(&csp->port);
+
+}
+
+static void chromite_serial_enable_tx_thld_hit(
+                                       struct chromite_serial_port
+*csp) {
+       u16 val =3D 0;
+
+       val =3D readw_relaxed(csp->port.membase + INT_EN_REG_OFF);
+       if (val & INT_EN_TX_THLD_HIT_MASK)
+               return;
+
+       val |=3D INT_EN_TX_THLD_HIT_MASK;
+       writew_relaxed(val, csp->port.membase + INT_EN_REG_OFF); }
+
+static void chromite_serial_disable_tx_thld_hit(
+                                       struct chromite_serial_port
+*csp) {
+       u16 val =3D 0;
+
+       val =3D readw_relaxed(csp->port.membase + INT_EN_REG_OFF);
+       if ((val & INT_EN_TX_THLD_HIT_MASK) =3D=3D 0)
+               return;
+
+       val &=3D ~INT_EN_TX_THLD_HIT_MASK;
+       writew_relaxed(val, csp->port.membase + INT_EN_REG_OFF); }
+
+static void chromite_serial_enable_rx_thld_hit(
+                                       struct chromite_serial_port
+*csp) {
+       u16 val =3D 0;
+
+       val =3D readw_relaxed(csp->port.membase + INT_EN_REG_OFF);
+       if (val & INT_EN_RX_THLD_HIT_MASK)
+               return;
+
+       val |=3D INT_EN_RX_THLD_HIT_MASK;
+       writew_relaxed(val, csp->port.membase + INT_EN_REG_OFF); }
+
+static void chromite_serial_disable_rx_thld_hit(
+                                       struct chromite_serial_port
+*csp) {
+       u16 val =3D 0;
+
+       val =3D readw_relaxed(csp->port.membase + INT_EN_REG_OFF);
+       if ((val & INT_EN_RX_THLD_HIT_MASK) =3D=3D 0)
+               return;
+
+       val &=3D ~INT_EN_RX_THLD_HIT_MASK;
+       writew_relaxed(val, csp->port.membase + INT_EN_REG_OFF); }
+
+static int chromite_serial_receive_char(struct chromite_serial_port *csp,
+                                               unsigned char *ch) {
+       u32 val =3D 0;
+
+       if (!ch) {
+               BUG_ON(1);
+               return (-1);
+       }
+
+       val =3D readl_relaxed(csp->port.membase + STATUS_REG_OFF);
+
+       // check if rx FIFO is empty
+       if ((val & STATUS_REG_RX_NOTEMPTY_MASK) =3D=3D 0)
+               return 1;
+
+       // if CREAD is not set in TERMIOS, then ignore the receive characte=
rs
+       if (csp->cread_flag =3D=3D 0)
+               return 1;
+
+       *ch =3D readb_relaxed(csp->port.membase + RX_DATA_REG_OFF);
+
+       return 0;
+}
+
+static void chromite_serial_receive_chars(struct chromite_serial_port
+*csp) {
+       int i =3D 0;
+       unsigned char ch =3D 0;
+
+       for (i =3D 0; i < RX_FIFO_DEPTH; i++) {
+               if (chromite_serial_receive_char(csp, &ch) =3D=3D 0) {
+                       csp->port.icount.rx++;
+                       uart_insert_char(&csp->port, 0, 0, ch, TTY_NORMAL);
+               } else {
+                       break;
+               }
+       }
+
+       spin_unlock(&csp->port.lock);
+       tty_flip_buffer_push(&csp->port.state->port);
+       spin_lock(&csp->port.lock);
+}
+
+static void chromite_serial_update_div(struct chromite_serial_port
+*csp) {
+       u16 div;
+
+       div =3D csp->clkin_rate / (16 * csp->baud_rate);
+       writew_relaxed(div, csp->port.membase + BAUD_REG_OFF); }
+
+static void chromite_serial_update_baud_rate(struct chromite_serial_port *=
csp,
+                                               unsigned int rate) {
+       if (csp->baud_rate =3D=3D rate)
+               return;
+
+       csp->baud_rate =3D rate;
+       chromite_serial_update_div(csp); }
+
+static void chromite_serial_stop_tx(struct uart_port *port) {
+       struct chromite_serial_port *csp =3D
+port_to_chromite_serial_port(port);
+
+       chromite_serial_disable_tx_thld_hit(csp);
+}
+
+static void chromite_serial_stop_rx(struct uart_port *port) {
+       struct chromite_serial_port *csp =3D
+port_to_chromite_serial_port(port);
+
+       chromite_serial_disable_rx_thld_hit(csp);
+}
+
+static void chromite_serial_start_tx(struct uart_port *port) {
+       struct chromite_serial_port *csp =3D
+port_to_chromite_serial_port(port);
+
+       chromite_serial_enable_tx_thld_hit(csp);
+}
+
+static irqreturn_t chromite_serial_irq(int irq, void *dev_id) {
+       struct chromite_serial_port *csp =3D dev_id;
+       u32 status_reg;
+
+       spin_lock(&csp->port.lock);
+
+       status_reg =3D readl_relaxed(csp->port.membase + STATUS_REG_OFF);
+
+       if ((status_reg & (STATUS_REG_RX_THLD_HIT_MASK |
+                               STATUS_REG_TX_THLD_HIT_MASK)) =3D=3D 0) {
+               spin_unlock(&csp->port.lock);
+               return IRQ_NONE;
+       }
+       if (status_reg & STATUS_REG_RX_THLD_HIT_MASK) {
+               chromite_serial_receive_chars(csp);
+               writeb_relaxed(STATUS_CLEAR_RX_THLD_HIT, csp->port.membase =
+
+                               STATUS_CLEAR_REG_OFF);
+       }
+       if (status_reg & STATUS_REG_TX_THLD_HIT_MASK) {
+               chromite_serial_transmit_chars(csp);
+               writeb_relaxed(STATUS_CLEAR_TX_THLD_HIT, csp->port.membase =
+
+                               STATUS_CLEAR_REG_OFF);
+       }
+
+       spin_unlock(&csp->port.lock);
+
+       return IRQ_HANDLED;
+}
+
+
+static unsigned int chromite_serial_tx_empty(struct uart_port *port) {
+       return TIOCSER_TEMT;
+}
+
+static unsigned int chromite_serial_get_mctrl(struct uart_port *port) {
+       return TIOCM_CAR | TIOCM_CTS | TIOCM_DSR; }
+
+static void chromite_serial_set_mctrl(struct uart_port *port,
+                                       unsigned int mctrl) {
+       /* No support */
+}
+
+static void chromite_serial_break_ctl(struct uart_port *port, int
+break_state) {
+       /* No support */
+}
+
+static int chromite_serial_startup(struct uart_port *port) {
+       struct chromite_serial_port *csp =3D
+port_to_chromite_serial_port(port);
+
+       chromite_serial_enable_rx_thld_hit(csp);
+
+       return 0;
+}
+
+static void chromite_serial_shutdown(struct uart_port *port) {
+       struct chromite_serial_port *csp =3D
+port_to_chromite_serial_port(port);
+
+       chromite_serial_disable_rx_thld_hit(csp);
+       chromite_serial_disable_tx_thld_hit(csp);
+}
+
+static void chromite_serial_set_termios(struct uart_port *port,
+                                               struct ktermios *termios,
+                                               struct ktermios *old) {
+       struct chromite_serial_port *csp =3D port_to_chromite_serial_port(p=
ort);
+       unsigned long flags;
+       int rate;
+
+       if ((termios->c_cflag & CSIZE) !=3D CS8)
+               dev_err_once(csp->port.dev, "only 8-bit words supported\n")=
;
+       if (termios->c_cflag & CSTOPB)
+               dev_err_once(csp->port.dev, "only 1 stop-bit is supported\n=
");
+       if (termios->c_iflag & (INPCK | PARMRK))
+               dev_err_once(csp->port.dev, "parity checking not supported\=
n");
+       if (termios->c_iflag & BRKINT)
+               dev_err_once(csp->port.dev, "BREAK detection not
+ supported\n");
+
+       /* Set line rate */
+       rate =3D uart_get_baud_rate(port, termios, old, 0, csp->clkin_rate =
/ 16);
+       chromite_serial_update_baud_rate(csp, rate);
+
+       spin_lock_irqsave(&csp->port.lock, flags);
+
+       /* Update the per-port timeout */
+       uart_update_timeout(port, termios->c_cflag, rate);
+
+       csp->port.read_status_mask =3D 0;
+
+       /* Ignore all characters if CREAD is not set */
+       if ((termios->c_cflag & CREAD) =3D=3D 0)
+               csp->cread_flag =3D 0;
+       else
+               csp->cread_flag =3D 1;
+
+       spin_unlock_irqrestore(&csp->port.lock, flags); }
+
+static void chromite_serial_release_port(struct uart_port *port) { }
+
+static int chromite_serial_request_port(struct uart_port *port) {
+       return 0;
+}
+
+static void chromite_serial_config_port(struct uart_port *port, int
+flags) {
+       struct chromite_serial_port *csp =3D
+port_to_chromite_serial_port(port);
+
+       csp->port.type =3D PORT_CHROMITE;
+}
+
+static int chromite_serial_verify_port(struct uart_port *port,
+                                       struct serial_struct *ser) {
+       return -EINVAL;
+}
+
+static const char *chromite_serial_type(struct uart_port *port) {
+       return port->type =3D=3D PORT_CHROMITE ? "Chromite UART" : NULL; }
+
+#ifdef CONFIG_CONSOLE_POLL
+static int chromite_serial_poll_get_char(struct uart_port *port) {
+       struct chromite_serial_port *csp =3D port_to_chromite_serial_port(p=
ort);
+       char ch;
+
+       if (chromite_serial_receive_char(csp, &ch) !=3D 0)
+               return NO_POLL_CHAR;
+
+       return ch;
+}
+
+static void chromite_serial_poll_put_char(struct uart_port *port,
+                                       unsigned char c) {
+       struct chromite_serial_port *csp =3D
+port_to_chromite_serial_port(port);
+
+       chromite_serial_wait_for_xmitr(csp);
+       chromite_serial_transmit_char(csp, c); } #endif /*
+CONFIG_CONSOLE_POLL */
+
+/*
+ * Early console support
+ */
+
+#ifdef CONFIG_SERIAL_EARLYCON
+static void early_chromite_serial_putc(struct uart_port *port, int c) {
+       while ((readl_relaxed(port->membase + STATUS_REG_OFF) &
+               STATUS_REG_TX_NOTFULL_MASK) =3D=3D 0)
+               cpu_relax();
+
+       writeb_relaxed(c, port->membase + TX_DATA_REG_OFF); }
+
+static void early_chromite_serial_write(struct console *con, const char *s=
,
+                                               unsigned int n) {
+       struct earlycon_device *dev =3D con->data;
+       struct uart_port *port =3D &dev->port;
+
+       uart_console_write(port, s, n, early_chromite_serial_putc); }
+
+static int __init early_chromite_serial_setup(struct earlycon_device *dev,
+                                               const char *options) {
+       struct uart_port *port =3D &dev->port;
+
+       if (!port->membase)
+               return -ENODEV;
+
+       dev->con->write =3D early_chromite_serial_write;
+
+       return 0;
+}
+
+OF_EARLYCON_DECLARE(chromite, "chromite,uart0",
+early_chromite_serial_setup); #endif /* CONFIG_SERIAL_EARLYCON */
+
+/*
+ * Linux console interface
+ */
+
+#ifdef CONFIG_SERIAL_CHROMITE_CONSOLE
+
+static struct chromite_serial_port
+*chromite_serial_console_ports[CHROMITE_SERIAL_MAX_PORTS];
+
+static void chromite_serial_console_putchar(struct uart_port *port, int
+ch) {
+       struct chromite_serial_port *csp =3D
+port_to_chromite_serial_port(port);
+
+       chromite_serial_wait_for_xmitr(csp);
+       chromite_serial_transmit_char(csp, ch); }
+
+static void chromite_serial_console_write(struct console *co, const char *=
s,
+                                               unsigned int count) {
+       struct chromite_serial_port *csp =3D chromite_serial_console_ports[=
co->index];
+       unsigned long flags;
+       u16 ier;
+       int locked =3D 1;
+
+       if (!csp)
+               return;
+
+       local_irq_save(flags);
+       if (csp->port.sysrq)
+               locked =3D 0;
+       else if (oops_in_progress)
+               locked =3D spin_trylock(&csp->port.lock);
+       else
+               spin_lock(&csp->port.lock);
+
+       ier =3D readw_relaxed(csp->port.membase + INT_EN_REG_OFF);
+       writew_relaxed(0, csp->port.membase + INT_EN_REG_OFF);
+
+       uart_console_write(&csp->port, s, count,
+ chromite_serial_console_putchar);
+
+       writew_relaxed(ier, csp->port.membase + INT_EN_REG_OFF);
+
+       if (locked)
+               spin_unlock(&csp->port.lock);
+       local_irq_restore(flags);
+}
+
+static int __init chromite_serial_console_setup(struct console *co,
+char *options) {
+       struct chromite_serial_port *csp;
+       int baud =3D CHROMITE_DEFAULT_BAUD_RATE;
+       int bits =3D 8;
+       int parity =3D 'n';
+       int flow =3D 'n';
+
+       if (co->index < 0 || co->index >=3D CHROMITE_SERIAL_MAX_PORTS)
+               return -ENODEV;
+
+       csp =3D chromite_serial_console_ports[co->index];
+       if (!csp)
+               return -ENODEV;
+
+       if (options)
+               uart_parse_options(options, &baud, &parity, &bits,
+ &flow);
+
+       return uart_set_options(&csp->port, co, baud, parity, bits,
+flow); }
+
+static struct uart_driver chromite_serial_uart_driver;
+
+static struct console chromite_serial_console =3D {
+       .name           =3D CHROMITE_TTY_PREFIX,
+       .write          =3D chromite_serial_console_write,
+       .device         =3D uart_console_device,
+       .setup          =3D chromite_serial_console_setup,
+       .flags          =3D CON_PRINTBUFFER,
+       .index          =3D -1,
+       .data           =3D &chromite_serial_uart_driver,
+};
+
+static int __init chromite_console_init(void) {
+       register_console(&chromite_serial_console);
+       return 0;
+}
+
+console_initcall(chromite_console_init);
+
+static void chromite_add_console_port(struct chromite_serial_port *csp)
+{
+       chromite_serial_console_ports[csp->port.line] =3D csp; }
+
+static void chromite_remove_console_port(struct chromite_serial_port
+*csp) {
+       chromite_serial_console_ports[csp->port.line] =3D 0; }
+
+#define CHROMITE_SERIAL_CONSOLE   (&chromite_serial_console)
+
+#else
+
+#define CHROMITE_SERIAL_CONSOLE   NULL
+
+static void chromite_add_console_port(struct chromite_serial_port *csp)
+{} static void chromite_remove_console_port(struct chromite_serial_port
+*csp) {}
+
+#endif /* CONFIG_SERIAL_CHROMITE_CONSOLE */
+
+static const struct uart_ops chromite_serial_uart_ops =3D {
+       .tx_empty       =3D chromite_serial_tx_empty,
+       .set_mctrl      =3D chromite_serial_set_mctrl,
+       .get_mctrl      =3D chromite_serial_get_mctrl,
+       .stop_tx        =3D chromite_serial_stop_tx,
+       .start_tx       =3D chromite_serial_start_tx,
+       .stop_rx        =3D chromite_serial_stop_rx,
+       .break_ctl      =3D chromite_serial_break_ctl,
+       .startup        =3D chromite_serial_startup,
+       .shutdown       =3D chromite_serial_shutdown,
+       .set_termios    =3D chromite_serial_set_termios,
+       .type           =3D chromite_serial_type,
+       .release_port   =3D chromite_serial_release_port,
+       .request_port   =3D chromite_serial_request_port,
+       .config_port    =3D chromite_serial_config_port,
+       .verify_port    =3D chromite_serial_verify_port,
+#ifdef CONFIG_CONSOLE_POLL
+       .poll_get_char  =3D chromite_serial_poll_get_char,
+       .poll_put_char  =3D chromite_serial_poll_put_char, #endif };
+
+
+static struct uart_driver chromite_serial_uart_driver =3D {
+       .owner          =3D THIS_MODULE,
+       .driver_name    =3D "chromite-serial",
+       .dev_name       =3D CHROMITE_TTY_PREFIX,
+       .nr             =3D 1,
+       .cons           =3D CHROMITE_SERIAL_CONSOLE,
+};
+
+static int chromite_serial_probe(struct platform_device *pdev)
+{
+       struct chromite_serial_port *csp;
+       struct resource *mem;
+       void __iomem *base;
+       int irq, id, r;
+       u32 cr;
+
+       irq =3D platform_get_irq(pdev, 0);
+       if (irq < 0)
+               return -EPROBE_DEFER;
+
+       mem =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
+       base =3D devm_ioremap_resource(&pdev->dev, mem);
+       if (IS_ERR(base)) {
+               dev_err(&pdev->dev, "could not acquire device memory\n");
+               return PTR_ERR(base);
+       }
+       id =3D of_alias_get_id(pdev->dev.of_node, "serial");
+       if (id < 0) {
+               dev_err(&pdev->dev, "missing aliases entry\n");
+               return id;
+       }
+#ifdef CONFIG_SERIAL_CHROMITE_CONSOLE
+       if (id > CHROMITE_SERIAL_MAX_PORTS) {
+               dev_err(&pdev->dev, "too many UARTs (%d)\n", id);
+               return -EINVAL;
+       }
+#endif /* CONFIG_SERIAL_CHROMITE_CONSOLE */
+
+       csp =3D devm_kzalloc(&pdev->dev, sizeof(*csp), GFP_KERNEL);
+       if (!csp)
+               return -ENOMEM;
+
+       csp->port.dev =3D &pdev->dev;
+       csp->port.type =3D PORT_CHROMITE;
+       csp->port.iotype =3D UPIO_MEM;
+       csp->port.irq =3D irq;
+       csp->port.fifosize =3D TX_FIFO_DEPTH;
+       csp->port.ops =3D &chromite_serial_uart_ops;
+       csp->port.line =3D id;
+       csp->port.mapbase =3D mem->start;
+       csp->port.membase =3D base;
+       csp->dev =3D &pdev->dev;
+
+       /* Set up clock divider */
+       csp->clkin_rate =3D CHROMITE_CLOCK;
+       csp->baud_rate =3D CHROMITE_DEFAULT_BAUD_RATE;
+       csp->port.uartclk =3D csp->baud_rate * 16;
+       chromite_serial_update_div(csp);
+
+       csp->cread_flag =3D 1;
+
+       platform_set_drvdata(pdev, csp);
+
+       cr =3D readl_relaxed(csp->port.membase + CONTROL_REG_OFF);
+       /* Set TX_THLD_AUTO_RST and RX_THLD_AUTO_RST in control register to=
 1 */
+       cr |=3D (1 << CONTROL_REG_TX_THLD_AUTO_RST_SHIFT) |
+               (1 << CONTROL_REG_RX_THLD_AUTO_RST_SHIFT);
+       /* Set TX_THLD and RX_THLD in control register to 0 */
+       cr &=3D ~(CONTROL_REG_TX_THLD_MASK | CONTROL_REG_RX_THLD_MASK);
+       writel_relaxed(cr, csp->port.membase + CONTROL_REG_OFF);
+
+       r =3D request_irq(csp->port.irq, chromite_serial_irq, csp->port.irq=
flags,
+                       dev_name(&pdev->dev), csp);
+       if (r) {
+               dev_err(&pdev->dev, "could not attach interrupt: %d\n", r);
+               goto probe_out1;
+       }
+
+       chromite_add_console_port(csp);
+
+       r =3D uart_add_one_port(&chromite_serial_uart_driver, &csp->port);
+       if (r !=3D 0) {
+               dev_err(&pdev->dev, "could not add uart: %d\n", r);
+               goto probe_out2;
+       }
+
+       return 0;
+
+probe_out2:
+       chromite_remove_console_port(csp);
+       free_irq(csp->port.irq, csp);
+probe_out1:
+       return r;
+}
+
+static int chromite_serial_remove(struct platform_device *dev)
+{
+       struct chromite_serial_port *csp =3D platform_get_drvdata(dev);
+
+       chromite_remove_console_port(csp);
+       uart_remove_one_port(&chromite_serial_uart_driver, &csp->port);
+       free_irq(csp->port.irq, csp);
+
+       return 0;
+}
+
+
+static const struct of_device_id chromite_serial_of_match[] =3D {
+       { .compatible =3D "chromite,uart0" },
+       {},
+};
+MODULE_DEVICE_TABLE(of, chromite_serial_of_match);
+
+static struct platform_driver chromite_serial_platform_driver =3D {
+       .probe          =3D chromite_serial_probe,
+       .remove         =3D chromite_serial_remove,
+       .driver         =3D {
+               .name   =3D "chromite-serial",
+               .of_match_table =3D of_match_ptr(chromite_serial_of_match),
+       },
+};
+
+static int __init chromite_serial_init(void)
+{
+       int ret =3D uart_register_driver(&chromite_serial_uart_driver);
+
+       if (ret)
+               return ret;
+
+       ret =3D platform_driver_register(&chromite_serial_platform_driver);
+       if (ret)
+               uart_unregister_driver(&chromite_serial_uart_driver);
+
+       return ret;
+}
+
+static void __exit chromite_serial_exit(void)
+{
+       platform_driver_unregister(&chromite_serial_platform_driver);
+       uart_unregister_driver(&chromite_serial_uart_driver);
+}
+
+module_init(chromite_serial_init);
+module_exit(chromite_serial_exit);
+
+MODULE_DESCRIPTION("Chromite UART serial driver");
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Sathish Kumar Balasubrananiam <b-sathishkumar@hcl.com>");
+
diff --git a/include/uapi/linux/serial_core.h b/include/uapi/linux/serial_c=
ore.h
index c4042dcfdc0c..91592471e762 100644
--- a/include/uapi/linux/serial_core.h
+++ b/include/uapi/linux/serial_core.h
@@ -274,4 +274,7 @@
 /* Freescale LINFlexD UART */
 #define PORT_LINFLEXUART       122

+/* Chromite UART */
+#define PORT_CHROMITE  123
+
 #endif /* _UAPILINUX_SERIAL_CORE_H */
--
2.17.1

::DISCLAIMER::
________________________________
The contents of this e-mail and any attachment(s) are confidential and inte=
nded for the named recipient(s) only. E-mail transmission is not guaranteed=
 to be secure or error-free as information could be intercepted, corrupted,=
 lost, destroyed, arrive late or incomplete, or may contain viruses in tran=
smission. The e mail and its contents (with or without referred errors) sha=
ll therefore not attach any liability on the originator or HCL or its affil=
iates. Views or opinions, if any, presented in this email are solely those =
of the author and may not necessarily reflect the views or opinions of HCL =
or its affiliates. Any form of reproduction, dissemination, copying, disclo=
sure, modification, distribution and / or publication of this message witho=
ut the prior written consent of authorized representative of HCL is strictl=
y prohibited. If you have received this email in error please delete it and=
 notify the sender immediately. Before opening any email and/or attachments=
, please check them for viruses and other defects.
________________________________
