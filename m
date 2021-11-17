Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 470DDC433EF
	for <linux-serial@archiver.kernel.org>; Wed, 17 Nov 2021 10:43:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BF5963237
	for <linux-serial@archiver.kernel.org>; Wed, 17 Nov 2021 10:43:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231650AbhKQKqe (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 17 Nov 2021 05:46:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234464AbhKQKqe (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 17 Nov 2021 05:46:34 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73986C061570;
        Wed, 17 Nov 2021 02:43:35 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id w1so9002942edc.6;
        Wed, 17 Nov 2021 02:43:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uDN1GsOnIo4V4ElqUrvWCtZve9NFoolkaMsk7vOONMc=;
        b=Gm/D8C/h5/hiiov56d8uVRJ/UloKPbAgDbfQ2BiLzeB3h0Bmk/EbgUFppqrezlFsJb
         aPt24m7oD0agtX+k7WUTkGiCXs9UT1bJnlKnhKfqtBFKDLbIll0X/9pD/CZegoDBMyzW
         xYuTr2pfLAntlCNJvupanmwWpKKl9V9wSNB5r5G0aIKFqT6rL+dMqyWhaQhL5LgDLKjz
         Is06RAyB22Z3RmrJAVFgF7sviPfSsgTtoU1HBi+1Ti8P7vLzPA+naLBi5FJJ0E/iTItY
         ensYu4kgixXXCw1U6sV3hm8PnMVd88E9idQsGfBhvmuuNjvfOCKCwvnvooflSRDKjjDO
         qgCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uDN1GsOnIo4V4ElqUrvWCtZve9NFoolkaMsk7vOONMc=;
        b=H7CkcR6y6bQfo6cHXSVmUyUiKLHQOu2BVjRDuGjSAKA1ZGCuZdm4ABlwJqv+8YXTts
         1H/JCFPIbZ/anBZobz1XHz1I1Q2tsgRTcSaHrEvSm/cBhKAWWwLNSWahDpiml2O3osgG
         xDHFpllOrvnP1lEzRXG0d0BjSHh3abDfVevw+s6MKQQVfxHMLGG5vtjgXRWtw8YRWFLO
         0QY6l7sKhSgRA+xjiLpkJyERxKBngQpYC2JN5bjbbRtDOzDprsGzbym5GPahrZ60ER4O
         HPNNtHrdwL5SMYpJgP8GX+rsXefhxoJhYcjiVqUeVbH0OK82dzxkY2n/gCgwttwmSvqc
         gCNA==
X-Gm-Message-State: AOAM533BU23Lpd4ir8LnOifDcLQwB0wS5ojRHYW4n9RqHZcXZmCKo80C
        aBEKQ7qffnW0DEPQUruurNxGmHynlgjx/l+Nz8w=
X-Google-Smtp-Source: ABdhPJy0UZW10x7IeVGEKtr3DcWxCW3RECxfztJDi9a6POTS6H3CWw1nuNc/+bHx5mNtasnfykpuO6ePXi1yDfEoEoQ=
X-Received: by 2002:a17:907:869e:: with SMTP id qa30mr19414299ejc.356.1637145814005;
 Wed, 17 Nov 2021 02:43:34 -0800 (PST)
MIME-Version: 1.0
References: <20211117100512.5058-1-johan@kernel.org>
In-Reply-To: <20211117100512.5058-1-johan@kernel.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 17 Nov 2021 12:42:53 +0200
Message-ID: <CAHp75Ve9MB4MW9KDPoNhnPa8TCabmMgLbt6H7qrGgwmA8CpdNg@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] serial: liteuart: fix driver unbind
To:     Johan Hovold <johan@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ilia Sergachev <silia@ethz.ch>,
        Karol Gugala <kgugala@antmicro.com>,
        Mateusz Holenko <mholenko@antmicro.com>,
        Stafford Horne <shorne@gmail.com>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Nov 17, 2021 at 12:05 PM Johan Hovold <johan@kernel.org> wrote:
>
> Ilia Sergachev noted that the liteuart remove() function would trigger a
> NULL-pointer dereference if it was ever called since the driver data
> pointer was never initialised.
>
> Turns out there are more bugs in this part of the driver which clearly
> has never been tested.
>
> Also relax the Kconfig dependencies so that the driver can be
> compile-tested without first enabling a seemingly unrelated SoC
> controller driver.
>
> Note that this series depends on the fix by Ilia:
>
>         https://lore.kernel.org/r/20211115031808.7ab632ef@dtkw


FWIW,
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Johan
>
>
> Changes in v2
>  - allow compile testing without CONFIG_OF (Andy)
>  - reword commit message to clarify that LITEX is neither a build or
>    runtime dependency and that the change only makes it easier to
>    compile test the driver
>  - move the Kconfig patch last in the series
>  - add Stafford's reviewed by tags to the two unmodified patches
>
>
> Johan Hovold (3):
>   serial: liteuart: fix use-after-free and memleak on unbind
>   serial: liteuart: fix minor-number leak on probe errors
>   serial: liteuart: relax compile-test dependencies
>
>  drivers/tty/serial/Kconfig    |  2 +-
>  drivers/tty/serial/liteuart.c | 18 +++++++++++++++---
>  2 files changed, 16 insertions(+), 4 deletions(-)
>
> --
> 2.32.0
>


-- 
With Best Regards,
Andy Shevchenko
