Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8300C00144
	for <linux-serial@archiver.kernel.org>; Fri, 29 Jul 2022 11:48:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234874AbiG2LsS (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 29 Jul 2022 07:48:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235143AbiG2LsO (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 29 Jul 2022 07:48:14 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2065.outbound.protection.outlook.com [40.107.92.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3E6D87F4F
        for <linux-serial@vger.kernel.org>; Fri, 29 Jul 2022 04:48:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DvCggTfjiDCXX9dcnYQkcoyV0THhgT8q1adLHx0LRkdm9IvoVBcXJQKUzvYO0KYivspnJPCoNskbgxDOi3pDYbDmSFMy4N2eefeu3g2xoAoe+ebyNVAbsjkp25NwBgO+UAF4bi1kpLdeF4pxLZmGDlCBAFA4fofpQLeEqNYbD574uA32OaxH/8nXSfmVMjA1lHUQy/S2wMZIzo/s4JkTucpz0i3cWifKFESfxevvYF9fEXTkXkjlyt97wamNwTl+L+q+mr6o8nRIzTQ1vRRbGMs/eLVrkExo+4nLlLCc7f55absiRXA9ht0HO+hz3N60sOlIC2uNbYDo5pT+7BqKOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y1tGCJQOjdjzQoTHoDaLHma027MZX0sVuh7BdRxnJow=;
 b=AApxCTNEGE+8/Ex5zdi6wylaMpa6hmhW2wBxuCbmZVjsuUk3sImnJaDIBjzKFPtXPVntXqW5KMBw8m0K939KCYsGr4PRV76cg+kkh+Dgr6cScol+fD0rNfQTYvV0FYyaWyO5Im1pLrsKo2IwwFHmpb/LIzaU1fRe6SgS05I+cF3amv/DMYJTzYpsI/EndZXyc3noAyI2wFL0GFMmtukHUJxkod/4Fs4Dynv+aGtSdTeVM+v+GjL2ijht4UCSCNhCuF+1h+OourZLBvMPjb6YqHJk3IWsPiCISSWEv+HGW4YgHgNLOpdRonTOqShBz4iofuGLF004ArO0oreSrlI9fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y1tGCJQOjdjzQoTHoDaLHma027MZX0sVuh7BdRxnJow=;
 b=lRxRJsC9QQOI/4MAUQ0v9hgY3h4Zb5GtmLKdf+gePj6F9Qt1vYwEKihDUePIyyG/1+PgRmGQCg/dM7XXNvDbfmH8W+X4UAV3Q4Acccovq0NSVdOIayHpTP8GWmKXdyQfrbuSkCTeeURKOKL7shN8qnKt8JQM2FIrnVBo16Bb74Y=
Received: from SN6PR01CA0004.prod.exchangelabs.com (2603:10b6:805:b6::17) by
 BN6PR02MB2500.namprd02.prod.outlook.com (2603:10b6:404:54::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5482.6; Fri, 29 Jul 2022 11:48:11 +0000
Received: from SN1NAM02FT0041.eop-nam02.prod.protection.outlook.com
 (2603:10b6:805:b6:cafe::c5) by SN6PR01CA0004.outlook.office365.com
 (2603:10b6:805:b6::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.10 via Frontend
 Transport; Fri, 29 Jul 2022 11:48:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com; pr=C
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0041.mail.protection.outlook.com (10.97.5.44) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5458.17 via Frontend Transport; Fri, 29 Jul 2022 11:48:10 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 29 Jul 2022 04:48:04 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Fri, 29 Jul 2022 04:48:04 -0700
Envelope-to: linux-serial@vger.kernel.org,
 gregkh@linuxfoundation.org,
 shubhrajyoti.datta@gmail.com,
 git@amd.com
Received: from [10.140.6.18] (port=57946 helo=xhdlakshmis40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <shubhrajyoti.datta@xilinx.com>)
        id 1oHOTL-000DJo-VQ; Fri, 29 Jul 2022 04:48:04 -0700
From:   Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
To:     <linux-serial@vger.kernel.org>
CC:     <michal.simek@xilinx.com>, <gregkh@linuxfoundation.org>,
        <shubhrajyoti.datta@gmail.com>, <git@amd.com>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: [PATCH v2 4/7] tty: xilinx_uartps: Fix the ignore_status
Date:   Fri, 29 Jul 2022 17:17:45 +0530
Message-ID: <20220729114748.18332-5-shubhrajyoti.datta@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220729114748.18332-1-shubhrajyoti.datta@xilinx.com>
References: <20220729114748.18332-1-shubhrajyoti.datta@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 36462786-ae2d-40f1-d883-08da7158363a
X-MS-TrafficTypeDiagnostic: BN6PR02MB2500:EE_
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m/mqbe58d5iNUshasP22uuXbr6gNPcZpQPfi4tJTNsoRICh+YIm/biMxiV7mP7+mrC0qWWtL3ff19FoOhN35E7KkZUt4WTcvHgnuEnXE38dJ4EX0czX/eI6q3eqlPBQO9Qz2/KFHLxpnT57h/+8NqJXLrhXgpdbjR+DgX3Qi2owM8RpVLV5CBuJqntQfLECjjwlXR4N8TIvii8J2Sjo1jgqytZow6hcNUugPNjup3KG58m4HRjNFOrL6Gcv3wM4mUZBIxyXhtdY1s4FW82C4SZo+Mzry2llTkyGFTL7Hjo2FpVFzXoE7Hg9wDbgGwdVMOfSbqp323psn36hVEb5+JB3huDOGgM+1zDMVMmab4xAPi2cLzSjvYIbuB3WZlhdLFKwpaynsYjRjdBOVIreTWDtdy7Tw0xBE0IM3s0/qXrToxmJAnBcVwRWzCSlzPpiLninirA2Q3G7h/pROel5O8NkIkEDVUG7wbZauq0BDnm4m5WrrxT+D7NauVpfkgn3VUp/WFlnj9c4Ms64Oe7losue1D+nQ8k+cSuSsx2r+X+y2wuKxZbCgJPf66JTdOAAUyzdp5c5r7Z2z+2TxQKCM9rQBC3Oq5KJJYfQVzjgQp4LxoSt3eqYBIbGWbZCIIMwfjedty2zzQ/e6ZwdSS0LZqW8rifwcV2IwDzilvX9QqgqWKHPvfkCwlSnks9VPSJKZyMexGwzRRs/ilcY6XBLtS/yD8FsuFZLOSFyYRryrgySR7AGEv7gPJbujZ7Syyh6nthgPyCCKRpDbli9OHb/+DFXa4RCmoRBF6N3BusOG/qmYkkzDgySL1auAw7qecrtPdc8RkufKUxU5NSjSCOa6FQ==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230016)(4636009)(346002)(376002)(396003)(136003)(39860400002)(36840700001)(46966006)(40470700004)(40480700001)(40460700003)(36860700001)(7636003)(82740400003)(356005)(7696005)(82310400005)(70206006)(70586007)(478600001)(9786002)(5660300002)(4326008)(8936002)(8676002)(316002)(6916009)(54906003)(186003)(107886003)(336012)(2616005)(47076005)(1076003)(426003)(83380400001)(41300700001)(2906002)(6666004)(4744005)(44832011)(26005)(36756003)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2022 11:48:10.6452
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 36462786-ae2d-40f1-d883-08da7158363a
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0041.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR02MB2500
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Currently the ignore_status is not considered in the isr.
Add a check to add the ignore_status.

Fixes: 61ec9016988f ("tty/serial: add support for Xilinx PS UART)
Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
---
 drivers/tty/serial/xilinx_uartps.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index 94e1bc694457..ae99e1164f0c 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -361,6 +361,8 @@ static irqreturn_t cdns_uart_isr(int irq, void *dev_id)
 		isrstatus &= ~CDNS_UART_IXR_TXEMPTY;
 	}
 
+	isrstatus &= port->read_status_mask;
+	isrstatus &= ~port->ignore_status_mask;
 	/*
 	 * Skip RX processing if RX is disabled as RXEMPTY will never be set
 	 * as read bytes will not be removed from the FIFO.
-- 
2.25.1

