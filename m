Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82F78C433ED
	for <linux-serial@archiver.kernel.org>; Wed,  5 May 2021 09:25:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 379B1613FB
	for <linux-serial@archiver.kernel.org>; Wed,  5 May 2021 09:25:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231774AbhEEJ0K (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 5 May 2021 05:26:10 -0400
Received: from mail-ua1-f43.google.com ([209.85.222.43]:36564 "EHLO
        mail-ua1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231265AbhEEJ0J (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 5 May 2021 05:26:09 -0400
Received: by mail-ua1-f43.google.com with SMTP id x9so362785uao.3;
        Wed, 05 May 2021 02:25:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h28TidAZCMYz7/IMmF+70mfHIZsQ1/vtB6OI3uOO2+0=;
        b=glZgqwlBfAH3f2OpZoRW+JdRVO381/Dwh6+HNKo37fgMQRsriPMgD2hQG0VuN37mWb
         1jiGpD0qWZnnaHBf9WDssD7AUHanQVi2HwPK4LhgE39hSeOl+A6qFWG9HDWFtnqPPRdX
         /uvBCq+kDZzaJTkkhurYVsFAeRlsHZdNTFAtc0P6rL2SDoCl/0IWxWsz19nxQEASE7+v
         fZx9a//h8BjNgxz8dCjXW8yTg60e7WyF2fbOw8zavueOWTkOW0Q4HLXAED8gFT5p+IYo
         GwuScIU/UD3zNSH2hZl53g6YKb/mDBTql7oRuu7uaK9kbiEHby7nKMz7+RPivhMGeci3
         7nXw==
X-Gm-Message-State: AOAM531JzCGUCgIlM2M70g2V0KPjFlQqq0rFnl8P8GwmNRNgw/cwVMjK
        0Iy1TE094960bdmFHnnfsDB+Aej+9nYQBhGcK8o=
X-Google-Smtp-Source: ABdhPJziI2TokqO5wfUMj1aBrqFZbT5GIdeIbXee3lqYPdWJeryzTcqf3ZpRLXGKV+ye4J+F2TNI8NfsZfSQjqgVtK8=
X-Received: by 2002:ab0:45e8:: with SMTP id u95mr376835uau.106.1620206712908;
 Wed, 05 May 2021 02:25:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210505091928.22010-1-jslaby@suse.cz> <20210505091928.22010-23-jslaby@suse.cz>
In-Reply-To: <20210505091928.22010-23-jslaby@suse.cz>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 5 May 2021 11:25:01 +0200
Message-ID: <CAMuHMdUM4tdoKm_vnUTo_zsR4P6oR=wp3KsZUK96xZd2jPQpyA@mail.gmail.com>
Subject: Re: [PATCH 22/35] tty: make tty_operations::write_room return uint
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>, Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Samuel Iglesias Gonsalvez <siglesias@igalia.com>,
        Jens Taprogge <jens.taprogge@taprogge.org>,
        Karsten Keil <isdn@linux-pingi.de>,
        Scott Branden <scott.branden@broadcom.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        David Lin <dtwlin@gmail.com>, Johan Hovold <johan@kernel.org>,
        Alex Elder <elder@kernel.org>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Jiri Kosina <jikos@kernel.org>,
        David Sterba <dsterba@suse.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Oliver Neukum <oneukum@suse.com>,
        Felipe Balbi <balbi@kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, May 5, 2021 at 11:19 AM Jiri Slaby <jslaby@suse.cz> wrote:
> Line disciplines expect a positive value or zero returned from
> tty->ops->write_room (invoked by tty_write_room). So make this
> assumption explicit by using unsigned int as a return value. Both of
> tty->ops->write_room and tty_write_room.
>
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>

>  arch/m68k/emu/nfcon.c                  | 2 +-
>  drivers/tty/amiserial.c                | 2 +-

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
