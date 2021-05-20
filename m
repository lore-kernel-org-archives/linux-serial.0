Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88272C43462
	for <linux-serial@archiver.kernel.org>; Thu, 20 May 2021 12:21:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FD84611C2
	for <linux-serial@archiver.kernel.org>; Thu, 20 May 2021 12:21:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232326AbhETMXJ (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 20 May 2021 08:23:09 -0400
Received: from mail-bn7nam10on2068.outbound.protection.outlook.com ([40.107.92.68]:58367
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231642AbhETMXG (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 20 May 2021 08:23:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NxCN0CCL6zxY9O6Ql3FEikNEThTeIhILk/YK0fbwTI76jVRLBMmvVUNaqVcYCBYOuZwUPKA+ivu30VcrAu0WrNAugMeT6MonML4K7hw88wuJE4jYHd7eQVVfC+lH+Ng6RN4rz0xLCdJH4AOnXl50ejpMK9obv9YPusokuzMlinIkE7U36E50+mSPl5v3u1861daGxqg9w9nhrbxgva8rNQE5Km0Da54NIop5YKwlz6F7ejrF4ega8k0Do2Bxoi6eGhZK5bo/YV4GfeYTA+lxZPSj6A33GDaD6V1HCHun/0Jwkqw+NcXTkunE7M80uaL3LQPFSLXZnGwy1jqVBQ8uQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IyZRyoYtoXC/9vC+LWUbs1JG8VYj002HZHBYh+iPUos=;
 b=mllAw4e3zeuBxTBihE/ThtjCRC2OS6z43PrS+TpNngLIkonAH61IEtv6oNoxZyuPAC66KoIPmPcSngMSv4CbW1CsTLr3VKSUCi/w2kN45d9YFshccfF1WifLMBErrcjCmhaEVty0OjGNI8wEirr0jCs+JrLgucmCqHRFB13o6mPFF6wdjGC5xbxxc3hJ0uCQYdCHJbpZ52J4aOTpwyopMI1P/bjFHK/U5ISCTtd/+EW6kxLBhEgNYWa8YCD+jdoQnbxBbxyP3Zjav+vR555Cc0xx+Qc1Ypyrt4JfIVdDHJ8AzoGfy/P0EAOzNLvNQHUTGYK8csdI74w/XwG8MuNGFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=xilinx.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=xilinx.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IyZRyoYtoXC/9vC+LWUbs1JG8VYj002HZHBYh+iPUos=;
 b=jmArAqpFbhbkmKJwtYFLB+/N6lpo3euVEamR9+aN2eyF4bU60iOUY4mrQgddIpwgxy6Wuz0+sPSPVNw1eEEBLQJc7p1L0QNXM9JYCsfH7ZTCuaiv5Sxcmeh0/o8c5y34aBHYIYkLvf3ydfBGcehHCmFXNzQC4MFn0nDrsnU2qjs=
Received: from SN7PR04CA0064.namprd04.prod.outlook.com (2603:10b6:806:121::9)
 by BN6PR02MB2451.namprd02.prod.outlook.com (2603:10b6:404:54::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Thu, 20 May
 2021 12:21:44 +0000
Received: from SN1NAM02FT0007.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:121:cafe::2b) by SN7PR04CA0064.outlook.office365.com
 (2603:10b6:806:121::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.23 via Frontend
 Transport; Thu, 20 May 2021 12:21:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=pass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0007.mail.protection.outlook.com (10.97.5.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4129.27 via Frontend Transport; Thu, 20 May 2021 12:21:44 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 20 May 2021 05:21:42 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Thu, 20 May 2021 05:21:42 -0700
Envelope-to: linux-arm-kernel@lists.infradead.org,
 linux-serial@vger.kernel.org,
 jirislaby@kernel.org,
 gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org,
 lee.jones@linaro.org
Received: from [172.30.17.109] (port=53970)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1ljhgM-00072r-KD; Thu, 20 May 2021 05:21:42 -0700
Subject: Re: [PATCH 11/11] tty: serial: xilinx_uartps: Fix documentation for
 cdns_uart_clk_notifier_cb()
To:     Lee Jones <lee.jones@linaro.org>
CC:     <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        <linux-serial@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20210520121906.3468725-1-lee.jones@linaro.org>
 <20210520121906.3468725-12-lee.jones@linaro.org>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <b25d7c14-8d38-2c45-1bc9-1c64da167031@xilinx.com>
Date:   Thu, 20 May 2021 14:21:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210520121906.3468725-12-lee.jones@linaro.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a9eca8a9-1773-47ab-8f1a-08d91b89d4a5
X-MS-TrafficTypeDiagnostic: BN6PR02MB2451:
X-Microsoft-Antispam-PRVS: <BN6PR02MB24511D088A09F96955F069C0C62A9@BN6PR02MB2451.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9e/+zmFvKNtUAQ4yxOoyjxkiIfRZjV0c4cS1PTtstySGC7EzYJqCfSARCPbA9g9lezWRxXHIlcc9UZn7hPqraOlj1bQfE/CBrIgxo7esWDP4VgPimHxiXH/fVfjmnXxw2K8wR0y+RJAxniPjt5SaiaOVLMVJA+K5baUCsWKha8n6ay57hoaRESy62r+04jLUaqtnryuGBue9cZ9YgpcYJAd+Mr2wbS/67I3K2g56u05tzUD9NKPlLkmdacsUAIWMQW4ZmaYrQpyzhUeI8P3VbnmFSFRLO32jrc+ADjl7MkKKbwlrtEsa9gDiVtS/eCC8AL81Gq+U5ToZBLwQvVQt8ASVpRg351V6zFHG9aGsce4ETxiVH56uKVa6MP1q/Pw07ATs0sd5DMJrYWBrrRmw+fTgBj5d1/yTQu8NX5batRJ86ODpwsbnnLBCiGeRvHmJQE6u6BxeHEiijaf8vndN+8LAqfq1YduQt911d66cuuzZ34dMbzWVhdyxsSc3gtGvtoafDXfB3ECan7BK1sXleSJNtlNapKZ1+WtH2jJcrR/5PjnMFbIG7CXKEjE5nQia8e8+hYr7RU4UEGsPKWj3VbSnpZtxBKfZ1oLCrsxhc47i81M876GPntSExiqbpu9vpE0F4d+2rtA9wfm2ArSB1ZyKPkJhGJ7MMZuJjz16ALyd4ogiUa9MmkpLfz4eyvO2nUOYuoXR30e1NF2LKLdLDA==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(396003)(346002)(376002)(136003)(39850400004)(46966006)(36840700001)(47076005)(186003)(36906005)(70586007)(8676002)(83380400001)(36860700001)(2616005)(426003)(31696002)(478600001)(31686004)(44832011)(8936002)(82310400003)(82740400003)(316002)(7636003)(5660300002)(4326008)(36756003)(9786002)(2906002)(54906003)(70206006)(356005)(26005)(53546011)(6916009)(336012)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2021 12:21:44.0925
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a9eca8a9-1773-47ab-8f1a-08d91b89d4a5
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0007.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR02MB2451
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org



On 5/20/21 2:19 PM, Lee Jones wrote:
> Fixes the following W=1 kernel build warning(s):
> 
>  drivers/tty/serial/xilinx_uartps.c:496: warning: expecting prototype for cdns_uart_clk_notitifer_cb(). Prototype was for cdns_uart_clk_notifier_cb() instead
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jiri Slaby <jirislaby@kernel.org>
> Cc: Michal Simek <michal.simek@xilinx.com>
> Cc: linux-serial@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/tty/serial/xilinx_uartps.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
> index 67a2db621e2b7..2cdcfb8f034de 100644
> --- a/drivers/tty/serial/xilinx_uartps.c
> +++ b/drivers/tty/serial/xilinx_uartps.c
> @@ -484,7 +484,7 @@ static unsigned int cdns_uart_set_baud_rate(struct uart_port *port,
>  
>  #ifdef CONFIG_COMMON_CLK
>  /**
> - * cdns_uart_clk_notitifer_cb - Clock notifier callback
> + * cdns_uart_clk_notifier_cb - Clock notifier callback
>   * @nb:		Notifier block
>   * @event:	Notify event
>   * @data:	Notifier data
> 

Reviewed-by: Michal Simek <michal.simek@xilinx.com>

Thanks,
Michal
