Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3117CC433F5
	for <linux-serial@archiver.kernel.org>; Fri, 19 Nov 2021 12:22:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12B6F61A89
	for <linux-serial@archiver.kernel.org>; Fri, 19 Nov 2021 12:22:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234888AbhKSMZC (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 19 Nov 2021 07:25:02 -0500
Received: from mail-mw2nam08on2067.outbound.protection.outlook.com ([40.107.101.67]:45217
        "EHLO NAM04-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234715AbhKSMZC (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 19 Nov 2021 07:25:02 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NEH96PvA4ZEnRpIhKKfNadRamj91s9ybenuWa2YNmloov3rw9Ud18pIj0Vr9E1z4TQGH/J9F3cA03z3FIrGrDpIawA0wRPK/LWhglg/MsClRuaHAG0f75wthk5S4xeaWHKAPV18py5lT07VkXB2xuXas6HNkscH61+6nQqdmdHP/Wlrczb+XOzPKicWy+7tdIkX573L9OCpOm/o8Kbi+mUI9QT+Ni8MYcEtrnhyo5U9m/Kwk6XquyKwYH8jHCxhoMIAx2Dk37J8E11HUTTNA8yYZT4cip5DTWGlu0exWwrKk8RsMN5T/KbqxYPEPH7SqUCDVLONL1buyDNjw6zSyvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OlJp9RRWkZB/CoYAVFHlcE6eg8NFGo3h25wo6PP2BAw=;
 b=Z9qVg/EdMulcER5EYaHCYjfS869Cilg1o0f3ZH875FsATHKh3FmI5hoGhglqML6F9gku2AekgyXcE7zeJ4sd0tIp+5RfxV/RXLJiZPiDUh9QxcjUede5Q7RlFWLB3elblTsn3qvTu8J+vYQ3X41vBorFBbBQKmukJlgas4oG3rYs0wECeCRt0eIzdKPH1XAfcv6SMuEWRT4dJvPu7ne3jpavuVv0bEksDYF601r6VvjESXBK5NzrWh3TtXSnu/HITbd7lswZjH937KlUQxTG87vsqPmHjGQ56z42bG/wpzaP4qcfIZBajAeyMBYk4RTYlfrlLCBdGjwnbjxGvhfzaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=hs-mannheim.de smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OlJp9RRWkZB/CoYAVFHlcE6eg8NFGo3h25wo6PP2BAw=;
 b=cA92RLWNRyCl+7XXkFdoojvz6XMQmvok28+f87dlw2NI/D9l06NrxdcPTil88utAC0TmNWPFn7WSuXyAXmyySH//zfVVu/LaQgYuWWMXWbIlKs8OMCKhjRRCrESEWoUdzeC1BZYQiyUbI9Qi0DATDswEC+ClegLJiE90d1eHkmc=
Received: from BN7PR02CA0004.namprd02.prod.outlook.com (2603:10b6:408:20::17)
 by BN8PR02MB6434.namprd02.prod.outlook.com (2603:10b6:408:bd::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22; Fri, 19 Nov
 2021 12:21:59 +0000
Received: from BN1NAM02FT026.eop-nam02.prod.protection.outlook.com
 (2603:10b6:408:20:cafe::14) by BN7PR02CA0004.outlook.office365.com
 (2603:10b6:408:20::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.26 via Frontend
 Transport; Fri, 19 Nov 2021 12:21:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT026.mail.protection.outlook.com (10.13.2.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4713.19 via Frontend Transport; Fri, 19 Nov 2021 12:21:57 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 19 Nov 2021 04:21:54 -0800
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Fri, 19 Nov 2021 04:21:54 -0800
Envelope-to: git@xilinx.com,
 r.willenberg@hs-mannheim.de,
 linux-serial@vger.kernel.org,
 gregkh@linuxfoundation.org
Received: from [10.254.241.49] (port=35950)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1mo2tt-0009yM-UV; Fri, 19 Nov 2021 04:21:54 -0800
Message-ID: <be268f13-7299-b701-55a9-0942d4aeb1e2@xilinx.com>
Date:   Fri, 19 Nov 2021 13:21:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v2] serial: uartlite: Move out-of-range port-numbers into
 ULITE_NR_UARTS range
Content-Language: en-US
To:     Ruediger Willenberg <r.willenberg@hs-mannheim.de>,
        <linux-serial@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>, <git@xilinx.com>,
        <shubhrajyoti.datta@xilinx.com>, <michal.simek@xilinx.com>
References: <20211118211745.133778-1-r.willenberg@hs-mannheim.de>
From:   Michal Simek <michal.simek@xilinx.com>
In-Reply-To: <20211118211745.133778-1-r.willenberg@hs-mannheim.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: be9280b8-3b54-4379-cd20-08d9ab572e74
X-MS-TrafficTypeDiagnostic: BN8PR02MB6434:
X-Microsoft-Antispam-PRVS: <BN8PR02MB64346668E40A43DF67568C2EC69C9@BN8PR02MB6434.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5gLhleUQLZLqj2CIVd0CElwgIVsvswF6A2oNY6BKfpx3V4HWZeXJBjCLOm/1fWf3sABOCNDZE+rTajwvVcrE/Q1YGkD/8maGBu2rtj/1QKHGxrd4s48UiglCrvsWSWYuyhsRwizuEN2xgYykudLNfVdhla8ifG8MRenG+mOmGXV3SJgBqPKvcaUf8nXKS236KCwhqTqNGL4Gz50OD+dcvuFL2mK9lZZBwIzlgG3Wkx4Mnve5uqsmncnb8OSGedLmjMEDvvelieI3w16rfkbl/CqxDPYxPIcueyA4SYzHyCQQyJvI1htLtULVJBrJUjyonE7f3xcmZxwCbD18LnsVIiUutZNPml6R2kXsocomlxiMfRClAyi+QOeYJv7bUoGlPuxEa3YL9e8k4CsLDJX0ZFhZk3aREQIDKs5hDJ5rF8VFXG8VaPxffc9aeijOY9dPYRihypWzYQ2kpkw7S2+pOTL0hyZA0EA3E2qdAStzjxqiPDrF5NutkXrEZMNzZBe7JImf/gY9ULG07M6hZYjK9J9BAeK27jmrHBv9rQRr1Q/7cSk0R64LH0wC7WG/a7Nu5WR0T0erSA7BrBZ293yq8raWlc6W2M8uB7SLk2jR5D8FW8uJl0XMJiOA5LHWN3c/8o1yzJ+RmmGZgu8/J8r8GTgomBVR9WUhu1Ql0VOU+Lx0b6zvpsFI0yholzyMiCrK2Nv3agNL4z2sPj4fAwhAUzZo6nJLxYLAMkOof49g0gX9N+t0AP/KclNsNDVtcTDfSRI/WQyinSivJx2yZqXqkA==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(36840700001)(46966006)(54906003)(336012)(26005)(508600001)(110136005)(82310400003)(4326008)(2906002)(5660300002)(426003)(36756003)(9786002)(36906005)(6666004)(47076005)(36860700001)(107886003)(8676002)(316002)(7636003)(70586007)(31696002)(8936002)(186003)(70206006)(31686004)(2616005)(44832011)(83380400001)(356005)(53546011)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2021 12:21:57.8147
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be9280b8-3b54-4379-cd20-08d9ab572e74
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT026.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR02MB6434
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org



On 11/18/21 22:17, Ruediger Willenberg wrote:
> Find free uart_port struct in range 0 <= id < ULITE_NR_UARTS when
> the device tree port-number property is outside that range. This
> happens when there are other UART types in the system because the
> Xilinx device tree generator numbers all UARTs consecutively;
> as a result, not as many Uartlites as specified by the
> SERIAL_UARTLITE_NR_UARTS parameter could be successfully added.
> 
> Signed-off-by: Ruediger Willenberg <r.willenberg@hs-mannheim.de>
> ---
> Changes in v2:
>   - give KERN_NOTICE when changing the id,
>     with reference to the requested port-number
> 
>   drivers/tty/serial/uartlite.c | 16 +++++++++++-----
>   1 file changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/tty/serial/uartlite.c b/drivers/tty/serial/uartlite.c
> index d3d9566e5dbd..27c513c7350e 100644
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
> @@ -676,7 +678,11 @@ static int ulite_assign(struct device *dev, int id, u32 base, int irq,
>   		dev_set_drvdata(dev, NULL);
>   		return rc;
>   	}

nit: please keep this newline here.

> -
> +	if (oor_id >= 0)
> +		dev_notice(dev,
> +			"assigned uartlite with device tree port-number=<%i> to %s%i\n",
> +			oor_id, ULITE_NAME, id);
> +



[linux](master)$ ./scripts/checkpatch.pl --strict 
0001-serial-uartlite-Move-out-of-range-port-numbers-into-.patch
CHECK: Alignment should match open parenthesis
#54: FILE: drivers/tty/serial/uartlite.c:669:
+		dev_notice(dev,
+			"assigned uartlite with device tree port-number=<%i> to %s%i\n",



>   	return 0;
>   }
>   

And there is one more issue with this. If you start to mix serial IPs 
which are partially recorded in aliases. For example like this.

aliases {
	serial0 = &uart1;
};

uart0 {
...
};

uart1 {
...
};

Uart0 is probed first. It is without alias and id 0 will be assigned to 
it. Then uart1 is probed. It looks at aliases you get id 0 but it is 
already taken and you end up with "cannot assign to %s%i; it is already 
in use"

It would be IMHO better to use of_alias_get_highest_id().
In xilinx_uartps I used in past of_alias_get_alias_list() to get 
bitfield of aliases which are taken and use only that one which are free 
but up2you. Having the same behavior across drivers would be good.

Thanks,
Michal





