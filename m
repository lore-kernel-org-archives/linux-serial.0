Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17C63C433F5
	for <linux-serial@archiver.kernel.org>; Tue, 23 Nov 2021 12:11:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236886AbhKWMOr (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 23 Nov 2021 07:14:47 -0500
Received: from mail-bn1nam07on2045.outbound.protection.outlook.com ([40.107.212.45]:34818
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236874AbhKWMOq (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 23 Nov 2021 07:14:46 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q4QTuDW3Ydg8wC5sXqolmTmHeYVjUrBFJn3s8TVtJz1p2kjn/TCFnpUYph47tzDnok1JkMwSyKvlKopKGgVCgjCdoATfpNtphexTzVThpP+SyAPx6ANtbTTYkx0qERvSCPSxry+kuFx5u3MM3HU82wLkyezdozihsxESHOtwKqScrJB24OJI2Gla0TYpaiUQNOgGSeukBQTHsqLChKY6zwHdvCY7rWC7p4/KytAFOTjfqBUfSUPDk7U/hlXX9vqW6LWg0V68plaunMg9TQjLf3sL9wvtmF+LEQGc5MTPQ2oo7lOZ6w1KNh3cEj9Nnum//fCmDcNUbFfafYJ81UZRIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=umZYX3xpDOUKZFFq5CwyHOXK0rgxz1KEtFlpPP2vy88=;
 b=PPk+5AEARfHSZ6KX5yUu3zpt47Qq9T5bBUprmYTgRncxYqNvuU0bMLs0Wn1DClkfouIjVQzRDRmR0Wp3+suiUsab6I/SCyDZ67OGKij4OVejw0BxD2etVoDOQUFvpbxcvgNfonGnQxw2CCjRoJ3EfIlhEsEeM5YdWQhdbg/gdELBTVlNcib/XZDL+WvGE0pn92A3CHpWXq5CB46GsfkbQTkmm/RFb+dZSt9oMRy6EVTl5nJ9+ao5On7JxGO1n7XRjXXWi2J+rE/erq0vvgQhPFFD9DSMI+/qqHogtv0a2wzbSHA+fTNZwqcic4V+tJzTv6DGNN7gkMLFVZfYTncasw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=hs-mannheim.de smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=umZYX3xpDOUKZFFq5CwyHOXK0rgxz1KEtFlpPP2vy88=;
 b=OJI0AXF8xh5jcWj5byFDC4lqbZCVi0vtwZ2qOZCR8gxCgGJNlLHSoAEk/CsMAQjNm/H7dbiIxUFx9e1UvtmT8VNJsxoXmZoY7hDI67d4bMYie3/ucLiy6Pg3u4v0XhoVzsMc8XTP+6g+k08nT3oWxKHoFt3wFqv8jJ7vJz967vM=
Received: from DM5PR11CA0002.namprd11.prod.outlook.com (2603:10b6:3:115::12)
 by SJ0PR02MB8830.namprd02.prod.outlook.com (2603:10b6:a03:3db::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22; Tue, 23 Nov
 2021 12:11:36 +0000
Received: from DM3NAM02FT032.eop-nam02.prod.protection.outlook.com
 (2603:10b6:3:115:cafe::54) by DM5PR11CA0002.outlook.office365.com
 (2603:10b6:3:115::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.20 via Frontend
 Transport; Tue, 23 Nov 2021 12:11:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT032.mail.protection.outlook.com (10.13.5.65) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4713.19 via Frontend Transport; Tue, 23 Nov 2021 12:11:34 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 23 Nov 2021 04:11:33 -0800
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Tue, 23 Nov 2021 04:11:33 -0800
Envelope-to: git@xilinx.com,
 r.willenberg@hs-mannheim.de,
 linux-serial@vger.kernel.org,
 gregkh@linuxfoundation.org
Received: from [10.254.241.49] (port=34652)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1mpUe5-00037X-5G; Tue, 23 Nov 2021 04:11:33 -0800
Message-ID: <efd26139-da33-7254-e2d6-7c41e2f52e31@xilinx.com>
Date:   Tue, 23 Nov 2021 13:11:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v3] serial: uartlite: Move out-of-range port-numbers into
 ULITE_NR_UARTS range
Content-Language: en-US
To:     Ruediger Willenberg <r.willenberg@hs-mannheim.de>,
        <linux-serial@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>, <git@xilinx.com>,
        <shubhrajyoti.datta@xilinx.com>, <michal.simek@xilinx.com>
References: <20211122231446.85138-1-r.willenberg@hs-mannheim.de>
From:   Michal Simek <michal.simek@xilinx.com>
In-Reply-To: <20211122231446.85138-1-r.willenberg@hs-mannheim.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d4e087ed-7aab-4900-e1f8-08d9ae7a64d2
X-MS-TrafficTypeDiagnostic: SJ0PR02MB8830:
X-Microsoft-Antispam-PRVS: <SJ0PR02MB88300C7BE6A612A9171FEB52C6609@SJ0PR02MB8830.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qwvvUjarriWF34P4soIlDv9MbNHh1XS+w1wQ2eBdQLVY3tN6SliMS7GvabgHC6VC+GIuBKyxVkwq+spUiQgzK2gsOUcctf3FjprGneQ5HBRYj18Zz4e1/uBvwC5uffinlP4VaOOCQVN7Zz03hu2AzHr3ESoKX8l7w2s6uaMxlhVuT0BO/rpFynJeu6pIfnc1H2IVUwftNycfmhwX8LK8G8S5ja9UtXiXRivGCu/5YdCmmFEOuvStBtXvvwGQxDZpQUvSgJYezBY3dsmkml7pNdgKZuW0MaHByeYDoHv1e8OQKoGmpCHD3lAPPnmmXq6e9PoK2j7jvhIEhmKBogp9AGEo7Q2smeUiNzewmr5R89dm1hbaVP3s0cZzRAE3MKDDYnklUVs0PlQwEl1SrvYFpB03XU2GlzalerfGQ28hWcD2A20mYBJ+rG6OzWCF9pgVuQ9rXOmb2VCu3pwb8z00+TB65Y1BrLMQm/CSw+eeyDZt5miAMIQFMEQGTSDcbvA/W7whfIWScWqgevZQX/oPsRl6pHlX2YIhJ7Nh8RyZq0mR491MSqG582YD9F65aojZ1d3aUqex2CfKsD9YDkhR3UtOlZWG4sbURlfkKWMP1cwCovaTYckM/ksGphxqBqwg7EIZHWms4sFLGp8qQ5OH4zWD2v6SCyyDNJcovit9/5m0EbwNmueY58dWtjNHv08Q8fUR2B0Z3NJytEimMQ27tQ7g3elX1WgmTx9Bb0GPxyh4sYeABWsCCKRsWNkInK21luCAc0/oAgXdrGFBcUgN+Ssh7hUG7hDIkRIrVpXngdHJJdK0gDOT+pTKs3Q9hvnfTZIi+/CNAfoFNbTX0Na2Oml2+N1Ll13k0w+GW3J6ZNE=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(36840700001)(46966006)(83380400001)(966005)(8936002)(70586007)(2616005)(508600001)(426003)(356005)(31686004)(36756003)(2906002)(44832011)(336012)(4326008)(5660300002)(9786002)(53546011)(31696002)(7636003)(107886003)(36860700001)(8676002)(110136005)(26005)(70206006)(316002)(82310400004)(36906005)(186003)(54906003)(47076005)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2021 12:11:34.9521
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d4e087ed-7aab-4900-e1f8-08d9ae7a64d2
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT032.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB8830
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org



On 11/23/21 00:14, Ruediger Willenberg wrote:
> Find free uart_port struct in range 0 <= id < ULITE_NR_UARTS when
> the device tree port-number property is outside that range. This
> happens when there are other UART types in the system because the
> Xilinx device tree generator numbers all UARTs consecutively;
> as a result, not as many Uartlites as specified by the
> SERIAL_UARTLITE_NR_UARTS parameter could be successfully added.
> 
> Signed-off-by: Ruediger Willenberg <r.willenberg@hs-mannheim.de>
> ---
> Changes in v3:
>   - corrected indentation to strict formatting
> 
> Changes in v2:
>   - give KERN_NOTICE when changing the id,
>     with reference to the requested port-number
> 
>   drivers/tty/serial/uartlite.c | 15 +++++++++++----
>   1 file changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/tty/serial/uartlite.c b/drivers/tty/serial/uartlite.c
> index d3d9566e5dbd..51e3f8086d31 100644
> --- a/drivers/tty/serial/uartlite.c
> +++ b/drivers/tty/serial/uartlite.c
> @@ -631,15 +631,17 @@ static int ulite_assign(struct device *dev, int id, u32 base, int irq,
>   {
>   	struct uart_port *port;
>   	int rc;
> +	int oor_id = -1;
>   
> -	/* if id = -1; then scan for a free id and use that */
> -	if (id < 0) {
> +	/* if id -1 or out of range; then scan for a free id and use that */
> +	if (id < 0 || id >= ULITE_NR_UARTS) {
> +		oor_id = id;
>   		for (id = 0; id < ULITE_NR_UARTS; id++)
>   			if (ulite_ports[id].mapbase == 0)
>   				break;
>   	}
> -	if (id < 0 || id >= ULITE_NR_UARTS) {
> -		dev_err(dev, "%s%i too large\n", ULITE_NAME, id);
> +	if (id == ULITE_NR_UARTS) {
> +		dev_err(dev, "maximum number of %s assigned\n", ULITE_NAME);
>   		return -EINVAL;
>   	}
>   
> @@ -677,6 +679,11 @@ static int ulite_assign(struct device *dev, int id, u32 base, int irq,
>   		return rc;
>   	}
>   
> +	if (oor_id >= 0)
> +		dev_notice(dev,
> +			   "assigned uartlite with device tree port-number=<%i> to %s%i\n",
> +			   oor_id, ULITE_NAME, id);
> +
>   	return 0;
>   }
>   
> 

I will wait for Greg to comment it first.
https://lore.kernel.org/all/337b2e18-ddc9-5540-1c5b-b47f0517c240@xilinx.com/

As I said before this patch can cause issues when you will have mix of 
serial IPs with and without serial alias that IP without serial alias 
can take ID to IP which has it. (All ports without optional port-number 
property).

Thanks,
Michal
