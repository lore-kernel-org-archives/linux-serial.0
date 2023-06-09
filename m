Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89526C7EE25
	for <linux-serial@archiver.kernel.org>; Fri,  9 Jun 2023 12:14:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240220AbjFIMOJ (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 9 Jun 2023 08:14:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240221AbjFIMOH (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 9 Jun 2023 08:14:07 -0400
Received: from outbound-ip23b.ess.barracuda.com (outbound-ip23b.ess.barracuda.com [209.222.82.220])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50C52199D
        for <linux-serial@vger.kernel.org>; Fri,  9 Jun 2023 05:14:03 -0700 (PDT)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169]) by mx-outbound46-9.us-east-2c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Fri, 09 Jun 2023 12:13:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AbNqR8CM3ZY0SqzEYJ6GvXRw6kKgC/LfKr+nAGEC9uvlOW9+N9giBSxBvonB509lJE1U5MD5wlOGs6JBwiuZaNlZpr1eTk4OMdyQYnl26FiQTwazNG4SHjTmUyW4ApiskDF0Seivso/iLR9FX1oFdc96HDddKFwRRITv+JDHxE3OkNbQGf7b9ciJc2x5OxnT82AvPjUo17rmIWcO3X5YQAmc2xV7J5rHPZi4n/LBOLXk7OyUu3c5PGgHX9likUUGlq9Uhs2UCnqH/hDTDVM2r5vrgXzso2h8kZN95kWsJffTnGTPdVfO1HYevvWXJ3JGyAa528hWEGgFemgQhDisKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hiJ7zH8GzHxRdA7QRi1BjVVzwCQTmBEzvGh6TwhSTCo=;
 b=N1tddcXOfQbA18L56BI2M8PmSddSxPJzr30egcLNgeqWcA7uPlTi0KCuuD9D4vO3V/uJCZIgVDrxwArys72zMSPMX9kHRzSEX5C930Qg7hyA1450wG+wFhfJPq1XRy9GGnMoqC7AoPQqf4r453m5Vgq3GwnloCBTW5d75c2OJud8hJ3u2t8uTbaiOkNG7V2Z4ZFF6Lq8FU3D4ZnGm0CkkQARdOyfuv9KuMwju+aRtb5s45Bfnmpfpyi+UnCUbljJ7uxnnWEe9iVEFT71uZj8V1xHLqtn1qeDyro4e2km/saMkPRdlTqTY6Xx2m5nrQaycWOd2NR5sO3ZF/lRk7Vyqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=digi.com; dmarc=pass action=none header.from=digi.com;
 dkim=pass header.d=digi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digi.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hiJ7zH8GzHxRdA7QRi1BjVVzwCQTmBEzvGh6TwhSTCo=;
 b=mPpVCTB3UaDg6ARcMeLqg3Uq3vf2CS9RbRtrGeWIkLO00Vf9ne5prWcxVtRwjr2MIsSWfoYC0jGS91MrnrRf+vwTORi3rtfo/yTrli+b3by/SvI/7SHRo2ACVwtgxB7qlgCTh8FKVWVFDewHJ7zeu/DVkjK5TMND1tUX06BiD+GVcPBwZMUA/I5hTrnujRhIRywLHTndpBrv+GhvoDOvv5N7SzcOiIEvQwydVML16f5eWEuFt/81G8dLcyUMqcDjdMq9St84udqPOtY1JH7smigJadUudmflMJa7IaXIBMa+XQrbWOiUx6PPEdZDBim8dqKvG242eiI56boe8R9rKQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=digi.com;
