Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013029.outbound.protection.outlook.com [40.107.159.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F1431B80D;
	Fri, 10 Jul 2026 15:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783696488; cv=fail; b=qJPFKt/GFWORg3n5x4mrte/NtM+o0hEs2XZBjSnbb8wTT4eBVJRgUWu4nlrDNWQHP+5SMegY5+B2vesnxxFiZPeSiEI0rDZimEAWZ7d5rVcJhxsjCZ2ltRDusAEgOOZmulnFOtchg5OKJuf8J/dvftvH+zQa1287+wwfnXEhsdA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783696488; c=relaxed/simple;
	bh=UNXtfgkmKQmTulevj4i5jF0pOLfeL+di0C/M9lz3Kt0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GUIUXj8PU7Hy2myqMyQEzDtuPT+tcqHepWb71PW2IiJBcQ77Nks4gztKeCOhxVGEhy6Y+fbQad/ubFGr2+O49kErTAQmVRo9A+jYY++ONDiU8ku7Bjn210HxDfbbbTY9bGZiDU5tmQfVhEMtF2XLmEyMPtWnvsmeyISwGnhG+o8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=RHBkKCeA; arc=fail smtp.client-ip=40.107.159.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="RHBkKCeA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lUTWxFI4nh3u+XUfiWtlcDpuqULMj2Kjj0eam/MPlaV+wUtfuraW5kX/8NF/5hq7uKixO4qxFnJTaboyC3MR4bMan+IUVLt1UpKG1RCMQYJHNAHSsTXuCLJIdXmSTsEvXXUbHbg0mFcg3jwPinXQY7NtELf+Ndmuhp+eG/8PFclMQBUYhtgRw0yQCY/dbCNr0uYeKxyKpg2rh1Q8J7LjPyX7plLrzd5DxUo35onoogds8SHDpHyPnFHf7sfJfP6GfSnpkwIMFHS4hoQ5rgNRAuN1RrKyBLF9HGAEMne2SO4v55JNEGYz6W/r7xL4pfuJQ4EBNtAM8XefOs/qkrkvnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XhC/7dbeV92o4k3G+9O8m3GC5hzDbLpxcKWcS2g8C3Y=;
 b=evJ7ehP6VfJwYa5IXwJuRh5WV+66C5ox9w0FbSXbyfuhc4yIlKTnWI5oBd6Gej0if3btP4mE3MjE4DpFg4GdK/S1GjoEHI2rffk3IiO7CZxNi7RVk8zSvlq+q9NhBuelvcA4RCkEqTuPHwWou/OM/oMllcUjYlVbSsQmXZiUarlq1AhDhpHUwLuj24UBaDtrgSbuT5ydX3TS3UOdGCzcFkmTcFubB45ghhSwA45x0ZnCVhSeS7ibJijkgWC8pBappVtbavJ72D6ABjMfsFKjV5FX0q7NJFRgJZX9y7sne4wOTTfeWNHlfklzxaFFmInfM+EAfyBZCU+tKzgFzOk0ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XhC/7dbeV92o4k3G+9O8m3GC5hzDbLpxcKWcS2g8C3Y=;
 b=RHBkKCeA7HJfRY+p0TBbor30VVIsV33sq7kVBxEeASDB6EU8L/JCd4DONU46X4cCx8XIL7d3NaBavMwqJT3fg8Jn9msterxKmwdl5QUMFxLu5O2QPv6KKGhTj2/VEVPMMWo0Dgh1g0kFxQ6u6MnhN5XZ8Oq6hn7HGbiaYfN2jpu+BZAvDmith1HtfJ2h4JhAYRkh9ZXStzYNolvCHKwr3fNvqGBc5O/hzlIbEc7cUr+xRCDsohdDvzcVEpuKjCDqQG+4k9xfP+CHHQmfEUjxBRbIWc5lxiRtQ1CbkTOpBDCPRkRsuGHESuV2LTZVodCObBzcTVlzuHcwr1CtH8Tjeg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by AM0PR04MB12122.eurprd04.prod.outlook.com (2603:10a6:20b:747::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.18; Fri, 10 Jul
 2026 15:14:41 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0159.007; Fri, 10 Jul 2026
 15:14:41 +0000
Date: Fri, 10 Jul 2026 10:14:31 -0500
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
Subject: Re: [PATCHv3 1/6] serial: mxs-auart: fix cast type for
 of_device_get_match_data
Message-ID: <alEMV1FeOJt3ZQ_a@SMW015318>
References: <20260611033856.6476-1-rosenp@gmail.com>
 <20260611033856.6476-2-rosenp@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260611033856.6476-2-rosenp@gmail.com>
X-ClientProxiedBy: PH2PEPF00003848.namprd17.prod.outlook.com
 (2603:10b6:518:1::65) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|AM0PR04MB12122:EE_
X-MS-Office365-Filtering-Correlation-Id: 945ace4a-ab85-48d3-46d3-08dede95f6f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|23010399003|19092799006|366016|376014|18002099003|22082099003|11063799006|56012099006|4143699003|3023799007;
X-Microsoft-Antispam-Message-Info:
	YyVJxdQzz9KxTThcba95cczeB2VM1amMOibVQKint+14wqayQVedXAABTzTOLSxO10RkrueHdXOt0lGPkPMylTh7ynUzHA5XkvKJm9thohni/YWgnajL+6z2L5vuZA0ROnfiyiPx2xCTnFF+5tPWfl+lfnvTwIJto9Qf11LTHVsEvIHEKumudpLdGMfwg7+9C4Yzb9U1NVm4L5btqpi+oDQASHH08DASG5HwGuLidAqQfgSAeaMz+Rs1JzLjLhJMe1lg3c9Mb76+/ds5Rk11cktPX7jceYi1R1vISHcTNhoB2SP8p4V8fdj06Dq2emZvJX+y1l1VqPLNhDNLkdw3i7pX4mUe674B5LjXpF5g083KtbgA9b3OmkkJ8N7PpjMF6v1ub3tkaHCDeM6Px0d2pCf+DAGpfYO9Ct0B1gi8fqZ5rg3t83BcW5j3SLufRit6iQfxITRWuM798kxXkoAf5ddLMpWuzdrwZ1idcmpG2h+eHeuMRipbHnoQcPwwcT4aqbwrXRMBrK6ypNJuRdGqUFD5Bobg5r2tia+bYuuvfrMiVGC/aBefkX6ZkAb4kw1V76mkQFAsLtDXJ0ApuoZbs8pHiPXni0zxqJ65SFUYbB2IVc1CvmaV1jsgxG+1d6llM0gskO/dKTq2z34xUWX6V8xWn/xF/cSrSyl/X7lTOfs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(23010399003)(19092799006)(366016)(376014)(18002099003)(22082099003)(11063799006)(56012099006)(4143699003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MdqdsQb8lJrNijTEYyWpdMGpNYewCWVOPX+OzmlBNSNcZJn7DyWV5flU3ypv?=
 =?us-ascii?Q?OO+CZGMBBsKYCGIe5XWV9V2uU94+UXhrtx0mby6laSwoaqwCb592zMo5uhOj?=
 =?us-ascii?Q?fvO1Sh802YoPgI0tC4VdLf9afutcA5ouMhKHT41jzD4Ph9TuRN+Ywm7aAvtk?=
 =?us-ascii?Q?OGr4WGfNhYuFqbYGlruwBfcFQZVSl653kP4SA8xWvgIORAK6L+Gqlm3FBxmb?=
 =?us-ascii?Q?QHo1Whnrp587g3sgzM4jQ8/vb+2S9Tk7vT4ZUgICMU7ylMyiiRgqLVjqt3QM?=
 =?us-ascii?Q?OFANCrXsDzKwwFwLPplw5fCXc50kSAJ77l1SKTTeA/tcUidz38jUKDjQ+KQx?=
 =?us-ascii?Q?1wdnGkvij1jGKi+KJi6fZhOdp0Y0DBa91slnSuU3zhGRHreT1AL7cDJRyTqW?=
 =?us-ascii?Q?C53hJNN5zrRnq5X7Z2WA4D/0CUOtKlRqGskwYXiHQN6gwlSntz8997JQIjzj?=
 =?us-ascii?Q?CAWiuJUfb8mldWF0x5jFXxmkg5nZtQDMZ5DYQvD4wpTnxY6BLMIoK0tb1WzH?=
 =?us-ascii?Q?4PsFE4uTapt1LQiKdmRzf48LdNO9rGLQqx2V5ukTpHTVIAGcur3D2NpexYqZ?=
 =?us-ascii?Q?mYdYpERMjqhkuH6hGxFAuoPzC2/+1RDNl7YdzK1LnxfgfCHrQy/NAOGBxU0J?=
 =?us-ascii?Q?5Z8wfDS282Eo2glvH5SvL8IQj2D6sL5mhF+3fyINJ9l3QTwUL4WGqSJZ6da2?=
 =?us-ascii?Q?h89uNTeLS7kXJiG1jTEWxPKa8HX+3SnZ7ZL+AWo1Id0REpXTXTU4em6eCnZz?=
 =?us-ascii?Q?Ioh1iVpTJklwuK8JAtcNL0kT/6o4B/KPfGFbio252RnWq336xbwXvWLwOqVu?=
 =?us-ascii?Q?nHYU/5pwfzZUB7uuJKUh3aq9ENLBAhMh7Fe/aAXaGVX90ItYzR5duE9u3V3L?=
 =?us-ascii?Q?E2ijJmQCzwATuclXF0FuOcXQoL7zyaHrG/i+UNgPudBrrYD+FHlJ59Fk0K3P?=
 =?us-ascii?Q?e75tMqC3qv4B9EALbkHLxBRDhE8XkUBdSNI7bcP4f96lXVP236AQKGiZzShz?=
 =?us-ascii?Q?gjzTF5CbKTNDhxawHayue7ec7rVY6A/j8qJ5o0EtkQxMQJs96mamsigfYf3J?=
 =?us-ascii?Q?SklzVbe3hjHKxj3xbii993w+ux+qGjKbtg7SDuRqrb3uUVZ0GKZLgZD9J7Re?=
 =?us-ascii?Q?RgwOCrmqFunJ2FP5IgKA7diacb+HbYAbTRVW48K294yALDEwosnjqKuT96hA?=
 =?us-ascii?Q?zv4kV1IHPhHUa3I9IhO+E45bhw1DBfmPqMN+xcy12A7dB1z/AWbBek3/JZyQ?=
 =?us-ascii?Q?SeiunXS+bwvuU37tgBboBfZMAMT2XZ1Ka+T3LdvIS9ZORbHIiZT/NaMXRGk8?=
 =?us-ascii?Q?sGfhPb5cjKI8FwVjcV8PrQC3ftqKpQ3iDJ+DPSszi5lR8VS7BIQ/o4U73OSb?=
 =?us-ascii?Q?37b2w+tz8OGjYxQJqA/UFWnfCyx/wFqqwpWxoV87SWhG6XQBUPW0H9sVx7pH?=
 =?us-ascii?Q?mUxS0i41uxO6ZK+bRbQI6T/fJ98y4miszUfLmU2vWcl2IVKm5mkhW0yurYyZ?=
 =?us-ascii?Q?fFwE3XP2C49xpYEAd3+AvH/GsbKxcdyMdJTgoZAXxrucyoJZIol5mx1hwybP?=
 =?us-ascii?Q?X71+YarVeAQbH7EqMwYF+fxLndHchG0tyJ7K0ksf5Y3ZRulildIbU+GNB1Ud?=
 =?us-ascii?Q?X5K8ZCVHRSRQ0d6NvC19XhdNg8tE0MAvt8fFaZ8uwsFNyxH3aycNh+ImuXkh?=
 =?us-ascii?Q?riV6/cnNFtISnOir3vMPnuTwtQGWK32UmviRGpH9eL6JLLTsPmiqd6Bsg3SB?=
 =?us-ascii?Q?HcVZVEMgxnwWVHTVYh3FvZfilwuhaVp1mlj7eN+xd4HHxcG5butH?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 945ace4a-ab85-48d3-46d3-08dede95f6f7
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 15:14:41.0151
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9G+PaW54+jYN6r9girsi7yJzWoaJeFzSaxUF3ddykLFvxWXXwPzG9ggO7Aq5tJNLgvuVLXOXpkglSrTkqE9km96Whf3SrZPqR/PrBA9UyyCxES99W9iihOJTAn/Q5Sgt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB12122

On Wed, Jun 10, 2026 at 08:38:51PM -0700, Rosen Penev wrote:
> of_device_get_match_data returns const void*. Cast to unsigned long to
> avoid implicit integer truncation warnings. All the data parameters are
> correct anyway.

where warning log?

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
