Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013006.outbound.protection.outlook.com [40.107.159.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF5A233920;
	Wed, 10 Jun 2026 01:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781054037; cv=fail; b=qqQEF7b/nGcoIPGNWcBS+uaSiqJRievvO8/RJfttgKGbqGTI/X60p2rdNIIRmlQWx99uwih02+iQg86oNDZdt4mtgW1NJw9nZ9MXGG8ugRBU6f0skhrj0aK/GlV0D/3i93nqIUR37CVH1kfUkXZ/pQt671PzOTOlWKgA7OU4KN8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781054037; c=relaxed/simple;
	bh=xpJQpCOIgNgJb6JR7AxMU8Mue+IUpjZ4cbS4iSoE2F4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mb+thmXcn3tSv/SToQjlPVexboGR09+BniL+dbnGEaK/fSHh6s2MU96yxL7I78cirsFxcHm46Itfs8CcaAQPq2GYksdfdtuCPPTneD6gPmRNXtOiQ7Zx1fMpvlTA+QX9krzB3ElBoxP7AnsOsELSwfAepzwsvdnhASBBuFIN3Ok=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=m0baf1B3; arc=fail smtp.client-ip=40.107.159.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="m0baf1B3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AUcsPoNBa6bEo+UmrI5uo4vV8XaYffcbLRTP1HlNs7kiOwWfHoyYGLX2WfxhpvxCRb+d6cjxF2n205tUTklvP010v0/HHd8USjYt3u0v9WI7gLSHv8o1P2MJd1MARbm5h532FwLpjTVTSULYkZsuGdV/zH9igBDqhJwofc/jJqUvpQVudBM/5A0P7UNxmO2ntO/ES3B1rv2JzrcoJMLGcrf0Y4abqLv5THmOQCBq30S8HDeDxYqTmmvCQF/+OtE9D1jrjvcdRbz2p2DFjsuE3P5faFN0eZbMD3sOX0/aMdm3WYUsuYhQVHpTyw5/rXydvQ98sCqpTW5vv85VlmmA9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/UxAFhRzWoIT2PslKgtJvndixhUQWBq70g2Fy5AHaN8=;
 b=ggbr8pP0nzdK42JvPBerbOY5G8xqYHKZ3VN4rfbPCjs1Fq1CYDBAk8fWdFK1atRnX0lQgLs/GXowm3JXVFyyTnvkIu3IVmWUIYLBS4xyuoTlzuQHgUxDLkdsnBr5PEWf5rv+qvIezeVfKpCUKwA/VQm4jzgybB+rHttgdoM/O3ufYqZ88+rX21PKhhEiEdIA47FAlBiViftv3Ys9GnMh6/2Df3qApD7Ak5N5ka9/vfJDi2GEtrI8ur2/SkJFVX8ENOGgk+G+2C5sRy445/a58+wlrGBTcTnYsLxPaoUH8aC2jOicO/JN2Sim8EJ7trRJgI1Tfl3K4hATUFS+X3CHbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/UxAFhRzWoIT2PslKgtJvndixhUQWBq70g2Fy5AHaN8=;
 b=m0baf1B3u7aZC1tm2YEyZXojKvUq9AWr/eS/qmH/undQGo0Bks8rDx5oDv+RwsyEpEcuZKaoes5+S+E7cHqjeefBQdX65DUCRqk0vr3xiyjdl8Y71uckUYCtO9PDtl/8PYjj+5K+Mxwwr1JyjDA+K6CpQOlR7G0UewEo7B87ln/L7/LLv/lHGQu4dWboeiQj8dcWhjralbhnD0UjqU+Ri+wqufk8kFpDJxPCGSLdyIOUJqcWRwXwLqHE2SSuQqkMK/Z73+KIX2lHUNse3YwpPthf0G/QlOciQGDae9bGbQv7kCLN93FAzEeCFCK0Y2YKoH1oKk1GqHo0Tq+q0AK0+g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by AS8PR04MB7782.eurprd04.prod.outlook.com (2603:10a6:20b:28a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.11; Wed, 10 Jun
 2026 01:13:52 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0092.011; Wed, 10 Jun 2026
 01:13:52 +0000
Date: Tue, 9 Jun 2026 20:13:41 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-serial@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	"open list:TTY LAYER AND SERIAL DRIVERS" <linux-kernel@vger.kernel.org>,
	"open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <imx@lists.linux.dev>,
	"moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCHv2 1/4] serial: mxs-auart: fix cast type for
 of_device_get_match_data
Message-ID: <aii6RX0321fJV99W@SMW015318>
References: <20260609223717.41670-1-rosenp@gmail.com>
 <20260609223717.41670-2-rosenp@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260609223717.41670-2-rosenp@gmail.com>
X-ClientProxiedBy: PH7P220CA0039.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:32b::26) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|AS8PR04MB7782:EE_
X-MS-Office365-Filtering-Correlation-Id: 57a1c529-dcf4-46c4-fbe5-08dec68d88e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|7416014|376014|23010399003|1800799024|11063799006|4143699003|56012099006|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	aPkwIPQWDo/Rxu5Os0OnBsSGFze5Vlj0MeOAzdXPZwU9qSr/nZ7k4TNP9pc9OmnlYJKJlmoecxIw1mZtGw8Gflyl+MbZ1PuQFGHboUlScQwx7AQROhyYdMIsQqydWCEvz9gj7iskii2GocuEm2a+Aig5UPMximzrx55LJqz4aogFYRZLDnRke1Kyy81NhJv0kWJEn1QflnVUfxtTMZ3guW1kkRePkr4FfJDtZJEbWBaYQ+CF3HLcR+4eOEGxN/+2tFucdElqs/SjRZzVMyK2NyHhcp+HCkQ+Wv/DE9gqgu4rkQoCQ1/I1VVX11FPQi3bzmd+OVSCmijZoX2aUsWk162/PQ7F+oiOhdOPcsR+h1E0iWEdAWhhS7qG3VWtc0ZUNFtJDhDq7ovbLb3Mr9GEAO3H6yjZ7n28dgoKStJ+fGR6jQAOvpC+t4XokBLOKELWq9GCtOSFnJ9O1TQbSY+3MbkcNtHpfqYET8IpvlJMkuNql7DsISFr/FKtcKrwq/Womnbmh6nMFJO0JS/zj16+GPOARl8kl8kplbIPuOJB4lZkL7xrHX7Q4RciAO/lsdaWsMMhMF+DplZestMgX+ZSw/2051Tug8lgn6P1kwMJHHQkWSNaZ8urCv5UoCTvABz/GYZ7BabaFf7+QLgTYGO0DeLG72kifMbx+aMKaxLrwCZnf8oVa7y8fuWVCAOBRjPj
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(7416014)(376014)(23010399003)(1800799024)(11063799006)(4143699003)(56012099006)(3023799007)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?K5QU4KxwERcgsD3skChPB3YV8HCBMLhX5nWEvgOEia+SOlkuV5ChhO+nnDdF?=
 =?us-ascii?Q?hAA1cGKvm+VOD4Bs9GHZr1p+EP4SGnzJpMOh12WUkaRvPnf9dVmTj/1CEqz6?=
 =?us-ascii?Q?O1ZUErHHseiol0r3VXmLGmtW4GBouBrv4qDolV/6sMNTE5Lfhz6/Y/pHDu7+?=
 =?us-ascii?Q?AMDc3t6KClM11OKdlZHzk7lYeVBQVzKE/Dpb2ZudYn/wcIDmUhJr7xSgfP5W?=
 =?us-ascii?Q?QU+yY/AnWhWz2Gqzc0gJKB6XXDX8a2aS6tztWeHRBh9N+TNnVM0hsr5nWVYy?=
 =?us-ascii?Q?X7B4cNfkCnLrKmIHiKxxZgbf5B1UjLTDIXpux93ievJcXULp/ceUriLxTuDc?=
 =?us-ascii?Q?CCzPxFfFwOqgTkESz11/PZHi/X6064ayj3INI8UIyRXgNsErhJxJB35mv+o8?=
 =?us-ascii?Q?g78qMzKmqZj92/Ha2PzIU2jFinuY2iIF9gRCObLiL0bjmXDtnTGbB+spXYp+?=
 =?us-ascii?Q?+bDk3cPFiiBkMXMfCKZJEFcljzyyA4b8F7ykrfPblZab6WaDHBwn9SawctlU?=
 =?us-ascii?Q?MrBHExbSDeVywfu51+r+q34LrHbXCuKwV/l0P7lFM7DkOtVNUn7/H9ugH3B4?=
 =?us-ascii?Q?RGBdjuSQ/qmrI8pkCOooHdVs+vxU0wVxoZQcpqIU9TUYK/XWjJqcIbocWUxm?=
 =?us-ascii?Q?NWF831mbX7fQvgB2BWo16dc5nX7JFdgkkdf8pWNofJBtaY7dNOCR8w0RGidX?=
 =?us-ascii?Q?OhzAfeyzBdFdpyhSRisvO3s9RyELOhTdQxx5z+9AeH1H7BNLztW8GBmIUqBo?=
 =?us-ascii?Q?8Jfu9Q8lLazdxCOnx+MIs6D99etb7ttl+mtFsZUOKYpJpF0wke/Z73sX8/ca?=
 =?us-ascii?Q?XDC3dYuZhQf1Q5HF1orCUzEJxLk8ZVHMHvjF4h5T6QL68tJXJuxW+Jr836nP?=
 =?us-ascii?Q?2zXvf1q62iDuf4yxC6ZhfHM2YTX58P2hBXfmboUriT5ocvugU/lXbZn0eUEF?=
 =?us-ascii?Q?vK9DR8SdbEquqc8ZlXQHgAoqBqkvLKfdWXj0DFTrJ2CN3Qh5ZTEjyAixrXWR?=
 =?us-ascii?Q?Hi/UsXSNFcGwLw2/lR8vTRZMODGeeSopNuJO736S9guqxgj1KvI/QmG4e5ix?=
 =?us-ascii?Q?cqRVnGNJQXqJXn+6IYI/jHeTXC2y4hynYt80gak9tUKG4zE1Ezu0zNYjcvwO?=
 =?us-ascii?Q?LVVnw6TlP15do+zFo+uloXOVcJiNtGtAVHWYBDfGJLhmqm+l3+MIR8Iy9hkp?=
 =?us-ascii?Q?Pb0e+YeYbrLxO+B5jlQwLkFIZzAYWDSB8x6UYb2VFWXXjGSH8ITetfvJeHnH?=
 =?us-ascii?Q?e5Sysdje49TruZoaEJMA7koVkJUrm4vs24NvC5Rhv4hIdiD7ewDQnqQ8pNXm?=
 =?us-ascii?Q?wHjCXZLXveuS2//i86q0MahDWDEtqj3onDfi4S+D1JBxTWAPc7vgb8IElhlb?=
 =?us-ascii?Q?eL0+VvRqBaeyiUWiHlksvqSl+BSC+EyDw9q00cCvMT6NJh+AUAq6Wya+231K?=
 =?us-ascii?Q?78FON0NPagS5eB7GvDcgeJt8maec4dP3b8DhzbVqpFtQl/VN7rKbbHqMeDep?=
 =?us-ascii?Q?OG1ltNgANbEvneLexTuiGF8kwrn0e0HdMj/WBek9qDG2pYKa/x8vz+lCpAz9?=
 =?us-ascii?Q?W9BVNjoG3KwWldEgPE03UxS8aQvk3ssBNYu0RG5TBzrcyFy19W8LcuTdlB7O?=
 =?us-ascii?Q?mRoxsnwIRGo5KoDDOGg8s2TgdgWaK56AkrNu35mwinGRGTxgvGUlp1i5ieKV?=
 =?us-ascii?Q?+tpNYXB28DvGhfHPRaHnsAm3ENlS73TEe7QSAOP06YdNdaz5UXaYhZ2uolQ7?=
 =?us-ascii?Q?zifYgQtPA1SJWpNDkehe36hICuUGYd/s5NOxevZhwxzoJ1rZwOpD?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57a1c529-dcf4-46c4-fbe5-08dec68d88e2
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 01:13:52.6300
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aPtwfm1+vaJzMT4ZC3GxQ4TERQaSttLGEAmULAAOHX/he8Sadw18hHD0l4r5YOVecPoSMVcZVSAsVKNUEYTbkCkN7fzmAgeXvldU4vxMkhda2ZXRZis3HjnRhKTeEcch
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7782

On Tue, Jun 09, 2026 at 03:37:14PM -0700, Rosen Penev wrote:
> of_device_get_match_data returns const void*. Cast to unsigned long to
> avoid implicit integer truncation warnings. All the data parameters are
> correct anyway.

It is not worth to fix it by this ways. cast void * to int/long is not good
at all.

struct drvdata
{
	enum mxs_auart_type type;
}

static const struct drvata chip_imx28;

&chip_imx28 as drv data.

Frank
>
> Assisted-by: opencode:big-pickle
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  drivers/tty/serial/mxs-auart.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-auart.c
> index 697318dbb146..de97c0f74e7d 100644
> --- a/drivers/tty/serial/mxs-auart.c
> +++ b/drivers/tty/serial/mxs-auart.c
> @@ -1598,7 +1598,7 @@ static int mxs_auart_probe(struct platform_device *pdev)
>  		return -EINVAL;
>  	}
>
> -	s->devtype = (enum mxs_auart_type)of_device_get_match_data(&pdev->dev);
> +	s->devtype = (unsigned long)of_device_get_match_data(&pdev->dev);
>
>  	ret = mxs_get_clks(s, pdev);
>  	if (ret)
> --
> 2.54.0
>
>
