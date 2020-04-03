Return-Path: <SRS0=+zim=5T=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2020BC2D0E8
	for <linux-serial@archiver.kernel.org>; Fri,  3 Apr 2020 10:47:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB3F52082F
	for <linux-serial@archiver.kernel.org>; Fri,  3 Apr 2020 10:47:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585910870;
	bh=n19yFo16QOMqFA1WDmUG5gmfUOke7qvod9qEnZ2OpK4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=otjv6NWQepDLGrXwIm65YtZVZQTUizS19S23vYWbbEt+GX8FwP6ybTjMZtLihkeUF
	 SDA+h6a1qoyNlP9OSEPohytFZy8p//oJtzaPsZ0xRhmrckh1cfTiaslK2DEyY0CxSg
	 KXjqQGCDDeXAA4gtQQoARpss5tOYyfY7xvZQ6SI4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727944AbgDCKrt (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 3 Apr 2020 06:47:49 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:34238 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727792AbgDCKrt (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 3 Apr 2020 06:47:49 -0400
Received: by mail-ed1-f66.google.com with SMTP id o1so8772487edv.1;
        Fri, 03 Apr 2020 03:47:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/qsV5G+EWb+7XocHOBXyq0rD3eTdN0wEIFWjn6eqrw0=;
        b=JOgZwphpxw5aJuGrV1e6NB8dnmsvnCZHsP0MfXj/8xPMZGAJAlnl/kheQHA8vxQenG
         Fq+3K1dt7sYaIj3npRKD+xkDo50whWWgx8CZUgEkb7ZQNL8pZ/tlYSxrbYBxljOEJtC6
         0YkFtBHcdExjM5iu/1bIvxIGk1/JjLaExKy002Sii9KIAqukh7AGc7FcS0KKjuzQ6UDE
         yhCttF9Iwp0a7gSri5z26d5tdNkW+g/yKYJs2fygHpqmE8jBy0PhoH4GBH50+Ofb3EJ/
         2H3JaAApDU2mCxDG3RSq3GsaAbWaPA+Xw0ik78lKwomUaH+0LGdQPa2ZxA/Xn2X4wQSA
         qhAQ==
X-Gm-Message-State: AGi0PuYVCj7Ob0HBNsf/NTZ4yhnOdqTypsCueR/jHaZwoyF1KrMeBPW/
        4YxdEBldMgkI7nmQE4HdsTU=
X-Google-Smtp-Source: APiQypL5vPUUwU2gK8AJePkOzrdpT7tRJ1mK4h7pF9JSf1Aki52IK/rhR4C/SGne9w6Yo0UNm1UZHA==
X-Received: by 2002:a17:906:cc2:: with SMTP id l2mr7897646ejh.115.1585910866860;
        Fri, 03 Apr 2020 03:47:46 -0700 (PDT)
Received: from kozik-lap ([194.230.155.125])
        by smtp.googlemail.com with ESMTPSA id gs12sm1565340ejb.86.2020.04.03.03.47.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 03 Apr 2020 03:47:46 -0700 (PDT)
Date:   Fri, 3 Apr 2020 12:47:44 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Hyunki Koo <hyunki00.koo@samsung.com>
Cc:     gregkh@linuxfoundation.org, Kukjin Kim <kgene@kernel.org>,
        Jiri Slaby <jslaby@suse.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] tty: samsung_tty: 32-bit access for TX/RX hold
 registers
Message-ID: <20200403104744.GA29385@kozik-lap>
References: <20200401082721.19431-1-hyunki00.koo@samsung.com>
 <CGME20200403102049epcas2p1d1fe95160b7f37609a8b1710c196cdd8@epcas2p1.samsung.com>
 <20200403102041.22015-1-hyunki00.koo@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200403102041.22015-1-hyunki00.koo@samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Apr 03, 2020 at 07:20:41PM +0900, Hyunki Koo wrote:
> Support 32-bit access for the TX/RX hold registers UTXH and URXH.
> 
> This is required for some newer SoCs.
> 
> Signed-off-by: Hyunki Koo <hyunki00.koo@samsung.com>
> ---
> v3: change rd_regl to rd_reg in line 954 for backward compatibility.

I cannot find this change against v2.

> ---
> 
>  drivers/tty/serial/samsung_tty.c | 76 +++++++++++++++++++++++++++++++++-------
>  1 file changed, 64 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
> index 73f951d65b93..a674a80163ed 100644
> --- a/drivers/tty/serial/samsung_tty.c
> +++ b/drivers/tty/serial/samsung_tty.c
> @@ -154,12 +154,47 @@ struct s3c24xx_uart_port {
>  #define portaddrl(port, reg) \
>  	((unsigned long *)(unsigned long)((port)->membase + (reg)))
>  
> -#define rd_regb(port, reg) (readb_relaxed(portaddr(port, reg)))
> +static unsigned int rd_reg(struct uart_port *port, int reg)

You should return here u32 to be consistent with readl_relaxed.

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
> -#define wr_regb(port, reg, val) writeb_relaxed(val, portaddr(port, reg))
> +static void wr_reg(struct uart_port *port, int reg, int val)

val should be u32.

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
> +static void write_buf(struct uart_port *port, int reg, int val)

buf is misleading, you do not write here any buffer. Maybe
"wr_reg_barrier()" or "wr_reg_order()"?

Best regards,
Krzysztof

