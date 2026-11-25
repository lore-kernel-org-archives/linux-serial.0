Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.59
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795639539;
	b=VxQAg0xVuRpoWWC1MuAVUcWn2sPJgck4Xgeji2lhW3YR8PqoMedAhl6/6V+LFmAWY39T
	 n34H+MqNNRLRXqz0iLSlodo5B8+xm7x1uyMcvZOtx8Dol3qiyiNcTx0+Qx94QiqsFMGi5
	 vk6EPabmr6Yag8gnh1HSItIKZy0I+hTUtdRBMG2cRs9QYvn+7SlGhlT6CdFYthLvyaVQT
	 v3KoclOiBH5jURZueJcdUVRpX/52koHL+K9jOLzgGyfQ4ChN/grToynX4So5WT7JlPzgh
	 3io0YUDk5p3jM8d4nzdSwi15HlqCWOQzAP7WRhOrrs/47cXTgJquQw5CeLcLBGvKAQw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795639539;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=7e/LQ2/hz5T58I5dcZESzD1uK17SBLPurk+OEpHO710=;
	b=sp4kN8tUR+Hq+8Z/xFrtRAjft2J+ucCVV4fPpCEyiSnJxG8zUDoCQ/sJNdKJ1An0bsFR
	 TVNvSNnumjgccgwb33cmEqEWpL/fln5W9EEuWK31MJwio1fxhz8nqoAZp3rECCPGLDnIe
	 PZC6eWDNibpKd+pUqPh+FQj34gIx+JEbpeLiB0ypVSlgmzHwW16oK5QDKKcWVrPiIWwx8
	 3aQTgMNBr7M6HdFPQkHw56ji3gmu9VrGyJvmWcSVsHUPBCGUtjGeELwGmysG3uBt7ysgg
	 N0fChNb+J8r+sEyqr34bXyLFmWUYlrpXHB8sfucwsTG7r1zdlN1EW1jdyJPyxTBo7NQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=MpGPi2A+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.59
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013059.outbound.protection.outlook.com [52.101.72.59])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6377E606A31E;
	Wed, 25 Nov 2026 20:45:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6377E606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=MpGPi2A+
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EgAta5R6cVJUHOhO7u8IOQ7Q7xWW/ua1dAq9msnGrZJhwKHN7F1IGpubF6Z0vrzZogRDT2mpXG5uyhrNsAffGKdqDL9tBFB8Z/fNBNB7VTl3tzjOQBO1DCXyHUVStZIJw2d2ytmG/HL+eIDey+Sdj7IPWh3Wuj/M4WkJnwkAOBhVsYL739ryU5f+G2CiGRfKEh6VjyvVcc+Z9Oci7OzG4ArXev2yr7fMP2Bgq6C2rnR+DlW2iCm9CRmexf6vDcg1RZJao2ZZj+RpUd+Aq1mOhQOf4SxsLFr5TzAqpjhjO/VXCiGtW1vPSXvpfoXa/vKBpLeTAM9PVoClsonuHH58MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7e/LQ2/hz5T58I5dcZESzD1uK17SBLPurk+OEpHO710=;
 b=Xt7SGyFk4dh/hBS1PvQyiXDH1rHFUzJSp5t+JMEtLQ7WI3R9Fzj7vRkipNmBkRm0WA/0A5xpD9NNx5W+YgcYlIdv3910Xr59wAzgnZ9QNV6ljAf/4BO+eDnm7NBt6v1uyHU+LEmmfj9v357vL2UJECyckQn8JCWtVUDUwvHa/qbw/AcW0WA9IfPqZvhLFlUkqs3X9e8MdUOr/hLpGYEq4ELUNOLEYAmMocXSd5ysUSnA0oElL4HYY683t8v+k+S2dA1Jc6tNly22lWaGm0cp5TtgA1Itqb8+lvn3TqpbKBpKYbHiqxSmzcETP/LNNULB7b0fOVV6z3rXhNbMxz5rlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7e/LQ2/hz5T58I5dcZESzD1uK17SBLPurk+OEpHO710=;
 b=MpGPi2A+KKtQyfWMh7iz5CH+z4KHY/RS7XMQJZzPOR5podQ9Z24i6hQ3WFunEpmIZJ6ct/WuvbR9vMm2JwRCBpWoYTyKht5z7VycpnMHF5lRF3EqX0/mnMXltlfer9dALwa9hBFTfU6N795j3GQx6BnR13cnZAuF0s5SG/8pSdjB6T+sLAx5PK/lb9HkPRohL2iexK3qJwUg6NgWNbmdq0oVexIN3CfFIJ3exAD0gO9ITRIY2t+DYNiYzQCfm6sz4YQzDL5wcoMVoz6eXJnOOxnLx0fE7fUc6dpSmYPc9VCim3WcY6unq5QFJ1dN1dgbf3bG8vDBRl5GazKV5nc7Pg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by PR3PR04MB7225.eurprd04.prod.outlook.com (2603:10a6:102:83::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Wed, 25 Nov
 2026 20:45:33 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%4]) with mapi id 15.21.0662.004; Wed, 25 Nov 2026
 20:45:33 +0000
