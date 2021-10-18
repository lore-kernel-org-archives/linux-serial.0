Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36298C433EF
	for <linux-serial@archiver.kernel.org>; Mon, 18 Oct 2021 08:27:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C9FD60FDA
	for <linux-serial@archiver.kernel.org>; Mon, 18 Oct 2021 08:27:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbhJRIaB (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 18 Oct 2021 04:30:01 -0400
Received: from mail-dm3nam07on2043.outbound.protection.outlook.com ([40.107.95.43]:25791
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230173AbhJRIaA (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 18 Oct 2021 04:30:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iuRURVo9eDULyhIeegTEV8JR+19MH4DdZx3ocaUpY6jM+O83hnrH84RVVTl1Mw+9/ls9xgtaAAYJP7c7FgDLegUNuc8/D7tE7K4hLm/NN1vY9str548zUQKvNLwHOtSDZuKMHyS3t+Kuqdz9+y1cF6BNQLG7QtA93mRD7L9Nb30hJqws3lzlDISnWRGYKO3kOQQeslD2G7LfWyN1QguV7PjiE1CLl42Q0Av+rItmymEFtwXZtibKcdyly0BlSxAJ3sjhCMHceZR3F6xfBLfj65+iX1JNz6OY8/bGKGDBe1rihBqGZZyiI8nVAA3r2BMaWawe/ScBMsOvBipk5B0kBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sffD4sKcGOOvIXzZc08kWKcai11xvU1wofrrJZqmJNU=;
 b=cphE1YrUjhAh1ETryqNPmw+dQr9WOX6trtWkJt8yY47FXfNk7ujjbMIj4VebhfaBLxiRpNLiPKqpGLiATKV8cF7ue8lO/NNM2t/W2F9oxokJweRX/U0GI04YsJCjb1gCxFG0ZNjQyVvsNN1jfL+CQU5gRSA/FZIE4Ra5ZDa/TKuIQ39SRClSzUU4FTkYLy/RaGVYsc7wSg96TTVinMq/rm2CHFxNrr+FeevCUq5gcwIaG9+qvIcSAJfL/sF0oXp4Yd3ayvSHa5HaDUVgaGJchM2ELQdr8lsvNUxlPAcTN5bbbAXxOvCsL3/Bk6de8ztn4zFSqJKUyv4Foz5cVv8D+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sffD4sKcGOOvIXzZc08kWKcai11xvU1wofrrJZqmJNU=;
 b=KEZEkp1cWyuOwY6Yv2Z33A6WIuXYtEHmiZRNs8MS/UY7EprxoKrEalq1QTrzYq/9QXv2nmJqsd4YQLIPW+2kamWhvCPdemAZV+89cl9KIj1DlflweyyTdwCG1KdttUfl3jV5VBuaoatua040NVhKIRcqCgXkHBG7vNvsbfCHv/M=
Received: from SA9PR13CA0147.namprd13.prod.outlook.com (2603:10b6:806:27::32)
 by BL0PR02MB4708.namprd02.prod.outlook.com (2603:10b6:208:56::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.18; Mon, 18 Oct
 2021 08:27:47 +0000
Received: from SN1NAM02FT0029.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:27:cafe::96) by SA9PR13CA0147.outlook.office365.com
 (2603:10b6:806:27::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.10 via Frontend
 Transport; Mon, 18 Oct 2021 08:27:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0029.mail.protection.outlook.com (10.97.4.175) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4608.15 via Frontend Transport; Mon, 18 Oct 2021 08:27:46 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Mon, 18 Oct 2021 01:27:46 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Mon, 18 Oct 2021 01:27:46 -0700
Envelope-to: linux-serial@vger.kernel.org,
 gregkh@linuxfoundation.org,
 shubhrajyoti.datta@gmail.com
Received: from [10.254.241.49] (port=32994)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1mcNzk-000AcV-Jo; Mon, 18 Oct 2021 01:27:44 -0700
Message-ID: <86771756-07ef-eb47-7eb3-0c995a1820d0@xilinx.com>
Date:   Mon, 18 Oct 2021 10:27:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] uartlite: Update the default for the parameter
Content-Language: en-US
To:     Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        <linux-serial@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>, <shubhrajyoti.datta@gmail.com>,
        <git-dev@xilinx.com>
References: <20211018082000.607185-1-shubhrajyoti.datta@xilinx.com>
From:   Michal Simek <michal.simek@xilinx.com>
In-Reply-To: <20211018082000.607185-1-shubhrajyoti.datta@xilinx.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4b486a60-55d9-40ab-3746-08d992112a39
X-MS-TrafficTypeDiagnostic: BL0PR02MB4708:
X-Microsoft-Antispam-PRVS: <BL0PR02MB4708BCF3E197AC6AE3CC5C3BC6BC9@BL0PR02MB4708.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:972;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /XkFJmvfqOhwtWbA2hiNL0Ol/GKZ1PA63JkgYtN+29bXbFERaAqFBS0aTqt2fAkiyxzGAFf6KTICIByzc1RWLMa1XKz3+lggQ9J0Fan2vhGtZ4KWwf4QHoAu2lh4TToJeRcLIIPZYhDvkF/7B3wNy/XdUhgHTKByaMfeir3EES9gj0ICsi0gCxC9aqrCjXEdWT31o8BukPBbJKfS5tfqDXnXXA8lpJZ3NRIe3kwonVxYmDG2+AqVBwdrapV4JrlRoPpt5NDjKwnXtSrFZmP+cdmEArLo6Q+6xxDwTa7ACScDI2QMMESiQQd8lgEjhavjc9BosHjerkjbmDtRvrJaXKAqoUJYL8JuHOVq5Sp6/ABMrc9pfE8ZYeH7ggDEB6wyqPnMMD0e14CfRMceQqEnKqM0uSgZGYpMqFFFQ9H76TGD18XRLrFOeUZvn3SirlSHs+aZT3LVxC2Tobmk65NGjIGVYiHZ406WyhzhJHoxL1P/0kfWbDgl2MR0oyHwdWDjWjs7dXzUaNrh7z9JUxRzDHfVnXdJSVPe/KeOxLnX2TVfsRjEzppmghg1TP5K/oQz4OkFzkwwg1L0GN4okCbKfZZlecIiVY4XF7syXcQbyyOl+tpfRo9YVICWdwFNlC0YWJPtkR+HMLj2Wp13qsLpKrk9dCiZJ6stvqqgz6y5qImo9NP5bP/Zagt1swI3X19e94S1zVdvPwwzTa9oAUXDSd9SRodllbOK3kcoZkCHk+l9XwUL4/VmLhQDvPRr8on+
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(46966006)(36840700001)(2616005)(31686004)(426003)(83380400001)(44832011)(7636003)(508600001)(4744005)(4326008)(2906002)(36756003)(5660300002)(356005)(8936002)(54906003)(336012)(15650500001)(70586007)(70206006)(82310400003)(9786002)(110136005)(26005)(31696002)(53546011)(47076005)(186003)(107886003)(8676002)(36906005)(36860700001)(316002)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2021 08:27:46.9318
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b486a60-55d9-40ab-3746-08d992112a39
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0029.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB4708
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org



On 10/18/21 10:20, Shubhrajyoti Datta wrote:
> Update the default number of uarts.
> The commit b44b96a060f3 changed the default from 16 to 1 change it back to 16.
> 
> Fixes: b44b96a060f3 (uartlite: Adding a kernel parameter for the number of uartlites)
> 
> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> ---
>   drivers/tty/serial/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> index 131a6a587acd..1254b523ca9a 100644
> --- a/drivers/tty/serial/Kconfig
> +++ b/drivers/tty/serial/Kconfig
> @@ -531,7 +531,7 @@ config SERIAL_UARTLITE_NR_UARTS
>   	int "Maximum number of uartlite serial ports"
>   	depends on SERIAL_UARTLITE
>   	range 1 256
> -	default 1
> +	default 16
>   	help
>   	  Set this to the number of uartlites in your system, or the number
>   	  you think you might implement.
> 

Reviewed-by: Michal Simek <michal.simek@xilinx.com>

Thanks,
Michal
