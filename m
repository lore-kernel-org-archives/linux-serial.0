Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BBCAC433F5
	for <linux-serial@archiver.kernel.org>; Mon,  8 Nov 2021 13:55:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E80260F45
	for <linux-serial@archiver.kernel.org>; Mon,  8 Nov 2021 13:55:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237872AbhKHN54 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 8 Nov 2021 08:57:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235081AbhKHN54 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 8 Nov 2021 08:57:56 -0500
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34D7BC061570;
        Mon,  8 Nov 2021 05:55:12 -0800 (PST)
Received: by mail-ot1-x330.google.com with SMTP id h12-20020a056830034c00b0055c8458126fso6677169ote.0;
        Mon, 08 Nov 2021 05:55:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gpD7XLy67GmEYeF6kcGI7Hoo0E9KOuNIu7Ojh9xwPrw=;
        b=eZuFawv36tzgdU6vsIaWRVu5rbXLz8O9eSWBPrgAmn7z68oltCln0+mXChCK/0Nhki
         0qa3+I4d75PliCBoQ0u0ShDUe6Iipr5qWIGK/38nwplDheAjk8LZw2gwEkj/78t01pI0
         VJfMF7gV4qW9zVRINc9oHlFHmT0JYnop8OZ42gVylsY4T83M/8Ecrlhcr22JzZS2bmCy
         w0Fea8IcHYS4Ro47f5iTP1wVT2FD6bnY4VbH2w5AhFBJDojw845JJgCFF2nohAxHlKgu
         1UoYvAdXpBY3bNXg9cKMVYWG8BErud5CLYYanDX980/ylpfIxx/M01cnoRAYGYtEkS4W
         pGOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gpD7XLy67GmEYeF6kcGI7Hoo0E9KOuNIu7Ojh9xwPrw=;
        b=xofvY8HowoycdgLdz8DAI3XtfPY81OlqiNfKmjkUQzbmmUCHS39fZydnpSfePUIUvq
         4sdmsS7OLyaw3gD7Mpvyh5MzFxbuizwRcxblwpDfdV4UMxtHirKcMqXkuPc/bpkIJvSF
         M1RtaLzYw1mEE0pCwuWNEps2LnM6NuxnC4iYZ6xaE+lxA+XYFg5WGmmsU6NI+JZuiEAu
         0oAP1J4XHsp2XbRdoP9bZfgkRtKf+1UC4kvRXik/n3T3lhW22e5vSorfV+Tm0jJ2iHCx
         Za+M4FdHakm02H2/6ZR6r6ylrDiFE6CwrYrBm2Nn7J4yzkli8Jv9VVJzzM8US151xTrc
         lhog==
X-Gm-Message-State: AOAM530zjKLu4jhYeVN9vUF+3sHuPqD9xg2JreHV01kYmwZVWyH5xE6O
        CQ6uyFaANwWm/rfcSU8jXMYs7z6k1H3pmxyPuiM9ELwJ39E=
X-Google-Smtp-Source: ABdhPJwshlO+RhI7cD/LhW63ScFM5ikSifoSqRTAblhaHZIkiWAOn1O9uVuaA6M/GmIksczuDm6yhDhuIBFKfO+tT5k=
X-Received: by 2002:a05:6830:2647:: with SMTP id f7mr45093866otu.162.1636379711534;
 Mon, 08 Nov 2021 05:55:11 -0800 (PST)
MIME-Version: 1.0
References: <20211108134901.7449-1-ajaygargnsit@gmail.com> <YYkroa2v1ruwPRBN@kroah.com>
In-Reply-To: <YYkroa2v1ruwPRBN@kroah.com>
From:   Ajay Garg <ajaygargnsit@gmail.com>
Date:   Mon, 8 Nov 2021 19:24:59 +0530
Message-ID: <CAHP4M8WLaWa769hDJBWVwL7P7hadoTk+CE1sVba3tRVxpMRVtw@mail.gmail.com>
Subject: Re: [PATCH v5] vt: keyboard: suppress warnings in vt_do_kdgkb_ioctl
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     jirislaby@kernel.org, andriy.shevchenko@linux.intel.com,
        kernel@esmil.dk, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, paskripkin@gmail.com,
        johan@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hmm, I am afraid I don't understand. The patch changes only 5 lines.
Could someone help me navigate what to "fix"?


Thanks and Regards,
Ajay

