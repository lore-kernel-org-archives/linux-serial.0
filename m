Return-Path: <SRS0=lyyL=6G=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92143C54FCB
	for <linux-serial@archiver.kernel.org>; Wed, 22 Apr 2020 19:20:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 682A72137B
	for <linux-serial@archiver.kernel.org>; Wed, 22 Apr 2020 19:20:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uhT1tnQf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726377AbgDVTUq (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 22 Apr 2020 15:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725935AbgDVTUp (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 22 Apr 2020 15:20:45 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E7AAC03C1A9;
        Wed, 22 Apr 2020 12:20:45 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id w65so1593011pfc.12;
        Wed, 22 Apr 2020 12:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KtmFmWbQrY8pc1EpVQXZVMz+o7YgDf3mMA7eDgpe41c=;
        b=uhT1tnQfPSj/TjtZ3wZw+so7Z0Vt7cA+7T6xXaEseKDmfs5FBjyrvrTomdpZvQDiY2
         2k5+TnTWWIoEE8Acv1BllsIWWxWBlBAcIqY4aYLDMMMYGCq2FM+9mKXgjzqBDTt8pqMC
         oNbP3xVPWlH15/zlEZOQTawwTnBtbtNgjGJIxDlJlY0ETcRFB3H59NFbDMKKvi+PYdlF
         P9XmiAm9GYIflk6+mwaBhQviWGrRoBjEM6x1PIPNbs5d04JFOQ4gfn6liDfD+LG8wOKn
         3aFUdAl0kNG+iGbWf5QmqIkoszQHtXkfvo2qM3zaqtCD0YV82j+Q21XA6mhylE7eaIem
         tXRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KtmFmWbQrY8pc1EpVQXZVMz+o7YgDf3mMA7eDgpe41c=;
        b=buLPIHExYGurUyi7e1kAUHlS4xKha2C56YltIRc8SBwUJJtrrAiwQbVEm0TqpISr4j
         Cg3MTu1VWIcySbv/sv3rB0t3r8x1qsDBSfL7u6+DDj3RDDZaDbDLzPF+9wKgTti/V7HU
         SkcHR5RumgJyIwdGBpl7Sm/UpXrAFBLzTzfWD4CiyspBGE6Xmjp76sdJbJLLsX5fFZ09
         F1Ju7IAjKGKGpH0RuREUJpZ6VebI2g9GnwaFK5128KCaWB00hzWy0hMCUP65bGtYCKNa
         azjz7dJgmYgqSacFUPAmZYVaKU7XbGjPha1Q6YMbR8U3q9Xs5Awsr6fEKLMaELVA7v6N
         zltw==
X-Gm-Message-State: AGi0PuYm4x12zcIpEov81Gtg+lxurEHxPJf2YlRDX7jmHfSM1spr07VK
        3a45m/lqJRq+LUMQKpCqRmf/xISzk9XU1ll92Fg=
X-Google-Smtp-Source: APiQypITCf2xMd3UMkVUBCj0ZbhYW1/aHWeFytRZabsdA3yMLAvCt9JL2QIHRkyc3NlzpGV3HtiJhypU95zkkNQfOWE=
X-Received: by 2002:a63:5511:: with SMTP id j17mr576026pgb.4.1587583245100;
 Wed, 22 Apr 2020 12:20:45 -0700 (PDT)
MIME-Version: 1.0
References: <cc41ea10be9ab96568f0371784e3b9f8d9f434b9.1587577548.git.sean.wang@mediatek.com>
In-Reply-To: <cc41ea10be9ab96568f0371784e3b9f8d9f434b9.1587577548.git.sean.wang@mediatek.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 22 Apr 2020 22:20:33 +0300
Message-ID: <CAHp75VdSvE9RPq3V8LTVX7OjaYs1PThVi2f1roh3p5EY_k0ANA@mail.gmail.com>
Subject: Re: [PATCH v3] tty: serial: don't do termios for BTIF
To:     Sean Wang <sean.wang@mediatek.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Stefan Roese <sr@denx.de>, Arnd Bergmann <arnd@arndb.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        tthayer <tthayer@opensource.altera.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Steven Liu <steven.liu@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Apr 22, 2020 at 9:05 PM <sean.wang@mediatek.com> wrote:
>
> From: Sean Wang <sean.wang@mediatek.com>
>
> Bluetooth Interface (BTIF) is designed dedicatedly for MediaTek SOC with
> BT in order to be instead of the UART interface between BT module and Host
> CPU, and not exported to user space to access.
>
> As the UART design, BTIF will be an APB slave and can transmit or receive
> data by MCU access, but doesn't provide termios function like baudrate and
> flow control setup.
>
> Even LCR on offset 0xC that is just a FAKELCR
> a. If FAKELCR[7] is equaled to 1, RBR(0x00), THR(0x00), IER(0x04)
>    will not be readable/writable.
>
> b. If FAKELCR is equaled to 0xBF, RBR(0x00), THR(0x00), IER(0x04),
>    IIR(0x08), and LSR(0x14) will not be readable/writable.
>
> So adding a new capability 'UART_CAP_NTIO' for the unusual unsupported
> case.
>
> Fixes: 1c16ae65e250 ("serial: 8250: of: Add new port type for MediaTek BTIF controller on MT7622/23 SoC")
> Cc: Steven Liu <steven.liu@mediatek.com>

> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

I didn't suggest this change. I only commented on the name of the macro.

> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
>
> --
> v1->v2:
> no change on termios->c_cflag and refine commit message
>
> v2->v3:
> change the naming from NMOD to NTIO as TIO is a well established prefix
> for termios IOCTLs.
> ---
>  drivers/tty/serial/8250/8250.h      | 1 +
>  drivers/tty/serial/8250/8250_port.c | 5 ++++-
>  2 files changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
> index 33ad9d6de532..234d8db470c0 100644
> --- a/drivers/tty/serial/8250/8250.h
> +++ b/drivers/tty/serial/8250/8250.h
> @@ -82,6 +82,7 @@ struct serial8250_config {
>  #define UART_CAP_MINI  (1 << 17)       /* Mini UART on BCM283X family lacks:
>                                          * STOP PARITY EPAR SPAR WLEN5 WLEN6
>                                          */
> +#define UART_CAP_NTIO  (1 << 18)       /* UART doesn't do termios */
>
>  #define UART_BUG_QUOT  (1 << 0)        /* UART has buggy quot LSB */
>  #define UART_BUG_TXEN  (1 << 1)        /* UART has buggy TX IIR status */
> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
> index 0325f2e53b74..abc974b4113f 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -286,7 +286,7 @@ static const struct serial8250_config uart_config[] = {
>                 .tx_loadsz      = 16,
>                 .fcr            = UART_FCR_ENABLE_FIFO |
>                                   UART_FCR_CLEAR_RCVR | UART_FCR_CLEAR_XMIT,
> -               .flags          = UART_CAP_FIFO,
> +               .flags          = UART_CAP_FIFO | UART_CAP_NTIO,
>         },
>         [PORT_NPCM] = {
>                 .name           = "Nuvoton 16550",
> @@ -2544,6 +2544,9 @@ serial8250_do_set_termios(struct uart_port *port, struct ktermios *termios,
>         unsigned long flags;
>         unsigned int baud, quot, frac = 0;
>
> +       if (up->capabilities & UART_CAP_NTIO)
> +               return;
> +
>         if (up->capabilities & UART_CAP_MINI) {
>                 termios->c_cflag &= ~(CSTOPB | PARENB | PARODD | CMSPAR);
>                 if ((termios->c_cflag & CSIZE) == CS5 ||
> --
> 2.25.1



-- 
With Best Regards,
Andy Shevchenko
