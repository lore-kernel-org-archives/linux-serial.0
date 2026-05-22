Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013012.outbound.protection.outlook.com [40.93.201.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9519C39DBDD;
	Fri, 22 May 2026 05:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779428429; cv=fail; b=u4rILdmIxq75nn9JtOauid63bYF0uE7VYwxMAT0GuyOWO+UBuy/aScMdDzBYslvmYWVkXhFuq8uSOBHPdPttr4RMl2oY6qFYplRCkcjYSYJfIYcYU3xMNTRRDMnFc4B6GmQXRAH0m0ZtGCpTq96AcDH32J80utnoks731cjirMg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779428429; c=relaxed/simple;
	bh=WsLTcOn1krA735uEnyNprP5j1YJK88BzLXeW+elJO5M=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=J6QtWNioyMuPI1MOAdGwbqGBl820K/LqeGcsq+x3qIoPthjbUgK4SxEfGTGJeulvattcPvrEsBFDhY9X/05Njw5IHuTkUdr1ssvhyj3uTxq0YPZ+nBOWTv5LH0fu63Cz/24bbkhiuZ9GQpjmnLxS6en0JHRg5aUvx2JDWvjgPt0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=tRrqQS8G; arc=fail smtp.client-ip=40.93.201.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="tRrqQS8G"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bCbX/oHdrgLSgZE4h6rLTkqivmsQxfLAPA1QAeKsm5Maq1Lg4nRbWYqG9XTkR47yfatlTbVz944TxBJvPQg/pNCZUTdIgGU923TsvpfxySAO1TkhbUIM27u+WcWds3bjKcEofw9I/B2ELrRzxQemBlQhI2c+CSBv3G73cSHe8fI6uQKtnEJwXmS8kPMX9owUHlUsBi+AnX8jDqsIG/Y9FupfBXFnuZ0TXtboEj+eNNZcU7vNqVQIlDM/6JsgRjUdm43I6cg0cYrwGo6AcMIEAJBbw04EBI/qTnziB7r6jkuEqJBN+CQdOttQzqb5D2H7tAODRzkoZYoXU4a1GTS/eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W+YFF9i7AMr+ujofdeqowfmLmLYfr5QAbAgs7ZshWeM=;
 b=Gwsk4iyDCmj85XsuQqvr/YN0rLvKod6CjETRgxUm9/7HNQx4WDzRQvQrIf4Solg5vSTtm4Cv5zg/Q01T1jHdx8Y6nQFg0Dar/sl3Ck7s+UOyKqC/8nNBGU7eEm0iw80rZfbaBci2ChwTEb9AwMd3PVEYwgCdvlGl6C3A+Ddo1SCUv0SqEgXj8sNU8vDvb+2wVyUkksbL+Qy5YaKzrF1qilnZ15RMJMfAkttAYJRnhxBGztAn+q+Ogl6mj4ZI8Ku6ep/rKc7v6/vgHqNnXorUxyv0EMnqFRTZG1yOHDQWjpmZR9Za2w153gU1RLqYws7az6LFIxEOoUV2wUVlt6xuFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W+YFF9i7AMr+ujofdeqowfmLmLYfr5QAbAgs7ZshWeM=;
 b=tRrqQS8Gy84pdsq6X2b6RHo8yyq7dg9gRER95nJy3Gm2T8B8jRB8FV8IGjNBGZeFmNgVq3+aXcqXKbfs6o45ijSWhg3o8IwYoYvbzdCLivZ+JwHxEDiuP4K79ltUwO4CjNHEeKUsSFMWveHVlXGd5Cy7Ukx7or+tVKuNRQb35ac=
Received: from SJ0PR05CA0132.namprd05.prod.outlook.com (2603:10b6:a03:33d::17)
 by LV3PR10MB7913.namprd10.prod.outlook.com (2603:10b6:408:20f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Fri, 22 May
 2026 05:40:24 +0000
Received: from SJ1PEPF00002311.namprd03.prod.outlook.com
 (2603:10b6:a03:33d:cafe::2b) by SJ0PR05CA0132.outlook.office365.com
 (2603:10b6:a03:33d::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.15 via Frontend Transport; Fri, 22
 May 2026 05:40:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SJ1PEPF00002311.mail.protection.outlook.com (10.167.242.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Fri, 22 May 2026 05:40:22 +0000
Received: from DFLE207.ent.ti.com (10.64.6.65) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 22 May
 2026 00:40:16 -0500
Received: from DFLE214.ent.ti.com (10.64.6.72) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 22 May
 2026 00:40:16 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Fri, 22 May 2026 00:40:16 -0500
Received: from [10.24.50.20] (moteen-ubuntu-desk.dhcp.ti.com [10.24.50.20])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 64M5eDph843356;
	Fri, 22 May 2026 00:40:14 -0500
Message-ID: <4b8c59fe-c6a1-47cb-ab3b-855b1edddde2@ti.com>
Date: Fri, 22 May 2026 11:10:12 +0530
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] serial: 8250_omap: clear rx_running on zero-length DMA
 completes
To: Matthias Feser <mfe@KBSgmbhfr.onmicrosoft.com>,
	"linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"jirislaby@kernel.org" <jirislaby@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"k-willis@ti.com" <k-willis@ti.com>, "msp@baylibre.com" <msp@baylibre.com>,
	"andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>
References: <BE3P281MB5515563BFB5DE5E093ADAD9DEE0E2@BE3P281MB5515.DEUP281.PROD.OUTLOOK.COM>
Content-Language: en-US
From: Moteen Shah <m-shah@ti.com>
In-Reply-To: <BE3P281MB5515563BFB5DE5E093ADAD9DEE0E2@BE3P281MB5515.DEUP281.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002311:EE_|LV3PR10MB7913:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c4a0142-b179-40ac-9677-08deb7c49e19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|376014|82310400026|6133799003|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	XXstSbsJ28CThKOzzJBE3GCnHI7aZ655jX9FULiePGll7vuFhR5kL0oY/UmmaQig/Jyr4IlfdP7GgNeIaIg+mw1BxMq+a/nhPaK89I780S6trJ64wWEHcHmV21V1+cjZKd/TdI9FBLzlqwgHP8ABjU38i9IFf+6hX1GuklZcH6hDdjR40JgDv/vMKC15Y8ZkpMouziS6dAmtd4CZHNu4KC7vTq4bWwfnlQHGxRogfUJ3UEGvGbpo13fkx+iVwdZwBNG5Mhv0cPq1jPHaQYn63yOQkx9IVyRVDQ8TExp98EkmRiewjTze2We6nw5CBLAmrrcbmsYVfCv6Kz96Wo6Wu0mFbqPP3iq5btMgxI+T+NzflTZbpm8N5fzixnvzrOErb6dyCZEJlJj0pIuSSEbGpv/3YyCuPa9Re2ERkRNgjIjLJrWsvryNxkAA5u9GIftnNdhnl2jcgwl1uIfESe/soMg8+ZjcwNW217qPv7FmLD71D4Fby1QqJS0BbYtiUL/lA2dEBCfkiaQ0nHYhIn5bXGxbChXeuBZ7h7lgs4cMEzVIpMH28CJtNe8SOdOsZoia/crU8CiK2nWYldQo2dBlLz/Q5OCmyniuyMbuoqhlHB9k7eKn0c3bHY4WZUnTdYJrs+uJH/Ew73f9K06OViiOeaubE93TpxefM0mEOZf1uwX4lr2TPOUMh7ZBfAsW9gon3irvWnZZTaZu0ZqMDlNCsCrEcZaDShVJlEG3CidvBz8=
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(6133799003)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	GsJdeKGHECsbd5sLZvbT+ohp2e7fUEAMkvUSe/MJddAcVcm54RMPjPYxadBAUq9EYE1oQQFlEAQBamBRnSeWAjfdYVzMS8GbXMSclRFGOd7JiOKgRIa6uyTEnjAZDYU1Xy47rZ+eeLkRZcTylUx4Y/HzwNONe6lKjwrFSaq9tcJaeQUbUNdILEWUmBGbbWRZdDbMV1uB2TSbitYxe2btaCiDb11S1jYVyaSvB3UWBAQJGZbKW0LYdqbpbf/MCH/0xV+xxFcqCDKR1w2PX5pbmzO2iPwVmZOBsj+mZyvqDw+aLbufc3/QzN9Ey+S4JOR+3v2TjkZepumwT00G0muKIvoaQT6CU3hNf3JVqKdm/J0QSnMA4HLWkJIoOP0V2x3VobJZm1jSBze8Du4u50AYYTQizklg5UqKzxZ942EOUQl3Do+MUMN7mt0UnNL2UDZT
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2026 05:40:22.5842
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c4a0142-b179-40ac-9677-08deb7c49e19
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002311.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7913

Hey Matthias,
Thanks for the patch.

On 21/05/26 19:00, Matthias Feser wrote:
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
> Fix this by always clearing dma->rx_running on exit.
>
> Signed-off-by: Matthias Feser <mfe@KBSgmbhfr.onmicrosoft.com>
> ---
>   drivers/tty/serial/8250/8250_omap.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
> index c552c6b9a037..686e54859aa5 100644
> --- a/drivers/tty/serial/8250/8250_omap.c
> +++ b/drivers/tty/serial/8250/8250_omap.c
> @@ -948,11 +948,11 @@ static void __dma_rx_do_complete(struct uart_8250_port *p)
>   		goto out;
>   	ret = tty_insert_flip_string(tty_port, dma->rx_buf, count);
>   
> -	dma->rx_running = 0;
>   	p->port.icount.rx += ret;
>   	p->port.icount.buf_overrun += count - ret;
>   out:
>   
> +	dma->rx_running = 0;
>   	tty_flip_buffer_push(tty_port);
>   }
>   

I think the better place should be just before the If(!count) check, 
this would mark the running status of the DMA as soon as the termination 
gets done.

Regards,
Moteen

