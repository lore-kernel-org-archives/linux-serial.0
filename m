Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E70AC433F5
	for <linux-serial@archiver.kernel.org>; Tue, 23 Nov 2021 12:19:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236011AbhKWMWX (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 23 Nov 2021 07:22:23 -0500
Received: from mail-co1nam11on2076.outbound.protection.outlook.com ([40.107.220.76]:22831
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233576AbhKWMWX (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 23 Nov 2021 07:22:23 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fn1mt1/qiXk8WtuZ1d5WVmh1y4HByo4dNiJUMn0xIfTF1YoPMSrpksq9mWq7aUKBPrGRmw1OCGPlqNZm0GSjpbleC/iAd15tqnyvZ9CNFEw2poLsA99MD0Bv5mfZXc4WFaXXwWioFobFNq1QVUBNuM2yCo/HVqSTjqKucCVD+srxEU4L1v6ywsFhbVvSXOpaRH7r28UcZREBwubMKMZkaN7m55/LB3GrevCHioz/T9uDsais/kHHmdCseodEbRi+X526UW8F6fNRHRfE+bEnp9rTfpJIf/pYcdZ5HwOWvOktrjQQbCgRJs6AUIs7WXf/317DyN7C/8b1RE3wIIQT4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CY7zyQQ/90o5MTWwRFYF19sR4CO6ivRq2UKiK306uMY=;
 b=eqYpQzVBxOUOILZiPdmfOAtXKqWwX/tpEMi8f7XhuSp1m/JKXa1q/uiHFM3lcXO7naSsLN6eM59/mHWQPzx9qsWdo648mcoGDIXaydv6Rj8kb4E4lY1ukPFRxg1vX5ZUyFk6JJ6SXidC3EnqZRx6UB0G5o5zO/U8lIwDyou7ewUgLx/CA+Yr0ke+7JxmmLVL6IMdign5Q/7iC1iVmY9RQACqrhcaZlUWhCB6JDbB0zFditRmP9sv3mRT77ZdFWOMyBYJUaUmtfEGPjaFVJ43PuRIcungiqILEJeaWUhKFPjiPGdff0G2oCvUiaV/vC2aPg/gbvuZddEZ8UWn/TEVSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=hs-mannheim.de smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CY7zyQQ/90o5MTWwRFYF19sR4CO6ivRq2UKiK306uMY=;
 b=DnX0K57NC78pLIDW/5nZ34CFsGPQCVP0MEQzalHw0YQCzZhcbnrMhRZGXl1XjQJrrzZVm4u9gt4y+CAB/7aEdHBQ4ljOnHbmkUw7/qoMWARAygg98WUU0dvaauNpz3xcfstsT/977TgFUJtotMV5Krv5NZ72FefJj8uEmILQwKQ=
Received: from BN9PR03CA0315.namprd03.prod.outlook.com (2603:10b6:408:112::20)
 by BY5PR02MB6801.namprd02.prod.outlook.com (2603:10b6:a03:20b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Tue, 23 Nov
 2021 12:19:12 +0000
Received: from BN1NAM02FT038.eop-nam02.prod.protection.outlook.com
 (2603:10b6:408:112:cafe::94) by BN9PR03CA0315.outlook.office365.com
 (2603:10b6:408:112::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.21 via Frontend
 Transport; Tue, 23 Nov 2021 12:19:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT038.mail.protection.outlook.com (10.13.2.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4713.19 via Frontend Transport; Tue, 23 Nov 2021 12:19:10 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 23 Nov 2021 04:19:10 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Tue, 23 Nov 2021 04:19:10 -0800
Envelope-to: git@xilinx.com,
 r.willenberg@hs-mannheim.de,
 linux-serial@vger.kernel.org,
 gregkh@linuxfoundation.org
Received: from [10.254.241.49] (port=35270)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1mpUlR-000CeY-IU; Tue, 23 Nov 2021 04:19:09 -0800
Message-ID: <7d46faa1-9a89-907e-bbb4-a03b91be86d0@xilinx.com>
Date:   Tue, 23 Nov 2021 13:19:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v2] serial: uartlite: Move out-of-range port-numbers into
 ULITE_NR_UARTS range
Content-Language: en-US
To:     Ruediger Willenberg <r.willenberg@hs-mannheim.de>,
        Michal Simek <michal.simek@xilinx.com>,
        <linux-serial@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>, <git@xilinx.com>,
        <shubhrajyoti.datta@xilinx.com>
References: <20211118211745.133778-1-r.willenberg@hs-mannheim.de>
 <be268f13-7299-b701-55a9-0942d4aeb1e2@xilinx.com>
 <fd919b8b-4348-df1f-05cb-93405f947dba@hs-mannheim.de>
From:   Michal Simek <michal.simek@xilinx.com>
In-Reply-To: <fd919b8b-4348-df1f-05cb-93405f947dba@hs-mannheim.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c86f3b50-4ae6-4f8e-f72b-08d9ae7b7480
X-MS-TrafficTypeDiagnostic: BY5PR02MB6801:
X-Microsoft-Antispam-PRVS: <BY5PR02MB68014E0D51FAFD06D29102BFC6609@BY5PR02MB6801.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SuX5qlvE6Qb6YWM3rUuT642dXruiZzxAu48GuWh6dtvcXv0a933Lm0cHQiYavyVyKmvmM9xypQxuBbwsgkel6QEoeL/ma6WtrhqlFst5CVHKWHfjxGPTWcRjzZayLQT+/+AXSZUMWS8+PeasGJYEdQRzgPH2bUonIEgDkfd85kbhom2Frq8kCJNuVFya48j0WJdUH4SRd2hSQ3PKa5GOQwiLF2eCui5ija4kCyfiZ9w2lrQOFS7GSnhQ7Coq1bq+WhAFLcjpVzgMam4BvS0Ds9EPemkK4afw39j6TvgEHhZ44HE9wzcnWeqLUvjBBhFNQTroDHXuUeBWUKrRCYsF+foQRE8H6PXC/8Jo88k2M8pqcPr/JSdm/BGR+ijOYZ2EOdFxMTkdL9l5N9qt0iYIVN0TG7cF5U7VLXv04DeOBPJFSbiMcVlj3SDwYj9V6L2ksIxtbASuLQmeMwiS8VTqIFpS1pPDCLyngO/gGhYzKnBMRcR4gbj2L2quT2gvmq/7Ft0VO4395GJ99zAuOeJOaWSN4FClHbTq/rqtrwE3e3Gz+HBN2fJ1MGGBs7HJdJj6iuRXHkgYdQH9ANdj0cv4Ux7Ggc+Lhv86meLFpSTr7/5uQJS94m/yABMkdprkmAKt+ovEPDTA0Ghydt6hRKBSzrLnBM2r/NWmEYUR2sC7Km/x07vAd88v+e2GOY+GTfZpKebob/PgOTddNg0GzvGoJfP5Xw7KHtop2iHGEwrjuvjALneqZRWvhZuxkIQUIkjhSZ357zAkWI0irNLnMPLRyg==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(36840700001)(46966006)(2906002)(54906003)(9786002)(36906005)(8936002)(44832011)(31696002)(31686004)(356005)(508600001)(110136005)(426003)(36756003)(83380400001)(2616005)(316002)(70206006)(4326008)(186003)(5660300002)(336012)(107886003)(8676002)(47076005)(26005)(7636003)(53546011)(70586007)(36860700001)(82310400004)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2021 12:19:10.6965
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c86f3b50-4ae6-4f8e-f72b-08d9ae7b7480
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT038.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6801
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org



On 11/22/21 23:08, Ruediger Willenberg wrote:
> Am 19.11.2021 um 13:21 schrieb Michal Simek:
>> On 11/18/21 22:17, Ruediger Willenberg wrote:
>>> Find free uart_port struct in range 0 <= id < ULITE_NR_UARTS when
>>> the device tree port-number property is outside that range. This
>>> happens when there are other UART types in the system because the
>>> Xilinx device tree generator numbers all UARTs consecutively;
>>> as a result, not as many Uartlites as specified by the
>>> SERIAL_UARTLITE_NR_UARTS parameter could be successfully added.
>>>
>>> Signed-off-by: Ruediger Willenberg <r.willenberg@hs-mannheim.de>
>>> ---
>>> Changes in v2:
>>>   - give KERN_NOTICE when changing the id,
>>>     with reference to the requested port-number
>>>
>>> -    if (id < 0 || id >= ULITE_NR_UARTS) {
>>> -        dev_err(dev, "%s%i too large\n", ULITE_NAME, id);
>>> +    if (id == ULITE_NR_UARTS) {
>>> +        dev_err(dev, "maximum number of %s assigned\n", ULITE_NAME);
>>>           return -EINVAL;
>>>       }
>>> @@ -676,7 +678,11 @@ static int ulite_assign(struct device *dev, int 
>>> id, u32 base, int irq,
>>>           dev_set_drvdata(dev, NULL);
>>>           return rc;
>>>       }
>>
>> nit: please keep this newline here.
>>
>>> -
>>> +    if (oor_id >= 0)
>>> +        dev_notice(dev,
>>> +            "assigned uartlite with device tree port-number=<%i> to 
>>> %s%i\n",
>>> +            oor_id, ULITE_NAME, id);
>>> +
>>
>>
>>
>> [linux](master)$ ./scripts/checkpatch.pl --strict 
>> 0001-serial-uartlite-Move-out-of-range-port-numbers-into-.patch
>> CHECK: Alignment should match open parenthesis
> 
> Thanks, I apparently didn't do "--strict" checking, sorry. Will fix both 
> in PATCH v3
> 
> 
>> And there is one more issue with this. If you start to mix serial IPs 
>> which are partially recorded in aliases. For example like this.
>>
>> aliases {
>>      serial0 = &uart1;
>> };
>>
>> uart0 {
>> ...
>> };
>> Uart0 is probed first. It is without alias and id 0 will be assigned 
>> to it. Then uart1 is probed. It looks at aliases you get id 0 but it 
>> is already taken and you end up with "cannot assign to %s%i; it is 
>> already in use"
> 
> As I point out in the other thread
>   "[PATCH v2] uartlite: Update the default for the 
> SERIAL_UARTLITE_NR_UARTS"
> (I don't feel crossposting all of it here would be good practice)
> 
> a) the Xilinx DTG gives "serial" aliases to _all_ Xilinx UARTs
> b) the Xilinx DTG gives "port-number" properties to _all_ Xilinx UARTs
> c) these two are not assigned in the same order by the Xilinx DTG, which 
> is problematic

DTG/MSS logic should be solved in different mailing list that's why 
please move it there.

> 
> uartlite.c currently looks at port-number properties, not aliases. So 
> unassigned aliases are not the issue. A similar-looking but more 
> complicated issue that COULD happen, to be transparent, is this:

port-number is optional and as I said in the second thread I think that 
this should be deprecated and removed. Most of DT drivers take care 
about serial alias that's why we should go that route too.

And I also remember that drivers shouldn't really use different names as 
ttyUL, ttyPS, ttyAMA, etc but all of them should use the same name as 
ttyUSB is doing.

Thanks,
Michal
