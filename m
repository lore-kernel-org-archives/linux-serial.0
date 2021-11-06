Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FC30C433F5
	for <linux-serial@archiver.kernel.org>; Sat,  6 Nov 2021 20:44:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18C25610FD
	for <linux-serial@archiver.kernel.org>; Sat,  6 Nov 2021 20:44:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230393AbhKFUrb (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 6 Nov 2021 16:47:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbhKFUrb (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 6 Nov 2021 16:47:31 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC0B2C061570;
        Sat,  6 Nov 2021 13:44:49 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id u2so20599424oiu.12;
        Sat, 06 Nov 2021 13:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5Wwu2M5WHYhPnMcLZDitxKTSUEf/rrDMMpK5D1XcgpI=;
        b=cxbc3sMI0xx6mOTKwBeoMKC5ALke1qGT8oAIHsPtlchEo3etwwXzdEKWR4+AEomfRj
         Ja37C5fwTUPWjpdG2bS8dj/GXbx7Ym2FFqk8txP3EdcgxnZgT+a5yuO9SIxsVLET5FUb
         5vgFRkhYAdMiJa7u9AfC0KsHx694cA26/BFuy5kZ48/2b2oyMIOQCYOf9sOTlDSYN5Fz
         bxh+r6EYXZw0X58SE97VqbmYqUovJr6Da7QVpvUSrt0svJGHMxCwkol596rcJdF0mBxh
         JMoDhiI3BzpllFk5MuadzlJlc4ARNmnMV9qvi8QqtDshfg/oq2FhA7zO0mmIDj7TSe4x
         rKqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5Wwu2M5WHYhPnMcLZDitxKTSUEf/rrDMMpK5D1XcgpI=;
        b=LJjTwHbfttJ58x8NW+lMtKJTPCy48LJuveREx7UEO9Jssfvlhe6Vczbt32RG60j9cH
         muUbuXs8cXk0ksTnylAC8KDA5ANbRAP8a+9UxOgMy822IZOf9gwZ92iAkxZZCPt4Qux9
         JzAIPpX1PA+FixmUCxqrB2YElkxjdkPT2/SNJylPu0YkTI0EurcZwWclJjSvp+Tc83Jt
         ieK9R7tJJc15cDiNpbBxZ5Nj7zGeFN5zKfHBhJUVGvy25bJOiv6d9ic6JAJ3ihlgJeIG
         JF/40ZrFsklnrW041+Z5JCzH6qfLKNYG0+e6A9fIcgJvVHCRyAaijcUzu/V2/inyolGT
         /msA==
X-Gm-Message-State: AOAM531gFkDl4GuLBkIUz10iOXK2WLtUamRvTUOxvn/5EZlSL0dOw9xx
        mWu3MDxyDCwDw9NFtzcRJkn6tPIX3J+9sZQYESY=
X-Google-Smtp-Source: ABdhPJy3MjSjOwvjLWHAZqZEWoiRqN9S/Iy8FIWcObZNfHtu7u8HAUPyiZZtyOPuL1GThL7OQHygczfUWT25FBbe04E=
X-Received: by 2002:a05:6808:2108:: with SMTP id r8mr14746685oiw.118.1636231488597;
 Sat, 06 Nov 2021 13:44:48 -0700 (PDT)
MIME-Version: 1.0
References: <20211106092041.43745-1-ajaygargnsit@gmail.com>
 <9eafae1f-d9f0-298d-cf20-212865d0becc@gmail.com> <868025b485b94480ad17d0ec971b3ee9@AcuMS.aculab.com>
 <CAHP4M8Ww0-VqCBKX=iLd=zy1AcDoNdzTOqJuaqRxCGZsMhoX9w@mail.gmail.com>
 <CAHP4M8UcZ=ttB8jbN1yOY6YH8SiQ27NhdEKi9SDH1CWG-GY6eg@mail.gmail.com>
 <6b58a3e1-f2ea-cc4c-03b2-06334b559373@gmail.com> <CAHP4M8Vs8a8u98enuHXaBcC7D4fCZzCOtEq06VnvuPUqhqPK=Q@mail.gmail.com>
 <9717b429-597f-7778-c880-94361bcdee7f@gmail.com>
In-Reply-To: <9717b429-597f-7778-c880-94361bcdee7f@gmail.com>
From:   Ajay Garg <ajaygargnsit@gmail.com>
Date:   Sun, 7 Nov 2021 02:14:36 +0530
Message-ID: <CAHP4M8XtFiAa1kF5A_rPbcui3DP8L6iyfP8GbwgLLzo0Bo+TNQ@mail.gmail.com>
Subject: Re: [PATCH] tty: vt: keyboard: do not copy an extra-byte in copy_to_user
To:     Pavel Skripkin <paskripkin@gmail.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>, jirislaby@kernel.org,
        kernel@esmil.dk, David Laight <David.Laight@aculab.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

> >
> > That's the whole point of the discussion :)
> >
> > The method "vt_do_kdgkb_ioctl" does not manage "func_table[kb_func]".
> > Thus, the method does not know whether or not
> > strlen(func_table[kb_func]) < sizeof(user_kdgkb->kb_string).
> >
>
> It manages. The code under `case KDSKBSENT:` sets func_table[] entries
> via vt_kdskbsent().
>
> kbs = strndup_user(..., sizeof(user_kdgkb->kb_string));
>
> is used to allocate buffer for the func_table[] entry. That's my main
> point :)

func_table is set in vt_kdskbent, which itself is external.

More importantly, vt_kdskbent is handled in case KDSKBSENT:, while the
strlcpy issue we are dealing with is in case KDGKBSENT:
In case KDGKBSENT, following are managed :

                ssize_t len = sizeof(user_kdgkb->kb_string);
                kbs = kmalloc(len, GFP_KERNEL);

while func_table[kb_func] is external entity here, so no assumption
ought to be made for it, just my 2 cents though :)

Anyhow, really, it is the maintainers' choice now :), since there
isn't a burning (compilation/runtime) issue.

>
>
>
>
> With regards,
> Pavel Skripkin
