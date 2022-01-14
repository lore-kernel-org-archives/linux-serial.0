Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57ADFC433F5
	for <linux-serial@archiver.kernel.org>; Fri, 14 Jan 2022 07:44:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbiANHoQ (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 14 Jan 2022 02:44:16 -0500
Received: from eu-smtp-delivery-197.mimecast.com ([185.58.85.197]:52849 "EHLO
        eu-smtp-delivery-197.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230403AbiANHoP (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 14 Jan 2022 02:44:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=camlingroup.com;
        s=mimecast20210310; t=1642146253;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=UmZSizZC3Y98wYG05A3e909OMWQddcE8UBKKAYZZ3TI=;
        b=hkgwn6elTBIGMiqehumVTAbK6HI6juLkIR6ciUl2+Ed5eaNGniECJWDmVBJ6ColZKeAT4k
        35ETLkfh7ySNRFJ30nAsGVCcXx4BvgkYU+DYzQpAzDwbk9gg2S7z6DBoU0eQ7qcd3ysz+G
        5D9HDbOcHKuwmVV9pE/qQHA1u57qkOg=
Received: from GBR01-LO2-obe.outbound.protection.outlook.com
 (mail-lo2gbr01lp2050.outbound.protection.outlook.com [104.47.21.50]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 uk-mta-274-o2BJSJ70OtK21d45WEGrUQ-1; Fri, 14 Jan 2022 07:44:12 +0000
X-MC-Unique: o2BJSJ70OtK21d45WEGrUQ-1
Received: from CWLP123MB5572.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:16b::6)
 by CWLP123MB3585.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:93::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.10; Fri, 14 Jan
 2022 07:44:11 +0000
Received: from CWLP123MB5572.GBRP123.PROD.OUTLOOK.COM
 ([fe80::4c56:90c1:1ed:2ea3]) by CWLP123MB5572.GBRP123.PROD.OUTLOOK.COM
 ([fe80::4c56:90c1:1ed:2ea3%4]) with mapi id 15.20.4888.012; Fri, 14 Jan 2022
 07:44:11 +0000
From:   =?UTF-8?q?Tomasz=20Mo=C5=84?= <tomasz.mon@camlingroup.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Jiri Slaby <jirislaby@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-serial@vger.kernel.org, k.drobinski@camlintechnologies.com,
        =?UTF-8?q?Tomasz=20Mo=C5=84?= <tomasz.mon@camlingroup.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: [PATCH v2] serial: imx: reduce RX interrupt frequency
Date:   Fri, 14 Jan 2022 08:44:00 +0100
Message-ID: <20220114074400.3417233-1-tomasz.mon@camlingroup.com>
X-Mailer: git-send-email 2.25.1
X-ClientProxiedBy: LO4P265CA0001.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ad::14) To CWLP123MB5572.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:16b::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 50b16d71-6db4-4b0c-42d8-08d9d731a7aa
X-MS-TrafficTypeDiagnostic: CWLP123MB3585:EE_
X-Microsoft-Antispam-PRVS: <CWLP123MB358515FBD715355AD5482F9E92549@CWLP123MB3585.GBRP123.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:586
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0
X-Microsoft-Antispam-Message-Info: vkGwMshj+h9E8+LXkdwKtGFtaPexy81Ck0+2+29Yzp61reGT8BnGrqOTltwN6zf0IVfFwqgFgw/YymDJb0q/ipuULez4zDVn5R57dp3ndTXyYK+wqKCwB0GWVwr5HFdIs+el+eFk8bfnvH4C6KCfGI6gVMmq/t/0aNtW+BPicg4aRjRPnHRfXuJ3LGK2D0hFuAfWhnFDbMkoPAnWfiFTBRH5UgJ46Uwg+1cF2IZW2n+WMM/cWavKXhMlVbU4J9pJPvxOvefBLl/F6WlZ+1ChKe20bpyU8ulOHDG7ihvSxdRIXRN2CSpUKEvxeEYUmNoOu6or3FuCc0FRCPjlh5re9pZqt4nQ0tXdSg2q2lYj3ZGv7Up2IOifa157jkY+bjl95gzwZfh9yF6IEWSvCUumQd08SjRv8r7IrTkwctOu9uhYqKGOPSaRjgzsfijWeykYvIkLrI+H5qmra/mE+qTSGDcWGgFvCCHu8f1OZMHpMsYG0gBUoy+TTi5axpKamIrTjLwiCNpl6IjH4uKTCIDFzVyaXEKnWaOuYIjhWiPXfttk4iJCguCz2/jBMUbFN2pDGwn6JJM3rEsbbZQvrpiVvTz6TpBOdOVrOPenIOz9LSd+RaJzdewJjQXevgwi9EzAi+lAez2n6guwbCB/FW6TyF6z1tBvUb1OS1k8CfJ5aCVkMJQol/KDs73SwUS0GYkxz+kFT9Bp/q0P6vYpQIPEVK8jKq7SfFefvAw3J3F89AYRhVFKOUJvdz1TmUu+pmq4Cnfx46JEpyJt5t2q+ALVpCmkhQHSWAzqc4G9zL9sizk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB5572.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(366004)(6486002)(83380400001)(316002)(6916009)(86362001)(38100700002)(5660300002)(6506007)(54906003)(38350700002)(2906002)(52116002)(508600001)(66574015)(36756003)(1076003)(6666004)(8936002)(66476007)(66556008)(966005)(66946007)(8676002)(26005)(4326008)(2616005)(6512007)(186003);DIR:OUT;SFP:1101
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SfhlYi3C7PamaO34Xsvpu/9N27UTW3ESuIBO4bUZkqkPyYoVMoccnKNPP3Ow?=
 =?us-ascii?Q?B2XhOCOgik3NtikL79/1j48hgH35qQLWtgP6uyarMvguAOotDmcmw8M7bqm+?=
 =?us-ascii?Q?lvMzPSTeakgcV3SrO9ObhoMzOBauQZTeCbNMWywOzuJW5CpoT4kcjK8qZ2Qe?=
 =?us-ascii?Q?LaW5LmhJYRRV+xVTNBQPk5wQo5ItTqY4vtXBxqa8mtAhoytZxS3HgD7RXJIk?=
 =?us-ascii?Q?A727yOhSSRcN7pY2L6PzW6KKfMKwqyHrB1a82aGF9SOF+3wUV1wNHfd3ffbN?=
 =?us-ascii?Q?KWyxVd3nsrC7morInUPmSGur+TFLpWaeD2N4xTEBdMyhykv2AWdDVnU8j2I0?=
 =?us-ascii?Q?zX91+s4FueN7r50Cert4pTc/IUbozYdmVEWMESmvKbdA5yxV44+cy/YCgkmJ?=
 =?us-ascii?Q?yQ4W/BP7sWSJlMlsfe+/3DLwG3NrDG6pOviMOwTsO9hHgq+/siHauGBKARFJ?=
 =?us-ascii?Q?WhBFSTRAiHtp1xzf4h5/wo0D5omidnaqsWTVW3TCcdwVR1vFlXynpfAbb0p/?=
 =?us-ascii?Q?9C/7Noa1l6TgZiabxh7Z47KP4zpK2E7yXpQP4ymzKew4VWAHZlfmntUGPzUw?=
 =?us-ascii?Q?EoR3H+JkrKrF3MwTUs2b93iB9P+iDsF4jOVri55hSbLJ0bkjXR2ZCFvR7u7P?=
 =?us-ascii?Q?+kBZ4ID3yUsBmEsX6Wq1oM2VVLFWYbdRwhhuuKv8SY8WuMwGLhW8sIYTKAOd?=
 =?us-ascii?Q?KD00uspK3+dxUICwSgM+GjutYu8TtLRqp/Bzx67BGlVzLvUb5qFkCFStb6Ll?=
 =?us-ascii?Q?B94Tv7gPRmQyMVm5k4IsZPMY/00nG79r+esKlq+d/USXLG9pgD15serHe5O3?=
 =?us-ascii?Q?hbcy9d9DN0y3fGhaOo19IyNimuqHoG4O7+jX5nLUXLsOSePczlWSejpYg86F?=
 =?us-ascii?Q?JESJ1Uv4U21nYX2P5ahMOoJavWiT2fPYg2P+lp/MEe1OZDAj7CGuFdM58t73?=
 =?us-ascii?Q?gRYfCdWMIf026kVE32owZy1Skh1MzWPRab0Y/3D1JOPhmG8v/NGGfBK9HlG1?=
 =?us-ascii?Q?mt99CW3m9lLPHzIRDpi0H0POieNtpKoW4lKYfwoWIYyAzCYtv5vQ1/d9Ygd9?=
 =?us-ascii?Q?iAInv7PM/KMgmJnCu9ad+bQ8s0SOsJG7uen7ksFpCFl7em11Lkzz/tuRlOKS?=
 =?us-ascii?Q?63zZ0ib9iasBuurd1KC2M7Wea2L+6vaIeovl5zDuh3UTCg5FBgsTT6aD+s1N?=
 =?us-ascii?Q?5qW4EE2RAt5bFnJG7zV0O2MQdZnAH7ujmdCQuzEZdl3CLkvTHmmj7b5O88Bl?=
 =?us-ascii?Q?A7G9P6y0it/jBRPDTasrTUTeeb9EnZqQsu6Qo9GAE2XxlGH7arP5i8EBzQAR?=
 =?us-ascii?Q?61VN8mQk+nqxDr0DNjjfYlVDxNpDpjufghAHV5mnRf8r5Xx3D+vFeECXlsee?=
 =?us-ascii?Q?U18AYihPJqCSZvmDqd8aG+0lJ81uNefU1vJix8730T6JBkxLvqDu0YgV1dug?=
 =?us-ascii?Q?K05bOdVKxQ8iq+O3ZUeRUQDqz8K4vBHgTkCNk3ceindB5DtWvhvMO6kGNvQv?=
 =?us-ascii?Q?ss9oKwrdqj4Eqmgm4taUmqBuxRgikqBPezmyzcNQXVCJ8KUPyIwOGTp7gKsw?=
 =?us-ascii?Q?Ux8FVM1/yrNKkS52Ztq/+KrzfyZCHsiLzfOqyfrAjjC3g37tahSmhI/jOndU?=
 =?us-ascii?Q?lsqv1ubpAsSIoYvSksTmQqx7+KTVT0kshpIKh7cURbopa6D5p8svvrJju5Qc?=
 =?us-ascii?Q?742C0g=3D=3D?=
X-OriginatorOrg: camlingroup.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50b16d71-6db4-4b0c-42d8-08d9d731a7aa
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB5572.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2022 07:44:11.7520
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fd4b1729-b18d-46d2-9ba0-2717b852b252
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OFtxC1iomVA4x2rENj8IQbDhgmhJ6fTjV7HYTim3ASIFvJ4zARr5DeQx077cIQC63mK+5OmRCaluhK+QU+JCG2yxuaNpA7SBN6/JhfVryg8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP123MB3585
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUK97A341 smtp.mailfrom=tomasz.mon@camlingroup.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: camlingroup.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Triggering RX interrupt for every byte defeats the purpose of aging
timer and leads to interrupt storm at high baud rates. The interrupt
storm can starve line discipline worker and prevent tty throttling,
rendering hardware/software flow control useless.

Increase receiver trigger level to 8 to increase the minimum period
between RX interrupts to 8 characters time. The tradeoff is increased
latency.

Aging timer resets with every received character. Worst case scenario
happens when RX data intercharacter delay is slightly less than the
aging timer timeout (8 characters time). The upper bound of the time
a character can wait in RxFIFO before being read is:
  (RXTL - 1) * (8 character time timeout + received 1 character time)

Usually the data is received in frames, with low intercharacter delay.
In such case the latency increase is 8 characters time at the end of
the frame with probability (RXTL - 1) / RXTL.

Signed-off-by: Tomasz Mo=C5=84 <tomasz.mon@camlingroup.com>
Acked-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
---
changes in v2:
  - reworded commit message based on review comments
  - added Acked-by by Uwe tag from V1 review

v1: https://lore.kernel.org/linux-serial/20220104103203.2033673-1-tomasz.mo=
n@camlingroup.com/
---
 drivers/tty/serial/imx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 90f82e6c54e4..3c812c47ecc0 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -1255,7 +1255,7 @@ static void imx_uart_clear_rx_errors(struct imx_port =
*sport)
 }
=20
 #define TXTL_DEFAULT 2 /* reset default */
-#define RXTL_DEFAULT 1 /* reset default */
+#define RXTL_DEFAULT 8 /* 8 characters or aging timer */
 #define TXTL_DMA 8 /* DMA burst setting */
 #define RXTL_DMA 9 /* DMA burst setting */
=20
--=20
2.25.1

