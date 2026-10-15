Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011045.outbound.protection.outlook.com [52.101.65.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D093D331E;
	Thu, 15 Oct 2026 17:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792083933; cv=fail; b=mvIjivhDfLnVnLYCxo/oLbpR2kutf+sPseETiIDQ5WTa8xwmYfHPmSg/UGCZlqUfW0V6bneqWb2BnVmpY5gkE7LNsdr9Iy37SC9Rc0LjYGj2M8X8Hydw9jHplw5YL2EHVzbN0tzYAsZ4UdyIXcqEPFqNztmI/rP5UXxgKiCsjMY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792083933; c=relaxed/simple;
	bh=oGmdJOo5MK4yGMgvEKzSQ7eFKbE4PwIqRt8WM3NTYzY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GnUR98b2WKz6LGsjo59ZiRHkWz/VdsPVVxCbYZ3GSFF//Bcmm3g8Fkmg7JhptHiWfstNNznSmlP1qbshi6toZrAc5mNTHKHdWaDDFgi72bVam6LBih64sIL0u9JXLXosKEWju2z/Ve8EhaVEE+ThESW4yYMHE/zIhIeCi1sACuM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=fail (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=fGywqiZJ reason="signature verification failed"; arc=fail smtp.client-ip=52.101.65.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="fGywqiZJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UIaSmTNsMaeq7sziexDG9IM9nBhu5BuBQiX6SgWdYTge/VMOAAYY9ZfQqvO+5EvIrk3yN2Ixicntkkd3UIwQr/wObM0fBrZi5NQa/LILJWKzKM+J3/EcyKSCcxiLRe3ymkaHF/eSJU9JPT2wD38U9lnrP9gJRKGEN3u9HtACNZAm5hXpmeHnRKz7+lvIM40HkM0d4slHi9ghiW9TDzWCny2UmUuF/A5tYyFqJpmrgfIDL7nUzsUuPhw2Drx7ehmfF7Vv545lKCQcHVkR85WCxXKR4l1W+RGWs5H82RZp3FnhmQuR+rxVU1BF/W9r2kFiViT7p0EgYEYw8iKJLP/Ewg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hLpZzikgj0TZVTb6SdcIrE6u9MGOnIrp7Q3W19uWsPs=;
 b=H69n34AGxLHuL+VxPzK4g8hn4dd3us8be7PAnRb2dUPyE1fJw0vWJYLXiKEDcrrC6v2AF23oMFEmSU7jT+Gl4ZWbiInjsaWBMtqYbpTrZfBUbbndhuwnXB8V1eNu58H2wR2EfZGZrTkl+BlKCXl2xDX1oRN9VXZp32/+1RCD1uN7h/94c030R6ms+hJY3bvg5I1yZKJA2xfJZq+BlepCpvk7QqIwSU5M+F3uh6q7mmYO/syyHTjF33+MTjGAZNGKyKnEZD8FrKbXedJ1KIwSLL/MiJ4ltXI/lrVfRVero95aoeRWknd4CKUP9FX9rqh+EfMVJ35RCGP6MZfO/yxkkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hLpZzikgj0TZVTb6SdcIrE6u9MGOnIrp7Q3W19uWsPs=;
 b=fGywqiZJSQ+3h3/s0TPILNWKNY73sLMP4tsw9bClpMWqX+LkKCny2RVTOZ/kbBofwKazS86wB5ITNFEKUXhLaJLIdEE0C49/KuGkv3XdxhnyrXUSpgvMV1WaVcpnIoE4S/tElDHHKR3CNFeD3Uuf8s1eSsL15SAZ7YfPuMoMSaADoFA+CkSMKYZHJiwHtAEWlf5wWen9erUUNLVOgkyKpo+YOP/+PYZxSuJrvNaXTdCb3+DpGEZ2k5ot3ko4wSrD/kexY3P61yEW4GaYPfdZCRVgjlZYFAE+UnkNCSYdeTsvvMccXSz09vSAm2yfDt6UH5W/xyMaEcqWbvx3A/wDQg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by PAXPR04MB8734.eurprd04.prod.outlook.com (2603:10a6:102:21e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Thu, 15 Oct
 2026 17:05:19 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0522.012; Thu, 15 Oct 2026
 17:05:19 +0000
Date: Thu, 15 Oct 2026 13:05:11 -0400
From: Frank Li <Frank.li@oss.nxp.com>
To: sashiko-reviews@lists.linux.dev
Cc: Naresh Maramaina <naresh.maramaina@oss.qualcomm.com>,
	Frank.Li@kernel.org, dmaengine@vger.kernel.org,
	linux-serial@vger.kernel.org, vkoul@kernel.org
Subject: Re: [PATCH 4/4] tty: serial: qcom_geni_serial: Add GPI DMA support
Message-ID: <atEHx8p0bbJ0CsuB@lizhi-Precision-Tower-5810>
References: <20261009-add-gpi-dma-support-for-uart-v1-0-c69e728df686@oss.qualcomm.com>
 <20261009-add-gpi-dma-support-for-uart-v1-4-c69e728df686@oss.qualcomm.com>
 <sashiko-outbox-164979@kernel.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <sashiko-outbox-164979@kernel.org>
X-ClientProxiedBy: SJ0PR13CA0072.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::17) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|PAXPR04MB8734:EE_
X-MS-Office365-Filtering-Correlation-Id: 71401e56-8506-4d0c-d73c-08df2ade7dd3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|19092799006|56012099006|5023799004|4143699003|11063799006|261009223027099003|10067099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	GIAYFTm7z2DFLaR1RblTWIRKl5duSdcHU4qyRzU2a/bfDlAAciUvXfYg02q316LhY4pD3Cih1rySBryhD2Di7OGWLcXDIevyT3FLSHQhnPqzzXL58R4lSEMFJ53LjpmoLOQemdfv1y4WKe35VKxSjmNBe5n+MQWxNfoTN12GqeOgNA3yzABvfhx3P2ZVWw8b1VrGGbYvE+e1JwhdXi4AzvELbmIke2Pdd+pNEMb7pWuuadNw2POHIEluzILKrZHN7ZcQWUcMY/85lh6XVWRyy+Eop6Yya8jt86ZwTQB5hCIIag1OKFL79GFoYC5Wj4SkQIRMj/XGN9wcL1pYn6jLb7/vSl02/8UXPqn2I3sy353KJDylzpJI2b+pLRV57MLqV5UN+Dwv7t4MWIdpVuFnmAMdLIOQbvcKCa0yADjZ26Bd05oBE74xXpWxNdo3DxWZCaK7Y36gFmIdGpeDovlA1nxQnqeIXGxmwN5qEsyNcKeTRpSCizkepZpORJDOIFzo19YnBOppJsUj8871hNb0sMkZpepjam4UGNOlPI0OD8zE7Eoh8w3y5LG3I8z9xLI6i3MYyBXsH26T5SxyFj8DdnGAID/v4+IOh6H6IMLQNsU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(19092799006)(56012099006)(5023799004)(4143699003)(11063799006)(261009223027099003)(10067099003)(22082099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?KjK0bb3R4fqFNcnimo4wpOqfYt0qEnoNyKvirKggmNbZffKLwHFEmGNgAf?=
 =?iso-8859-1?Q?Lz7iOX3AdBV0fvertVLuXJwA+IcqKOaGrESu2LpnvV8qY7NexD/kCWp8vS?=
 =?iso-8859-1?Q?4gRrsL/6BuJsqJoofjgLo1FR3Vbr1oGGjb/kWrQthgoaAoRrXSh5lZKdPq?=
 =?iso-8859-1?Q?zes0gY4iVwqbhRD0Ga16lzyGZ1gGPHkv0yJza92mBo/FFPR9nLqrGWrxBn?=
 =?iso-8859-1?Q?aM8PIol+5seEI0D/oDULgty5oky/cNVVW+7DBekPrCd2bKYLBjqVGvIcHI?=
 =?iso-8859-1?Q?/wT85QjekOdRoHMMlnz6slm9aV6szU9H9Ud0YPcZ+pB2vj3CP/b1MpfG2e?=
 =?iso-8859-1?Q?95uckvmPkDIp++jjATxHAw10K1E0smzhniBi1ReirAs7K6mHPtx++ptq+q?=
 =?iso-8859-1?Q?fDFpzRnMP7lv740tf7/91+bTufn0Ob1rOTihJm3ogWc3qWHnNGmvdkhUqQ?=
 =?iso-8859-1?Q?NZgU8jNiIIDLSIXi+1nFjYt4ID35xZldXy10MlY3hJZYb4/1qBAVWcMWRu?=
 =?iso-8859-1?Q?MumJReDQ9pD6qvha+7qeECJ4SdYdt1A8GVVbeMO3L4k8M8+cwm1hmQu5jh?=
 =?iso-8859-1?Q?YWLWnxquZTYpGfEblmCyxgf5hOgEqBX+teNVQlh53/haNBZM77CQQTnKLv?=
 =?iso-8859-1?Q?pljkh92GppirXPGx6bWRhHn90Y2pf4rbQFur86Xvw4yWPZw4SIJbAk9PTJ?=
 =?iso-8859-1?Q?/fw8Ckf8+4Pzu1iQgKTx3a7+lnN9OzABu768DISH7itrv20QpWL8hKO4Ix?=
 =?iso-8859-1?Q?mHmmZug8eUXFnUalwez15ksJ06FsZlf4eD6X7ssIeCtPYtvCt9IKct4ln8?=
 =?iso-8859-1?Q?k+SbiD2bQjqb0SLGFneZWR+dZ+kiL4Ezzc0rbe40wud3R4q8ChQ+Ghixui?=
 =?iso-8859-1?Q?Vtif5ImkbymQE3krYyaUE8XuFpAaMSa3L5IhWS1q6p9545fuu2eakmVZtT?=
 =?iso-8859-1?Q?35hRBdTjlu3sKMXHtXlcbnyREHqUPSBUdYrzDAZ0NK6npSyW2GAwgW0Ajg?=
 =?iso-8859-1?Q?QDusfDryrdlw64FKvtWcbs22g4F5QX2YYliUvS4/F0L6a9tL94cxDf9sET?=
 =?iso-8859-1?Q?VlaRSL8JCRG7mKhASpAISnaPqO7JeZKaWpilDYs5JAvh9byiI0QB9kiXR6?=
 =?iso-8859-1?Q?PbTUYikAQ82O4fGURMsrKDHWNctOLwKqmhtLc15mG5kb98E+osS8A6rPQ1?=
 =?iso-8859-1?Q?AQViYr1ZVThXYgdit564BQ1vyRvGyWKoZqn9sZ40NYRIi2Ra5s1TE7EE1h?=
 =?iso-8859-1?Q?NPzGEX4tDvnqB7FyIKZT5N/sM7IWHAjqDOBYmX9YD+pI1z02TDGF2hbJBe?=
 =?iso-8859-1?Q?PuUKp7U1d/DCWaBNembRwGMnRE+JseXQssyGcDL3qyyNrFvv43OI6nz/D6?=
 =?iso-8859-1?Q?8Vk7MPdk0lS+ul8U/0H6ObC3SWNQ0+pVrUgV5oYOwaFnsOpt68HNH8nH5M?=
 =?iso-8859-1?Q?XAyHZPm5K74xncVV5+4jVlAQ7kNMYZv+wDUc5yaVIDkU32RsW4jTEr7pHM?=
 =?iso-8859-1?Q?4Jgmp1U9LLw4+RwIh5Iu4tW770ZUC6h3SrDnSZqRSoRmwhvN0Ce0iIU8mT?=
 =?iso-8859-1?Q?yXPcvcKFkIaERHZThdDyMxeMfpAMtpEXZ6Wb6D9JCc3Gi/Dr8YTS4u6WSs?=
 =?iso-8859-1?Q?wUhTkhC/P/QUlT0SRuSquntMzMFSbWF0hY4dxd9SznM4wni48t8ABtG+wk?=
 =?iso-8859-1?Q?oqw3gk/qwpX0Eu3ejObVOlO/J6iUj7hqSwAhsFO7UdFPawpugxQ/7expZe?=
 =?iso-8859-1?Q?jOTyWcBL8nmx2wRIExeKTVMH0FSsrjRMVKwCa71tfjNuNVZ0qL2pAz2zH+?=
 =?iso-8859-1?Q?TZ6PyKTtPc+kukJN63Yvps1yW3afRJWbyZInhGl76tLGMms7iHOe?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71401e56-8506-4d0c-d73c-08df2ade7dd3
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 17:05:19.5041
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4SZxRFd0iNVrIE0GB/NgR8z0slT7rqFmXmT21rt+Ts3miguKeeZZXum49rLnQROW1YndzStRziD3f7xfcANLvdD21by33riM1XEHNpM9NZz/7UkI3GoQ9wqmZA+/nhHi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8734

On Fri, Oct 09, 2026 at 07:09:23AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 10 potential issue(s) to consider:
> - [Critical] tty: serial: qcom_geni_serial: RX DMA is never safely stopped or cancelled, leading to UAF
> - [High] tty: serial: qcom_geni_serial: Broken GPI TX DMA cancellation and TOCTOU races
> - [High] tty: serial: qcom_geni_serial: Lockless TX kfifo access and missing flush validation cause data corruption
> - [High] tty: serial: qcom_geni_serial: Workqueues destroyed before port unregistration cause UAF
> - [High] tty: serial: qcom_geni_serial: Invalid DMA buffer ownership transfer corrupts TX data
> - [High] tty: serial: qcom_geni_serial: TX path permanently stalls after a single transfer
> - [Medium] tty: serial: qcom_geni_serial: Multiple resource and DMA mapping leaks on initialization error paths
> - [Medium] tty: serial: qcom_geni_serial: Squashed dma_request_chan error breaks probe deferral
> - [Medium] tty: serial: qcom_geni_serial: Incorrect tx_empty reporting breaks tcdrain
> - [Medium] tty: serial: qcom_geni_serial: Callbacks access port state without locks on error

Please fix these issue.

Frank
> --
>
> commit 795e95674391634c4084de89abe8cbcd0788b18d
> Author: Naresh Maramaina <naresh.maramaina@oss.qualcomm.com>
> Subject: tty: serial: qcom_geni_serial: Add GPI DMA support
>
> This commit adds support for the GPI DMA interface in the QCOM Geni serial
> driver. It configures hardware flow control, DMA channels, and RX buffers
> when the UART engine operates in GPI mode.
>
> > diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
> > index 4a6f526340b8d..eb66194a7f645 100644
> > --- a/drivers/tty/serial/qcom_geni_serial.c
> > +++ b/drivers/tty/serial/qcom_geni_serial.c
>
> [ ... ]
>
> > @@ -828,6 +828,11 @@ static void handle_rx_uart(struct uart_port *uport, u32 bytes)
> >
> >  static unsigned int qcom_geni_serial_tx_empty(struct uart_port *uport)
> >  {
> > +	struct qcom_geni_serial_port *port = to_dev_port(uport);
> > +
> > +	if (port->gpi_mode)
> > +		return !port->tx_dma_addr ? TIOCSER_TEMT : 0;
> > +
>
> [Severity: Medium]
> Does this reporting logic correctly account for pending asynchronous TX work?
>
> If qcom_geni_serial_start_tx_dma() queues the tx_xfer_work on the workqueue,
> the tx_dma_addr remains 0 until the work actually maps the buffer. Could this
> cause polling functions like uart_wait_until_sent() to prematurely return
> TIOCSER_TEMT and assume the shift registers are idle while data is still
> waiting to be transmitted?
>
> >  	return !readl(uport->membase + SE_GENI_TX_FIFO_STATUS);
> >  }
> >
> > @@ -848,6 +849,17 @@ static void qcom_geni_serial_stop_tx_dma(struct uart_port *uport)
> >  {
> >  	struct qcom_geni_serial_port *port = to_dev_port(uport);
> >
> > +	if (port->gpi_mode && port->tx_dma_addr) {
> > +		/*
> > +		 * Allow tx_xfer_work to finish. Buffer cleanup is deferred until
> > +		 * the DMA channel has been terminated.
> > +		 */
> > +		port->gpi->tx_cancel_pending = true;
> > +		complete(&port->gpi->tx_xfer_completion);
> > +		queue_work(port->gpi->tx_wq, &port->gpi->tx_cancel_work);
> > +		return;
> > +	}
> > +
> >  	if (qcom_geni_serial_main_active(uport))
> >  		__qcom_geni_serial_cancel_tx_cmd(uport);
>
> [Severity: High]
> Is it safe to bypass cancellation if tx_dma_addr is zero?
>
> If start_tx_dma() has queued tx_xfer_work but hasn't yet executed and mapped
> the buffer, tx_dma_addr will still be 0. This seems to allow the asynchronous
> work to start up later even after the port believes it has stopped.
>
> Furthermore, if tx_dma_addr is 0 in GPI mode, this drops through to call
> __qcom_geni_serial_cancel_tx_cmd(), which writes directly to the SE hardware
> registers. Can this collide with the GPI DMA controller's operation?
>
> [ ... ]
>
> > @@ -1056,6 +1056,11 @@ static void qcom_geni_serial_stop_rx_dma(struct uart_port *uport)
> >  	if (!qcom_geni_serial_secondary_active(uport))
> >  		return;
> >
> > +	if (port->gpi_mode) {
> > +		queue_work(port->gpi->rx_wq, &port->gpi->rx_cancel_work);
> > +		return;
> > +	}
> > +
>
> [Severity: Critical]
> Will this GPI mode branch ever execute?
>
> In GPI mode, S_IRQ_EN is disabled during initialization, so the call to
> qcom_geni_serial_secondary_active() above it will always evaluate to false.
> Could this prevent the rx_cancel_work from ever being queued, leaving the
> RX DMA permanently active?
>
> [ ... ]
>
> > @@ -1381,6 +1381,16 @@ static void qcom_geni_serial_shutdown(struct uart_port *uport)
> >  	/* Atomic console output queues tx_kick without taking the port lock. */
> >  	WRITE_ONCE(port->tx_kick_enabled, false);
> >  	irq_work_sync(&port->tx_kick);
> > +
> > +	if (port->gpi_mode) {
> > +		qcom_geni_serial_stop_tx_dma(uport);
> > +		flush_workqueue(port->gpi->tx_wq);
> > +		flush_workqueue(port->gpi->rx_wq);
> > +
> > +		pm_runtime_put_sync(uport->dev);
> > +		return;
> > +	}
> > +
>
> [Severity: Critical]
> Should qcom_geni_serial_stop_rx_dma() be called in this branch before we shut
> down the device?
>
> Without stopping RX, the DMA channel seems to be left running while
> pm_runtime_put_sync() powers off the device, which might lead to severe
> memory corruption or IOMMU faults.
>
> [Severity: High]
> Can these flush_workqueue() calls trigger a use-after-free panic during device
> removal?
>
> Looking at qcom_geni_serial_remove(), it calls destroy_workqueue() on both of
> these workqueues before it invokes uart_remove_one_port(), which synchronously
> executes this shutdown callback. Passing destroyed workqueues into the flush
> API can cause crashes.
>
> [ ... ]
>
> > +static void
> > +qcom_geni_serial_gpi_rx_callback_result(void *cb, const struct dmaengine_result *result)
> > +{
> > +	struct qcom_geni_serial_port *port = cb;
> > +	struct uart_port *uport = &port->uport;
> > +	struct tty_port *tport = &uport->state->port;
> > +	size_t bytes = UART_XMIT_SIZE - result->residue;
> > +	u8 idx = port->gpi->rx_done_index;
> > +	int ret;
> > +
> > +	if (result->result != DMA_TRANS_NOERROR) {
> > +		dev_err(uport->dev, "rx dma xfer failed: %d\n", result->result);
> > +		qcom_geni_serial_stop_rx_dma(uport);
> > +		qcom_geni_serial_start_rx_dma(uport);
> > +		return;
> > +	}
>
> [Severity: Medium]
> Is it intended to call qcom_geni_serial_stop_rx_dma() here without holding
> the uport->lock? The stop routines appear to assume they are serialized by
> the port lock.
>
> [Severity: Critical]
> Does this logic unconditionally restart the DMA pipeline even on an intentional
> cancellation?
>
> If the DMA channel is intentionally halted (which might return an error code
> like DMA_TRANS_ABORTED), qcom_geni_serial_start_rx_dma() will immediately
> re-arm it, completely nullifying any attempt to cleanly halt the RX channel.
>
> [ ... ]
>
> > +static void
> > +qcom_geni_serial_gpi_tx_callback_result(void *cb, const struct dmaengine_result *result)
> > +{
> > +	struct qcom_geni_serial_port *port = cb;
> > +	struct uart_port *uport = &port->uport;
> > +	struct tty_port *tport = &uport->state->port;
> > +	unsigned long flags;
> > +
> > +	if (result->result != DMA_TRANS_NOERROR) {
> > +		dev_err(uport->dev, "tx dma xfer failed: %d\n", result->result);
> > +		qcom_geni_serial_stop_tx_dma(uport);
> > +		return;
> > +	}
>
> [Severity: Medium]
> Similar to the RX callback, does this call to qcom_geni_serial_stop_tx_dma()
> need to be protected by uart_port_lock_irqsave() to prevent concurrent
> modifications to the hardware and driver state?
>
> > +
> > +	uart_port_lock_irqsave(uport, &flags);
> > +	uart_xmit_advance(uport, port->gpi->xmit_size - result->residue);
> > +	complete(&port->gpi->tx_xfer_completion);
> > +
> > +	if (kfifo_len(&tport->xmit_fifo) < WAKEUP_CHARS)
> > +		uart_write_wakeup(uport);
> > +	uart_port_unlock_irqrestore(uport, flags);
> > +}
>
> [Severity: High]
> Does this blindly advance the kfifo pointers after they could have been reset?
>
> Because the tx_xfer_work reads the kfifo without holding the spinlock, another
> TTY operation (like uart_flush_buffer) could zero out the FIFO pointers while
> the DMA transfer is mid-flight. When the transfer finishes, calling
> uart_xmit_advance() here will push the out pointer past the in pointer (0),
> corrupting the kfifo state and causing out-of-bounds accesses.
>
> [Severity: High]
> Are we missing logic here to queue another TX work element if there is still
> unsent data remaining in the FIFO?
>
> Because hardware TX interrupts are disabled in GPI mode, if we don't manually
> re-arm the next DMA transfer, the transmission pipeline could permanently stall
> until a new userspace write explicitly triggers it.
>
> [ ... ]
>
> > +static void qcom_geni_serial_gpi_tx_xfer_work(struct work_struct *work)
> > +{
> > +	struct qcom_geni_serial_gpi *gpi = container_of(work, struct qcom_geni_serial_gpi,
> > +							tx_xfer_work);
> > +	struct qcom_geni_serial_port *port = gpi->port;
> > +	struct uart_port *uport = &port->uport;
> > +	struct tty_port *tport = &uport->state->port;
> > +	struct dma_slave_config config = {};
> > +	struct dma_async_tx_descriptor *desc;
> > +	unsigned long flags = DMA_PREP_INTERRUPT | DMA_CTRL_ACK;
> > +	unsigned long time_left;
> > +	unsigned long timeout;
> > +	dma_cookie_t tx_cookie;
> > +	u8 *tail = NULL;
> > +	int ret;
> > +
> > +	gpi->xmit_size = kfifo_out_linear_ptr(&tport->xmit_fifo, &tail,
> > +					      UART_XMIT_SIZE);
>
> [Severity: High]
> Can this race with the TTY layer modifying the transmit buffer?
>
> The shared transmit buffer is being accessed here without the necessary
> spinlock serialization (uport->lock). This lockless access makes it possible
> for the kfifo state to be modified out from underneath the running DMA worker.
>
> > +	if (!gpi->xmit_size)
> > +		return;
> > +
> > +	config.peripheral_config = &gpi->peripheral;
> > +	config.peripheral_size = sizeof(gpi->peripheral);
> > +
> > +	ret = dmaengine_slave_config(gpi->tx_chan, &config);
> > +	if (ret) {
> > +		dev_err(uport->dev, "tx dma config error: %d\n", ret);
> > +		return;
> > +	}
> > +
> > +	port->tx_dma_addr = dma_map_single(port->se.dev->parent, tail,
> > +					   gpi->xmit_size, DMA_TO_DEVICE);
> > +	ret = dma_mapping_error(port->se.dev->parent, port->tx_dma_addr);
> > +	if (ret) {
> > +		dev_err(uport->dev, "DMA mapping failure: %d\n", ret);
> > +		port->tx_dma_addr = (dma_addr_t)NULL;
> > +		return;
> > +	}
> > +
> > +	dma_sync_single_for_cpu(port->se.dev->parent, port->tx_dma_addr,
> > +				gpi->xmit_size, DMA_TO_DEVICE);
>
> [Severity: High]
> Does calling dma_sync_single_for_cpu() immediately after dma_map_single()
> invalidate the device's ownership of the memory?
>
> By forcefully revoking the device's ownership before transmission begins, the
> DMA controller might be instructed to read stale or uninitialized CPU cache
> lines on non-coherent platforms, which corrupts the transmitted data.
>
> > +	desc = dmaengine_prep_slave_single(gpi->tx_chan, port->tx_dma_addr,
> > +					   gpi->xmit_size, DMA_MEM_TO_DEV, flags);
> > +	if (!desc) {
> > +		dev_err(uport->dev, "Error setting up tx desc\n");
> > +		goto err;
> > +	}
> > +
> > +	desc->callback_result = qcom_geni_serial_gpi_tx_callback_result;
> > +	desc->callback_param = port;
> > +	tx_cookie = dmaengine_submit(desc);
> > +	if (dma_submit_error(tx_cookie)) {
> > +		dev_err(uport->dev, "%s: dmaengine_submit failed: %d\n", __func__, tx_cookie);
> > +		dmaengine_terminate_sync(gpi->tx_chan);
> > +		goto err;
> > +	}
> > +	reinit_completion(&port->gpi->tx_xfer_completion);
> > +	dma_async_issue_pending(gpi->tx_chan);
>
> [Severity: High]
> Could the reinit_completion() call overwrite the cancellation signal?
>
> If qcom_geni_serial_stop_tx_dma() concurrently executes and issues a
> complete() signal, the reinit_completion() here would wipe out that signal.
> This causes the worker thread to hang on the subsequent completion timeout.
>
> [ ... ]
>
> > +static int qcom_geni_serial_prepare_gpi_rx_dma(struct qcom_geni_serial_port *port)
> > +{
> > +	struct qcom_geni_serial_gpi *gpi = port->gpi;
> > +	struct uart_port *uport = &port->uport;
> > +	int i, ret;
> > +
> > +	for (i = 0; i < NUM_GPI_RX_BUFFERS; i++) {
> > +		gpi->rx_buf[i] = devm_kzalloc(uport->dev, UART_XMIT_SIZE, GFP_KERNEL);
> > +		if (!gpi->rx_buf[i])
> > +			return dev_err_probe(uport->dev, -ENOMEM, "RX buffer %d\n", i);
> > +
> > +		gpi->rx_dma_addr[i] = dma_map_single(port->se.dev->parent, gpi->rx_buf[i],
> > +						     UART_XMIT_SIZE, DMA_FROM_DEVICE);
> > +		ret = dma_mapping_error(port->se.dev->parent, gpi->rx_dma_addr[i]);
> > +		if (ret) {
> > +			dev_err(uport->dev, "Failed to map gpi rx buffer[%d]\n", i);
> > +			return ret;
> > +		}
> > +	}
> > +	return 0;
> > +}
>
> [Severity: Medium]
> Are the earlier DMA mappings leaked if this loop fails?
>
> If dma_map_single() fails on an iteration i > 0, the function returns the
> error directly without unwinding and unmapping the successful mappings from
> the previous iterations.
>
> [ ... ]
>
> > +static int qcom_geni_serial_setup_gpi_dma(struct qcom_geni_serial_port *port)
> > +{
> > +	struct qcom_geni_serial_gpi *gpi = port->gpi;
> > +	int ret = -EINVAL;
> > +
> > +	gpi->tx_chan = dma_request_chan(port->se.dev, "tx");
> > +	if (IS_ERR(gpi->tx_chan)) {
> > +		dev_err(port->se.dev, "Failed to get tx DMA ch\n");
> > +		return ret;
> > +	}
>
> [Severity: Medium]
> Does this squash important probe deferral error codes?
>
> The original error from dma_request_chan() (such as -EPROBE_DEFER) is lost
> and replaced by the hardcoded -EINVAL. This converts a normal transient probe
> deferral into a permanent initialization failure for the device.
>
> [ ... ]
>
> > @@ -1352,13 +1805,26 @@ static int qcom_geni_serial_port_setup(struct uart_port *uport)
> >  		return -ENXIO;
> >  	}
> >
> > +	port->gpi_mode = readl(uport->membase + GENI_IF_DISABLE_RO) & FIFO_IF_DISABLE;
> > +	if (port->gpi_mode) {
> > +		geni_se_select_mode(&port->se, GENI_GPI_DMA);
> > +		ret = qcom_geni_serial_gpi_init(port);
> > +		if (ret)
> > +			return ret;
> > +	}
> > +
> >  	qcom_geni_serial_stop_rx(uport);
> >
> >  	ret = setup_fifos(port);
> >  	if (ret)
> >  		return ret;
>
> [Severity: Medium]
> Does this return early without cleaning up the initialized GPI state?
>
> If setup_fifos() fails, the error code is returned without unwinding the
> resources acquired in qcom_geni_serial_gpi_init(). Since port->setup has not
> yet been set to true, the teardown logic in qcom_geni_serial_remove() will
> also skip freeing these leaked workqueues and DMA mappings.
>
> [ ... ]
>
> > @@ -2035,6 +2565,14 @@ static void qcom_geni_serial_remove(struct platform_device *pdev)
> >
> >  	WRITE_ONCE(port->tx_kick_enabled, false);
> >  	irq_work_sync(&port->tx_kick);
> > +
> > +	if (port->gpi_mode && port->setup) {
> > +		destroy_workqueue(port->gpi->tx_wq);
> > +		destroy_workqueue(port->gpi->rx_wq);
> > +		qcom_geni_serial_release_gpi_dma(port);
> > +		qcom_geni_serial_unprepare_gpi_rx_dma(port);
> > +	}
> > +
> >  	dev_pm_clear_wake_irq(&pdev->dev);
> >  	device_init_wakeup(&pdev->dev, false);
> >  	if (!port->dev_data->console)
>
> [Severity: High]
> Are the workqueues being destroyed too early in the port lifecycle?
>
> This code destroys the workqueues right before calling uart_remove_one_port(),
> which synchronously runs qcom_geni_serial_shutdown() if the port is open. As
> seen earlier, that shutdown callback invokes flush_workqueue() on these
> newly-freed workqueues.
>
> [Severity: Medium]
> Will this leak resources if initialization failed partway through?
>
> Because cleanup is gated behind the port->setup boolean, early failures in
> qcom_geni_serial_port_setup() mean these resources will never be freed.
>
> --
> Sashiko AI review · https://sashiko.dev/#/patchset/20261009-add-gpi-dma-support-for-uart-v1-0-c69e728df686@oss.qualcomm.com?part=4
