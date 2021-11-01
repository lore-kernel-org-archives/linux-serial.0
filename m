Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52445C433EF
	for <linux-serial@archiver.kernel.org>; Mon,  1 Nov 2021 12:28:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22BEA60F36
	for <linux-serial@archiver.kernel.org>; Mon,  1 Nov 2021 12:28:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232244AbhKAMas (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 1 Nov 2021 08:30:48 -0400
Received: from mail-bn8nam12on2063.outbound.protection.outlook.com ([40.107.237.63]:21698
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232036AbhKAMar (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 1 Nov 2021 08:30:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=coDWiz0Wy7CRqi8bxI9IU6hqTJQjW3gQmSDjli52YgFZFRas8FyuaN208gmmw97yX7f5LfmKbW3V5rKOlqxT9YFi6l4FRPq0Kfi+qPPq/RSE+0boS/t3JuKuc1baM7thdEfvj1nn5dX9i4teLEO19zHrtdreOqSUT5jx+hynKYxQFLbp9Xo9FUzPM5OH2/+du3wqxDK3a5+FbMAK7O/jh9Px653h3DPiYVEWQISIYA8QP69bKO8aUTOlZJXxlL8Q9jaKLoKGPdb6H9miZziJNAuYNmPKokxAGQVjIqZVUYZHCW6WIyRVWo3f5UXN/nIZ/ufzjN5onr0qXx9RAFyXKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L4hPCt8oNUFeWse/FoXMOJxyGUYL15r/Ur/Jg9kMeRc=;
 b=HZzjCTNOmI4oh8SZtZYxgNlh4II2diuEbdbetPRoinKCakJPQ1IZyga3kLi7+Wib1fj57Rua5Gt3JCO/mEf0NlUmkM2bV7zvFdIu2OxfQf5/4DICcBm37GXVOCvizOw+nrcYET24RGmb+TtQchwKRdWyLqHJ2Olynp2h9mFvrrNXlJmAS0i5YwihXjDjn0xC1ufgCpIwn2Yn1J03WVT86P/c47w028HcQ+m6RwFKQk2NPvykV2yhWZZUod3USR9ZV1wvtcKWerxvOTGI0yxSq5fMwXmEtU0pPv29ZyGfRHR1Mk5O0YOfHv3zSgGU7DBz3jrtGwMuiV4j/7wJ9YdA8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=bitwise.fi smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L4hPCt8oNUFeWse/FoXMOJxyGUYL15r/Ur/Jg9kMeRc=;
 b=ASBCQ/iQe20kA8TWXXPvLRigM5JyaOmy3Wk2p2rQ4qoZNIYhBpFosMJF3fVvndbagD5beyNI9Ifo9sYiAuhMsBgIroHl30OUNYXtjuDLkJnApofMh/Aebt2b+YqsaPoDWTkroCFODw8R8F+vkJIWqqbOJ2ib2SUDTycNLCwkHuI=
Received: from BN6PR2001CA0042.namprd20.prod.outlook.com
 (2603:10b6:405:16::28) by DM5PR02MB2364.namprd02.prod.outlook.com
 (2603:10b6:3:4f::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.18; Mon, 1 Nov
 2021 12:28:12 +0000
Received: from BN1NAM02FT032.eop-nam02.prod.protection.outlook.com
 (2603:10b6:405:16:cafe::86) by BN6PR2001CA0042.outlook.office365.com
 (2603:10b6:405:16::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14 via Frontend
 Transport; Mon, 1 Nov 2021 12:28:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; bitwise.fi; dkim=none (message not signed)
 header.d=none;bitwise.fi; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT032.mail.protection.outlook.com (10.13.3.192) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4649.14 via Frontend Transport; Mon, 1 Nov 2021 12:28:11 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Mon, 1 Nov 2021 05:27:57 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Mon, 1 Nov 2021 05:27:57 -0700
Envelope-to: anssi.hannula@bitwise.fi,
 linux-serial@vger.kernel.org,
 gregkh@linuxfoundation.org,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Received: from [10.254.241.49] (port=50498)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1mhWPs-0009vB-Py; Mon, 01 Nov 2021 05:27:57 -0700
Message-ID: <685e4187-d2cf-4468-ded3-cca0e8bf35b4@xilinx.com>
Date:   Mon, 1 Nov 2021 13:27:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH] serial: xilinx_uartps: Fix race condition causing stuck
 TX
Content-Language: en-US
To:     Anssi Hannula <anssi.hannula@bitwise.fi>,
        Michal Simek <michal.simek@xilinx.com>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
CC:     <linux-serial@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20211026102741.2910441-1-anssi.hannula@bitwise.fi>
From:   Michal Simek <michal.simek@xilinx.com>
In-Reply-To: <20211026102741.2910441-1-anssi.hannula@bitwise.fi>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 37ca04c6-0e91-4606-6acf-08d99d331206
X-MS-TrafficTypeDiagnostic: DM5PR02MB2364:
X-Microsoft-Antispam-PRVS: <DM5PR02MB2364AD3587AF8F9CFCE05FA2C68A9@DM5PR02MB2364.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2Q1bdYpFvh2sR6tN/BykI4Q5BjPg22OXSNCxDkvysjAZmyEICWOrB1E0sbHX1Tpw0dnbIXLh+23AHY8N9UKZkBZ2nKTAqJo7GCTDVCEqpV4hDYBfnISC4T7emlQPEYOM6qQNagz90BwHvzG5QEuqlwlH/sj9QpTzQ02odN0pnXSOvfwKIRlxd/OGN11zeCTtzbACtv4XRoSytTC2d9AABZhcrMSj/YRiOHaKZc5Aw0rXalZS0KRMCtSa+EMl3EYAK/WbIRZnMi66hclVxDfYm6mXjXmHHpzvRiaGqI19qpJVoYaVEIB/Xw3VxweFjf5ymE0Uca0wW8yCqzt3BADmVfV3dBseUvQumXMDq4osF7vE/izO9lWhk3FBzERqxva35X2hnsu9W2m73SHzjvr7WKl+J+0BJ+BO0/p8d/tFDRMz7K/iQBGdqSAD4wrUIZhaSUoFWmdp07ldeuGtRgO8SbH5fk4p1vqRoEyR3OgDkcMB6T9FvMjWudU5LLe5GFdHzBAWy/XiKNr2AN20F1jrp6jSc8JtAkB47C2USb9SaASWc7JIMHliwEq43GZ9oW2BP0kOfQQkLR7awvflAQmQqjcWztU1bJsvzZ2hVKq+0bfrZp9ux1Met4PNJ69kiCHutXtSbp6G2sV9nfdqruMJaza0IwvnFgwTNRJY7vN7//i1Zj/4t1zmajQOXKsTQIGOOh/SbX3iGCrmJXS7D8fj5kF9V+eUvrRKmwkxcizPzjFK2ZqlcJXVmZmrOWqWsBgH
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(36840700001)(46966006)(4326008)(31696002)(316002)(9786002)(36906005)(70206006)(5660300002)(426003)(70586007)(2906002)(54906003)(36756003)(110136005)(8676002)(2616005)(8936002)(36860700001)(47076005)(44832011)(6666004)(82310400003)(186003)(53546011)(26005)(508600001)(7636003)(356005)(6636002)(336012)(83380400001)(31686004)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2021 12:28:11.9619
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 37ca04c6-0e91-4606-6acf-08d99d331206
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT032.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR02MB2364
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org



On 10/26/21 12:27, Anssi Hannula wrote:
> xilinx_uartps .start_tx() clears TXEMPTY when enabling TXEMPTY to avoid
> any previous TXEVENT event asserting the UART interrupt. This clear
> operation is done immediately after filling the TX FIFO.
> 
> However, if the bytes inserted by cdns_uart_handle_tx() are consumed by
> the UART before the TXEMPTY is cleared, the clear operation eats the new
> TXEMPTY event as well, causing cdns_uart_isr() to never receive the
> TXEMPTY event. If there are bytes still queued in circbuf, TX will get
> stuck as they will never get transferred to FIFO (unless new bytes are
> queued to circbuf in which case .start_tx() is called again).
> 
> While the racy missed TXEMPTY occurs fairly often with short data
> sequences (e.g. write 1 byte), in those cases circbuf is usually empty
> so no action on TXEMPTY would have been needed anyway. On the other
> hand, longer data sequences make the race much more unlikely as UART
> takes longer to consume the TX FIFO. Therefore it is rare for this race
> to cause visible issues in general.
> 
> Fix the race by clearing the TXEMPTY bit in ISR *before* filling the
> FIFO.
> 
> The TXEMPTY bit in ISR will only get asserted at the exact moment the
> TX FIFO *becomes* empty, so clearing the bit before filling FIFO does
> not cause an extra immediate assertion even if the FIFO is initially
> empty.
> 
> This is hard to reproduce directly on a normal system, but inserting
> e.g. udelay(200) after cdns_uart_handle_tx(port), setting 4000000 baud,
> and then running "dd if=/dev/zero bs=128 of=/dev/ttyPS0 count=50"
> reliably reproduces the issue on my ZynqMP test system unless this fix
> is applied.
> 
> Fixes: 85baf542d54e ("tty: xuartps: support 64 byte FIFO size")
> Signed-off-by: Anssi Hannula <anssi.hannula@bitwise.fi>
> ---
>   drivers/tty/serial/xilinx_uartps.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
> index 962e522ccc45..d5e243908d9f 100644
> --- a/drivers/tty/serial/xilinx_uartps.c
> +++ b/drivers/tty/serial/xilinx_uartps.c
> @@ -601,9 +601,10 @@ static void cdns_uart_start_tx(struct uart_port *port)
>   	if (uart_circ_empty(&port->state->xmit))
>   		return;
>   
> +	writel(CDNS_UART_IXR_TXEMPTY, port->membase + CDNS_UART_ISR);
> +
>   	cdns_uart_handle_tx(port);
>   
> -	writel(CDNS_UART_IXR_TXEMPTY, port->membase + CDNS_UART_ISR);
>   	/* Enable the TX Empty interrupt */
>   	writel(CDNS_UART_IXR_TXEMPTY, port->membase + CDNS_UART_IER);
>   }
> 

Shubhrajyoti: Can you please take a look at this one?

Thanks,
Michal

