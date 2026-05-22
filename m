Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011027.outbound.protection.outlook.com [40.93.194.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0AAE39EF12;
	Fri, 22 May 2026 08:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779438498; cv=fail; b=plTWk6HOnNjERFtj7DvCAfT8e3leWKiOBS+QvCUONQg8Fctj0SirRB4W9PFtwW0ZG7ZODN4oMw1yAxL7WVXpFObkSA9I0OUZGa4Fgbb5MM19ovE3PrgQQRY2VnnwJDbmPsZO1Em7KAREQ3U1l4IIGHZaJXL5i4NeH3QUvhTo0mc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779438498; c=relaxed/simple;
	bh=S+YLWclC57P1vbjxaiYYVuqOMCXqd3QAJ29s9RqM6ls=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=CA2LCRlX42I3bv6ZQWOQFPpGUOlAACRGK2nWcOBW/2ta/HMCqvpjcnKrTl+60VgZNwfKAZVrJmlTULfVYpGjha5xNmNqv2JV+Yy549r6kR5qtIPlbgFpRYwcRqi+ynH1D/zVFg/iP9XWo7Qys/LCX77s0ANbF4AxielgsjCOg44=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=tWaf3r8y; arc=fail smtp.client-ip=40.93.194.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="tWaf3r8y"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lLt6M9Ubif+G280IUmkJU0tRugcKztLvyAC/Pu11s7kYsKvzmSE/WmLalho0TZnR8wkR1Q+jRr2aCuFdH5QJpDYPvf0ov9vtQNA0WsOP5MmdouOfBmiw+Ly5/3R+IUETWg995a1UuHYhajd8/iCp+Red592kINqnY4Pf+D9DI5OkP64IFSvvLvLmg76CfTqtVD+FVO8JStd5JAj7Z1MZ5lO0NWQhCVOpZAziDqTt2HQGl04WOKVw7WV6SQ0JYbnw/8ER51sGxgfT8xCNggtETHhdH205F6ZN04MToqNB/7OrC40ibW2pv+uazAdFq/VUJR3MIkMDJzEKOE3JFJutEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aP79bOUixhWkutN9kfjjtnFGpmv1dh5HVpMQBCciKag=;
 b=oOOO3/cazNj/RlRL6Suul31q0FeCQWw89kX14WCsSoLGjb/ov02I4iopG79vbhO5A9DXb0XCuPT4IMax29miRZXaeQRxzEkPM4L/p85MD9Ix9c98OQ/+KeNsnc1BWLMl7WP1EUQ3UsBd2EsKudr8BttbG1AZlhyUPKAwC2We1g5O9y/3Irb2tJt8/gsWYPKYqQKDEf+N/wO2RDqkKJaicZtcquEpKe8L+pX3bfOQ09BjnzZYPfU4npNcJuuSTzzqanqvISN5PAPB4FqR+EqbwpEgKns5KhsdYkgVanEXLLvgo+BVW/TSzs22kyGKBLrZAQMaX0wxO4RRg8BYW7TsaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aP79bOUixhWkutN9kfjjtnFGpmv1dh5HVpMQBCciKag=;
 b=tWaf3r8yLDbLOxVjbR1+ufCPY+JELfyM/D3m6RiB/nWYfmeMvz9N0p4P9XUUOMM99gegdskM9ooPMVBavaq74Bsk2l7iRNhj7UVbLsQ1Kcvk4C4qwPP4344x9JRqdiK7bMmG/Emveq+/qkefP5FcyMu3zICQqX+01XhG84VsVxQ=
Received: from BLAPR03CA0168.namprd03.prod.outlook.com (2603:10b6:208:32f::6)
 by BN0PR10MB5112.namprd10.prod.outlook.com (2603:10b6:408:12c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Fri, 22 May
 2026 08:28:14 +0000
Received: from BL6PEPF0001AB54.namprd02.prod.outlook.com
 (2603:10b6:208:32f:cafe::c6) by BLAPR03CA0168.outlook.office365.com
 (2603:10b6:208:32f::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.17 via Frontend Transport; Fri, 22
 May 2026 08:28:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BL6PEPF0001AB54.mail.protection.outlook.com (10.167.241.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Fri, 22 May 2026 08:28:13 +0000
Received: from DFLE206.ent.ti.com (10.64.6.64) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 22 May
 2026 03:28:11 -0500
Received: from DFLE202.ent.ti.com (10.64.6.60) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 22 May
 2026 03:28:11 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE202.ent.ti.com
 (10.64.6.60) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Fri, 22 May 2026 03:28:11 -0500
Received: from [10.24.50.20] (moteen-ubuntu-desk.dhcp.ti.com [10.24.50.20])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 64M8S8jg1637290;
	Fri, 22 May 2026 03:28:09 -0500
Message-ID: <ab76b900-6d1c-4218-a14a-59541b92f2c6@ti.com>
Date: Fri, 22 May 2026 13:58:08 +0530
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB54:EE_|BN0PR10MB5112:EE_
X-MS-Office365-Filtering-Correlation-Id: c77126ba-5c09-4ddf-bdb9-08deb7dc1099
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700016|1800799024|6133799003|4143699003|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	62elQDNpMLrSEhwaxSeq3xsk06V18q2cY6dXUx1v56smI843LYb5fS0qnH7IPGLaQYw+26Hjuz8TXTNGazgCdu0zVO3L8j493qBzEe+97f6ZukTT6DEwz2Ye66QPUtHssnAxP1h/PSnIUOeSPONFjrNDim95scQ1b7L8zX84Osvjy2LrFv0xQfvkffp4+swqqKp7x9GOx3vR8NUEK4nqdO3EKWzIejEmWAfbWgt0OY8ihf/xLXKwHHw2M67h8JvNx1JSY2ymf7e8nsphAA6dU9py2UB+MT2iEMqBQXbjO2bs5eOHSzft/OAlfKzh6rxUYsRfRwitm+J1gAj7BLl8cqxVclJwlBl7p3rFLDYiTf+m06DsjgpUVjEHCKzjN0QN7yE4fW9CLGLeELv+SCYANjUdkRBMjXgmJSgCj2bn04UJqQbGTHjGvlucX4bPQUiE5062gXPa6iWMvM4k9fVDDjh8KqX8zFCOar0v7NmgKdziIz4uf1/XGbqPeg8q4A7ShKP0HGkc4X2ah2p9GLDEu40yH647dpxuvJDmQfaLGhClUBvbYkooNs79ltDx4SoGaXhkfZXe5gk7DnwtHL9Pt35WgKMICAawEsVYscg5kxWtQ9Oz/cLWaibwW02opyMpudHDihSrFEL11le73eEypdpt2CDfiqF1EjNkiCjL1capKvktR/40c6ulknSqFiz90UxJCbybUFp1LCBzu1bsTJ6KO1/AC1DO/DMVqOLoEK0=
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(6133799003)(4143699003)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	tNoaWftEcipGGTj3eisQmaYXMCl8XcSz8+p3J6GSji0bQYrzNAmgn/OIBwQbag5tsOpfaztDWblpuU+9aVHlE24PCcfWfl56HtWuxXkzbGULyhZDLk159WWw7wMP0prIYa22Q/1qWY6nBj0HmLXIgBh4pdksXsw2Ajdzc/7INpqGeBqF3WuXchYciaDdQ05C/s0VSD2Np4cd5V22o1hftXTOkaexbZotGoBirB6gpA2cXGQ3CptCMWpI0Xm5Yf8NBX8QAqFb+dvj2H14zhRSAxe49H/uWU7aPrGyN1cIa5cDXFmIihWlMr/Hnpp8srcVBF95FWv2Fs4vYyXn0pzrPKoBDTO6aEeZOFXrpxan/2zhhdErHtati8U8eYs6aNVodWz2UspyNNlbSiwTyJuEojruisdhdQuFXXwlfho9HoWOXhKsLhc7lZnm7gqkI6Oj
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2026 08:28:13.1225
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c77126ba-5c09-4ddf-bdb9-08deb7dc1099
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB54.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5112


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

Just a nit pick here: I think the "Changes in v2:" line should come 
below the tear line(---) after signed-off-by.
Code wise LGTM.

Regards,
Moteen
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
