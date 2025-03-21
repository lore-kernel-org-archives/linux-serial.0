Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013012.outbound.protection.outlook.com [40.107.159.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC391DFF7
	for <linux-serial@vger.kernel.org>; Fri, 21 Mar 2025 13:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742563349; cv=fail; b=gwHiLdn/GjSgyCuHF2jhW61n5xoq/jaSiUWXSRBHV5UWXc17WFq4z2iRzeAyoSGmwmuvx3DzYndpeXdCbMgJggPH12SLPrClcm0pWH1IfwjOkK8yMd0yyJP6SALsVJLn1eJRzrp+gv2VviO/nsa17qb+XhLUpDehc/jXTv9A5q0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742563349; c=relaxed/simple;
	bh=nbLVEGzLfWYCvQWYJ6vkViEkeRw3ma7GTltU3ub/hUg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oX+x0+M79rKVYbKhjaJCyne4nKfwOR22E28FlNw4MRycdUWCI2gNOB8UYhRYru+izZpcV3fsw0riL1YhiOplkIsiwqS7QztGm3TT/aGWF4I0rBawtRXvXsdqngjGTdzjvIUdC7mdhgQks5yU2kUjvR33jXWVWmJnQWxjXOuhUls=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=fbEvYMwJ; arc=fail smtp.client-ip=40.107.159.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="fbEvYMwJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yp1XOO5mIzWdAXywtchb3iFVreHByEgXj7sb1YX+BWEip7/VaTB/nPqRI5th63ubYQ0AwZiW9+rv+P5xcdX3kkLshflEBxHSV4sE3jBGNx0Cr4b/coic6bVnDwwd+X4U2eI2QoJJKWVkMNvj6jcyO4iNemKnkcg+7JhZrJXspwMJv0pFF9+n7Cqd8qDGQ3HCCbxa4DBCkpZBlRrwW3yegJUMYJCN1c4kTxsRCb1xIZIxQOTNCGMrLmBQJTjMyGhE6RwhRcXZT6yBrOLadzc2zuzjlz1mZridhAvrBE38RTFmtKaH8sevCUS3cQv3G7BGr+Ape23KiTrPHVyuRUipfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KI3lGgReECVz63EcB92AujdLkh1kB/ZF+jh91pKIFww=;
 b=VIordtjojQKbCkn6fjCWp06nnOtTwfRVZ4KA/tTT5aV037hn1aDgkfZmRcV3lgrYGDUW5mhcNWcOmvVyJtAPnutqR/9ZcBe+TMTQk9kiHjRrR+3tglhb/JaVy0gRi1sx38KqSg7NM5bpUsj+c6ZbRU6tRFcMWa4D/COZrDRlzzbxVzcBnQLtPJ3E0iAKNm2UUO/YGssgmfj/jgvvsBltBR3kqZKTD4jTnZfks9fwK4P39rcPTB0uT92YwRsz5gvVje0DrBFxxPho6NdFAAQuQ/4MEfw2b/MexXw81dltS31ncWq8TvSguf09Ya55XV8S9jCjOoW/rPV00XBmDdZeKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KI3lGgReECVz63EcB92AujdLkh1kB/ZF+jh91pKIFww=;
 b=fbEvYMwJ6y2k9LfchRYMDE6QijYUopNlHbPns8G+qJPtg2Y9xtkkTf66IvnsT5q9jycx8pZK8tsPX5XMlvAUaWpzu7Kt5JveAbjk2xwGmYxSnx0daJ8MVfLfQ+K5OOneaO4/ZTKUONSm30cXnpo44bRvXRqNz+qRCwVX0ntRhTYlMIEcR94FUGUJYGD1MPphOvFOhwUWGOGUth8Qdd7MfWqUvXfv8hsIzpH937zvSWATjHgGZa/AbVb5sWjXp9dQZH48CvTMdg2TWhWcBMZFvjcyqo+aiEZo3lPFQYMkMiwdKkecmyIxz9FfiOi1oKFGtr1BZggF/pYtlcIg+U8SMA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com (2603:10a6:20b:4fe::20)
 by AS8PR04MB8916.eurprd04.prod.outlook.com (2603:10a6:20b:42f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Fri, 21 Mar
 2025 13:22:23 +0000
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299]) by AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299%4]) with mapi id 15.20.8534.034; Fri, 21 Mar 2025
 13:22:23 +0000
