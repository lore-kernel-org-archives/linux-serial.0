Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6E54C433ED
	for <linux-serial@archiver.kernel.org>; Mon, 17 May 2021 08:23:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 896A3611CA
	for <linux-serial@archiver.kernel.org>; Mon, 17 May 2021 08:23:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235544AbhEQIYd (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 17 May 2021 04:24:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235504AbhEQIYZ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 17 May 2021 04:24:25 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3EEBC061573;
        Mon, 17 May 2021 01:23:07 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id k5so3247764pjj.1;
        Mon, 17 May 2021 01:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oNLBA3bZ2ZKUb5gVkU09s3zCreGR9NAVIwqZ5qbVNXI=;
        b=uuOKF0qRNn9MLlGgA5CRVYHL9tG7u21QPRafR2e+SZnXmW+0rzpd6k8pbLdjvdRun4
         OWEmxKCelYLALC38rYHpiTfgK66DG/QBuI0Zg9SRj70Gh6bt3CUkv9XwFAx1dldoK7Ob
         b1QiNyq+k2YdUQMLqxNcfDIztwKquJsFAdkP609fPXJ3q7M5fVZNBenl0L4NsH2WAkOa
         WHot8d77Wrxe6+NMnFE3L5Q255ohbAJf0Y7tnZB9iTivf/he+TfSlJ6ioRUkCrY9Gm7J
         o/y5dKXG1Q+zRb8B71SQldM/nye1w8eW+sL9e4V9C9YaRGA/31tP58M3hzQE6+p4Uenm
         y0sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oNLBA3bZ2ZKUb5gVkU09s3zCreGR9NAVIwqZ5qbVNXI=;
        b=ADKLTndYsmUQ15igqVjQvTgBv8AtLlmSfq7qtfN3LGN7lKkOKqTSU8Ukdb6M+PjXWs
         zEO6VKs/VDfqbyoYpeFdTtHM7Jemot4mcWH5jYUCKXIDCnLDni12z+LZ22XLLnADPg8H
         /xsj/pLPLYoAFXPj9IelH+7Hrv2k0LjSADIWyVhhW1VknK65ydHJPKanZoIEQYhsVVhA
         5baZDJKikoVkAs73Jtoimi1bShEksEjwB0N+2wUhpQMx++8SSETBRRes1bGMSaNqYrh1
         Z84L0lOPwLTxNpgOBfGyGsIDClcvBLcZnmTznM8W0U+H51Y0NuEMz5XqwyPvdEUoR8hk
         6/zQ==
X-Gm-Message-State: AOAM5318Vd96Bf2/YovOq+pXDkyXs6Qox7N9tA5kEgUbN7g6DCtGV6aj
        fkteQ6fZghugwrpSDGYGEto=
X-Google-Smtp-Source: ABdhPJwLf/DtYQLlJmqkJKNJODM9GQyIxQ4oqknEgl7Gi6ReFZdxGAEy/+fJdx9uun+8/sCxRpszlw==
X-Received: by 2002:a17:90a:4282:: with SMTP id p2mr54218621pjg.21.1621239787426;
        Mon, 17 May 2021 01:23:07 -0700 (PDT)
Received: from localhost (g1.222-224-229.ppp.wakwak.ne.jp. [222.224.229.1])
        by smtp.gmail.com with ESMTPSA id o7sm5548265pgs.45.2021.05.17.01.23.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 01:23:06 -0700 (PDT)
Date:   Mon, 17 May 2021 17:23:04 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Florent Kermarrec <florent@enjoy-digital.fr>,
        Mateusz Holenko <mholenko@antmicro.com>,
        Joel Stanley <joel@jms.id.au>,
        "Gabriel L . Somlo" <gsomlo@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
Message-ID: <YKIn6PHlGGsK+70W@antec>
References: <20210515084519.167343-1-shorne@gmail.com>
 <adb78be2-18a6-224d-1fa7-36b7912fa1cf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adb78be2-18a6-224d-1fa7-36b7912fa1cf@kernel.org>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, May 17, 2021 at 10:16:43AM +0200, Jiri Slaby wrote:
> On 15. 05. 21, 10:45, Stafford Horne wrote:
> > Most litex boards using RISC-V soft cores us the sbi earlycon, however
> > this is not available for non RISC-V litex SoC.  This patch enables
> > earlycon for liteuart which is available on all Litex SoC's making
> > support for earycon debugging more widely available.
> > 
> > Signed-off-by: Stafford Horne <shorne@gmail.com>
> > Cc: Florent Kermarrec <florent@enjoy-digital.fr>
> > Cc: Mateusz Holenko <mholenko@antmicro.com>
> > Cc: Joel Stanley <joel@jms.id.au>
> > Cc: Gabriel L. Somlo <gsomlo@gmail.com>
> > ---
> >   .../admin-guide/kernel-parameters.txt         |  5 +++
> >   drivers/tty/serial/Kconfig                    |  1 +
> >   drivers/tty/serial/liteuart.c                 | 31 +++++++++++++++++++
> >   3 files changed, 37 insertions(+)
> > 
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > index 04545725f187..2d4a43af8de2 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -1084,6 +1084,11 @@
> >   			the driver will use only 32-bit accessors to read/write
> >   			the device registers.
> > +		liteuart,<addr>
> > +			Start an early console on a litex serial port at the
> > +			specified address. The serial port must already be
> > +			setup and configured. Options are not yet supported.
> > +
> >   		meson,<addr>
> >   			Start an early, polled-mode console on a meson serial
> >   			port at the specified address. The serial port must
> > diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> > index 0c4cd4a348f4..9ceffe6ab6fd 100644
> > --- a/drivers/tty/serial/Kconfig
> > +++ b/drivers/tty/serial/Kconfig
> > @@ -1531,6 +1531,7 @@ config SERIAL_LITEUART
> >   	depends on OF || COMPILE_TEST
> >   	depends on LITEX
> >   	select SERIAL_CORE
> > +	select SERIAL_EARLYCON
> >   	help
> >   	  This driver is for the FPGA-based LiteUART serial controller from LiteX
> >   	  SoC builder.
> > diff --git a/drivers/tty/serial/liteuart.c b/drivers/tty/serial/liteuart.c
> > index 64842f3539e1..38c472487e68 100644
> > --- a/drivers/tty/serial/liteuart.c
> > +++ b/drivers/tty/serial/liteuart.c
> > @@ -372,6 +372,37 @@ static int __init liteuart_console_init(void)
> >   console_initcall(liteuart_console_init);
> >   #endif /* CONFIG_SERIAL_LITEUART_CONSOLE */
> > +#ifdef CONFIG_SERIAL_EARLYCON
> > +static void early_liteuart_putc(struct uart_port *port, int c)
> > +{
> > +	while (litex_read8(port->membase + OFF_TXFULL))
> > +		cpu_relax();
> > +
> > +	litex_write8(port->membase + OFF_RXTX, c);
> 
> Hi,
> 
> am I missing something or this doesn't differ to liteuart_putchar?

Hi, No you are right, I missed that thanks for catching it.

I should be able to remove this function and use putchar below.

-Stafford

> > +}
> > +
> > +static void early_liteuart_write(struct console *console, const char *s,
> > +				    unsigned int count)
> > +{
> > +	struct earlycon_device *device = console->data;
> > +	struct uart_port *port = &device->port;
> > +
> > +	uart_console_write(port, s, count, early_liteuart_putc);
> > +}
> > +
> > +static int __init early_liteuart_setup(struct earlycon_device *device,
> > +				       const char *options)
> > +{
> > +	if (!device->port.membase)
> > +		return -ENODEV;
> > +
> > +	device->con->write = early_liteuart_write;
> > +	return 0;
> > +}
> > +
> > +OF_EARLYCON_DECLARE(liteuart, "litex,liteuart", early_liteuart_setup);
> > +#endif /* CONFIG_SERIAL_EARLYCON */
> > +
> >   static int __init liteuart_init(void)
> >   {
> >   	int res;
> > 
> 
> 
> -- 
> js
> suse labs
