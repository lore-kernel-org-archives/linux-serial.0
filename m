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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70C12C43460
	for <linux-serial@archiver.kernel.org>; Sat, 15 May 2021 08:49:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BE71613FC
	for <linux-serial@archiver.kernel.org>; Sat, 15 May 2021 08:49:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbhEOIuf (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 15 May 2021 04:50:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbhEOIue (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 15 May 2021 04:50:34 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11B8EC06174A;
        Sat, 15 May 2021 01:49:19 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id h16so1463604pfk.0;
        Sat, 15 May 2021 01:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=d7JME7PsV+guxE+FlqoT+L1SZsDBd+kLRGnzG/zfbdY=;
        b=bjXZOZZkEqNhyjGLeIwwqgzRbB4ycr2YCBPKeLNvqlMYYeo7299W1bj9Kur7Pwvz8d
         4KRrfmjlzd/i3pyiLoypa/XHuzKeiwaoJwIgq3u3XB8fhVA9xKhTI8QZtXfEEH6uIScN
         fm3j6Ov/m6mseeOyQ2bnoF9C31+3RGAn6/mUz0I9Cl+ORYkkmnubFStqjiMR5lHR8Z6x
         a7/unbpq7m3N7RBxoABxAgYFQ1hjlqGEylP5eDWTSUZ5qrn9a4u2Yx+xE6se54cvFpso
         97NYkQY9G+sbzfBTCcXea5bwdmYE205d1XDu0eyDzsMldl7RgXtar7/aKkRvPOf4gF0q
         wljQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=d7JME7PsV+guxE+FlqoT+L1SZsDBd+kLRGnzG/zfbdY=;
        b=qDIDgsr/bNdGxTTbn9eMGur6vrXeKeKPA2Pf0Jw35EPKMt9ljtRqSrd4wxTnTQg8Ph
         2lNU4mqB05iqR+ucOnIpXD6lF7uYBh8M27xB9N/u+jngOWgboipx70TmQze5uPLvY8vM
         8xYAAILjehrAItLczVMRFg5CUGCtZuKvx2TzRdDpYIX3s1DJWefOF0sZ6MrrBYSrqMeX
         xH5EKbRH8p/rarOiZFyavg/dqNdzFJX5T0g5MaT2X3Hiow5W6QB/y14L2FZx/NfrxEKp
         d7bS/wkrIH0nianqKBGtZBBWzCYCdvz+uoP44iqZTjbYqBMPh2BgDVvUg/G9aYxkCAj5
         6KpQ==
X-Gm-Message-State: AOAM5339IPtQLFojsxIwMYoSk5WSrkWja8luQPBPav1WZODLOEcG8Kmh
        kB1Ncvd2kBng09GN8v3Nc8p1tRCXWcWWAg==
X-Google-Smtp-Source: ABdhPJwVtLEKFoOtRsiYR3H70dhU7NmUU9oqNAsaJtFyjkkRA/krJfBVqlnTqiKH4xK4R5fVjY/WFA==
X-Received: by 2002:a05:6a00:230b:b029:2ca:4c19:ea87 with SMTP id h11-20020a056a00230bb02902ca4c19ea87mr22209110pfh.43.1621068558201;
        Sat, 15 May 2021 01:49:18 -0700 (PDT)
Received: from localhost (g1.222-224-229.ppp.wakwak.ne.jp. [222.224.229.1])
        by smtp.gmail.com with ESMTPSA id g4sm5923708pgu.46.2021.05.15.01.49.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 May 2021 01:49:17 -0700 (PDT)
Date:   Sat, 15 May 2021 17:49:15 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Florent Kermarrec <florent@enjoy-digital.fr>,
        Mateusz Holenko <mholenko@antmicro.com>,
        Joel Stanley <joel@jms.id.au>,
        "Gabriel L . Somlo" <gsomlo@gmail.com>,
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
Message-ID: <YJ+LCygukQsQNIuj@antec>
References: <20210515084519.167343-1-shorne@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210515084519.167343-1-shorne@gmail.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

I pulled the trigger a bit early, the subject needs a bit better/consistent
formatting.  It should be:

  serial: liteuart: Add support for earlycon

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
> 
