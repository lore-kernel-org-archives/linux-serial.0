Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010007.outbound.protection.outlook.com [52.101.46.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29EA639EF12;
	Fri, 22 May 2026 08:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779438349; cv=fail; b=KMl7ZhoXKTdnP5vFv1j95vmBZISdmidgVFkzlFkUkbxf7i4HPblVb2434ZtLcOVflAD9hMwhz+Hhfu++KJi6On/d10F67e6kQ7b5yCC0Rwvjk6dMpzsm1x2m8//MmUjWj7H61bCdu8Y4qH0f1mtbzxfDKv0/L3tkYKRhW01T1sM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779438349; c=relaxed/simple;
	bh=7uqAEdJ0/NaZM7FkQx/ZBNpWmyjPzYetZ51zhmwb0WY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=bIjcGS677xACgGGQNjgivs8F8gg41K77cbj8ob5+jSDGnvSsl/B9yX5n2s3xjY5TRLLKm/2AThzsAu9HN8QvFjkdjyCPlrflzYxHArUPkRYjIb/d3Yyzxvg5LsPieB8IU5n+Jq5GKqB+Ey1LpSXzVR5tluIVGQ2pbJF1ME9gJYA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=FHzF1EvJ; arc=fail smtp.client-ip=52.101.46.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="FHzF1EvJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VVynmana/6hby+YyEDTWcdUIZTu8lldDnTzvSgM8eNoTl96PhIaffoMVrfDlglCpf7xw4dv2pOUiyH1NWEbELbdfNROYLji9hvTi7LNgoCsT2sKsyPK6PkL55Lfk8QFWr0cgxF6m/wpjfAhaZrcsHXqfmoRyMlD5PxpnsivtMg//se943LWuoHyDBRLLv8TD2SwIINR1XNDqpteUicP4N1mVsFd/PcGCJuE5C2S/emI8rcZVZ/xHJq9Laom562QmLurCSmIg47IrhN8OeJWjEK0Q8Mn/RQ9uO9ln9+obuu+R/6Rhj4UpDNc7jZpHGSXLx/EBN5PI0RvfiUKAiMnypA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tz4Eygoe6G8aSBTIjMAwVRZw8O2j7GmpqE/krRE1mYc=;
 b=MRk+HmWhqC1xv3ptJezLm0AiKHuvXzZMoX93ijCiqu6SqgzA+8glgC3zgAY1XyEsbPwjxtBw9bH1W1aqWOkJwFkuZ1USeh894AH47jtws8ZlW1C5TS3NStuRg/6QhrwlhVNqtm4bLCK0Q9AniRNUdFnipTKzIWwtkFll1dBpzTiQAvhxYmD2DiZDxNEyhlZgvzQ9Im3yKeG3Nb4Im4KG8uQnWYOu0qEPIa0YPdxxIqTVcTv6AsRe1xH1iLjscbMYXphEVMdvTSQgD1HrQti50VXPz6LNXy53YOY0eGPfMo/yoiuhRH2O1Ci8IzVkXuKWcMLkLKZKr33484D3GbIQSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tz4Eygoe6G8aSBTIjMAwVRZw8O2j7GmpqE/krRE1mYc=;
 b=FHzF1EvJurJCnG/7gbtYSEvME5xDUHVkvVWTZPHONpcf0tYwniwc66HZjPfWyTxZJly0UPa+U88vqivlNRmSAhkaR8pDql5mQ3PlgqJzcdaP5LA5SZr01oV8awQX9Ma+vqDgGjahArUtKKXmQQtoRCMbcc3U842fS9+3SuRdjPs=
Received: from BLAPR03CA0052.namprd03.prod.outlook.com (2603:10b6:208:32d::27)
 by SN4PR10MB5639.namprd10.prod.outlook.com (2603:10b6:806:20a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Fri, 22 May
 2026 08:25:44 +0000
Received: from BN2PEPF000044A8.namprd04.prod.outlook.com
 (2603:10b6:208:32d:cafe::7e) by BLAPR03CA0052.outlook.office365.com
 (2603:10b6:208:32d::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.16 via Frontend Transport; Fri, 22
 May 2026 08:25:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BN2PEPF000044A8.mail.protection.outlook.com (10.167.243.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Fri, 22 May 2026 08:25:44 +0000
Received: from DLEE206.ent.ti.com (157.170.170.90) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 22 May
 2026 03:25:43 -0500
Received: from DLEE209.ent.ti.com (157.170.170.98) by DLEE206.ent.ti.com
 (157.170.170.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 22 May
 2026 03:25:43 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE209.ent.ti.com
 (157.170.170.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Fri, 22 May 2026 03:25:43 -0500
Received: from [10.24.50.20] (moteen-ubuntu-desk.dhcp.ti.com [10.24.50.20])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 64M8Pe771098781;
	Fri, 22 May 2026 03:25:41 -0500
Message-ID: <79ab3c39-0650-43c7-81ed-8248c200ceff@ti.com>
Date: Fri, 22 May 2026 13:55:39 +0530
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] serial: 8250_omap: clear rx_running on zero-length DMA
 completes
To: Matthias Feser <mfe@KBSgmbhfr.onmicrosoft.com>,
	"linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"jirislaby@kernel.org" <jirislaby@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"k-willis@ti.com" <k-willis@ti.com>, "msp@baylibre.com" <msp@baylibre.com>,
	"andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>
References: <BE3P281MB5515563BFB5DE5E093ADAD9DEE0E2@BE3P281MB5515.DEUP281.PROD.OUTLOOK.COM>
 <4b8c59fe-c6a1-47cb-ab3b-855b1edddde2@ti.com>
 <BE3P281MB55153573889A8124C06291F1EE0F2@BE3P281MB5515.DEUP281.PROD.OUTLOOK.COM>
Content-Language: en-US
From: Moteen Shah <m-shah@ti.com>
In-Reply-To: <BE3P281MB55153573889A8124C06291F1EE0F2@BE3P281MB5515.DEUP281.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A8:EE_|SN4PR10MB5639:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e33cd1b-b810-46a0-d967-08deb7dbb7bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|376014|82310400026|18002099003|22082099003|56012099003|4143699003|6133799003;
X-Microsoft-Antispam-Message-Info:
	UeDzRKCL9YkRtpfn+fYh9JyC+DAMpeVaTwHTHFWg0WoPIGbpfLF+uNfPAqqNzWH4pbnMC0WkybG5UrjoCDAef8gjUZ7xcnPRttRBH5vKdjBuvOMUH0pK34p+Yzr2UXk+ce2ot0RoSixLejSMRNx10c/W1mLpmNmLT3K/Se/L9Uz+2ex1HISv9PMf8vu3+kmJ4kiLHRzkgRq5slLK3Pvlb6tL8nCBGzr4/J8Wmdb7Lb6FMcvD4w48stheJewY9RXx00fK6WIqwjoxFMtTNiQAtgdFoQ1igJKrMdMyh2GteSEeGOjCFalXWv9FfrkQ3lm3hwPuMaB24QGpDjDyVMkKbq6q/x6PZNPTFtfUradANe8eKY0zmkni7ZAGRCrg7p50SkrgTxWihsvF3Gw0w0xU9efR2vCl2H1NG97+X38/sIovGzBqOpggrV8voVgPb3Nfq/PGxDPrKQBeAW0wTP/JG1XNyghpw+o+OHu1cb4KfoCmzdEVoFWA8vWRJa2wof3CiCEFRNNknqRew1ARYZCZzfVHfhKFzyc3rYjZTZZHbTMZ9y103bPZi8Fw00uu5IOPx6XXGq/RCXO/5t2lBsHPwL+CrQE90FBGTA7RYUTW4nwqIho7a2wQ+zaxKUPJkR4t7HzMEJaiOlpooj/G/0LLRHtU+UTtGuN5rGWTHTjTPupPK1GK8cY3/tFqLUGVjJw2waM3Dxxv1fyoIJPAxpPqW5U60pafXCakiVcEyFnSNWs=
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(376014)(82310400026)(18002099003)(22082099003)(56012099003)(4143699003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	RB6W3h0fn1Z1cmpEjqtWE5MZz3uE+W0xCG/N++0X9P+aIhN8eWzHyq4FAhbkWdEymO/48aP3GlfN9TY6eE5stNsgQj62V0N6uXBYt2aLzC03irlIkw4dTrrvODer19WdDxFgYN06R78EMrGT7M/hJOi4vtupLTqD0pKJQVC5BRXLWc/pGcXgyzmwZWIZ0k70sA0aP68r7CZalb8fbp0fvPnB1yS3yftRxjneFjFlWNj2oxrxx6bGIj/4ZQVwsCKQLcaf4nOCf5pSyWtZHhWbJX708uBqO/qnS9ng3QmO+pPzaDV6bI3+ToSk1rcgwFJiNem7W3y9y02gk3kQtftGtAzpWHqJ+9xAq6Ko+mwlTOOmwInzyLTWaC52v2vSs1KuRH6rbX7VFguIYOdS9nWFvft3sJgbArPcDRp+sendnfIBWVUjNNX7kdrj+34Nimr5
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2026 08:25:44.0477
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e33cd1b-b810-46a0-d967-08deb7dbb7bf
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5639


On 22/05/26 13:54, Matthias Feser wrote:
> Thanks for the fast response. I've updated the patch accordingly.
>
> From: Matthias Feser <mfe@KBSgmbhfr.onmicrosoft.com>
> Date: Fri, 22 May 2026 10:11:16 +0200
> Subject: [PATCH v2] serial: 8250_omap: clear rx_running on zero-length DMA completes
>
> On AM33xx RX DMA only triggers when the FIFO reaches the
> configured threshold (typically 48 bytes). For smaller bursts
> no DMA request is issued and the FIFO is drained by RX timeout.
>
> In this case __dma_rx_do_complete() can legitimately see count == 0.
>
> The current code exits early in this case and does not clear
> dma->rx_running, leaving the DMA state inconsistent. This can
> prevent RX DMA from restarting and may cause
> omap_8250_rx_dma_flush() to fail, marking DMA as broken.
>
> Fix this by clearing dma->rx_running once the DMA transfer has
> completed or been terminated, even if no data was transferred.
>
> Changes in v2:
> - Move dma->rx_running clear before the count check so the state
>    is updated immediately after DMA completion/termination
>
> Signed-off-by: Matthias Feser <mfe@KBSgmbhfr.onmicrosoft.com>
> ---
>   drivers/tty/serial/8250/8250_omap.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
> index c552c6b9a037..76bc8ad324cb 100644
> --- a/drivers/tty/serial/8250/8250_omap.c
> +++ b/drivers/tty/serial/8250/8250_omap.c
> @@ -944,11 +944,11 @@ static void __dma_rx_do_complete(struct uart_8250_port *p)
>   				dev_err(p->port.dev, "teardown incomplete\n");
>   		}
>   	}
> +	dma->rx_running = 0;
>   	if (!count)
>   		goto out;
>   	ret = tty_insert_flip_string(tty_port, dma->rx_buf, count);
>   
> -	dma->rx_running = 0;
>   	p->port.icount.rx += ret;
>   	p->port.icount.buf_overrun += count - ret;
>   out:


Reviewed-by: Moteen Shah <m-shah@ti.com>

Regards,
Moteen

