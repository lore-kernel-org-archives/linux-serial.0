Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3449FC4167E
	for <linux-serial@archiver.kernel.org>; Mon, 30 May 2022 13:53:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233496AbiE3NxL (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 30 May 2022 09:53:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239226AbiE3NvV (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 30 May 2022 09:51:21 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4586382152;
        Mon, 30 May 2022 06:35:32 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id c2so4023319edf.5;
        Mon, 30 May 2022 06:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B5qzJKFRJwAAu/QM/B/KVn24fcOUj7gvWWYWm+pws8I=;
        b=EWtmQSlAEQCyXW1SZi7EJsYzFWTGB4Q+1bUGtDn/pkr+Yr2eH0RrMUxgq/OWfbNeKw
         M6/yhJYDfJ9fy+d/a+08VRePSNPMZXlvgRYNU13d15l/SaFfP/YEjiwBM70OBzYV7fje
         JzJCB+lfgMIuNk8FUxbZnOoX8ANwm2+n7aLjW6B6M8NqiZCcMeztgOPWL0IzEKHUlRY4
         Y95g/w4XK7mo6MDlnwQfUs7WU6hc8OGUslzUfJXGkEd5CAz1iwrO9kG9IfZni+lirPvs
         SizdIUTlaANRJ37dclYwy0obvmwcpK+1Y/P9fEhHeBinE3EP6+i0zCvw2xWFS/I9MCy0
         sZ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B5qzJKFRJwAAu/QM/B/KVn24fcOUj7gvWWYWm+pws8I=;
        b=4Wqov/RIGAA78rf05VWJ2YPW37n4CJz0RA62j815m9Dpk69njmnrR1xu7vG+U3IolC
         mJrQ1BmbVM/Bp5w4NzgTZhgkRU4+zWE4+7Fas4Z9JOOsbGIG2F33ebOKt9Oh97MRrUWD
         G/YR4a6i3Ftu1dtp79FJ1bhiGLIKUlY6yMtiwYlmuN6iDgxsj7Bis+y267a4TPeDD+B5
         dDrl2DqH6k7flRVYziexQ40bMxMqeaDxaSyITQp7zhy1KC97fmvE8AZ9tf7TDUCM5NBD
         k/41eQ1F1CBfBKDNutMWHt17Ea5AhTfCVVGVecp2f2yeiNYO6jbPfDQq368IYUB7tcRY
         iQKw==
X-Gm-Message-State: AOAM530K33DlhLTRWLVzrA+YSFslGMkvzw79Ej/I8XGLXj3tTsyh90vi
        JzagQZlQfMENx4HnFwadmDC5xPsnUBPkLvaSCrsND0w649pQ7w==
X-Google-Smtp-Source: ABdhPJy1tcRWc2i/fixr5Hi89yMwtDtGxooa1pHHooQkVtWeJjBbYN8Iox0QLzdTeQV7bG77PvYdggjo6yYQygXVdJo=
X-Received: by 2002:a05:6402:2382:b0:42b:7fec:1abf with SMTP id
 j2-20020a056402238200b0042b7fec1abfmr33897162eda.111.1653917730570; Mon, 30
 May 2022 06:35:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220527222713.A369E3740211@freecalypso.org>
In-Reply-To: <20220527222713.A369E3740211@freecalypso.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 30 May 2022 15:34:54 +0200
Message-ID: <CAHp75Ve2WG3bQk5XXumX6r1V=qunOE-z5F90eS0tMhvbBY-Qug@mail.gmail.com>
Subject: Re: [PATCH 2/6] serial: core: add sysfs attribute to suppress raising
 DTR & RTS on open
To:     "Mychaela N. Falconia" <falcon@freecalypso.org>
Cc:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        USB <linux-usb@vger.kernel.org>,
        Mychaela Falconia <mychaela.falconia@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Sat, May 28, 2022 at 2:22 AM Mychaela N. Falconia
<falcon@freecalypso.org> wrote:
>
> Add a manual_rtsdtr sysfs attribute to suppress automatic raising of
> DTR and RTS modem control signals on serial port open.
>
> This special mode can be used to prevent undesirable side effects on
> open for applications where these lines are used for non-standard
> purposes such as generating power-on and reset pulses.

As I read this I think of the pins used as GPIOs. So, sounds like what
we need instead is to list the pins that are used for (dedicated)
GPIOs and pass this information to serial mctrl layer and perhaps
prepare that layer to handle exclusions like these. The given (in this
series) approach sounds to me like a (hackish?) workaround of this
simple idea.

-- 
With Best Regards,
Andy Shevchenko
