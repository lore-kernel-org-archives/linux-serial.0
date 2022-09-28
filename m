Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECA03C04A95
	for <linux-serial@archiver.kernel.org>; Wed, 28 Sep 2022 23:33:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233644AbiI1XdK (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 28 Sep 2022 19:33:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233614AbiI1XdI (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 28 Sep 2022 19:33:08 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16ED9B40CE
        for <linux-serial@vger.kernel.org>; Wed, 28 Sep 2022 16:33:07 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id bj12so30130396ejb.13
        for <linux-serial@vger.kernel.org>; Wed, 28 Sep 2022 16:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=q74yArMABpzeLkr74sIBfXXMxk7/EMgQ3hoGRYitxYU=;
        b=U0Q8SQFHSkScbj4cM4pTg7Yzb04zm5WgomM/5gs7MQUTxOnAoEjVy5BjCW7Lo5/BUi
         xVGQd3n/TGijftlrmbedS+TIFC4PIQ4GVxgHSTo1Hxqh7rav4zS5xPPOiO0U6zV/NMl4
         5n8EmZnC9tTRHnX8rS/uqie8PD5M0KehiVHl4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=q74yArMABpzeLkr74sIBfXXMxk7/EMgQ3hoGRYitxYU=;
        b=Y4dl8zrvUate1OSxQUrW7Bf05S8QgkZfzB/0rRUjBk2vGHV0QH4wSHH17fBUMBrYF0
         3KVIjwIPtXeVCFMC+JllJtPm6RB6MgRCH/NuVw7STyCpjNacwUfzjDDMT16lV23j9iHW
         4ze8LoFsW9uOpNY8uYWvV1lqYRduiOlo1ij2sc6H5ssgfKS5LegodJNUT1FhfzgUIMgJ
         RNCKC+QKMZ5iLmIrcQkkcTPPPBpaLG6xKDnphNfDH2MgjcZtPWXs78gDUdu0G7hmR9TX
         78fnB8xzaToiO6raKeDczoYDmqIrO7ODu9I5xvcIPzypRqhLz/D2TJTnqKaX91VrZmh0
         IqpA==
X-Gm-Message-State: ACrzQf0iiDs36hCae//kg6E8sr37wgL0pRebcvrEGSlgO0XpMcu0rOC5
        /Z5fLX9FlIYiqWSajTyHViLsH8feAGdRDt5R
X-Google-Smtp-Source: AMsMyM6EifXEJ+KEa5dm9BB/FSRnOaxLEI6xuhsOxPNrcVN4rwzR9/Y6UJnoutqHIftGQUypn5vm6g==
X-Received: by 2002:a17:907:a425:b0:783:b550:d99d with SMTP id sg37-20020a170907a42500b00783b550d99dmr289469ejc.17.1664407985326;
        Wed, 28 Sep 2022 16:33:05 -0700 (PDT)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com. [209.85.221.51])
        by smtp.gmail.com with ESMTPSA id u24-20020a056402065800b004571907240asm4197586edx.36.2022.09.28.16.33.03
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Sep 2022 16:33:04 -0700 (PDT)
Received: by mail-wr1-f51.google.com with SMTP id bk15so14252183wrb.13
        for <linux-serial@vger.kernel.org>; Wed, 28 Sep 2022 16:33:03 -0700 (PDT)
X-Received: by 2002:a5d:522f:0:b0:228:dc7f:b9a8 with SMTP id
 i15-20020a5d522f000000b00228dc7fb9a8mr145687wra.617.1664407983299; Wed, 28
 Sep 2022 16:33:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220924000454.3319186-1-john.ogness@linutronix.de> <20220924000454.3319186-10-john.ogness@linutronix.de>
In-Reply-To: <20220924000454.3319186-10-john.ogness@linutronix.de>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 28 Sep 2022 16:32:51 -0700
X-Gmail-Original-Message-ID: <CAD=FV=W5mnR6MH+KLK9VgUCvY0rsjkMdR7un=pHmtNBBup7w7g@mail.gmail.com>
Message-ID: <CAD=FV=W5mnR6MH+KLK9VgUCvY0rsjkMdR7un=pHmtNBBup7w7g@mail.gmail.com>
Subject: Re: [PATCH printk 09/18] serial: kgdboc: Lock console list in probe function
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
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

On Fri, Sep 23, 2022 at 5:05 PM John Ogness <john.ogness@linutronix.de> wrote:
>
> From: Thomas Gleixner <tglx@linutronix.de>
>
> Unprotected list walks are not necessarily safe.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> ---
>  drivers/tty/serial/kgdboc.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/tty/serial/kgdboc.c b/drivers/tty/serial/kgdboc.c
> index 79b7db8580e0..af2aa76bae15 100644
> --- a/drivers/tty/serial/kgdboc.c
> +++ b/drivers/tty/serial/kgdboc.c
> @@ -193,7 +193,8 @@ static int configure_kgdboc(void)
>         if (!p)
>                 goto noconfig;
>
> -       for_each_console(cons) {
> +       console_list_lock();
> +       for_each_registered_console(cons) {
>                 int idx;
>                 if (cons->device && cons->device(cons, &idx) == p &&
>                     idx == tty_line) {
> @@ -201,6 +202,7 @@ static int configure_kgdboc(void)
>                         break;
>                 }
>         }
> +       console_list_unlock();

Seems right to me, thanks!

Reviewed-by: Douglas Anderson <dianders@chromium.org>
