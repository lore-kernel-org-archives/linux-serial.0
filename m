Return-Path: <SRS0=tlDI=6U=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FFCCC28CBC
	for <linux-serial@archiver.kernel.org>; Wed,  6 May 2020 11:03:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1865220714
	for <linux-serial@archiver.kernel.org>; Wed,  6 May 2020 11:03:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="bDVmQ0EZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725882AbgEFLCz (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 6 May 2020 07:02:55 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:35836 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727893AbgEFLCz (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 6 May 2020 07:02:55 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200506110251euoutp01e729631da068cd2f33ad0910d9ce8f9e~Ma4FHNYOP0900609006euoutp01k
        for <linux-serial@vger.kernel.org>; Wed,  6 May 2020 11:02:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200506110251euoutp01e729631da068cd2f33ad0910d9ce8f9e~Ma4FHNYOP0900609006euoutp01k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1588762971;
        bh=Hs2Nzv92QqdJ8EHIoLJIaIAUoacHy1QViDiEr6yGEoY=;
        h=Subject:To:From:Cc:Date:In-Reply-To:References:From;
        b=bDVmQ0EZKK5UJKA0k+v4wGR0x7FiIq8Sl1bU/+lExrryg1iM37sR62Ku2rUL3sM3D
         pKCfNcVS3O9YfH2J+V7JqmooenbwtzZQvjxgYOg1ubw32hU5iABcsKB70r+/d9XyuN
         T9zG+6PGwvWpFw/42hI2C6OoeOcqB2yRly/HUpRc=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200506110251eucas1p104b545408aa5cd6e0ebd1d1c89e6becc~Ma4E0bbDY2312923129eucas1p1Z;
        Wed,  6 May 2020 11:02:51 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 98.0E.60679.B5992BE5; Wed,  6
        May 2020 12:02:51 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200506110250eucas1p25a74a37f899d8942cbf06457738fef5c~Ma4Eal-PC0589605896eucas1p2W;
        Wed,  6 May 2020 11:02:50 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200506110250eusmtrp148cdad59bf92eace06afe76ca6c6f4f3~Ma4EZ1SV52544325443eusmtrp1u;
        Wed,  6 May 2020 11:02:50 +0000 (GMT)
X-AuditID: cbfec7f4-0e5ff7000001ed07-0c-5eb2995bc236
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 3F.55.07950.A5992BE5; Wed,  6
        May 2020 12:02:50 +0100 (BST)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200506110250eusmtip298a51f745c23623739f778e654242287~Ma4D7IKem1685116851eusmtip2u;
        Wed,  6 May 2020 11:02:50 +0000 (GMT)
Subject: Re: [PATCH v10 3/3] tty: samsung_tty: 32-bit access for TX/RX hold
 registers
