Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84969C6FA8E
	for <linux-serial@archiver.kernel.org>; Thu,  2 Mar 2023 17:20:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbjCBRUv (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 2 Mar 2023 12:20:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbjCBRUt (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 2 Mar 2023 12:20:49 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71F79521CF
        for <linux-serial@vger.kernel.org>; Thu,  2 Mar 2023 09:20:39 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id q31-20020a17090a17a200b0023750b69614so3460360pja.5
        for <linux-serial@vger.kernel.org>; Thu, 02 Mar 2023 09:20:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1677777639;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JZZeb/QJtCSWsDPCLiUjqJbjxkXpQiEZdAtSmYc8Bm0=;
        b=F5D5X5uqvBtMhYF3w0Xr/uf2zrz8OvToHEahoAyBcnfo0v6iGALUHqsmaT6kmaE74a
         5t1zBfvSarlwKA3mKghkbo/0BwZZyL6FtjGi1l9vR4+KpL0o2NqnwxPpEgijIByJ1hUV
         1sAITfv8KOmNpILbtegMQR2c/ocOtQO8hwPZBY4w37lxL3khmtf9VONQCsnouuy7C/VI
         VcF/rfl7oj6/yUFEaNtQKlJznD36okdLVsBzwK/8XOtpQGmQyzKyX5iODXjcZTP++2lk
         S+i1n2mOEEvX9rd9ljYXrWwTgUPYKpXtrKun0GaJ+rZQLVtsb0UljgyI6uoO/rJ2XExM
         UzBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677777639;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JZZeb/QJtCSWsDPCLiUjqJbjxkXpQiEZdAtSmYc8Bm0=;
        b=sGS/iddTf0eOoG01uPX019F1gFIV+btIfCgrabv2uh2juBArNn1n/bYvGuRpYyBklh
         IHO2+kwXXFqCJdj/EVQagtlIhAhYyRaob2NsloGlGiXrfY6oZv3eLBs0/uih5IZHFBtA
         QhwnHDOKXawztVLDdpHhafDQ+9f6BB4rMEU2D3YiuOHa0kl32t3tBxJIf8j37sdpGtNA
         /IpWAn+L0NqKnQ0f3ELuELE5TlEbIsKO6eGtqh7rEs5vWFB3JqQTSU7KZmZk5/qtpexO
         PTBMo1ytgaKUjsEr4S77SVpNTlIUnXoEwekydCSlgzRk3q306v7r4QeaiZAIdfFyuBhK
         Dkew==
X-Gm-Message-State: AO0yUKWtiDEypqT8o0hNcGgXZjLvVdI8WqtLwnuklGAEq102wh+oDqbl
        Hjcw+Zr/dwfDY1HhLk3hVYwEd4c895oQgWvB+2bdt6gTBq0iPqMl
X-Google-Smtp-Source: AK7set97Rr+Ogo+c7nqW57rLngpeC8lkirhCru4aKSVzp4ByNq1tdKKif5KRaOOWIBExwe8NZy4u77pTF13CxW6w6HU=
X-Received: by 2002:a17:902:efce:b0:19a:fdca:e405 with SMTP id
 ja14-20020a170902efce00b0019afdcae405mr4183974plb.10.1677777638649; Thu, 02
 Mar 2023 09:20:38 -0800 (PST)
MIME-Version: 1.0
References: <20230302023509.319903-1-saravanak@google.com> <2cc752fb-a25d-0789-0fad-54b99f08ced7@i2se.com>
In-Reply-To: <2cc752fb-a25d-0789-0fad-54b99f08ced7@i2se.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Thu, 2 Mar 2023 09:20:02 -0800
Message-ID: <CAGETcx_nCdm2WYLC7h1s8i9tnHc_LcHk2oZUQ0sUDr-PBsUWDg@mail.gmail.com>
Subject: Re: [PATCH v1] serdev: Set fwnode for serdev devices
To:     Stefan Wahren <stefan.wahren@i2se.com>
Cc:     Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        kernel-team@android.com, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Mar 2, 2023 at 9:01=E2=80=AFAM Stefan Wahren <stefan.wahren@i2se.co=
m> wrote:
>
> Hi Saravana,
>
> Am 02.03.23 um 03:35 schrieb Saravana Kannan:
> > This allow fw_devlink to do dependency tracking for serdev devices.
> >
> > Reported-by: Florian Fainelli <f.fainelli@gmail.com>
> > Link: https://lore.kernel.org/lkml/03b70a8a-0591-f28b-a567-9d2f736f17e5=
@gmail.com/
> > Cc: Stefan Wahren <stefan.wahren@i2se.com>
> > Signed-off-by: Saravana Kannan <saravanak@google.com>
>
> since this fixes an issue on Raspberry Pi 4, shouldn't this be mentioned
> in the commit message and providing a Fixes tag?

So RPi 4 was never creating a device links between serdev devices and
their consumers. The error message was just a new one I added and we
are noticing and catching the fact that serdev wasn't setting fwnode
for a device.

I'm also not sure if I can say this commit "Fixes" an issue in serdev
core because when serdev core was written, fw_devlink wasn't a thing.
Once I add Fixes, people will start pulling this into stable
branches/other trees where I don't think this should be pulled into
older stable branches.

-Saravana

>
> Thanks
> Stefan
>
> > ---
> > Florian,
> >
> > Can you give it a shot and a tested-by please?
> >
> > -Saravana
> >
> >   drivers/tty/serdev/core.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
> > index aa80de3a8194..678014253b7b 100644
> > --- a/drivers/tty/serdev/core.c
> > +++ b/drivers/tty/serdev/core.c
> > @@ -534,7 +534,7 @@ static int of_serdev_register_devices(struct serdev=
_controller *ctrl)
> >               if (!serdev)
> >                       continue;
> >
> > -             serdev->dev.of_node =3D node;
> > +             device_set_node(&serdev->dev, of_fwnode_handle(node));
> >
> >               err =3D serdev_device_add(serdev);
> >               if (err) {
