Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2254C43219
	for <linux-serial@archiver.kernel.org>; Thu, 24 Nov 2022 12:10:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbiKXMKZ (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 24 Nov 2022 07:10:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbiKXMKY (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 24 Nov 2022 07:10:24 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0400E748C6
        for <linux-serial@vger.kernel.org>; Thu, 24 Nov 2022 04:10:24 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id d123so1093359iof.7
        for <linux-serial@vger.kernel.org>; Thu, 24 Nov 2022 04:10:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WsnqhIo8OuDtSYALlQhH/obeAFS+XPS7ahZHr0d+yKU=;
        b=YjfJcqXwBHOuVL7wse2ZKsQ5JtVewfVDDfpPUV3ubL2ABHvwcOsMfh/HD/aiEg6gBB
         XX/wR1/utF+we2u4WcBAMai6wjIAhlDokhsEktAsEKxDjH4nIrxXjHdbODGOHBoWnqqk
         Cq2an3iNEkj2a9KY8cKh4PvmX1XJ5yuCdmHkQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WsnqhIo8OuDtSYALlQhH/obeAFS+XPS7ahZHr0d+yKU=;
        b=mXaT9yEwrVpv3RI5uqeIDowyt6tA1I35RBtmF5e43UY228jR0NG/crHBMENEw+thSc
         0avJ8YgpOx4XhulmmFjxsNCBjV2h/kSD7PBUPJlawQ8+TGkeM2MD2YJ5AYg/ZJ2xc7wZ
         xZ5naLRuoRAA06IeGrP7lkvLpvg91fhIdp8Gkzwwj9tzMchrGnTntzyy+fTbOzlPSWu/
         XSjRZ282THzMMMeIULvTgMWOhn78A0aQvzAujt4POu1TpacgaEqjahxp87u/cJrvSweA
         pZdf+cchLsUAvRPW9hf5TjuIesX7CFtgvC+azYpseP/ur80yDh3KNACiMvFZ/0TJheYu
         4Dzw==
X-Gm-Message-State: ANoB5pkHs6UyM/GcbGlq3yLdI9NchDLHQc56NCI+hqmZtXtX/WAWm1Sr
        rp7G0xvcc82Kq/jWtjLVfoAacz0m6xuAVA==
X-Google-Smtp-Source: AA0mqf7S0f+JInZV3RI+7UAE4Fqk4G+knLQutd6y8crVF5cemSpQLVyEbwSN9IaonHuf/mDorzcSMQ==
X-Received: by 2002:a02:7a06:0:b0:374:c658:2141 with SMTP id a6-20020a027a06000000b00374c6582141mr13886845jac.210.1669291823247;
        Thu, 24 Nov 2022 04:10:23 -0800 (PST)
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com. [209.85.166.52])
        by smtp.gmail.com with ESMTPSA id m16-20020a0566022e9000b006deea01ff39sm400776iow.22.2022.11.24.04.10.21
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Nov 2022 04:10:22 -0800 (PST)
Received: by mail-io1-f52.google.com with SMTP id y6so1088873iof.9
        for <linux-serial@vger.kernel.org>; Thu, 24 Nov 2022 04:10:21 -0800 (PST)
X-Received: by 2002:a02:c897:0:b0:374:100a:b0c7 with SMTP id
 m23-20020a02c897000000b00374100ab0c7mr6338879jao.185.1669291821369; Thu, 24
 Nov 2022 04:10:21 -0800 (PST)
MIME-Version: 1.0
References: <20221123-serial-clk-v2-0-9c03ce8940d8@chromium.org>
 <20221123-serial-clk-v2-2-9c03ce8940d8@chromium.org> <140187ba-7d2c-8b7b-e172-7350eed458be@kernel.org>
In-Reply-To: <140187ba-7d2c-8b7b-e172-7350eed458be@kernel.org>
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Thu, 24 Nov 2022 13:10:10 +0100
X-Gmail-Original-Message-ID: <CANiDSCvq54Xr7OECNuo230XhNbtY1Pgr8GA+ajreEZGYGucq9Q@mail.gmail.com>
Message-ID: <CANiDSCvq54Xr7OECNuo230XhNbtY1Pgr8GA+ajreEZGYGucq9Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] earlycon: Let users set the clock frequency
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, 24 Nov 2022 at 12:19, Jiri Slaby <jirislaby@kernel.org> wrote:
>
> Hi,
>
> On 24. 11. 22, 11:02, Ricardo Ribalda wrote:
> ...
> > --- a/drivers/tty/serial/earlycon.c
> > +++ b/drivers/tty/serial/earlycon.c
> > @@ -120,9 +120,15 @@ static int __init parse_options(struct earlycon_device *device, char *options)
> >       }
> >
> >       if (options) {
> > +             char *uartclk;
> > +
> >               if (kstrtouint(options, 0, &device->baud) < 0)
> >                       pr_warn("[%s] unsupported earlycon baud rate option\n",
> >                               options);
>
> IMO this won't work if there is a comma in options (i.e. your new
> clkrate param). kstrtouint will return -EINVAL in that case.
>
> > +             uartclk = strchr(options, ',');
> > +             if (uartclk && kstrtouint(uartclk, 0, &port->uartclk) < 0)
>
> You are giving ",number" to kstrtouint, right? That won't work either ;).


The fun thing is that it worked because it fell back to the acpi
parameters :). Will send a v3

Thanks!
>
> regards,
> --
> js
>


-- 
Ricardo Ribalda