On Mon, Nov 8, 2021 at 7:22 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Mon, Nov 08, 2021 at 07:19:01PM +0530, Ajay Garg wrote:
> > smatch-kchecker gives the following warnings when run on keyboard.c :
> >
> > vt_do_kdgkb_ioctl() error: uninitialized symbol 'kbs'.
> > vt_do_kdgkb_ioctl() error: uninitialized symbol 'ret'.
> >
> > i)
> > The 'kbs" warning was introduced by "07edff926520" :
> > ("vt: keyboard, reorder user buffer handling in vt_do_kdgkb_ioctl")
> >
> > *
> > prior 07edff926520, the scope of kbs (allocation/deallocation) was
> > external to switch-cases.
> >
> > *
> > post 07edff926520, kbs is allocated internally for each case, however the
> > deallocation remains external.
> >
> > Thus, as the "fix", the scope of kbs deallocation is now made internal
> > to each switch case.
> >
> > ii)
> > The 'ret' warning is the result of "4e1404a5cd04" :
> > ("vt: keyboard, extract and simplify vt_kdskbsent")
> >
> > where the "ret = 0" (right at the end) was accidentally removed.
> >
> > Bringing back the above in a slightly different way, by initializing ret
> > to 0 at the start.
> >
> > Many thanks to the following for review of previous versions :
> >
> >       * Pavel Skripkin <paskripkin@gmail.com>
> >       * Andy Shevchenko <andy.shevchenko@gmail.com>
> >       * Johan Hovold <johan@kernel.org>
> >
> > Signed-off-by: Ajay Garg <ajaygargnsit@gmail.com>
> > ---
> >
> > There were discussions previously, and the current patch is the
> > result.
> >
> > v1 :
> > https://lore.kernel.org/linux-serial/YYZN30qfaKMskVwE@kroah.com/T/#t
> >
> > v2 :
> > https://lore.kernel.org/linux-serial/CAHP4M8Vdj4Eb8q773BeHvsW9n6t=3n1WznuXAR4fZCNi1J6rOg@mail.gmail.com/T/#m18f45676feaba6b1f01ddd5fe607997b190ef4b9
> >
> > v3 :
> > https://lore.kernel.org/linux-serial/20211106220315.392842-1-ajaygargnsit@gmail.com/T/#u
> >
> > v4 :
> > https://lore.kernel.org/linux-serial/YYjw2mRIhy1SoIb+@hovoldconsulting.com/T/#mf25ca00a93e278bbb8f0382a4f7752dc35f4aa8b
> >
> > Changes in v2 :
> >
> >         * Changes as required by scripts/checkpatch.pl
> >
> >         * Checking whether kbs is not NULL before kfree is not required,
> >           as kfree(NULL) is safe. So, dropped the check.
> >
> > Changes in v3 :
> >
> >         * Using default-switch case, and setting the variables
> >           when there is no matching cmd.
> >
> > Changes in v4 :
> >
> >         * Removed braces for the default switch-case.
> >
> > Changes in v5 :
> >
> >         * Incorporating changes as suggested by Johan Hovold
> >         (please see v4 link).
> >
> >  drivers/tty/vt/keyboard.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
> > index c7fbbcdcc346..ea19671d5d0c 100644
> > --- a/drivers/tty/vt/keyboard.c
> > +++ b/drivers/tty/vt/keyboard.c
> > @@ -2050,7 +2050,7 @@ int vt_do_kdgkb_ioctl(int cmd, struct kbsentry __user *user_kdgkb, int perm)
> >       unsigned char kb_func;
> >       unsigned long flags;
> >       char *kbs;
> > -     int ret;
> > +     int ret = 0;
> >
> >       if (get_user(kb_func, &user_kdgkb->kb_func))
> >               return -EFAULT;
> > @@ -2073,6 +2073,7 @@ int vt_do_kdgkb_ioctl(int cmd, struct kbsentry __user *user_kdgkb, int perm)
> >               ret = copy_to_user(user_kdgkb->kb_string, kbs, len + 1) ?
> >                       -EFAULT : 0;
> >
> > +             kfree(kbs);
> >               break;
> >       }
> >       case KDSKBSENT:
> > @@ -2088,11 +2089,11 @@ int vt_do_kdgkb_ioctl(int cmd, struct kbsentry __user *user_kdgkb, int perm)
> >               kbs = vt_kdskbsent(kbs, kb_func);
> >               spin_unlock_irqrestore(&func_buf_lock, flags);
> >
> > +             kfree(kbs);
> >               ret = 0;
> >               break;
> >       }
> >
> > -     kfree(kbs);
> >
> >       return ret;
> >  }
> > --
> > 2.30.2
> >
>
> Hi,
>
> This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
> a patch that has triggered this response.  He used to manually respond
> to these common problems, but in order to save his sanity (he kept
> writing the same thing over and over, yet to different people), I was
> created.  Hopefully you will not take offence and will fix the problem
> in your patch and resubmit it so that it can be accepted into the Linux
> kernel tree.
>
> You are receiving this message because of the following common error(s)
> as indicated below:
>
> - Your patch did many different things all at once, making it difficult
>   to review.  All Linux kernel patches need to only do one thing at a
>   time.  If you need to do multiple things (such as clean up all coding
>   style issues in a file/driver), do it in a sequence of patches, each
>   one doing only one thing.  This will make it easier to review the
>   patches to ensure that they are correct, and to help alleviate any
>   merge issues that larger patches can cause.
>
> If you wish to discuss this problem further, or you have questions about
> how to resolve this issue, please feel free to respond to this email and
> Greg will reply once he has dug out from the pending patches received
> from other developers.
>
> thanks,
>
> greg k-h's patch email bot