To:     Hyunki Koo <hyunki00.koo@samsung.com>
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Message-ID: <1b230724-c87b-aa28-f850-ecdeb0542dba@samsung.com>
Date:   Wed, 6 May 2020 13:02:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200506080242.18623-3-hyunki00.koo@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFKsWRmVeSWpSXmKPExsWy7djP87rRMzfFGWx7zmzRvHg9m8WqpTeY
        LaZs+MBk0f/4NbPF+fMb2C02Pb7GanF51xw2ixnn9zFZnFncy+7A6bFpVSebx/65a9g9Ni+p
        9+jbsorRY/2WqywenzfJBbBFcdmkpOZklqUW6dslcGXM3DGFpWCzQsXiJvcGxieSXYycHBIC
        JhJTHh9g6WLk4hASWMEosbZtMxOE84VRomHmBKjMZ0aJhw2NLDAtv6+8YYRILGeU2HNwBzuE
        85ZR4u3eZiaQKmGBcIlpDUsZQWwRAU2J1juz2EFsNgEriYntq8C6mQWWMEkc33QIbCyvgJ3E
        7s7rYM0sAioSl++cBmsQFYiQ+PTgMCtEjaDEyZlPwOo5geovtX0Es5kFxCVuPZnPBGHLS2x/
        O4cZZIGEwCl2ifmXPrJC3O0iMen1AUYIW1ji1fEt7BC2jMTpyT0sEA3rGCX+dryA6t7OKLF8
        8j82iCpriTvnfgHZHEArNCXW79KHCDtK9DavZAYJSwjwSdx4KwhxBJ/EpG3TocK8Eh1tQhDV
        ahIblm1gg1nbtXMl8wRGpVlIXpuF5J1ZSN6ZhbB3ASPLKkbx1NLi3PTUYqO81HK94sTc4tK8
        dL3k/NxNjMAUdfrf8S87GHf9STrEKMDBqMTDa+C+MU6INbGsuDL3EKMEB7OSCC/PD6AQb0pi
        ZVVqUX58UWlOavEhRmkOFiVxXuNFL2OFBNITS1KzU1MLUotgskwcnFINjKF6WwSCa84vtLrf
        vr+Y+5j0u7CTDycKXHOx/Fo0aeWJY1cyT+7SctJnue7bZuW7uKFyXeKlBwkdN28yt5hrzr2n
        1bO3zUS5dUd9Z9HJ03ZJZzdp6En08Fcmv14QLBYfv86S0VQ1n3Patw2b0nvYvT+qRRcarKp9
        +Sbxjd77U5pvmUvS5l3mVWIpzkg01GIuKk4EAIjin6JNAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJIsWRmVeSWpSXmKPExsVy+t/xe7pRMzfFGSx8qmPRvHg9m8WqpTeY
        LaZs+MBk0f/4NbPF+fMb2C02Pb7GanF51xw2ixnn9zFZnFncy+7A6bFpVSebx/65a9g9Ni+p
        9+jbsorRY/2WqywenzfJBbBF6dkU5ZeWpCpk5BeX2CpFG1oY6RlaWugZmVjqGRqbx1oZmSrp
        29mkpOZklqUW6dsl6GXM3DGFpWCzQsXiJvcGxieSXYycHBICJhK/r7xh7GLk4hASWMoo8fP5
        aZYuRg6ghIzE8fVlEDXCEn+udbGB2EICrxkl9h93AbGFBcIlpjUsZQSxRQQ0JVrvzGKHmHOU
        UWLTxnZ2kASbgJXExPZVYEXMAkuYJI5v1gWxeQXsJHZ3XmcCsVkEVCQu3zkNVi8qECFxeMcs
        RogaQYmTM5+wgNicQPWX2j6yQMxRl/gz7xIzhC0ucevJfCYIW15i+9s5zBMYhWYhaZ+FpGUW
        kpZZSFoWMLKsYhRJLS3OTc8tNtIrTswtLs1L10vOz93ECIzGbcd+btnB2PUu+BCjAAejEg+v
        gfvGOCHWxLLiytxDjBIczEoivDw/gEK8KYmVValF+fFFpTmpxYcYTYGem8gsJZqcD0wUeSXx
        hqaG5haWhubG5sZmFkrivB0CB2OEBNITS1KzU1MLUotg+pg4OKUaGA/t4rH943ouV3Huhxdc
        X0N9v2+65RPv4+zKypTlM8+pUl/+8jvTTZYCc/fprdS/sOnRQg19Kb0cgaDMms9NW17EXryV
        /4934eKtjm9EN2sZTiicbM43eabLAZfO+SlWre3h0tevrXg/NWVb6pkb7T9OFSl9nGPOER26
        79Cjf99aC3UPvVy7y1+JpTgj0VCLuag4EQBaQFrf3AIAAA==
X-CMS-MailID: 20200506110250eucas1p25a74a37f899d8942cbf06457738fef5c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200506080258epcas2p4f242fb66a2145f76b0e108014ee351fb
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200506080258epcas2p4f242fb66a2145f76b0e108014ee351fb
References: <20200506080242.18623-1-hyunki00.koo@samsung.com>
        <CGME20200506080258epcas2p4f242fb66a2145f76b0e108014ee351fb@epcas2p4.samsung.com>
        <20200506080242.18623-3-hyunki00.koo@samsung.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


Hi!

On 5/6/20 10:02 AM, Hyunki Koo wrote:
> Support 32-bit access for the TX/RX hold registers UTXH and URXH.
> 
> This is required for some newer SoCs.

Krzysztof has asked this previously but I couldn't find the answer in
previous mails:

Do you plan to upstream support for these newer SoCs?

