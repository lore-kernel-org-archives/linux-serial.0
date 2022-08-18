Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2C3EC00140
	for <linux-serial@archiver.kernel.org>; Thu, 18 Aug 2022 07:17:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235189AbiHRHRa (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 18 Aug 2022 03:17:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233637AbiHRHR3 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 18 Aug 2022 03:17:29 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E88458C017
        for <linux-serial@vger.kernel.org>; Thu, 18 Aug 2022 00:17:27 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id w18so517511qki.8
        for <linux-serial@vger.kernel.org>; Thu, 18 Aug 2022 00:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=iLr0ZZbDjSU7032+yNJXs7L1w9P/ve4Rdx9M/ZBgdlU=;
        b=WKlJk+Ov2wdz2cTkoZIWKl4fgZF/7i5QBvNuL2RQK1K4dvekppV4OfUb51YGeAPALM
         SqycHhvKtHKwqp6Qjr00dXmiL0aVBz0YcHteL5s8Hid5GQ3lySSZ2PJ43N8D/pTYr6L5
         AV5bit6ZEyo3ba36rTux2hJkaQY1Uunty+9K6E8srEmwnbJnGuOzSR+R+hHLVrImScFN
         viXoVHzjlVm19aQQqDN/FiVpu6Iq1zTtJ6WxF7klxhKoXLBVuBByh/ukLDHA42rWg6zR
         dpWJYdufgoQngPWrSZjBCWLhbS1MnHBzYrffxNAt7T1FUo/pzgaBmNYWatnAcYjQLm/a
         Je8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=iLr0ZZbDjSU7032+yNJXs7L1w9P/ve4Rdx9M/ZBgdlU=;
        b=hsSoKw4vGL+iMzyfN4hwuBILQhqPnq82HsLW9mc6k7uZCRTTaE4rPnotFNRbIfKS6O
         LkOXjl/B8jXTcW118KzWqk3eyMtwbdkU1p8J/KGCxB9A8CRvG3mWI9mt5BdJsVLwGx9d
         /w4JzFFPJmmyEPLVrUvRq1aZDLwi+KjkM/ErGZy/EBV9in6jQYzgYHG0jE/P72msuNhf
         8KcbZZR2oVT3H2p1xzaP/4LtcCFbXuIC9hl+oTJGOSEaSK1+FcRijfLwD1M3lRMw8ZbL
         I5IxVYWdAEZVLSaTSvMhp+2PBenMAIFEpm8LYadElDe52jojpo7IJS6Mjiay5CeRf00/
         SipQ==
X-Gm-Message-State: ACgBeo3dtBLOc1KR2CimtNDazzkWjbIU9wRhbrrkqE0Rg4sTMF8u086i
        EkPKmh9uaL1vwFA6gpzHOrM7Rz8VXZYHX8Wq+AiRaE3vTUA=
X-Google-Smtp-Source: AA6agR7vkMaZ7vcnNPXQiTkSHQytAJBIYNcay7Kk8diuFYnFyyWlUFt++5GbHkyv+QTnl7WODGV/XfiptXB5iMc1xwQ=
X-Received: by 2002:ae9:e311:0:b0:6ba:e711:fb27 with SMTP id
 v17-20020ae9e311000000b006bae711fb27mr1131181qkf.320.1660807046885; Thu, 18
 Aug 2022 00:17:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220816115739.10928-1-ilpo.jarvinen@linux.intel.com>
In-Reply-To: <20220816115739.10928-1-ilpo.jarvinen@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 18 Aug 2022 10:16:50 +0300
Message-ID: <CAHp75VeDnT3q9kZMd0H_PXK-2pyhwke6FwOh+-5=RtubjLzsiw@mail.gmail.com>
Subject: Re: [PATCH 0/8] tty/serial: Convert ->set_termios() related
 callchains to const old ktermios
To:     =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Johan Hovold <johan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Aug 16, 2022 at 3:11 PM Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:
>
> ->set_termios() callchains input old ktermios (mainly used as fallback
> and feature compares). It is discarded right after returning from the
> calls and should therefore not be modified by drivers because any such
> change will get lost (instead, the changes must be applied to the new
> ktermios). While doing this patchset, I found a few such issues that
> were fixed earlier.
>
> Now enforce old ktermios constness. Another goodie is that "get" named
> functions in tty_baudrate.c that previously mucked with the old
> ktermios can no longer have such side-effects. I found out that the
> ktermios adjustments made were dead-code for all in-tree archs anyway.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
for all, but patch 3.

I'm not sure we can blindly use old_termios settings, is there any
guarantee that old_termios _always_ has a correct baud rate settings?

> Ilpo J=C3=A4rvinen (8):
>   tty: Remove baudrate dead code & make ktermios params const
>   tty: Fix comment style in tty_termios_input_baud_rate()
>   serial: dz: Assume previous baudrate is valid
>   tty: Make tty_termios_copy_hw() old ktermios const
>   tty: Make ldisc ->set_termios() old ktermios const
>   serial: Make ->set_termios() old ktermios const
>   usb: serial: Make ->set_termios() old ktermios const
>   tty: Make ->set_termios() old ktermios const
>
>  drivers/char/pcmcia/synclink_cs.c           |  3 ++-
>  drivers/ipack/devices/ipoctal.c             |  2 +-
>  drivers/mmc/core/sdio_uart.c                |  4 ++--
>  drivers/net/usb/hso.c                       |  3 ++-
>  drivers/s390/char/tty3270.c                 |  2 +-
>  drivers/staging/fwserial/fwserial.c         |  3 ++-
>  drivers/staging/greybus/uart.c              |  2 +-
>  drivers/tty/amiserial.c                     |  6 ++---
>  drivers/tty/moxa.c                          |  9 +++----
>  drivers/tty/mxser.c                         |  6 +++--
>  drivers/tty/n_gsm.c                         |  3 ++-
>  drivers/tty/n_tty.c                         |  2 +-
>  drivers/tty/pty.c                           |  2 +-
>  drivers/tty/serial/21285.c                  |  2 +-
>  drivers/tty/serial/8250/8250_bcm7271.c      |  2 +-
>  drivers/tty/serial/8250/8250_dw.c           |  2 +-
>  drivers/tty/serial/8250/8250_dwlib.c        |  3 ++-
>  drivers/tty/serial/8250/8250_dwlib.h        |  2 +-
>  drivers/tty/serial/8250/8250_fintek.c       |  2 +-
>  drivers/tty/serial/8250/8250_lpss.c         |  2 +-
>  drivers/tty/serial/8250/8250_mid.c          |  5 ++--
>  drivers/tty/serial/8250/8250_mtk.c          |  2 +-
>  drivers/tty/serial/8250/8250_omap.c         |  2 +-
>  drivers/tty/serial/8250/8250_port.c         |  6 ++---
>  drivers/tty/serial/altera_jtaguart.c        |  4 ++--
>  drivers/tty/serial/altera_uart.c            |  2 +-
>  drivers/tty/serial/amba-pl010.c             |  2 +-
>  drivers/tty/serial/amba-pl011.c             |  4 ++--
>  drivers/tty/serial/apbuart.c                |  2 +-
>  drivers/tty/serial/ar933x_uart.c            |  2 +-
>  drivers/tty/serial/arc_uart.c               |  2 +-
>  drivers/tty/serial/atmel_serial.c           |  5 ++--
>  drivers/tty/serial/bcm63xx_uart.c           |  5 ++--
>  drivers/tty/serial/clps711x.c               |  2 +-
>  drivers/tty/serial/cpm_uart/cpm_uart_core.c |  2 +-
>  drivers/tty/serial/digicolor-usart.c        |  2 +-
>  drivers/tty/serial/dz.c                     | 11 +++++----
>  drivers/tty/serial/fsl_linflexuart.c        |  2 +-
>  drivers/tty/serial/fsl_lpuart.c             |  4 ++--
>  drivers/tty/serial/icom.c                   |  5 ++--
>  drivers/tty/serial/imx.c                    |  2 +-
>  drivers/tty/serial/ip22zilog.c              |  2 +-
>  drivers/tty/serial/jsm/jsm_tty.c            |  4 ++--
>  drivers/tty/serial/lantiq.c                 |  4 ++--
>  drivers/tty/serial/liteuart.c               |  2 +-
>  drivers/tty/serial/lpc32xx_hs.c             |  2 +-
>  drivers/tty/serial/max3100.c                |  2 +-
>  drivers/tty/serial/max310x.c                |  2 +-
>  drivers/tty/serial/mcf.c                    |  2 +-
>  drivers/tty/serial/men_z135_uart.c          |  4 ++--
>  drivers/tty/serial/meson_uart.c             |  2 +-
>  drivers/tty/serial/milbeaut_usio.c          |  3 ++-
>  drivers/tty/serial/mpc52xx_uart.c           | 12 +++++-----
>  drivers/tty/serial/mps2-uart.c              |  2 +-
>  drivers/tty/serial/msm_serial.c             |  2 +-
>  drivers/tty/serial/mux.c                    |  2 +-
>  drivers/tty/serial/mvebu-uart.c             |  2 +-
>  drivers/tty/serial/mxs-auart.c              |  2 +-
>  drivers/tty/serial/omap-serial.c            |  2 +-
>  drivers/tty/serial/owl-uart.c               |  2 +-
>  drivers/tty/serial/pch_uart.c               |  3 ++-
>  drivers/tty/serial/pic32_uart.c             |  2 +-
>  drivers/tty/serial/pmac_zilog.c             |  4 ++--
>  drivers/tty/serial/pxa.c                    |  2 +-
>  drivers/tty/serial/qcom_geni_serial.c       |  3 ++-
>  drivers/tty/serial/rda-uart.c               |  2 +-
>  drivers/tty/serial/rp2.c                    |  5 ++--
>  drivers/tty/serial/sa1100.c                 |  2 +-
>  drivers/tty/serial/samsung_tty.c            |  2 +-
>  drivers/tty/serial/sb1250-duart.c           |  2 +-
>  drivers/tty/serial/sc16is7xx.c              |  2 +-
>  drivers/tty/serial/sccnxp.c                 |  3 ++-
>  drivers/tty/serial/serial-tegra.c           |  3 ++-
>  drivers/tty/serial/serial_core.c            |  8 +++----
>  drivers/tty/serial/serial_txx9.c            |  2 +-
>  drivers/tty/serial/sh-sci.c                 |  2 +-
>  drivers/tty/serial/sifive.c                 |  2 +-
>  drivers/tty/serial/sprd_serial.c            |  5 ++--
>  drivers/tty/serial/st-asc.c                 |  2 +-
>  drivers/tty/serial/stm32-usart.c            |  2 +-
>  drivers/tty/serial/sunhv.c                  |  2 +-
>  drivers/tty/serial/sunplus-uart.c           |  2 +-
>  drivers/tty/serial/sunsab.c                 |  2 +-
>  drivers/tty/serial/sunsu.c                  |  2 +-
>  drivers/tty/serial/sunzilog.c               |  2 +-
>  drivers/tty/serial/tegra-tcu.c              |  2 +-
>  drivers/tty/serial/timbuart.c               |  4 ++--
>  drivers/tty/serial/uartlite.c               |  5 ++--
>  drivers/tty/serial/ucc_uart.c               |  3 ++-
>  drivers/tty/serial/vt8500_serial.c          |  2 +-
>  drivers/tty/serial/xilinx_uartps.c          |  3 ++-
>  drivers/tty/serial/zs.c                     |  2 +-
>  drivers/tty/synclink_gt.c                   |  3 ++-
>  drivers/tty/tty.h                           |  2 +-
>  drivers/tty/tty_baudrate.c                  | 26 +++++++--------------
>  drivers/tty/tty_ioctl.c                     |  4 ++--
>  drivers/usb/class/cdc-acm.c                 |  4 ++--
>  drivers/usb/serial/ark3116.c                |  2 +-
>  drivers/usb/serial/belkin_sa.c              |  6 +++--
>  drivers/usb/serial/ch341.c                  |  5 ++--
>  drivers/usb/serial/cp210x.c                 | 13 +++++++----
>  drivers/usb/serial/cypress_m8.c             |  6 +++--
>  drivers/usb/serial/digi_acceleport.c        |  6 +++--
>  drivers/usb/serial/f81232.c                 |  3 ++-
>  drivers/usb/serial/f81534.c                 |  4 ++--
>  drivers/usb/serial/ftdi_sio.c               |  6 +++--
>  drivers/usb/serial/io_edgeport.c            |  7 +++---
>  drivers/usb/serial/io_ti.c                  |  8 ++++---
>  drivers/usb/serial/ir-usb.c                 |  6 +++--
>  drivers/usb/serial/iuu_phoenix.c            |  3 ++-
>  drivers/usb/serial/keyspan.c                |  3 ++-
>  drivers/usb/serial/keyspan_pda.c            |  3 ++-
>  drivers/usb/serial/kl5kusb105.c             |  5 ++--
>  drivers/usb/serial/kobil_sct.c              |  6 +++--
>  drivers/usb/serial/mct_u232.c               |  5 ++--
>  drivers/usb/serial/mos7720.c                |  5 ++--
>  drivers/usb/serial/mos7840.c                |  5 ++--
>  drivers/usb/serial/mxuport.c                |  4 ++--
>  drivers/usb/serial/oti6858.c                |  6 +++--
>  drivers/usb/serial/pl2303.c                 |  3 ++-
>  drivers/usb/serial/quatech2.c               |  4 ++--
>  drivers/usb/serial/spcp8x5.c                |  3 ++-
>  drivers/usb/serial/ssu100.c                 |  4 ++--
>  drivers/usb/serial/ti_usb_3410_5052.c       |  6 +++--
>  drivers/usb/serial/upd78f0730.c             |  4 ++--
>  drivers/usb/serial/usb-serial.c             |  3 ++-
>  drivers/usb/serial/whiteheat.c              |  6 +++--
>  drivers/usb/serial/xr_serial.c              | 20 +++++++++-------
>  include/linux/serial_8250.h                 |  4 ++--
>  include/linux/serial_core.h                 |  6 ++---
>  include/linux/tty.h                         |  4 ++--
>  include/linux/tty_driver.h                  |  4 ++--
>  include/linux/tty_ldisc.h                   |  4 ++--
>  include/linux/usb/serial.h                  |  4 ++--
>  net/bluetooth/rfcomm/tty.c                  |  3 ++-
>  135 files changed, 283 insertions(+), 234 deletions(-)
>
> --
> 2.30.2
>


--=20
With Best Regards,
Andy Shevchenko
