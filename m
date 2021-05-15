Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B93E7C433ED
	for <linux-serial@archiver.kernel.org>; Sat, 15 May 2021 12:17:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F6F2613CD
	for <linux-serial@archiver.kernel.org>; Sat, 15 May 2021 12:17:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231591AbhEOMSj (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 15 May 2021 08:18:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230144AbhEOMSj (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 15 May 2021 08:18:39 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A793CC061573;
        Sat, 15 May 2021 05:17:25 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id 1so1613288qtb.0;
        Sat, 15 May 2021 05:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DPoGlMS/oCbgWHNPbUx7scOgPtN4DdBoyWnSloUqTQw=;
        b=Vo8sGSPnG2sneOjS72HFiXr0WgvO+KnNFs8J1kFYeCimMYwaIg9sP4LSLRBogdeEBJ
         /2bfN7emebEMroR3MGjZl+5okEEnASuaMmWbo25dYwprM3BfddVBEPbP0B0LHaoutj/i
         xsp6Ap8A1mwB+5FXzav5/5IAcRsq4WosFmZ79DJyrcjayO2a5Eg2BC8CHxD4rcR/Qxpm
         m9cDPDxYjKxN2wBT0rAiIPOnYmYMPAOqqeMfbq1WLqY5wBIoWKMaN8711LcOqo8CZ+Ju
         0y+yrQwrRwB+C+j7BNJd4EZnVsHhbypMPdzNkBea2944IddEhue3BgeohHzMBFbXmA4v
         k12g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DPoGlMS/oCbgWHNPbUx7scOgPtN4DdBoyWnSloUqTQw=;
        b=JJQB/F93DS3vHsaLH4nPOPfCkVP5lGpPHFxeM5EIwsAI/Kdu/pUe+zqkpAoO2voB4O
         0igEA8PJBCdgoOdFQwE32qOJBBr141PvPr1hwSHhEFn2h95GS24pl46sFa1y7tr97APR
         amLVA1oZNVfqJT8AStfpR11Bb4E2S02fKWASAWyU73KZivA+RO5wbyd16D3UoLXb845+
         HyxDWg9O3Rs/rftAvxgS3Nxyxz35jmAsy6jvK1K8huoS5UA+iuCJ4vvUnZKTq12C0DKH
         VCqxSdHccFkWTe88vPRlDQ28MqMDQ4qeOQgxyRYRLmv5I49RXAxa9o+fthnvxpWe8wrG
         rhTQ==
X-Gm-Message-State: AOAM531IzYAIomW/sGTY00KhdJLoOEstoNpoHC5yrvZa+lBT3aIqd1L/
        3xE+mERJlbb5fm/7PmeEoTU=
X-Google-Smtp-Source: ABdhPJwCy7Hg0PI8WYcO8+4B7gcsS26JbgGagbutHc/rU9q5/hKRp9x0eGrzmlAbISIBe3ODazf2rg==
X-Received: by 2002:ac8:5d16:: with SMTP id f22mr24989947qtx.84.1621081044752;
        Sat, 15 May 2021 05:17:24 -0700 (PDT)
Received: from errol.ini.cmu.edu (pool-108-39-255-32.pitbpa.fios.verizon.net. [108.39.255.32])
        by smtp.gmail.com with ESMTPSA id d16sm6570349qtw.23.2021.05.15.05.17.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 May 2021 05:17:24 -0700 (PDT)
Date:   Sat, 15 May 2021 08:17:17 -0400
From:   "Gabriel L. Somlo" <gsomlo@gmail.com>
To:     Stafford Horne <shorne@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Florent Kermarrec <florent@enjoy-digital.fr>,
        Mateusz Holenko <mholenko@antmicro.com>,
        Joel Stanley <joel@jms.id.au>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Karol Gugala <kgugala@antmicro.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-doc@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH] serial/liteuart; Add support for earlycon
Message-ID: <YJ+7zTmMOxlCbaRf@errol.ini.cmu.edu>
References: <20210515084519.167343-1-shorne@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210515084519.167343-1-shorne@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Sat, May 15, 2021 at 05:45:18PM +0900, Stafford Horne wrote:
> Most litex boards using RISC-V soft cores us the sbi earlycon, however
> this is not available for non RISC-V litex SoC.  This patch enables
> earlycon for liteuart which is available on all Litex SoC's making
> support for earycon debugging more widely available.
> 
> Signed-off-by: Stafford Horne <shorne@gmail.com>
> Cc: Florent Kermarrec <florent@enjoy-digital.fr>
> Cc: Mateusz Holenko <mholenko@antmicro.com>
> Cc: Joel Stanley <joel@jms.id.au>
> Cc: Gabriel L. Somlo <gsomlo@gmail.com>
> ---
>  .../admin-guide/kernel-parameters.txt         |  5 +++
>  drivers/tty/serial/Kconfig                    |  1 +
>  drivers/tty/serial/liteuart.c                 | 31 +++++++++++++++++++
>  3 files changed, 37 insertions(+)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 04545725f187..2d4a43af8de2 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -1084,6 +1084,11 @@
>  			the driver will use only 32-bit accessors to read/write
>  			the device registers.
>  
> +		liteuart,<addr>
> +			Start an early console on a litex serial port at the
> +			specified address. The serial port must already be
> +			setup and configured. Options are not yet supported.
> +
>  		meson,<addr>
>  			Start an early, polled-mode console on a meson serial
>  			port at the specified address. The serial port must
> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> index 0c4cd4a348f4..9ceffe6ab6fd 100644
> --- a/drivers/tty/serial/Kconfig
> +++ b/drivers/tty/serial/Kconfig
> @@ -1531,6 +1531,7 @@ config SERIAL_LITEUART
>  	depends on OF || COMPILE_TEST
>  	depends on LITEX
>  	select SERIAL_CORE
> +	select SERIAL_EARLYCON
>  	help
>  	  This driver is for the FPGA-based LiteUART serial controller from LiteX
>  	  SoC builder.
> diff --git a/drivers/tty/serial/liteuart.c b/drivers/tty/serial/liteuart.c
> index 64842f3539e1..38c472487e68 100644
> --- a/drivers/tty/serial/liteuart.c
> +++ b/drivers/tty/serial/liteuart.c
> @@ -372,6 +372,37 @@ static int __init liteuart_console_init(void)
>  console_initcall(liteuart_console_init);
>  #endif /* CONFIG_SERIAL_LITEUART_CONSOLE */
>  
> +#ifdef CONFIG_SERIAL_EARLYCON
> +static void early_liteuart_putc(struct uart_port *port, int c)
> +{
> +	while (litex_read8(port->membase + OFF_TXFULL))
> +		cpu_relax();
> +
> +	litex_write8(port->membase + OFF_RXTX, c);
> +}
> +
> +static void early_liteuart_write(struct console *console, const char *s,
> +				    unsigned int count)
> +{
> +	struct earlycon_device *device = console->data;
> +	struct uart_port *port = &device->port;
> +
> +	uart_console_write(port, s, count, early_liteuart_putc);
> +}
> +
> +static int __init early_liteuart_setup(struct earlycon_device *device,
> +				       const char *options)
> +{
> +	if (!device->port.membase)
> +		return -ENODEV;
> +
> +	device->con->write = early_liteuart_write;
> +	return 0;
> +}
> +
> +OF_EARLYCON_DECLARE(liteuart, "litex,liteuart", early_liteuart_setup);
> +#endif /* CONFIG_SERIAL_EARLYCON */
> +
>  static int __init liteuart_init(void)
>  {
>  	int res;
> -- 
> 2.31.1
 
FWIW:
Reviewed-and-tested-by: Gabriel Somlo <gsomlo@gmail.com>

Thanks,
--Gabriel