If not (i.e. this code is only to support Android GKI) then the code
you are adding now may be removed at any time later during cleanups
(due to lack of the in-kernel users).

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> Signed-off-by: Hyunki Koo <hyunki00.koo@samsung.com>
> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
> Tested on Odroid HC1 (Exynos5422):
> Tested-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  drivers/tty/serial/samsung_tty.c | 62 ++++++++++++++++++++++++++++++++++++----
>  1 file changed, 57 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
> index 326b0164609c..6ef614d8648c 100644
> --- a/drivers/tty/serial/samsung_tty.c
> +++ b/drivers/tty/serial/samsung_tty.c
> @@ -154,10 +154,33 @@ struct s3c24xx_uart_port {
>  #define portaddrl(port, reg) \
>  	((unsigned long *)(unsigned long)((port)->membase + (reg)))
>  
> -#define rd_reg(port, reg) (readb_relaxed(portaddr(port, reg)))
> +static u32 rd_reg(struct uart_port *port, u32 reg)
> +{
> +	switch (port->iotype) {
> +	case UPIO_MEM:
> +		return readb_relaxed(portaddr(port, reg));
> +	case UPIO_MEM32:
> +		return readl_relaxed(portaddr(port, reg));
> +	default:
> +		return 0;
> +	}
> +	return 0;
> +}
> +
>  #define rd_regl(port, reg) (readl_relaxed(portaddr(port, reg)))
>  
> -#define wr_reg(port, reg, val) writeb_relaxed(val, portaddr(port, reg))
> +static void wr_reg(struct uart_port *port, u32 reg, u32 val)
> +{
> +	switch (port->iotype) {
> +	case UPIO_MEM:
> +		writeb_relaxed(val, portaddr(port, reg));
> +		break;
> +	case UPIO_MEM32:
> +		writel_relaxed(val, portaddr(port, reg));
> +		break;
> +	}
> +}
> +
>  #define wr_regl(port, reg, val) writel_relaxed(val, portaddr(port, reg))
>  
>  /* Byte-order aware bit setting/clearing functions. */
> @@ -1974,7 +1997,7 @@ static int s3c24xx_serial_probe(struct platform_device *pdev)
>  	struct device_node *np = pdev->dev.of_node;
>  	struct s3c24xx_uart_port *ourport;
>  	int index = probe_index;
> -	int ret;
> +	int ret, prop = 0;
>  
>  	if (np) {
>  		ret = of_alias_get_id(np, "serial");
> @@ -2000,10 +2023,27 @@ static int s3c24xx_serial_probe(struct platform_device *pdev)
>  			dev_get_platdata(&pdev->dev) :
>  			ourport->drv_data->def_cfg;
>  
> -	if (np)
> +	if (np) {
>  		of_property_read_u32(np,
>  			"samsung,uart-fifosize", &ourport->port.fifosize);
>  
> +		if (of_property_read_u32(np, "reg-io-width", &prop) == 0) {
> +			switch (prop) {
> +			case 1:
> +				ourport->port.iotype = UPIO_MEM;
> +				break;
> +			case 4:
> +				ourport->port.iotype = UPIO_MEM32;
> +				break;
> +			default:
> +				dev_warn(&pdev->dev, "unsupported reg-io-width (%d)\n",
> +						prop);
> +				ret = -EINVAL;
> +				break;
> +			}
> +		}
> +	}
> +
>  	if (ourport->drv_data->fifosize[index])
>  		ourport->port.fifosize = ourport->drv_data->fifosize[index];
>  	else if (ourport->info->fifosize)
> @@ -2587,6 +2627,18 @@ module_platform_driver(samsung_serial_driver);
>   * Early console.
>   */
>  
> +static void wr_reg_barrier(struct uart_port *port, u32 reg, u32 val)
> +{
> +	switch (port->iotype) {
> +	case UPIO_MEM:
> +		writeb(val, portaddr(port, reg));
> +		break;
> +	case UPIO_MEM32:
> +		writel(val, portaddr(port, reg));
> +		break;
> +	}
> +}
> +
>  struct samsung_early_console_data {
>  	u32 txfull_mask;
>  };
> @@ -2612,7 +2664,7 @@ static void samsung_early_putc(struct uart_port *port, int c)
>  	else
>  		samsung_early_busyuart(port);
>  
> -	writeb(c, port->membase + S3C2410_UTXH);
> +	wr_reg_barrier(port, S3C2410_UTXH, c);
>  }
>  
>  static void samsung_early_write(struct console *con, const char *s,
> 

