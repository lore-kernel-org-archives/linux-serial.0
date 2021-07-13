Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2C28C07E95
	for <linux-serial@archiver.kernel.org>; Tue, 13 Jul 2021 06:48:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CA64611AB
	for <linux-serial@archiver.kernel.org>; Tue, 13 Jul 2021 06:48:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233374AbhGMGvd (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 13 Jul 2021 02:51:33 -0400
Received: from mail-bn8nam12on2044.outbound.protection.outlook.com ([40.107.237.44]:9664
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232908AbhGMGvd (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 13 Jul 2021 02:51:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jpjn4fTBiY7uja0l30g4TF5CZB8pPDRxdJArBjfKwwGBet9ZmBI3v1dZtKke+vqPxDeX1IXLSBm2sybclmQTDIOmHD2HKTIQLAITYITQjfFzsYGzTZZ+aXgCRHrHWU4cZt24kUVjhRwTWokiLiZCCaAuB891ucUv9HbZFf7mxKALKTwW/6vi42f9/y3hlJ7FkBo1AvnNFKo5Ae3aELSmmNV9vAUO+JWJzKjve+zAs9RNRlM9U7HoT12VdbsY97311PNvplVx2BMJe8f7XJL5V+dMmJXDz0/7xjEcPKP9rRk/30uqFqwLim5eoEoehbGnfWisH5gN3VpMQhulYn+4Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h3Cgs5BJlo3RMijK4UT/FKmyUwuxq3Qq0GAvfe+wWF0=;
 b=XYMErnqrPTJeyCDg2I35q96pSlg9oDWTgETCPpZXAX16K5QNenS7PeSjHNaKs9QDFngS4gP8fIZ5sWtObXMzx7VfrKnQlNAlR5n11KG7sZelV1SYjI98AAGh7Eb3aT0JP/4vDyeRYZhYJmf88qk61zapK7BOk1EtMgc1+9ZS4eEFkiOfyMVtVKT/RY9odgtHxiEOBnUIEVrO6JrKUJGPQoAxfjRRllqPopd8W4HvQXV2Q9ncK0EUtT25ZUOHODhELSQ0LTW5VYAo1d98uW0cFS44EaCmPJcSUOLVTA7/AUgGGX3OhE7hHYa/rAeJhRgjIbDvvKzGBujyiMIjB91Kzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h3Cgs5BJlo3RMijK4UT/FKmyUwuxq3Qq0GAvfe+wWF0=;
 b=nnWGeeMQu2MVyOcV0LY3i3rGbmfuLHULfDvzV69lDSoo90bp6RgAqb+2k0iwHOy9K0FesqjLmlMTKZu/WiXCLQmOykIc1j4GqbyzeG1on+P5UenDU2HP61W5j36FiXbhWPigccBOrfAJBEA17xmvB+om+HPHOo3TZDLTXwD16QI=
Received: from SN7P220CA0013.NAMP220.PROD.OUTLOOK.COM (2603:10b6:806:123::18)
 by CH2PR02MB6918.namprd02.prod.outlook.com (2603:10b6:610:89::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.22; Tue, 13 Jul
 2021 06:48:41 +0000
Received: from SN1NAM02FT0060.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:123:cafe::7d) by SN7P220CA0013.outlook.office365.com
 (2603:10b6:806:123::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.19 via Frontend
 Transport; Tue, 13 Jul 2021 06:48:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0060.mail.protection.outlook.com (10.97.4.134) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4308.20 via Frontend Transport; Tue, 13 Jul 2021 06:48:41 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 12 Jul 2021 23:48:39 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Mon, 12 Jul 2021 23:48:39 -0700
Envelope-to: git@xilinx.com,
 linux-serial@vger.kernel.org,
 gregkh@linuxfoundation.org
Received: from [10.140.6.59] (port=58696 helo=xhdshubhraj40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <shubhrajyoti.datta@xilinx.com>)
        id 1m3CDe-000Gjm-8B; Mon, 12 Jul 2021 23:48:38 -0700
From:   Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
To:     <git@xilinx.com>, <linux-serial@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: [PATCH v2 0/2]  tty: serial: uartlite: PM Runtime
Date:   Tue, 13 Jul 2021 12:18:33 +0530
Message-ID: <20210713064835.27978-1-shubhrajyoti.datta@xilinx.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d535c6e4-399c-4b41-b56b-08d945ca4079
X-MS-TrafficTypeDiagnostic: CH2PR02MB6918:
X-Microsoft-Antispam-PRVS: <CH2PR02MB691862789799E27F149CA48FAA149@CH2PR02MB6918.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:2276;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ps6wpeCwOgTmyaXZSRVNCrLsvnDvY29mhgBH0kTrSc0412ECVa6t7Wv3fhJgs+SomHub76oYDJpmx3Z9/XFICqUSMLGt7bkVFHKm/MmmHP2hxppv+/Z3+7yFq11wVV19IBcdZ/X4Sk0DofRHx69olqz40Irq7+yCyv9v/WIOW81xd1SlNKa+a2l73iZKM/twdQDJfm7ET4yAaJPXvG3aQVSUUuBExw5m7S7TnnIoLDV+E5RbnQZZXeMhYBuNuh2I7p8UlPtYU++WUatKK5SgiLNvEV7q8tXGmMHIuDS99ohmY/jzsR/jjqj5ieUVF9ErP1DBST67My/ZYA/wEXuuzgVyowW4n0nMc8aeB1eFua8WcI34pKAgPtTfhv8mc3oLvfyNr/TShBvpfOP6qZw0n2lZ9AQsH//aSnc46mPbub5R4SA4SwWOTexfy8ggL5WOxq08AidIpCPljHyCucZB0wuBJHIPAgE0naKE5SPuO3EXc4+o+R5/aEF64hdaN395QyHYqU9jERCHEd7+pHRBYIY1CaONobGsprNq8iIFMI5J1ZCtevyIMhYJclO/8ZmlzWqtGEpZP6II6NYAwH7Fx4DbfzpOK3V5nEJl3D7mTjBFppDMk2Zu8O9OIFlDbjyFs0cUSunq2J6D6vEguuOfRyR57WjnADQzDMZ+WKyLM1mvMpIxpWbxLT0i/KAtNovONXVorrOS10lTkis6LeCTTvLGZ5+PyLjXEYzf5+15yw4=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(39830400003)(396003)(136003)(346002)(376002)(46966006)(36840700001)(107886003)(8936002)(6666004)(186003)(426003)(336012)(7696005)(70586007)(7636003)(9786002)(36756003)(478600001)(1076003)(36906005)(4744005)(5660300002)(54906003)(8676002)(4326008)(316002)(356005)(44832011)(70206006)(110136005)(82310400003)(26005)(2616005)(2906002)(83380400001)(36860700001)(47076005)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2021 06:48:41.6254
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d535c6e4-399c-4b41-b56b-08d945ca4079
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0060.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6918
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Add PM runtime support.
In case of errors disable clocks.
Add runtime PM support.

Shubhrajyoti Datta (2):
  tty: serial: uartlite: Disable clocks in case of errors
  tty: serial: uartlite: Add runtime pm support

 drivers/tty/serial/uartlite.c | 61 ++++++++++++++++++++++++++++++-----
 1 file changed, 53 insertions(+), 8 deletions(-)

-- 
2.17.1

