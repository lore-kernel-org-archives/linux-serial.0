Return-Path: <SRS0=LhIc=CX=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A55AFC433E2
	for <linux-serial@archiver.kernel.org>; Mon, 14 Sep 2020 17:28:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53F4921D7E
	for <linux-serial@archiver.kernel.org>; Mon, 14 Sep 2020 17:28:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dBMfqyJE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726044AbgINR15 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 14 Sep 2020 13:27:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbgINR1v (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 14 Sep 2020 13:27:51 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA958C061788
        for <linux-serial@vger.kernel.org>; Mon, 14 Sep 2020 10:27:47 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id h4so958593ioe.5
        for <linux-serial@vger.kernel.org>; Mon, 14 Sep 2020 10:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BwPANE+A16n6RMiw9JBF2S1Ck+UsVna++YTmzFcao5Y=;
        b=dBMfqyJEEiWN4OVGlLXbaiuqZYwZT7kTphrfPQbmvVtaOCEeAQHT0S35u5yn2VaIWs
         JrJSjswPV0J9jGvc8wWbv1L3gpVZR+Zf5HNyVRcQO5G6eszgbCCLNgMoPH2IpDxWxRfb
         QMPqN9BeUkRu652EFTslhoIrQ6KirXsVOPsUY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BwPANE+A16n6RMiw9JBF2S1Ck+UsVna++YTmzFcao5Y=;
        b=qWIF/8xyOQt96Yz91+nJd81CfBZRYzYAmxZ09yvgRTpEudUsSKT8bQlJIqKbJa2uZb
         nJ0FNvzK9WHE0QbYjyYnfVr6MXp2XyNHVvhvFasuSqHa03AnFaO+Yf8hmKj40xmDKj0+
         Pj0Y5V0TITs7EGvygzcz8RMp9GEKDpwBTq1KOzyHD8L7G/ws5INKzXPP2RB4UFySFKLl
         sWs6Q4ZSiH7+IA+7HHAyz54DUGjBznfHO8CwXG+VM0+85pOywLjoZHQxwc7PwJFSUAdV
         MK84UKIN9ktce7VcaTHRl/csLsOODWNZojpUf7tQnYWD2Q8i0RXhO+w5RSYRyOzK/GNP
         gB5g==
X-Gm-Message-State: AOAM532y3tZSVIrDxgnBOh7gw4FgCZHfmn4MNfcTGfFxOdvH3zaQFpoT
        O+qg90k7t3BXSUEuMafQCGUX2kru3AzDrbEBLGxIOg==
X-Google-Smtp-Source: ABdhPJzzsrEOkoCkxg8Yh/J7cKJRF1A17Py12eYnhGz+i/Q7pBRKtKs7wKw18KJI8Ko8jLZpDN+sPg8WNaiXkMUy5ik=
X-Received: by 2002:a02:c942:: with SMTP id u2mr13818959jao.114.1600104466981;
 Mon, 14 Sep 2020 10:27:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200911093927.608024-1-hsinyi@chromium.org> <20200914160634.GL3956970@smile.fi.intel.com>
In-Reply-To: <20200914160634.GL3956970@smile.fi.intel.com>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Tue, 15 Sep 2020 01:27:20 +0800
Message-ID: <CAJMQK-iL6xvn96=WkRBwCeyV2NEe9uTJGY2Tntomnpouern5+A@mail.gmail.com>
Subject: Re: [PATCH 1/2] tty: serial: print earlycon info after match->setup
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Changqi Hu <changqi.hu@mediatek.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Sep 15, 2020 at 12:06 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Fri, Sep 11, 2020 at 05:39:26PM +0800, Hsin-Yi Wang wrote:
> > 8250 devices may modify iotype in their own earlycon setup. For example:
> > 8250_mtk and 8250_uniphier force iotype to be MMIO32. Print earlycon info
> > after match->setup to reflect actual earlycon info.
>
> But this means you do something which user didn't ask for...
>
8250_uniphier states that it can only use mmio32
https://elixir.bootlin.com/linux/v5.9-rc4/source/drivers/tty/serial/8250/8250_uniphier.c#L46

For MTK, may be the same case. So they are set in the driver.

> > +static void __init earlycon_info(struct earlycon_device *device)
>
> Can it be earlycon_pr_info() or earlycon_print_info() ?
>
Sure. I'll send a v2.

> --
> With Best Regards,
> Andy Shevchenko
>
>