Received: from CO1PR10MB4561.namprd10.prod.outlook.com (2603:10b6:303:9d::15)
 by SN7PR10MB6641.namprd10.prod.outlook.com (2603:10b6:806:2ac::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Fri, 9 Jun
 2023 12:13:51 +0000
Received: from CO1PR10MB4561.namprd10.prod.outlook.com
 ([fe80::c626:ce53:befb:11a9]) by CO1PR10MB4561.namprd10.prod.outlook.com
 ([fe80::c626:ce53:befb:11a9%5]) with mapi id 15.20.6455.039; Fri, 9 Jun 2023
 12:13:50 +0000
From:   Robert Hodaszi <robert.hodaszi@digi.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        linux-serial@vger.kernel.org, sherry.sun@nxp.com
Cc:     Robert Hodaszi <robert.hodaszi@digi.com>
Subject: [PATCH v2] tty: serial: fsl_lpuart: reduce RX watermark to 0 on LS1028A
Date:   Fri,  9 Jun 2023 14:13:34 +0200
Message-Id: <20230609121334.1878626-1-robert.hodaszi@digi.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0123.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:94::9) To CO1PR10MB4561.namprd10.prod.outlook.com
 (2603:10b6:303:9d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4561:EE_|SN7PR10MB6641:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bd29926-85d4-4ebf-d63c-08db68e2fba9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JQgL4rhWSs8RUeiC3bzaMgOUHCa4M5282V1F3zQo78n+SOQXGmEbE1eWrvgNIvzHrUuPaqjLeMo/jsje40cJ5iLPMK/tcxVmL02flkE6i3P6KNb1D6Hxu+TwQLw4Ty6kyON6wASZLYmcf/p5YWbTRPQ/BYTMY9bQayBfBkz3XMHN/lqHnWU8Ur3ve1hCn07DL4AzR7WxLRrluXBxDIncaP9rcyItCWikzwS+P8fnXjjqRYx9yUGVW5GhfKQYe8T+wp1r1zZRt0/CwcjsSWtxoei3OkDSnlcvs7qXJmVzGLW7X1YKYLPg8uG8imDyP2aJoEcLsXj6EMB/iRR9AIl5KBK0j5FoGxq3ua7Jz389eoGYKQ9xv/NqxORu0XKcM0+y1oPxDY1bDZGLLppGhp3GG+M55peZfCT+Ck3Kpe9GD7sAw0KxrhWukKOBVkc0mKqCsUfn6P48Yrpm4+kbuBu6s9IwD5zdqpBJNWSXh9qKLj99pS7HSVv6bcFKaNvkiRWZ6MksPsWi7j99X6gEYsG/8nFwHWTXJj7NpJ7heBJDGkSUo6gHxFIUGtSaZxNBofIpZM2L3ddzajstrMm00TQn7wheAqeKZ1R+ufecGUpmfvc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4561.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39850400004)(396003)(346002)(136003)(376002)(366004)(451199021)(86362001)(38100700002)(38350700002)(66556008)(83380400001)(66946007)(2616005)(66476007)(4326008)(6666004)(6506007)(316002)(26005)(478600001)(1076003)(6512007)(52116002)(6486002)(44832011)(41300700001)(8676002)(186003)(5660300002)(2906002)(107886003)(966005)(8936002)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HIF+DdFfv4YiYLBgpdsogc1Z9e/X+uxAJq7cGO7MdpwuyW6odV1eKjDMvAB/?=
 =?us-ascii?Q?pg6yk9uW129by9ZFrMSLEhHtHef28EqJXlJXSDzc27CwkR9x4e2ljxoaSwUf?=
 =?us-ascii?Q?4D3M62bKHkDd4hyQDJ2a4MCFbkgpgF49BvMQO3IPJD8PR/r+VSN6rNMAYugX?=
 =?us-ascii?Q?crxX8etoywTXbFd2sq1uX1HEW9kExdED/ZImTG1RlXBbMyR1Cc5rxYA/KhH8?=
 =?us-ascii?Q?S3W0CmiRKejc54jG47qlBUD5FSNAKjsu9S5j12mIAoox/8r85t/0GaoDITma?=
 =?us-ascii?Q?GNy13x79KE/UadKlYWufx9OiUy+PFuzpcnSYGix7LVmesTM3jIQeDVoEEMOt?=
 =?us-ascii?Q?7+q7sK0X2edvsfL6P3BeS1iOiUEh8yDZgkCEaeTRagQqQjrdn1gQwoh9+1Ov?=
 =?us-ascii?Q?yVfSFx+YJ5GPnnBiN5BpEhOKf9BGh1lHu0N8cICVFOKcwYadFn5c4hakxQo1?=
 =?us-ascii?Q?/lp7pcitkR8+itQoWeHDIvvKWewWT9wj4oggHeGUd8GkABGDWe/HQhYc1Y0s?=
 =?us-ascii?Q?44ehYBx88QTSJbhXyM6softEBP8przXjg1qJLogo64Nip695BiIhfP3CRmZA?=
 =?us-ascii?Q?2QqqVfyYdtrOZRVrHcaXZDwLYxbqUBxMXlAMfSc4DRpZZGaMEdZEfkfNI4aG?=
 =?us-ascii?Q?/8S7FpCgzjnT8dbqm+xYoTkAaiu9sJd6bEQw+Du+rBDBV5lJsFjKU5ApXqkd?=
 =?us-ascii?Q?BIy3ueGYKhyzwN52d9sBaQQ3FuvBj+PkW+O2gvITTUXslZfHD9vYsBvULOa9?=
 =?us-ascii?Q?xq9k694rYTxpA1n7iZXRrIhYqnXrZeK/SZKgbHg4tE4e+nhdLLyeCzQcPqRe?=
 =?us-ascii?Q?WnS+qDuSjhlBKWADeGPdSkuhJWoETnSW28rw3JTiOqp6eMEEKHZ9kCMXBENe?=
 =?us-ascii?Q?iXQDd38vd9ZHnstJ1A2gBVT2fEBP6uE9OCCqcuXWHJ9lpIrhViMJojy+lKA3?=
 =?us-ascii?Q?fxDcL+nrgsFz4WgMkntVNNec3ujJhmRvhsPOwWnrbnvg66Ce7/cXzXdghKw6?=
 =?us-ascii?Q?GZ3OA9ZYsn6i9UsRFWymBHo/ZSix6Nl7IHWVhL09Tg425x+0CgVAH27r2Lid?=
 =?us-ascii?Q?0x4WNlMQRxttL5TFFK/ImeaptTDH2BEYmLt5CM2kjYyqOfvaqGcwrzkEHON8?=
 =?us-ascii?Q?6f31vEKk72ZGZamIuZ6bXUj3vfGNRUExCEm3O5/rP5HzJB2JFO0Cut8BT4fA?=
 =?us-ascii?Q?0X5x90ioG6i03roH4wex8tnHIjMTjTBEHqsv7L3mc7cjJISKtYlH4QqFYL8n?=
 =?us-ascii?Q?GE16Lg+G60chlTjUln3Aq5b5l4d3MrSN7r6WDQzNKMFj9VffaEG0IO3YL98L?=
 =?us-ascii?Q?bya3TYF5It1u+2+bcC2YsRWguhsbN0itbILWLMhUtkTF230xXbk43VFKq+a8?=
 =?us-ascii?Q?x8g2xLVqbFXm8j0mJKpoemz5J7RZiUElw1aGV5IeMVIyBC1l8e7Imz6k2vFL?=
 =?us-ascii?Q?CkEyioQ2kF3PX3vivTPNMe6YHPjiuoHBXMWWyT8fyDRhOxT2++nasR15e1Kn?=
 =?us-ascii?Q?Fb8dD5A2giuKqECna6uzD65dS8WxcZ48618SXAne3Vx0fdjtMUvJZLJZYhN/?=
 =?us-ascii?Q?deBvPzow0Cx+mq+YiXS7XWseWzbn4OdKH6yU59Yw?=
