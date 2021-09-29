Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 608B9C433F5
	for <linux-serial@archiver.kernel.org>; Wed, 29 Sep 2021 20:50:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D31E61390
	for <linux-serial@archiver.kernel.org>; Wed, 29 Sep 2021 20:50:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346777AbhI2Uv5 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 29 Sep 2021 16:51:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346773AbhI2Uv4 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 29 Sep 2021 16:51:56 -0400
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com [IPv6:2607:f8b0:4864:20::933])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D240C06161C
        for <linux-serial@vger.kernel.org>; Wed, 29 Sep 2021 13:50:15 -0700 (PDT)
Received: by mail-ua1-x933.google.com with SMTP id i8so2549619uae.7
        for <linux-serial@vger.kernel.org>; Wed, 29 Sep 2021 13:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Fv0gX/eAGfXRcPXzdbs24Qf9uwtUlAyl1uWstmgK+2A=;
        b=Y2x1be+oyeR0xJ/tyKhiHnSwf3F/JVNiOOpUfweB8LHLJBuRXH3wDz/vauMS5SEAUp
         axpAsGP3Z1oTxoz2UKYDgNU/BdcDbLbq1l8DstRZCZqGMDB0gqDVYtroR/YueVXNy8Z6
         FACbab9NRMT7XV2KkutIrqc2OUup36ThXBAibDSuXrFQAvs9Roz7OlqI09m2wmt5sorQ
         E0KNdvf+mvYpCSKJLvO9PL7d01uflAq5y9jqZJU6loiM2gvbA2spgLE6/jps4SMeSpJO
         vCEBbMHawVPEW4H6nqcwfDu4DcvQ5Qlisqi/qcEStpuO4M+28g2RRz5zGVGrVGnwPz2b
         kbhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Fv0gX/eAGfXRcPXzdbs24Qf9uwtUlAyl1uWstmgK+2A=;
        b=xSUo4cIK7S8GxBSEBRjQeW4+nI5V1rzDy7MzTecmQ2aRvlI4ZiQdhWz3v45dk0b2La
         cOLZQwvO3i5IazHALdcrRGyFWcqZmZr5Jyya0RXOBMX+o8iTRMAOHUccyhI0Inhvc5Xr
         0wrr0So5sS3zopTKB8ooEugpF1OwdD5U+lYb/F0A2hppmMo0+/dmYgefgcWXCpBzhAe6
         SzwifTBjv+Z+9orYn+33QCFCG6aaeJJbzv3OEu+dJZmJAW3vOlabrEuRHlH1yyTzSKxM
         5Zq+b5DK9yCccX/FtoogDsekoI17WrRe69Cq2rVuMr59qItuWF9WjvXBzHJ7rs7kfNjT
         5BFw==
X-Gm-Message-State: AOAM532F3vEQ5UjSd/XClUNyBHWrtjH/NZlDOXmqGwOUco+Xbhnl10Ds
        t3yr+Z2QvZlvCwcjanBTKbiZP10O+WudAjYPFrL3vVCIq6o=
X-Google-Smtp-Source: ABdhPJyesLGgB5HfgZuhklwZa3z9p49YX+z5Or5ER2v/EHVCBGqwlRRO1gsT3FhCO82/BjsB2ni5xQqAbWHaniLbi7k=
X-Received: by 2002:ab0:5b5d:: with SMTP id v29mr2458419uae.85.1632948614131;
 Wed, 29 Sep 2021 13:50:14 -0700 (PDT)
MIME-Version: 1.0
References: <CAOMZO5Du1L4A6okC0GJaEiKQr_=n_AJ8SvA15PPU35=mxz8LZw@mail.gmail.com>
 <CAOMZO5DWFttk49W5qP75gOqpXw4HfX0=UU3rsO+y3Xgqdio4fw@mail.gmail.com>
In-Reply-To: <CAOMZO5DWFttk49W5qP75gOqpXw4HfX0=UU3rsO+y3Xgqdio4fw@mail.gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 29 Sep 2021 17:50:03 -0300
Message-ID: <CAOMZO5D1aQ1WNeU69J3pczw7oXBS2ZFHOWQm2aq5S_pfMfGfVQ@mail.gmail.com>
Subject: Re: serial: imx: Possible circular locking dependency
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Petr Mladek <pmladek@suse.com>
Cc:     linux-serial@vger.kernel.org, rostedt@goodmis.org,
        Marek Vasut <marex@denx.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Sep 29, 2021 at 3:35 PM Fabio Estevam <festevam@gmail.com> wrote:
>
> On Wed, Sep 29, 2021 at 1:10 PM Fabio Estevam <festevam@gmail.com> wrote:
> >
> > Hi Petr and Sergey,
> >
> > I know this has been reported before [1] and [2], but I am still
> > observing the deadlock below
> > on an imx6q board since commit dbdda842fe96 ("printk: Add console
> > owner and waiter logic to load balance console writes").
> >
> > To reproduce it:
> >
> > # echo t > /proc/sysrq-trigger
> >
> > [   20.325246] ======================================================
> > [   20.325252] WARNING: possible circular locking dependency detected
> > [   20.325260] 5.15.0-rc2-next-20210924-00004-gd2d6e664f29f-dirty #163
>
> If I move the __imx_uart_rxint() block outside the spin_lock() like this:
>
> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> index 8b121cd869e9..c94704f5dd99 100644
> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> @@ -955,13 +955,6 @@ static irqreturn_t imx_uart_int(int irq, void *dev_id)
>         if ((ucr4 & UCR4_OREN) == 0)
>                 usr2 &= ~USR2_ORE;
>
> -       if (usr1 & (USR1_RRDY | USR1_AGTIM)) {
> -               imx_uart_writel(sport, USR1_AGTIM, USR1);
> -
> -               __imx_uart_rxint(irq, dev_id);
> -               ret = IRQ_HANDLED;
> -       }
> -
>         if ((usr1 & USR1_TRDY) || (usr2 & USR2_TXDC)) {
>                 imx_uart_transmit_buffer(sport);
>                 ret = IRQ_HANDLED;
> @@ -993,6 +986,13 @@ static irqreturn_t imx_uart_int(int irq, void *dev_id)
>
>         spin_unlock(&sport->port.lock);
>
> +       if (usr1 & (USR1_RRDY | USR1_AGTIM)) {
> +               imx_uart_writel(sport, USR1_AGTIM, USR1);
> +
> +               __imx_uart_rxint(irq, dev_id);
> +               ret = IRQ_HANDLED;
> +       }
> +
>         return ret;
>  }
>
> Then the problem does not happen anymore.
>
> Is this a proper fix?

It seems that a proper fix would be to use the same approach as in

5697df7322fe ("serial: fsl_lpuart: split sysrq handling):

I will send a proper patch with this solution.

Thanks
