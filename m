Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2B5DC433F5
	for <linux-serial@archiver.kernel.org>; Thu, 18 Nov 2021 08:34:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB23E61548
	for <linux-serial@archiver.kernel.org>; Thu, 18 Nov 2021 08:34:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244644AbhKRIh0 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 18 Nov 2021 03:37:26 -0500
Received: from mail-sn1anam02on2074.outbound.protection.outlook.com ([40.107.96.74]:1173
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S244638AbhKRIhY (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 18 Nov 2021 03:37:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HCNEWT3i5JX7cDCtMr8ylPhRZJthcbT4soVkBvtX31O7MbVD1lYMJamhcke+H3bgOWzy+hWzxsMDfqDK1yEXkHhc6rSQCGWl4UBWbIRBgRBKLvjcQwTskmbuBj2rNFlgKOZck/8dc3GEbWtvnxZfISo9OJRRyvHeNo2voSYsBiLtbLgxudAy6FMUMX6KTzw+9P8ZlVIE0ywSLgcRKF9MVmPdu8Tkl+JHYDRyMAwegdGkowalOma3kPPvhMWc2IVKJbkIfuFTkW0nEt6JVQJf23gJOapVwntaMZLkJExj/in6WNDc+IAJxh4wLZHsbzW5xFHpRx7v3bZaDbC6eHQ6EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hkx7LeRcgQ1kYTengaKOldJ/vRSOGUN37EkB9OadsMc=;
 b=G0rwO0shVHVW5UYs1zTkc6HW3oQr0HXepewSgiJlj9fCf1Llj3HdACjbnHHrNV1/Hb0MbOwGLg5LyUBGCpXUik5lkxmIeQ3pDM1f+zUI8FkaaJWYoprDbpdEUhZTo5xpNUDZ5e5A0xQm5LRfvYHzwaP+U2GP/e2DYahXoHZQdBU4OGPbiaNk+ALJDowBMvW6YZfU3nd2Myomouadb5B8hWHjUOThhVh6mTjV66h7gTm+4dS2A0+28mjYE3vCfZE+2s5VGF7NCeh4HzG6mUjBXcQwSXJ0bf0/0C0b/jWkkFe9+1BknhJxV5tt+uqqn9VotgsjpH9/4TPyFJe0SSXLOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=hs-mannheim.de smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hkx7LeRcgQ1kYTengaKOldJ/vRSOGUN37EkB9OadsMc=;
 b=hmhwCeTjfnBQXMn1Mg3EoopVVAa90lJ6b+vqniUF+OKB24lDgzch82DKKeKjUaJ7LcdvkZ+sn7cIy5HoOwYCGBuVFU7RQUatCGIM6L0WgNejCe8iMsVyWW7ardzZDyXbEm9pYxS5H3P6BnhAoPBvMZ+hEQld6csYz8nf8Ia8bFg=
Received: from SA0PR12CA0004.namprd12.prod.outlook.com (2603:10b6:806:6f::9)
 by MWHPR02MB2351.namprd02.prod.outlook.com (2603:10b6:300:5f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.26; Thu, 18 Nov
 2021 08:34:21 +0000
Received: from SN1NAM02FT0047.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:6f:cafe::92) by SA0PR12CA0004.outlook.office365.com
 (2603:10b6:806:6f::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19 via Frontend
 Transport; Thu, 18 Nov 2021 08:34:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0047.mail.protection.outlook.com (10.97.5.120) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4713.19 via Frontend Transport; Thu, 18 Nov 2021 08:34:20 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Thu, 18 Nov 2021 00:34:18 -0800
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Thu, 18 Nov 2021 00:34:18 -0800
Envelope-to: git@xilinx.com,
 r.willenberg@hs-mannheim.de,
 linux-serial@vger.kernel.org,
 gregkh@linuxfoundation.org,
 jacmet@sunsite.dk
Received: from [10.254.241.49] (port=55198)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1mncs5-000DHe-SN; Thu, 18 Nov 2021 00:34:18 -0800
Message-ID: <01610e0c-998a-85b3-17b4-5a495c2974bf@xilinx.com>
Date:   Thu, 18 Nov 2021 09:34:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH] serial: uartlite: Move out-of-range port-numbers into
 ULITE_NR_UARTS range
Content-Language: en-US
To:     Ruediger Willenberg <r.willenberg@hs-mannheim.de>,
        <linux-serial@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>, <jacmet@sunsite.dk>,
        <git@xilinx.com>, <shubhrajyoti.datta@xilinx.com>,
        <michal.simek@xilinx.com>
References: <20211117221510.11959-1-r.willenberg@hs-mannheim.de>
From:   Michal Simek <michal.simek@xilinx.com>
In-Reply-To: <20211117221510.11959-1-r.willenberg@hs-mannheim.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bf79db0f-dfb9-4f40-7f8f-08d9aa6e37a2
X-MS-TrafficTypeDiagnostic: MWHPR02MB2351:
X-Microsoft-Antispam-PRVS: <MWHPR02MB23519A030B1D24AE2319F830C69B9@MWHPR02MB2351.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:1775;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SuWiHawcPap8XmUdjEXS54d8GX3QzBee6zSfTTCPbosHKQgtZw7PgvxCw/pzuA3Kc1WJmw28tDntfogWRziXPkmNNTVUUMwdm4WJlMzDEK7gZ/h1Aj7II3O7dC9q1HVOsCLB5GUwTKKZDXpSz0+JFuGLbzxkhAPZZO79dObS+n2ErZG06vI0bXZIKDegbyC/8l28YNJNmFw51UtNWxpXQ94K2bY0qFduiRYvdL2q5nXzZR/io7+VsRsGMJnnyI+W7C51ElPh6CMjWp/j3qpN/8CWdyqeaO3H+QwtUJJ08++iKFLKDQD9EoQPrGXInRrYKn+YG/nAagdAYZ0UDsTINSyTA8+c4ZJAHdl17vtgMOBUzpz+0vomz4sxexXuDaov9BnebbqozgDq8/kkmJvq47Cg5qdnCywmChGf3RcELgzx/hVKCq3i6XOubPAh9kZ/R10Hxqt9I2mHPVUx2woa/jqPdXrdTl1l4Ejm+/YJT55AJgHfX5wNVySOusprqGBnKlg6lB7MTDjyRVbVPF/I5rRvTat7qrk5Bd0Ya6uDXvnjsrz6LgrEHNMjWvNBKVvxZzicUeNO95rM80TqNwt3jwtk3JqoQpsVPwjlI7ytOtQ4+wq/kJk2x4DqniOqScH1OXVy4KRIQzVEL/p/o9XocNbClH5foixU1ZVM25+To+BHVmxCTnY4LRNIZuB1nY07deCSUICx6LpPrabs9uOgHivVBSP19ZK1R+MjFjY1LwgdKXlv4gQVorQ1CNanLs9mkyYvf4p4rO3nZdajxZlprw==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(46966006)(36840700001)(54906003)(4326008)(36906005)(47076005)(426003)(44832011)(31686004)(356005)(36756003)(6666004)(2616005)(2906002)(316002)(110136005)(508600001)(9786002)(36860700001)(8936002)(336012)(8676002)(7636003)(31696002)(82310400003)(186003)(70206006)(83380400001)(53546011)(70586007)(107886003)(26005)(5660300002)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2021 08:34:20.5357
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf79db0f-dfb9-4f40-7f8f-08d9aa6e37a2
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0047.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB2351
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org



On 11/17/21 23:15, Ruediger Willenberg wrote:
> Find free uart_port struct in range 0 <= id < ULITE_NR_UARTS when
> the device tree port-number property is outside that range. This
> can happen because the Xilinx device tree generator does not start
> enumerating Uartlites at 0 when there are PS-UARTs or AXI 16550A
> UARTs in the system; it then enumerates all UARTs consecutively
> despite them having separate drivers with separate structures.
> This has become more problematic since the Kconfig property
> SERIAL_UARTLITE_NR_UARTS enables precise allocation of uart_port
> structs, which can't be used if the port-number doesn't start at 0
> 
> Signed-off-by: Ruediger Willenberg <r.willenberg@hs-mannheim.de>
> ---
>   drivers/tty/serial/uartlite.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/tty/serial/uartlite.c b/drivers/tty/serial/uartlite.c
> index d3d9566e5dbd..546eecdb6033 100644
> --- a/drivers/tty/serial/uartlite.c
> +++ b/drivers/tty/serial/uartlite.c
> @@ -632,14 +632,14 @@ static int ulite_assign(struct device *dev, int id, u32 base, int irq,
>   	struct uart_port *port;
>   	int rc;
>   
> -	/* if id = -1; then scan for a free id and use that */
> -	if (id < 0) {
> +	/* if id -1 or out of range; then scan for a free id and use that */
> +	if (id < 0 || id >= ULITE_NR_UARTS) {
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
> 

Don't you want to also inform user about it? They can expect that 
serial10 is going to be ttyUL10 but if ULITE_NR_UARTS is less you will 
get different number and user will have no idea why.

Thanks,
Michal
