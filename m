Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FA0BC7EE25
	for <linux-serial@archiver.kernel.org>; Thu,  8 Jun 2023 11:20:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234342AbjFHLUE (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 8 Jun 2023 07:20:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234653AbjFHLUD (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 8 Jun 2023 07:20:03 -0400
Received: from outbound-ip23b.ess.barracuda.com (outbound-ip23b.ess.barracuda.com [209.222.82.220])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0397F1BDF
        for <linux-serial@vger.kernel.org>; Thu,  8 Jun 2023 04:19:57 -0700 (PDT)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172]) by mx-outbound22-73.us-east-2b.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Thu, 08 Jun 2023 11:19:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FDSf6uJEo9NLbXL8TqZfvZHYkTBPR7XbJqEgUN93iBwCwo8xVVIlWd+UUQVRybDl4dBsmPKWsSGMntsZC6HMPKWExEYwjELQfixXQa9UBSn9bCHpMmEF3VZNihh/fu9F5EFypAItEiUOEdQ/RJxjvS1j05wtZ5dnkVsYkzUzBWlguDXD+vxLtkZps07DEoj8mZEG5buKbIjE8zzWt7SvlcAtdLBrJvhKOfGY6e6poaIA1wmjVoEUOeygIavUOX6HWA00IWYEWzqtNmf0nIvUXT7Hd3VTLAlVvTczhxeA7iaJrFvPBnRv+oDdL3cpTrz3h6CxlhuFVLNFibgeomoi3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=up8JCA9SupJt1+bBXpSs1R3Hku6LZhqHY6NeiFE8Kfg=;
 b=KXcUoDwYZyeE4y/XIgCb2r2LnLuafhgfOXc6oLT+K++IeIU89RLuGjP7lxd5uBvIyEgzBtCERlakjKr0YNxF60PEBtRjbKr21sCB9u97vS4YqxBtM9lPiGo0qhHgnaTo71q+kg2czZpc48MzCDn7X/4LZ33hFOzT7CwIo1arZvLAKJSkAP6ECEpuEFhOJOaVtGrbksJF5yMG+Kj0PLCTh3b6Dof2e0cinzjh2NZQykZAwNjDKO83wVCDMn21j1hjB0Yw0c1VSaXEiM1fAWPcJXvDsF7lM4itbxqGIf1h5jAn17QS2kIuUSU5s1laLgPAOLFliVph9xdF8iimqxaYrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=digi.com; dmarc=pass action=none header.from=digi.com;
 dkim=pass header.d=digi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digi.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=up8JCA9SupJt1+bBXpSs1R3Hku6LZhqHY6NeiFE8Kfg=;
 b=q99KZIgA0nuYVG1yqA+qHdqZOvMrlML27SfMF8IGnQdDc3CaxTDKLsPevdetJLxG+AeEQycuqbQXR/QvGwVN83lbKbKcdZ6ZIqJ1wFmXPBTFuXVyyAvV9HDqgYEpZ255c/zYT0qUmS7AtU7eBFSDMWzoK9jHiGb5PDSw8cXAw2Z/k2ZIHsO3XouOr1L2EjJCLvfPzmXmlN8MoTXmS0dlTYy2Ao8yw6+dVKQT+sshdN5B6WbTuZKBGUSB3W114bBMob7dhI2Mkz0AIrt6suno23QTHkvricgUrgE7FXplteSIHJ3JMSqCRcgHeoco7+t2GUpccr3AX5AnMpGDdQk0Rg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=digi.com;
