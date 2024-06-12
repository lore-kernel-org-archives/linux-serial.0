Received: from eu-smtp-delivery-197.mimecast.com (eu-smtp-delivery-197.mimecast.com [185.58.85.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ADE84688
	for <linux-serial@vger.kernel.org>; Wed, 12 Jun 2024 13:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718200692; cv=none; b=kHSML9/iMsRhIfxTlWbZJaVUhYTvpKdG5Dcz/6P6Ryg/cn0ahYP/TrbFW02dPWcRV7TbhxVNVqIYDRU6EAzNciU/qdWqvH8M2ZS4BBiPB5PPLEjV0HWOmJ0KCUmoRXDAYncqfC55hBFVnkMx/vqYeDmY+i52+YkslZTrssxOUdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718200692; c=relaxed/simple;
	bh=O6G5TaiCA41+wSa7aM4dFLV/xHyDNAm98fdMR7CjG5g=;
	h=Message-ID:Date:From:Subject:To:CC:References:In-Reply-To:
	 MIME-Version:Content-Type; b=OwFmkQofzvmYzXVto1rmNlqJ6pKslFP4K85q3opX91go2BQC0IZKdp4Ed5F0T+VPp2iVRGD5CiaWh9Uk7jlJFai5myTM+78NqN9TpTsZ3KYEa+d0YO7UwqUQa00YlxweT4B631hlPPCs+pmk26bVyaYqqmf84lf+tgLuwbc+0zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=camlingroup.com; spf=pass smtp.mailfrom=camlingroup.com; dkim=pass (1024-bit key) header.d=camlingroup.com header.i=@camlingroup.com header.b=U+eP6hTk; arc=none smtp.client-ip=185.58.85.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=camlingroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=camlingroup.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=camlingroup.com header.i=@camlingroup.com header.b="U+eP6hTk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=camlingroup.com;
	s=mimecast20210310; t=1718200689;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KWCbTGY2sxHZYGiHeyxnlA7b3gCtopcNxMCb8DtEp+0=;
	b=U+eP6hTkSvg8avnjOkFlUxJ6NwPucNkgLECfaOg+r0nqfz6hfgKxW1mCOImLbFQaTfsPxn
	TS7B23X5Uq0ysyrLI1pRJ07kW6tP6Fbg8qtMU6iv3Wz12d1T5r4qEfursCfRZ9c/JFESAd
	AJOdjdaS5sTHM1PreDAGdxWLArke6bc=
Received: from GBR01-CWX-obe.outbound.protection.outlook.com
 (mail-cwxgbr01lp2040.outbound.protection.outlook.com [104.47.85.40]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 uk-mta-86-1f6TP0P4OSGdBY2xiXGQbQ-1; Wed, 12 Jun 2024 14:56:56 +0100
X-MC-Unique: 1f6TP0P4OSGdBY2xiXGQbQ-1
Received: from CWXP123MB5267.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:142::9)
 by LO0P123MB7197.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:333::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.37; Wed, 12 Jun
 2024 13:56:54 +0000
Received: from CWXP123MB5267.GBRP123.PROD.OUTLOOK.COM
 ([fe80::f866:62f9:716e:ca4f]) by CWXP123MB5267.GBRP123.PROD.OUTLOOK.COM
 ([fe80::f866:62f9:716e:ca4f%4]) with mapi id 15.20.7677.019; Wed, 12 Jun 2024
 13:56:54 +0000
Message-ID: <18a1beeb-e45b-4d6d-bd21-74b85c33dc2c@camlingroup.com>
Date: Wed, 12 Jun 2024 15:56:51 +0200
User-Agent: Mozilla Thunderbird
From: Lech Perczak <lech.perczak@camlingroup.com>
Subject: Re: [PATCH v3 2/2] serial: sc16is7xx: hardware reset chip if
 reset-gpios is defined in DT
To: Hui Wang <hui.wang@canonical.com>, linux-serial@vger.kernel.org,
 devicetree@vger.kernel.org, gregkh@linuxfoundation.org
CC: jirislaby@kernel.org, hvilleneuve@dimonoff.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, andy@kernel.org,
 Maarten.Brock@sttls.nl
References: <20240612131454.49671-1-hui.wang@canonical.com>
 <20240612131454.49671-2-hui.wang@canonical.com>
In-Reply-To: <20240612131454.49671-2-hui.wang@canonical.com>
X-ClientProxiedBy: WA1P291CA0016.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::27) To CWXP123MB5267.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:142::9)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWXP123MB5267:EE_|LO0P123MB7197:EE_
X-MS-Office365-Filtering-Correlation-Id: b4fb6666-f1d9-4cb5-dbf3-08dc8ae78453
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230032|1800799016|7416006|366008|376006
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?yw9wqc2zjXBJfHMkBc7kSgyLEzGCx5uNP5aXuHrPhoT7OXHWHCYHpGB3Tubq?=
 =?us-ascii?Q?YyLMQ7X3PRmunQEPOLrAY0pgKI8by5ccirTkfwdq246xLAIvzAWg3KJoQQAK?=
 =?us-ascii?Q?yiB1C3u5Ecrk938htn1FIe/maZjCzOGMSrDrSOJeXnqlGrtrbCEWgNCeJHGO?=
 =?us-ascii?Q?WPSk7ZadnerlMWtWIAvozPy9EW8qx6ed0Ujz+KuLZwuSDNriPX3BKchSeEha?=
 =?us-ascii?Q?BwYu0/BsDsqSkiCrFyNQ7tq5upFAeIwIGgSXe5GZtOJQx3kiO6vDmnGjYnR/?=
 =?us-ascii?Q?TkNpziz44aq/Q9B/xps6hPMyS/1bsMLtj8eDelj8k3uPTPte2yQMdsnY11sS?=
 =?us-ascii?Q?KzG8g2nRa77HuX8ybjvym7iPFck4wqXeFaA5pJYNJ6lKmB2KU63/FPKJspqm?=
 =?us-ascii?Q?7vNNgVnHNfQaB8+2JH4eWA/TEHNWRhx5LWYJI9TWZnRHnW8T9DdhQmNn68qs?=
 =?us-ascii?Q?kMK4rAtmDFe/K5IdIT5Ut2ERDZimsqvNmR1lmP43Vjcy33+vIKOkDxIqIkEe?=
 =?us-ascii?Q?Y8Z/HtVAfXW1J/0A08j7BC8SYemFbQqCrzdaf9zKaJd3c7nj4HJ24qvLiS9R?=
 =?us-ascii?Q?E3h3c91+axg5DtNn4zbGXo3detoZPVPPGEyWpX4YUJJ+e3u/qa7ixhy13r3/?=
 =?us-ascii?Q?Nzk4AvBVD3lJeyyo1+MQJz/cOURjNNGwPrQg+rxv8WMnyzRuWgSNVJzOB97V?=
 =?us-ascii?Q?Agj29LsvRH+uxIfP2rK7OVIBBfTMn2JKNtc+wp7RHVJdGygtuWy+MfwxQIcm?=
 =?us-ascii?Q?0ctViBKO8YGwl//iFjNoxOxqdaHBx9dC5cPNFrJuj1x5rp7MzGFWns7KyDey?=
 =?us-ascii?Q?RTc45yvF+L5/SGclHZwU1ljuWAKAUdvrLC1qECfl04CqkZxISVDgTWPUCjm0?=
 =?us-ascii?Q?7odXkq3Qp/RS7IjIjzb+/um70rIuDizMYIJhLQXxMOCwq4tfJ0t4ZFDLbcnh?=
 =?us-ascii?Q?mtGIesZkr5gaEczF4gb/QMAQ8YKcyPniUaYuyZCGT01CNkwrvGql0pz8dmgG?=
 =?us-ascii?Q?VhyDDVrZxbBfsKfWgboQwZ3l1A9410gPQQvOobMmkgHifIntROg8EQwhoWQE?=
 =?us-ascii?Q?X5tEi1KcmGgnLYodCAbPb/nILQ+l80kUxTPkNL51D1cjhRdQvCcKOyy4EGgq?=
 =?us-ascii?Q?k+FWIv6zDdRZIu4lPhIzGSdpyIzoBW+fnw14qv6VYK31TbgWtJ5QvsyZbyC/?=
 =?us-ascii?Q?7RAvlzVnbqZhe5XbxQKYt5ObeCuTDgbjZda84MeO7Xrz5oqkDeLZJSefVaeY?=
 =?us-ascii?Q?PvyQn6t8u5PB1GCwQMic?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWXP123MB5267.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230032)(1800799016)(7416006)(366008)(376006);DIR:OUT;SFP:1102
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6bbdJvpIQ1ZT0rcNJvD5UpYY+1SYNBU10sbFUS1YJTqAlfoSCATUDWmmd5gx?=
 =?us-ascii?Q?UoLlyqwX9vi+cQ4HgxHSbRnioFTvUmbIPDb10+bIU2rA8mspu9/3ZNXkh9Dd?=
 =?us-ascii?Q?YzG845TfyuKEb6QdnIJBr/gDJiIxbYxgVC+am575vHjUDclrJT+ZtTjJlPl2?=
 =?us-ascii?Q?+UGCJq6OpN50APdPSLwMNtvM78KaQK9Nz/AQfSBwCL1GSRDvoDsJk6r08liS?=
 =?us-ascii?Q?APe/8RL+1Eo6F0rgXPE5Ks5bnBVf8RZ16QkTDiOMeGYIoVz/Z907+PwoveCP?=
 =?us-ascii?Q?vOAHl6PaCU6TDnPKMMs6mSdXCthxGtcqb5OocUSMc7QEppvuFIGS/HAQ0na7?=
 =?us-ascii?Q?35FyQZF2jEbsGU1wI0ofehbksr6/5aL4Iw6OkIBYTlXRohJyy7M7M+VsWpoV?=
 =?us-ascii?Q?cuNxb0IOmoPmtb+lCYxURXHm/MkkT+EDyEveX1guQGc+JuprwCV01wDVErLW?=
 =?us-ascii?Q?hvs6TUwh6OtIwjVbAsVyIHJSGGp1B3J79ZyMwZ0h2yB2QBbTIxCrDbyslshb?=
 =?us-ascii?Q?Spdk/UvpBP8XH55z3NK+q16Oye1vzfXFik/eVK1EKJ+JvwYIASM/sZntVXzv?=
 =?us-ascii?Q?GKt1QING0vXufQo/q616fUAWeFLm9sRazDvwN9Lo5YS0som20f8ANZpkHcUZ?=
 =?us-ascii?Q?aVCb8ZwcJtifeNpFZLLNRFO+Py5XIXp2+A5SoGpL+0AUkX995KdXaM1wBA6f?=
 =?us-ascii?Q?QUnn687FpyHdyCCQOmzy1NdOn0T6FoXO7Bq1dmqgrj+CTuN2Bc5c5QuYnYFq?=
 =?us-ascii?Q?8i5bTTPvyO0tTbVvBseHEJyV9lzPLyU4etViB9Ve+fdidw9osSzDncXTQ9Dv?=
 =?us-ascii?Q?Qd4qn4WmhXJx74JUK4vxyBPQmJFDVcnB1od5sYtv/UvXanCwA2lMly5l30j9?=
 =?us-ascii?Q?5KZEyBnPSw36x1Eyh0elcsPZ4KATfOJ5ChJVbiiDDdJDlwz632QOCBNCxttq?=
 =?us-ascii?Q?vwp5oGp4oB0N5hCiJi7P9VbuqNYn/ZM/8lXTyekzVZ8B+mWz81t2EKIw4OvD?=
 =?us-ascii?Q?7Hahew8pAnhrTG8gYN9aQp8QlG1Uk3vB90Z5n8uIj85HdV4uGvzX2ypHgwmL?=
 =?us-ascii?Q?T98nCPvqF358WJlpPBejIOpiBqA2kxNtLot9ZVLI/RJA+o8eNxVr0yMiZHIu?=
 =?us-ascii?Q?+GzWALleQnI+FAZ0JOoJGohsEqpJ97q2KEKkAPjLK7Uc9HWhQU65xz2yf6jn?=
 =?us-ascii?Q?JAHHTInuQFg3czZFjFf/y61Dp4SE25SpCmjZUqdCvO7V26nNR03NZOlYj42q?=
 =?us-ascii?Q?gvlbZI5FIw28ZYRSAH6fJmB6HgncNRebooZLCCr3hw8EAodHhBNCTJGzigZf?=
 =?us-ascii?Q?SaVOdtVv4LIS6v3vVd3flUnp2NxvpsNc0GSS6S24y0hcVAs5eNoB2JTU3uI7?=
 =?us-ascii?Q?wPrJJPSIlMJVC0vrQ5wiY3fON4pTCAeW6r4UPqyjjKImMIxs91CDDzGbisGu?=
 =?us-ascii?Q?zfawK243rwWaqthbBKG2mfENAM9pROv50yxgNQQoXr9ujzcKUOmw1aku5Ow4?=
 =?us-ascii?Q?bla2bAqam64N+ADbUx8J1Ej7Mb8a7H9re1GQxPjbY5jb9KYZtCzzpsQdBe8v?=
 =?us-ascii?Q?abLpbpCvx3GBEvJjYBB+MC92QQxc6kDlZaD0hsE+CqqLw/NMRxN+qNFskdwW?=
 =?us-ascii?Q?xEhnw82AGrcoRmTNExn27gnGZhmkGSaD2SWuWh1+9SuER66cgDSN4VYpldAI?=
 =?us-ascii?Q?jTM9pw=3D=3D?=
