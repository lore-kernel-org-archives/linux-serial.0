Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42BE1C54E76
	for <linux-serial@archiver.kernel.org>; Mon, 20 Nov 2023 09:09:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232413AbjKTJKA (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 20 Nov 2023 04:10:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232419AbjKTJJ7 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 20 Nov 2023 04:09:59 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2040.outbound.protection.outlook.com [40.107.102.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54ACFF2
        for <linux-serial@vger.kernel.org>; Mon, 20 Nov 2023 01:09:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cjA5D3sGAWl6+k1YT1OujzjMn49ZkrO6xjpncUYjlmea7YX8nKBTDJC7QGkjt3orAq3glm2MC49KN4Nw+Ul1lO/n7lAuEuc9JhcUV5dxSnkPPIu90B153Z7oGMy6wxVXrcF1aneMhxDXT6iXCHgO+81TGjIlnHVu3Cqf5cGGqcRefVPE5l0C4F7up+GHSYeGTSHvUFe+QI7nZmdQS2sItc4YUTq1Vm7x5J4WuQ1B0Zsd5PTGRaHOJo1Cr3EZO1LTgkOnwRCddL+YQKw22fx8S1LyCKPrk3ouAZYSIRvtEE8uDx1LRYM344bpHQXeBlWhApXA988jpqIPQm7CPrtElQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w1GKnTLS8y292runHi1Bk3PExI35nx12mx7rMh7CAI8=;
 b=jQ6SWWGjwguOEPCrfVqqYCYJoHL/ObNEEAjd6QcN6L1SPmUddtYgmoWaVORNCL8gS8w5j3zCjfemMTHGYC7eJY0c0mELgy43AqIfeeNay2akIUZEA2VdUQWhFTWdX1C/Jasy0QVtgxA8gG6nuxz2IRNsukBm9eLlSvliTCHtJ12pr8D+EbJyW9IXd8Q6gZo5cB2MilCRmEbTMULiolMqdiMgzDGRkLY1NVDCPIcv/a+jhxDUiqATRRPCIhidu6VxpJ670mC1UcoDqduqOfjOoFxmF57cl05+Q7LFhX9nSGh0eJ27pqHnH/pFr5/eJgCznyKTZII1ntix7Qy10+pCJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w1GKnTLS8y292runHi1Bk3PExI35nx12mx7rMh7CAI8=;
 b=N9d/6yYKH8PJDZr0fxKDdvUpMkobrE0verk+25GrJY7QWW7RRAFJNb589Q7gQebOaYwcibl/AIl6Je1ni4ukDk1/skz9oXllyOVbsbI87cwMyoEBPu5uPxQRtvATDfiL6y2hzGJtr8st5T0/dwzVDbT5yPSSKjeyZas9YchE0mI=
Received: from CH0PR04CA0012.namprd04.prod.outlook.com (2603:10b6:610:76::17)
 by CH2PR12MB4955.namprd12.prod.outlook.com (2603:10b6:610:68::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.26; Mon, 20 Nov
 2023 09:09:51 +0000
Received: from CY4PEPF0000FCC0.namprd03.prod.outlook.com
 (2603:10b6:610:76:cafe::21) by CH0PR04CA0012.outlook.office365.com
 (2603:10b6:610:76::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.26 via Frontend
 Transport; Mon, 20 Nov 2023 09:09:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC0.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7025.12 via Frontend Transport; Mon, 20 Nov 2023 09:09:50 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 20 Nov
 2023 03:09:46 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 20 Nov
 2023 03:09:07 -0600
Received: from xhdshubhraj40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Mon, 20 Nov 2023 03:09:06 -0600
From:   Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
To:     <linux-serial@vger.kernel.org>
CC:     <jacmet@sunsite.dk>, <gregkh@linuxfoundation.org>,
        <jirislaby@kernel.org>, <sean.anderson@seco.com>
Subject: [PATCH v2] tty: serial: uartlite: Fix kernel doc warning
Date:   Mon, 20 Nov 2023 14:39:05 +0530
Message-ID: <20231120090905.24222-1-shubhrajyoti.datta@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC0:EE_|CH2PR12MB4955:EE_
X-MS-Office365-Filtering-Correlation-Id: 20171a58-dff9-4829-c3f3-08dbe9a87424
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l6TD39EpdVzsMOiEclX+6sf+AVQyeWZoGx6JV22mXUtrseloM6qOrFK39zt52je0XeihmXtbU6RSklRyL06umhaCJTBWjtTKLhcFs/y7QgBxDBAdXJeGazwIYdchegICB3xZBC+gKgwXX36GG9T5RolWNV/+zsk0ILHj3L3ZipMCyMxajGAy3BlqY/A2tHNhTQZlb3YG53WngymJGANJ6a4tCgbvBXSrsCCi1xgH8WovaZ+KCpQxRij2ul3DNAziNXSCIf2qwV31EIQtPyRpHXFSWiTOOUzLJS9muCsVCSfbtp1u4NH8Iplh1/5fp87gkg76TB3ATmjLgRuKZJ4ZFgrIHip0nT1lK3PHiKKRBYK/Yf/IUZf1+30SZe/acxquzME+9V2wP+hTlMrom4BH0VXvWtly5LPY3/imXhbiZ0Q6QKH/qQ5WL4aQbwrF38lEfIdOyWIysOlA0AKzGpEp9t4j33MoHDa5TrqABxVvDfVR09aNh39ei9PxKWm0sQsvr4pH9r2jpst6s52UO3WGjq5CWdqJcxO4n73no9RAd907DDGJwFe9paugy0qjYeYPOIVS6kw5oGnNIqdjIkYS1yuh3L1VI6Ujlcy82MydYey50TJEmvUys+jnanxPwBbIR20iUBp6ne8O5N61aN5GwTdmqVy23+O3zNTRYFJLuzDF8492qEWj/hDArhcw/ItfiA/S0cq4WEyPpTDFf4TV2G6X2O8iEZ81Mf9nTlr6AI8Pk3/KI6fhC9fX5OkiOpMOrBrWvAAF4qtYpxWmrS96YL3xfHQO1pZUV+wZ6fwflP+erk2vCWzSAF0ihdCLhT7W
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(39860400002)(136003)(376002)(230922051799003)(230273577357003)(230173577357003)(82310400011)(186009)(451199024)(64100799003)(1800799012)(46966006)(36840700001)(40470700004)(47076005)(1076003)(81166007)(2616005)(356005)(40460700003)(36860700001)(336012)(41300700001)(426003)(83380400001)(36756003)(26005)(82740400003)(44832011)(8936002)(4326008)(8676002)(40480700001)(478600001)(5660300002)(86362001)(966005)(70206006)(2906002)(70586007)(6916009)(316002)(54906003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2023 09:09:50.9619
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 20171a58-dff9-4829-c3f3-08dbe9a87424
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4955
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

Changes in v2:
Update doc for uartlite_data

 drivers/tty/serial/uartlite.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/uartlite.c b/drivers/tty/serial/uartlite.c
index 404c14acafa5..e586d7aeac98 100644
--- a/drivers/tty/serial/uartlite.c
+++ b/drivers/tty/serial/uartlite.c
@@ -62,11 +62,11 @@ static struct uart_port *console_port;
 #endif
 
 /**
- * struct uartlite_data: Driver private data
- * reg_ops: Functions to read/write registers
- * clk: Our parent clock, if present
- * baud: The baud rate configured when this device was synthesized
- * cflags: The cflags for parity and data bits
+ * struct uartlite_data - Driver private data
+ * @reg_ops: Functions to read/write registers
+ * @clk: Our parent clock, if present
+ * @baud: The baud rate configured when this device was synthesized
+ * @cflags: The cflags for parity and data bits
  */
 struct uartlite_data {
 	const struct uartlite_reg_ops *reg_ops;
-- 
2.17.1

