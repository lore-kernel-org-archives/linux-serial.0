Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A44C9FA373F
	for <linux-serial@archiver.kernel.org>; Tue, 25 Oct 2022 01:18:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231422AbiJYBSG (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 24 Oct 2022 21:18:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231394AbiJYBRw (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 24 Oct 2022 21:17:52 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5D8A1EEEE
        for <linux-serial@vger.kernel.org>; Mon, 24 Oct 2022 17:37:14 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id k2so8859059ejr.2
        for <linux-serial@vger.kernel.org>; Mon, 24 Oct 2022 17:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fPe/RMLbUY4CuSM7GCQGLirlVS+xcFvAA0teuuPRF5Q=;
        b=OyZEHkKgw9pJonxe/apcVlx8t/OatQWcG++lFP2RH/sgR7udHA3ave3qg6yhSyv8ts
         9P8tWQVY3ZO99ez5CIYNXXDcSjK4+nWK+99p8jGTGisyAe1UeAfrqntujEiWBP+HSzUR
         mUl37+uoGw+MhlNyTQ55QbmuDGjT/rVhABIkg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fPe/RMLbUY4CuSM7GCQGLirlVS+xcFvAA0teuuPRF5Q=;
        b=4TFpsXKRQOmNrbf4mJm83qVSqmdiTV2fWoFRhEoaJ3ztBOfLOabgNFJDpau8nfXX9f
         njsq0wkUXIeiHLwjGtpcGUyzBv80gJpYpKTLPR1vIgVG32C2QQsiWFeZaMhK83A0bQUm
         l4u13hg3rTeLwIPbMTVHYiSiUZPaxu5qmBQaDyTRep5RoBN+TWu9FvKn4UsVwNo4zl1y
         r4HCSKkc1VJC53xpNhzD/heB1Fgzlm6qm5Ps5UcrITACWTG0fRPifk/mW6moHvNzm/n/
         Oy331Oe8mM+bjxBAPR55nhT9H9+RnhIvcIjWM0mY+f1Du/Z8R7ZUyIRKhMjotaIFi4u7
         yZag==
X-Gm-Message-State: ACrzQf26UwigvrC4sMHNib1xeWIrZnyuZqmlnk+EWI33y5UQs+KAAq8q
        NvTWvPBrlv76uYVULX+5lw3JWO8kszl/hQx1
X-Google-Smtp-Source: AMsMyM5Rk5qZVbzEW9yAiv8NmyYntRiS4D+q4QJZcAQgZqLxJJihDeUIrg5J14fmFsowfuFk/xZSZg==
X-Received: by 2002:a17:907:2cf0:b0:7aa:21b1:9b4f with SMTP id hz16-20020a1709072cf000b007aa21b19b4fmr4633673ejc.752.1666658232961;
        Mon, 24 Oct 2022 17:37:12 -0700 (PDT)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com. [209.85.221.42])
        by smtp.gmail.com with ESMTPSA id lb3-20020a170907784300b0077909095acasm543222ejc.143.2022.10.24.17.37.11
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 17:37:12 -0700 (PDT)
Received: by mail-wr1-f42.google.com with SMTP id y16so8030717wrt.12
        for <linux-serial@vger.kernel.org>; Mon, 24 Oct 2022 17:37:11 -0700 (PDT)
X-Received: by 2002:adf:f641:0:b0:236:737f:8e00 with SMTP id
 x1-20020adff641000000b00236737f8e00mr4375266wrp.659.1666658231649; Mon, 24
 Oct 2022 17:37:11 -0700 (PDT)
MIME-Version: 1.0
References: <20221019145600.1282823-1-john.ogness@linutronix.de> <20221019145600.1282823-23-john.ogness@linutronix.de>
In-Reply-To: <20221019145600.1282823-23-john.ogness@linutronix.de>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 24 Oct 2022 17:36:59 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WYa2SEFkARyHqJFLt4vBfC9zzdnRZeaXGoa-aGtPVRiQ@mail.gmail.com>
Message-ID: <CAD=FV=WYa2SEFkARyHqJFLt4vBfC9zzdnRZeaXGoa-aGtPVRiQ@mail.gmail.com>
Subject: Re: [PATCH printk v2 22/38] serial: kgdboc: document console_lock usage
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        kgdb-bugreport@lists.sourceforge.net, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi,

On Wed, Oct 19, 2022 at 7:56 AM John Ogness <john.ogness@linutronix.de> wrote:
>
> kgdboc_earlycon_init() uses the console_lock to ensure that no consoles
> are unregistered until the kgdboc_earlycon is setup. This is necessary
> because the trapping of the exit() callback assumes that the exit()
> callback is not called before the trap is setup.
>
> Explicitly document this non-typical console_lock usage.
>
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> ---
>  drivers/tty/serial/kgdboc.c | 8 ++++++++
>  1 file changed, 8 insertions(+)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
