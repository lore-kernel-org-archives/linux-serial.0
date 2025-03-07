Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013070.outbound.protection.outlook.com [40.107.162.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8B321CC68;
	Fri,  7 Mar 2025 15:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741361249; cv=fail; b=McBfZWaZ1irQ6pXA3VYXA29Rh3Awx5C+4UJ94W9pJkg3GYqJHd+rkhUgdObHeNLOb3dD8OGCPcB4rkT3RhfZPe1r1DAPXTsAh2VKn/ZU7A/ZQGx7vlqoC9LL0yP8OAVSJjdtvXxLEn4Nu+hbDUdeCekIcIkJDSOPGYJmFoxc8Nk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741361249; c=relaxed/simple;
	bh=LKYhQbFSIHE7zVMMoZ0tb/JwCB/d/Pjd6pE/my7FH4M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RrEyw2+bgeLMP4uGd5GfSay1hWgh5KBxMYU5bzDqs6Z5SzdMqfJwZXTFr9bXqpLk0yT/7Nr8EjKC1TuPMq1aQ0h1vu3mvniBwmApqGoY9Yu9jIDcbja2zwoZb0d1/s98xuAsRMtFQj9lXy4amWsrcq4bzuLxrK84M03X2DYO7K4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=KextMIbw; arc=fail smtp.client-ip=40.107.162.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="KextMIbw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dsar4fq6v2uOv3GHA9s7/u38j4lboo2CHdZ9ilTRL1SUq2BgCrOGNvCtr3+knVONGHju9xD+99bRQ0nkOUyaj7n/KTPsabq+L880jFONcxkzCnb9YMsxVPZZzNTp0r98+ecJ6CWyur/pAHZXRwnvejEH/Ym3NMXWK/vbMVkdnB16guj8Bj71QPAsiV4O9Bx77d5eziUiqNFGilzaUKaW+nSx8OvXisn6JXqn8kwKZpHv/jQdGUEGu/uSCiOQN+yRIVbLg7k+vOUAbrG2UMjIs+z+J2siaupJLFpoLlcv8RGEcmi57OhjyVMzXsK/7Bw6q/1Q4rx6+o5XW8o1GSEkaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LrAos/qcl5ePR8aFL9+EB9wSxe4soXueFQzBa/7qlnU=;
 b=fYKeuBLMajmatfJdQBp1mOwXgoxTbS9BqnsrS5bvCBKBqz7pOd3WR9nozhyFov8dCedBcnZXkWPyGwPTcf3IQcQEJzC1GkYAQxTj04HC+PdOiRaFoYiAxsyRufX2ejxAnL6oM8r0cc2qXNbMlQ2IU12i/1F3RGinSYVzEEpRR7tQK2sTSFc8RZGBhrL0vtl42I/4B77nQAaUPtIy534tk5PO+99GU07CzRmDU0dNYGpsz4pix8fJZNTjET8KopBXqOHCbNsh9+PEWm2Or57HJDzEXFNMieot4vMq90W5e5Awanb+ot7NS6B9nzfTj/Vk085i3zJkdaDM1RZxEbVd4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LrAos/qcl5ePR8aFL9+EB9wSxe4soXueFQzBa/7qlnU=;
 b=KextMIbwzbvCR//mhtNmQUgAWnaXADRe/1XIYRLFjsPpZJII6DTp3/iHjQXtba6dz7VHTEuMj0XjRdNKLlm9BQKww3aEbi4811XsYJdl4G36Un2HmtrUcF7bAmZOtY1b5HBuKGgudyQxCAqEVO4yC3pDIp7BAIZTjp8l0r5yxFCu94aARdasvq0o3YSPCSD4YECfyGkLLXY/goiXZKiKgRswmr8kas7S447PAFYo2gca5qpvUr7Cmfhm1njo1kBbb0SrIXMHriOe0vuRbe+BGgJB+pLR1sLwjhFmtVGM+cepNH1/qD4A0EcSgn24eHE3BTHrIEchyc2O+Zx3EKOi0g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU0PR04MB9694.eurprd04.prod.outlook.com (2603:10a6:10:312::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.22; Fri, 7 Mar
 2025 15:27:23 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%6]) with mapi id 15.20.8511.017; Fri, 7 Mar 2025
 15:27:23 +0000
