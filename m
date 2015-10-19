From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: [PATCH] tty/serial: make early console depend on SERIAL_CORE=y
Date: Mon, 19 Oct 2015 15:11:13 -0400
Message-ID: <20151019191112.GD26878@windriver.com>
References: <1445206009-12275-1-git-send-email-paul.gortmaker@windriver.com>
 <4727600.4io7e2HWRP@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4727600.4io7e2HWRP@wuerfel>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

[Re: [PATCH] tty/serial: make early console depend on SERIAL_CORE=y] On 19/10/2015 (Mon 14:56) Arnd Bergmann wrote:

> On Sunday 18 October 2015 18:06:48 Paul Gortmaker wrote:
> > On an powerpc allmodconfig build, the following is seen:
> > 
> > paul@builder:~/git/linux-head$ make O=../ppc-build -j30 > /dev/null
> > drivers/built-in.o: In function `.setup_earlycon':
> > (.init.text+0x5b00): undefined reference to `.uart_parse_earlycon'
> > make[1]: *** [vmlinux] Error 1
> > 
> > Since uart_parse_earlycon lives in serial_core.c we need to ensure
> > it is built in if early console is to be used.
> 
> I saw the same thing and came up with a different fix
> 
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: Peter Hurley <peter@hurleysoftware.com>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: Jiri Slaby <jslaby@suse.com>
> > Cc: linux-serial@vger.kernel.org
> > Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> > ---
> > 
> > [A google shows this cropped up in April of this year; I guess it wasn't
> >  completely fixed?
> >  http://lists.infradead.org/pipermail/linux-arm-kernel/2015-April/336954.html
> >  FWIW, I was testing on tty/tty-testing pulled today, from Greg  ]
> 
> The new problem was clearly caused by 1d59b382f1c4 ("serial: fsl_lpuart:
> add earlycon support"), which selects SERIAL_EARLYCON but not
> SERIAL_CORE_CONSOLE.
> 
> However, the way I read Peter's patch from the URL you provided,
> it seems that it is supposed to work without my patch, so I'm not
> sure.
> 
> 	Arnd
> 
> From 8b8704525b47ba3287de2d7ff89a53e3e335f9d8 Mon Sep 17 00:00:00 2001
> From: Arnd Bergmann <arnd@arndb.de>
> Date: Mon, 19 Oct 2015 13:02:08 +0200
> Subject: [PATCH] serial: fsl-lpuart: select SERIAL_CORE_CONSOLE
> 
> drivers/built-in.o: In function `setup_earlycon':
> :(.init.text+0x2c4c): undefined reference to `uart_parse_earlycon'
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> index 1aec4404062d..f1a4f9eccc44 100644
> --- a/drivers/tty/serial/Kconfig
> +++ b/drivers/tty/serial/Kconfig
> @@ -1540,6 +1540,7 @@ config SERIAL_FSL_LPUART
>  	depends on HAS_DMA
>  	select SERIAL_CORE
>  	select SERIAL_EARLYCON
> +	select SERIAL_CORE_CONSOLE

So the next uart that is not FSL that selects EARLYCON will fail in the
same way.  Isn't it better to have EARLYCON select it or depend on it;
i.e. go to the root of the problem?

Paul.
--

>  	help
>  	  Support for the on-chip lpuart on some Freescale SOCs.
>  
> 