Received: from CO1PR10MB4561.namprd10.prod.outlook.com (2603:10b6:303:9d::15)
 by DS0PR10MB6726.namprd10.prod.outlook.com (2603:10b6:8:139::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Thu, 8 Jun
 2023 11:19:45 +0000
Received: from CO1PR10MB4561.namprd10.prod.outlook.com
 ([fe80::c626:ce53:befb:11a9]) by CO1PR10MB4561.namprd10.prod.outlook.com
 ([fe80::c626:ce53:befb:11a9%5]) with mapi id 15.20.6455.030; Thu, 8 Jun 2023
 11:19:45 +0000
From:   Robert Hodaszi <robert.hodaszi@digi.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        linux-serial@vger.kernel.org, sherry.sun@nxp.com
Cc:     Robert Hodaszi <robert.hodaszi@digi.com>
Subject: [PATCH] tty: serial: fsl_lpuart: reduce RX watermark to 0 on LS1028A
Date:   Thu,  8 Jun 2023 13:19:27 +0200
Message-Id: <20230608111927.1808525-1-robert.hodaszi@digi.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0255.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:af::18) To CO1PR10MB4561.namprd10.prod.outlook.com
 (2603:10b6:303:9d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4561:EE_|DS0PR10MB6726:EE_
X-MS-Office365-Filtering-Correlation-Id: 64171349-d8a1-4f2d-e256-08db6812435f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lM3hyKg2GgnTcB2uUWMsbnpoNKEPRw36TLzO9nX8OPfOwfKM+OUPOErX9GPvQ1eeFGmO/7kCO1qtYR3PSnVlCIcsYfjVy06ogkYx1AJ3cNqndltpEFfU14aW/EpRKLvn/toIpHjnn7bysrVOryFbEypruiVOCeogpwTiowbRm78f3bGbWywtceWq0uYJZKSCZxNc3VLGbX+FuHj8iYDyeRl9dl2nAK17gQUhjM/PGhPfPip/QiQ1j7oqfF2Tm6wtp8uz3XrqyExJ5Hwz7n8qtr7L7xZjDuSoZhcDHe08F1BkY5CUBF7b2E3N+6jN6S5hOX7Sm9yRgNN1cJcV4fQ5BUjYc+Vy5+PxKE3CbIvlc9B05APXpWhjdaahf6xKy2nfCisJGdK96dx1rPsuiHKT8J+EJgzOpiE/vU/pMAa56J51IdrzPSb39NxpxnFgWJsxY2j5D6Y7rHvkb4Ts1RwNi6k1ShXHNq9oIdW3HCJpGsAp4/ZLmX3eG1v7FemCT73TyJ23eXOPRBMco40S2IOgGMGVR8e2EFV6GQJX75CZZGKE/Hdb4+4ElvgjCJclv3CEaXSmDiV3BKZ5HA61IZiL2WSaXkKQevRy82aXHV8JQWhQ9mG45yIJ+jx/CLnklh5g
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4561.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(39850400004)(366004)(396003)(376002)(451199021)(8676002)(107886003)(8936002)(478600001)(6666004)(52116002)(5660300002)(41300700001)(6486002)(316002)(26005)(1076003)(44832011)(186003)(6506007)(66556008)(66946007)(6512007)(4326008)(66476007)(2616005)(83380400001)(2906002)(38100700002)(38350700002)(86362001)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eOH6whq99JfCmYnwZf19huEkyThxM5ji587f68C8qIskQi38is7CCiNJZSWt?=
 =?us-ascii?Q?cjHSzE3JIxVVSQBTAmvuJgVFl88Oy54PAlGwJwZ/syLraEeXbgK76ENyMpww?=
 =?us-ascii?Q?aLWpneE278PVeJ3f+EvjpVj1WqlKDTUQnjzjac6SVrQqcSt3lr0e0V6R/htc?=
 =?us-ascii?Q?4aGs5F3pbsKd8sSjdYBix3MaTVjtmDGsDFYLR1bMQeTLQd7JQ424KOfkj+Fc?=
 =?us-ascii?Q?zfNCA6MEp6SHYeD94iNipoSnVgAI9I4oHVFNUZo1I7L2La3fnNHPMuwwdCFU?=
 =?us-ascii?Q?+IIVc1CiJUnhgD07OnwPU9fu2ZSjDohK+t8AqhrzuAMgHnm8OBsQuhELQitr?=
 =?us-ascii?Q?x+/4Xag4dIZxQOF5Fe1CpUS1Px8fQ8GC8DFM5AlmSsfXzpv/uj4tB+j2QOvW?=
 =?us-ascii?Q?326gTKC6Xf7OQVFKjS9AxW6EKsqFX7CGMhMCOU1rW5ebgS3VLZfZheqqiIAX?=
 =?us-ascii?Q?xc4kWl+8YkNPzBRnh8ZnsHspn2q+HVlUK83mTDcAFwth0HNJpJ/5p4P3dfLB?=
 =?us-ascii?Q?GEYGKq5l32UQX4f/MZmvCQ1wlyT3jSY3PRS/TcB92kOKlIBOjYvB0rljFCdj?=
 =?us-ascii?Q?FEWQ9TJzgt9LxJOvav9ki2A0UkuvNXpRpMUZS+gVhjOqeeNpUIQix69cv6cb?=
 =?us-ascii?Q?0gms9NTlwBjcAw0Ry2lI4mYMoHS1OM8tVjG4IPefc34vCQt/9MZM7rjKNXsT?=
 =?us-ascii?Q?FCkD2NH4LdhRVc5agjo2C4IM7ZkUue/qJu7Uf60PLVrdGzzBQG9XL7uy90pd?=
 =?us-ascii?Q?d4v+z6F5h1rzyAr2/hICqsgEVAQ290aaP9OXmrkKLGOWgM/fsYytqQIFqaBH?=
 =?us-ascii?Q?ijY9+qM73uCAd5KSq2oHn9500oy52UQQZ4ET2baIwIYc3YSkyYmK/HA+tU3o?=
 =?us-ascii?Q?ljPGitl3PAJSw8IIxaDSAmiOGrulQ16vvNppthNWVpZAubL/f4+PUV/BpV1w?=
 =?us-ascii?Q?nPZhenPQvuzXUn8LxDgCm5JjA01eLw9hk56pOnT0N6et707hsoGzwl8hNozK?=
 =?us-ascii?Q?G4jlG0X9xvF87HB/agC4MbMvtb7BtjEvC2MBF30/t6+rrKSS9iNeF76ffwQj?=
 =?us-ascii?Q?7FYuNZX7Q2FXUHAEFF46+Mj1v/Sdze3a8ZC/UrW5Wc8uuPIYQW+w8qSVNqQL?=
 =?us-ascii?Q?mZi6Gz0ALYisx9inrOOp4CwzCwir1FQxliU/kNwOzNPhVoenLx6fxUHgxVn+?=
 =?us-ascii?Q?O42zMypt2Z2Ob1vplVx1wUUmzgRDMowfZS5y01q9cpZn46Kus265LDBJTpxH?=
 =?us-ascii?Q?0guCB+Vio6V5MKotkHwzrLOvQqeyYmcKQjuGXUT4Z7sCw19fy2wK6zYMxcjH?=
 =?us-ascii?Q?jkHYetxNpQKl2QNQEfUH0ODNw8lT12b+okUzpb5mDzsYbo7L/MsVrAxHOnUc?=
 =?us-ascii?Q?W8ZRZPkrM4o7aamVBeYi5a5DPB9w03/k/cGKfZLzJ7nYia7bfBuij6wiew5I?=
 =?us-ascii?Q?kWin37vENmx2iQnNylrTa7qLIL+H9y7hX/KRmx7ucspshOruImYlXGDpL0Ce?=
 =?us-ascii?Q?lm8WPQvPLozl5i4qLzYTtGm27TepkoJFUQIqfBV3zwCmoalhbansconYgQqk?=
 =?us-ascii?Q?dHRFipktUF8OK+C0v4p9KlIiwzN86KkUE2ArglGG?=
X-OriginatorOrg: digi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64171349-d8a1-4f2d-e256-08db6812435f
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4561.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2023 11:19:45.5344
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: abb4cdb7-1b7e-483e-a143-7ebfd1184b9e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jfYTCx0+J8KRJGr7vtNumb01a/gsApYBsMvAC3rUMoKY0hfw45sYUiyjnMt7HYDJyhDZE4y5QlycHoNS3LEliQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6726
X-BESS-ID: 1686223188-105705-5420-1090-1
X-BESS-VER: 2019.1_20230525.1947
X-BESS-Apparent-Source-IP: 104.47.59.172
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoYGluZAVgZQMDk52SI5ydTCyN
        TUxMLIINUkycA82SQpKckyxcTS0MRMqTYWAFm2W5BBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.248674 [from 
        cloudscan16-158.us-east-2b.ess.aws.cudaops.com]
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS112744 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
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

Signed-off-by: Robert Hodaszi <robert.hodaszi@digi.com>
---
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