Date: Fri, 7 Mar 2025 10:27:16 -0500
From: Frank Li <Frank.li@nxp.com>
To: Sherry Sun <sherry.sun@nxp.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, shenwei.wang@nxp.com
Subject: Re: [PATCH] tty: serial: fsl_lpuart: disable transmitter before
 changing RS485 related registers
Message-ID: <Z8sQVNaLCxl3x9eG@lizhi-Precision-Tower-5810>
References: <20250307021950.1000221-1-sherry.sun@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250307021950.1000221-1-sherry.sun@nxp.com>
X-ClientProxiedBy: SJ0PR13CA0040.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::15) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU0PR04MB9694:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f12fc81-ce6c-4178-edb7-08dd5d8c8ee3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ccTb80PlbgdCfpdqlDp7TQDOhZLC0WCnsi/QL+vSmqDLn4fuLUOedPssqsLa?=
 =?us-ascii?Q?alweR2INYfrXtLeKhMh55QGdvLGVH55XsmkLTLVxmUmlqXEzh0eRt5NOclUi?=
 =?us-ascii?Q?RemUd4IBlTVi15axLL8dGZQvFJRHCZoj2La9RxHJxSIN9to+6x5FYpl1uAWj?=
 =?us-ascii?Q?y8OH8TBaBTjopXs+m2Ah0oKg+Zs8Yvyob+gU78m2AGPLZBJU7KThcvPrM6Ur?=
 =?us-ascii?Q?QQkVK6zXSR5KPwwuiqTFNKHWOKo9T0dGX7Qen529JJnyEJrgwYLQkzuGeiWh?=
 =?us-ascii?Q?tC6S6yMFf2h1obcT3RkwQJTFlppU4uWEVYYPTIhQWaaUHf7ZLwtjN6LoJYRR?=
 =?us-ascii?Q?eiKRIoGiXJvqZZfVk+NGejZPppD+5vN4SyLTmtgRRHXKVYdGgFJrhDlgz+IO?=
 =?us-ascii?Q?auRJE/68L0+N/NZuJeyXboPjO7dKrwFbKz42MLgJ1NPiiX3D9lnjNzAxGr9Z?=
 =?us-ascii?Q?FJd74pa9zrAjwU0x88uQssr+sTysFuso/KS579CqWZDO7nRQIqY2xGWFkWBS?=
 =?us-ascii?Q?PDL+NaAT73sov5UlfbLkgw/nY28hnmeBQkqeaXLbnbybVc9DIsY1s+wc1N7Q?=
 =?us-ascii?Q?IIWNvda/tn1oGgpVKYlS8c1b+PoJMDX/oBudyRzzMwRCTXEA5+EMsh5DDbqe?=
 =?us-ascii?Q?eZK8fIdTfX8Hov5iPExDJSAnbEOeKBC5xHeLj85UJ32Ex7FlvOcJFAmMPmZB?=
 =?us-ascii?Q?/M4gx2biyfjNq++4dabFLl9+FgkLfxAzxbe4wKKZ2ip0wS/XC7iS8drTeVIy?=
 =?us-ascii?Q?3zEFsMDjJn/Uzu4w0tb4djNr/bCc9nIxQe9bZ9VrvUEi3veXsGaPOqQZ1MAb?=
 =?us-ascii?Q?X0Xep7OSbO16ys6PUC57mh4MmK/KjkDFS8XOm6QrfibZ22dnVcbktP/b0qcg?=
 =?us-ascii?Q?hKVvZ2AeH0Qb8h3rpPYl78RDUwMuNT9PCDPmKJ5p6juraI1muO0481AaRuHt?=
 =?us-ascii?Q?ztRkJDej/5xrTQf8IpyvLoSnV7sehvVW6RuTvVa4MRJb4unzGkSvFq+WP/0N?=
 =?us-ascii?Q?EcyXnWvfcPCF12JXMzisuymGUoegx3TGd+ISHSkLHdZCGhLMlqo62ZdvtNp9?=
 =?us-ascii?Q?rkBTrT3duvY4AFQqOfmufVD3VAK57GQzTlOvkpQ4pT4jLj98DZafAqsScfpG?=
 =?us-ascii?Q?tRq1GzmWhtlC6/AhJ3O4CJ50dnEirnlvPFbSIikpMcENj+Xu+hx7XNRMKFor?=
 =?us-ascii?Q?SYPeAKMYTxJCZ/3uoDSpWYFfE7PhOYXHMOSCLUaV1Q034NQ0B982C/oGNSWt?=
 =?us-ascii?Q?XHHVnm4X8P2L38Ok2M0m1CatRGuBfUr9zFZHBezjyWroO0xDLCN6ne+fhaVz?=
 =?us-ascii?Q?/k8EHcsAI4rminZjV5EtU8/m3JAJOAbwabT6rdZmbXiH4qJt1qgjH18XGxc2?=
 =?us-ascii?Q?/KqqXwPsoloAv7uwIQjR/OSGmLWU5ilidnYWNWXOqE/4dMf0TqSjcJKbsE65?=
 =?us-ascii?Q?9WHxQLqkQQlDBt3+xLLNx5y/lZFH4CAP?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?17zHIKoPf36G7ePIhNNv86BKUIuNkOuKYQngmC9HBU6VE3z2OHcA3ytcsjAN?=
 =?us-ascii?Q?MRJrh2EopRjG7zt1FgV0AlO3qy0oDIDW2b+amBjs1JeDmmtmxZY8txPSOEc2?=
 =?us-ascii?Q?aEExfb6apccPcZ6YSRM3Uuu3haexac9M3oYTHuDENyD9+/FqbI2brw+Lrh1d?=
 =?us-ascii?Q?QRWbpkWFaRBQEqkj/UILpB5AmZ/M2t4lUrvfPQXyvyf4y1JAduAeo1jH2Fqp?=
 =?us-ascii?Q?hIH4v2AVCduKzvgPUdsW4Sa+no9riukHk0+m+B52UlPZ6SvrwRJzfv31Lzwy?=
 =?us-ascii?Q?QzEwBDyiVEDuy4wS+oa9dDdH0hEZGzbE0OjRGEhMSmOmMEiN13MIDyO4iADY?=
 =?us-ascii?Q?FBG9CgmqQeJba7r8k0x9J+NiarSHxO5a/ncfBTqJETdPtlDCvENKBZ/HnBt0?=
 =?us-ascii?Q?4QIEoHj9Jn6g5WRtqf2HWIhcspg+I3ABoeRcJPTDZ3JR58YNt+ZACy10+F8N?=
 =?us-ascii?Q?wpaN7zHfjePRnkIPvGBtXoKEEs65WTVXLUtyBNIQZFceYOBKZ/y5Sop55DIW?=
 =?us-ascii?Q?L6SDZHOC8Wln6XA3JrvK3mkH511knCwlA7yJTDxuLXs0f2y3zVYljonZvMFj?=
 =?us-ascii?Q?4AT/0+v1X3z6b2/XOrULHz6RtK7kjMODchU1EUm5Em53p5DEa2PjENZJsVgl?=
 =?us-ascii?Q?pVPoB6QE78zsemMfrylxXwhgkw945/Rdl76/bx592QFPUpsxs3STKDG178fQ?=
 =?us-ascii?Q?d+Y/sUweGDJL+YfN0VnnMpAHEr+mEvGlFTwz87iDJxwK+vix5lmbMuJMMnJ1?=
 =?us-ascii?Q?Cwu6ZKW5I+uVh15KoU3W5GjiUXH0Wc1sDMnfm6Z7MRaRol1BNLeBLIesWFAa?=
 =?us-ascii?Q?R9eUpkKaBEkijr+KROw//ph5bsQSwDPSkr1QjuSgKjNDOCQH/xYyC4w++7Dl?=
 =?us-ascii?Q?6yEOxco9h/NpPjREiM3exfvY+9APea2J+yoRfpPgSXh5XEbODSDOstBXt93m?=
 =?us-ascii?Q?mvhsCKssfrhNSYgLm4EQZYEO9ADMqx+H1Q03QFFyKgdJ+0XJTixIdRerLQcH?=
 =?us-ascii?Q?GLsXFozmgjMjPM02fUqacYliL0OV2IeM3W8o2McP7LMPaTkCvc7nBDpjdtJf?=
 =?us-ascii?Q?LxY9Pj4X0nGpzCRj9DJEBrtYRFkcm46jhB1HIh+sc9T3miIYQBaE+C9FSDy8?=
 =?us-ascii?Q?M02PM+x0Zj7QPnD/OlynkcjNP7sdQpHDDppX6lOaVdtoxAtlyQ7I+t4Jm21J?=
 =?us-ascii?Q?bWgMxY4BibZOncvQTbhO0K46+8+RLBCdLNKUMrHN2f3sWeNYh2VJbCICJGwe?=
 =?us-ascii?Q?CRVMwqs8Ao71ib39o0GbRZ5rloKB2c5p7z+l5ABfpCP2o4oCBdzIe5hbOwMc?=
 =?us-ascii?Q?km6QNc0jgHEkH13Vg3Pnj2sRwi5Y7cw93bH9Hljz3sKANXNDp0h5kxoS+Csv?=
 =?us-ascii?Q?k9DOM/y96/YTGvyZbGRlu0IwJfyAUBohbwFfYTyzTsqJg5IuR0lTlavrsVY7?=
 =?us-ascii?Q?3McObjkL7SRQJ4w0/5k0k6IeLcqgi5pyI70AtGbRmo9CiD6Z7lE6PyVz5A+Y?=
 =?us-ascii?Q?SaSZn9i3MsWy/ysE1Nf6EKNXEAnddjM603q/Cs2BTKfWnMb4+i2L3K5LOu9Y?=
 =?us-ascii?Q?m8Vri7Ns8NdqUBlcaX6xkCesubLqjx40+VafHtGC?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f12fc81-ce6c-4178-edb7-08dd5d8c8ee3
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 15:27:23.3688
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g0XyDKT88WspYGxUG5usJDSuUbGVi+mt5kpl+QPMP5dW1dgCelKAQ4YeQq3oZJX/Azqm8G7PMClxCGv+IgUssw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9694

