Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1650C4338F
	for <linux-serial@archiver.kernel.org>; Mon, 26 Jul 2021 14:19:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3C73608FB
	for <linux-serial@archiver.kernel.org>; Mon, 26 Jul 2021 14:19:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233194AbhGZNjQ (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 26 Jul 2021 09:39:16 -0400
Received: from mail-mw2nam10on2087.outbound.protection.outlook.com ([40.107.94.87]:10100
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233206AbhGZNjP (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 26 Jul 2021 09:39:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qyw1A4fNiCSmKY2RgVdwepR1W4xbI7h3gioX8JcL0SVjKoe1P9u7FtTsitwbpcs1M4R/hW1KMdL0bML0QTmvcekaOp60MiurIea4EHfxBY7EwbOSQcz/Co/KxvRK4sdVPq4MVuYkFmDetEjQTb11nusjk3CWCT3KDjPM826b/QDRnPo5nWUBWeet+3OytnjwGDq22SABAUvJwGb/zRHi0bnUoJSbmI7NXo7wF3qBUGJA95burizuadp22Ve3KYV1MaoRqwAdokP+nFLqZexyZ/NRg68Jps819/uCq0IkMkMrxX0QCfgbT/bmYKtraJiNPeOrnt26IkUzTXTvr69q2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z0DNVMeSoqTwyQP+GzPa/0Vq33q1/wISK9c+iuyhm7Q=;
 b=DfQoxSdPPKONadlusHAH9oiSg7iPrYAk52oDpBzE+nbvrzdCg7CizYhCk64yNTglMEoIcB5UpF5diiMj3VK6ONBDOmEj6kC00/OLTlJr7f6kbVwaG+way2OwckgUHGo7PEqCygS/nYVSVbjZWL/Ns340PVRvIHaViRnJH1IJbPxH3venNAnhmZ00R3rQQIpw/HQU+VcCbLDgElLHqSccQbTxOHRCIuZ8qNELwj48vqT0fPFNOJrIGaSY390y/lNta5aO/ulMZcB74lvCulJdCiA8G/OyH8mf7dOuZjDV5KG8qgkN208omI0jY+EErOThXXRtKV50OmvEkEVbLyDWqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 149.199.62.198) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=xilinx.com; dmarc=temperror action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z0DNVMeSoqTwyQP+GzPa/0Vq33q1/wISK9c+iuyhm7Q=;
 b=WxyQF5G34ZctnPutw7ERJ16dbyVpNopiGIZi4sS47XfhltUDsPV9fecz3HMac+KEXY7SYF8KhKsRGcNcxnMT6utQunHrMZI8Y5+vKa/IDtFFvLCME7FuDtlepZ3BU9GCs9IG9Jpz2d2FZkA7LpQ3Gean7+qfaHWM1NPBM/JwFMI=
Received: from DM5PR18CA0091.namprd18.prod.outlook.com (2603:10b6:3:3::29) by
 DM5PR02MB2252.namprd02.prod.outlook.com (2603:10b6:3:53::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4352.26; Mon, 26 Jul 2021 14:19:39 +0000
Received: from DM3NAM02FT049.eop-nam02.prod.protection.outlook.com
 (2603:10b6:3:3:cafe::f8) by DM5PR18CA0091.outlook.office365.com
 (2603:10b6:3:3::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.25 via Frontend
 Transport; Mon, 26 Jul 2021 14:19:39 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 149.199.62.198) smtp.mailfrom=xilinx.com; linuxfoundation.org; dkim=none
 (message not signed) header.d=none;linuxfoundation.org; dmarc=temperror
 action=none header.from=xilinx.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of xilinx.com: DNS Timeout)
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT049.mail.protection.outlook.com (10.13.5.68) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4352.24 via Frontend Transport; Mon, 26 Jul 2021 14:19:38 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 26 Jul 2021 07:19:38 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Mon, 26 Jul 2021 07:19:38 -0700
Envelope-to: gregkh@linuxfoundation.org,
 jacmet@sunsite.dk,
 linux-serial@vger.kernel.org,
 sean.anderson@seco.com
Received: from [172.30.17.109] (port=59064)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1m81SD-0000at-OX; Mon, 26 Jul 2021 07:19:37 -0700
Subject: Re: [PATCH] tty: serial: uartlite: Use read_poll_timeout for a
 polling loop
To:     Sean Anderson <sean.anderson@seco.com>,
        <linux-serial@vger.kernel.org>,
        Peter Korsgaard <jacmet@sunsite.dk>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
CC:     Michal Simek <michal.simek@xilinx.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20210723215220.624204-1-sean.anderson@seco.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <292d7088-063c-9649-7b87-a7f3fd48b796@xilinx.com>
Date:   Mon, 26 Jul 2021 16:19:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210723215220.624204-1-sean.anderson@seco.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7562d3e8-089f-4b20-cb97-08d950406713
X-MS-TrafficTypeDiagnostic: DM5PR02MB2252:
X-Microsoft-Antispam-PRVS: <DM5PR02MB2252F424B9C7F8D06888ABEDC6E89@DM5PR02MB2252.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3Gd2r0zzt+mC445vGgaea5CuTmNG+ItkJNpDjws6rDcwWEqNOXXJfoiYxb8D6GwelZYHCWdpWyIUspzveRRAspKc31Ebsae/0DKbioOkjCC0rfqynNAYzqMtBWOjkD0CnFYA/I446DhutQWPDghgZu1hIVIb1zchhKW9CXNGCV0S5KcpLexrnGcf2wYIT1cv6WOdEWnFtmtCDRwjfLlCcnyc9XYBFrCu9Sf+VJuDpq+nuONyUZ85t6J3QyMD9Mp+u+kysuwm/dETOscn+tRTUCSQH14qy1eVKj1DTgRT/JnjXQpQS2SoVPGWBMAEiEZAfXJ7xNDxJnuXw77/f3DaFV31r2IzOtRq2VANb16jEYUmYo2BU4+Vp5mU5zgeArptrpuvaSo+EIuDxZfIrvvTBF+gtwIVoHPENRt8fmfjgzqLDzqoOWTbHWYlbIAA7ROJQtPbl8a7en+DX0VXia/TfQe52vVAg2RApOlg9AmCBFxmeCaR021+IA9kr1sYOuoRH37iI7vd/cjaoGcwBcqLi6QdSpDZByvU5IFWdcJ9lzs0gzuQKDSERhgFvgEd32Dzx2vI32fjkvEJlAj7qdDlvntsMJT9nd5+Fx4gVbM5oyAf6cUPOoVOxGnnSR7a0ZLba14sLDZVz3O7T3Apyo6I6gqsFhFsf2s2Av4/SRUVJlknFPbLKMjfSzJVMX+2naqNiVT68PFpEg9N+Zb35aH/2PUYYqXPInj8sh+ARXgvoiu8qzdQWTg7PLZOXLq6rb1b
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(39860400002)(396003)(376002)(346002)(136003)(46966006)(36840700001)(70206006)(70586007)(54906003)(4326008)(53546011)(36906005)(8676002)(356005)(7636003)(31696002)(36756003)(83380400001)(5660300002)(316002)(110136005)(26005)(8936002)(9786002)(6636002)(82740400003)(47076005)(478600001)(336012)(63350400001)(63370400001)(2906002)(2616005)(31686004)(44832011)(426003)(82310400003)(186003)(36860700001)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2021 14:19:38.6195
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7562d3e8-089f-4b20-cb97-08d950406713
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT049.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR02MB2252
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

+Shubhrajyoti

On 7/23/21 11:52 PM, Sean Anderson wrote:
> This uses read_poll_timeout_atomic to spin while waiting on uart_in32.
> 
> Signed-off-by: Sean Anderson <sean.anderson@seco.com>
> ---
> 
>  drivers/tty/serial/uartlite.c | 18 +++++-------------
>  1 file changed, 5 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/tty/serial/uartlite.c b/drivers/tty/serial/uartlite.c
> index f42ccc40ffa6..106bbbc86c87 100644
> --- a/drivers/tty/serial/uartlite.c
> +++ b/drivers/tty/serial/uartlite.c
> @@ -17,6 +17,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/init.h>
>  #include <linux/io.h>
> +#include <linux/iopoll.h>
>  #include <linux/of.h>
>  #include <linux/of_address.h>
>  #include <linux/of_device.h>
> @@ -448,24 +449,15 @@ static const struct uart_ops ulite_ops = {
>  static void ulite_console_wait_tx(struct uart_port *port)
>  {
>  	u8 val;
> -	unsigned long timeout;
>  
>  	/*
>  	 * Spin waiting for TX fifo to have space available.
>  	 * When using the Microblaze Debug Module this can take up to 1s
>  	 */
> -	timeout = jiffies + msecs_to_jiffies(1000);
> -	while (1) {
> -		val = uart_in32(ULITE_STATUS, port);
> -		if ((val & ULITE_STATUS_TXFULL) == 0)
> -			break;
> -		if (time_after(jiffies, timeout)) {
> -			dev_warn(port->dev,
> -				 "timeout waiting for TX buffer empty\n");
> -			break;
> -		}
> -		cpu_relax();
> -	}
> +	if (read_poll_timeout_atomic(uart_in32, val, !(val & ULITE_STATUS_TXFULL),
> +				     0, 1000000, false, ULITE_STATUS, port))
> +		dev_warn(port->dev,
> +			 "timeout waiting for TX buffer empty\n");
>  }
>  
>  static void ulite_console_putchar(struct uart_port *port, int ch)
> 
