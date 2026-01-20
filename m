Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010005.outbound.protection.outlook.com [40.93.198.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95CF92EACEF;
	Tue, 20 Jan 2026 05:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768886336; cv=fail; b=rV0xTgl5AEPi7PCqP6OKeChZ+qegon50giKNLWmYyt7e8VFsaSm0iOSYY2y2pkPsL1gWlOSHWGMc2NP8zaVfufCxSUQDxjdm6Ov4g4YKR/ai99KP2bz/AS2i6Kdn0hPlaB4eNvGEVXGFCK8Z3R1VqLh9vPPu4WbzX16XJ6vHz+g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768886336; c=relaxed/simple;
	bh=PDROZ5PsJRADFjPZcuu9skcp0SNO9NVQaiqRAlAZ1WA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=pGF560cla5kFsbUcHCuAouQHRiXBAf4y9WTblTe1XRi/VzXf9Bz8d5kQsYqCB2x7pmkhaLdlrhiv46a+D8mV3yegnHz8D/Nw0r/LiF2ghaXi/3IPuoyNefn98FuidSt0shIXer2AsrTai0bdEYj06aJkR8zBf5MLtFLxn25ccIs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Md8jfR+U; arc=fail smtp.client-ip=40.93.198.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Md8jfR+U"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GItIG8U+WFggIwBGHv9dCE1YAb/pVvlmQxlIA2EQTXOOX+4U3T41atyeEtYXXj/Hqs05Vg0gXw3uJh51oXKl0b3HPU335UwFYlu8RmDQxOLEKClImxReUhkmi0W1/LWjokA+wR+ZnkOOSKhLxneoinEC1OnfYeoepudE0STCcj9TLvMqoWOggp5DOIbdQWISOw5EPAB7Z5Nic6BuYHsDdjGic8UwvatAUXxoTsGEhcZcse3VD9JBg7J4710EIoCbFDH3rtaeo52jeFV7XqlHbQElhYN69bl1Ssv/REQRGxGb0UYvoKwIF1NVA4x1pvovMiZjceypNkBzAPvt5z4cvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wPM8jt7cTfXFiRVjLvsnRxKwWS6H0udt0rpaR/DpIw4=;
 b=U5ixMac0/gWc0XqPdHTZm4pDf6i/2a+x7dIVP/UhybA1o68lWGQC93AfsWD+YqV8n30IyfpJqONqyTMabs9UqmFIB7zfJlJiPRisb8tUwZCt9MbFkxuyAPNMI3Gi1QPUaJuhVhQlg299BluJpODOOI56SlaQqycT7UEKRg29Is3C2RlQhH/h2CS44lMqQiEb0MzWMSvA/IvMg7y0DM3KzgiP8Yu8S1I/VtY8PtcSKvHmIaYatHLbjZ6X8Q7Kk+73ZIoxf/VzS5CG4379BkGkmqM0SDSv4If7AHOMVTCah2DYk+1ySYz+wojxo6drnbklRU3OAfs5fN4J3042YufdQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wPM8jt7cTfXFiRVjLvsnRxKwWS6H0udt0rpaR/DpIw4=;
 b=Md8jfR+UNVz8Byh6bPe47OPyhz0ljfaOdTlfMO6bvsYdHbZ0QOQqn9gd8awE6A2OR0JOiYDiUX5RYJowP58+SOa34MO7G1J1en5Ojf0VWQ9lq1lMf/rKw0OA4LgvGmhvGH9KYqK7MXL1Hur7Gt2JiUpVGvyGhIIq5wsKLwqlEzc=
Received: from CH2PR14CA0034.namprd14.prod.outlook.com (2603:10b6:610:56::14)
 by CY5PR10MB6045.namprd10.prod.outlook.com (2603:10b6:930:3e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Tue, 20 Jan
 2026 05:18:52 +0000
Received: from CH3PEPF00000013.namprd21.prod.outlook.com
 (2603:10b6:610:56:cafe::5f) by CH2PR14CA0034.outlook.office365.com
 (2603:10b6:610:56::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.12 via Frontend Transport; Tue,
 20 Jan 2026 05:18:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 CH3PEPF00000013.mail.protection.outlook.com (10.167.244.118) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.0 via Frontend Transport; Tue, 20 Jan 2026 05:18:52 +0000
Received: from DLEE203.ent.ti.com (157.170.170.78) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 19 Jan
 2026 23:18:50 -0600
Received: from DLEE212.ent.ti.com (157.170.170.114) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 19 Jan
 2026 23:18:49 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE212.ent.ti.com
 (157.170.170.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 19 Jan 2026 23:18:49 -0600
Received: from [172.24.21.248] (lt5cd2489kgj.dhcp.ti.com [172.24.21.248])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60K5IkBW499346;
	Mon, 19 Jan 2026 23:18:46 -0600
Message-ID: <0462fd91-54b8-4ceb-a623-80326e6ce658@ti.com>
Date: Tue, 20 Jan 2026 10:48:45 +0530
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] serial: 8250: 8250_omap.c: Clear DMA RX running
 status only after DMA termination is done
To: Moteen Shah <m-shah@ti.com>, <gregkh@linuxfoundation.org>,
	<jirislaby@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
	<vigneshr@ti.com>, <gehariprasath@ti.com>, <g-praveen@ti.com>,
	<j-keerthy@ti.com>, <u-kumar1@ti.com>
References: <20260112081829.63049-1-m-shah@ti.com>
 <20260112081829.63049-3-m-shah@ti.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20260112081829.63049-3-m-shah@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000013:EE_|CY5PR10MB6045:EE_
X-MS-Office365-Filtering-Correlation-Id: 00de504c-6570-4a65-5ac2-08de57e36689
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z1FzeEFSUEU3Vk8xSTl1V0N2bDRXMFcxN3Q5UTh0WDRzVloycjN4Wnl5Q1Z3?=
 =?utf-8?B?VEhTbFZtcXFCWCs5WjRhb0tSWFNPOXg3cVVpbHgva0ZPU1VZUWw3MDFNZlgx?=
 =?utf-8?B?NTVndGFsVWRqMEpWckR5ZlNud3JvTnUvMURRYVRHeFlYanBEWldmeG1heHZh?=
 =?utf-8?B?Z1JHZ0lkSmowWllZVE5HTGNSUTZUcGFjVCtBeHRycnc1M0EwWGRwREg4dm56?=
 =?utf-8?B?NEEwa2ZWQnc1ajhydTFZbkFDcTI5R3YyTVZlRFdWTDFiZXVDRndLTGRSK0xY?=
 =?utf-8?B?dEUyUFRaTVpsY2tXNmJ1Ui9UR09vZ21SUGx2YjVIVlpHcGJTTkxLUW5KRmsr?=
 =?utf-8?B?blVObkFDSnZscnZPMmg1clJUU2l4OXpkUCtIcWdqVmpuQy80Mkk3NE1ENHA1?=
 =?utf-8?B?MElVUU9ySDNpbnlMVkNZUHVURWJmckY2bDEwajlId2grRzFnNEtpRTNPU0Qv?=
 =?utf-8?B?ZVRwNlFtbmZPcmFGWE1Hd1dYcVJha20rY05GUEswZUV6aDFOSUxPbXlWRGlZ?=
 =?utf-8?B?MFY5U1JUZ212YUtDTzV4eUUxbHhseWkvYzZ1aXlENGR0WllXWUtFOE9MTmxW?=
 =?utf-8?B?STNDZEp2TENBbzRlWXZGRFlMb1dlWE1hc2JLQ1N3eDA3dS9mVDY2TUhubWsv?=
 =?utf-8?B?RmVGNy9qb3NCWTRoTDFnNkdMK1hseTlLaHdVVlVHcmd6WTVDUG43S1VvNGxt?=
 =?utf-8?B?MmlVQnhEYnllb0RQdE1Oa3dJL2NBWE04ZTZ4am1VbFh6cGozZmhkampGU3ZH?=
 =?utf-8?B?N1U2NjZoVXp1cVY5V0lWQVJKY0dhQThOclVRNlkySVlxU1EwaXEvVk8wSjlE?=
 =?utf-8?B?YUtXOGREWEdETGRsM3lnand2K0xoeEZ5enhVNHhQNXhBRkxJaGxjUUF6SVpp?=
 =?utf-8?B?U3RTbGlDR0ZPdzM5R1pYZmtGU0VDQXZwSUlHOGVWa1lyRU5lRDJxY0tVN2F6?=
 =?utf-8?B?OCtaZXhTNmc2MGJiQ2craWhIelhsMVlmelJIVDRTcXRBZWovcDJJMXBBU08r?=
 =?utf-8?B?Nnl0L01TVHdubkFPcHd6cVZJN2cxc3lhK3pKQnN1T0x5cE13SjlmcHF2YUJF?=
 =?utf-8?B?THM1WHZ5ZC9TcUxIUHJIVHpXTUY5R2tqNnBmclQ1b0VsdndPcVJMMUlQSkZT?=
 =?utf-8?B?Zk9KOHpXNEMzNHBPZklGejNaNDkyN2VCdlQ4WHFSZnVGSDlSRi84WVVyM1Iv?=
 =?utf-8?B?QkdjNFpncGRkb2pUSnhTc2RScy9rSzdXUWU2bDZ5MkE4QXBuNHJMMlJjNkNF?=
 =?utf-8?B?eGptam1kSE5VbTBLQldPVDk4ZmJuandiVm1QbkFpdmdkUHJHMnB3ZGo3Ump3?=
 =?utf-8?B?STdmVWFQLzF1Tk1LVGZkVDN1L3ZmVy9ZUEMxWkxBVkwveXZRUEIvM2ZQMUo2?=
 =?utf-8?B?OTh3Lzh2S2ZmNHpJV3VXQzRPRVBxT1F2ekR1bUVQMWpYVG1LdGFUT0MvVnN6?=
 =?utf-8?B?T1gwUzVWQkZ1Mzc0UVJ3NTUrRVpxdmhHd1J5emUrRzVTbWNjMFYxbkVyTlZ5?=
 =?utf-8?B?MXI4aENDYXBHTXphVEJmVEJEQlFZclg3S042ZjUveStZOFNNYzNUNllrMU0w?=
 =?utf-8?B?R21HWGhJUy9SK0RnUnpOZms4MUt5VDAxd0xVeDdHWUF0RFVGVkorY0YvWnJL?=
 =?utf-8?B?aVo3NXVjYTFpTVlzdDE2VjMySWtwNGNvd3NxS2pBeGYwcklRVjJEaFEvblNI?=
 =?utf-8?B?U2xjUERPazJUc1JEczBBSVQwL2dkQVpuWmJTcEJiTzdpRjhZdzU5bXh5V0Zy?=
 =?utf-8?B?TEs2NWlmUk16OVM4bUNDaFUvNzBkV0srSHZvckFzOTRXazJnaG9SdzYzTXJU?=
 =?utf-8?B?VUlER1ZZU2s5OFNLcWFKTXpkSlB5TlFsUHdRM3BlODFoK01JVWdQR2VBdjBC?=
 =?utf-8?B?Qy9xLytDenRLcTFaRXlWUEVFV3B1Rkp6dE1Tb0Y5QzRHaWs1S3RCNy9DdERD?=
 =?utf-8?B?cXdBd3BzQTJEY0d6Z0xPcUlPcDZvR09QaUNtTG9YcDBML2syVUZQK1JBNFpR?=
 =?utf-8?B?cWVTZmVaeGJGelJKZjdaT2JaVlp0T0RjZE9FS1l4RCtwYWRCSUpsVUV4ellv?=
 =?utf-8?B?N2owWG82NElZRnIybVQ1NTdrL1RHYXAxdWFFMlppRTZlRW9rWGFzanNPMFNB?=
 =?utf-8?B?MFAwTG42TTJ6cU55N3BFZjlnSkRsVTM4K2F0WldEMWh3WFUwQjJ1c1ZmOXFu?=
 =?utf-8?B?WTBNT0VhUDcwVWtWQ3BzQmJ0cnFwQTBrMkJFNzRQQjc4YUhkTTM5NTlhL0wr?=
 =?utf-8?B?Y3FRckhya0ZqcXZtd25CMFhiVFZRPT0=?=
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 05:18:52.1587
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 00de504c-6570-4a65-5ac2-08de57e36689
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000013.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6045

Please check subject

git log drivers/tty/serial/8250/8250_omap.c

serial: 8250_omap: ....

On 1/12/2026 1:48 PM, Moteen Shah wrote:
> Clear rx_running flag only after DMA teardown polling completes. In the
> previous implementation the flag was being cleared while hardware teardown
hardware to DMA please,
> was still in progress, creating a mismatch between software state
> (flag = 0, "ready") and hardware state (still terminating).
>
> Signed-off-by: Moteen Shah <m-shah@ti.com>
> ---
>   drivers/tty/serial/8250/8250_omap.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
> index e26bae0a6488..272bc07c9a6b 100644
> --- a/drivers/tty/serial/8250/8250_omap.c
> +++ b/drivers/tty/serial/8250/8250_omap.c
> @@ -931,7 +931,6 @@ static void __dma_rx_do_complete(struct uart_8250_port *p)
>   		goto out;
>   
>   	cookie = dma->rx_cookie;
> -	dma->rx_running = 0;
>   
>   	/* Re-enable RX FIFO interrupt now that transfer is complete */
>   	if (priv->habit & UART_HAS_RHR_IT_DIS) {
> @@ -965,6 +964,7 @@ static void __dma_rx_do_complete(struct uart_8250_port *p)
>   		goto out;
>   	ret = tty_insert_flip_string(tty_port, dma->rx_buf, count);
>   
> +	dma->rx_running = 0;
>   	p->port.icount.rx += ret;
>   	p->port.icount.buf_overrun += count - ret;
>   out:
