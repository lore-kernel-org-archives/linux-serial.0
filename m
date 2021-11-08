Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AE13C433EF
	for <linux-serial@archiver.kernel.org>; Mon,  8 Nov 2021 13:52:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 732FE61074
	for <linux-serial@archiver.kernel.org>; Mon,  8 Nov 2021 13:52:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236528AbhKHNyr (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 8 Nov 2021 08:54:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235081AbhKHNyq (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 8 Nov 2021 08:54:46 -0500
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D8EDC061570;
        Mon,  8 Nov 2021 05:52:02 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id u74so6478020oie.8;
        Mon, 08 Nov 2021 05:52:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S6x3SGq2T9+uPlHqILiB1mO6dm6KR4D4Uff3QjdZP+8=;
        b=K2oS3Wvamq+l7laiwJA4ATRPsoSvszYUqyvHbR+SplxYF4I29CslKR4a1kqEhSNmCn
         MjuJhdNqKY9+3cq1CntheyQnxtrWRwLn+TLKfvUDgBAQ1jilNhF/5cMZiFcpF+isQ6C5
         9MUeg+YCyPN+fl8TY3hCr/YnRhrNysm7xfwphyJwu/Q4sV+2sG2dLueHdIB69A9kFu6h
         Ilt+Ny6JrIyycKD63Nda1+x75sCEDqE/iFwBc+eNFcW+mOPmCU/hRzR5WGEuaaAB1s4h
         A7JLKbn580Slrby0K4xLrhNGVCDVIt99XTb60zyxRw9rdGO9OML7ME2Maa0+9/z18mnM
         /1Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S6x3SGq2T9+uPlHqILiB1mO6dm6KR4D4Uff3QjdZP+8=;
        b=2aZIDcmgEWsWyxJ8DKW8j2tmkFw5XEUESxrTlOKc9tloaVtXa7golum19CciRcciTf
         wJ29nx0ofQAwRfTj3lL2VT1SwhPhKkMJXhQqzFEMoiFIzi7COA6kg51U5IqXTGTxMKjB
         pIiFI0qCWPhoBuSCCkeZY4zxk9h0fd/BTujZm7ZKBwRcjRnm+tJvVzh0j8TekuZPb88p
         ia2qeQvCfvbTFPGW/R+1nXrueV+5xURYkQ/lh9aQoMr6vkGPFeb7I5zl5dhwRbnQ1jWa
         knUHGTrcYQTsm+u+nFdZeumyP3IHcH2HYOnObXsZFG7I7XdM5K5Vmh2zz2ZgKgbCLBvG
         0awg==
X-Gm-Message-State: AOAM533M3OEObwPpZvUn4h/0CuvMg6gttHp+N5oADqabP1itkBzoLm8e
        u3/kOq9TAtdt9/L3D5Wikfs3+jKx6SPl4TqBhV0=
X-Google-Smtp-Source: ABdhPJy7TbKcAo6kp6MYlICuPiXQoLkh8LBtRikmsPcsL6PTDah8RO+95uSiyNwux/96bx6mUWCjG0/kLZVKiTmrO8I=
X-Received: by 2002:a05:6808:2108:: with SMTP id r8mr45338oiw.118.1636379521787;
 Mon, 08 Nov 2021 05:52:01 -0800 (PST)
MIME-Version: 1.0
References: <20211107031721.4734-1-ajaygargnsit@gmail.com> <YYjw2mRIhy1SoIb+@hovoldconsulting.com>
In-Reply-To: <YYjw2mRIhy1SoIb+@hovoldconsulting.com>
From:   Ajay Garg <ajaygargnsit@gmail.com>
Date:   Mon, 8 Nov 2021 19:21:50 +0530
Message-ID: <CAHP4M8Va6BLY+RYPzZi=_o1M3jcxbywSHJ3FsXZkeDU2T3BphA@mail.gmail.com>
Subject: Re: [PATCH v4] tty: vt: keyboard: add default switch-case, to handle
 smatch-warnings in method vt_do_kdgkb_ioctl
To:     Johan Hovold <johan@kernel.org>
Cc:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        andriy.shevchenko@linux.intel.com, kernel@esmil.dk,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        paskripkin@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Johan,

Thanks for your time.

On Mon, Nov 8, 2021 at 3:11 PM Johan Hovold <johan@kernel.org> wrote:
>
> First, please fix your patch Subject which is way too verbose. You
> should aim at less than 72 chars including prefix. Something like
>
>         "vt: keyboard: suppress smatch warning in vt_do_kdgkb_ioctl"
>
> should do.

Thanks Johan, will keep this in mind in all my future patches.

Taking the subject as suggested by you for the current patch, after
removal of "smatch" keyword, as it otherwise produces :
WARNING: A patch subject line should describe the change not the tool
that found it
when run through checkpatch.pl



> >       kfree(kbs);
>
> Instead, move the kfree() into the two cases blocks

So, if I understand correctly,

* prior 07edff926520, the scope of kbs (allocation/deallocation) was
external to switch-cases.
* post 07edff926520, kbs is allocated internally for each case,
however the deallocation remains external.

Thanks for the much cleaner suggestion, will move kfree() into the two
cases blocks.



> and initialise ret to 0

Got it, other functions (except vt_do_kdskled) initialize ret to 0.
Thanks again.


> as is done in several other vt helpers in case a driver bug ever
> causes them to be called for the wrong cmds (e.g. instead of sprinkling
> WARN_ON(1) in all those functions).
>
> You may want to mention that the kfree warning was introduced by
>
>         07edff926520 ("vt: keyboard, reorder user buffer handling in vt_do_kdgkb_ioctl")
>
> which moved the shared allocation into the switch statement, and perhaps
> also mention
>
>         4e1404a5cd04 ("vt: keyboard, extract and simplify vt_kdskbsent")
>
> for the ret warning.

Thanks a ton Johan for your time in investigating the history.
This has made things, in the current scenario, crystal clear.


Have floated the v5 patch at :
https://lore.kernel.org/linux-serial/20211108134901.7449-1-ajaygargnsit@gmail.com/T/#u

Let's continue further discussion there.


Thanks and Regards,
Ajay