X-OriginatorOrg: camlingroup.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4fb6666-f1d9-4cb5-dbf3-08dc8ae78453
X-MS-Exchange-CrossTenant-AuthSource: CWXP123MB5267.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2024 13:56:54.3356
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fd4b1729-b18d-46d2-9ba0-2717b852b252
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wIpyzC6zxXlG3DAdyJ1VZsir6F20OW0m5yufsfVSDS0cjgLa+OZs65DqjlpPzInm8R6m50TaCR9QbToXdL5i8kCNH1foYMX2AmAKU2P7D2I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P123MB7197
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: camlingroup.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,
Some comments inline.

W dniu 12.06.2024 o=C2=A015:14, Hui Wang pisze:
> Some boards connect a GPIO to the reset pin, and the reset pin needs
> to be setup correctly before accessing the chip.
>
> Add a function to handle the chip reset. If the reset-gpios is defined
> in the DT, do hardware reset through this GPIO, othwerwise do software
> reset as before.
>
> Signed-off-by: Hui Wang <hui.wang@canonical.com>
> ---
> In the v3:
>  - drop Reviewed-by
>  - adjust the sequence of if, else if and else
>  - replace PTR_ERR(reset_gpiod) with dev_err_probe
>  - change GPIOD_OUT_LOW to GPIOD_OUT_HIGH, this will assert the reset pin=
 after requesting the GPIO
