Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDD27C2B9F8
	for <linux-serial@archiver.kernel.org>; Tue, 25 May 2021 08:21:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD55E61419
	for <linux-serial@archiver.kernel.org>; Tue, 25 May 2021 08:21:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbhEYIWt (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 25 May 2021 04:22:49 -0400
Received: from mail-sn1anam02on2069.outbound.protection.outlook.com ([40.107.96.69]:37617
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231325AbhEYIWs (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 25 May 2021 04:22:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jiTIjuP5rlm6o5AjUJfwvzwNcl/s4HVmO2jdHdiHt33y2VzVo000h7cQeewbXr9+YdkyCX2bxCkg6VaZ5MtuQCDt8u6l94wV8VNe5jla/SmSLAKgJzAZYu49jKCjzWsuYD1kj358QFRCYS/C4uriHp2NBmr+L49kjkCtOlQmW3geH1UT2B6quY4rGz++81a4wQm0uRKYADajqa+7frjiGpVGzOXd1wrJ6S+tTa/bDQRm7zn+LoDu2VXRQI1bhAKjLdqoZUO0ofqDBzobm05dt36pBCpcTXG/MTiBzs6KAwkmqgF1+8nlfIZaTsMBZ22D0W8XZvXMuiS6wnM41VWIZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nyM/QKyBoJapznQvYiSG7D3hHrz8eCI92x9rgLJkzcQ=;
 b=lj61YaH567Q0MHmkzlWYUX1PR0qwc3Yf7/Izx0WJClZQlTQf8JN3D6+NPLFSdnpbAsudDwVXM03c/kMzexrUyoX1QwfcZ4Sg5eS+tHhnTtOO1xq5d9CeKLZPMi0cLRzsZOulMrx9HZzDmO6yn/1tntnbnYhuoHRntL6+I/QVdtePwVuvWnk3rNJ1u7VgI9NoqfpdpOJRphMuOTSToQu+TSQxu2Sc3pxYoKNgQGJfTX784TqRllzVLUAvLTUtUvXfcgJhCxKyiR0eBp7lFHeGh74+XQZ9Ii8tv86nkCHmhwdeHqeuA7QwLmPm5f3FDMGKwNqg6PrelrZzD68AZM3jBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nyM/QKyBoJapznQvYiSG7D3hHrz8eCI92x9rgLJkzcQ=;
 b=eKDe3kAN96F/lpc6OIr2LPRq4a4pq13+yJ16n+P0wMhDbgDMsp+yMyMluI1UCrOzC5i29/QHV5KlvEgbs2GmkzAsPu221sFQdNFb/pZPkB+knpWQTnLf7WA52yuTb10rnbIlO/OuopqC5Dg07RCzZDmH78ZFaQNwXsYjfCVxAiM=
Received: from BN0PR04CA0050.namprd04.prod.outlook.com (2603:10b6:408:e8::25)
 by SN6PR02MB4477.namprd02.prod.outlook.com (2603:10b6:805:b2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.26; Tue, 25 May
 2021 08:04:26 +0000
Received: from BN1NAM02FT008.eop-nam02.prod.protection.outlook.com
 (2603:10b6:408:e8:cafe::31) by BN0PR04CA0050.outlook.office365.com
 (2603:10b6:408:e8::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.24 via Frontend
 Transport; Tue, 25 May 2021 08:04:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT008.mail.protection.outlook.com (10.13.2.126) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4129.27 via Frontend Transport; Tue, 25 May 2021 08:04:26 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 25 May 2021 01:04:09 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Tue, 25 May 2021 01:04:09 -0700
Envelope-to: git@xilinx.com,
 linux-serial@vger.kernel.org,
 jacmet@sunsite.dk,
 gregkh@linuxfoundation.org
Received: from [10.140.6.59] (port=58378 helo=xhdshubhraj40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <shubhrajyoti.datta@xilinx.com>)
        id 1llS2p-0004Kz-Q4; Tue, 25 May 2021 01:04:08 -0700
From:   Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
To:     <linux-serial@vger.kernel.org>
CC:     <jacmet@sunsite.dk>, <gregkh@linuxfoundation.org>,
        <git@xilinx.com>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: [PATCH 0/2] tty: serial: uartlite: PM Runtime
Date:   Tue, 25 May 2021 13:34:02 +0530
Message-ID: <1621929844-19727-1-git-send-email-shubhrajyoti.datta@xilinx.com>
X-Mailer: git-send-email 2.1.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c9868051-75bb-49e7-1ab6-08d91f53b73f
X-MS-TrafficTypeDiagnostic: SN6PR02MB4477:
X-Microsoft-Antispam-PRVS: <SN6PR02MB4477FB75AD0DAE999A851C73AA259@SN6PR02MB4477.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:2276;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QRASniEF3NQFyUNQgNh2r4OebLkFQ6hBlUYOr83yr/XGlysFO7QYBbj8xZRRH/vfQ/qEw9Ob3cP/3rL8N0riGIEbrEOWrmQdCX7okRgn6crS7cN2JLrNcyAj78WIzrZBVeF/xpDBJRFupmDBaqNj6xX9kkHQcrZtGIIvrbKmrQrA7J2HGlALh1EghCwm++KsAASJJ7Ogzrn+7BNotq4pEvRg7QSYdDKf3VNsf8lr+6C9akRkc2jral+WGcAStLpvNAHqKdaHxty9KPU6IvLnoEhhiQlGCbv3cW4eutSjVPowENIsFOlF5iauBZdqp2BPXdCTkxMgz6pgHbG3kcDKrrdryshQMGoh5NE13gL0/AWKg+cD3jFh+BBtFrNfsC7Tz1rmgK7GEoLuBlRG0jLTOmllvJ3+ivZ5L9+X6zMkomsUxpnmJTSSqYuCSP8JSm5PtvYStNi85g/4s++ff2hzMryqyF3phgwpIdZx/DnYNljaUU2kWmTNVCSdIiISX3VUbb59wFPRslgAmOIvxfR3yEYy9xBVyWUTrFjtRHWlzc3HGgl7hjlS+55CKSGAg3yFa20x9PLOTDXVQTEmJlaVtTtbyD6Njudp021FS+jceYvHlrbRPS5AKsL9JpY0bkDC7UOsV8S67W/5LJSCgiye3cCeC9Gix/YAatuhT/npHKBs2+LpDr6W0Mfg1AwkkMCY
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(346002)(376002)(39850400004)(396003)(136003)(36840700001)(46966006)(9786002)(36906005)(7636003)(70586007)(7696005)(356005)(70206006)(82310400003)(336012)(54906003)(316002)(8676002)(478600001)(4744005)(44832011)(4326008)(8936002)(6916009)(47076005)(2906002)(107886003)(83380400001)(2616005)(82740400003)(36860700001)(426003)(5660300002)(6666004)(36756003)(26005)(186003)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2021 08:04:26.5259
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9868051-75bb-49e7-1ab6-08d91f53b73f
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT008.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB4477
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Add PM runtime support.
In case of errors disable clocks.
Add runtime PM support.

Shubhrajyoti Datta (2):
  tty: serial: uartlite: Disable clocks in case of errors
  tty: serial: uartlite: Add runtime pm support

 drivers/tty/serial/uartlite.c | 65 +++++++++++++++++++++++++++++++++++++------
 1 file changed, 56 insertions(+), 9 deletions(-)

-- 
2.1.1