Date: Fri, 21 Mar 2025 18:54:35 +0530
From: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
To: Loic Poulain <loic.poulain@linaro.org>
Cc: robh@kernel.org, jirislaby@kernel.org, gregkh@linuxfoundation.org,
	linux-serial@vger.kernel.org, manjeet.gupta@nxp.com,
	amitkumar.karwar@nxp.com
Subject: Re: [PATCH] serdev: Add support for wakeup-source
Message-ID: <20250321132435.GA442087@PE-DT639>
References: <20250213143430.3893651-1-loic.poulain@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213143430.3893651-1-loic.poulain@linaro.org>
X-ClientProxiedBy: AS4P189CA0058.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:659::20) To AS4PR04MB9692.eurprd04.prod.outlook.com
 (2603:10a6:20b:4fe::20)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9692:EE_|AS8PR04MB8916:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a4d40d2-edaf-4d4a-4b36-08dd687b6a7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|52116014|366016|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8qO5eMGAp9UvJcUodv9LVy+30bxnQYHlJlw23lmMv3kjxYMf7LOOpN+kMJON?=
 =?us-ascii?Q?FBQ9bBqavNXzdc99WaAhfJGyQf2JUmaQWU5b49Wb+SL09q6hx5usSlmqganf?=
 =?us-ascii?Q?7Ub+Z0OiA3EUU6gDwj0AWdOkePrMPGGQAJL2CV9LfktkiZtznKRHO+gdYrRX?=
 =?us-ascii?Q?sYf1wJrMUgrQ1BPI4Tjn0Ft5+G3HK0gfz8+gy/wHVb5AbJhPC0BB7Kg5V+p/?=
 =?us-ascii?Q?bSnR6qBw5SBdD9R6MVz7f1zkOkjAzlpvAMNskl0BoB5gfNr3Wx9MEbfxuZJ6?=
 =?us-ascii?Q?qfvqCVATPUP9zXsSrmVj+/Xeushhf8qrmZPWDkERPTcFEBoUZAecrZe78ha4?=
 =?us-ascii?Q?1tcDgUBwNHbRI2iORF6NPS3sJwY37WukxOqMemAlcqJEbH5IvGXlBb2bEVl1?=
 =?us-ascii?Q?El/GK4TNH0ygPm3vlGGPqfvp/LlgYW3sgewvwTrYdNxtEX3I12RRnP5c6ips?=
 =?us-ascii?Q?mc7cx1XoYlQFELY6ZD+pAhrAgMSaBvdMj8DyDkIK3/8I4Yvz5ykNhgQ7UOa4?=
 =?us-ascii?Q?QI/2WvXnU39P202rkNqC1W2JiHZFn2jJ+YJjFuVJPHAALc81Zu3iXcsHTPJy?=
 =?us-ascii?Q?ycSYSJyriZrm3bRxXU9W9xHNhOdsj5FIpoW0tux5GhS3HTnxXLLd1wp6f3Bp?=
 =?us-ascii?Q?FRjbeMASqw2wTtW9qVPmIMeixBfQsaoDvnhg9lB+TrNLXv7DmGyOmNC2U4EY?=
 =?us-ascii?Q?++0NJaT4B8+5z1lLn+AaZg6roOuKAsW1sW/67hk1RMj9NvcTti4QdTXckg/f?=
 =?us-ascii?Q?yd4Vq60YJnlMH/HI/fLM+VvsoM0C4h4rGXu3XPCzN79MCRN6uzuL/SFyIP4m?=
 =?us-ascii?Q?veo34R0ybhPXJ/oyGLn6HkRfalJ3jqgpfAPC9Rsv7qrQL3dZyOPgnWWQ8kJs?=
 =?us-ascii?Q?R6d19iWk+smzpVFs4MVBmiyq2x2RRHYr+GsPElEu9D//JUr3eNGqdDQIDj01?=
 =?us-ascii?Q?EgRmAVu6kUL5AWvbMGkomdW4qeevwsphNgVR45MZp4Fxx25ygQBJ/Bxx6ONy?=
 =?us-ascii?Q?0365E457flqbH3bw9avuSfEam3eSb+9Qwop1c0nTF4tpY09BAroVPw7CxjcV?=
 =?us-ascii?Q?uhZPrMu9+GJjlFIWjNTcwV5kVRoVlaVN8zJXCEZ2VVwOrMyzDYNa1O3SoVtt?=
 =?us-ascii?Q?mn0+e1BMlaNNsnvFS1uQbG8O8SFCcRsoqhBEtj6XwqEkQZG1GNjccQTHb/Yx?=
 =?us-ascii?Q?0DQ8ocPffdeqKAHMeSXy5ZuthyHJnKqUMwAm/Wu7xY9lEgEz9JzCOdG15t0B?=
 =?us-ascii?Q?QjrJZxhpzSIlCIlI+A1geGcr+E3BGcnrCz88X2+Di32iNKHOgcunpW4Kc2Lm?=
 =?us-ascii?Q?nCdlqbWtB3B73A2EBZ1JOPNPm1bLLkTpMaA44aHm7gw2DaWaFJ04A1ikOx2v?=
 =?us-ascii?Q?f+n/19RKkM+kTjmk3s4tKZOiasRYi24l0PkAsI5MlgB6uPylS8W6V/EKpmtB?=
 =?us-ascii?Q?jran8VvneaHsdh6dyybsZor1EDJCRpyd?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9692.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(52116014)(366016)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8rl37Ir/HYcHauIsApg7flPKgPTNWO9XwU8i7rd5tOkCcOGThBkcAt2JZfJ9?=
 =?us-ascii?Q?VIhmdDeL5IBbThfKjmXbYyTlILObeSt8o9HE/Hu29x1RCmCdD3pzj3t3O6ht?=
 =?us-ascii?Q?wCUs06uLAF36rbuUjInV/4RZjtseS37u1K1WIOHWPyJRs8AJYi28x7hJ8Y38?=
 =?us-ascii?Q?/+6KvWg3fS0TqAwkjfA3dQXH3JcA1xODfozrr5+qyVcfh1olQYNM2nM0dUK4?=
 =?us-ascii?Q?B0DQe79/aEB4TZffSaG6G2L+imx0cqCrbSVVqSlZrJ3Gy8qkgYRwXHmzwedI?=
 =?us-ascii?Q?HPOec9lUQUheHEsbB9CE5vquKp6o24CrDYvIjmCuP6oiP9BDVtikWtF21VUS?=
 =?us-ascii?Q?+Hc0V//2E+a1KLcSkrPt0xacmFbt+V8CYO+BMJEy+q7YmLKmc47DHaocn4PG?=
 =?us-ascii?Q?sVDRVR+MNqqEklDnu8uM+J6gHhYJORvyLEwAurMuMUFiFofgwa7Ydyh4AOp1?=
 =?us-ascii?Q?dbhs7Liq5zdPxrvNWdPYTEkxwNX1hPuDj7M30MkSwKEnwroILJt5bMsywd6E?=
 =?us-ascii?Q?DnDC3mIwExHJuUJxfoIA7JrtneMgWwktFwIqmHIsxHiy3B/HaC0XgdeVIc/Y?=
 =?us-ascii?Q?1Mp7M0ODLZtqc20WB6K7/V4kTH0aqwzBzmKS1rqUpIsAtPQUljMiJZwIBlSc?=
 =?us-ascii?Q?3OXvf/CuROHK/3oO6lDaDJsP/NUTbhCDFcCLW1QXZoxv8zjNookCIMfNG6yO?=
 =?us-ascii?Q?LqwbkBF8rdaz1aXoiKhHz32Jf+no0F0l31uZH9BOqZ+iaz6uoCXniqZPmyf1?=
 =?us-ascii?Q?hVkEDOZYkQKSUpE451QmHjbvChAvQu7MAfLE4wTi38WvRTT6A+Rm5loTRlJS?=
 =?us-ascii?Q?RPqv1xg7OnF35BuAMBbovMpqpiUNr372KcGpPyjBITLi3mPhJbXRLggbh3tz?=
 =?us-ascii?Q?Hav+fHbKzaV52p7d2TCwm5aDoeKjSFvU6Qr8hm+bFo0jtcpRBzPrVetFlUtv?=
 =?us-ascii?Q?Tb8g0IwDSVYV8eNUebhT4WaYqT1j/lVsuMFwfh50bfLd1d9U7nf75S82rvsp?=
 =?us-ascii?Q?C2TSxpSnpU76uYxh5sMjQtbJjEI3Pyi4aIPwXfLQl9odgm+KoxS9i+XoRCHX?=
 =?us-ascii?Q?HB8ALCJt6S0ATNiWured7DVqW9e+kDoUSdffHrhIc+e2FZBySpEz8TgrURxK?=
 =?us-ascii?Q?PexIMNASM+qa7GKwccYzAvUw2iPJ4RmTB7kNX24ZnfVAuh1XH0GjwmO6kxvq?=
 =?us-ascii?Q?kvXXo/d4MqNMaLJ3uuJfFYie1nGjoAEchejK7ftLO8XFx+hlMDHy4IZ9mHln?=
 =?us-ascii?Q?P6eJeLvPwkhm6+WMHuQ1VhnsHufUlkwfOEKGzHTzjJHl78QrQ2nVEAlo8kq/?=
 =?us-ascii?Q?4x03wP4Ro9SsO6x/8F9FOlXzMYVtggOPK0ENufXuR3FwDArs1xTahPN/oHAX?=
 =?us-ascii?Q?s9Fr8hAoVFddxRp9m5Lg52L7LJP0plGse7eIOwXkBQExlSa5zOHIX6DPQVEL?=
 =?us-ascii?Q?oI3+ds4Cv1BUSvorHX3lM4jl2AUZgaDUiOHczmRUmwH2TxcfKvNbjsHITpS6?=
 =?us-ascii?Q?L7L+YtZI6SLWjYZpcHIT555uhIKM6JBHPhyNAfXaU+xAviCTDqvGNLZN8mbY?=
 =?us-ascii?Q?nagacF72A5noGPn6w5NJ4M+C31czXbOuigWmur8rI2qd5j7ySSoMCFHRwYcd?=
 =?us-ascii?Q?6w=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a4d40d2-edaf-4d4a-4b36-08dd687b6a7f
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9692.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 13:22:23.6586
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /NGeGESrCoKabo8nA/CXaQwCWlc0GOo/jwDHy9W0hAk1zWvYr6wuJWP6vZrMYzeRKtFn5aUgitHpGwnbQZUULIFeiHqjOi9YLC2VsI638gY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8916

