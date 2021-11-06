Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED2A1C433FE
	for <linux-serial@archiver.kernel.org>; Sat,  6 Nov 2021 19:48:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFBB06113A
	for <linux-serial@archiver.kernel.org>; Sat,  6 Nov 2021 19:48:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231460AbhKFTtN (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 6 Nov 2021 15:49:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbhKFTtM (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 6 Nov 2021 15:49:12 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6615DC061570;
        Sat,  6 Nov 2021 12:46:31 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id u2so20444910oiu.12;
        Sat, 06 Nov 2021 12:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PMspPuEiHF8TTw4kpezLZ3py+j8BpQXsy8JAmQiChSg=;
        b=bZj1bZW5/C8ymc9ru64b52ComXgJNFIyr1bapKV2EWDocBtE3mAzrW1SLuzvWVApDQ
         vmQRzXPgxo7LIYH2iLZoIGiI3GKgRIcwHoWu7q89Y+UdkqFF5HSkl3C4ZlCIboMbKXNb
         CvQuz0UFLNgYPndh5wnsm3okt2+//t9bGKse1h+zwvMSal6F9ptJgzZWsy9qIiYpp1Qh
         QtkUBLo3BrNWrqwcwQOpuFqs4jwwXVV7AqR8C13yYHo+PZl69pRBE2AoNeFDP0Tl4Dfn
         /eE2nslWlSuqWxecZUHoegoxDjU/0m/K3J1hnRKzhcwBOQd2IVekaGAHy9m41nkkiE3I
         3Ozw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PMspPuEiHF8TTw4kpezLZ3py+j8BpQXsy8JAmQiChSg=;
        b=LLl3rj2ZeVov/SSbpUmb1ogEw92hfaE6zBHIzvePpE+g3gaF2dZ8yL3YlbtHulpHjq
         fLDaPhmffzZ7/4zSpzvO9PNFRRwsvvL4wxUb9houh4LwgNiqTm949IDkLYOo0QCZFXfn
         Jd4OtQeN2d60XWDfWAGSPm1K/rPr7TEv3/w2xJnvxwnomgdvInpQi4Zo41YiXku+40FY
         g9qhtAYiq6FPb/bF4As176o+kJ5jnSkL/ZrwNxCilNiytEha/UGlRzq9dHKSNcr484jt
         vrQWRkFz01wvuLb0gEzH4hTonhmVJ8GxzeUedlWrtO8Y6FMdrDLatB/crflkVMWJ6nct
         HnAg==
X-Gm-Message-State: AOAM530wN3tO0kQDdoytRgbEDlr36SlwTAIovy4Fdu+g96xEaqkmYsot
        sCPUKtGM84GDoTQaxHRCn4beauVZAufxhF/7WB8=
X-Google-Smtp-Source: ABdhPJz30mwHsyZZBJKXIvrBbWkOYGE/1UuZWohf+qYGZ7K8qggINr+7egIte0C0W/Cj57CAezkZChLeIbpQ/32QYP8=
X-Received: by 2002:a54:4499:: with SMTP id v25mr28167081oiv.71.1636227990612;
 Sat, 06 Nov 2021 12:46:30 -0700 (PDT)
MIME-Version: 1.0
References: <20211106092041.43745-1-ajaygargnsit@gmail.com>
 <9eafae1f-d9f0-298d-cf20-212865d0becc@gmail.com> <868025b485b94480ad17d0ec971b3ee9@AcuMS.aculab.com>
 <CAHP4M8Ww0-VqCBKX=iLd=zy1AcDoNdzTOqJuaqRxCGZsMhoX9w@mail.gmail.com>
In-Reply-To: <CAHP4M8Ww0-VqCBKX=iLd=zy1AcDoNdzTOqJuaqRxCGZsMhoX9w@mail.gmail.com>
From:   Ajay Garg <ajaygargnsit@gmail.com>
Date:   Sun, 7 Nov 2021 01:16:18 +0530
Message-ID: <CAHP4M8UcZ=ttB8jbN1yOY6YH8SiQ27NhdEKi9SDH1CWG-GY6eg@mail.gmail.com>
Subject: Re: [PATCH] tty: vt: keyboard: do not copy an extra-byte in copy_to_user
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>, jirislaby@kernel.org,
        kernel@esmil.dk, David Laight <David.Laight@aculab.com>
Cc:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Actually, on further thoughts, even David's solution will require an
extra check, if -E2BIG is returned.

So, I guess the solution suggested by me looks the best
(https://lore.kernel.org/linux-serial/868025b485b94480ad17d0ec971b3ee9@AcuMS.aculab.com/T/#m1c4aaa4347b02fd4c11ce611ff5029fcb71c37a1)
:

1.
== Do not use the return value from strlcpy. ==

                len = strlcpy(kbs, func_table[kb_func] ? : "", len);
=>
                strlcpy(kbs, func_table[kb_func] ? : "", len);


2.
== Calculate the actual length of kbs, add 1, and then copy those many
bytes to user-buffer ==

ret = copy_to_user(user_kdgkb->kb_string, kbs, len + 1) ?
                        -EFAULT : 0;
=>
ret = copy_to_user(user_kdgkb->kb_string, kbs, strlen(kbs) + 1) ?
                        -EFAULT : 0;

On Sun, Nov 7, 2021 at 12:50 AM Ajay Garg <ajaygargnsit@gmail.com> wrote:
>
> Thanks Pavel, Andy, David for the help.
>
> Andy,
>
> There is no compilation/runtime blocker.
> There were warnings reported by smatch.
>
> My intention is to make the method "vt_do_kdgkb_ioctl" bullet-proof in
> itself, without depending upon external clients.
>
> Pavel has explained that currently things are fine, as per :
> https://lore.kernel.org/linux-serial/868025b485b94480ad17d0ec971b3ee9@AcuMS.aculab.com/T/#m740fffb7c6ee52fdc98b9ef0b4e32a060b6a3be3
>
> but it seems that there is a big flaw - we are dependent on the length
> of "func_table[kb_func]" being ok. If func_table[kb_func] goes awry,
> the method will cause overflow.
>
> Since func_table[kb_func]" is not managed by the method, so the method
> must not depend on func_table[kb_func]" length-correctness. Instead,
> "vt_do_kdgkb_ioctl" must ensure no overflow, without depending how
> external entities (func_table[kb_func] behave.
>
>
>
> The issue with strlcpy, along with a potential "fix", has been explained in :
> https://lore.kernel.org/linux-serial/868025b485b94480ad17d0ec971b3ee9@AcuMS.aculab.com/T/#m1c4aaa4347b02fd4c11ce611ff5029fcb71c37a1
>
> David has provided a simpler fix (usage of strscpy), as in :
> https://lore.kernel.org/linux-serial/868025b485b94480ad17d0ec971b3ee9@AcuMS.aculab.com/T/#m63dab1137e593f2030920a53272f71866b442f40
>
>
> So, we could go with one of the above changes (mine/David's), or
> nothing at all (since there is no blocker).
>
> I vote for David's strscpy "fix", as it is simple, and does away with
> the dependency on the length of "func_table[kb_func]".
>
>
> Would like to know what the maintainers think.
> If there is a consensus that the method "vt_do_kdgkb_ioctl" be made
> bullet-proof in itself, please let me know, I will float the next
> version of patch.
>
>
> Thanks again Pavel, David, Andy.
>
>
> Thanks and Regards,
> Ajay
