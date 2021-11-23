Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66BA4C433EF
	for <linux-serial@archiver.kernel.org>; Tue, 23 Nov 2021 13:14:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbhKWNRN (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 23 Nov 2021 08:17:13 -0500
Received: from mail-mw2nam12on2042.outbound.protection.outlook.com ([40.107.244.42]:15739
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231240AbhKWNRN (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 23 Nov 2021 08:17:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VF6vFhps3q9T5ThjarJf6MsZ9X+0DLpShH1TP7okuBh6KSTBeNalZ4GvVoZO6n6Yfa8fIObtbhsTGAb3IP6N69dsqfg1Mi7Wh2F8wLgIJae1CbTd3KnDUG9jX70J+TynuuD1xxvRWMpd7kMGivcHUO2uvxdbf3759O7E/eyKHq4nQS0zUY9UltH1gUxJz9qhr6MAbU7I/a0UmXL29pDSwmdmERqejOVhRhtGz8+6y549JnpaMOsKKwlK0XYS3khY8d/YEXbA/rETWuRuxKUOJcU+7Nuh6dkPeaYvJzVPHBkj4RoFxjEpiJC9foAed6rsb7GuRGjJXdEj5nEXd+eKcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ojOmAuZ9FZ+FyoS7dJxIYvp7dxkDtMry1r9xuMG7gEk=;
 b=a3mzea4IzQyMfuP9YkncJgaWxouDVf9RgWLdsNpn5jatky8y+5EoqYlrfXV4iDmsEdIeY23hlO3KFZL6+Q4sDA5ev21Et+iLdvOHJpNN0oLMhZW/eBEteDJ5C10CpyePCFY7Q+kemX/vveP78HmDQ3Vfc22H2i3tXD7lzW10A/AM94iOAucgGQXu6BPeZoW72XqQxH7XbEk8wHkFGUkHlJYwYJT8ZohIKVyrzL/ha+Oa5wO9cTAQJ54IReyrdnuwdtiR5+8kS8DKlVEcsHeDjyMCHwxwqurQP0DJCRLZSyx2MBLXs8VST6ubBRfdrhclkUM/TDVVwrhXF7q+IKpr2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ojOmAuZ9FZ+FyoS7dJxIYvp7dxkDtMry1r9xuMG7gEk=;
 b=nu/TZj74qo3hm7NMm4smbARFQFVUP+dELek2IVdB296jag+9PvQ4BNBPjOpXTlrk11bRhFjXseL6XMs5TqnwPOYy3zzMD0esoZl3DDJfTVjSqO+aY1w51A1QrsnDul1V2rXpU2xtY27dmSjsv3ZEiJixyvkQ2zz6JBgBfe8aCOw=
Received: from BN9P220CA0023.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:13e::28)
 by CH2PR02MB6328.namprd02.prod.outlook.com (2603:10b6:610:5::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22; Tue, 23 Nov
 2021 13:14:02 +0000
Received: from BN1NAM02FT027.eop-nam02.prod.protection.outlook.com
 (2603:10b6:408:13e:cafe::7d) by BN9P220CA0023.outlook.office365.com
 (2603:10b6:408:13e::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.20 via Frontend
 Transport; Tue, 23 Nov 2021 13:14:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT027.mail.protection.outlook.com (10.13.2.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4713.19 via Frontend Transport; Tue, 23 Nov 2021 13:14:01 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 23 Nov 2021 05:13:55 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Tue, 23 Nov 2021 05:13:55 -0800
Envelope-to: git@xilinx.com,
 linux-serial@vger.kernel.org,
 jirislaby@kernel.org,
 gregkh@linuxfoundation.org,
 jacmet@sunsite.dk
Received: from [10.140.6.18] (port=55080 helo=xhdlakshmis40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <shubhrajyoti.datta@xilinx.com>)
        id 1mpVcP-0002IH-8f; Tue, 23 Nov 2021 05:13:54 -0800
From:   Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
To:     <linux-serial@vger.kernel.org>
CC:     <jirislaby@kernel.org>, <gregkh@linuxfoundation.org>,
        <jacmet@sunsite.dk>, <git@xilinx.com>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: [PATCH v2] serial-uartlite: Remove an un-necessary read of control register
Date:   Tue, 23 Nov 2021 18:43:48 +0530
Message-ID: <20211123131348.26295-1-shubhrajyoti.datta@xilinx.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6778d44a-aeb8-4adf-ad7d-08d9ae831dfe
X-MS-TrafficTypeDiagnostic: CH2PR02MB6328:
X-Microsoft-Antispam-PRVS: <CH2PR02MB63280967DA7101791DC04DB4AA609@CH2PR02MB6328.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Opx7kA1okIRdKzbU8AMEK5YTaKRMxivjLYCpn/EOPwfBxdVj22ctJaT8O359AvMa/VmjjEqMi/XECmfCR0yuOFQB6OxwfltR63qlO/Zf0zH6WBdBUfjnPWLmjUmfet185njabfyUoJXamx8dbqfzD5UB3Ydiq0w3UnoHdEeQekWpMBwQrD2qHXOl/kdl+U/BMiO8bjRovCUqRDlhHelA9rUlvvMD5LhLJPrO+VlshAkKswyUK6JHfEpEFHSGX3dIfu1sNU9IUxP6PApPQjMIaX15L2I4dCnchnlP2/320xk4ula9mMgz2MaeScqJ0Ck7LLTuPkNwZSNdMx1/vCyNwwo36ZXAE1zn8Ent1D37p8LGbkUykzaiDdvpvFGEoA4xHwUUvN7lSxQyFxnJUBdnZtpmrRl3LHoL7pLQeYkfVia4BN1LCWIEWGrySUchxSdl+RHtUJ+1x2dlVt9qNjOEaK2Xb7YQ+cJpHi0CzxMD71CwKA2vdcS3R1zSruDiPPSzjFKeg2z7Ikcaq2az3rNh4e6a4w6gcW8usC0Bu6mlukdeJfKFz+WC43sDVEsNMoTfrW2sf4sZuo4RaHP+HplfcAC7rkkvzJHjui4T3ndnaV0EHY79oqdFKQ1JzVcsvfk4oHoYPCLIzNtYmEH2prIQXE6PtxW3jKENgdI21iwwlIwQTQFDI/dxtBjkh3lYFWUE8gGDTohdy1Ro0YsBf8pZuGwNPtYxaMigB0z8k2jMbSKWRxVA+d+q9z9inobXckIF35NrgUX2hUVWKvjjwRHslWL3p17fMms7OpJamjeO8dsLz5BGCPs9txAKMHxM8icU
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(46966006)(36840700001)(36756003)(47076005)(8936002)(107886003)(336012)(83380400001)(7696005)(426003)(6666004)(82310400004)(6916009)(44832011)(1076003)(508600001)(54906003)(356005)(7636003)(70586007)(186003)(8676002)(36860700001)(70206006)(316002)(2906002)(36906005)(966005)(2616005)(9786002)(4326008)(5660300002)(26005)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2021 13:14:01.5335
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6778d44a-aeb8-4adf-ad7d-08d9ae831dfe
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT027.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6328
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The control register is a writeonly register that's why reading it
doesn't make any sense.
The manual states "This is a write-only register. Issuing a read request
to the control register generates the read acknowledgment with zero data."

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
---
v2:
Update the description
https://www.xilinx.com/support/documentation/ip_documentation/axi_uartlite/v2_0/pg142-axi-uartlite.pdf

 drivers/tty/serial/uartlite.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/tty/serial/uartlite.c b/drivers/tty/serial/uartlite.c
index dfc1ba4e1572..0df471eddb0e 100644
--- a/drivers/tty/serial/uartlite.c
+++ b/drivers/tty/serial/uartlite.c
@@ -297,7 +297,6 @@ static void ulite_shutdown(struct uart_port *port)
 	struct uartlite_data *pdata = port->private_data;
 
 	uart_out32(0, ULITE_CONTROL, port);
-	uart_in32(ULITE_CONTROL, port); /* dummy */
 	free_irq(port->irq, port);
 	clk_disable(pdata->clk);
 }
@@ -368,7 +367,6 @@ static int ulite_request_port(struct uart_port *port)
 	}
 
 	pdata->reg_ops = &uartlite_be;
-	ret = uart_in32(ULITE_CONTROL, port);
 	uart_out32(ULITE_CONTROL_RST_TX, ULITE_CONTROL, port);
 	ret = uart_in32(ULITE_STATUS, port);
 	/* Endianess detection */
-- 
2.17.1

