Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 467F1C433B4
	for <linux-serial@archiver.kernel.org>; Mon, 17 May 2021 08:53:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2389660249
	for <linux-serial@archiver.kernel.org>; Mon, 17 May 2021 08:53:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235737AbhEQIyo (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 17 May 2021 04:54:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235731AbhEQIyn (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 17 May 2021 04:54:43 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F798C061573;
        Mon, 17 May 2021 01:53:26 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id m190so4193084pga.2;
        Mon, 17 May 2021 01:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nJVJSykwKfy3n47FOydKmpx61QhCYnnGnyws86EkojY=;
        b=Pp0JhHNFdCdWiXk8ejDs2Cnk2Bfb+hGWEiTqMM+RlKNRzRwS3Cdnhdp9f8mOHJ74co
         SJyUCBVElX+y5M8qvmkcpvMLEVWM2lBH7KbCOpv9MB3BBScvptqYTMW4WP8DaTYOP7VP
         IHvlTfckZd83ecQoMi67xIQSzgZ1tJsT6yyd1r0gwadndNJy7Z6MRidGd/8TL+Ez7Ao8
         hdH74JM05BrkehF97QUtaSqmvPip1ugkRw2JfNj53Y/I3obln/LHoaQn3rgW5IizFXly
         zHw8/0YmQvPMJVmBzZw2MltzsMFxmbYwaVei1XegJ9fc52z2jPS9tuO0/EKTU/FZVjUG
         XonQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nJVJSykwKfy3n47FOydKmpx61QhCYnnGnyws86EkojY=;
        b=Z23QPd8pXao511NKmapEORAkfhWHI+oe6yM4Oe6ylVVO+/3OjSg623T2tBTZfHc7/Y
         mbA0WCLRG6F5663DZGY+OP0SWYSJ0Yu5EbhtxIaJozVh9UwMaKwvTMRDmBgKyVRV9l7E
         uanRw6LCEEZf/wxcnn6Siqs+BC30mblMVpzPamhXTVGkAbJr67hNEj5+LXbatMx943fT
         zUBJHvPW8h8XInmajSuoA9HxS75E6HBQ52Cq49PeK5gwhHx2N853OgxKzLwEw8+BzY+i
         jNIupaQwbuvGSQ+gNOg1C88xZqsB5X2P3+E8ccFPQWkaTrMKQV1VhKi7rc30k1i7i+QO
         LJ9A==
X-Gm-Message-State: AOAM531wEmmqYwa024GbVKQZjpp1K+NSmwPGHG45J/wSzaZxriZCIAFL
        nUSc+KJjZxCgXTYF23s1Dm4=
X-Google-Smtp-Source: ABdhPJzz6Xm+OOVvSIHMjdKAIS5jJ0thRb5snIak00jxc+LcKn3DFO4U2qOY8pzfVzHbvNYQ+3MbpA==
X-Received: by 2002:a05:6a00:706:b029:217:9e8d:f9cc with SMTP id 6-20020a056a000706b02902179e8df9ccmr59333025pfl.1.1621241605810;
        Mon, 17 May 2021 01:53:25 -0700 (PDT)
Received: from localhost (g1.222-224-229.ppp.wakwak.ne.jp. [222.224.229.1])
        by smtp.gmail.com with ESMTPSA id v18sm9859441pff.90.2021.05.17.01.53.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 01:53:25 -0700 (PDT)
Date:   Mon, 17 May 2021 17:53:23 +0900
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
Message-ID: <YKIvA+fgbgaoB5sc@antec>
References: <20210515084519.167343-1-shorne@gmail.com>
 <adb78be2-18a6-224d-1fa7-36b7912fa1cf@kernel.org>
 <YKIn6PHlGGsK+70W@antec>
 <d17a43ab-facf-8ffb-5147-7492fb85b0b5@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d17a43ab-facf-8ffb-5147-7492fb85b0b5@kernel.org>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, May 17, 2021 at 10:25:46AM +0200, Jiri Slaby wrote:
> On 17. 05. 21, 10:23, Stafford Horne wrote:
> > On Mon, May 17, 2021 at 10:16:43AM +0200, Jiri Slaby wrote:
> > > On 15. 05. 21, 10:45, Stafford Horne wrote:
> > > > Most litex boards using RISC-V soft cores us the sbi earlycon, however
> > > > this is not available for non RISC-V litex SoC.  This patch enables
> > > > earlycon for liteuart which is available on all Litex SoC's making
> > > > support for earycon debugging more widely available.
> > > > 
> > > > Signed-off-by: Stafford Horne <shorne@gmail.com>
> > > > Cc: Florent Kermarrec <florent@enjoy-digital.fr>
> > > > Cc: Mateusz Holenko <mholenko@antmicro.com>
> > > > Cc: Joel Stanley <joel@jms.id.au>
> > > > Cc: Gabriel L. Somlo <gsomlo@gmail.com>
> > > > ---
> > > >    .../admin-guide/kernel-parameters.txt         |  5 +++
> > > >    drivers/tty/serial/Kconfig                    |  1 +
> > > >    drivers/tty/serial/liteuart.c                 | 31 +++++++++++++++++++
> > > >    3 files changed, 37 insertions(+)
> > > > 
> > > > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > > > index 04545725f187..2d4a43af8de2 100644
> > > > --- a/Documentation/admin-guide/kernel-parameters.txt
> > > > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > > > @@ -1084,6 +1084,11 @@
> > > >    			the driver will use only 32-bit accessors to read/write
> > > >    			the device registers.
> > > > +		liteuart,<addr>
> > > > +			Start an early console on a litex serial port at the
> > > > +			specified address. The serial port must already be
> > > > +			setup and configured. Options are not yet supported.
> > > > +
> > > >    		meson,<addr>
> > > >    			Start an early, polled-mode console on a meson serial
> > > >    			port at the specified address. The serial port must
> > > > diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> > > > index 0c4cd4a348f4..9ceffe6ab6fd 100644
> > > > --- a/drivers/tty/serial/Kconfig
> > > > +++ b/drivers/tty/serial/Kconfig
> > > > @@ -1531,6 +1531,7 @@ config SERIAL_LITEUART
> > > >    	depends on OF || COMPILE_TEST
> > > >    	depends on LITEX
> > > >    	select SERIAL_CORE
> > > > +	select SERIAL_EARLYCON
> > > >    	help
> > > >    	  This driver is for the FPGA-based LiteUART serial controller from LiteX
> > > >    	  SoC builder.
> > > > diff --git a/drivers/tty/serial/liteuart.c b/drivers/tty/serial/liteuart.c
> > > > index 64842f3539e1..38c472487e68 100644
> > > > --- a/drivers/tty/serial/liteuart.c
> > > > +++ b/drivers/tty/serial/liteuart.c
> > > > @@ -372,6 +372,37 @@ static int __init liteuart_console_init(void)
> > > >    console_initcall(liteuart_console_init);
> > > >    #endif /* CONFIG_SERIAL_LITEUART_CONSOLE */
> > > > +#ifdef CONFIG_SERIAL_EARLYCON
> > > > +static void early_liteuart_putc(struct uart_port *port, int c)
> > > > +{
> > > > +	while (litex_read8(port->membase + OFF_TXFULL))
> > > > +		cpu_relax();
> > > > +
> > > > +	litex_write8(port->membase + OFF_RXTX, c);
> > > 
> > > Hi,
> > > 
> > > am I missing something or this doesn't differ to liteuart_putchar?
> > 
> > Hi, No you are right, I missed that thanks for catching it.
> > 
> > I should be able to remove this function and use putchar below.
> 
> OK.
> 
> I've just noticed you add an ifdef CONFIG_SERIAL_EARLYCON here, but you
> select SERIAL_EARLYCON in Kconfig above. So the ifdef is sort of pointless?
> (Or you shouldn't select SERIAL_EARLYCON.)

Ah yes, this I thought might have been wrong when I wrote it.  I think my
problem here is I was just copying how some other patches implemented earlycon.

 omap-serial - has ifdefs, doesn't select SERIAL_EARLYCON - looks ok
 sifive - has ifdefs + select SERIAL_EARLYCON - maybe needs cleanup too

-Stafford
