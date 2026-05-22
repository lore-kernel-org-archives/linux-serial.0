Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012003.outbound.protection.outlook.com [52.101.48.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941803CEBBD;
	Fri, 22 May 2026 10:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779445151; cv=fail; b=HJ3YDqLOqRaVnoTv9JzFXY8J3EA93lWNEsbzJJmDrLTio3b+4nEe3UxfaunAcAceaQ0RCEZVn6BsfomjwB/i65pP3c1U1CY4pLgfbjDoYqq9tEYgmITxq52V1sbItJaigBJVYGFnhmntb9mw7DXhPcwyFlKl1vbcuZdmVKjCMdI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779445151; c=relaxed/simple;
	bh=I2v50F6W6Vkl4Vgyygjs1+p/94BNmeRQ+GcPHpGc5F0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=punrJPVBqf6iB9A86YK3DiA1Rzx/WLrGxydZ7vPh/DRVY2slzMjFe3NpZTK2u4Wos9MAaXDglCPR1aQJpwnHmrSmQFXBrdQFHHMl+WVRL1+6wEuhDws//1KeN8bpMNU18X6i8lpRS52y/cqbFO2F6Xvmirrwy9lv8m9TyWp1MaI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=TinzeeiC; arc=fail smtp.client-ip=52.101.48.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="TinzeeiC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hduZ7RcDGs6Iw1nKESzooZ/A6HidqH89jSQpvftX5SFK69BQz8WXEYTLIbh+ADVJqdFB/zCjyVMpE24FQtwOXF+KegZ7gazIbSkh0u3x1dXoUpqsNQIKkN02Ruzzx8FQ/jRXtkqT5RHg3/MqyZ/vQy65rLUZxDvYdtQRDhjtSkoBJ6JWwslo1cfB8nR4CmH+mN4kTWsfiXmRFBUmydk3PiSXncjU2lSGuzn5HLKF2Qx7mgqTTdkxROiKACzsDAQiBoYFYZfYX1UzzLF9+NMwNRdjpNgL3FALXWdgY1d7eTjAMlLB5ggXp4XDwrom7dMf+aJ+9OGI/U/aKBgq63eOGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KaoDLVEBjiWqpYMojWtILYUc6ITO5ebl9f7ICc/LP2I=;
 b=Pba+I2rze3cX4npEcCYIquAblycMF2qaaem2MAsPFzwoVzFGm0jsaI8VSf74fJPd8+4k7BptKVCYFMNfoIEcmtDeN6vUjhuqDh2DoPA2LOGFEjVY3HuYSsPyfUA3jk6nl/Y6N56PMsU8jwtfPzy8Y2mM9Jy+baKq+5HHqIfRVnW8qFIbVKhm8nmqM9sScuJA9BAeETRoaKAQ5KEWPFNsRrvmtB1uUCzo3G+dSoelcKMrCmPkQOklzHIPHcYZjHv+xZ69PO3RxYGfYrdyTOsGXzzNbS9/tQkQiaRSLhG5UFUf2uX1Jbrs7iuiwJNH+nPaOZi35QjV0Ei2WU+ELidTjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KaoDLVEBjiWqpYMojWtILYUc6ITO5ebl9f7ICc/LP2I=;
 b=TinzeeiCYevS1yu63YEZyRSZ5lf0SBNaO4TIY209M7HnrPqAS9dWnJRiFKm6uO4QC1b1hL1UTuoeO7Mp1iFG3HbMJ9F2iyhW9JXLERZ9scKmfh9EzuR3ak7bpgb4b9rU64irBDoWiBJnzQemMuLlcd1/xrvJvC/O1LRq1hXK7Ak=
Received: from SN7PR18CA0022.namprd18.prod.outlook.com (2603:10b6:806:f3::21)
 by DS0PR10MB6150.namprd10.prod.outlook.com (2603:10b6:8:c6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Fri, 22 May
 2026 10:19:02 +0000
Received: from SN1PEPF0002529E.namprd05.prod.outlook.com
 (2603:10b6:806:f3:cafe::3) by SN7PR18CA0022.outlook.office365.com
 (2603:10b6:806:f3::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.17 via Frontend Transport; Fri, 22
 May 2026 10:19:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 SN1PEPF0002529E.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Fri, 22 May 2026 10:19:01 +0000
Received: from DLEE203.ent.ti.com (157.170.170.78) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 22 May
 2026 05:19:01 -0500
Received: from DLEE211.ent.ti.com (157.170.170.113) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 22 May
 2026 05:19:01 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE211.ent.ti.com
 (157.170.170.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Fri, 22 May 2026 05:19:01 -0500
Received: from [10.24.50.20] (moteen-ubuntu-desk.dhcp.ti.com [10.24.50.20])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 64MAIwV81269727;
	Fri, 22 May 2026 05:18:59 -0500
Message-ID: <ede98ffc-9e34-46a5-8d8f-87894fbf9d12@ti.com>
Date: Fri, 22 May 2026 15:48:58 +0530
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: AW: [PATCH v3] serial: 8250_omap: clear rx_running on zero-length
 DMA completes
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
 <ab76b900-6d1c-4218-a14a-59541b92f2c6@ti.com>
 <BE3P281MB5515A937D47F610974FAEFA7EE0F2@BE3P281MB5515.DEUP281.PROD.OUTLOOK.COM>
Content-Language: en-US
From: Moteen Shah <m-shah@ti.com>
In-Reply-To: <BE3P281MB5515A937D47F610974FAEFA7EE0F2@BE3P281MB5515.DEUP281.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529E:EE_|DS0PR10MB6150:EE_
X-MS-Office365-Filtering-Correlation-Id: 97d3d67e-8f7d-410f-fc2d-08deb7eb8b90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700016|1800799024|6133799003|4143699003|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	DZtiTUFVpZRFbI8D0F2afW5fVwc6GTZgbWo3CX1azasUm6nCyP75+yMBDKEINUiBIZk3Y1lgoI60Y2uXxXggPBryL8jxHJiWc2Kjl+40SgBwJcmaYHJfu6Sveqxwnusco2moAwSzY+qf4odv5CpysNonEIPnE797iugls+5uOlay+OPO+UMbmV8m7z6iTsyjzZUE/k9naHKUO2GVS3SDoW48ijdlOAIdqbHTuRUMrtH8lbZ0xoqRWe2MiUyUJ75wsribyrKNXQfdgwml3J+kIY8jYehI8JGfdI6ChCqyhb9AsQEX0ta2eNGB/njtSjA5K1rRR+kRpb/hnlK51CU7mLjGlnf1mWtsZnnVLSkt+TjXJTIyv0IKPZFSJVRMVQrNV4zEpgRhj9FhCOyz9/pF91rmSU6SFR4KZbFpGdCDgBetXWu9fKQmJU32b15eUQjnRQrB3cMX7RGUazSBeZ8drV5yzyrIhBcgfx8ROhbflS3WosMi5goZDSzErS/M3dbtXdRjg01SegM7CjVcMy/nkwfUZpbFL1xoH4y7Ylyfzqru5nSMa4dTIjNIjmoP36zfaBoE86EjrV4sgR7+qwZll4aQNlxX+zHEEAx2VUvXBW6xBQ23qxes2xXjI451f22XEOrecPmNgIl0XsXTvXjOo6wwmbdch+8NSy2haHlcFvhg1Kwv64vhss4Nv4UzplwNnc0nOEhkf61/DocITS6ONNf1oLH//MR1FRSTDsazNDY=
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(6133799003)(4143699003)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	69opUZismOE2uvCyA1c2vtWb7vNbZUt1yRSQD2kGyR574+escl/UFxL070pimM8z/QYIGHqwbEMTD09obJdycpj+P57UAMDt+oXMk/+hP0JVYo6wMkFqePJyQBqJbC1hy6ve1RgXWRmZc+dTMj/8QxnQgLB5dRt+QOi95aFkfV0hJp3IEHNkIuXG9XlJWeeGNnL96NS1kchsc+lXp2XDwsGyshCDZk2dfbUpQ4G4/usv0svgYkRG+022LhxH6b3Ylf0HekaMuQK5Q6L1QyKTQAHMTwNb7xMI+hUoAmHYbjXHpbrnwCZfzrXTqm176vXyUxICkf4L05KNCDpw/zyDVQLI6jWIVFHA9Lj5wwXWhM2g0eg9iFijx0L99debl0NN9eIXsz5IPGq1SmdTbY0z32TQBwIq5OtKEesrtiwP9zJqiRSq6FZvkPL66OTALGiA
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2026 10:19:01.9183
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 97d3d67e-8f7d-410f-fc2d-08deb7eb8b90
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002529E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6150


On 22/05/26 14:32, Matthias Feser wrote:
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
> Signed-off-by: Matthias Feser <mfe@KBSgmbhfr.onmicrosoft.com>
> ---
> Changes in v3:
> - Move "Changes in v2" below the tear line as suggested
>
> Changes in v2:
> - Move dma->rx_running clear before the count check so the state
>    is updated immediately after DMA completion/termination
>
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

Nit: Add a newline above dma->rx_running, I think checkpatch would have 
caught it.
With the above change:
Reviewed-by: Moteen Shah <m-shah@ti.com>

Please pick the tag up in the next version if you intend to make one.

Thanks and Regards,
Moteen

>   	if (!count)
>   		goto out;
>   	ret = tty_insert_flip_string(tty_port, dma->rx_buf, count);
>   
> -	dma->rx_running = 0;
>   	p->port.icount.rx += ret;
>   	p->port.icount.buf_overrun += count - ret;
>   out:

