Return-Path: <SRS0=r4Ma=EM=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5E43C55178
	for <linux-serial@archiver.kernel.org>; Fri,  6 Nov 2020 11:12:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EB1520825
	for <linux-serial@archiver.kernel.org>; Fri,  6 Nov 2020 11:12:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ds/Oe2Ia"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727057AbgKFLM4 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 6 Nov 2020 06:12:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726565AbgKFLM4 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 6 Nov 2020 06:12:56 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC727C0613D2
        for <linux-serial@vger.kernel.org>; Fri,  6 Nov 2020 03:12:55 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id a65so966294wme.1
        for <linux-serial@vger.kernel.org>; Fri, 06 Nov 2020 03:12:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=s7hWJyyabv7sI/xODuTMucUe3yrgTF3pC69+ROC/S8Y=;
        b=ds/Oe2IaV1IEO2VJo8FZOySGoTnyAnhf/4uDafYyRECwYi2juu1ib8lOfP2DJ27X4p
         aaVT4mkH4XPGC0X84gMYHL00Z+f3KIx1rrTQqUG3S7ptDhGXch3+v4yBbY3etIeYyQGE
         I8tE8DreW9P0HDBG8u/7s8KcyjbMyOCuknXc03aih62df6/YMo6GS4OwU6M4wl5HM0VE
         WUnDrjAA2UvXTMp8lnqoQHdMJt4AfkWSX5DI4PpK172HZ9AiWSLPZP+vpUgtzdvv9P2m
         UbjuPNkM7RMJU+rVRW6Km66SSJzfijw6r1khzA7kBfF42GDAUsMhm8REURreWoC8ENWj
         DXrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=s7hWJyyabv7sI/xODuTMucUe3yrgTF3pC69+ROC/S8Y=;
        b=neWdqOzMK0QHgQscto8hn+p8r3tZDxHfXFxHCWduuUACPyKeclcMe1k+yGHMqrU8aI
         Omr0ZMQBg5Zaia7/B0iNeL18uK+WmFCEtLkk7d8PN7uPPl/oPgp0aeNXqtn91sNy7SE3
         yKkXBu7YI1oe5CG/76MSlOUG1zjFVWJCtsQZOTBbY3gQDPLWck18IdGD97rbdfVlXS1R
         Qom0JgZm2IRiVcY94uoSYoK1sYfx4OsW5n2er8l2K2VmDmWoI3OSs9GXKYHmdvYtHikQ
         tiDcSQ2fASGnxZnx6qZBv+h1GjoL9jqfhXCEX+TaODBeQDh7CBpSmpaQZm1YwSsJJMYb
         V9rA==
X-Gm-Message-State: AOAM533mXMFeVk7rfjBbipLSkHkc9zxKaWqeDQGZIbYSvJOyyTdSiaKF
        hQ/22VqViV4bpNyfYyHyh5kZ6Q==
X-Google-Smtp-Source: ABdhPJya+4M9jpMB4EHwvPz4HdjvNjJ554A5ToFy4rwZSt6uEwsBJhNNh9D7BRQXO+kQFqwEXt9DSQ==
X-Received: by 2002:a7b:c145:: with SMTP id z5mr1815645wmi.164.1604661174401;
        Fri, 06 Nov 2020 03:12:54 -0800 (PST)
Received: from dell ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id d2sm1611881wrq.34.2020.11.06.03.12.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 03:12:53 -0800 (PST)
Date:   Fri, 6 Nov 2020 11:12:51 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>,
        Mike Hudson <Exoray@isys.ca>, linux-serial@vger.kernel.org
Subject: Re: [PATCH 13/36] tty: serial: 8250: 8250_port: Staticify functions
 referenced by pointers
Message-ID: <20201106111251.GF2063125@dell>
References: <20201104193549.4026187-1-lee.jones@linaro.org>
 <20201104193549.4026187-14-lee.jones@linaro.org>
 <20201106095326.GA2652562@kroah.com>
 <20201106100552.GA2063125@dell>
 <20201106101646.GB2063125@dell>
 <20201106103955.GA2784089@kroah.com>
 <20201106104810.GE2063125@dell>
 <20201106105552.GA2810950@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201106105552.GA2810950@kroah.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, 06 Nov 2020, Greg Kroah-Hartman wrote:

