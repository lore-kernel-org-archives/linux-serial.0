Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013022.outbound.protection.outlook.com [40.107.162.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18EA22DCBFA;
	Tue, 10 Feb 2026 15:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770739011; cv=fail; b=Po7ItyhwyenGYwk+7NHcHnYRT2MxiNK3orHnnD12PTjUmDe82vTw5oSJekQjROfipKb1wRTk767lyA6lXo96CpDjHlsnZE2VcJZ1YKRMAAcryoau964V/SFuPGRkA4/upsTlVqpSQi4v9sJmny2hvAKOJTWAOne2dQL3n8XRyJ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770739011; c=relaxed/simple;
	bh=vO3HPF5xZKHt+I1YxYurioc1w8sziE9b7RVDoV0Zk/M=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JEsWrVCei3h232OBQExvoRxatIeqNukSkMYWcUqk/80oX/apiDg7KrIRTyqkEdt0gjR44Ch9ER5D0S0pHHndL5OuEtzsa29/rc1mS2tOG71kYB9h/7jiAZYN1uVMM3L8Gt/re4zf1yZtODi2YvkFyKN5eqsLW9kgFMbiFsJUzw8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Nng0spI7; arc=fail smtp.client-ip=40.107.162.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Nng0spI7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AZWS0NGUugFfN8D4MSo2jcIbTbl5+IRguy7zbjiufy6E80ec46F/Cv9j1qJ4EEA9Fc+Qsz1+EVTJdMPvQL4Sud66ndd9q/5GU8TAfuj2eOzKuQXYfsuc6O7abtQmlx3XF962hKKfflRc4kvQJYic0gShJ8pFmWcDH2qHy2jf9fsaumZS7QBGLYyZPqIntxvSCX6a1EWco4mQIRBbuxSLahozPjaMUQ2dMOfMC6wB2+TcPcXY/oKIarCGspdI//xJMrHFlwGyQgEfhw7jKna3XXbq7DwUts//cy2csqZs3sSpU3+940W0tKNJtyg5LYiaie0mYmyysx3uem9miLoeTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m6BWi9rZfnjo+3b/0LkfkjRXLdySRdPdWvFaEqWOfKg=;
 b=oSVa6o33+iCKP1h+Uh6UfcYvuzN4Xlg3CHbGZjkWcm2pKIpe/OuTCprQdnF1+rhGdG5MuqpuVYRDcIki7xsRkF0NmpaHOrAtf5Smq+7jo99LzLX9VnRMPLP3KxaGKhfwDcwnA336noR8PUZHausDyu25T59TcX8R73zj6QkxLyWmKxawPUmr1CTaxIHJC6XEHLNZXV3vn5oiodl5ZSRa0vJtWSJrLMHl6TfbVYKt8gAuyTNpBhSsdNeTb7cA5V73UQTPNedAl8g9z/KfG0ifW2WNsAbF+xdeJx7UVhAi4I7spv/9dvWG1o71xwLwv/nUHtC6sTJ6hq6ahTJvJPxaeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m6BWi9rZfnjo+3b/0LkfkjRXLdySRdPdWvFaEqWOfKg=;
 b=Nng0spI7yWOmzPwAQQgaFA9nSqhIKZtMdhch8RuIgoMmwZU3RpFXkC4Gj7vYyN88fTctU/vhAWxyWuJ3qrrjS6e09wER5qHsf4w/qxPKT+FaUj/m5SYnwSCX9hgQ29qnkbU1OgKCeJg58HZDG0ZLd8G4Bwrhcm6yE1KrTaPzXNwbpWzJjlCdfmw0rJfgWWDLg41z9N9DU2LlGXO4u2dMlq4XV7eckJ4MyXu2mj5PGzM7Rtq17KD0ZOT6qEO5mUlDecoaL1bQM1JbTXkxfHrMisHLZNUtOu+RZDDGOfKNVxtilejKDvKFIy8Jql/3AQBj/A8V8f4wl/XcT5n0heluuw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by DB9PR04MB9498.eurprd04.prod.outlook.com (2603:10a6:10:360::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Tue, 10 Feb
 2026 15:56:47 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9587.010; Tue, 10 Feb 2026
 15:56:46 +0000
Date: Tue, 10 Feb 2026 10:56:39 -0500
From: Frank Li <Frank.li@nxp.com>
To: imx@lists.linux.dev, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Roelf-Erik Carsjens <rca@thorsis.com>,
	Josua Mayer <josua@solid-run.com>, sherry.sun@nxp.com
Subject: Re: rts-gpios support in fsl_lpuart driver?
Message-ID: <aYtVNxZU4tqtj2fo@lizhi-Precision-Tower-5810>
References: <20260210-rearview-hungrily-536a95fc3385@thorsis.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260210-rearview-hungrily-536a95fc3385@thorsis.com>
X-ClientProxiedBy: BY3PR05CA0018.namprd05.prod.outlook.com
 (2603:10b6:a03:254::23) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|DB9PR04MB9498:EE_
X-MS-Office365-Filtering-Correlation-Id: fa31aa72-9371-48a5-92ad-08de68bcfe7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zNyXDP2k8zi8KwA8CAxkDWA8vKS6RCej67S9iNdb6F27SaoDKVkxGFRc3yEz?=
 =?us-ascii?Q?OYcmgayLxJoMdxAP/BLJOtSKKRYcjYxKSTRC6fmoKoC/5yUbDf6jCfOIIIfD?=
 =?us-ascii?Q?kpGeGUr/tQ8pL28vSbP/ZQbc0fyg4C/0IihLPzyRhWw5AnKLg2ernk+q3+q3?=
 =?us-ascii?Q?/8B3irRhn7NbisrVRIIHYjp5YA7/S2Q7g1TDsyp0DDJF4IIbECNIDUHswMHU?=
 =?us-ascii?Q?Pk0UvoQ26b30Kw2QQpJL8QKn9k01YChTNIZUwNAi4t9eJoeIOGsvLANzVwvH?=
 =?us-ascii?Q?gHM76eoyoaLyVk6g5AxiByySD3Q4TxHYy98ECYKJgfhy7RnizaEKeWCUrhMp?=
 =?us-ascii?Q?0pgk9YXFs1qQXNVIJ1HfOfFV79t3/rnzx7zVCQi+FAejgHQ41an13RzxJjre?=
 =?us-ascii?Q?v0UOK++OPeaG9JwrrSNlv6X6bS759ym1/RhSPWadXqLKVPCbTgv7pxrgaTdo?=
 =?us-ascii?Q?TF2NAIrgxwHGpRnCukkWbPFqG4FCP1Eumh6gS2+2y92rIzkBofcQOI5i5UJA?=
 =?us-ascii?Q?SWNSGoepKd6lo4KqQOUP0idBJK3KnCHed6Qcl0egnsfsZ9muYHKR6RMsC3zt?=
 =?us-ascii?Q?sXcysTIAbbB1rfdoF2NvAmdwlJlsR9KSBFiI8LE36Ghc1Pi8vavzndQwn285?=
 =?us-ascii?Q?9Jir/GuyXrUHNt87DHnWUyVsm3DPByrrQqFWufUmMwOSyNMuIoXRi28g/2KM?=
 =?us-ascii?Q?SAtxje5XCD/HPJ88v+v1LCBj/Sh19mxo7l7Qp2PCc8nV+pMQPcvjwX/CD7Uy?=
 =?us-ascii?Q?cXzj4HzkZ0gmm3NpWtgnH0p8lbqyKLlf2qFYn/G1Gg1Dyp6OAGw0Tu76l4t0?=
 =?us-ascii?Q?vOyqgB7QU4nTuYk4I1YTxk5mmrULj3Q0atAVQfuWJyvydGcG7/mH2vLZzCQN?=
 =?us-ascii?Q?q+eFqSOASpc2XSVXooTofJAlgT+oN43dyLrX29IGkue1C9fBM/tuEbEvI+Wb?=
 =?us-ascii?Q?wnH2KjTSZTd4qoSmwaIT44h+/cpTMCVuZeaVaOAAp04Uh9bF1Fz9BH7VPp8z?=
 =?us-ascii?Q?k0niR0zLiyPfLP688xAttpfrIIIZuUSmF+ygOllyoBjDX+GxnVr3L0inlc0l?=
 =?us-ascii?Q?qpab2A0dq91zXkrPohTeBjp4fkmWJ4/Bs09zgq+UQOHdKSVeIFsjIbAhQS/3?=
 =?us-ascii?Q?mCEN3XC/7WNHeThMFJ8n3m9zVwZ8qBNT1Kcj3O6bgMAVcgS54PL41xL0yjvf?=
 =?us-ascii?Q?s11DWMbUgVhqbVzstNwp2g4ZJAW1B9evd7WY8O78Z8GN2lb45JBb6QA1TfZC?=
 =?us-ascii?Q?TnqJTQPwm9ZK/rWQMPWW/NAnMgEhlTIBy4X2ybujOOpi6sTppL3aRgk3E5SH?=
 =?us-ascii?Q?llBRscePIWnOKXQaM4KWpZicO5KX2hNnTYOlNQn1QPaagWz/kDjugmtdNvSI?=
 =?us-ascii?Q?+ngzCKPTlrRm9enwCZpgz0uD45/dhKGsWh536jQg+YxfgoxAKSvP2Y436net?=
 =?us-ascii?Q?/eThLTJ1aOWvFKBIlTMcSA4JGRF/zRK21NmrQtrgrEttuCGvC98q5IBa4Jok?=
 =?us-ascii?Q?aWG4/5zgrAC16XoBXpTH0YJW6/zcOOC8GCKdmOb+MpcHO625YOaXA+jOcf9m?=
 =?us-ascii?Q?MBoA+h1rJPNrqji8jr6gGd4BLg8c+jnk3lU6W+zO7+MC8KHbJoJuJifiGI9b?=
 =?us-ascii?Q?IC2lvpE86kI5oFFtOepVAnk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tAryszLQzEA/pQxzSqdsjtgO1fNJwZrcSC71NJ3cbhZRdy+2e/9OCTQmLIQ0?=
 =?us-ascii?Q?Ja+IEhOLRZj7fKbxAmkqW1ItHFiNdVxv0mPCXDTDo6yLFDXCUzY1TBFWThdk?=
 =?us-ascii?Q?HuOA2L06zu6++VJzLi3MByAASklr728I7kS1lY1T2wcydOP4jx0s/K5PQxvJ?=
 =?us-ascii?Q?CMxg/SiVIi1LpknQ3oSJ2A06UpJlPERdpX5ArSAf/Il1JfEFS0Cwx/6MwcY2?=
 =?us-ascii?Q?dqXDxyuyEidyaVS5gz2wyTRnWpLbUwsLCsTVQXZeRp026ShbJoNagwJlh3wJ?=
 =?us-ascii?Q?gJZjjnnYJIjYQaYzVGtc7Ijrt190cDuteVqUfHQKIbrIDdE2zkEZW/CZ1RQp?=
 =?us-ascii?Q?vg8dpJvsFYUq4u8NrCh1hcbUI4QUW80Q6DX9ETAx8ftVnQOUZN1OQTl1hHhs?=
 =?us-ascii?Q?0yNOhlwf0M9DwbpID3IFJjef6DYC8bx8UswuS4+8MLWTQRaVnTNlo3TbYGEM?=
 =?us-ascii?Q?41PVkT6wEcFeagGfFd74RfKsRTi4cBFXJ/cvoNVpe19ZuLFEmQ3iTGxm8cYl?=
 =?us-ascii?Q?2kUe7/eU+JHGkA/ySGM06pX6Tw0Nj6jWiwtnvF87bbObtvH55QoZRlpFIKUh?=
 =?us-ascii?Q?w/2NbNzXlKb26skbsH1Dr2hukqf+pH9vJ20eZYajdRVbX45TSAYS8AsSwSyz?=
 =?us-ascii?Q?HkeDVcpjtubQVW60zAf+wPjNA3ohiAmWuLyqvT0wcTB7lMfLtW3T87muHjC2?=
 =?us-ascii?Q?rL/LinEp8NAlAO48pR1ShpvM5etFc4d4g6N9edvpE24PN92GH8XhKhkMcYo9?=
 =?us-ascii?Q?5p/wjEZC/1qeHElwv15L4lfxcV9A2pjCWGy2shCkg+kaM+beM+ZG4Abur5iP?=
 =?us-ascii?Q?vKJ9eWX+P5TrxRMby7M0gxQWwJUefEtUSxjDUqvg6lVBWDVj7aE/DPwLnWNw?=
 =?us-ascii?Q?7iRZ9Fw6EfiVylM+vlGjbgmbY2L11S9ufnWS6byu3srKLMZ17hsxsqLV/KlV?=
 =?us-ascii?Q?mBZ/6fAGwjYKRXY1xUTr3XFfxW8kFkM0bDDd3+C+kPd0yZJ/lxRIy5SRI6Q8?=
 =?us-ascii?Q?fniJal9DC8Lzwc6ZrDLIe80Y9pWQ/vviarc0QyY7KNhoiSq8MH2jJsyFYZHq?=
 =?us-ascii?Q?tfp0PSEXmsewt10x7o3T7t0fBMC5ILMCT3VL1Ol95fgY7Cn3QTS9KlNqW0R/?=
 =?us-ascii?Q?goC+4z/6Z1suyTW1DtPvFy7Ew5tBtlm15fx06S8L6UDCTFcEe8ROyU7/dElR?=
 =?us-ascii?Q?wAeN0Cm1Rbxwkp+Nh3US7MjrWBpLWcKV1/I9jUCAthtXtBevQCWeexMaSxMH?=
 =?us-ascii?Q?nQf87lQc6bYAvxnPlJbVvWX/6Br8FBBxkIcIVM69kIz+fovFqw0xpGeAotlM?=
 =?us-ascii?Q?KS6iyZV0poqr3Vs4abL+n8HGz5TC7/ATvKNOUjctD+7OV9QNhEaCjqnaT0Ar?=
 =?us-ascii?Q?7Fp3S1z4A3NeQNfoGBD5CNyW4dOcV4SrGKwVB4pnlGMrO8OFULdMx89c8/fE?=
 =?us-ascii?Q?O7vaG0eQpqkCKmI7MlTVoteEb8CCvqWnS5fg+NZtzECbwU2Vx7WXv+7gDDna?=
 =?us-ascii?Q?Q69ajnC9lmJ8thr5OumhfqQK1RrvLzGhYOZubH+gNkDXoMu9tYsoMNWKT6lD?=
 =?us-ascii?Q?xjs5tITsBJ/Fm6oqoeIyL/uPt4s7ZQ2Q8B44tW/vjSw4HmJEaaA46+9GTwNN?=
 =?us-ascii?Q?58X7pTmOPFZlK1bIkVgkBSq2OMKaUgcDHoU/njrG74iu0CUnTQeyLmxm6vfa?=
 =?us-ascii?Q?zgYlHffAL2bZ5uCZ19TKmh69d2Yb7vWxXGq23oAzI95Anmhj/9fqzwjflEM6?=
 =?us-ascii?Q?WL4Qou2SMg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa31aa72-9371-48a5-92ad-08de68bcfe7b
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 15:56:46.7605
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lUYwpHBDCDa2+F7gvPajJ6+JbAfm0OxUerA8tdeRy51zmmRfRD6mrHv0JoWrprk+pS5NkP+yODoNi9pyg+7YmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9498

On Tue, Feb 10, 2026 at 12:48:05PM +0100, Alexander Dahl wrote:
> Hello everyone,

Add sherry. look like we have not implemented it at lpuart.

Frank
>
> we are currently experimenting with the SolidRun 8XLite SoM featuring
> an i.MX 8XLite SoC on a custom base board.  Due to how our peripheral
> hardware is connected we need to use rs485 with uart3, which has no
> native soc controlled rts line.  On different SoCs you just use
> 'rts-gpios' in devicetree then, letting the kernel switch this line
> through gpio.  Alas it does not work on this SoC, the RTS line is not
> switched at all. :-/
>
> According to my analysis the i.MX8 family has different variants using
> different uarts with different drivers.  For the variants using the
> imx.c driver, you find dts files using rts-gpios, but for variants
> using the fsl_lpuart.c driver you find none.
>
> The rts-gpios property is evaluated by the serial core in
> `mctrl_gpio_init()` right?  And the actual switching is also done
> through that mctrl_gpio interface, right?  As far as I understand the
> source code, the serial core calls the .set_mctrl function pointer,
> and then it is up to the driver what to do?  Some (like atmel_serial.c
> and imx.c) call mctrl_gpio_set() in the function mapped to that
> pointer, some (like fsl_lpuart.c) don't.  Correct so far?
>
> Up to this point I'm somewhat confused this is no generic feature in
> the core which works for any uart, but there's probably a reason for
> that?  Maybe interaction with the actual uart registers in some way?
>
> If it is like described, I'd say the fsl_lpuart driver currently just
> does not support this usecase?  Is it possible to implement the
> necessary things?  Is anybody already working on that?  I looked in my
> mailing list archive and in the imx downstream kernel, but could not
> find any hints.
>
> Any advice welcome. :-)
>
> Greets
> Alex
>
