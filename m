Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4281EC433EF
	for <linux-serial@archiver.kernel.org>; Sat,  6 Nov 2021 10:44:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 194806124F
	for <linux-serial@archiver.kernel.org>; Sat,  6 Nov 2021 10:44:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232324AbhKFKqm (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 6 Nov 2021 06:46:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbhKFKql (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 6 Nov 2021 06:46:41 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDFB3C061570;
        Sat,  6 Nov 2021 03:44:00 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id s7-20020a056830148700b0055ad72acb7eso16015254otq.1;
        Sat, 06 Nov 2021 03:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fhzaPm3bgTZfozjWVQ50J/S1nHkYDmmZ/qd6Wk0wRtg=;
        b=FLeQ0CbzW2bv7jNqkArpjNg6/kFn2DMO2VhrIEmic4nRtzLUf29R9zgETt6o8gm+fA
         XTlgivF+yMVMjd8Fr1upxHNRamN00CN3VQGgxzinjfWlc0y5TrKAe2vipC1crMdxwQdd
         Xbha84/InPA6RbvX9G5UF104+PIEwj2PIjR2/QcGJRu8cDb4L5tJ41I0wPmm+6BgctOB
         ImJC4UIz59ph5E+BAI0BMO4Th1bwetUqEzNQHMBpzcjKT/Svg3F7FqMbayPuY8p+HAs6
         YuuOJ0pgTe41kwAi3qgwd1EuZDHQDTE1tZJuSuuxdhiDEpSGJABwsCHxPoOxj8CftFS0
         ck4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fhzaPm3bgTZfozjWVQ50J/S1nHkYDmmZ/qd6Wk0wRtg=;
        b=F5ou4rjIKaADybqSG2peO1+3GP/HCfKr1SDWhR6xt+WGS+xDIQ92AUsOe5i7Zc+JT2
         RDzbQEqD2o5vz5Agp+43rIjdLcRF7+q79mgL7NEhPPAzv3988fQTt1rHs0qtNKHcYLsR
         V03YZPBmpyPx/i40Sw7HdzL9aMfmI7WUaCyjl4XYRFBmmPpBaoBanYqGsGAfrdwj8puS
         eOfYiNMVZOE5Quvao2AdbEqd8cVDtwcplfRpKBNF5WOKR+dUjMXQt4OoLgipUDnfOBfR
         b5LWhAXdlHIl2OQbwqChono54MjtPdHSnoO3S8pml4rG0R4NQL882CD4wwYZwEs9bPrH
         CO+Q==
X-Gm-Message-State: AOAM530TMYvpcoOj+8MO15HG0FrvvQ6cH6mNhu6kJ7kjrzaqcLjHO3qw
        6Awa3E2fgx9PFccynLhwbHaABJyyzKZnOXWrd4/vJnBEWA4=
X-Google-Smtp-Source: ABdhPJyA52s9mHtRot3rHns/Bq66A3ZQz+1pSXKbOKfKBXPsMWbaeT1QI+8h6vwDvBiZBkry7vIf6Y31ixB7dSHYJQg=
X-Received: by 2002:a9d:20c7:: with SMTP id x65mr12753848ota.173.1636195440360;
 Sat, 06 Nov 2021 03:44:00 -0700 (PDT)
MIME-Version: 1.0
References: <20211106093202.44518-1-ajaygargnsit@gmail.com> <YYZN30qfaKMskVwE@kroah.com>
In-Reply-To: <YYZN30qfaKMskVwE@kroah.com>
From:   Ajay Garg <ajaygargnsit@gmail.com>
Date:   Sat, 6 Nov 2021 16:13:48 +0530
Message-ID: <CAHP4M8XW3NBvR7XFv6TogCd_eR=wMTyTQs0HToFk0p4Oj6NkQQ@mail.gmail.com>
Subject: Re: [PATCH] tty: vt: keyboard: Free dynamic-memory only if kmalloc'ed.
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Thanks, will ensure that I run scripts/checkpatch.pl before posting
any patch from now on.

The v2 patch is posted at :
https://lore.kernel.org/linux-serial/20211106104053.98761-1-ajaygargnsit@gmail.com/T/#u

On Sat, Nov 6, 2021 at 3:11 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Sat, Nov 06, 2021 at 03:02:02PM +0530, Ajay Garg wrote:
> > In "vt_do_kdgkb_ioctl", kbs is kmalloced, if cmd is one of
> > KDGKBSENT or KDGSKBSENT.
> >
> > If cmd is none of the above, no kbs is kmalloced, and thus,
> > kbs must only be kfreed if it is really kmalloced.
> >
> > Signed-off-by: Ajay Garg <ajaygargnsit@gmail.com>
> > ---
> >  drivers/tty/vt/keyboard.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
> > index dfef7de8a057..95839987c79c 100644
> > --- a/drivers/tty/vt/keyboard.c
> > +++ b/drivers/tty/vt/keyboard.c
> > @@ -2049,7 +2049,7 @@ int vt_do_kdgkb_ioctl(int cmd, struct kbsentry __user *user_kdgkb, int perm)
> >  {
> >       unsigned char kb_func;
> >       unsigned long flags;
> > -     char *kbs;
> > +     char *kbs = NULL;
> >       int ret;
> >
> >       if (get_user(kb_func, &user_kdgkb->kb_func))
> > @@ -2092,7 +2092,8 @@ int vt_do_kdgkb_ioctl(int cmd, struct kbsentry __user *user_kdgkb, int perm)
> >               break;
> >       }
> >
> > -     kfree(kbs);
> > +        if(kbs)
> > +            kfree(kbs);
> >
> >       return ret;
> >  }
> > --
> > 2.30.2
> >
>
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
> - Your patch contains warnings and/or errors noticed by the
>   scripts/checkpatch.pl tool.
>
> If you wish to discuss this problem further, or you have questions about
> how to resolve this issue, please feel free to respond to this email and
> Greg will reply once he has dug out from the pending patches received
> from other developers.
>
> thanks,
>
> greg k-h's patch email bot
