Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC072C433F5
	for <linux-serial@archiver.kernel.org>; Fri, 15 Oct 2021 06:51:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EA2160F41
	for <linux-serial@archiver.kernel.org>; Fri, 15 Oct 2021 06:51:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235662AbhJOGxj (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 15 Oct 2021 02:53:39 -0400
Received: from mail-eopbgr1310090.outbound.protection.outlook.com ([40.107.131.90]:37600
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234400AbhJOGxj (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 15 Oct 2021 02:53:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GvLeJrs6HTWUqEiOECo5A1LuKnocC6EaVJ1BwlDMJ7n2DEqyAe+6g38fuFLMGxwbckzOrmibeJTNWb+ckHBgelrkYnR1XqFkjqyDiYEgCSC0HVDWjGciPVDeqMPaw/HMIRFeOekX3/avdXLkBJZn4P3iMz8GkpUSWt2yvpJU7BGvkJeWWyvtqvYwkEE6Ix8MlOnKaTL92pAHsgxfThvab6BjwCnH2WQ/SmsYZm+3ds4/9YLI4WLXoXcpy+tW793yElE/G5YbMo/XnlqUYjkKvmm5yb+OI1GjCUDpAJkUa3TMiaAna1ZUafx0VmPhwM4GQHDskWcDkMv0YyaVQJ2IRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YG7BUZSVe+LwsTJ2vA1sHxcdan5uuhYJmBcKPouVDnA=;
 b=kGYuaE5/KYTrNA9iJzZJ3++ACo8KUr48PAUo4VFVzr4xRLOv9WvTp8MDSakUV13WDXT7jsh9Smj7y6ArKhUP2zKRSLfvk7g5TCXU+u8ZSvirMqpGyoZ7zreRATsJ6lDfo7xVdKKgn3/EfeuvGIBDVVwRxvYYf6EcLrbdE3JDGeMrLabp/CzfIh6WaX59/zsZRTMKl1f0sJe/RrgsOjwbB5W8o4+s+UgL36ChPeHTeAcpx9o5vmCxFhbhWk6pPPEMdR1O8Pgy4jOpLgG4WcwIROlR1X2d4hAWhxXYAcBpYF5AjUOF48X48Cr7gHYSMMCs8tmX4R2INH5i7pZtaKhN/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YG7BUZSVe+LwsTJ2vA1sHxcdan5uuhYJmBcKPouVDnA=;
 b=mj8WW4/SKy3WpSGEaCm3ZsQnb/cjBnPgZ2qxATHM7ZBPr/Q+kGwV4svug41wUyInXdxYGBzR/PmXsNgFuHWrNS9fZB542jX3KzyDyafF7HM/NcqqU24aFw4fW130MLqlzKjP/MJ8HEfCtleSNrCYzXxxMr6lQDRuRVdt9UAaFok=
Authentication-Results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=vivo.com;
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com (2603:1096:100:37::17)
 by SL2PR06MB3003.apcprd06.prod.outlook.com (2603:1096:100:33::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18; Fri, 15 Oct
 2021 06:51:31 +0000
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::4c9b:b71f:fb67:6414]) by SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::4c9b:b71f:fb67:6414%6]) with mapi id 15.20.4608.017; Fri, 15 Oct 2021
 06:51:31 +0000
From:   Qing Wang <wangqing@vivo.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     Qing Wang <wangqing@vivo.com>
Subject: [PATCH] tty: 8250: replace snprintf in show functions with sysfs_emit
Date:   Thu, 14 Oct 2021 23:51:22 -0700
Message-Id: <1634280682-5002-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: HKAPR03CA0010.apcprd03.prod.outlook.com
 (2603:1096:203:c8::15) To SL2PR06MB3082.apcprd06.prod.outlook.com
 (2603:1096:100:37::17)
