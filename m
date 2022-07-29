Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03397C00144
	for <linux-serial@archiver.kernel.org>; Fri, 29 Jul 2022 11:48:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235391AbiG2LsA (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 29 Jul 2022 07:48:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231454AbiG2Lr5 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 29 Jul 2022 07:47:57 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2044.outbound.protection.outlook.com [40.107.220.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5236B74787
        for <linux-serial@vger.kernel.org>; Fri, 29 Jul 2022 04:47:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a1kjEdP9OuVYUDANzV8r+HBBr/zZi0xcTsujqpsl/rktD3dEhI0bTiZEs3Mpj9cYJ6CBHd5K/60wCuLPUVt3uG9K0rI4WWaTZ4QQo5x4rxkUT6vqUflppHBQWwVhu5xmksGI4jQjsLuMeoIgVk7nZ5PWXxzKGPUL2tmbq6reeqAkrcn8FTY0KRs/epqBt61zL2nYNP4UAHx2MGVzV2Cps6GxvUCLxBN4I1Plx3id2NGUJMnuSpYpnGbNUlPzlUhUMKShj7UqATtFiFR/lnwSVCitkeQ80MjlWcfj47NgDWkEj32phkkSWS3CgVGmc4X31kp/ncGc27QWmJbZNfge0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rb9gaBNAW5ih0mEnqUgesm4xKz7OW3JVRssmwnpTftg=;
 b=PHEzCJDdGOWvSDO5a7775y9S2mOs2isEhUZvqf6TR+C5oeBqBT60qa2U19Wch86J9cCj8MywgZjr1TZS1TzKbsG1pjFPp8HhVnv5a+BLDQBGiw9WesYsUaQ30TqdKQsx5iyC7xAyHcrLw6dqvsElQrM4g37cd+iV1FvDziUx+1m40JnZQWXNAAluTCeYcr6XH6nnzh6eaitghIJoudcPU73R9C1iTR2i01rT59WXwSSdiM0pWaDd+Mld2+gJ/SzvXiyGtxI3KEkgUPPx0zCUQVs3vi3GGWoUyeCWnsX2sgywICvfXDohy1kVdya1CzmDfNUYSsXZUrV6NOoRuaFauw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rb9gaBNAW5ih0mEnqUgesm4xKz7OW3JVRssmwnpTftg=;
 b=kxeiZeaiNepTjvXMC0cGf9Ph6SnnPnr9S4VzAhJB62eE3Re5lFmmqF6wxZMk1q9n83WZIArjddO3SNihbWGPpSh1LeeHzI/c5YA2EHgKINRMA1YeGr30ky9yYBpy1NwdQmJiwq5BwIPwrd0oFZQZGeVnnD7zU1YlFGY04XoFRTA=
Received: from DM6PR11CA0050.namprd11.prod.outlook.com (2603:10b6:5:14c::27)
 by BL0PR02MB4530.namprd02.prod.outlook.com (2603:10b6:208:42::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Fri, 29 Jul
 2022 11:47:54 +0000
Received: from DM3NAM02FT056.eop-nam02.prod.protection.outlook.com
 (2603:10b6:5:14c:cafe::59) by DM6PR11CA0050.outlook.office365.com
 (2603:10b6:5:14c::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19 via Frontend
 Transport; Fri, 29 Jul 2022 11:47:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com; pr=C
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT056.mail.protection.outlook.com (10.13.4.177) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5482.10 via Frontend Transport; Fri, 29 Jul 2022 11:47:54 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 29 Jul 2022 04:47:53 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Fri, 29 Jul 2022 04:47:53 -0700
Envelope-to: linux-serial@vger.kernel.org,
 gregkh@linuxfoundation.org,
 shubhrajyoti.datta@gmail.com,
 git@amd.com
Received: from [10.140.6.18] (port=57946 helo=xhdlakshmis40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <shubhrajyoti.datta@xilinx.com>)
        id 1oHOTB-000DJo-Cc; Fri, 29 Jul 2022 04:47:53 -0700
From:   Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
To:     <linux-serial@vger.kernel.org>
CC:     <michal.simek@xilinx.com>, <gregkh@linuxfoundation.org>,
        <shubhrajyoti.datta@gmail.com>, <git@amd.com>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: [PATCH v2 0/7] tty: xilinx_uartps: fixes and improvements
Date:   Fri, 29 Jul 2022 17:17:41 +0530
Message-ID: <20220729114748.18332-1-shubhrajyoti.datta@xilinx.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 60b654fb-48f4-435f-4efa-08da71582cad
X-MS-TrafficTypeDiagnostic: BL0PR02MB4530:EE_
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N/aEMDgRwsNPoLIRoGKWq88rUgo3WFyrMDaXvBWBXmpKy3uwWiKluWf4QNt0iYu1L4CUIa8jMMFej8tPwYHVkbl/wOPG7ILVpFVjGb6yACPedrYLnhXcahDxAi2t+eiofmtH02OlhUi5mZmRSWGfGrzCziiyLCP6ud6EcPbREd1Eno6hkNbciWF6uV44KeWy5Bocq7UcG1lqydDIy4pTlxGPNTWNQT4Flmf3TDaV4CQjvebavGkYezK1cnUmK6KRXRrDyiIm12yXNgk8rBLT3Q5nximw1K4kb+2qOJMBaKphREZwfvZGA34v5b2S0hrb3/YhKSU5v0I9K/dONApen4/nUTuXJB0CjQZEPYbmKXeazrQhqvkJYEMP0XOp3R5ilanaO0G2q+ltkqXpTfnq3R4fChPC4tIffF2Rwb97BG4v+83S1tE4MtpmvinS4+fvnF0K6BePhFfqlt222Yzn8ATKusoEhwht/s+zmxu0qXvyQ6wPvO6kNng2ApqXuqGzDJigAEXTkmHBeDHbgk5LY30BKd6n0DlDe8EJXeofqh1xSWvAg5uFSm/q/xmh3GT/nAtSvovHqrQz1lvy7A4WH7aUoPFveOwcLtmrRAZBb1wYI9Qu1xEvZ4K0OJEGaDFs7SOei8ypcjDpV60+Q3+TTz7Vn+0hgo+/FsXH7xIVAUF8RqQreYLHh6QDqniKzboOTkWYpM1Kp6rkPrPG7tID8zbEl+Ar6Q7BJW4qKLXPjDjX0GT5ty/fKHTYUgTvmL6eDDeHC7MAhI5Q7VbdAVE+SZMPNiCoDw7taCjSDZpOJxmP1YNGUsuBYo15EFIoi3hKrXsJ0zcXUT+xxFO2IK0evA==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230016)(4636009)(346002)(136003)(376002)(39860400002)(396003)(46966006)(36840700001)(40470700004)(4326008)(26005)(82310400005)(41300700001)(6666004)(316002)(478600001)(6916009)(40480700001)(40460700003)(356005)(54906003)(82740400003)(7636003)(36860700001)(186003)(7696005)(107886003)(1076003)(47076005)(2616005)(426003)(336012)(83380400001)(44832011)(8676002)(5660300002)(70586007)(8936002)(4744005)(70206006)(36756003)(9786002)(2906002)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2022 11:47:54.6025
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 60b654fb-48f4-435f-4efa-08da71582cad
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT056.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB4530
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

changes are 

- Update the copyright text
- Check the return values of clock enable calls
- Check the ignore_status in the isr 
- Prevent writing to the fifo when controller is disabled.

v2:
Split patches.
Remove non functional changes for coverity.

Michal Simek (1):
  tty: xilinx_uartps: Update copyright text to correct format

Shubhrajyoti Datta (6):
  tty: xilinx_uartps: Check clk_enable return value
  tty: xilinx_uartps: Initialise the read_status_mask
  tty: xilinx_uartps: Fix the ignore_status
  tty: xilinx_uartps: Prevent writes when the controller is disabled
  tty: xilinx_uartps: Add timeout waiting for loop
  tty: xilinx_uartps: Check the clk_enable return value

 drivers/tty/serial/xilinx_uartps.c | 59 +++++++++++++++++++++++++++---
 1 file changed, 53 insertions(+), 6 deletions(-)

-- 
2.25.1

