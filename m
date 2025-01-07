Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2084.outbound.protection.outlook.com [40.107.22.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80451F237D;
	Tue,  7 Jan 2025 15:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736264759; cv=fail; b=cDj4iIsdMiHxMtUxvcKwZI9byC4IhR0mjFiM2bkbIbrY7N4Wt7KhgEGNltzhm45QpKmYdZIcAwYHSBb6BxVYjDAw5w71LT1gQS+gvvF6E2FLjCgICKVKK0R+yMoxGjacZJ7CuwBEonJE0RVOGXKaN4+vBGWwdPEPkKTe1srMxOY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736264759; c=relaxed/simple;
	bh=JQVbLzn3LoCRIe9apd1/oC/MqzYUbLXDguH29YywhMM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=np7z2vGp/nj16Fa8STAo4zuJ4JDdjP87ab6eCdBj1JSICaaAJyIabOzqYATPW7Zm/crWqeDmhL6FWJ6p5O2Vl37bzHhl21vZX22AF7txNNspShDUNS//9iNEBtItwUMNY6cx8EXB03voEjuw52CmJocpt2OzuxwUsw68hTwUldE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Ryt9qHkh; arc=fail smtp.client-ip=40.107.22.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ryt9qHkh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xma0roN3eJ/VDaOM8Ei13Wp0TuppDwxdD6jJvQdtk98ihv5szXtmqb2NQJW/JSwuEgtO2groJV9s9a6kITzbFfRsURK4vg8Eik+VLybAYg9jilrYALNRmCx3DdI4cWss+Ml6iRnkq0GVMMrsQnwf+pHDskAB17RNjKTGTAULQ2HF/mix75pdqXZicY9EI9RdoWPk0A9WDC95nZq3cwtHoys4phZ/a/VqoI1A+SIz5HDhap7JaiWJ7JRlvEzxtPtNintmDBM7fAWeJ560mfundG3jZlK1KvyvVbl7MYT//VvzYqiGSUcPaO6xgAkYShIpItynsTbuZ+HVPwkCgyi/DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KmCEHpCtrlJqTiddKQcr2qnG8otFKgqlAuAvQJygAUk=;
 b=B6qsd5SZrNTN1e5irPomOk+CLDyPEbQzFh+A1qTRoKN8H7WEbyIncxt0MSwG4i6grFtgxKEZlFZRNCY//Zu6gM5WiQ5jGLJnyR0WGT8CJ2y+bfXqsT/vQ70RVimoLxf8EIrXPU//3Dt18KR4y+vKjss577DS94gUethemQbbAZZQv38uiNX5FUv6+msu2t1nKc7AXlVW5Jzyk6fn60rt8gWhPcCS/X+W3Dm8CnmawusmUbbuteU6mb0LiDLAkfNgLOm8GaFq1iXdmTuuzpNYOSwJovbjFjQZD71GZysbe7aQqtRyzkj5E5kX9FM7UkFG5tyVowxDl3jvglXhdzf0bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KmCEHpCtrlJqTiddKQcr2qnG8otFKgqlAuAvQJygAUk=;
 b=Ryt9qHkhHeccpNz/1flPP1vmurYyG8zBaa7rg4CFTWGkHSwsQeqqg3lstvuUQmDnMC/yPYOgvBoHs1choCaZhI7OMkNQM1dMa3ynVw9BVvVpKDigb11i3vbnIuKkn8/mXY9zfMQGukaP/WUH8+YwjA3lEIoIefO/DsiHSoG2Vl4rnEICsHfwMCL6jkbKuVpNFYLAXQ3Bdny8SEqFsx5RfwwvacWi7puo4NYGMNTb/HaaaFpWvYIsezz5BYtpDahbcwX3PQHyBNAjDGHDuMFsjHOeFn7wT4wXGpKNWouRsjiVpJaxkTahKpyZRYa6ImvQ7x4cW3zCK/+lOJ6dLDRcNQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM0PR04MB6818.eurprd04.prod.outlook.com (2603:10a6:208:186::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.18; Tue, 7 Jan
 2025 15:45:53 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8335.010; Tue, 7 Jan 2025
 15:45:53 +0000
Date: Tue, 7 Jan 2025 10:45:46 -0500
From: Frank Li <Frank.li@nxp.com>
To: Sherry Sun <sherry.sun@nxp.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: Re: [PATCH] tty: serial: fsl_lpuart: flush RX and TX FIFO when
 lpuart shutdown
Message-ID: <Z31MKgrQEsMAc3aR@lizhi-Precision-Tower-5810>
References: <20250107074834.3115230-1-sherry.sun@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250107074834.3115230-1-sherry.sun@nxp.com>
X-ClientProxiedBy: SJ0PR13CA0084.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::29) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM0PR04MB6818:EE_
X-MS-Office365-Filtering-Correlation-Id: 01dc0619-6376-4481-5cb8-08dd2f325e28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xkOiuvVYb2Jv0Qx4fvNyOuK1rEMcdEGKbI/AEDr0moFu97ql+wbN9qHH7waa?=
 =?us-ascii?Q?QeLh98WNAGyJSartx0gg4EhMfEJz9FSHVddtjoiRiyQv6Z4l/HtWwWa6Jz71?=
 =?us-ascii?Q?8KxMIdTw16w/vs5ETlfDP2PPANC8SuP+fSqTm5S8H/cu/hzhq8IGPqdam7/n?=
 =?us-ascii?Q?e8PvHG2zNkc3L0bLe4DNIimEryu/vFRCRNuZMdK3z2XjsgJSWTpTFErpJMyr?=
 =?us-ascii?Q?X4S7kvU9irK4jtX/IFPO6H9DqX2Q9xmBgT4EHyApOzlJNse832Sb5ult4qnf?=
 =?us-ascii?Q?8h6CEyxq0cUTO7mrXkKY0d8AJ8cspTAWyyHGoFF/FGRmfAvnW5Ct2Xl7tAur?=
 =?us-ascii?Q?TBr6J8JS3K47orCP5UW4ENwlBGefgkQyU/GvUu5iJqcfCMUgbNoj5795l4wI?=
 =?us-ascii?Q?c0jHYpph8zkA4Bb9IYI5kLYACQ+JzpOAFRHJArgwXfsMtV2ytX/c7FBdX4Si?=
 =?us-ascii?Q?mNRSt/GBt8LJDtssfJ/laq0l8zIrlda9Dc12Z17nKQ/FuiPUSeuUbu1A3AEG?=
 =?us-ascii?Q?5UcZklKdNfTxKQTrgGpx81tA+2LsEArB3Z+0qolbvtcGbjPKFoJXBvvO+KX4?=
 =?us-ascii?Q?yLqkxomLdO3QGX6O8p5zk22zCRR8+HomX7g1Ex6mkcCMNBxOiVlcW5QBhSGS?=
 =?us-ascii?Q?zma4rqIwmMfOqFmz/IcItmgkMteAtwPdp821QxCvzjcOCmh013WP2ylTx/1b?=
 =?us-ascii?Q?sBb6T8n5wtuLUSUf6JL+yYVJOBtZbw1frjGLHNQRtwQkSZllMVKBs2A0TX1v?=
 =?us-ascii?Q?PdSFw7UlO4ZfUP+qyMbjciR+lTUil7xAnKXVhFpqv1qo4ZAcXtVbk2YQP+/E?=
 =?us-ascii?Q?SCdSKSIvon+sM5wGt8bvmFjcVGKNgGgR3aCkipbKYlIPV/N13jLe5HY9xkdr?=
 =?us-ascii?Q?WpFOTESBbh2mp1GwTq14DGMSoAbLVhzNOmQ8m3xx9DdnlJuGeL0OdeP/BVpA?=
 =?us-ascii?Q?WCOOWnV/oe4WN2KZP46757dFEkJtuRXV3h3LUjuWzpt3wShHeIQdOW+bocuL?=
 =?us-ascii?Q?o2Xruj6llqoSYAmWexP0tjbPfpN3uUnPWU9Ng3dkY7L1Zwoyp16mEHGhX+s1?=
 =?us-ascii?Q?T+6V1sBV/OE+PBJY4ZKf5RxPJoTOiDq8nf6ejrSG/TKFGw29e+uY6GsBgtfd?=
 =?us-ascii?Q?O3YKCKRtqLZxXdx4ntEl56i/SDILEP4Gvn3t+vcK4E+JO+tN1q8xV4s6aPDL?=
 =?us-ascii?Q?RLJF9H4n2l36NRrzf6NlYQNE770s4Qz0/4JNX+DQg7Mu/O+/iOrj6CdEKrXa?=
 =?us-ascii?Q?qGVukVk02JD1c8PhsoTbcOsYc8FHEWZBZcgKPWEOxHIl+ldvZsnygS9FK085?=
 =?us-ascii?Q?blQmsICd3iZ2LhXUDpl82IaiVse+jVmA8c4kCOBr1eI1agbH5lljEgTSEAcL?=
 =?us-ascii?Q?83xnYPeNYPBx1C+WmMf2x30tzcMy+5K3U5+NWkmQWRxs+TTQuWQIRC5xHWRz?=
 =?us-ascii?Q?GlThP5UUXlv5iyVUECz9eEXkaZNaDQua?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rboxX0EJZtF76ObwQgJuti7gzoHb8ikQE1KUAOIGMd03uHbcNCQvsUVEajhv?=
 =?us-ascii?Q?FcO3FOxAo88g+5eWQ42Jr8y8JsQv+VWV/NuO2HK/+3jQ0tyL3JzczkA7/5xX?=
 =?us-ascii?Q?Dp8oaCOQ8MrIgVsJxvQfMco+lRU3HN2Fil1+AD3Xd8z9rllg3Ui4siCmesty?=
 =?us-ascii?Q?GjrqnB04hwu99JRsulonXTF/fsYi2qyGE7emcp3fuGJ6yhujlSdZzgdIB28Q?=
 =?us-ascii?Q?/Z9+hGI1ODz48ZwpNhn0f478Qds2zsH3+/8VxEVxlcIxh8zcfdj8PP7ELftt?=
 =?us-ascii?Q?EAQTZ20rGWeYnoSa0gpn0zP/O5I5prC4SYC9LN/1h21rOsXUhNu3guDP+Q8u?=
 =?us-ascii?Q?ThZIda5Z9+LNduxATeHRzh+SSDHavbQOOkpZPcZT8yo6AP5EUhGbewMrGyF/?=
 =?us-ascii?Q?Hde3fVaRM0nosOAcYx6r3biH66MesH2wv1+tATghtlx5gNx1zyTpuHNcmSl3?=
 =?us-ascii?Q?pZuPmSNMbJ2Qd3IhVF1cDbAQ/n4ZxH8TCUiEj1Tsp3TvI5D5jO0Xk3tFJoPV?=
 =?us-ascii?Q?vKXdWC8/WJB9CXlJ8EiqrBu1Smn5eqX1tE9P/hSnhZS1+G8cJ1CVnHiq8AvR?=
 =?us-ascii?Q?c0mfoHoubKqpIqP1MZYLt8BjBSZMyM6BxgqX+gOV/2gK0VIa+NvwH/YWMMZJ?=
 =?us-ascii?Q?c0o/DLeUpWPMw5BhGoEurCTGJPsBS5UG0DKFbbmIuov2AAdnTG0Q2yom0FKr?=
 =?us-ascii?Q?/WHVBh5LQ5e9kqdcNZoR+QO6iN2KTwAYPKuNAX8MOEDNCUkmN2oeRtXI3tXf?=
 =?us-ascii?Q?8oS50/mVJJwctgkhyW5IMUSe1f5eCnumn82g/ZPV7P0hU9EOV/LCCRCFyIL6?=
 =?us-ascii?Q?+isKuZkc0GAmwOlydFZ5daJol4n8iw+DZGvAfMcNkddx7SmkYfzRl9lFnlaO?=
 =?us-ascii?Q?dvQapjklmvm7Yc8TwwDgKmH/s12rXi18YXuC0kUPMGqYr/HLjgWn1t2VDtx7?=
 =?us-ascii?Q?YqnTJxMsLSrv7wc1fa5GV4CpkkHv3drEWXecQiabv+eVsHGmwtZB1Glq0Z3O?=
 =?us-ascii?Q?5Kma/sQ+wFVbdZboioufiawq5h9981mb5yFya59Jli+CQn/xK79/GcUL9UyD?=
 =?us-ascii?Q?Uvqx9PG/Q148UA6LkXzMlOhF3npUk5J1OsWK7dkm4OwI63CbHoIJWuK6wR1W?=
 =?us-ascii?Q?3IUUujI1SeZb3jik79bj3rPfE5S0VG3qfjT88OdbOrf62GCJa0e7oWZI6nbZ?=
 =?us-ascii?Q?NpUoaMukX/n7WgmVdomXFHhlEowDn600pW14hyZ0QzQNU5SZcLmqpLZwb2i3?=
 =?us-ascii?Q?r8iAJn6jcs9X5J7foilLkdCfNSsyqiaBS7jv9lp9fX2yxH/6ugv2SiaJHJSA?=
 =?us-ascii?Q?L5bvmuWC30d5AGtAQXBuupeoIiEdsOg9o2kdQFAuV/iNifxgOlDM0xDWcL24?=
 =?us-ascii?Q?BVjTAxbUQzogAgmCMPvNi4SWTXK+WP6HGe//Vi+NcdtagKxJtFxJEEDUj3HC?=
 =?us-ascii?Q?aRs6jCBH3suos0HEWHh5/piW+9IF8OrDntU5JP9hdfEBYGZPwQIMzghAM+VT?=
 =?us-ascii?Q?wOW1D5vwmiMIz7nLPbubmhI6iz1gC1uxPtcTLo+J4Ic5gJXYlpxPRz5bf7r+?=
 =?us-ascii?Q?Jprs9fgmYNqZjo4yOflIFv1kxCQohDIw9JhzbesL?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01dc0619-6376-4481-5cb8-08dd2f325e28
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 15:45:53.2361
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9QvQ/2orVNF43DRqUOerjUyfJK8MuHkBAeK/QpuA4sqJArRvCJ0+U9elz4LHshQXYsL8Mlbcvjg+HG/U6uSmeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6818

On Tue, Jan 07, 2025 at 03:48:34PM +0800, Sherry Sun wrote:
> Need to flush UART RX and TX FIFO when lpuart is shutting down to make
> sure restore a clean data transfer environment.

why not flush it at open()?

Frank

>
> Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
> ---
>  drivers/tty/serial/fsl_lpuart.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
> index 7cb1e36fdaab..c91b9d9818cd 100644
> --- a/drivers/tty/serial/fsl_lpuart.c
> +++ b/drivers/tty/serial/fsl_lpuart.c
> @@ -1965,6 +1965,11 @@ static void lpuart32_shutdown(struct uart_port *port)
>  			UARTCTRL_TIE | UARTCTRL_TCIE | UARTCTRL_RIE | UARTCTRL_SBK);
>  	lpuart32_write(port, temp, UARTCTRL);
>
> +	/* flush Rx/Tx FIFO */
> +	temp = lpuart32_read(port, UARTFIFO);
> +	temp |= UARTFIFO_TXFLUSH | UARTFIFO_RXFLUSH;
> +	lpuart32_write(port, temp, UARTFIFO);
> +
>  	uart_port_unlock_irqrestore(port, flags);
>
>  	lpuart_dma_shutdown(sport);
> --
> 2.34.1
>
