Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F26E8C433F5
	for <linux-serial@archiver.kernel.org>; Wed, 20 Oct 2021 19:55:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7E7661354
	for <linux-serial@archiver.kernel.org>; Wed, 20 Oct 2021 19:55:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231659AbhJTT5T (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 20 Oct 2021 15:57:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231629AbhJTT5T (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 20 Oct 2021 15:57:19 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57BE3C06161C;
        Wed, 20 Oct 2021 12:55:04 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id z11so731116lfj.4;
        Wed, 20 Oct 2021 12:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o23NUFi4NSuDgxiiKqNfA+UEGKmDoRefv9wYtUa1fcg=;
        b=Q0tHDpE6NbCFqUdl2WmP/pzrTHuEbdZ37pv07jncZVe8s168enf4PIu5YsEmXpWS17
         nORnfa5X+sqfcTI9PT11mZLjYKcBpBHtnsE9kaFaZ3Gb188VVnH8VA0VYx8TIuCwcX0x
         2BLVPo2gLP2iOO3i6Usye2xTSHrMBw0IaBBahqN/3joixanbhuisuxE0vKqg6NE/PnMe
         qhgeV0rv2snVwW5UCdli+4+5Ar33vYUYmu5BLl5a6iduour+0q2Dih5l7Jyz5gUOxBb4
         IUIMcNF84/kmhwXnhG8agF01VPAM/1kHtv13vWAV9llMn1S44SclF2ytNOhIl8dNicb+
         UxHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o23NUFi4NSuDgxiiKqNfA+UEGKmDoRefv9wYtUa1fcg=;
        b=cVIRibhwkWvB+Qv7ZmKnLlgq25UGs6d/lJPzL2+Mj80W0Olyka1WNnqRJ+iLCJW+Js
         QU2YDALDTgmWy92GgeTmW8Ic4QQLZZPGUYJxWF7+bx5hQ9EQvogLLWsKjKFKnLDpubFC
         K0HdmWpEVEuo8D+EzvR+0BVxpK9aLKY83VEg8d+9UbUsfe29D5nwR81ioeaihxeOTmuA
         jXkPOZKv3BPkaXTDlV09hJFDLC517ltTocrZbpjcvpgNS0I0fCq8TMWp8ctEFr92AE8C
         yEq8UI3/XGQ9Ca5qTL/mef7jUWc97eGaiyr7zjUg8LTX3r/njTa0a9xCXPR29pAqhrOh
         2SBg==
X-Gm-Message-State: AOAM532pfHLLOUbwjvgEXPvvwdnQ9I5B0QzXT+vJVlvOafqRj/AzSzZC
        NwrywIxBFle9ZeRnQJGE24NUBaI/oVlISRI2/butMAB20PI=
X-Google-Smtp-Source: ABdhPJyHGgTVFGXw0lCyT2xq8t05Z7dcmfNDMpiuxnbYjlUce2jqVkkIfEdlRUxfg5OBN/WRx1NTCKPna32vx73fwGs=
X-Received: by 2002:ac2:5e79:: with SMTP id a25mr1197326lfr.677.1634759702571;
 Wed, 20 Oct 2021 12:55:02 -0700 (PDT)
MIME-Version: 1.0
References: <20211020192643.476895-1-francesco.dolcini@toradex.com> <20211020192643.476895-2-francesco.dolcini@toradex.com>
In-Reply-To: <20211020192643.476895-2-francesco.dolcini@toradex.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 20 Oct 2021 22:54:26 +0300
Message-ID: <CAHp75VdieUOthjX9N89W-boPNk7PrQuTuxM_xmqpo2yv07oZZA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] serial: imx: fix detach/attach of serial console
To:     Francesco Dolcini <francesco.dolcini@toradex.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Stefan Agner <stefan@agner.ch>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Oct 20, 2021 at 10:27 PM Francesco Dolcini
<francesco.dolcini@toradex.com> wrote:
>
> From: Stefan Agner <stefan@agner.ch>
>
> If the device used as a serial console gets detached/attached at runtime,
> register_console() will try to call imx_uart_setup_console(), but this
> is not possible since it is marked as __init.

Thank you for fixing this!

> For instance
>
>   # cat /sys/devices/virtual/tty/console/active
>   tty1 ttymxc0
>   # echo -n N > /sys/devices/virtual/tty/console/subsystem/ttymxc0/console
>   # echo -n Y > /sys/devices/virtual/tty/console/subsystem/ttymxc0/console

Can we leave only something like below in the commit message?

> [   73.167005] Unable to handle kernel paging request at virtual address c154d928
> [   73.168304] Internal error: Oops: 8000000d [#1] SMP ARM
> [   73.168522] CPU: 0 PID: 536 Comm: sh Not tainted 5.15.0-rc6-00056-g3968ddcf05fb #3
  ...
> [   73.168791] PC is at imx_uart_console_setup+0x0/0x238
> [   73.168927] LR is at try_enable_new_console+0x98/0x124
  ...
> [   73.173826] [<c0196f44>] (try_enable_new_console) from [<c01984a8>] (register_console+0x10c/0x2ec)
> [   73.174053] [<c01984a8>] (register_console) from [<c06e2c90>] (console_store+0x14c/0x168)
> [   73.174262] [<c06e2c90>] (console_store) from [<c0383718>] (kernfs_fop_write_iter+0x110/0x1cc)

> A similar issue could be triggered unbinding/binding the serial console

on unbinding/binding

> device [*].
>
> Drop __init so that imx_uart_setup_console() can be safely called at
> runtime.
>
> [*] https://lore.kernel.org/all/20181114174940.7865-3-stefan@agner.ch/

Make it Link: tag?

> Fixes: a3cb39d258ef ("serial: core: Allow detach and attach serial device for console")
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>

With above nit-picks addressed, FWIW,
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

-- 
With Best Regards,
Andy Shevchenko