Date: Wed, 25 Nov 2026 15:45:27 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: James Hilliard <james.hilliard1@gmail.com>
Cc: Viresh Kumar <vireshk@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Dan Williams <djbw@kernel.org>,
	Serge Semin <fancer.lancer@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	dmaengine@vger.kernel.org, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v12 4/7] dmaengine: dw: use virt-dma for descriptor and
 callback ownership
Message-ID: <awdI59DI_mdEk_Ec@lizhi-Precision-Tower-5810>
References: <20261121-submit-dw-dma-synchronize-v1-v12-0-f51eb635209d@gmail.com>
 <20261121-submit-dw-dma-synchronize-v1-v12-4-f51eb635209d@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261121-submit-dw-dma-synchronize-v1-v12-4-f51eb635209d@gmail.com>
X-ClientProxiedBy: CPBP307CA0011.DNKP307.PROD.OUTLOOK.COM (2603:10a6:380:1::6)
 To MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|PR3PR04MB7225:EE_
X-MS-Office365-Filtering-Correlation-Id: cbc92a41-84d0-4f80-1bab-08df4b350cb8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|19092799006|23010399003|6133799003|18002099003|22082099003|261009223027099003|261021121427099003|261021123027099003|261022105027099003|261022075727099003|261026140227099003|261102123227099003|261026121527099003|261028144727099003|56012099006|4143699003|10067099003|5023799004|11063799006;
X-Microsoft-Antispam-Message-Info:
	4Z+2YC9qLyYlQJRsoArMN+DeRhZz69okoKUJCTIb7yzFzdNYvm+OC/ZCQzeEsr8vVF0BCLxfYYLnFGytKV8+pIPpjlfU8rxtTi1e/bjUqspiR09Rx0b2OnCutzy/6qjVomGHWOqGelf/5VTfH702oglqiqmlCroxYJ9XffJAe6VnTIFuE9+IOmWWkoK1C7PaN/njlg72lgs3ZuWxVaEamNunzoULdNvC0fjvb7765xezcK/eONEFmcCqn3HdcWnYIViFluHH9zLZ/tVWeZoR9bqu411Xx0NB+kjHzPyfNPjK2cNS/HDSDYZ060xC6oZ+lMP4ORA3dl8hR+1RomDLa9c0JO5PdTtArs7qVbQmyDqq6QYiyD7UhYjhkQ1sEUyH28PlCLhXevKWVPbTRXIY1w+/xjWlwalGvzki5iRxup+gD/jNQCbPRFUKN5PjARv5PXUrlkDaxTszKmQEc09yBGEr2zmkrvG2SR6PZusRrd+IagdU4X65lTiZb2LWFICLLp0f/RIj8KiIlJMf3fIuHBzXMeCw5BSSyW/mNPcfqEGBPJbk+sTwVTazIFldLjttET8zGygVPeVMK98q5EQmAyPIgUTlsPc03tg8J42viUmFuS4jRPlfX7m4EC8bkRUn
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(19092799006)(23010399003)(6133799003)(18002099003)(22082099003)(261009223027099003)(261021121427099003)(261021123027099003)(261022105027099003)(261022075727099003)(261026140227099003)(261102123227099003)(261026121527099003)(261028144727099003)(56012099006)(4143699003)(10067099003)(5023799004)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0oPCu5clY7pSqzxyQcr7CbcmH5Y5zda6MBbPKZWOpeEH9pynFVYwwT1eBoHd?=
 =?us-ascii?Q?IpI4hjO2onIern8QfiR7vk+hcwwrfAJnp1naljAiM4BUgwAwEJt9Y2mMf9jj?=
 =?us-ascii?Q?UINBy+iYhMGet/1gyTCZeI+XXxf+MUDhw6Dzg7Epli5D6ZTbva/Ro5e10/YH?=
 =?us-ascii?Q?wzgev9V9Z3krfhvtiRUndI+56kurFqAtvKw7fu8/bkM9VaAAH6+P5muFNnIh?=
 =?us-ascii?Q?cH7kd94dQuYD0G2nu0BtUmT+HYpfTLs139QJuMhXFh17dusnF5snct2uwGjx?=
 =?us-ascii?Q?nkzwXuIE3d1/Bx1bgn7itDS1HakdMJdp3jaLwLdAjmOj+w8eWUfknlpSzaUr?=
 =?us-ascii?Q?jicc6PqSpwYoRiJD6SIhtHrEbrVwj0M2bVQHUC+08vKrsRC0ultkSKLQCPzF?=
 =?us-ascii?Q?uVRPI6djeIJywWgcyTmHiAbSv5hF0/E5O09Zkem0E5/etOp6cQqSL0WCkcia?=
 =?us-ascii?Q?u3w/OGz6/LUW4i+8q2vnVqy7ZEI7T9qtXZf0SzPwSWaicdmgMDIaWx4l3kJG?=
 =?us-ascii?Q?L1TObZVNGyLkoSPXmlflBMClKwP5w7Cm0fpgrHuunH3K5+Srau/Sv8QxsoKy?=
 =?us-ascii?Q?iaXfOgOqLnh3TjFmDqEYyjewrGOLzQg1sdYOahWedzph/bqpB6V5V86SmDff?=
 =?us-ascii?Q?pqEvr2DvgUhXTZmPaL6w3fpD3xj3kCkDrnf1LuFKV45fT3oadsupSINRuXSx?=
 =?us-ascii?Q?ASWVdZvw6ov9zcQpFZR3fyZrHa+n0EARMsLgp8CU1hiCC7hxQ/bPe4Oy8SxZ?=
 =?us-ascii?Q?po6fNEINgt6leoRRZk7WFzDYShwCHNLRZSvJ43p2kXz+hgfjiNtDQUU004GI?=
 =?us-ascii?Q?eXX7oiyv+crUEbgHfiHmxsd5hElGqj4ajrBk2waCyQxIYozt4UTJZRYHlhEB?=
 =?us-ascii?Q?ot2RewqzbLilCgDW9yisCZXaWJ6G5iaEoWL2PGKmvaCJHMa89q/LsFNNAoBI?=
 =?us-ascii?Q?nzMf9jSq2/KcAyp9oUhnrEVk11N/3h0h9gblnI5oj7bLtsZvViWgmiR5/N85?=
 =?us-ascii?Q?E3gD5HeiwHEjs/0oEpu+QlVNyP3kGCL6l4RnSseD/AVk1ZKAblo00Uzc0DJP?=
 =?us-ascii?Q?8vNugKapKwyozwcsrZxlYU1BA7INwgAGRDevM+FjK9T36v404aTX/fVsQWcD?=
 =?us-ascii?Q?J6yXTcynO+zEKVmqmRu1XL+BuwfqnQiGkXRBhjlPXKCpmq81bHQv8XVMEf2L?=
 =?us-ascii?Q?iX17f2USe0XrpwNZsljz8H9RqYUFuzwxaFnZnvZ4wzBd15d4esqJw61YdvBV?=
 =?us-ascii?Q?p1BCunvOhX+7u1v6NGLraeB8WY0FRGIH/BvgFbhLXizF7TuiZ7YmtHr2hEYe?=
 =?us-ascii?Q?j2lun4wyElpbEzkbr4GJNp5PEX6Dr2jqLO3OAwEsl7rHNJS668KpB0Ukrj1Q?=
 =?us-ascii?Q?o1xJYGNsrxjDNp53ttH0Z9fpNCqfupO4PO6zvdU3WktZL7Yif5VbUP8Aj9Cm?=
 =?us-ascii?Q?c+CHWEE2pNyX1AMWmrFEfdnKqFfAUwv2CrEfxvk2848kpnktFryae2613kht?=
 =?us-ascii?Q?bVcy9NL0XqWkdDEy2X/FZieZe66tLDbyfM2nkCjq367PImI06c7spnf2wPUd?=
 =?us-ascii?Q?oRN5Vy4jMGu7yiP5rzFvb7Qid5l7NIz6iqTIwUhCUobvvw3DrlF58LPRRn/0?=
 =?us-ascii?Q?6h/ohtzIhwcFN9C4GTu3eH7Nycg7fNSGpRprsNTS5qd6cVU1b2bvLKX0xEsY?=
 =?us-ascii?Q?9nGogz631U31BsvC9E281FcFV3MGc6bPK4GDlC7XzxXjEz0BV0K88hUQMZx2?=
 =?us-ascii?Q?KJf5djjK8t5lZObKr4bvz1RT9IXqDp05NtX61p4NjaBF3RgMG8VK?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbc92a41-84d0-4f80-1bab-08df4b350cb8
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 20:45:33.0545
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gbnzHZR/MoFSOzsrYzh7YdTopDyhjQP9PMwIPE1H2NHv79qq0nmbAaTGmcnmBT74ostcqQP1R8ZnvOlESh1PDIXdfDfFURibo7q6sNEJbzWT3v5C5w5r6v19wvjqHQru
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7225