X-OriginatorOrg: digi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bd29926-85d4-4ebf-d63c-08db68e2fba9
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4561.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2023 12:13:50.1728
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: abb4cdb7-1b7e-483e-a143-7ebfd1184b9e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +mWHHKPN6FAO7Wrj/kDjLNJYN3Hrhd+N7eCqQS3TsV85rgQ9/+eyPGJJL180MdrHgl2zaA7ZQn6T5jIkOjkGFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6641
X-BESS-ID: 1686312833-111785-5463-9084-1
X-BESS-VER: 2019.1_20230608.1643
X-BESS-Apparent-Source-IP: 104.47.58.169
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVobGRiZAVgZQMMU4zTIpyTIlyS
        zZMikxzdLUMDEt1cTENDHZ3MjY0CJZqTYWAGvbhhJBAAAA
X-BESS-Outbound-Spam-Score: 0.40
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.248699 [from 
        cloudscan17-22.us-east-2b.ess.aws.cudaops.com]
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.40 BSF_SC0_SA085b         META: Custom Rule SA085b 
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.40 using account:ESS112744 scores of KILL_LEVEL=7.0 tests=BSF_SC0_SA085b, BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

LS1028A is using DMA with LPUART. Having RX watermark set to 1, means
DMA transactions are started only after receiving the second character.

On other platforms with newer LPUART IP, Receiver Idle Empty function
initiates the DMA request after the receiver is idling for 4 characters.
But this feature is missing on LS1028A, which is causing a 1-character
delay in the RX direction on this platform.

Set RX watermark to 0 to initiate RX DMA after each character.

Link: https://lore.kernel.org/linux-serial/20230607103459.1222426-1-robert.hodaszi@digi.com/
Fixes: 9ad9df844754 ("tty: serial: fsl_lpuart: Fix the wrong RXWATER setting for rx dma case")
Signed-off-by: Robert Hodaszi <robert.hodaszi@digi.com>
---
V1 -> V2: Add Fixes and and Link tags

 drivers/tty/serial/fsl_lpuart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 7486a2b8556c..7fd30fcc10c6 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -310,7 +310,7 @@ static const struct lpuart_soc_data ls1021a_data = {
 static const struct lpuart_soc_data ls1028a_data = {
 	.devtype = LS1028A_LPUART,
 	.iotype = UPIO_MEM32,
-	.rx_watermark = 1,
+	.rx_watermark = 0,
 };
 
 static struct lpuart_soc_data imx7ulp_data = {
-- 
2.34.1