>  - change the 2nd parameter struct regmap *regmap[] to struct regmap *reg=
map
>  - address all spelling and description issues in the v2
>
>  drivers/tty/serial/sc16is7xx.c | 33 +++++++++++++++++++++++++++++----
>  1 file changed, 29 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7x=
x.c
> index bf0065d1c8e9..8c7e0fe76049 100644
> --- a/drivers/tty/serial/sc16is7xx.c
> +++ b/drivers/tty/serial/sc16is7xx.c
> @@ -14,6 +14,7 @@
>  #include <linux/delay.h>
>  #include <linux/device.h>
>  #include <linux/export.h>
> +#include <linux/gpio/consumer.h>
>  #include <linux/gpio/driver.h>
>  #include <linux/idr.h>
>  #include <linux/kthread.h>
> @@ -1467,6 +1468,30 @@ static const struct serial_rs485 sc16is7xx_rs485_s=
upported =3D {
>         .delay_rts_after_send =3D 1,      /* Not supported but keep retur=
ning -EINVAL */
>  };
>
> +/* Reset device, purging any pending irq / data */
> +static int sc16is7xx_reset(struct device *dev, struct regmap *regmap)
> +{
> +       struct gpio_desc *reset_gpio;
> +
> +       /* The reset GPIO is ACTIVE_LOW, flag GPIOD_OUT_HIGH asserts the =
reset GPIO */
s/reset GPIO is ACTIVE_LOW /reset input is active low/ - because we're refe=
rring to the chip input here, and this is reflected in DT bindings.

Also, it isn't clear from the comment that GPIO is asserted immediately.


> +       reset_gpio =3D devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HI=
GH);
> +       if (IS_ERR(reset_gpio))
> +               return dev_err_probe(dev, PTR_ERR(reset_gpio), "Failed to=
 get reset GPIO\n");
> +
> +       if (reset_gpio) {
> +               /* The minimum reset pulse width is 3 us. */
> +               udelay(5);

Prefer usleep_range() over that, since maximum reset time isn't all that cr=
itical.


> +               gpiod_set_value_cansleep(reset_gpio, 0);
> +               /* Deassert GPIO */

This comment should go one line above or be removed entirely.


> +       } else {
> +               /* Software reset */
> +               regmap_write(regmap, SC16IS7XX_IOCONTROL_REG,
> +                            SC16IS7XX_IOCONTROL_SRESET_BIT);
> +       }
> +
> +       return 0;
> +}
> +
>  int sc16is7xx_probe(struct device *dev, const struct sc16is7xx_devtype *=
devtype,
>                     struct regmap *regmaps[], int irq)
>  {
> @@ -1527,6 +1552,10 @@ int sc16is7xx_probe(struct device *dev, const stru=
ct sc16is7xx_devtype *devtype,
>         s->devtype =3D devtype;
>         dev_set_drvdata(dev, s);
>
> +       ret =3D sc16is7xx_reset(dev, regmaps[0]);
> +       if (ret)
> +               goto out_clk;
> +
>         kthread_init_worker(&s->kworker);
>         s->kworker_task =3D kthread_run(kthread_worker_fn, &s->kworker,
>                                       "sc16is7xx");
> @@ -1536,10 +1565,6 @@ int sc16is7xx_probe(struct device *dev, const stru=
ct sc16is7xx_devtype *devtype,
>         }
>         sched_set_fifo(s->kworker_task);
>
> -       /* reset device, purging any pending irq / data */
> -       regmap_write(regmaps[0], SC16IS7XX_IOCONTROL_REG,
> -                    SC16IS7XX_IOCONTROL_SRESET_BIT);
> -
>         /* Mark each port line and status as uninitialised. */
>         for (i =3D 0; i < devtype->nr_uart; ++i) {
>                 s->p[i].port.line =3D SC16IS7XX_MAX_DEVS;
> --
> 2.34.1

--=20
Pozdrawiam/With kind regards,
Lech Perczak

Sr. Software Engineer
Camlin Technologies Poland Limited Sp. z o.o.
Strzegomska 54,
53-611 Wroclaw
Tel:     (+48) 71 75 000 16
Email:   lech.perczak@camlingroup.com
Website: http://www.camlingroup.com