On Sat, Nov 21, 2026 at 02:03:19PM -0700, James Hilliard wrote:
> The status getter can invoke a client's completion callback while polling
> the hardware. An 8250 RX timeout calls it with the port lock held, and the
> callback takes that same lock. Termination also lacks a synchronization
> hook to wait for callbacks already detached from the channel's queues.
>
> Serge Semin proposed leaving transfer completion to the controller
> tasklet [1]. Clients such as catpt poll with the controller interrupt
> masked, so the status getter still needs to process RAW.XFER and
> advance software-LLP blocks.
>
> Use virt-dma for transaction queues, cookie completion and callback
> delivery. Keep the active transaction and hardware state under vc.lock.
> Run client callbacks only from the per-channel virt-dma tasklet.
>
> An 8250 RX timeout consumes the transfer length minus the reported
> residue. On a bus error, source reads do not establish how many bytes
> reached the destination. Credit only whole blocks whose completion the
> driver observed while advancing a software-linked transfer. For a
> hardware-linked transfer, treat the whole buffer as unconfirmed.
>
> Report the abort and the same residue to result callbacks and status
> pollers, even after another transfer completes. Reserve the error record
> during preparation, when clients can still handle allocation failure.
> Use the normal virt-dma submission path; neither submission nor fault
> reporting needs to allocate. Keep only failed cookies after descriptor
> release, until the cookie is reused or the channel is released.
>
> Submit only the first block of each transaction to virt-dma. Its child
> LLIs remain on the driver's hardware-chain list and are freed together
> after the callback returns. Keep the controller tasklet for hardware
> event processing and error recovery.
>
> Complete cookies under vc.lock before handing descriptors to the callback
> tasklet. Complete terminated cookies in submission order without invoking
> their callbacks, so a concurrent termination cannot advance the completed
> cookie past an older completion that later moves it backwards. Newly
> submitted transactions become eligible to start when issue_pending()
> moves them to the issued queue.
>
> Implement device_synchronize with vchan_synchronize(), which drains only
> the selected channel's callbacks. DMAengine calls it before releasing
> channel resources. Exclude the controller tasklet while clearing channel
> configuration and powering down, and let a pending run return without
> register access after the last channel has been released.
>
> Fixes: 3bfb1d20b547 ("dmaengine: Driver for the Synopsys DesignWare DMA controller")
> Fixes: 69cea5a00d31 ("dmaengine/dw_dmac: Replace spin_lock* with irqsave variants and enable submission from callback")
> Fixes: b36f09c3c441 ("dmaengine: Add transfer termination synchronization support")
> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Link: https://lore.kernel.org/r/20240911184710.4207-2-fancer.lancer@gmail.com [1]
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> ---
>  drivers/dma/dw/Kconfig |   1 +
>  drivers/dma/dw/core.c  | 502 +++++++++++++++++++++++++------------------------
>  drivers/dma/dw/regs.h  |  26 ++-
>  3 files changed, 273 insertions(+), 256 deletions(-)
>
> diff --git a/drivers/dma/dw/Kconfig b/drivers/dma/dw/Kconfig
> index a9828ddd6d06..444702c4a059 100644
> --- a/drivers/dma/dw/Kconfig
> +++ b/drivers/dma/dw/Kconfig
> @@ -7,6 +7,7 @@
>  config DW_DMAC_CORE
>  	tristate
>  	select DMA_ENGINE
> +	select DMA_VIRTUAL_CHANNELS
>
>  config DW_DMAC
>  	tristate "Synopsys DesignWare AHB DMA platform driver"
> diff --git a/drivers/dma/dw/core.c b/drivers/dma/dw/core.c
> index 3df696e41ff2..d00d0d53f6ba 100644
> --- a/drivers/dma/dw/core.c
> +++ b/drivers/dma/dw/core.c
> @@ -8,6 +8,7 @@
>   */
>
>  #include <linux/bitops.h>
> +#include <linux/cleanup.h>
>  #include <linux/delay.h>
>  #include <linux/dmaengine.h>
>  #include <linux/dma-mapping.h>
> @@ -41,35 +42,6 @@
>
>  /*----------------------------------------------------------------------*/
>
> -static struct dw_desc *dwc_first_active(struct dw_dma_chan *dwc)
> -{
> -	return to_dw_desc(dwc->active_list.next);
> -}
> -
> -static dma_cookie_t dwc_tx_submit(struct dma_async_tx_descriptor *tx)
> -{
> -	struct dw_desc		*desc = txd_to_dw_desc(tx);
> -	struct dw_dma_chan	*dwc = to_dw_dma_chan(tx->chan);
> -	dma_cookie_t		cookie;
> -	unsigned long		flags;
> -
> -	spin_lock_irqsave(&dwc->vc.lock, flags);
> -	cookie = dma_cookie_assign(tx);
> -
> -	/*
> -	 * REVISIT: We should attempt to chain as many descriptors as
> -	 * possible, perhaps even appending to those already submitted
> -	 * for DMA. But this is hard to do in a race-free manner.
> -	 */
> -
> -	list_add_tail(&desc->desc_node, &dwc->queue);
> -	spin_unlock_irqrestore(&dwc->vc.lock, flags);
> -	dev_vdbg(dmaengine_chan_dev(tx->chan), "%s: queued %u\n",
> -		 __func__, desc->txd.cookie);
> -
> -	return cookie;
> -}
> -
>  static struct dw_desc *dwc_desc_get(struct dw_dma_chan *dwc)
>  {
>  	struct dw_dma *dw = to_dw_dma(dwc->vc.chan.device);
> @@ -80,12 +52,8 @@ static struct dw_desc *dwc_desc_get(struct dw_dma_chan *dwc)
>  	if (!desc)
>  		return NULL;
>
> -	dwc->descs_allocated++;
>  	INIT_LIST_HEAD(&desc->tx_list);
> -	dma_async_tx_descriptor_init(&desc->txd, &dwc->vc.chan);
> -	desc->txd.tx_submit = dwc_tx_submit;
> -	desc->txd.flags = DMA_CTRL_ACK;
> -	desc->txd.phys = phys;
> +	desc->vd.tx.phys = phys;
>  	return desc;
>  }
>
> @@ -97,14 +65,86 @@ static void dwc_desc_put(struct dw_dma_chan *dwc, struct dw_desc *desc)
>  	if (unlikely(!desc))
>  		return;
>
> -	list_for_each_entry_safe(child, _next, &desc->tx_list, desc_node) {
> -		list_del(&child->desc_node);
> -		dma_pool_free(dw->desc_pool, child, child->txd.phys);
> -		dwc->descs_allocated--;
> +	list_for_each_entry_safe(child, _next, &desc->tx_list, vd.node) {
> +		list_del(&child->vd.node);
> +		dma_pool_free(dw->desc_pool, child, child->vd.tx.phys);
>  	}
>
> -	dma_pool_free(dw->desc_pool, desc, desc->txd.phys);
> -	dwc->descs_allocated--;
> +	kfree(desc->error);
> +	dma_pool_free(dw->desc_pool, desc, desc->vd.tx.phys);
> +}
> +
> +static void dwc_desc_free(struct virt_dma_desc *vd)
> +{
> +	struct dw_dma_chan *dwc = to_dw_dma_chan(vd->tx.chan);
> +
> +	dwc_desc_put(dwc, vd_to_dw_desc(vd));
> +}
> +
> +static struct dma_async_tx_descriptor *
> +dwc_tx_prep(struct dw_dma_chan *dwc, struct dw_desc *desc, unsigned long flags)
> +{
> +	if (flags & DMA_CTRL_REUSE)
> +		goto err;
> +
> +	/* Reserve a record now so neither submission nor error completion can fail. */
> +	desc->error = kmalloc_obj(*desc->error, GFP_ATOMIC);
> +	if (desc->error)
> +		return vchan_tx_prep(&dwc->vc, &desc->vd, flags);
> +err:
> +	dwc_desc_put(dwc, desc);
> +	return NULL;
> +}
> +
> +static int dwc_error_cmp(const void *key, const struct rb_node *node)
> +{
> +	const struct dw_dma_error *error = rb_entry(node, struct dw_dma_error, node);
> +
> +	return *(const dma_cookie_t *)key - error->cookie;
> +}
> +
> +static int dwc_error_cmp_nodes(struct rb_node *a, const struct rb_node *b)
> +{
> +	return dwc_error_cmp(&rb_entry(a, struct dw_dma_error, node)->cookie, b);
> +}
> +
> +static void dwc_retire_cookie(struct dw_dma_chan *dwc, struct virt_dma_desc *vd)
> +{
> +	struct dw_desc *desc = vd_to_dw_desc(vd);
> +	struct dw_dma_error *error = desc->error;
> +	struct rb_node *old;
> +
> +	lockdep_assert_held(&dwc->vc.lock);
> +	/* A numeric cookie may still have an error from before it wrapped. */
> +	if (vd->tx_result.result == DMA_TRANS_ABORTED) {
> +		error->cookie = vd->tx.cookie;
> +		error->residue = vd->tx_result.residue;
> +		old = rb_find_add(&error->node, &dwc->errors, dwc_error_cmp_nodes);
> +		if (!old) {
> +			desc->error = NULL;
> +			return;
> +		}
> +		rb_entry(old, struct dw_dma_error, node)->residue = error->residue;
> +	} else {
> +		old = rb_find(&vd->tx.cookie, &dwc->errors, dwc_error_cmp);
> +		if (old) {
> +			rb_erase(old, &dwc->errors);
> +			kfree(rb_entry(old, struct dw_dma_error, node));
> +		}
> +	}
> +}
> +
> +static void dwc_free_errors(struct dw_dma_chan *dwc)
> +{
> +	struct dw_dma_error *error, *next;
> +	struct rb_root errors;
> +
> +	scoped_guard(spinlock_irqsave, &dwc->vc.lock) {
> +		errors = dwc->errors;
> +		dwc->errors = RB_ROOT;
> +	}
> +	rbtree_postorder_for_each_entry_safe(error, next, &errors, node)
> +		kfree(error);
>  }

I can't understand why need rb tree for errors? if error happen, whole
desc should return error.

Frank
