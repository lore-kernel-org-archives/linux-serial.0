Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79948C2BB3F
	for <linux-serial@archiver.kernel.org>; Mon, 20 Nov 2023 05:21:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231807AbjKTFVH (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 20 Nov 2023 00:21:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjKTFVG (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 20 Nov 2023 00:21:06 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2067.outbound.protection.outlook.com [40.107.243.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87AE5BC
        for <linux-serial@vger.kernel.org>; Sun, 19 Nov 2023 21:21:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n3zjr0YL1F64wef9NMzJduH3XVk5gQ5IFHlNXSEC5SwmVyW8/s9rapaUoXS8Lsn4x9HAqCg9K5CbbzrErJL4zSpihKhWjx3fYeyKTPQt9aJArR7Op/TaXKwp3F+tMgkY8hZsK99GyG10VEjckuKUEnhPCSw5PErSkUQ4RplKLULHX3crYubmSosEQkvY9HiwcGv/FHQ554sGgRwHiMGII9aUGK2r3IiAEvH8mbuTDs7H5+3kBInqKWBhado1jAjK3C2pP09VPSGe19hTnVTj34LADxn1v1snAKYOu5163bMqK3Mjp84qG1IL2wN9frK4eUYZrUk3F8bhc0e/rzteOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fm63ctMOo0U0PDQwa1KRzYSAbks5pOmDgtSaCJhdvj0=;
 b=WRFSlI+Wzh6xFy98VWBIJbnPsq8lflx2OIAZmmTINeVwA1/aS+XXZT1HKkX+fw2mC+rt9kfcS5Hz3JcEZidKhE37ncVLKsVz9Sz5jNJUuoz44L/6MZyHklWIXybUEeoPDviFBCv7rqZWZTRLd7NBBOAAOvnXVjGx3Tlixq3XxjHrvB6D5odPTR8Y2LAZDIVXdsfGRnkq6EF0wKvZfkacbVo6VLqUFN4nK4d3pOXmgIhkPr01FYj8NKvMYwgFIXeIp0nbsICjHApR53jinbQ6tfnZiAZR3w207edrey3i6Go5jvIxJ8y7XQtH4gJwwVx3Pv7IvXdi0QzzTVIFrmAwtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fm63ctMOo0U0PDQwa1KRzYSAbks5pOmDgtSaCJhdvj0=;
 b=UGG1UR+ZB3V4cOPrz3usI0vgBK2IaypY/LkgaQ/zH3o99aFLs0w0L3VY26GtaAPiHN2LSDIDoigQg/c1Vbf0zlfys+Qs+geQr9aSta8BtStUDbIwVTs/frM2KfBDM9IzlDqDlTMQ9I2ahQdsMeMc0jn0pDh/6x219TqRS6JFazI=
Received: from SJ0PR05CA0109.namprd05.prod.outlook.com (2603:10b6:a03:334::24)
 by MN6PR12MB8492.namprd12.prod.outlook.com (2603:10b6:208:472::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.26; Mon, 20 Nov
 2023 05:20:58 +0000
Received: from CO1PEPF000044F5.namprd05.prod.outlook.com
 (2603:10b6:a03:334:cafe::83) by SJ0PR05CA0109.outlook.office365.com
 (2603:10b6:a03:334::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.16 via Frontend
 Transport; Mon, 20 Nov 2023 05:20:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F5.mail.protection.outlook.com (10.167.241.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7025.12 via Frontend Transport; Mon, 20 Nov 2023 05:20:58 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Sun, 19 Nov
 2023 23:20:57 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Sun, 19 Nov
 2023 21:20:56 -0800
Received: from xhdshubhraj40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Sun, 19 Nov 2023 23:20:55 -0600
From:   Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
To:     <linux-serial@vger.kernel.org>
CC:     <jacmet@sunsite.dk>, <gregkh@linuxfoundation.org>,
        <jirislaby@kernel.org>, <sean.anderson@seco.com>
Subject: [PATCH] tty: serial: uartlite: Fix kernel doc warning
Date:   Mon, 20 Nov 2023 10:50:54 +0530
Message-ID: <20231120052054.30161-1-shubhrajyoti.datta@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F5:EE_|MN6PR12MB8492:EE_
X-MS-Office365-Filtering-Correlation-Id: 5267936c-6af2-4f8b-58ed-08dbe9887a91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tIUc4oXpYnVZhMr76L6JqqIFdVOG4TSYXaafiFy4jdqs/yeFoQ62j9uLu0juL4FflIpNKG0YuRielBPvSumJzXVIKoEnWz0nPG/+Nz8dYK4n997/Owp+9T6Nm5TDPlexOgjjVlz+impeUO8n+BO/i4nqFGSUjlxPHwvHLMZMgYzz8WWSYdUSDwKP+VzSC02gK/gKiLK7JeVMlv2eoysWxLCf24/lm+6i7KkSqNnxGq2KTZNOB2z0jaOyVSBxkn5OSch53XUoGFz83gL11CPOT/AhN9E7uzy1fHIXSkZYDfdVqbIMgoDgYkdaOjskfAMkgT4Wk3+ECudYmIWRZDI76Wbp5nX+cjgXDpvMANbbt5eH3UYeo64n+LbVKmHeTNPQQ52NUXAP/dalbnvslV1Dm3bXXHnUJOPAMDrkr4Sq0xFyeKQgOWfINUFnaFjlVPRFHRqmnszhxh7QwTP7UyQ0uEUhK2UgFFjgtyPMzOA/qY3hNbOkaD+vk+NEpAL8E0LurkAhK2Ks7VduWSVs2IGn89Fl49UUDVD6ApYh/KGyPfeKyWnq0Sjw7wjzsKnE2fVuvre45Gj3bygDyY4/a3LEXoWZqvQFVP7WeBepRX8mwdjXw/w1cSN1btqG9PuF4aqBKmtYPRr2/YXDA5Y+WqphAtJ/wOuf7beo2ARCt0EDJQ964anFv6oWAa0GrOKvNENyQ5n+SjnTS8M21r1R0e2NRpg/TVGHIs2ezhhqGKPf9xcuvZ8Ntsb5OQ5DqKBzGUhJKqTEhyg0lrmEU5QgZtSSwm3JiKBjBjdi09fFyb1+fB0yskbK2Q7HXFjIuOArDh3z
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(39860400002)(346002)(376002)(230922051799003)(230173577357003)(230273577357003)(451199024)(82310400011)(186009)(64100799003)(1800799012)(46966006)(40470700004)(36840700001)(47076005)(1076003)(81166007)(2616005)(356005)(40460700003)(36860700001)(336012)(41300700001)(426003)(83380400001)(36756003)(26005)(82740400003)(44832011)(4326008)(8676002)(8936002)(40480700001)(5660300002)(478600001)(86362001)(966005)(70206006)(70586007)(2906002)(316002)(6916009)(54906003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2023 05:20:58.2820
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5267936c-6af2-4f8b-58ed-08dbe9887a91
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8492
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Fix the below warning
drivers/tty/serial/uartlite.c:79: warning: Function parameter or member 'reg_ops' not described in 'uartlite_data'
drivers/tty/serial/uartlite.c:79: warning: Function parameter or member 'clk' not described in 'uartlite_data'
drivers/tty/serial/uartlite.c:79: warning: Function parameter or member 'baud' not described in 'uartlite_data'
drivers/tty/serial/uartlite.c:79: warning: Function parameter or member 'cflags' not described in 'uartlite_data'

Reported-by: kernel test robot <yujie.liu@intel.com>
Closes: https://lore.kernel.org/r/202311061059.NUeUar9b-lkp@intel.com/
Fixes: ea017f5853e9 ("tty: serial: uartlite: Prevent changing fixed parameters")

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
---

 drivers/tty/serial/uartlite.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/uartlite.c b/drivers/tty/serial/uartlite.c
index 404c14acafa5..f1096b19f36c 100644
--- a/drivers/tty/serial/uartlite.c
+++ b/drivers/tty/serial/uartlite.c
@@ -63,10 +63,10 @@ static struct uart_port *console_port;
 
 /**
  * struct uartlite_data: Driver private data
- * reg_ops: Functions to read/write registers
- * clk: Our parent clock, if present
- * baud: The baud rate configured when this device was synthesized
- * cflags: The cflags for parity and data bits
+ * @reg_ops: Functions to read/write registers
+ * @clk: Our parent clock, if present
+ * @baud: The baud rate configured when this device was synthesized
+ * @cflags: The cflags for parity and data bits
  */
 struct uartlite_data {
 	const struct uartlite_reg_ops *reg_ops;
-- 
2.17.1

