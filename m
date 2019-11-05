Return-Path: <SRS0=mTc+=Y5=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 921CBCA9EDB
	for <linux-serial@archiver.kernel.org>; Tue,  5 Nov 2019 08:43:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C6C720717
	for <linux-serial@archiver.kernel.org>; Tue,  5 Nov 2019 08:43:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729597AbfKEInB (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 5 Nov 2019 03:43:01 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:36091 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727401AbfKEInA (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 5 Nov 2019 03:43:00 -0500
Received: by mail-ot1-f65.google.com with SMTP id s3so9347031otk.3
        for <linux-serial@vger.kernel.org>; Tue, 05 Nov 2019 00:43:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p+JwvCyNQZrexeHFulYuJg58ql4mf+z4stztGAEpABo=;
        b=GsFWq3kdKteXntWjlSbgOgMh3j0/RSym80/OVWBiCWPV8ODtjn5ifZLEy+h2uLsm1n
         fOgqSTeXOyVn2+rJCatYsIvHCPtxElCvbAU9xzvxT9zuhOHXTudLDJPcX3DKOh5jSIcS
         q520GZlCdERgfebwozgWQrzVIa9pQjOomzBef3Z0TmkdHhqSchjoWuEOYQxptPb3D+uz
         qginQLGg5YuF5irkU9Sn7/VyGvm4HiOcDKXopIVnMY16w6xhhseeZK7SoLw9VKvRVxLv
         wZd0ZOZ2D2XGaHywHIkWGJLgScVL1Gss4zR4QQBInXdQ9d8FExq3wSCR9wBsqJtVSiR0
         s7GQ==
X-Gm-Message-State: APjAAAV36JoUBvtMaOjgNwVZsxtM3uxj/2lr2nlvIZ3V93/SvfWWhbW0
        dWz57fJBzFjtPOZkvFyS4h5skqdLaJLrGho5rwc=
X-Google-Smtp-Source: APXvYqx+5QomUWgGs2WmEELvfhS1StbN2l8NrgFKZfoPwalXqUzMRzoyNCmHigrVRNN30YlWOzUuBDvJWTgJHKx2MHg=
X-Received: by 2002:a9d:191e:: with SMTP id j30mr12253029ota.297.1572943380002;
 Tue, 05 Nov 2019 00:43:00 -0800 (PST)
MIME-Version: 1.0
References: <20191004132256.GA715053@kroah.com> <20191104193525.229055-1-pterjan@google.com>
In-Reply-To: <20191104193525.229055-1-pterjan@google.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 5 Nov 2019 09:42:49 +0100
Message-ID: <CAMuHMdUm+s4UaBrtxvXaLg1EUmsoYYG=6JvnWzC0ivbyzdMBZw@mail.gmail.com>
Subject: Re: [PATCH v3] Remove every trace of SERIAL_MAGIC
To:     Pascal Terjan <pterjan@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Pascal,

On Mon, Nov 4, 2019 at 8:35 PM Pascal Terjan <pterjan@google.com> wrote:
> This means removing support for some debugging code in amiserial.c
> (SERIAL_PARANOIA_CHECK option), which was checking a magic field which
> doesn't currently exist in the struct. That code hasn't built at least
> since git.
>
> Removing the definition from the header is safe anyway as that code was
> from another driver and not including it.
>
> Signed-off-by: Pascal Terjan <pterjan@google.com>

Thanks for your patch!

> --- a/drivers/tty/amiserial.c
> +++ b/drivers/tty/amiserial.c
> @@ -23,17 +23,12 @@
>   */
>
>  /*
> - * Serial driver configuration section.  Here are the various options:
> + * Serial driver configuration section.
>   *
> - * SERIAL_PARANOIA_CHECK
> - *             Check the magic number for the async_structure where
> - *             ever possible.
>   */

You might as well drop the whole comment block, as no options are left.

With that fixed:
Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

BTW, there's a similar serial_paranoia_check() in drivers/tty/cyclades.c,
which is active, but doesn't serve much purpose, IMHO.

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
