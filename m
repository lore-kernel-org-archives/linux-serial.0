Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EAD1C433EF
	for <linux-serial@archiver.kernel.org>; Fri, 14 Jan 2022 12:06:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240949AbiANMGl (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 14 Jan 2022 07:06:41 -0500
Received: from eu-smtp-delivery-197.mimecast.com ([185.58.85.197]:44715 "EHLO
        eu-smtp-delivery-197.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234308AbiANMGl (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 14 Jan 2022 07:06:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=camlingroup.com;
        s=mimecast20210310; t=1642162000;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LjofUSNDV/MThiEdJlMj0PZf35YhSn29yxA17+3Z5DQ=;
        b=Cjzip46p8jgTFcvzc7nKD1umOA1yrMZ/DqeYnvvMxecvf8tz3SW9GY0ucrvKF24lwEj1Dk
        91uFh+LbrkcifzfX3zHMTz4/hAEj8pgoR6j72OVNV6LPbkc7Hgys1DJqOLxV0fBTvkpVFA
        H6rCNSGSH9clnOCms4gDb3sSa0eOiJc=
Received: from GBR01-CWL-obe.outbound.protection.outlook.com
 (mail-cwlgbr01lp2051.outbound.protection.outlook.com [104.47.20.51]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 uk-mta-48-kX1RK-R6M9CUkmiPhfRrRA-1; Fri, 14 Jan 2022 12:06:39 +0000
X-MC-Unique: kX1RK-R6M9CUkmiPhfRrRA-1
Received: from CWLP123MB5572.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:16b::6)
 by LO2P123MB5280.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:204::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Fri, 14 Jan
 2022 12:06:38 +0000
Received: from CWLP123MB5572.GBRP123.PROD.OUTLOOK.COM
 ([fe80::4c56:90c1:1ed:2ea3]) by CWLP123MB5572.GBRP123.PROD.OUTLOOK.COM
 ([fe80::4c56:90c1:1ed:2ea3%4]) with mapi id 15.20.4888.012; Fri, 14 Jan 2022
 12:06:38 +0000
Subject: Re: [PATCH v2] serial: imx: reduce RX interrupt frequency
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Jiri Slaby <jirislaby@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-serial@vger.kernel.org, k.drobinski@camlintechnologies.com,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
References: <20220114074400.3417233-1-tomasz.mon@camlingroup.com>
From:   =?UTF-8?Q?Tomasz_Mo=c5=84?= <tomasz.mon@camlingroup.com>
Message-ID: <ea52f0ea-7d8c-31d0-2599-71c3c1cb228e@camlingroup.com>
Date:   Fri, 14 Jan 2022 13:06:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20220114074400.3417233-1-tomasz.mon@camlingroup.com>
X-ClientProxiedBy: LO4P123CA0251.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a7::22) To CWLP123MB5572.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:16b::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5bb7df46-ea40-4d8b-e792-08d9d7565124
X-MS-TrafficTypeDiagnostic: LO2P123MB5280:EE_
X-Microsoft-Antispam-PRVS: <LO2P123MB5280AB69A097BB45B10B111892549@LO2P123MB5280.GBRP123.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0
X-Microsoft-Antispam-Message-Info: 2XMKWq8WPXWtqRQJlMwT41yBXX4CBusgikX5K4wj1t3gnurr+OBo6QDKdEKTppVfq7juXn1S43lMSFeYJi9dI7lxbbgX3PGmp3+PkGzG9pt41KiasipdZAWiW46YrVMLTF2QaOVjaLRmzEKHm8JuMHHc/PG91i12nwP/MG5zJ0fXAH0vpMPk+1Rhx4kgBiacgcPFR7tj8IeaMDihaW/RJZX8wyCm02Pya74Zyxk7RZ7HkSxKtx93/cIGGqugIHMwqt2AJi6qivwaaJa4Vek1tD6vADlgA1ec08MNUNaIkccgR5PT0zA59oh8i6PfqPKMqOyoFqmaIykEnGU43LYYgtXoi//1d74/p7OuMgS5Ly9f1vC7U+6Ddt/HX4j1wTJMsDsKqWIKAOcybl1o8zP0TFVSemHYk121QO3Qi/grwCsU/4fE335bAxzqQFs49x3qXZZaK63fiG9GyYghX968aQ2ZQRu2m83k8UDre9MicAJScunpWPfi/2Vc7zoV/c/0c493MONNHZy2fiyY1+gNeBe+m3hHz5z2ySuMCcd98FEyLXi2dvM09iAIwAhHLGOU99T22r4YPOvLxlcVWKLegF1QsKtNgnItoCA/4OYNxnl5Dx/Hc8p4wx2YIc+8lDbGvHiJCTUOZViD5M7g5QED2ypIDkZszoUnvXMxdDIAYcXAaYOAbJ3k6Tukg5T4zZD+TLp4aG16HP3D4QVnR4lz61fWwEbH5bcmYkG/m1b43zT/ao6w7pI2/kZCW9V9TMkeDE+jDC3bkUV+J04m4VzjSQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB5572.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(366004)(2616005)(86362001)(54906003)(316002)(6916009)(36756003)(4744005)(53546011)(2906002)(6506007)(31696002)(66946007)(508600001)(66476007)(8936002)(52116002)(4326008)(8676002)(186003)(38350700002)(38100700002)(31686004)(66556008)(6512007)(6486002)(5660300002)(26005)(43740500002)(45980500001);DIR:OUT;SFP:1101
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jwW24NLEc4EyRIBZRu7YEctMKBz9dumlQKUxRbnXU9Cxx1wLiHTNHMbfgCJE?=
 =?us-ascii?Q?6ioZoOrFx5YFlrhGo+pFS0xiygCnOQWkOnV8w/9lCxt7dWNkbtWeTP3QOEWG?=
 =?us-ascii?Q?1Q2YAw1qmSXb9KI2lL1kN7reVxG3ReiSipxvAICiyuCK2MkawDzSkdZjpj/V?=
 =?us-ascii?Q?ElbdNkZfXbHeEZDUZLtw480CHdGdaPzS1d8WAXS5fRka6ebDb88syvBKoXtU?=
 =?us-ascii?Q?AhVDeotLoiI6I0iH+q3yH//EkVdPZ/IeahccG1PVb0FGdmPyj1cyj91Cy6a5?=
 =?us-ascii?Q?sNQV349WzTo84tdspSARs3/16gn4kjYHXQwy7vtTABHsIuipHswthFfuqh/+?=
 =?us-ascii?Q?4TInM4z4UHYpSmlNU5rogGxxyJkTA8pGVfoDWYpML7HiG1s01ZT3P3+1b7VK?=
 =?us-ascii?Q?FcGvefczkW/T79IXPEgKar6oUjvVReFYjWQV0ifvhARGajx6WUhGAYrJvvJQ?=
 =?us-ascii?Q?dgiXGYB/MTtgr7GbCtYX3JntoaBq7JbSJI6yqkjjTZoJwUpaAu9r1w3Ybhkg?=
 =?us-ascii?Q?4OTb3OMOEQhwRgD+AcGQCeJMK7IPbN0R7fjtu2Vro+Zk8QsfSQF+P2CmQm2a?=
 =?us-ascii?Q?c1bMRj9VXuQs1671jaRP8f3HVoQQt3YIign5YhWhC3CPVlPvldC8rJ8QcmVS?=
 =?us-ascii?Q?DeRZzQLYfbtx1zKQHKCWZweOFv95hS9ZHQR3l++x1MFV4mQYpxPnV46iChwq?=
 =?us-ascii?Q?EUZKfzZR6mqHccoN5WlhwyQeSq0X/nc2of5RqU/BPv9qPIxdZmal+8+VOmQX?=
 =?us-ascii?Q?akslWntAksGq/jt0uixQ2hjfbpWwI3QaFPja53OfyelGvahBZxn6nfLhjpir?=
 =?us-ascii?Q?CvsoIV/Ce5xQdfgL+f4AZa5cK7mxL9KqOXol7BjNVVFNak6JzvhNGu21mUT9?=
 =?us-ascii?Q?RRife6U3EFs/gOfeaemn7Koz5Dp3E9n5Lp5EpcKKq1oYXekVtvLhUgBAat8/?=
 =?us-ascii?Q?akyjDPXmfOCR5BgCf6E8UCrFYASFpre7n+CfOdAwj0oLxC0zxJcOewc/21Zk?=
 =?us-ascii?Q?9u3JYbIlNU8/ug35NH7cFx5Cly1Bz2fKzW9kvVHU6hqeZormQ4T1BiNEq+s+?=
 =?us-ascii?Q?gMXiP+SBeaTVoicSv5g6LcCacB5lInhbzWqTKpcKiQQSou9v/RoSBs5fIDRb?=
 =?us-ascii?Q?lymOSNtDdC9WEBNnYGxGgrmEXCbAlHaQTVJ7hoeITqhMQo/74v4vsu16o9rI?=
 =?us-ascii?Q?v8uYltWGeHIbNQJggUdHEYwFEa9oFD05BQhwKj93CSbDYpCU0jSFZW0litF7?=
 =?us-ascii?Q?m7UG0jBP7eAeKDxTGhSJHSqcgR1hTkMPxetjTHRAW77dTUnHbSVUxxwrEtYm?=
 =?us-ascii?Q?2nZh3l5gNI+vcfwQB+sQ0z6t0bF1XX5kxT2zzc0bkvxUs59zzY2nfJ0bkJ+4?=
 =?us-ascii?Q?/C3paByWFNcffZ6vyYcxFIuf2qEKHUA6Mhj/3NZ1r5N7OPMzXNayFR2sXdfU?=
 =?us-ascii?Q?lUxed7ROB4vszOaggG8riRec9lcMjMyih4oIfPqxpHNeQuE8wcrIjVeZJjrO?=
 =?us-ascii?Q?SWyBDkaRmf63R7lc7mcwdQd81WPFF/tHhIe03+fmr5pbrcaOmydKY6bkgwSJ?=
 =?us-ascii?Q?HP0mqEgoa3MvFNf6vZPS54w/LlE5A4AOVGuk4tyxiVrIsQbux2iN+eaLsKmH?=
 =?us-ascii?Q?twcLzVseo7Y2+w84XbEAWK55aVMRblkumL2n1AXIB3A/VuLiwZnNILKwg/m0?=
 =?us-ascii?Q?aHmGlQ=3D=3D?=
X-OriginatorOrg: camlingroup.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bb7df46-ea40-4d8b-e792-08d9d7565124
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB5572.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2022 12:06:37.9886
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fd4b1729-b18d-46d2-9ba0-2717b852b252
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f7S0i1brhG/zORkxB4KdrDiJDBU0+VA4sDmbmceMG9lrHF9DJspEvDz8jPqN9P6KuvUeG4lyWtSDA/FtC1uZziP08uwJEveS4NlrlD8O9kQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P123MB5280
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUK97A341 smtp.mailfrom=tomasz.mon@camlingroup.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: camlingroup.com
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 14.01.2022 08:44, Tomasz Mo=C5=84 wrote:
> Aging timer resets with every received character. Worst case scenario
> happens when RX data intercharacter delay is slightly less than the
> aging timer timeout (8 characters time). The upper bound of the time
> a character can wait in RxFIFO before being read is:
>   (RXTL - 1) * (8 character time timeout + received 1 character time)

s/being read/interrupt is raised/

This description is not precise. The character can wait in RxFIFO longer
than the mentioned upper bound, as the time it takes to actually read it
from RxFIFO is the sum of how long it takes to raise the interrupt and
actual interrupt handling time.

Best Regards,
Tomasz Mon

