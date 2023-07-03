Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62574EB64DD
	for <linux-serial@archiver.kernel.org>; Mon,  3 Jul 2023 11:38:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231199AbjGCLie (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 3 Jul 2023 07:38:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbjGCLie (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 3 Jul 2023 07:38:34 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2086.outbound.protection.outlook.com [40.107.93.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFF9910C1;
        Mon,  3 Jul 2023 04:38:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IKrRfXiUPgcEy03269BbIW9pg4xM5JlLqcUfRmBSJmhkRbFKtp7yL6A3xISF+7t2rDN8NGiODAk3gY+pk1uGJoqhraB82Ry4cEfI6kq2KElgWoMq+sylFy9hr7Wo4fL5PpPmHZ/R+ryvcaQGy1KJhWDDCvQDWVqSz28oXBMrmVZN3E6MjVaayk3rlBeqQKVAP6b92MmTxXhb8x4XRbBCAgb1s6kzwmZJCIryg83STgtYC9xwO5505Nnyt6QO6H2pb3jhv5+yNZka8cv3TqPVfHS1WKPTplaCVR3dOJwQU1Q3YC9Zi8TCnycI9dvrGICTOnEXpCuSmz7Giet5OxdL5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PF2V9gsy+uPDkAUC0sWqnpWA349/+oxz6d/IkFueEdY=;
 b=DKMxFwqI27Lp0gIVw9AG/vBVug4Ls5SMfcFihMEuUIVHj4+Tp9QfjDlWEaK0zjk0xqzEYnIoiR5wzx/93V01MUs7QWSswg/rLiPbm6ucAtmYnOJIoh8qSGmf4qpIbTSmUyP8VdWVtzHkLIAt7IvCUHW0eyND7ZRR4+nn4BlPb5f93WWGD1E8D1iVUcuEYdjoSixb7fLQcl1VOhZ9zxuB1KwCi0SN/f1lKZQl1KfcLvxApKZC1ffkmlGB6ea0TS53z4t8nsGz774f5/5sv3CuqqVlK1poMiCEUzPP9scs6/eJmK+S5O4fbgCQJhx7BedGLE8CAUgl5UlS/c9Wt10gCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PF2V9gsy+uPDkAUC0sWqnpWA349/+oxz6d/IkFueEdY=;
 b=nkENCtJtiz3SP/oJrtabWh1Z7+ZGJL3zOrlpO2Deb/N0QvbVmJbXn11HfNSV3PKjAo8sxf9YrtbafMb9W5ZI1o2p6hKGxRNOZA7m9zpgRADg5bv3y4CM0jeIBszkA+AnDEoYoxOustGKLL/kqjhtYzbAdDJb9A+hZxP5+M2n9X8yteqpAGMuZEl6zNDVcnykJV3gLUYjFbsAL4bzByhybPz/joML9LJt4/ynJy+sZR3CtytAoA+nNwzTnPF49XrvcRSNeBnPZWQhlQXwyI6loXMuLwYNU0PC2vX/BTTLCIZ5zalEgBsZMqCU/0y1VHmtty8Xbl3dk0ZR/8amkPBDyg==
Received: from BN1PR12CA0004.namprd12.prod.outlook.com (2603:10b6:408:e1::9)
 by DM6PR12MB4284.namprd12.prod.outlook.com (2603:10b6:5:21a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Mon, 3 Jul
 2023 11:38:18 +0000
Received: from BN8NAM11FT115.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e1:cafe::5b) by BN1PR12CA0004.outlook.office365.com
 (2603:10b6:408:e1::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.30 via Frontend
 Transport; Mon, 3 Jul 2023 11:38:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT115.mail.protection.outlook.com (10.13.177.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.44 via Frontend Transport; Mon, 3 Jul 2023 11:38:17 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 3 Jul 2023
 04:38:07 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Mon, 3 Jul 2023
 04:38:06 -0700
Received: from moonraker.home (10.127.8.14) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.986.37 via Frontend Transport; Mon, 3 Jul
 2023 04:38:04 -0700
From:   Jon Hunter <jonathanh@nvidia.com>
To:     Laxman Dewangan <ldewangan@nvidia.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "Thierry Reding" <thierry.reding@gmail.com>
CC:     <linux-serial@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH] serial: tegra: Don't print error on probe deferral
Date:   Mon, 3 Jul 2023 12:37:59 +0100
Message-ID: <20230703113759.75608-1-jonathanh@nvidia.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT115:EE_|DM6PR12MB4284:EE_
X-MS-Office365-Filtering-Correlation-Id: f8e297b3-7f28-468a-9414-08db7bb9fefe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vdsDixlu/+E0181s+AnacTqweYzqL7lQRkNrrAIS55pfdn8310bxIwKrF9KL4bRwS0MeVkJmb7RvgWszxQviS6tEsehatz7TZdHTzHvZC1dNHfYwXI0jet1WsVWtMyatX2JeBsl2cDoXSBfsk0GzJiR6ygR9x+gCs6Gat/fHdYOApDuU7LsjcwnMW3WyDaMrk6fRP+zD/nv1mG7sryOhHmkBE9MFJOjrKqQiupwVRCnijBU21Ec7PI3YhB92xx9gmdKvUwsBMD4GhsG07rAqlmCaKB7GoAtYJ0oLrQ1KyenCI//6Y6CaAAkGy8w/jyUIaZbZ4J2C9qbmVEF/lWxYvuh55sIMBhuzFNOZT4rXpD8eDch8nJzevkmXZmcBKQESx4g3/3XdKqXdUgo+u6/etwp41bsX8oIEUfwQ98pA52zQmTYukSd+UWx+UbigiWk+xrM4wVrKpkCA5T0gE8fm82Lnk3ZKY2tCE3EzKktM/h/nwSGdW6VR8RP7Ld+f4E3Ep6syAa+MF+Ej9ir8CjV1HMoBHJcgN748zpDUbuCrTqF/pFwgtDXd2OaLDdXCWxUNUtqX+Kb2B1+3uzc+cAUeqzrvDpbXCWx4S+zcWej7n5VhF0TQKGA3ff700tuCG2/4YNRbgb3jfeyDcOR62VK5vsxHsaG6lgEJ8tNXfbcXZpe+Vsxx5X3Heo8cphe+Qt3TwTj7vklOYlFx1hVb95OnBoUtm3rn4IWmV9lPciOg5bu8S/y65+/h0bguP9d0dgVt
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(396003)(136003)(39860400002)(451199021)(40470700004)(36840700001)(46966006)(110136005)(54906003)(2906002)(478600001)(26005)(41300700001)(6666004)(86362001)(8676002)(8936002)(5660300002)(36756003)(316002)(40460700003)(4326008)(70586007)(70206006)(1076003)(40480700001)(82740400003)(356005)(7636003)(2616005)(186003)(336012)(83380400001)(82310400005)(426003)(107886003)(47076005)(36860700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2023 11:38:17.8289
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f8e297b3-7f28-468a-9414-08db7bb9fefe
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT115.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4284
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

If the Tegra serial driver is probe before clocks are available then the
following error is seen on boot:

 serial-tegra 3100000.serial: Couldn't get the clock

This has been observed on Jetson AGX Orin. Fix this by calling
dev_err_probe() instead of dev_err() to avoid printing an error on probe
deferral.

Fixes: e9ea096dd225 ("serial: tegra: add serial driver")
Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
 drivers/tty/serial/serial-tegra.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/serial-tegra.c b/drivers/tty/serial/serial-tegra.c
index 1cf08b33456c..848ea53a26bd 100644
--- a/drivers/tty/serial/serial-tegra.c
+++ b/drivers/tty/serial/serial-tegra.c
@@ -1591,10 +1591,8 @@ static int tegra_uart_probe(struct platform_device *pdev)
 		return PTR_ERR(u->membase);
 
 	tup->uart_clk = devm_clk_get(&pdev->dev, NULL);
-	if (IS_ERR(tup->uart_clk)) {
-		dev_err(&pdev->dev, "Couldn't get the clock\n");
-		return PTR_ERR(tup->uart_clk);
-	}
+	if (IS_ERR(tup->uart_clk))
+		return dev_err_probe(&pdev->dev, PTR_ERR(tup->uart_clk), "Couldn't get the clock");
 
 	tup->rst = devm_reset_control_get_exclusive(&pdev->dev, "serial");
 	if (IS_ERR(tup->rst)) {
-- 
2.34.1