On Fri, Mar 07, 2025 at 10:19:50AM +0800, Sherry Sun wrote:
> According to the LPUART reference manual, TXRTSE and TXRTSPOL of MODIR
> register only can be changed when the transmitter is disabled.
> So disable the transmitter before changing RS485 related registers and
> re-enable it after the change is done.
>
> Fixes: 67b01837861c ("tty: serial: lpuart: Add RS485 support for 32-bit uart flavour")
> Signed-off-by: Sherry Sun <sherry.sun@nxp.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
>  drivers/tty/serial/fsl_lpuart.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
> index 91d02c55c470..4dc2f3e2b8e0 100644
> --- a/drivers/tty/serial/fsl_lpuart.c
> +++ b/drivers/tty/serial/fsl_lpuart.c
> @@ -1484,6 +1484,16 @@ static int lpuart32_config_rs485(struct uart_port *port, struct ktermios *termio
>
>  	unsigned long modem = lpuart32_read(&sport->port, UARTMODIR)
>  				& ~(UARTMODIR_TXRTSPOL | UARTMODIR_TXRTSE);
> +	u32 ctrl;
> +
> +	/* TXRTSE and TXRTSPOL only can be changed when transmitter is disabled. */
> +	ctrl = lpuart32_read(&sport->port, UARTCTRL);
> +	if (ctrl & UARTCTRL_TE) {
> +		/* wait transmit engin complete */
> +		lpuart32_wait_bit_set(&sport->port, UARTSTAT, UARTSTAT_TC);
> +		lpuart32_write(&sport->port, ctrl & ~UARTCTRL_TE, UARTCTRL);
> +	}
> +
>  	lpuart32_write(&sport->port, modem, UARTMODIR);
>
>  	if (rs485->flags & SER_RS485_ENABLED) {
> @@ -1503,6 +1513,10 @@ static int lpuart32_config_rs485(struct uart_port *port, struct ktermios *termio
>  	}
>
>  	lpuart32_write(&sport->port, modem, UARTMODIR);
> +
> +	if (ctrl & UARTCTRL_TE)
> +		lpuart32_write(&sport->port, ctrl, UARTCTRL);
> +
>  	return 0;
>  }
>
> --
> 2.34.1
>
