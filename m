Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2140C433B4
	for <linux-serial@archiver.kernel.org>; Wed,  5 May 2021 11:54:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6714761159
	for <linux-serial@archiver.kernel.org>; Wed,  5 May 2021 11:54:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232349AbhEELyz (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 5 May 2021 07:54:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232327AbhEELyz (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 5 May 2021 07:54:55 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5603C061574;
        Wed,  5 May 2021 04:53:58 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id d14so1641157edc.12;
        Wed, 05 May 2021 04:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GOLa/HhR+2JLqpJrEhs+g+vjEzJCBqJQnERANGL+Djk=;
        b=rIHEPGwjlr65nYW4qGbrpQ6ke/GG0MhDP8fgb1SYMZA6cJlhwrJ7ciPHR3czBiu2ZW
         GmR6jLPObdHbrmriqm5BmHOyA9Wm9kZa0PhK5W6prmtMHbDKoRuD4x1kix0Uim35lxv9
         Y3O/PAyrFrm7bgdOkSZSzstsJnpKdGzF4SRIv7LXlMbGt9/wpgoFdTc48sUWP01aeQSZ
         5tfoZYE9cu8FBgM45AHDMarWkUeCZ8GOoFzFu+iLybBEJBNj5caynN9EOBj5PQhZC1M7
         u1eaFwidFiATh02JZSjaUXLkhbCB00w6vydXS0ZIbGLtIONhQcZAPzMLfi51zrAiyBn7
         N8kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GOLa/HhR+2JLqpJrEhs+g+vjEzJCBqJQnERANGL+Djk=;
        b=fik8qIcEGCxhkszTyFyezPGw6GGfFTuJrMmAgYRZs8czwbd5CMuSkzvtwzDni+p+1I
         TPIpQdWPgHPKcjCrwyaAt0URl4S2yRu1UUpKw4F9RDTBK3iLDd5KR+WHMkexHv3bsfR6
         8iaZVRb1JYpxmwajGD05IYoWprVfKV1u6EFBtxY+VGUwQg/KjaQgMz4zOhYA5jY50pVF
         mMpl9L1Sze6u8A/Oi0csCjMOK1JbnZGLEDNgDd7nQ/Bg748LlwA0DQpCjgi9fpCpRTao
         qNLzVewb8tX+cxEteYw4QtWuQGATWH+jkX2sDBcBG26kdlz5fTLV+u1b8b+Vr+iTSvmB
         1v+g==
X-Gm-Message-State: AOAM533PqY1BxLRCI/bCOl8fsQjxTrnfMl6v8f1ksVDqu46xX/R7K17Q
        pRcIVcBwIpN2ihaGERmMvRMU6dq/NDRMk76IhhU=
X-Google-Smtp-Source: ABdhPJx/RcW+y2WvwGcMF0wC/teVQQTnPsgf9xs9O1h4rd77j2jN6tnHp3LKP83pVEYnZhrmX807cbZ+GiNOOlv/0k8=
X-Received: by 2002:aa7:d699:: with SMTP id d25mr18608691edr.107.1620215637385;
 Wed, 05 May 2021 04:53:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210505091928.22010-1-jslaby@suse.cz> <20210505091928.22010-23-jslaby@suse.cz>
In-Reply-To: <20210505091928.22010-23-jslaby@suse.cz>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Wed, 5 May 2021 04:53:46 -0700
Message-ID: <CAMo8BfLHEZqY_+pO4EYOJ6Acc_hFKDvuC7k_9ZPF8uMkm4tvWw@mail.gmail.com>
Subject: Re: [PATCH 22/35] tty: make tty_operations::write_room return uint
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>, Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Chris Zankel <chris@zankel.net>, Arnd Bergmann <arnd@arndb.de>,
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

On Wed, May 5, 2021 at 2:19 AM Jiri Slaby <jslaby@suse.cz> wrote:
>
> Line disciplines expect a positive value or zero returned from
> tty->ops->write_room (invoked by tty_write_room). So make this
> assumption explicit by using unsigned int as a return value. Both of
> tty->ops->write_room and tty_write_room.
>
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> Cc: Richard Henderson <rth@twiddle.net>
> Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
> Cc: Matt Turner <mattst88@gmail.com>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
> Cc: Helge Deller <deller@gmx.de>
> Cc: Jeff Dike <jdike@addtoit.com>
> Cc: Richard Weinberger <richard@nod.at>
> Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
> Cc: Chris Zankel <chris@zankel.net>
> Cc: Max Filippov <jcmvbkbc@gmail.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Samuel Iglesias Gonsalvez <siglesias@igalia.com>
> Cc: Jens Taprogge <jens.taprogge@taprogge.org>
> Cc: Karsten Keil <isdn@linux-pingi.de>
> Cc: Scott Branden <scott.branden@broadcom.com>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Heiko Carstens <hca@linux.ibm.com>
> Cc: Vasily Gorbik <gor@linux.ibm.com>
> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
> Cc: David Lin <dtwlin@gmail.com>
> Cc: Johan Hovold <johan@kernel.org>
> Cc: Alex Elder <elder@kernel.org>
> Cc: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> Cc: Jiri Kosina <jikos@kernel.org>
> Cc: David Sterba <dsterba@suse.com>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Oliver Neukum <oneukum@suse.com>
> Cc: Felipe Balbi <balbi@kernel.org>
> Cc: Mathias Nyman <mathias.nyman@intel.com>
> Cc: Marcel Holtmann <marcel@holtmann.org>
> Cc: Johan Hedberg <johan.hedberg@gmail.com>
> Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
> ---
>  arch/alpha/kernel/srmcons.c            | 2 +-
>  arch/m68k/emu/nfcon.c                  | 2 +-
>  arch/parisc/kernel/pdc_cons.c          | 2 +-
>  arch/um/drivers/line.c                 | 6 +++---
>  arch/um/drivers/line.h                 | 2 +-
>  arch/xtensa/platforms/iss/console.c    | 2 +-
>  drivers/char/pcmcia/synclink_cs.c      | 2 +-
>  drivers/char/ttyprintk.c               | 2 +-
>  drivers/ipack/devices/ipoctal.c        | 2 +-
>  drivers/isdn/capi/capi.c               | 6 +++---
>  drivers/misc/bcm-vk/bcm_vk_tty.c       | 2 +-
>  drivers/mmc/core/sdio_uart.c           | 2 +-
>  drivers/net/usb/hso.c                  | 4 ++--
>  drivers/s390/char/con3215.c            | 2 +-
>  drivers/s390/char/sclp_tty.c           | 4 ++--
>  drivers/s390/char/sclp_vt220.c         | 4 ++--
>  drivers/s390/char/tty3270.c            | 2 +-
>  drivers/staging/fwserial/fwserial.c    | 6 +++---
>  drivers/staging/gdm724x/gdm_tty.c      | 2 +-
>  drivers/staging/greybus/uart.c         | 2 +-
>  drivers/tty/amiserial.c                | 2 +-
>  drivers/tty/ehv_bytechan.c             | 4 ++--
>  drivers/tty/goldfish.c                 | 2 +-
>  drivers/tty/hvc/hvc_console.c          | 2 +-
>  drivers/tty/hvc/hvcs.c                 | 2 +-
>  drivers/tty/hvc/hvsi.c                 | 4 ++--
>  drivers/tty/ipwireless/tty.c           | 2 +-
>  drivers/tty/mips_ejtag_fdc.c           | 4 ++--
>  drivers/tty/moxa.c                     | 8 ++++----
>  drivers/tty/mxser.c                    | 2 +-
>  drivers/tty/n_gsm.c                    | 2 +-
>  drivers/tty/nozomi.c                   | 4 ++--
>  drivers/tty/pty.c                      | 2 +-
>  drivers/tty/serial/kgdb_nmi.c          | 2 +-
>  drivers/tty/serial/serial_core.c       | 4 ++--
>  drivers/tty/synclink_gt.c              | 6 +++---
>  drivers/tty/tty_ioctl.c                | 2 +-
>  drivers/tty/ttynull.c                  | 2 +-
>  drivers/tty/vcc.c                      | 4 ++--
>  drivers/tty/vt/vt.c                    | 2 +-
>  drivers/usb/class/cdc-acm.c            | 2 +-
>  drivers/usb/gadget/function/u_serial.c | 6 +++---
>  drivers/usb/host/xhci-dbgtty.c         | 4 ++--
>  drivers/usb/serial/usb-serial.c        | 2 +-
>  include/linux/tty.h                    | 2 +-
>  include/linux/tty_driver.h             | 4 ++--
>  net/bluetooth/rfcomm/tty.c             | 2 +-
>  47 files changed, 71 insertions(+), 71 deletions(-)

Acked-by: Max Filippov <jcmvbkbc@gmail.com> # xtensa

-- 
Thanks.
-- Max