Hi Loic,

Thank you for the patch.

I have verified this patch with btnxpuart driver and I am able to wakeup the host with a GPIO interrupt signal from BT controller.

Tested-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>

Thanks,
Neeraj

On Thu, Feb 13, 2025 at 03:34:30PM +0100, Loic Poulain wrote:
> This brings support for dedicated interrupt as wakeup source into the
> serdev core, similarly to the I2C bus, and aligned with the documentation:
> Documentation/devicetree/bindings/power/wakeup-source.txt
> 
> As an example, this can be used for bluetooth serial devices with dedicated
> controller-to-host wakeup pin.
> 
> Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
> ---
>  drivers/tty/serdev/core.c | 48 +++++++++++++++++++++++++++++++++++++--
>  include/linux/serdev.h    |  1 +
>  2 files changed, 47 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
> index ebf0bbc2cff2..2d016fa546ca 100644
> --- a/drivers/tty/serdev/core.c
> +++ b/drivers/tty/serdev/core.c
> @@ -13,8 +13,10 @@
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/of_device.h>
> +#include <linux/of_irq.h>
>  #include <linux/pm_domain.h>
>  #include <linux/pm_runtime.h>
> +#include <linux/pm_wakeirq.h>
>  #include <linux/property.h>
>  #include <linux/sched.h>
>  #include <linux/serdev.h>
> @@ -164,6 +166,9 @@ int serdev_device_open(struct serdev_device *serdev)
>  		goto err_close;
>  	}
>  
> +	if (serdev->wakeup_source)
> +		device_wakeup_enable(&serdev->dev);
> +
>  	return 0;
>  
>  err_close:
> @@ -181,6 +186,9 @@ void serdev_device_close(struct serdev_device *serdev)
>  	if (!ctrl || !ctrl->ops->close)
>  		return;
>  
> +	if (serdev->wakeup_source)
> +		device_wakeup_disable(&serdev->dev);
> +
>  	pm_runtime_put(&ctrl->dev);
>  
>  	ctrl->ops->close(ctrl);
> @@ -406,18 +414,52 @@ int serdev_device_break_ctl(struct serdev_device *serdev, int break_state)
>  }
>  EXPORT_SYMBOL_GPL(serdev_device_break_ctl);
>  
> +static int serdev_wakeup_attach(struct device *dev)
> +{
> +	int wakeirq;
> +
> +	if (!of_property_read_bool(dev->of_node, "wakeup-source"))
> +		return 0;
> +
> +	to_serdev_device(dev)->wakeup_source = true;
> +
> +	device_set_wakeup_capable(dev, true);
> +
> +	wakeirq = of_irq_get_byname(dev->of_node, "wakeup");
> +	if (wakeirq == -EPROBE_DEFER)
> +		return -EPROBE_DEFER;
> +	else if (wakeirq > 0)
> +		return dev_pm_set_dedicated_wake_irq(dev, wakeirq);
> +
> +	return 0;
> +}
> +
> +static void serdev_wakeup_detach(struct device *dev)
> +{
> +	device_init_wakeup(dev, false);
> +	dev_pm_clear_wake_irq(dev);
> +}
> +
>  static int serdev_drv_probe(struct device *dev)
>  {
>  	const struct serdev_device_driver *sdrv = to_serdev_device_driver(dev->driver);
>  	int ret;
>  
> -	ret = dev_pm_domain_attach(dev, true);
> +	ret = serdev_wakeup_attach(dev);
>  	if (ret)
>  		return ret;
>  
> +	ret = dev_pm_domain_attach(dev, true);
> +	if (ret) {
> +		serdev_wakeup_detach(dev);
> +		return ret;
> +	}
> +
>  	ret = sdrv->probe(to_serdev_device(dev));
> -	if (ret)
> +	if (ret) {
>  		dev_pm_domain_detach(dev, true);
> +		serdev_wakeup_detach(dev);
> +	}
>  
>  	return ret;
>  }
> @@ -429,6 +471,8 @@ static void serdev_drv_remove(struct device *dev)
>  		sdrv->remove(to_serdev_device(dev));
>  
>  	dev_pm_domain_detach(dev, true);
> +
> +	serdev_wakeup_detach(dev);
>  }
>  
>  static const struct bus_type serdev_bus_type = {
> diff --git a/include/linux/serdev.h b/include/linux/serdev.h
> index ff78efc1f60d..2b3ee7b2c141 100644
> --- a/include/linux/serdev.h
> +++ b/include/linux/serdev.h
> @@ -47,6 +47,7 @@ struct serdev_device {
>  	const struct serdev_device_ops *ops;
>  	struct completion write_comp;
>  	struct mutex write_lock;
> +	bool wakeup_source;
>  };
>  
>  static inline struct serdev_device *to_serdev_device(struct device *d)
> -- 
> 2.34.1
> 
