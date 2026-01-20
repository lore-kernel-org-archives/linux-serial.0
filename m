Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012031.outbound.protection.outlook.com [52.101.43.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8025C363C51;
	Tue, 20 Jan 2026 05:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768886927; cv=fail; b=dJRJcGueBnLPy7yoLp28Bq6/F1O2nduVDEjU+mBp0vIHssTJCm/N4HcIFu67WvSM3AtNhWLw8Dr966kJ27SCc/qUct2d5ALsmkguQEJV0N7xME+Kd72+TGHgQ0J+U9/Pvq8ZC/WDgq+CW44okwnyoG3gRb4skTVUYux97ig4ino=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768886927; c=relaxed/simple;
	bh=GB+sx+gzAhiW2RnOQ2vsPYcIjmoci39rDi7SxDtXmCw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=CAGqkTX0mOWzhdD4WNxjkZG5WONu5iEcTc4tp2X8GqR1E6ziUYu8QteFweo7hngKeCI5Y8uPCHpkyD86Rqej6scBOVFd/e5m+kv/89bYTL4wHZPflE/PZoSy08mVz4GfERHuKhnklxP2AKIVx0w/KWeQKtxtxibqXQBF8Yqjduc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ZP7RgGmD; arc=fail smtp.client-ip=52.101.43.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ZP7RgGmD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QZnKvF+hveG84EBbuc8CCMYOskc0+a9kea5YqIbDvPlrx2mGbo7m7HOmwBe3Idl44mrGuIefXo4YkIeJm+p0KyTlQn7wSZpfQch+Feu8qu1wsSDVfxiqomt5fRSyBky6NDscmKNt4aN3o+Xo1KKUhBIMbuqP7Dl2bFnd2o29vcvzEfW13w+8TX+UbuSyuYM4pfyKVLPpxwGROMfnZqhYWvoaA3/Fhzz6KL8kJG7fr7o/xCQ0h99zamgWM7jELazInZb99W6v6HrxXRDnjY9SzfK2OJrL3KnIRhrbv3x+HtH12c65JUbocVwZO3gRDiSQbTv1ndq81Zy+ESoaiZkkoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zRutsHTcQKm+qrRnln/8LYzPbKanoJlP5uMNUN2QS1w=;
 b=nUJ0BLSJDSEPccwiZ2NvfVazZ7EanePfd5T6yrtQhWpmRPNCytE8SeRtL9nEy564sNP58I64i0OnNSV/Q7CdWYs3j9iCr0/6jRWTzeyxtaUcIA0nujE72oBaDxdYnM1anUlax9a3cQLq5OaWp/l52jI5fDT9hKe2EnXpU8y8JDLoxYFfAeg38ATL5e1AWINGvIiv1VoUtQg4Q7V10f9B79ZRF8xYuSKt3ScaFek06xg4b5q2Ta80L+Awe7wEccNVol6fZxQMX+KDdbq7VaZnbRkflo2w5Z2c4UU+pPySmX0+BDw+OTjqsqMfmDkSEZEOb/uLwYGZz03cqkhsH+CtKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zRutsHTcQKm+qrRnln/8LYzPbKanoJlP5uMNUN2QS1w=;
 b=ZP7RgGmDLegpZFGBO3hSaQEf5MYiCGfQF8GAQQzUO8s6O8GMmctBdq0E4dygYjv4u/GtNuwjkMOZvTWjfka+j+CL0ak4WgyI8ogJt4A7sgDDvfFi+3iWoq5daZ69WkZQilPVrXy2KPJAmBlkZPZm0yfqxlCTUmQPi2mdzhAt5kM=
Received: from SJ0PR13CA0035.namprd13.prod.outlook.com (2603:10b6:a03:2c2::10)
 by SJ5PPF4B2F62DBB.namprd10.prod.outlook.com (2603:10b6:a0f:fc02::79d) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Tue, 20 Jan
 2026 05:28:43 +0000
Received: from CO1PEPF000075EE.namprd03.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::94) by SJ0PR13CA0035.outlook.office365.com
 (2603:10b6:a03:2c2::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.8 via Frontend Transport; Tue,
 20 Jan 2026 05:28:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 CO1PEPF000075EE.mail.protection.outlook.com (10.167.249.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Tue, 20 Jan 2026 05:28:41 +0000
Received: from DFLE201.ent.ti.com (10.64.6.59) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 19 Jan
 2026 23:28:32 -0600
Received: from DFLE200.ent.ti.com (10.64.6.58) by DFLE201.ent.ti.com
 (10.64.6.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 19 Jan
 2026 23:28:32 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE200.ent.ti.com
 (10.64.6.58) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 19 Jan 2026 23:28:32 -0600
Received: from [172.24.21.248] (lt5cd2489kgj.dhcp.ti.com [172.24.21.248])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60K5SSKl510969;
	Mon, 19 Jan 2026 23:28:29 -0600
Message-ID: <21a85fdd-d462-48f5-b145-9eb7000bf96b@ti.com>
Date: Tue, 20 Jan 2026 10:58:27 +0530
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] serial: 8250: 8250_omap.c: Add support for handling
 UART error conditions
To: Moteen Shah <m-shah@ti.com>, <gregkh@linuxfoundation.org>,
	<jirislaby@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
	<vigneshr@ti.com>, <gehariprasath@ti.com>, <g-praveen@ti.com>,
	<j-keerthy@ti.com>, <u-kumar1@ti.com>
References: <20260112081829.63049-1-m-shah@ti.com>
 <20260112081829.63049-2-m-shah@ti.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20260112081829.63049-2-m-shah@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075EE:EE_|SJ5PPF4B2F62DBB:EE_
X-MS-Office365-Filtering-Correlation-Id: 25d02b33-d7d7-4404-6edc-08de57e4c593
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aVdvZlByaHRLL2xsdmlaYnkvZFY1Q1dBZ2MwWUl4a0VDVFhFZHlrZStjZkYr?=
 =?utf-8?B?U3JnNFlmYWsrQ2ZSTEFUaEYxUWJNSFB3UGJBWXNEeHBHOTZhU2hFdjRtRlhB?=
 =?utf-8?B?cHh6dTNHS1RIOERhZ2FOTzdMaXFLTjFXQnBTdHZzcjlzU3FVcG5OOWppVHNU?=
 =?utf-8?B?VEVFV0N2TXFIL2NkUC9mYmxlaVBxUWdpUnowaUpmRWkrdDVqaWliV3NrQWJY?=
 =?utf-8?B?Y0dGdEVLdnVOaWdrbndJbC9Zc0I5OE1GVDluNUxNU2dzMmU4QmFUTERKeE5k?=
 =?utf-8?B?ZVFFWklrL0dpdGxYM0h4V011b2JWdzhuQzB3NG9nUnV5SERJbFlMYmRDR0U1?=
 =?utf-8?B?dlFZY09FUzFZRzNLRUVkR0lZaTRGTEJkVE5rTTBoRFBMZCtHNXpnZ1JqbW8v?=
 =?utf-8?B?V1pBL3JuOHJ1TkRjeGZzblVpY3NobXNGbWxsT2hpSVhYMmVRUm5kOE5jS1hE?=
 =?utf-8?B?alYwdkNqaDRUeVZaZEpteTBpVnZmSkJoRXJONkl6MnhFaVdwTHc5SURGWWxq?=
 =?utf-8?B?aEp1dG45NUVMUnpqa2RRV3JLMVJnaFZkNWRsbjZWd3paT1VOa3BOYXd6Q0RC?=
 =?utf-8?B?a0w2NXJuSlRGUVplZWJsWWVDQm1KYTVaNjN2NnFKOXIrTFZzYzgwdVAydUUy?=
 =?utf-8?B?SkM2U29xaVlPeEs2Nmdva041S2VmTVhnSko2aHVla3hCNnFqbkRFK0tDeXUx?=
 =?utf-8?B?Ym91UkhZa25mUXZJWUJWVk9XQjIyZlN1ckkxYXhpNUlvTTlhMnk3UEYzeDF4?=
 =?utf-8?B?UHZ3bnpoYTdMWDYzbXhVQU1DMko1QW9ZNW5GdWMxd2pzenlBV3BuSzZNVUdH?=
 =?utf-8?B?RzJoaWZ6WWw1ZUJ3UHpFU2I2UVB2aTcxcDFqR3ZCMlpyOGNqOEpqWTJ3VE1r?=
 =?utf-8?B?TVZIZGtyVGMrdVFBMFh4a2xNNExCL2hzdXcrS29ZZVRveGpFWjhZWG9GVUVR?=
 =?utf-8?B?dTVCRS9PY29ITVJmVS9RWnJnM0pTZGgwalpHWm5nZEZQVEJjclNEbDZhNjZL?=
 =?utf-8?B?ZlBtMXcvQkE3ZHp3SGEvQno3Y3JtcEQ3U2wwOHNJVXhscjhJMm9xbWszeGhn?=
 =?utf-8?B?Z1lxVnRrL0FlZGlNcTZXOEN3bmJRbE9JSmZtOFUrVHVNUWwzRm51L2N3cjEv?=
 =?utf-8?B?d25UUTRYMy9vTVh4VVZEWHZId0dJY0VLUUp2eGtvRkFGSjFrOGxEQk40Ynkv?=
 =?utf-8?B?UVJ2ZndrRDVSRGljaVFqL1dFOVltdGFQcDVBUWl6Vmo0WFk5amh3NjhMd1dG?=
 =?utf-8?B?R2M5RU9CRFFsQnlZVnIwcUR3RG1TL3VqbDl5QWowbjRIWExRQ0JmUjNkR2Vv?=
 =?utf-8?B?cFF1ZUdkMGVwbVNtL0pGSXJmZ3Vwd2FiM2YzTEhRTlozVTNsV2pIS2hlMmU3?=
 =?utf-8?B?b3pKN3ZSeG03YnpzVHVwbytudWlTZWlLVkFnZzZ0VUlNWEw1RG0rV1FFV01H?=
 =?utf-8?B?VU5FK3Z3T0dHT29Ddm82MmpGYzhlQ3NKOEdPbTN4YzJKU3hNYXd6UVFoaEZO?=
 =?utf-8?B?eDVNMHptRjVMUXRBK0ZMMEo3QXhwaGdZUEZZMnJRYUwvY3h0Y2dOVUxXVDhR?=
 =?utf-8?B?NDE5elNsNzFScG0rczJNc1h1cERqT3RtMmtzUGhFVVN5TDRrZ1d5elJxMnRD?=
 =?utf-8?B?eWZCbnpJSHUvbEN2NjNGSWl2MTduRWRTQW5RaHRwR3R0VmdxK1RUZ2F2Z0or?=
 =?utf-8?B?bmtlcWU3NFJtSzEvaHl5L3J0dlp6alpLMDcrQ3dpUjM2Vm9GaVN2RUQ4UU9P?=
 =?utf-8?B?WUV3b09UZzlOL0tpc3NEaFpkVEdVSTdMME9qdWNsSUxpWmo0akNWT0xxWExp?=
 =?utf-8?B?dXVjdlhwVnlaUG0xcVNYN0NpMisraitmd3BqV1VoZlJRekNpdU1oTXF1Mnp2?=
 =?utf-8?B?OHMwWEZpQ29KVXp1RkpRMmJyaFZoNG1Ib3AvSnc3K0RSam5YYVR3Ly9neTln?=
 =?utf-8?B?b2VVRk9iY1VtMDJtNG1iN2tad0IzQ1oyZHlsNXBodFRPYmQ0NmpMN0pMcnN2?=
 =?utf-8?B?ZG00SnNVY3R3eDdueXpGaWFQQTdIMk14U1c2OTVkQVFxY3ZYOCtUcU0wQjhX?=
 =?utf-8?B?bHE0SkVUeE4reWJhSlBsaWZiSGJjRjBmeWZEbk01N0xnbHZ2TDlJb1huYTFp?=
 =?utf-8?B?eVRyb2NzK3pLK1hqWmt5cklzTlhFWk5CYnRrbVROb1F2bXgraXRhUGNDT1NX?=
 =?utf-8?B?NHJkZ2hLL0RjbGh1SU5lNDdlb1hWUWVsNkdyWnFxT1N1VkVBZnlDc3ZycDVF?=
 =?utf-8?B?NlBEY1RjUjVxa1VYQ3d3NDkybGtnPT0=?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 05:28:41.0836
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 25d02b33-d7d7-4404-6edc-08de57e4c593
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075EE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF4B2F62DBB

please check subject of patch

On 1/12/2026 1:48 PM, Moteen Shah wrote:
> The DMA IRQ handler does not accounts for the overrun(OE) or any other
accounts to account
> errors being reported by the IP before triggering a DMA transaction which
transaction, which
> leads to the interrupts not being handled resulting into an IRQ storm.
>
> The way to handle OE is to:
> 1. Reset the RX FIFO.
> 2. Read the UART_RESUME register, which clears the internal flag
>
> Earlier, the driver issued DMA transations even in case of OE which shouldn't

transations to transactions

> be done according to the OE handling mechanism mentioned above, as we are
> resetting the FIFO's, refer section: "12.1.6.4.8.1.3.6 Overrun During

FIFO's to FIFO

> Receive" [0].
>
> [0] https://www.ti.com/lit/pdf/spruiu1
>
> Signed-off-by: Moteen Shah <m-shah@ti.com>
> ---
>   drivers/tty/serial/8250/8250_omap.c | 23 +++++++++++++++++++++--
>   1 file changed, 21 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
> index 9e49ef48b851..e26bae0a6488 100644
> --- a/drivers/tty/serial/8250/8250_omap.c
> +++ b/drivers/tty/serial/8250/8250_omap.c
> @@ -100,6 +100,9 @@
>   #define OMAP_UART_REV_52 0x0502
>   #define OMAP_UART_REV_63 0x0603
>   
> +/* Resume register */
> +#define UART_OMAP_RESUME		0x0B
> +
>   /* Interrupt Enable Register 2 */
>   #define UART_OMAP_IER2			0x1B
>   #define UART_OMAP_IER2_RHR_IT_DIS	BIT(2)
> @@ -119,7 +122,6 @@
>   /* Timeout low and High */
>   #define UART_OMAP_TO_L                 0x26
>   #define UART_OMAP_TO_H                 0x27
> -
>   struct omap8250_priv {
>   	void __iomem *membase;
>   	int line;
> @@ -1256,6 +1258,20 @@ static u16 omap_8250_handle_rx_dma(struct uart_8250_port *up, u8 iir, u16 status
>   	return status;
>   }
>   
> +static void am654_8250_handle_uart_errors(struct uart_8250_port *up, u8 iir, u16 status)
> +{
> +	if (status & UART_LSR_OE) {
> +		serial8250_clear_and_reinit_fifos(up);
> +		serial_in(up, UART_LSR);
> +		serial_in(up, UART_OMAP_RESUME);
> +	} else {
> +		if (status & (UART_LSR_FE | UART_LSR_PE | UART_LSR_BI))
> +			serial_in(up, UART_RX);
> +		if (iir & UART_IIR_XOFF)
> +			serial_in(up, UART_IIR);
> +	}
> +}
> +
>   static void am654_8250_handle_rx_dma(struct uart_8250_port *up, u8 iir,
>   				     u16 status)
>   {
> @@ -1266,7 +1282,8 @@ static void am654_8250_handle_rx_dma(struct uart_8250_port *up, u8 iir,
>   	 * Queue a new transfer if FIFO has data.
>   	 */
>   	if ((status & (UART_LSR_DR | UART_LSR_BI)) &&
> -	    (up->ier & UART_IER_RDI)) {
> +	    (up->ier & UART_IER_RDI) && !(status & UART_LSR_OE)) {
> +		am654_8250_handle_uart_errors(up, iir, status);

may be you can think of splitting error handing into 2 functions ie 
handle BI or so and OE error.

when you call above function am654_8250_handle_uart_errors, first 
condition will be always false.


>   		omap_8250_rx_dma(up);
>   		serial_out(up, UART_OMAP_EFR2, UART_OMAP_EFR2_TIMEOUT_BEHAVE);
>   	} else if ((iir & 0x3f) == UART_IIR_RX_TIMEOUT) {
> @@ -1282,6 +1299,8 @@ static void am654_8250_handle_rx_dma(struct uart_8250_port *up, u8 iir,
>   		serial_out(up, UART_OMAP_EFR2, 0x0);
>   		up->ier |= UART_IER_RLSI | UART_IER_RDI;
>   		serial_out(up, UART_IER, up->ier);
> +	} else {
> +		am654_8250_handle_uart_errors(up, iir, status);

I assume , you will hit this else only case of OE ? , if yes then do you 
think, call to error handling should be conditional ?


>   	}
>   }
>   