MIME-Version: 1.0
Received: from ubuntu.localdomain (218.213.202.189) by HKAPR03CA0010.apcprd03.prod.outlook.com (2603:1096:203:c8::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.4608.13 via Frontend Transport; Fri, 15 Oct 2021 06:51:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a257fe8b-46f4-4097-2c38-08d98fa837f1
X-MS-TrafficTypeDiagnostic: SL2PR06MB3003:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SL2PR06MB30037436715C6FEB4D741026BDB99@SL2PR06MB3003.apcprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1107;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ozBo0OhRK7PksXBCUEnEQERqLZ2uxeto9t/OJKLZ7IpgLnd0BecGSXZfiHQ1LDrSNuzq2jii4UC1CY6XXJfZBhWdRvT75QP7JN9Y7iwtrID9TeWRre+P7VkVAsZOa3QXjKn7q94aJ504BZlAMOC9zQpHwPHm3AavHYsfgbRONAmjxTi+8gkpSbPRtKjcoEJs0vFLDehtujvrkO903t31yuggpL41ZYdUgNl1kN2XccguoK0i0kH3CS4Ez32KAaVQAXsQhQASncDZRkWerqV0pHqx2k893z6NY+nf9GTYJYpqituhFvIb/akKMCyjd3MdgOhmZPZrxmPXT2aQstU31bfGVtTGHj01tTJLnphPtyBj+GCkV8UyTOIEg1eR5wWhpggCNR1ziZSbC1DiMBVGJffe+luYB6KVN/VvI+QNcXw8SdueJH+unfVHOu7n+R3R6UicQp/Kh5RD19JSEPQDejeAWx29gdKqpC50pZO9qs5YqmLe9WacT1BQ5ZKIJ8nPs1EByFJW2TnQuDpB8WhKmjwX0DBpKRV3/SEhXXyG5n8w1HkjPXO7ViLaMi672dufGQmulFWl2TA3ppsYe+0vB1ltC/6QtvhvnT/4anBa7QwLdtUpwbvj/DgpUZCkR9b/P6CvsmLDtqb2y9UvfgDlkS20qKDOKOS1IX8MCCSosiJEQ1n3MxsQ9Ga9NZyiD0t8KvJZtiBOruRfiIvSUyon/w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR06MB3082.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66556008)(5660300002)(8936002)(66476007)(83380400001)(316002)(2906002)(4326008)(36756003)(110136005)(6666004)(66946007)(86362001)(186003)(956004)(2616005)(107886003)(26005)(6512007)(8676002)(508600001)(52116002)(38350700002)(6506007)(6486002)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kzVgKVc4+4vzU6uWdm42dBlUVvJ3i2Qarf8uGIR0iBPapz4+8bul95l85ofK?=
 =?us-ascii?Q?idDd8dv6NqsMGeOd5HwQRB2QB9vxoxGnlTQnEQU/BY+oFhoH/PZDC1jsjIX7?=
 =?us-ascii?Q?eTlwscnHTookMX3Yw64ORzj6hJgjKe5YJ2/08+dn8ZBSj/I9ByjdZA123ZxR?=
 =?us-ascii?Q?9GkY5GAReVdb3dfIwXruM9h7BqAx1gtB37t26O3hOVIPpqcDIwMNp/yxWP30?=
 =?us-ascii?Q?ia/8ukQw9qyANvVtL94yrET/qEhFXMmTrL4wL6v9w+xg0KPzXN93DUopG9uS?=
 =?us-ascii?Q?u891L0PTKhiedjfrZoz/GQSq+QuXt8hdtIRkKgMVVA9LOS9QtYfhgrYtOryI?=
 =?us-ascii?Q?A2XNWRSqQRAfkahYHAp47REm4psUGZuGzGEglJmS67OdhkLR+hRPXKGNFA4l?=
 =?us-ascii?Q?EXowjifMv+xYnHza9O6Tg6MEIZydOyisSFTlxU+IjHp4KIVdlYKam66ymSo7?=
 =?us-ascii?Q?lnAM7Iax3ElPbxSMKrlCf4ivaaj4iQJnnsGrCxRwoe/CZNzx5DZlwDZKsqhS?=
 =?us-ascii?Q?4LRk86Oyp4NxZoegnErjWPLF9UquRnSdPvPS8YNdIgv4exEWK4Gob2TRzsQ1?=
 =?us-ascii?Q?K2uNGHJZS4q28rKB8WLfjxu76C/z7j4U2zlwsO10y6t3xFBO187vKSbpUqUv?=
 =?us-ascii?Q?gfxTM3trfrYrwPQrj8f+dBb+qWzsW9lb1b/TSk3wgAJSu9L+ISgkrGuOkSJs?=
 =?us-ascii?Q?VorWMChm+uNXyeBUiDPCGVmciytPFEdjrnTrerPh7LOA4AT1iEMGSIzBkHxu?=
 =?us-ascii?Q?J17yGY0RcrYjLIs4zN1FggN5ORJGEO1c7JpcVra+Vvuw/6lhtOLD8BuYOETr?=
 =?us-ascii?Q?FFAIWn+eqXEEdAtwzWp3WHGwDBzBuHnZjP2TfuLsZYIIRquSvuCQN1mW1MjE?=
 =?us-ascii?Q?tHJpO70eMesb+cWWUPDJKfObJ+qRTh/pTMHQbjlWoapw5uK31TOcGS3ngszd?=
 =?us-ascii?Q?DMYxbyCXK0w2v1lGGTp8tJQ5hfsNvWmvJRoBAGdJ7BGlC6qV/OC8i3+aGgOH?=
 =?us-ascii?Q?c741NRTTn/g0lvvHg5kyEl65CGtG2v+yF9FGrG39dUNUlaBk/yriiiV8kIlJ?=
 =?us-ascii?Q?FlT8th3/vxZy+iYVj6iyDoPMey0MIYy6/IKhFFAOu8luV2g8sA79aTR1HFFG?=
 =?us-ascii?Q?W6WrqU/Hq9V1oP+5tOYRGlWsp9iopx9isdYXW+y5XbrfIl1HAOII0W38bi4l?=
 =?us-ascii?Q?GOV8wR0/ZhHlF4DNpOYpydljVpCiJjaputuvZTub3aRz+u/KO1vSH1iadXGe?=
 =?us-ascii?Q?0TuuQv3iP1wVZx2lh4Z8674qjBt7T5i0dp3whbOZv4FU0Ga4WXt4ODf+oPB8?=
 =?us-ascii?Q?VkzenYhmErJpqDrR4zViPZv2?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a257fe8b-46f4-4097-2c38-08d98fa837f1
X-MS-Exchange-CrossTenant-AuthSource: SL2PR06MB3082.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2021 06:51:30.8404
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TShA0TKSqTNgQEKsezys7ZPCcZXLAcaJXQpBpZHx/j7brTTtHtTa4A/lvEpuh9JcF0hX8IGmnbHUwyCfdWR4rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SL2PR06MB3003
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

show() must not use snprintf() when formatting the value to be
returned to user space.

Fix the coccicheck warnings:
WARNING: use scnprintf or sprintf.

Signed-off-by: Qing Wang <wangqing@vivo.com>
---
 drivers/tty/serial/8250/8250_aspeed_vuart.c | 6 +++---
 drivers/tty/serial/8250/8250_port.c         | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_aspeed_vuart.c b/drivers/tty/serial/8250/8250_aspeed_vuart.c
index 2350fb3..082b9bd 100644
--- a/drivers/tty/serial/8250/8250_aspeed_vuart.c
+++ b/drivers/tty/serial/8250/8250_aspeed_vuart.c
@@ -82,7 +82,7 @@ static ssize_t lpc_address_show(struct device *dev,
 	addr = (aspeed_vuart_readb(vuart, ASPEED_VUART_ADDRH) << 8) |
 		(aspeed_vuart_readb(vuart, ASPEED_VUART_ADDRL));
 
-	return snprintf(buf, PAGE_SIZE - 1, "0x%x\n", addr);
+	return sysfs_emit(buf - 1, "0x%x\n", addr);
 }
 
 static int aspeed_vuart_set_lpc_address(struct aspeed_vuart *vuart, u32 addr)
@@ -124,7 +124,7 @@ static ssize_t sirq_show(struct device *dev,
 	reg &= ASPEED_VUART_GCRB_HOST_SIRQ_MASK;
 	reg >>= ASPEED_VUART_GCRB_HOST_SIRQ_SHIFT;
 
-	return snprintf(buf, PAGE_SIZE - 1, "%u\n", reg);
+	return sysfs_emit(buf - 1, "%u\n", reg);
 }
 
 static int aspeed_vuart_set_sirq(struct aspeed_vuart *vuart, u32 sirq)
@@ -171,7 +171,7 @@ static ssize_t sirq_polarity_show(struct device *dev,
 	reg = aspeed_vuart_readb(vuart, ASPEED_VUART_GCRA);
 	reg &= ASPEED_VUART_GCRA_HOST_SIRQ_POLARITY;
 
-	return snprintf(buf, PAGE_SIZE - 1, "%u\n", reg ? 1 : 0);
+	return sysfs_emit(buf - 1, "%u\n", reg ? 1 : 0);
 }
 
 static void aspeed_vuart_set_sirq_polarity(struct aspeed_vuart *vuart,
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 1da29a2..635cc42 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -3085,7 +3085,7 @@ static ssize_t rx_trig_bytes_show(struct device *dev,
 	if (rxtrig_bytes < 0)
 		return rxtrig_bytes;
 
-	return snprintf(buf, PAGE_SIZE, "%d\n", rxtrig_bytes);
+	return sysfs_emit(buf, "%d\n", rxtrig_bytes);
 }
 
 static int do_set_rxtrig(struct tty_port *port, unsigned char bytes)
-- 
2.7.4