> On Fri, Nov 06, 2020 at 10:48:10AM +0000, Lee Jones wrote:
> > On Fri, 06 Nov 2020, Greg Kroah-Hartman wrote:
> > 
> > > On Fri, Nov 06, 2020 at 10:16:46AM +0000, Lee Jones wrote:
> > > > On Fri, 06 Nov 2020, Lee Jones wrote:
> > > > 
> > > > > On Fri, 06 Nov 2020, Greg Kroah-Hartman wrote:
> > > > > 
> > > > > > On Wed, Nov 04, 2020 at 07:35:26PM +0000, Lee Jones wrote:
> > > > > > > Fixes the following W=1 kernel build warning(s):
> > > > > > > 
> > > > > > >  drivers/tty/serial/8250/8250_port.c:349:14: warning: no previous prototype for ‘au_serial_in’ [-Wmissing-prototypes]
> > > > > > >  drivers/tty/serial/8250/8250_port.c:359:6: warning: no previous prototype for ‘au_serial_out’ [-Wmissing-prototypes]
> > > > > > > 
> > > > > > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > > > > Cc: Jiri Slaby <jirislaby@kernel.org>
> > > > > > > Cc: Mike Hudson <Exoray@isys.ca>
> > > > > > > Cc: linux-serial@vger.kernel.org
> > > > > > > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > > > > > > ---
> > > > > > >  drivers/tty/serial/8250/8250_port.c | 4 ++--
> > > > > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > > > > 
> > > > > > And now I get build errors of:
> > > > > > 	ld: drivers/tty/serial/8250/8250_early.o: in function `early_au_setup':
> > > > > > 	8250_early.c:(.init.text+0x7): undefined reference to `au_serial_in'
> > > > > > 	ld: 8250_early.c:(.init.text+0xf): undefined reference to `au_serial_out'
> > > > > > 	make: *** [Makefile:1164: vmlinux] Error 1
> > > > > > 
> > > > > 
> > > > > I *always* test build my sets before posting.
> > > > > 
> > > > > /investigating
> > > > 
> > > > What config failed for you?
> > > > 
> > > > It looks as though SERIAL_8250_CONSOLE is a bool and doesn't appear to
> > > > be compiled with allmodconfig builds for any architecture that I test
> > > > against (Arm, Arm64, MIPS, PPC, x86).
> > > 
> > > I build on x86, and here's what I have set:
> > > 
> > > CONFIG_SERIAL_EARLYCON=y
> > > CONFIG_SERIAL_8250=y
> > > CONFIG_SERIAL_8250_DEPRECATED_OPTIONS=y
> > > CONFIG_SERIAL_8250_PNP=y
> > > CONFIG_SERIAL_8250_16550A_VARIANTS=y
> > > CONFIG_SERIAL_8250_FINTEK=y
> > > CONFIG_SERIAL_8250_CONSOLE=y
> > > CONFIG_SERIAL_8250_DMA=y
> > > CONFIG_SERIAL_8250_PCI=y
> > > CONFIG_SERIAL_8250_EXAR=y
> > > CONFIG_SERIAL_8250_NR_UARTS=16
> > > CONFIG_SERIAL_8250_RUNTIME_UARTS=8
> > > CONFIG_SERIAL_8250_EXTENDED=y
> > > # CONFIG_SERIAL_8250_MANY_PORTS is not set
> > > # CONFIG_SERIAL_8250_SHARE_IRQ is not set
> > > # CONFIG_SERIAL_8250_DETECT_IRQ is not set
> > > # CONFIG_SERIAL_8250_RSA is not set
> > > CONFIG_SERIAL_8250_DWLIB=y
> > > CONFIG_SERIAL_8250_DW=m
> > > CONFIG_SERIAL_8250_RT288X=y
> > > CONFIG_SERIAL_8250_UNIPHIER=m
> > > CONFIG_SERIAL_8250_LPSS=y
> > > CONFIG_SERIAL_8250_MID=y
> > > CONFIG_SERIAL_8250_TEGRA=m
> > 
> > Is that from the default defconfig?  Or something bespoke?
> 
> No idea, bespoke I guess, it's grown over the years as what I use for
> testing the tty.git tree.  Odd that I have some 8250 options turned off,
> no idea why that is...

Not as strange as this.

I cannot recreate the issue or work out why:

# THE OUTPUT
#   *_port.o and *_early.o were both built

$ ls -l ../builds/build-x86/drivers/tty/serial/8250/
total 1196
-rw-rw-r-- 1 lee lee  36376 Nov  6 10:52 8250_aspeed_vuart.o
-rw-rw-r-- 1 lee lee  17696 Nov  6 10:52 8250_bcm2835aux.o
-rw-rw-r-- 1 lee lee  90896 Nov  6 10:52 8250_core.o
-rw-rw-r-- 1 lee lee  34184 Nov  6 10:52 8250_dma.o
-rw-rw-r-- 1 lee lee  11840 Nov  6 10:52 8250_dwlib.o
-rw-rw-r-- 1 lee lee  50472 Nov  6 10:52 8250_dw.o
-rw-rw-r-- 1 lee lee  16496 Nov  6 10:52 8250_early.o
-rw-rw-r-- 1 lee lee  49376 Nov  6 10:52 8250_exar.o
-rw-rw-r-- 1 lee lee  20256 Nov  6 10:52 8250_fintek.o
-rw-rw-r-- 1 lee lee  26976 Nov  6 10:52 8250_ingenic.o
-rw-rw-r-- 1 lee lee  18904 Nov  6 10:52 8250_lpc18xx.o
-rw-rw-r-- 1 lee lee  21712 Nov  6 10:52 8250_lpss.o
-rw-rw-r-- 1 lee lee  18768 Nov  6 10:52 8250_men_mcb.o
-rw-rw-r-- 1 lee lee  25880 Nov  6 10:52 8250_mid.o
-rw-rw-r-- 1 lee lee  30880 Nov  6 10:52 8250_of.o
-rw-rw-r-- 1 lee lee 142776 Nov  6 10:52 8250_pci.o
-rw-rw-r-- 1 lee lee  23240 Nov  6 10:52 8250_pnp.o
-rw-rw-r-- 1 lee lee 214088 Nov  6 10:52 8250_port.o
-rw-rw-r-- 1 lee lee  18992 Nov  6 10:52 8250_tegra.o
-rw-rw-r-- 1 lee lee  23736 Nov  6 10:52 8250_uniphier.o
-rw-rw-r-- 1 lee lee   1626 Nov  6 10:52 built-in.a
-rw-rw-r-- 1 lee lee      0 Nov  6 10:52 modules.order
-rw-rw-r-- 1 lee lee  94280 Nov  6 10:52 serial_cs.o

# THE BUILD

 locally noclean x86 w1 drivers/tty debug
 
 Running locally
 
 ********************
 * Building for X86 *
 ********************
 
 rm -rf ../builds/build-x86/drivers/tty/
 
 make -f Makefile -j24 KBUILD_OUTPUT=../builds/build-x86 allyesconfig
 make -f Makefile -j24 KBUILD_OUTPUT=../builds/build-x86  W=1  drivers/tty/
 
 make[1]: Entering directory '/home/lee/projects/linux/builds/build-x86'
   SYNC    include/config/auto.conf.cmd
   GEN     Makefile
   GEN     Makefile
   DESCEND  objtool
   CALL    scripts/atomic/check-atomics.sh
   CALL    scripts/checksyscalls.sh
   CC      drivers/tty/tty_io.o
   CC      drivers/tty/n_tty.o
   CC      drivers/tty/tty_ioctl.o
   CC      drivers/tty/tty_ldisc.o
   CC      drivers/tty/tty_buffer.o
   CC      drivers/tty/tty_port.o
   CC      drivers/tty/vt/vt_ioctl.o
   CC      drivers/tty/tty_mutex.o
   CC      drivers/tty/hvc/hvc_console.o
   CC      drivers/tty/vt/selection.o
   CC      drivers/tty/vt/vc_screen.o
   CC      drivers/tty/hvc/hvc_irq.o
   CC      drivers/tty/ipwireless/hardware.o
   CC      drivers/tty/serdev/core.o
   CC      drivers/tty/tty_ldsem.o
   CC      drivers/tty/vt/keyboard.o
   CC      drivers/tty/serdev/serdev-ttyport.o
   CC      drivers/tty/hvc/hvc_xen.o
   CC      drivers/tty/tty_baudrate.o
   CC      drivers/tty/ipwireless/main.o
   CC      drivers/tty/serial/serial_core.o
   CC      drivers/tty/serial/8250/8250_core.o
   CC      drivers/tty/serial/8250/8250_pnp.o
   CC      drivers/tty/serial/jsm/jsm_driver.o
   CC      drivers/tty/ipwireless/network.o
   CC      drivers/tty/ipwireless/tty.o
   CC      drivers/tty/serial/8250/8250_port.o
   CC      drivers/tty/vt/consolemap.o
   CC      drivers/tty/serial/jsm/jsm_neo.o
   CC      drivers/tty/serial/8250/8250_dma.o
   HOSTCC  drivers/tty/vt/conmakehash
   CC      drivers/tty/tty_jobctrl.o
   CC      drivers/tty/n_null.o
   CC      drivers/tty/serial/8250/8250_dwlib.o
   CC      drivers/tty/vt/vt.o
   AR      drivers/tty/ipwireless/built-in.a
   CC      drivers/tty/serial/jsm/jsm_tty.o
   CC      drivers/tty/serial/jsm/jsm_cls.o
   CC      drivers/tty/serial/earlycon.o
   CC      drivers/tty/pty.o
   SHIPPED drivers/tty/vt/defkeymap.c
   CC      drivers/tty/tty_audit.o
   CC      drivers/tty/vt/defkeymap.o
   CONMK   drivers/tty/vt/consolemap_deftbl.c
   CC      drivers/tty/vt/consolemap_deftbl.o
   CC      drivers/tty/serial/clps711x.o
   CC      drivers/tty/serial/8250/8250_fintek.o
   AR      drivers/tty/serial/jsm/built-in.a
   AR      drivers/tty/hvc/built-in.a
   CC      drivers/tty/serial/bcm63xx_uart.o
   CC      drivers/tty/serial/8250/8250_pci.o
   CC      drivers/tty/serial/samsung_tty.o
   CC      drivers/tty/serial/8250/8250_exar.o
   CC      drivers/tty/serial/max3100.o
   CC      drivers/tty/serial/max310x.o
   CC      drivers/tty/serial/lpc32xx_hs.o
   AR      drivers/tty/serdev/built-in.a
   CC      drivers/tty/serial/8250/serial_cs.o
   CC      drivers/tty/serial/8250/8250_aspeed_vuart.o
   CC      drivers/tty/sysrq.o
   CC      drivers/tty/n_hdlc.o
   CC      drivers/tty/n_gsm.o
   CC      drivers/tty/n_tracerouter.o
   CC      drivers/tty/n_tracesink.o
   CC      drivers/tty/serial/8250/8250_bcm2835aux.o
   CC      drivers/tty/serial/sh-sci.o
   CC      drivers/tty/cyclades.o
   CC      drivers/tty/serial/imx.o
   CC      drivers/tty/serial/imx_earlycon.o
   CC      drivers/tty/serial/8250/8250_early.o
   CC      drivers/tty/serial/8250/8250_men_mcb.o
   CC      drivers/tty/isicom.o
   CC      drivers/tty/moxa.o
   CC      drivers/tty/serial/8250/8250_dw.o
   AR      drivers/tty/vt/built-in.a
   CC      drivers/tty/mxser.o
   CC      drivers/tty/serial/sccnxp.o
   CC      drivers/tty/serial/8250/8250_lpc18xx.o
   CC      drivers/tty/serial/sc16is7xx.o
   CC      drivers/tty/serial/8250/8250_uniphier.o
   CC      drivers/tty/serial/atmel_serial.o
   CC      drivers/tty/serial/uartlite.o
   CC      drivers/tty/serial/8250/8250_ingenic.o
   CC      drivers/tty/serial/qcom_geni_serial.o
   CC      drivers/tty/serial/8250/8250_lpss.o
   CC      drivers/tty/serial/8250/8250_mid.o
   CC      drivers/tty/nozomi.o
   CC      drivers/tty/ttynull.o
   CC      drivers/tty/rocket.o
   CC      drivers/tty/synclink_gt.o
   CC      drivers/tty/serial/8250/8250_tegra.o
   CC      drivers/tty/serial/8250/8250_of.o
   CC      drivers/tty/goldfish.o
   CC      drivers/tty/serial/altera_uart.o
   CC      drivers/tty/serial/st-asc.o
   CC      drivers/tty/serial/ucc_uart.o
   CC      drivers/tty/serial/timbuart.o
   CC      drivers/tty/serial/altera_jtaguart.o
   CC      drivers/tty/serial/ifx6x60.o
   CC      drivers/tty/serial/pch_uart.o
   CC      drivers/tty/serial/mxs-auart.o
   CC      drivers/tty/serial/lantiq.o
   AR      drivers/tty/serial/8250/built-in.a
   CC      drivers/tty/serial/xilinx_uartps.o
   CC      drivers/tty/serial/arc_uart.o
   CC      drivers/tty/serial/rp2.o
   CC      drivers/tty/serial/fsl_lpuart.o
   CC      drivers/tty/serial/fsl_linflexuart.o
   CC      drivers/tty/serial/digicolor-usart.o
   CC      drivers/tty/serial/men_z135_uart.o
   CC      drivers/tty/serial/sprd_serial.o
   CC      drivers/tty/serial/stm32-usart.o
   CC      drivers/tty/serial/mvebu-uart.o
   CC      drivers/tty/serial/mps2-uart.o
   CC      drivers/tty/serial/owl-uart.o
   CC      drivers/tty/serial/rda-uart.o
   CC      drivers/tty/serial/milbeaut_usio.o
   CC      drivers/tty/serial/sifive.o
   CC      drivers/tty/serial/serial_mctrl_gpio.o
   CC      drivers/tty/serial/kgdb_nmi.o
   CC      drivers/tty/serial/kgdboc.o
   AR      drivers/tty/serial/built-in.a
   AR      drivers/tty/built-in.a
 make[1]: Leaving directory '/home/lee/projects/linux/builds/build-x86'
 
 ******************************
 * Checking for SPARSE errors *
 ******************************
 
 make -f Makefile -j24 KBUILD_OUTPUT=../builds/build-x86 C=1 W=1  drivers/tty/
 
 make[1]: Entering directory '/home/lee/projects/linux/builds/build-x86'
   GEN     Makefile
   DESCEND  objtool
   CALL    scripts/atomic/check-atomics.sh
   CALL    scripts/checksyscalls.sh
 make[1]: Leaving directory '/home/lee/projects/linux/builds/build-x86'
 
 ******************************
 * Checking for SMATCH errors *
 *   TODO: stdout => stderr   *
 ******************************
 
 make -f Makefile -j24 KBUILD_OUTPUT=../builds/build-x86 C=1 CHECK='smatch --no-data -p=kernel' W=1  drivers/tty/
 
 make[1]: Entering directory '/home/lee/projects/linux/builds/build-x86'
   GEN     Makefile
   DESCEND  objtool
   CALL    scripts/atomic/check-atomics.sh
   CALL    scripts/checksyscalls.sh
 make[1]: Leaving directory '/home/lee/projects/linux/builds/build-x86'

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
