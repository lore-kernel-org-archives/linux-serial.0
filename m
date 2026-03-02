Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010024.outbound.protection.outlook.com [52.101.69.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30899282F22;
	Mon,  2 Mar 2026 21:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772488064; cv=fail; b=tRySFDZ76CIVx6COGjd8o0V/qVQSgxLcn9laCKg+qVL4WgJQAB3DlLSSLcS3SvwynGhEB7WsEs203/dGtyhuI0KbWtcpDKeJBE6q/vW9QZmP2e2D5Pqjp08qJ28zL4VbZz8X0INE6e89K8TPYm/ltjDEtoRJY+LWktzngJLMnO8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772488064; c=relaxed/simple;
	bh=SorT4txOQ/urNV7wg0uMIj7fWez+dq7zH3fGqpGSE8I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BQQO0/QG2Un4uWmXVfb6YmvqlianfvlkQnxe/WLd4Bw5kJ9Hg0mX5ibFGJoZYu9sJ4rGOpDkbR2DHNFqlVA3XDACKd1/PpGv9Y7qmCcfvv6NKBKGqYNCYIQX8bInRSYSDCDBR2nEQX98VfF/ktpwmAHdshq20R7++OgDyephFRA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=WLBPZp9d; arc=fail smtp.client-ip=52.101.69.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="WLBPZp9d"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QPb1NaqNOpHJKe3vHwE/m5YCfdkoLlxDSfaKBzl1Ld0r/Mb7KVXq/+cyc5B2z1KXgaMaOTCTaj9QIAxapFswaIWIRf4IoOuLV9B7i/CS/UAx5CJvVhOyhQhOq1V4KOsdt17rnJCcOy9Au6K0FMEd79ZoyYdriRbtTJWo+xsfZeKw/lY4XW105Hkis9gnuS1EI/G2kfeBMRQkplyFWbk7pJzc27L0hrOh/VGUAnSxk3A0h61c5tR1AylvYOPTJNEhJRMzbVTnaP9ic7JHQghrOgcS+wZjWMQ3aoz1/0a1sB9R4AAb+gHwJJDi7FbAw43RvPnf8VVqleirNHLXyrldsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZMo/xbHVS2gmXZ+GIFuO98l+Kxas3Vx+cFOXJKW06co=;
 b=W3Ptxc8SgU6f1DhrPu6yPTUXt31DC/GB036OPV+xmNLoZM+DrPp09OlZe9/cskphf24PEUTue3wv4FlGqR6RIXIH8+E1OtVU6gzd1AyXWlI0VK03xtEVp2IJq/gkA5xU34CLIagEl9hDBO+i27TJNiX8y/I/SxglXf3g7Mvcv+yFh/sHDg5nRDRoL2z5xSnis1RV5FAKWo+IBmPsMLyn/Eu/p+y/RWlbHrF8D9XATk5jbkBUSeZPl05RW6aE2y2nIBaIDjbD+IztrdkkgspFYivK09aQZWCKcNoxQVN6TBWjPz+aykupexaEeLEbznDRiVVW3MNJ3/zdg7wjNMc0tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZMo/xbHVS2gmXZ+GIFuO98l+Kxas3Vx+cFOXJKW06co=;
 b=WLBPZp9d/Y/L7++me+XoMYfdoo5QLvAQoxisulXHiiNUYLMceLiRwSu/fu1WeW/LThe22U574DYAE/pdfIvPCrysiqIdIPg3ZoPnUHQupfp8JJIyFcqQkCF0Jj3ujV/87VOoFhfiDjqweJdcjx9JmpHXWOJW0Bde1Rq75dzvMMuF6WfrF0DTaUBUY11IDNTL11F9BUcOjocKztCETo76478XpM+QHbQQolvmJD2M3tOTKo9il2gCgcMNzWNNeEUmW+RsJABzXXylJfESqwBjxTL685EjH9qe5gmoWs0O/AdZhCVdyRCjVW67vx8kwWVX8r6CSJmYH10NxrFfepRbgg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by AMBPR04MB11840.eurprd04.prod.outlook.com (2603:10a6:20b:6f2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.18; Mon, 2 Mar
 2026 21:47:40 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9654.020; Mon, 2 Mar 2026
 21:47:40 +0000
Date: Mon, 2 Mar 2026 16:47:34 -0500
From: Frank Li <Frank.li@nxp.com>
To: Zhaoyang Yu <2426767509@qq.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org, shawnguo@kernel.org,
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
	linux-serial@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] serial: auart: check clk_enable() return in console write
Message-ID: <aaYFdpi1jKvyu3Yr@lizhi-Precision-Tower-5810>
References: <tencent_AB29FADF1FAD67D818283B6BB4FDF66F2F08@qq.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_AB29FADF1FAD67D818283B6BB4FDF66F2F08@qq.com>
X-ClientProxiedBy: SA0PR11CA0117.namprd11.prod.outlook.com
 (2603:10b6:806:d1::32) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|AMBPR04MB11840:EE_
X-MS-Office365-Filtering-Correlation-Id: 027d2237-7593-4ffb-b8d0-08de78a553a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|1800799024|376014|7416014|52116014|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	W+gxSZKG0A82tG1xJMA+VRbvcT7U3xcrFxrBL+soMvtQGKckm7raidRbYFcLKx5p+WNFMvzqThHE6F6aveN/i3PFJ4YflHcvVnNyuis1A47/a5EvJnuCGCdcjuKQbEM+ODHwHnSBFAxRNZIvmxPV8JIjpcdIMqT4lgOpx07rw0iHgGj+v+Z9uw823YDA2o7aqBE1VYzW8wF0tr0gXb4xvRSghrnzhFbuczZwXS507+3PJ/U5f6bD9/mJxehk618CEcWWjVbQTIxds7eKD535qLK7Tf+SBHdXagKpszA9v3eppVsx9zO501CxpdwZqrIpsnBc4YkT3XCfjL2qrIBgwoRm2xNdIigQmxMrrdSMac/5fQV8QhWyOOc+0oySBozaYSj7EsicuEonO1753av7w1RdC2A+F8+gqbcX8H70UO2PEHGAh6sciZWMNnV8rcZwutTqvVwcvfWrqLL4XC/mUdZDvCZol8jmu+yOIwhdp9mc0/U6+vGsU/q1QgaKT2Ki8Kj7+juNdZpSyCXEtNxhjtD9sv5/+2ZfUj7TOeOmL6YqBqcDSfYiGZjf0l/i27kb+KZrzkSYGt1EXNS6VyfuAlbuyFV2Izvtg25OEimRzj3PPFNWzAaGq9M34DD0CIpRKxKcCafN4mBcqJ0tKMQzOo4sFQeDE5OkkBSC3z2MrC9q3R9aLSRx1qAfwhZbFslbr97wFnGPFf3W2iRs9856T/6r2n9NuTf7dB4LRNtisE8Cdb4zWEE6M3TIVFeS8jnkBY3PNd55/AmACholMYI67W5tMptfaumnCCBo1MzBJQI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(376014)(7416014)(52116014)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yZwvDzwU6TyhLn9WhCDAQQijg6POa7Li/EkzaPP+Rd4kKpAmRoQV3q4UKNj5?=
 =?us-ascii?Q?hftrojV56ymtAL7QyZz10T7IryEfOBGb5/nfLfNrvX4cHbQDZ8Xsk4gUUk3m?=
 =?us-ascii?Q?Pe9SFed0bIwR+CDRvMaN2rVqircswPaKVGRxCcDhegNKaTsnoPvM3pdKWCrm?=
 =?us-ascii?Q?+kS33wLj1dkey6g1y2zkAkcx8JvQMLhVSwOF3N9wBv4oXnKkBRok+gNBnBf+?=
 =?us-ascii?Q?2IWxgCaEM1zQ/WYEu7UeeC3UuwyIV+bEQ3fsNufaP7HmJBM1VhfryTuEXE6X?=
 =?us-ascii?Q?qjLf7IcuDk2Nq6TewmOVV8cg43XydB+GJXxxSge3xXpeeuCgWQEVf+L0izoB?=
 =?us-ascii?Q?qqUw1MYXTn9DHs640CorfLx2wmfC6WabpWsa0yQW/yOyg6VRkVwPj/ZAMXP/?=
 =?us-ascii?Q?EiK/2D2C4SRNE+n6LLGW3RYC3YEe807GsOVl8CaK3QWk54X2bUC30AVxEPST?=
 =?us-ascii?Q?ewdZglNpCFrbL1MtiEUzIiWbvlVf2guy05EnS5tjbE6EeOIdHtX1uWdqApqk?=
 =?us-ascii?Q?d+tJK8uAkxLQxBZ94rC0fuaC1OvG/zKgTZpTw+p8uNVBa2ceGHIyjsN7CSwf?=
 =?us-ascii?Q?cvqsiS1b9WQBU141OrKNv+bd/yJQOuBK7nmXg7Sy/Tx3jVUlNxWLfubSMw6S?=
 =?us-ascii?Q?+6Hrjcvu8mXXvsnbuF5k3sbROaFESAM/c3wNVUJtNJIXDwsRKAiOFF+WAFhk?=
 =?us-ascii?Q?vcwgKp3rUrLqJjtofNhYv6/WtDSv2cfNyqKdfLOpP8Ftekhpf2KIt+mL+FIH?=
 =?us-ascii?Q?IekUAcTLi578hdEgAYXDbacSRI6Z2NDPN72Huq6w0b6WDJOtpAwJiRRHswj5?=
 =?us-ascii?Q?crGZRfgMvTZyZdlP+ddU5PdxNYO92sIdwE3eRp9yIIgvkyo2AnS6bZ9MaVdY?=
 =?us-ascii?Q?cdLPVN/jViM+dxcH9QQri/2DSTd0Yl0LEmk9XV05UhjZZ+N1SzdI+PYdHL5L?=
 =?us-ascii?Q?ujshW/t/8AIfry3m+osX7lOdBKOjsrK3bzKMJvmABmJeXhg6byPbPESykEXp?=
 =?us-ascii?Q?Vtsxyrw2HD0pBqUxPEzAtXcVZ94ensBJyVTL4jxm5mV4ApZmGRGMYMH+TfQk?=
 =?us-ascii?Q?94+bFLER9K6CSp3VGHH+iLkTUtJK7Y7b3OthdNyEwf56HaQeCt+FF0q5TGLs?=
 =?us-ascii?Q?rzOXzbPnu2azwiNx7Pdp3H6is5jd5O+7qtVT24JDoVWvYxlmFsKJvFdttyp7?=
 =?us-ascii?Q?pXvqSrsUWbX17kzP4uTYLwsI/MhX1UIhBR6uLtflUu1Tt1hit1ewdNqy9OUo?=
 =?us-ascii?Q?XlqwdEjqF1c99EJIFsk1SAlGHe1q2SGBYAyOt4NBb0v3qTknnSFPJOv5FeaB?=
 =?us-ascii?Q?MERcxMzSJo5o/3yll78rXpSC224aB5hNnZjHdrqqStPbF8YcmSzZGjn1XVmu?=
 =?us-ascii?Q?jP1b2alWNIeyqx5MwpO0vsyxL3YpOuJJaMQdrsdi+ui3AiOsP/BCazLhCWkC?=
 =?us-ascii?Q?BgnSODXq2BpWxBgPhYZcrM6QuxT34AOov9Y12B8cK00NtQ8zzH7fBeJDxYrQ?=
 =?us-ascii?Q?OGNnpz4um5TTPFEt5X4aF6qFBU3cPeKlHgmclL4oW48NhN/zheVfRvzo71Eu?=
 =?us-ascii?Q?jnvjVSEQl0gBYmBSQ8nlgVb2YS9xkZumFlZSH44GCCRZHjH1tWOfxd82eap3?=
 =?us-ascii?Q?FnSooQUMBieioVI9yJDd0X3BFZDqPLd2prqIwLJbCPI7vYDgFwtBFK9HBeC5?=
 =?us-ascii?Q?kevKENYS88vRASWy2weNu2jk3NKCuuCwclG/trLUbk2P87rf?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 027d2237-7593-4ffb-b8d0-08de78a553a6
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 21:47:40.3319
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r4E3ZxaAGZUSbienxcKExSxILsw+P/SLSzr6S8kmWpgxQ8W8NnKxeSVVBPPKRwS7eW+C/w74griahDoQW57yOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR04MB11840

On Sun, Mar 01, 2026 at 04:22:56PM +0000, Zhaoyang Yu wrote:
> Add a check for clk_enable() in auart_console_write(). If
> clk_enable() fails, return immediately to avoid accessing
> hardware registers while the clock is not enabled.
>
> Signed-off-by: Zhaoyang Yu <2426767509@qq.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/tty/serial/mxs-auart.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-auart.c
> index cc65c9fb6446..693b491f1e75 100644
> --- a/drivers/tty/serial/mxs-auart.c
> +++ b/drivers/tty/serial/mxs-auart.c
> @@ -1318,7 +1318,8 @@ auart_console_write(struct console *co, const char *str, unsigned int count)
>  	s = auart_port[co->index];
>  	port = &s->port;
>
> -	clk_enable(s->clk);
> +	if (clk_enable(s->clk))
> +		return;
>
>  	/* First save the CR then disable the interrupts */
>  	old_ctrl2 = mxs_read(s, REG_CTRL2);
> --
> 2.34.1
>
