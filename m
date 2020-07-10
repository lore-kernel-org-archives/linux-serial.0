Return-Path: <SRS0=t8aj=AV=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5199C433DF
	for <linux-serial@archiver.kernel.org>; Fri, 10 Jul 2020 11:45:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A931A20748
	for <linux-serial@archiver.kernel.org>; Fri, 10 Jul 2020 11:45:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="OKrH2Sgp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbgGJLpi (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 10 Jul 2020 07:45:38 -0400
Received: from mail-dm6nam11on2065.outbound.protection.outlook.com ([40.107.223.65]:31147
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726725AbgGJLph (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 10 Jul 2020 07:45:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kxRu4Y/XZvt31l/nECuyKrhBS5qN8d3UDDT3wvdZbdfxfTrMSR8DjgC+J6SSKmr4Qq/6f0fNb5f04XfcMprLuYqgrk7NMiBwxPlcUMa1cnYvV+8QP8AueCy07DkV0yvtxWNjtN6WDlX8vYxj/0YrzN7dj8UiN4qFBvdCjYE8tn9KrlLy8f3D9A2WoHciEM2mcpEmLv2Jqtibsl2xd1pVq2c+GT+TeR0zH95eE6ugJWJ4IxmlcxzbD8U+ihT9YlizpZLwdAObbFjyySCYmNcxOZO1jA3pxCl5E9bxdkx2y1H/OQIUfyTX2focYadVvSMkyEa8rHDgdlPGURcgz6mQ4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tLOYZERGU2M0QFXZAq3aH9Bba5xFQVTfksdfa61I+MM=;
 b=bzkLFvTqjQ6AmYiEjLAgvrmJadnOs4fs6LDy9D0XvN+6oiEVuXgKNIQO66rp7YbqdNZMdYMNFB2Matn7M4HCIWGAUpxUuP9Lrq/DEyIxqg/S7ZSd3hdXfPblk/7pUe7x4lJn3WhfDK7/LKJZ/zXCmOBRBGbyoHvYR98cf2xXXP9I8B/ZdFPZ3sylbCihtCBM1F0H6L3aqo8uD101Jwbk4QyzldA042ZVaOlXSBPL5Muvvqba8V85nzUX4iHf30ukGyVeYLnRymliXiIdeFcPSa4A/EFC/xEcoojrVFOkz1JLYW6l9rQlS1Hukc7sBcZL+n9aQOrOLHZ3S5Ucbt3obg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=intenta.de smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tLOYZERGU2M0QFXZAq3aH9Bba5xFQVTfksdfa61I+MM=;
 b=OKrH2SgpdnfxiMeOSdKzT1+M9yT2pAMBDawnV4a+tE1Ay3dwHfocqCZv2qJS1w7syNIN3z8rLH9miExDs/JT/TzjMvQI3wkOsuItpMdsTE+hqDzf50Bx42rU6eVPj9WCuG93JhYEg97z7Ki2q/EF24A2eCOnWmiyXalHEaeKJsU=
Received: from CY4PR08CA0046.namprd08.prod.outlook.com (2603:10b6:903:151::32)
 by DM6PR02MB7065.namprd02.prod.outlook.com (2603:10b6:5:25a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.20; Fri, 10 Jul
 2020 11:45:33 +0000
Received: from CY1NAM02FT044.eop-nam02.prod.protection.outlook.com
 (2603:10b6:903:151:cafe::6a) by CY4PR08CA0046.outlook.office365.com
 (2603:10b6:903:151::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21 via Frontend
 Transport; Fri, 10 Jul 2020 11:45:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; intenta.de; dkim=none (message not signed)
 header.d=none;intenta.de; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT044.mail.protection.outlook.com (10.152.75.137) with Microsoft SMTP
 Server id 15.20.3174.21 via Frontend Transport; Fri, 10 Jul 2020 11:45:32
 +0000
Received: from [149.199.38.66] (port=56829 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1jtrRc-0003T0-3x; Fri, 10 Jul 2020 04:43:56 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1jtrT9-0007QK-Sd; Fri, 10 Jul 2020 04:45:31 -0700
Received: from xsj-pvapsmtp01 (mailhost.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 06ABjOt8030935;
        Fri, 10 Jul 2020 04:45:24 -0700
Received: from [172.30.17.109]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1jtrT1-0007Lz-Vu; Fri, 10 Jul 2020 04:45:24 -0700
From:   Michal Simek <michal.simek@xilinx.com>
Subject: Re: [PATCH] tty: xilinx_uartps: Really fix id assignment
To:     Helmut Grohne <helmut.grohne@intenta.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        Jan Kiszka <jan.kiszka@web.de>
Cc:     linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <f4092727-d8f5-5f91-2c9f-76643aace993@siemens.com>
 <20200709074849.GA28968@laureti-dev>
Autocrypt: addr=michals@xilinx.com; keydata=
 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
 0Z1MQlmNcq2bhOMzTxuXX2NDzUZs4aqEyZQ=
Message-ID: <a3b9df28-8142-fc04-317f-44d65a24f38e@xilinx.com>
Date:   Fri, 10 Jul 2020 13:45:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200709074849.GA28968@laureti-dev>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFTY:;SFS:(376002)(39860400002)(396003)(136003)(346002)(46966005)(966005)(36756003)(70586007)(44832011)(478600001)(70206006)(8676002)(8936002)(316002)(31696002)(2616005)(2906002)(336012)(426003)(4326008)(6666004)(186003)(81166007)(9786002)(31686004)(110136005)(82310400002)(83380400001)(356005)(26005)(82740400003)(47076004)(5660300002)(43740500002);DIR:OUT;SFP:1101;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 186c005b-231a-41d4-e50c-08d824c6c050
X-MS-TrafficTypeDiagnostic: DM6PR02MB7065:
X-Microsoft-Antispam-PRVS: <DM6PR02MB70653D9E6CB2CDEEAFFB98A8C6650@DM6PR02MB7065.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6D2F7iN/FlSdq70R5IwEvURKsHChsl/2FD6KcAHnR1BSV9TzREUrYT5Q8FkPZlQm7qDYfzOmsBBPDlMo+wYTtRh6dF3qvcmroQY2NDE52XnXpKwkmNxkp9N3dDBAajHR5Z2RWsNw70HHvW0tzBIv0u4NPWpH7Yb+PGcmWpomb7q9gbFqBIJyp+Ez2OwCEIfp0+fzu02Eol0jKeh0hnyU8lohJFaCoQ9y7ScWwdKpL7d89hC7K7vtGYGy/hS77MqTM23SHdl5Rr7+t69UaEQ4Ifid7eRDPMnT2oU7dwLEMDgJh5aEuQ4sh3NoXhR50dpqiRKZF9yyQN1YJ7KzfteiLcmZKeNKrSAJqWHj1g3q9ITSmXBeDimOoMQgUnD1KTIcHdAb/nVLfqBbwNzjehKXO/j6iI466oDwohQK3xp7ui61eHSLFGXwN9XTsWfYMfHTwjMRaV09I8LM8NOYpw98DQP3ogeSKvH09+/T+/wuth0feZtAY7RGI0RnZ2Lh+bon
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2020 11:45:32.1282
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 186c005b-231a-41d4-e50c-08d824c6c050
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: CY1NAM02FT044.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB7065
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


Hi,

On 09. 07. 20 9:48, Helmut Grohne wrote:
> The problems started with the revert (18cc7ac8a28e28). The
> cdns_uart_console.index is statically assigned -1. When the port is
> registered, Linux assigns consecutive numbers to it. It turned out that
> when using ttyPS1 as console, the index is not updated as we are reusing
> the same cdns_uart_console instance for multiple ports. When registering
> ttyPS0, it gets updated from -1 to 0, but when registering ttyPS1, it
> already is 0 and not updated.
> 
> That led to 2ae11c46d5fdc4. It assigns the index prior to registering
> the uart_driver once. Unfortunately, that ended up breaking the
> situation where the probe order does not match the id order. When using
> the same device tree for both uboot and linux, it is important that the
> serial0 alias points to the console. So some boards reverse those
> aliases. This was reported by Jan Kiszka. The proposed fix was reverting
> the index assignment and going back to the previous iteration.
> 
> However such a reversed assignement (serial0 -> uart1, serial1 -> uart0)
> was already partially broken by the revert (18cc7ac8a28e28). While the
> ttyPS device works, the kmsg connection is already broken and kernel
> messages go missing. Reverting the id assignment does not fix this.
> 
> From the xilinx_uartps driver pov (after reverting the refactoring
> commits), there can be only one console. This manifests in static
> variables console_pprt and cdns_uart_console. These variables are not
> properly linked and can go out of sync. The cdns_uart_console.index is
> important for uart_add_one_port. We call that function for each port -
> one of which hopefully is the console. If it isn't, the CON_ENABLED flag
> is not set and console_port is cleared. The next cdns_uart_probe call
> then tries to register the next port using that same cdns_uart_console.
> 
> It is important that console_port and cdns_uart_console (and its index
> in particular) stay in sync. The index assignment implemented by
> Shubhrajyoti Datta is correct in principle. It just may have to happen a
> second time if the first cdns_uart_probe call didn't encounter the
> console device. And we shouldn't change the index once the console uart
> is registered.
> 
> Reported-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> Reported-by: Jan Kiszka <jan.kiszka@web.de>
> Link: https://lore.kernel.org/linux-serial/f4092727-d8f5-5f91-2c9f-76643aace993@siemens.com/
> Fixes: 18cc7ac8a28e28 ("Revert "serial: uartps: Register own uart console and driver structures"")
> Fixes: 2ae11c46d5fdc4 ("tty: xilinx_uartps: Fix missing id assignment to the console")
> Signed-off-by: Helmut Grohne <helmut.grohne@intenta.de>
> ---
>  drivers/tty/serial/xilinx_uartps.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
> index b9d672af8b65..2833f1418d6d 100644
> --- a/drivers/tty/serial/xilinx_uartps.c
> +++ b/drivers/tty/serial/xilinx_uartps.c
> @@ -1465,7 +1465,6 @@ static int cdns_uart_probe(struct platform_device *pdev)
>  		cdns_uart_uart_driver.nr = CDNS_UART_NR_PORTS;
>  #ifdef CONFIG_SERIAL_XILINX_PS_UART_CONSOLE
>  		cdns_uart_uart_driver.cons = &cdns_uart_console;
> -		cdns_uart_console.index = id;
>  #endif
>  
>  		rc = uart_register_driver(&cdns_uart_uart_driver);
> @@ -1581,8 +1580,10 @@ static int cdns_uart_probe(struct platform_device *pdev)
>  	 * If register_console() don't assign value, then console_port pointer
>  	 * is cleanup.
>  	 */
> -	if (!console_port)
> +	if (!console_port) {
> +		cdns_uart_console.index = id;
>  		console_port = port;
> +	}
>  #endif
>  
>  	rc = uart_add_one_port(&cdns_uart_uart_driver, port);
> @@ -1595,8 +1596,10 @@ static int cdns_uart_probe(struct platform_device *pdev)
>  #ifdef CONFIG_SERIAL_XILINX_PS_UART_CONSOLE
>  	/* This is not port which is used for console that's why clean it up */
>  	if (console_port == port &&
> -	    !(cdns_uart_uart_driver.cons->flags & CON_ENABLED))
> +	    !(cdns_uart_uart_driver.cons->flags & CON_ENABLED)) {
>  		console_port = NULL;
> +		cdns_uart_console.index = -1;
> +	}
>  #endif
>  
>  	cdns_uart_data->cts_override = of_property_read_bool(pdev->dev.of_node,
> 

Thanks for the patch. I think that it will be very useful to list out
all testcases to make sure that we test all that scenarios and finally
get over it.
We are testing scenarios and likely we are missing some that we are not
able catch all issues before we submit a patch.

Thanks,
Michal
