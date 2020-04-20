Return-Path: <SRS0=2nXW=6E=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FORGED_MUA_MOZILLA,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8157C3815B
	for <linux-serial@archiver.kernel.org>; Mon, 20 Apr 2020 14:19:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92DB020857
	for <linux-serial@archiver.kernel.org>; Mon, 20 Apr 2020 14:19:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t2CozfZA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728920AbgDTOTu (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 20 Apr 2020 10:19:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727890AbgDTOTt (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 20 Apr 2020 10:19:49 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDA72C061A0C;
        Mon, 20 Apr 2020 07:19:49 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id x26so5106284pgc.10;
        Mon, 20 Apr 2020 07:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:to:references:from:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=7B/LXMOm0voTdgUI+ifynbQOYjuUKN27/q+UqAFqkRc=;
        b=t2CozfZAPyz/NaYojLBmjI5RNpQfJfzQZC5gzRW4IivEIt3sPU9V8o/DMe7AeAMfOn
         zGjWvGF739M6yCv7E0bKpq323LKV3WuZ6KAL8GAdTPmD4z6ZIOfOXmdkUWYHxa24KGsd
         EfQurt9weJ3HbiqHEG+stMxZp2YNG71VNETnakc+mK3JJ9RTYxkQivogktXvNpFIzARE
         gGkLVhGvCeaUGEnjT6r0/Fbgofgc2LpMTRTVrkYOZkk539hOEAdYIVCu2QRN73vnwDqX
         B5aotR/Y+cO29c9kU5FTc9wotWEVbihrTbfp6u91UmxqiQrC3dxoTkE4Dh0cJNivRfVb
         ooDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:to:references:from:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=7B/LXMOm0voTdgUI+ifynbQOYjuUKN27/q+UqAFqkRc=;
        b=B9/wBQmmyD950XNsEBfuoR0rzc6O7TEoKEgxTMCcpS3MUTgl96CBIdVWTEweu8OXlR
         kA/gHoobwK/k8hscgSjr8QSBp+iIL2DfKeIc2lSIH1wslgeRlCuyqnShuod+5EGrK2OO
         OrJUzgQueDNYCtyKkqkZ1R30AFgMsX2WWa/NejUdd6+Aznjc8dgQtCS9tk+iN45yn9EV
         r9J/Z6Fxna0PjV4OrDTLGmL1ypQ9IRR7cUpiyXqwCQWNGxzqnIaxzimAnabQVZ4kkIGT
         7Us3OxAgT42OwO3jDTMzNcSWNuBpYcKU3V/eBWryNHtmDF/M4fGTEzwpWKVJbp8Aszan
         iDcw==
X-Gm-Message-State: AGi0Puaw7F+1rSU2CZDniKv04vrsohEX8GiqDeP6u3Kn0I6a1KCAtpLL
        J3Ezc63d2fl85VklczBp86dluEmG
X-Google-Smtp-Source: APiQypKh9UX1CHQfTUvGuMYFpFinbgf83oyAr/Qc6skJXohPd+tQh798UPm0MPbRGreVNpQ1c3xYvg==
X-Received: by 2002:a63:2a08:: with SMTP id q8mr1742352pgq.442.1587392389212;
        Mon, 20 Apr 2020 07:19:49 -0700 (PDT)
Received: from [192.168.0.4] ([211.243.117.64])
        by smtp.gmail.com with ESMTPSA id o63sm1378702pjb.40.2020.04.20.07.19.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Apr 2020 07:19:48 -0700 (PDT)
Message-ID: <5e9daf84.1c69fb81.7404a.34ba@mx.google.com>
Subject: Re: [PATCH v8 3/3] tty: samsung_tty: 32-bit access for TX/RX hold
 registers
To:     Hyunki Koo <hyunki00.koo@samsung.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200420013300.17249-1-hyunki00.koo@samsung.com>
 <CGME20200420013332epcas2p381793b8c09d71269d3e8c38a196a1c74@epcas2p3.samsung.com>
 <20200420013300.17249-3-hyunki00.koo@samsung.com>
From:   Hyunki Koo <hyunki00.koo@gmail.com>
Date:   Mon, 20 Apr 2020 23:19:44 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200420013300.17249-3-hyunki00.koo@samsung.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

sorry, cover-letter [PATCH v8 0/3] does not sent, I will send cover 
letter tomorrow

all information of version control is included in cover letter.

On 20. 4. 20. 오전 10:32, Hyunki Koo wrote:
> Support 32-bit access for the TX/RX hold registers UTXH and URXH.
>
> This is required for some newer SoCs.
>
> Signed-off-by: Hyunki Koo <hyunki00.koo@samsung.com>
> ---
>   drivers/tty/serial/samsung_tty.c | 62 ++++++++++++++++++++++++++++++++++++----
>   1 file changed, 57 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
> index 326b0164609c..bdf1d4d12cb1 100644
> --- a/drivers/tty/serial/samsung_tty.c
> +++ b/drivers/tty/serial/samsung_tty.c
> @@ -154,12 +154,47 @@ struct s3c24xx_uart_port {
>   #define portaddrl(port, reg) \
>   	((unsigned long *)(unsigned long)((port)->membase + (reg)))
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
>   #define rd_regl(port, reg) (readl_relaxed(portaddr(port, reg)))
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
>   #define wr_regl(port, reg, val) writel_relaxed(val, portaddr(port, reg))
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
>   /* Byte-order aware bit setting/clearing functions. */
>   
>   static inline void s3c24xx_set_bit(struct uart_port *port, int idx,
> @@ -1974,7 +2009,7 @@ static int s3c24xx_serial_probe(struct platform_device *pdev)
>   	struct device_node *np = pdev->dev.of_node;
>   	struct s3c24xx_uart_port *ourport;
>   	int index = probe_index;
> -	int ret;
> +	int ret, prop = 0;
>   
>   	if (np) {
>   		ret = of_alias_get_id(np, "serial");
> @@ -2000,10 +2035,27 @@ static int s3c24xx_serial_probe(struct platform_device *pdev)
>   			dev_get_platdata(&pdev->dev) :
>   			ourport->drv_data->def_cfg;
>   
> -	if (np)
> +	if (np) {
>   		of_property_read_u32(np,
>   			"samsung,uart-fifosize", &ourport->port.fifosize);
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
>   	if (ourport->drv_data->fifosize[index])
>   		ourport->port.fifosize = ourport->drv_data->fifosize[index];
>   	else if (ourport->info->fifosize)
> @@ -2612,7 +2664,7 @@ static void samsung_early_putc(struct uart_port *port, int c)
>   	else
>   		samsung_early_busyuart(port);
>   
> -	writeb(c, port->membase + S3C2410_UTXH);
> +	wr_reg_barrier(port, S3C2410_UTXH, c);
>   }
>   
>   static void samsung_early_write(struct console *con, const char *s,
