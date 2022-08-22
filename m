Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D598C28D13
	for <linux-serial@archiver.kernel.org>; Mon, 22 Aug 2022 13:03:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232970AbiHVNDs (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 22 Aug 2022 09:03:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbiHVNDr (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 22 Aug 2022 09:03:47 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2087.outbound.protection.outlook.com [40.107.94.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28DD49595;
        Mon, 22 Aug 2022 06:03:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K4qGxXY7fdRashDAt73E3whbEx8auqR3AacUbUS1qsMO3yGJ4/DQNLyMZ6Gd1CggSssWTrbwbxDGLXzYLZv46rtAmeV+YaVde/UnBd8WjH0PLaqqGlwzuVzY2k5qIBVw3DDJgxbrLWZnOBFv9RI7lNVij0H7KyO+ZFSRKyAYmTvn3uE1SNCl13KFBS2da3/Sexkwu/uGu8RFS/1w6b4na2QIJBED1ReRZTcCIFT34TrI5KtU0LFdhjRFDhxLLb/7L/Wlvar4dTl9fpEd9Ww7BTHQs3Vi5y3ikzdFUam/Ntjfn2ZisrZGgS2y5nroExw7wP16hAZsOsv2ow7VE6LUXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o1S/Xv6JCneKPlnWzvc+FNYpvsYOofwOmC01DOpL65M=;
 b=SkpV64FBlJie8L2hhIdufLIRYbICXlpPeIzpEo+EfGcIRbpzYrWGDQ9XG0RNiLlf/Gv2Nn+sdeCKgTNSqE8Dms/8Prahc6+O6q+8M4FykwgekDzgImE7Aop0/x5jYudlgcH8ixgamUyK0G0yT96877V80laOFyk8WyPXbXpJZ6yxZHrQrW4FxkwwNkRDg6pSASt/sME/owZMKZL85i6L0D9aW7EXd6P6MD+a0u8QB4wUU74wbIBIYJxxQ+gCrRehQi6hSsJ1/873HtB43JhhxDj0/PP+tbiD3DAz90KlcMzUxeZiYcpVOJw0CUVkyx9e2D5cxKoPTUtL4o+Lh7DOKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o1S/Xv6JCneKPlnWzvc+FNYpvsYOofwOmC01DOpL65M=;
 b=zZqEfTNdkUVnWyV3Z2v3pc+7ioas4yJEuj+vaM42fvSxF6N4n4vOFTT9riUoIclSMnMvNfIkqiH7W1bHrlskQkjy8MjHjvCeDhXwOCZ8BnZhI8U8OeEVf00/JPN0Un1nwTV4867afzoFucODIGd1frmrsORK92BOTKG3dI2YEAY=
Received: from BN0PR08CA0002.namprd08.prod.outlook.com (2603:10b6:408:142::18)
 by BY5PR12MB3667.namprd12.prod.outlook.com (2603:10b6:a03:1a2::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.21; Mon, 22 Aug
 2022 13:03:38 +0000
Received: from BN8NAM11FT085.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:142:cafe::62) by BN0PR08CA0002.outlook.office365.com
 (2603:10b6:408:142::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.23 via Frontend
 Transport; Mon, 22 Aug 2022 13:03:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT085.mail.protection.outlook.com (10.13.176.100) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5546.7 via Frontend Transport; Mon, 22 Aug 2022 13:03:38 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 22 Aug
 2022 08:03:37 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 22 Aug
 2022 06:03:37 -0700
Received: from xhdlakshmis40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Mon, 22 Aug 2022 08:03:34 -0500
From:   Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
To:     <linux-serial@vger.kernel.org>
CC:     <git@amd.com>, <devicetree@vger.kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <gregkh@linuxfoundation.org>,
        <shubhrajyoti.datta@gmail.com>
Subject: [PATCH v3 0/2] serial: pl011: Add xilinx uart
Date:   Mon, 22 Aug 2022 18:33:31 +0530
Message-ID: <20220822130333.5353-1-shubhrajyoti.datta@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a27dacde-4a04-4470-6572-08da843ebae6
X-MS-TrafficTypeDiagnostic: BY5PR12MB3667:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lE+3C3fTkQrbjAPOR3is0Nrf4x0oNRQ6lWFfrxoVnCNXhY04idOEiK/9uxNLIvEu62NLtf4lWvzrtQjHQZ0EqjLUIdC2Fc14A8xR33BAp3ZehQzxuq4fCZOqVRLn05cl/NvriGL8MT+20uCTBSk1ItawfLxIz+j7j+IC0hTiNrEwSwpI0IoDPLSy76f9hAEararPZjurPqnbBbPdCuEv/2jUVEFUK0WjPLH4ni+3O+uS4t+OO6HYLiCm2ZWZSq79gaJG5+5bN17sMmuJkggf6p4RYvx5hZFK0dVvNu06rTLum0zA5svuEHtvaqSQXJ2QOGawcOEYAQhEDPJdkvM5mleE6QWsTBan/gtPEAc09Wpuj3C8//7GJQqFL9v9rwlxbRQJuo/6XEBmPvF/Js5IsFtYGKODmI8eE3PsUIGsxzbzkaRtiKn/K+xhYVviGxxTjR3taSUkdhXVI1syYcHCOfS0nq3tLYg3bP3cgUW+FjLRYC+00ChQwhXvdjCY6jp50skY1kO5I3AYBDmbyTBTzzh9WqGw2wyHJafpVwA0t7qxf8tLHPqJ95rNIXe7PldUe9a2p1iBSM9sVmaiadbFEhoe7uVMQc/qNidxFJfk2wzt2YeR3LfABOFBDaG6h2wcLBNVKaqfbFFkGNvFQ+nPhI6DhicHnyuaQepHzMROvtyckiow47bAnjUpTaHgevoNdPl1u3Gtl1OITaVyrTQJ6ZFiqTCPhdqGaEleXSSCcMGO00L4TvAsN3GUWMh6782jAKhyfMhlbgk6JjKpMeRlrvVisBLejyS52CHCeGMn56RWU6jvBMbViBRb+ll5BO81
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(136003)(376002)(346002)(39860400002)(396003)(40470700004)(46966006)(36840700001)(478600001)(6666004)(316002)(6916009)(26005)(5660300002)(8936002)(4744005)(44832011)(186003)(2616005)(2906002)(47076005)(86362001)(426003)(1076003)(336012)(41300700001)(54906003)(82310400005)(36756003)(81166007)(40460700003)(40480700001)(356005)(83380400001)(4326008)(8676002)(70586007)(82740400003)(70206006)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2022 13:03:38.4221
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a27dacde-4a04-4470-6572-08da843ebae6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT085.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3667
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>

-Support uart peripheral in Xilinx Versal SOC.
Add parameter reg-io-width.
Add the dt-binding for the same

v2: 
Update the commit message to reflect the AXI limitation.

v3:
Add reg-io-width.


Shubhrajyoti Datta (2):
  dt-bindings: serial: pl011: Add a reg-io-width parameter
  serial: pl011: Add reg-io-width parameters

 .../devicetree/bindings/serial/pl011.yaml        |  7 +++++++
 drivers/tty/serial/amba-pl011.c                  | 16 ++++++++++++++++
 2 files changed, 23 insertions(+)

-- 
2.17.1

