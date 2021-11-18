Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CA10C433FE
	for <linux-serial@archiver.kernel.org>; Thu, 18 Nov 2021 08:46:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31BE661B93
	for <linux-serial@archiver.kernel.org>; Thu, 18 Nov 2021 08:46:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244744AbhKRItH (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 18 Nov 2021 03:49:07 -0500
Received: from mail-mw2nam10on2043.outbound.protection.outlook.com ([40.107.94.43]:57312
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S244753AbhKRIsz (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 18 Nov 2021 03:48:55 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=at01y/8HDCPzQSClz2ePIyK3O+fT6l4ZN1GkPhur5pnpQ8DJ/HHAdL03xX7MINphFNVTwPxWk/Tld7Y1NaQiSRwSTN0JAJrIxfipJOqZcFFrgFYKOi4y8DJ+XfGzBKb+rssXORvNnY+mTUPuHdkghSR3MYHUiBgljWcujtR/tiHVkbuNQykzMT0lbDm2jGI0k6vnLoHezA3En7sBVSMEqGuvEriCcWC4jVsx2MetuFXAm4OJilK4CPgijpCNRvHrvBEW18VJ0zYbcDhPCQoBru+uk5reNXmU74PFibqw+M6yhgeCIqOROnAj3XzXB+LZwP8Lv4FjoV8KrtbueKqnOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XYxNEOaHjyX5mYhUfFSF+qzeuEQ/QW21NFr5vLIFi8c=;
 b=lubU+vTA98PtBDsNn/8qs9Du5njgAF+6gd5JftW8OZgWefONnMBtfbWqaB/KLFkz8e+r4gVjW6WjkrrcTKRYbrMI+RQuHLl0udhIa9xdyWDuX+xZVjEmUaGH2Vw/aJWjSOKoNEsVvOFaDZjPV9iQ/O7OzAz5FBy1InzEqiIih5MF6XfuEWnjZMiE+oMGzYGF4u7ZgQxTq5X8DWr7ARaV0qlW9DTdL/H90XgNf30h21lM3PTP3erX26C07jKs/ABQu+8oWa+mR5tfjOwZoblWGTQTCt9oXEmKWaNGAqnpRAnestMdjopOxjma2jsZ4+2OeLu8dDj8GKTD3U6KuvUE7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=hs-mannheim.de smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XYxNEOaHjyX5mYhUfFSF+qzeuEQ/QW21NFr5vLIFi8c=;
 b=Ki/Mp5gb1UifPkUXd6WzHdUj0W7+iKANmZqZfvB1sef3lipecHGhg7nTBGpJLKo/6zScCoyv74D4MJdH+56OhJx6y900QLAb/XLcAXONEwc2PJ9kgUYBIm+6+h8EJqCQE9hie7pKGgWmbnh4FGiXBTYeG4/IjrJXvdmW+0FZ46w=
Received: from SN7P220CA0028.NAMP220.PROD.OUTLOOK.COM (2603:10b6:806:123::33)
 by CH0PR02MB8194.namprd02.prod.outlook.com (2603:10b6:610:ff::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.21; Thu, 18 Nov
 2021 08:45:54 +0000
Received: from SN1NAM02FT0013.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:123:cafe::cc) by SN7P220CA0028.outlook.office365.com
 (2603:10b6:806:123::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19 via Frontend
 Transport; Thu, 18 Nov 2021 08:45:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0013.mail.protection.outlook.com (10.97.4.188) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4713.19 via Frontend Transport; Thu, 18 Nov 2021 08:45:52 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Thu, 18 Nov 2021 00:45:51 -0800
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Thu, 18 Nov 2021 00:45:51 -0800
Envelope-to: git@xilinx.com,
 r.willenberg@hs-mannheim.de,
 linux-serial@vger.kernel.org,
 kernel.development@povil.us,
 gregkh@linuxfoundation.org
Received: from [10.254.241.49] (port=56162)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1mnd3G-000FSj-TV; Thu, 18 Nov 2021 00:45:51 -0800
Message-ID: <82ee1522-da4b-9fc6-bcf5-ceb94e307f96@xilinx.com>
Date:   Thu, 18 Nov 2021 09:45:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v2] uartlite: Update the default for the
 SERIAL_UARTLITE_NR_UARTS
Content-Language: en-US
To:     Ruediger Willenberg <r.willenberg@hs-mannheim.de>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        <linux-serial@vger.kernel.org>
CC:     <kernel.development@povil.us>, <git@xilinx.com>,
        <gregkh@linuxfoundation.org>,
        Michal Simek <michal.simek@xilinx.com>
References: <20211117051635.1316958-1-shubhrajyoti.datta@xilinx.com>
 <edf15265-548a-1315-9175-967dddb38d4b@hs-mannheim.de>
From:   Michal Simek <michal.simek@xilinx.com>
In-Reply-To: <edf15265-548a-1315-9175-967dddb38d4b@hs-mannheim.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d82719c0-b1ed-469c-7fb2-08d9aa6fd44f
X-MS-TrafficTypeDiagnostic: CH0PR02MB8194:
X-Microsoft-Antispam-PRVS: <CH0PR02MB819496E829B7D0AD1E7D2926C69B9@CH0PR02MB8194.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SnFJexZCHu0+LvEPOWXD1Y44w3V6wSEL/jz56oFK8JIPUIM+gNP0+4ZErdmru9nQgzbhKXAaKLbqIw3Z/lxMDk6KHrq12RXe986TnE3BAzJQPMFXTfiq4vQdwRintpLGi+kKdbAF2x2QeoCsQypii0JIxc1IFuJqQ8hl0ruF0mftT/wHOuA26WNSnhRLOglyWL6zbFJWMpuuBvMrwU79e2bpGdaY+hnEo+QR4oCEwMfMZLxALgTYVyD+zc3ls4MSKnGsImeXr5Ccyi9x/dTE60JqXiuS+Ex9ghT5/KKedXGGBjRVOyO2ifoJukxexkXB+sW5VPZh4d+i2jvH+BcPPN6nGq79xG1RrdaR0klFCUWlS0GUXzjPxBt2xtfh/3cZYX/rLBBtMSV8jC0VQQy0uOhVJI6QiEtl8iY8K8OuPkHUorrlbS5lgUFXgEEzLLfVGe1aLX7ZRU/+k8tNvrdpsXH6Hl6RsCGxcHG1ePfsgropvva9FcGpd6n8I2pUhKTrH+apX0GsgNBlvdiBf9YGox6KbD27H94ImFf/b90Vfhg6chjQWulUpdo7PMZI/mdrczy1WEHxg2zmKw/B7R7TcOSATDFBalBpjeAkqB5aZlNymnJqtO9GtJnrYmMtyprGul+LAyHSJ3/IqG+77Pju0amqaoJpIQUm/wGiXoj5+QO2/40M9rxYyas2h1gKNsWcG2K1vgqtTPnyxeAw7PUHhNLeg02ZI5opXyabksjKUcDpfCWuqk37v7HvsYU6oWyw
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(46966006)(36840700001)(83380400001)(7636003)(356005)(2616005)(6666004)(426003)(70586007)(336012)(70206006)(5660300002)(47076005)(107886003)(44832011)(36756003)(4326008)(9786002)(186003)(8936002)(26005)(8676002)(31696002)(508600001)(316002)(36860700001)(82310400003)(2906002)(31686004)(36906005)(53546011)(110136005)(54906003)(15650500001)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2021 08:45:52.8907
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d82719c0-b1ed-469c-7fb2-08d9aa6fd44f
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0013.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR02MB8194
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org



On 11/17/21 10:53, Ruediger Willenberg wrote:
> Am 17.11.2021 um 06:16 schrieb Shubhrajyoti Datta:
>> "The uartlite is used by FPGAs that support a basically unlimited number
>> of uarts so limiting it at 16 dosn't make sense as users might need more
>> than that."
>> the commit also said that number should be unlimited. However it set the
>> default to 1 instead of 16.The original 16 written in driver should be
>>   quite reasonable default to cover most of the cases.
>>
>> So change the default number of uarts back to 16.
> 
> Respectfully, this is an inadequate fix to a decade-old underlying issue
> in the Xilinx device tree generator. The DTG assigns consecutive
> "port-number" properties to UARTs handled by separate drivers (uartps,
> uartlite, uartns), which are then used in drivers/tty/serial/uartlite.c
> to index the struct uart_port[] array and set uart_port->line.
> The DTG should number devices for each driver separately from 0;
> serial_core.c checks for (0 <= uart_port->line < NR_UART_PORTS). As a
> consequence, when a Zynq system has both a PS-UART and a Uartlite,
> setting SERIAL_UARTLITE_NR_UARTS explicitly to 1 in Kconfig means
> probing the uartlite fails, which is confusing to the unsuspecting
> KConfig user. Setting the default to 16 just kicks the can down the
> road because it will fail for more than 15 Uartlites (or less, if there
> are more PS-UARTs or AXI 16550A UARTs).
> I've submitted a patch for the DTG numbering scheme to git@xilinx.com
> just yesterday. Will post a PATCH to this list later today or tomorrow
> to handle the issue from the other end (uartlite.c).

I have no problem with your patch and it is correct (I would prefer a 
message to show for this option). But it doesn't mean that default 1 was 
correct value to setup especially when range was setup by Sam from 
1-256. And originally number 16 was used.

And using aliases for serial id identification is around for a while and 
Xilinx DTG is aligned with it because via current dt you can't describe 
cases where you will have stable numbers for different tty names like
ttyS0, ttyUL0, ttyPS0, ttyAMA0, etc.
That's why DTG generates it per all serial IDs.

That's why I think this patch is still valid. If you don't like 
description it can be changed because definitely people are using 
systems with more then one uartlite and 1 is not reasonable default.
We can also take a look at default for others serial drivers

8250  - 4
SH - 3,10,18,2 depends on platform
TXX9 - 6
AR933X - 2
RP2 - 32

and none of them is using 1 as default. IIRC discussion about UARTPS it 
was said if number is not enough we can just extend it.

Thanks,
Michal



