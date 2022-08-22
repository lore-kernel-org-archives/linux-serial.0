Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E3ABC32789
	for <linux-serial@archiver.kernel.org>; Mon, 22 Aug 2022 13:03:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234639AbiHVNDu (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 22 Aug 2022 09:03:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234633AbiHVNDs (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 22 Aug 2022 09:03:48 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2057.outbound.protection.outlook.com [40.107.220.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FAE065E7;
        Mon, 22 Aug 2022 06:03:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hiFMsai9WWZXsQeK/tUx/ZhguEREFQQ5bK9UbaNPgdJFuEGYK++KSyHwBprgjvNjbTLkuw7l3JxVq/s+CKZ2J8yrk1L5OdLvbvTXiWaYjrU2Mg51a+BJhqrpbC77kVPTR2OEiTncf8nf5PoXeAZXwh3eoWE4CIajaTnPtLvnnB1AZimKdXooOOyTkDiWR17Dr2eFX7fy0x9pMlM2OK7yZPl69sZOUabbIs7DQ4dYmbz9TqZfD0MnZqPJhC0npWYnGRyKgDF8I87YqCJ3nnQXR7bKqxtqepfeFdxNjJS+iNrHrzBd4kupaE/JzMfyJeKWE9uU++DRVbDuTjnjH4g8Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tWfBXcwfmlqGEh6Rg6C0H0HLF4yWFlVyxAh2k+t4PIA=;
 b=GbJXunWzCvRi+owdfqNC8TOtGtOatumvALYldIcfX5ge5MJ8welNShy3bl4XTjKMseB6wdN2kgUCg4e7hMEHp9CqtfekwUb81vNPRzz71QmsO6HH3Du8M7gvmwJaFMqayNVaSstGSyOnukDpOdyMzlqO7ifAn7538/RjUbzpDrFkRTzDCDboIFsuNk/sGE69Y8zT74oQeydc7yQsRkoi1Fw3UxrnPluMfFIrYabv8V8LcIOU/21WeVtBa/5EatmIykZztU7qD6ODiHDmdafmSjUO0alhCZ4YMlWeX909W3AiE48qMnmj8W/6OnTNz/ShKYGwYqNZqOZRLvxJEQRRBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tWfBXcwfmlqGEh6Rg6C0H0HLF4yWFlVyxAh2k+t4PIA=;
 b=x3jxyqC2y89MFGjFgZ2jx6G5xLYVb/jIQgDCr1QkgiblljHfVM6LWxME6oZfEzihatVpcS/e+Wz2wF4Z+7oznjKGGXxSiTA0oVp5mhFa36dHoAHgPA+uSYFKv0SbOMOF2+/KqfGhxsycrlfUEGFgLNdOmx59nQ+AwVMlgyjvxoI=
Received: from BN9PR03CA0153.namprd03.prod.outlook.com (2603:10b6:408:f4::8)
 by DM4PR12MB5197.namprd12.prod.outlook.com (2603:10b6:5:394::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.18; Mon, 22 Aug
 2022 13:03:44 +0000
Received: from BN8NAM11FT116.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f4:cafe::73) by BN9PR03CA0153.outlook.office365.com
 (2603:10b6:408:f4::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.21 via Frontend
 Transport; Mon, 22 Aug 2022 13:03:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT116.mail.protection.outlook.com (10.13.176.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5546.7 via Frontend Transport; Mon, 22 Aug 2022 13:03:43 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 22 Aug
 2022 08:03:42 -0500
Received: from xhdlakshmis40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Mon, 22 Aug 2022 08:03:40 -0500
From:   Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
To:     <linux-serial@vger.kernel.org>
CC:     <git@amd.com>, <devicetree@vger.kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <gregkh@linuxfoundation.org>,
        <shubhrajyoti.datta@gmail.com>
Subject: [PATCH v3 2/2] serial: pl011: Add reg-io-width parameters
Date:   Mon, 22 Aug 2022 18:33:33 +0530
Message-ID: <20220822130333.5353-3-shubhrajyoti.datta@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220822130333.5353-1-shubhrajyoti.datta@amd.com>
References: <20220822130333.5353-1-shubhrajyoti.datta@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8ea2f661-f5ec-4608-ebe2-08da843ebe17
X-MS-TrafficTypeDiagnostic: DM4PR12MB5197:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y0lzt2d8oEMgfs8f//w+BBo+XXGsLTTY8YGgvn9JSNw2pXKvw/rX69itRbkq4F2KTLjIraraLjz1Rpwsw2FiznXS2IriWIR6+RKdp7NYir/ro0KaGco0ANZ4xDUORkfIS4clJ7cw+0nwJxdvVYznvAoaBLkJCmWmj9+EXMzLsEt1rf5nJwxAYRTwkmtz90AnKoFDlqtMaNkaAZ27NAT3dum0AW5HolmrHhZZfStRh+cnTD9/fm5XVJyYJqg9HHZ9ns0sfhWf1GNrNgnY9ioQGFnag2y3WOPN6ie/v5x+wYqmWi3cykVAaNItPFSo6PTj5qInE8Z5OmxyPw7A4AEM0ea/cVtTZes4ZmIiuADZSgI/DGQT0Z2k9YGlGZVZzUsVY29TDS+MwvAUGw5rWDUtfQFF3d8Y2/pKMepi2vlX97997Hl4BbJpwr2fg+h2oJMvRtOHhg2JTlEkf8qtJQA/JnZ3KnCtTKp/8t8IzCasUY/fgxB5r6OL1xSgEBYqyxXl83JynFo1FozRcT4JxdiVETYz9Blk1w1wzSPtaxj7vfco79Y9reVSKA5qt1KzX3TeZ509mGlg+aCuTBNypHeIN+xVIoqGZ/R+2+m1wEEveyik0fCVdyIxUpcV3mUfqmBuDe8zcCe34uKaZ43w0Qofcto32Y+qbtPf93VavNNZ2Nx8wCpp/XVs2ojz5+jkTKnGwyMX0RoR5Zb8uXzcMzSYI4bxRENFYk/vuPT1YPvauhD/bqaaLzqzrPDIBXINmUlXp0NPEM8Nl8wfIZszevN0sOPGLGhiCKivcXFYXl8SndM=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(346002)(136003)(396003)(376002)(46966006)(40470700004)(36840700001)(82740400003)(8676002)(4326008)(70586007)(86362001)(54906003)(6916009)(70206006)(36756003)(36860700001)(81166007)(356005)(186003)(1076003)(426003)(336012)(83380400001)(26005)(6666004)(41300700001)(478600001)(47076005)(40460700003)(316002)(40480700001)(8936002)(82310400005)(2906002)(2616005)(44832011)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2022 13:03:43.7799
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ea2f661-f5ec-4608-ebe2-08da843ebe17
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT116.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5197
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>

Some of the implementations can read only 32 bits because of
the interface limitations of the port they are connected to.
Add a parameter reg-io-width for supporting such platforms.

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
---
v3:
use reg-io-width

 drivers/tty/serial/amba-pl011.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 16a21422ddce..735451e44fbb 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -2775,6 +2775,7 @@ static int pl011_probe(struct amba_device *dev, const struct amba_id *id)
 	struct uart_amba_port *uap;
 	struct vendor_data *vendor = id->data;
 	int portnr, ret;
+	u32 val;
 
 	portnr = pl011_find_free_port();
 	if (portnr < 0)
@@ -2798,6 +2799,21 @@ static int pl011_probe(struct amba_device *dev, const struct amba_id *id)
 	uap->port.rs485_config = pl011_rs485_config;
 	snprintf(uap->type, sizeof(uap->type), "PL011 rev%u", amba_rev(dev));
 
+	if (device_property_read_u32(&dev->dev, "reg-io-width", &val) == 0) {
+		switch (val) {
+		case 1:
+			uap->port.iotype = UPIO_MEM;
+			break;
+		case 4:
+			uap->port.iotype = UPIO_MEM32;
+			break;
+		default:
+			dev_warn(&dev->dev, "unsupported reg-io-width (%d)\n",
+				 val);
+			return -EINVAL;
+		}
+	}
+
 	ret = pl011_setup_port(&dev->dev, uap, &dev->res, portnr);
 	if (ret)
 		return ret;
-- 
2.17.1

