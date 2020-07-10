Return-Path: <SRS0=t8aj=AV=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1176C433E7
	for <linux-serial@archiver.kernel.org>; Fri, 10 Jul 2020 13:12:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC57F206A5
	for <linux-serial@archiver.kernel.org>; Fri, 10 Jul 2020 13:12:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BlknhlTB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727865AbgGJNMw (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 10 Jul 2020 09:12:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726828AbgGJNMv (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 10 Jul 2020 09:12:51 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61FE4C08C5CE
        for <linux-serial@vger.kernel.org>; Fri, 10 Jul 2020 06:12:51 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id a1so5954117ejg.12
        for <linux-serial@vger.kernel.org>; Fri, 10 Jul 2020 06:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8+B6R5mJEpOJb42tI1yLL2PEwUrHS9w3qTSTv3oJe1E=;
        b=BlknhlTBd+Ss9ftS/csOWPo/g8foLPXmQVd0lTgVKsQn0pUIivQ6n5bKQD42c0dbfK
         np+SklQ1QOnUgnQzunCX0ufti23nX0g3OipJtKXB2qEkQdbJFJ6spI8HWq0/Sbxscmht
         GmdAvASmDND+VdyWC9VqAiyvE+6jB/M0nvya2L/y2rl7/pRuIlYZ2+vjFfvtOji1wicM
         sT9bAoM2BDIRdfkf6USHYJka+h0NRc3a+PIUsATRORMKsF1CqlVqXviqk4axENS/G530
         PntkVg6PlAxTjkGYOcvodIUn8iUZvKdIAJgmzxK7pXN164eKMOy+W39hatptpgWlv8FZ
         WELQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8+B6R5mJEpOJb42tI1yLL2PEwUrHS9w3qTSTv3oJe1E=;
        b=klbQPDqVIcwSb+L1JFo26e8Ct5Ld3c++ZNokT+tCLozonMtziFfIF4KmMsvUNQ7Lz2
         ac8jOejvIEwUS389vVe2Pp3xX1EYYmLnX3hez0xYuyBJZAKaCI8RdOaRpEP7dNg9zYNC
         N117Rbp0/RJoF/V+MBX12R/RI1ycuUl3KvlSrMRXtl91t/Te77z3xhFkJXAnU8nOXz9n
         +RZP9vH/1XYcJRX3zt1g/DwdJUUTCqa4I2oSUfBnON4Bmn+MVxjeGvM3/+DYguK/05i3
         J2yWF4RiAzBzqsHVMVGM0N/QZuxctBFoef6/hJmhSwAizgDM5rsq9LxH9NaKtn1qDoew
         BdPQ==
X-Gm-Message-State: AOAM531SXJoiyQYE6B/xcHDiFZaFjp8R6lCp0SfNFB5r3kg908upM48X
        nSRSrdw/s0RiTfxlSYTZWzlaA9fJOtwwFI8ahtHRaA==
X-Google-Smtp-Source: ABdhPJzxFImHbY4FhXga1db3MgMaAyDyZ/8LYPGNGHiL0rLjtrnjvgWuvykjpbgFfHRnDNiRPbZzhe63Abv9ltJprqg=
X-Received: by 2002:a17:906:c0da:: with SMTP id bn26mr60611929ejb.359.1594386770075;
 Fri, 10 Jul 2020 06:12:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200706214903.56148-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20200706214903.56148-1-andriy.shevchenko@linux.intel.com>
From:   Anatoly Pugachev <matorola@gmail.com>
Date:   Fri, 10 Jul 2020 16:12:39 +0300
Message-ID: <CADxRZqz1zKb2X=J1BNyPBL3Rm6oVYtoH00haOPj+1fvLk7DK7A@mail.gmail.com>
Subject: Re: [PATCH v3] serial: core: Initialise spin lock before use in uart_configure_port()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Tony Lindgren <tony@atomide.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Jul 7, 2020 at 12:49 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> The comment near to uart_port_spin_lock_init() says:
>
>   Ensure that the serial console lock is initialised early.
>   If this port is a console, then the spinlock is already initialised.
>
> and there is nothing about enabled or disabled consoles. The commit
> a3cb39d258ef ("serial: core: Allow detach and attach serial device
> for console") made a change, which follows the comment, and also to
> prevent reinitialisation of the lock in use, when user detaches and
> attaches back the same console device. But this change discovers
> another issue, that uart_add_one_port() tries to access a spin lock
> that now may be uninitialised. This happens when a driver expects
> the serial core to register a console on its behalf. In this case
> we must initialise a spin lock before use.
>
> Fixes: a3cb39d258ef ("serial: core: Allow detach and attach serial device for console")
> Reported-by: Marc Zyngier <maz@kernel.org>
> Reported-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Reported-by: Anatoly Pugachev <matorola@gmail.com>
> Acked-by: Marc Zyngier <maz@kernel.org>
> Tested-by: Tony Lindgren <tony@atomide.com>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> v3: renamed lock init primitive and dropped inline (Marc), added tags (Marc, Tony)
>  drivers/tty/serial/serial_core.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c

Andy,

probably late, but tested on my sparc64 ldom - works (boots).
Thanks.
