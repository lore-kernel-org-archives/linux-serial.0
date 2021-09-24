Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 774BFC433EF
	for <linux-serial@archiver.kernel.org>; Fri, 24 Sep 2021 15:14:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F3A761050
	for <linux-serial@archiver.kernel.org>; Fri, 24 Sep 2021 15:14:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347018AbhIXPQY (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 24 Sep 2021 11:16:24 -0400
Received: from mail-ua1-f49.google.com ([209.85.222.49]:40599 "EHLO
        mail-ua1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346962AbhIXPQY (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 24 Sep 2021 11:16:24 -0400
Received: by mail-ua1-f49.google.com with SMTP id i8so4668202uae.7;
        Fri, 24 Sep 2021 08:14:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IzHdx66/I9DnMs/+vVVxhuiRRkdOLILKFmBcM2wNsa0=;
        b=rHXad7yzr89HGwdrsu1TI5Z8I10mdb1EYeZXICQLh/63W39skXDApxDQxpn6yl8tl/
         76SVQH7fN8XAS5GkGiq9lg01jTY7UsHq5k6z8AT8KYgPcwSAlGIKNDTIcTKulUd7bPE3
         FR5dXnfbDZgPYoBQ+ijN+cSaSlaZEa4Q02nJAT0rsKZ4rr1f4J8eOLH8cdgWisKyz/Bt
         cxy5LoVxSANBZVRbHhOHn1yHIRDCvs8h2rO8u9LAzgQx/aTO2gKO85xws+X6lxNjX2QZ
         FPuSIUDKKGVYcHOyXZ1ZhhtS1Iq5lHvk4jK7NzKOB6ehQlBD64xmmKjePoQph5GE1OuM
         8xvg==
X-Gm-Message-State: AOAM530MIz1sFqtf5zY8qg4WSqLu3ESMIeE3YXYHHHoMaXHZyk9Gyl/5
        TyBTHTLCqnl02rSfJgF0PK4Fi7NP3ImFvZBuyU8=
X-Google-Smtp-Source: ABdhPJzPYhhgtjWGC/UpzYDgHkRdnZf+OBBaCGtI7lj0+mbh+C/9ZEXiCqDytvf0GqUW3ZMW4hNFmOjoCqnr11wDPqg=
X-Received: by 2002:ab0:7d5:: with SMTP id d21mr10120714uaf.78.1632496489500;
 Fri, 24 Sep 2021 08:14:49 -0700 (PDT)
MIME-Version: 1.0
References: <6421f256407262afd658ffa74ec9430581528a7d.1632467477.git.geert+renesas@glider.be>
 <20210924141232.4419-1-johan@kernel.org>
In-Reply-To: <20210924141232.4419-1-johan@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 24 Sep 2021 17:14:38 +0200
Message-ID: <CAMuHMdUKtitgin5zwya=1q1HEwJx6Fy_H8C5jGbDBgagSfwdKQ@mail.gmail.com>
Subject: Re: [PATCH] serial: 8250: allow disabling of Freescale 16550 compile test
To:     Johan Hovold <johan@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Sep 24, 2021 at 4:13 PM Johan Hovold <johan@kernel.org> wrote:
> The SERIAL_8250_FSL option is used to enable a workaround for a
> break-detection erratum for Freescale 16550 UARTs in the 8250 driver and
> is currently also used to enable support for ACPI enumeration.
>
> It is enabled on PPC, ARM and ARM64 whenever 8250 console support is
> enabled (since the quirk is needed for sysrq handling).
>
> Commit b1442c55ce89 ("serial: 8250: extend compile-test coverage")
> enabled compile testing of the code in question but did not provide a
> means to disable the option when COMPILE_TEST is enabled.
>
> Add a conditional input prompt instead so that SERIAL_8250_FSL is no
> longer enabled by default when compile testing while continuing to
> always enable the quirk for platforms that may need it.
>
> Fixes: b1442c55ce89 ("serial: 8250: extend compile-test coverage")
> Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Johan Hovold <johan@kernel.org>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
