Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99E84ECAAD4
	for <linux-serial@archiver.kernel.org>; Fri, 26 Aug 2022 12:06:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242915AbiHZMGU (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 26 Aug 2022 08:06:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236026AbiHZMGQ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 26 Aug 2022 08:06:16 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2071.outbound.protection.outlook.com [40.107.244.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F310352E7F;
        Fri, 26 Aug 2022 05:06:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fQNpukhUiQWt2OZjUxDCX/t5z9OzdVg8vNpi5YcOMx+c2R9ed3NJ1Qq+0XkaCZT6nJWo4279zOlmyC8QNHOeGBNujGzvj+TT/MOGcABt11ElmdLrfQpcJpRVezZIGIS3+WzXK0WYBwRERmCssfXf03ouuFcGQeVlYb8b+8tdb7ETX51oUqbSwQ7TnE/dfg60fIcsy+D8EFPrQ/rUd+add+SUOzo6Yc5belf1Lk/4CBDl7lr+59Rak8U2UErQ3omcXfkv02QA9cAnpNR7WkREYv9NBG32IBVy/e737hjHhsM5Q6N76PGKqWjpGxpJzDz3VmpGzqK36iXHkwFvRIpZdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kXRe4yCQjOglGZiEXFoHN5ZIAXcazcGo6p4Pvns968s=;
 b=at5/ZcI9/njtr3JzqK9DY8Bwbhyr82a/BwCfNHntmTii3fr71CcV34Aaoy5OKJkRD/LvvL9QsxLKhaqJdeuAmPVjFxSGzJonuX4fRRZ/K9G3Dg+jR4j56CDMby+IqVex+i07FkwKTv8HJbqm9oisB0ESmBNHHaayX05/VSh9WX7vJsaMMTRzU5FnTaGU9O16jU16muOVaj+zOjQCoFff5vJRzMiFfkMPPGDBvyCjXxt0YQrq4DCe5iNZd4bRdHWD14h7OGH09/aWBhAgTEeWqwaUqEOh+7mHtqBnHhPzROHhBYaV3T7zol4h4rg/Knv94CjNz0E8oBn2ZabAUqfeFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kXRe4yCQjOglGZiEXFoHN5ZIAXcazcGo6p4Pvns968s=;
 b=kvWEOBxyCBbJRlJN6k+8pyMzbUMnIL2bTALkaQYavUr64SmDcz715Jk1b0uKB22eylXf09e58aSzhxNh7+SNLLOynt3/kIg54/l0lnBzgme5/m6Wtf7OkjsrTFvfhCqiHPeage+XQIT0dSSar+OMSPJq5kEIWzibIx14ukY/bZs=
Received: from DM6PR06CA0064.namprd06.prod.outlook.com (2603:10b6:5:54::41) by
 BYAPR12MB3431.namprd12.prod.outlook.com (2603:10b6:a03:da::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5546.22; Fri, 26 Aug 2022 12:06:11 +0000
Received: from DM6NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:54:cafe::7b) by DM6PR06CA0064.outlook.office365.com
 (2603:10b6:5:54::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15 via Frontend
 Transport; Fri, 26 Aug 2022 12:06:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT027.mail.protection.outlook.com (10.13.172.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5566.15 via Frontend Transport; Fri, 26 Aug 2022 12:06:11 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 26 Aug
 2022 07:06:10 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 26 Aug
 2022 05:06:10 -0700
Received: from xhdlakshmis40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Fri, 26 Aug 2022 07:06:07 -0500
From:   Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
To:     <linux-serial@vger.kernel.org>
CC:     <git@amd.com>, <devicetree@vger.kernel.org>,
        <jirislaby@kernel.org>, <linux@armlinux.org.uk>,
        <krzysztof.kozlowski+dt@linaro.org>, <robh+dt@kernel.org>,
        <gregkh@linuxfoundation.org>
Subject: [PATCH v4 2/2] serial: pl011: Add reg-io-width parameters
Date:   Fri, 26 Aug 2022 17:35:59 +0530
Message-ID: <20220826120559.2122-3-shubhrajyoti.datta@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220826120559.2122-1-shubhrajyoti.datta@amd.com>
References: <20220826120559.2122-1-shubhrajyoti.datta@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 871d8aad-b395-4cfe-0fd1-08da875b5e09
X-MS-TrafficTypeDiagnostic: BYAPR12MB3431:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Vuppo6IyBvhH2liCHLx6JXZoTYM5GOJR3r6cpbjAjXxXMOoTRX52ou5dYbsF9TSuZRHHUqifMJehe9pHvHZA2WLx3JOI1R1dqn9d/sqAQ0FObeNEzeoNsp1+IoN+iGs2axwbgnzBw+2JUIaHix3B3Nm1EWqZnMXjULXsjp+mYpUrFB1i8cwZUk2KJ5zS7EIdVuhxZnVA2kd8Xiflt8b5law6wepCHqDgp90+GMOSXIG/exf6zHtbEe0ywIMBIHS5U8wfx2KXqe62UHgBzY4t9zyAqNwYT/RhNFa4mj53pEazlUmTM2Tls2+UjdeO3CooSudu+RacEwMoWwxkmM+wzy2Nl4g2VbEfU2jXR53V2SWmlpdXnwpFKOp3HidRdo23BLC1pc0DdaSD1qQKP0KOuf5OTaxiVS/xqp6L61BdjQNDNco61Nqu2zvuDc58cz1OSWMqUbn+7tEdbs3KyxLIq7dAAprJ318WMjMQzKw2SKDF1s5fD2T2xd0ALDlMV603ZaiiwOKchyKS+x4rWMBIjeZfdqIzX4OHqJFo5uKtjw+FUGH1wJ7tCM9DkjjXRiPl2gS0LHqEhg2OwB0OdIong4lK43001mpe9dgtsccGL3h9XiS+nGY12DoFiOHwOdugjzvSCf7a5vIybus5QMsYsPB9EuMOy92bJj/6b7ST4qYcMPHLVY3LyVKK+6s4yDkGwykH+N5KsS4H2wrcsCK42jZ1SqCuiRJnkhxnOqZY0qkwuRJUX4/9G+vOghZ/zUf9Z6VB2q2pxDCfnCsGQzl/8AQGE7mn25XC08rHbs1T4e4=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(396003)(136003)(346002)(376002)(39860400002)(40470700004)(46966006)(36840700001)(82740400003)(2906002)(356005)(83380400001)(40460700003)(40480700001)(36756003)(4326008)(70206006)(81166007)(36860700001)(70586007)(8676002)(8936002)(6666004)(26005)(5660300002)(44832011)(82310400005)(316002)(6916009)(478600001)(41300700001)(47076005)(426003)(2616005)(86362001)(336012)(186003)(54906003)(1076003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2022 12:06:11.4678
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 871d8aad-b395-4cfe-0fd1-08da875b5e09
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3431
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Some of the implementations can read only 32 bits because of
the interface limitations of the port they are connected to.
Add a parameter reg-io-width for supporting such platforms.

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
---
v4:
No change

 drivers/tty/serial/amba-pl011.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 15f0e4d88c5a..033bf8699540 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -2777,6 +2777,7 @@ static int pl011_probe(struct amba_device *dev, const struct amba_id *id)
 	struct uart_amba_port *uap;
 	struct vendor_data *vendor = id->data;
 	int portnr, ret;
+	u32 val;
 
 	portnr = pl011_find_free_port();
 	if (portnr < 0)
@@ -2801,6 +2802,21 @@ static int pl011_probe(struct amba_device *dev, const struct amba_id *id)
 	uap->port.rs485_supported = pl011_rs485_supported;
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

