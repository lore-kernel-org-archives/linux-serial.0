Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72771C433F5
	for <linux-serial@archiver.kernel.org>; Sat,  6 Nov 2021 12:16:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CBF66124D
	for <linux-serial@archiver.kernel.org>; Sat,  6 Nov 2021 12:16:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbhKFMTj (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 6 Nov 2021 08:19:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbhKFMTj (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 6 Nov 2021 08:19:39 -0400
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05F25C061570;
        Sat,  6 Nov 2021 05:16:58 -0700 (PDT)
Received: by mail-oo1-xc30.google.com with SMTP id j6-20020a4aab46000000b002bb88bfb594so3997909oon.4;
        Sat, 06 Nov 2021 05:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+POYMDTp6W1bADv+1zpQV58ffNru2a1oFkuJEw7LceM=;
        b=cDS6jT3mPqFPQ3DEWrCVdEKL0K4a4YC9rrPpVEZqfcHkG99ywGdW4gGtVygvq77vSp
         pEfwt8ub/xY76sEVmRbhNTMHD+20lTCKQnqqm09A/K1KLiqOBHVa6q49G9tP3/zlKoAV
         nSRwCSESqn5iuDdi/bHRLOcE8vsk1SVQYZ8VA0CoRUdtOtDdVufV+v22LftFsfWHdv2X
         li2rnWNk/OC6w19jsEuCPWeP6mB8vuS04GYaaspg/gUKL1T/N7xM81qZWtlvpzIc+bVx
         7MrRqROxO4rnQtgWjtIol/Zr3OuEmK50lFvX0SODk0Shew0MLixN6tdLWvjcZ5K9cXTO
         xB+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+POYMDTp6W1bADv+1zpQV58ffNru2a1oFkuJEw7LceM=;
        b=sbAb+HE/0xZ/iz7Scz6kxslUXqKSizLzae3DfsKbYGx1o8XnGGceDucf6hQJAomYe3
         RaQV4PXwDi8C32BGnl6/ODnlKBprxJFws/DYGBLAlfmJ5DODNVXSPlDs4e/+DnOQbtIQ
         lNH+HLW/RMDM1XfL1UJSKtXOmPk5OU4tjKOS6h3Wc+UDFkJ3zlL17rflrvKPSqgonUix
         T2HclCQqVgcUvfcCxWepLgbpuB78nFK0qzdfbLInAoC+2gabB8tFL65yw9ZQ61QVbhRc
         kNIoQ1F+D7Nfp6QQNv0xhGWhiq4rhjWQAM20vaTVIbYYAR3LXxganD6a/g3w6+tfeiuF
         xcig==
X-Gm-Message-State: AOAM532fL6eU9S/x1DSmPOg787moA0uyw0A3JwVciunqLjJz+dkfUZRJ
        QSlRsJHFAi/+bpnn0yyyh8BDBqAnTFLUBAUPGY8=
X-Google-Smtp-Source: ABdhPJzH+uh1bsIQhgyKNTei5cixUNJJIf2WHuW6LIbw/BXBvHpf+9pRteVEOqiI9w4abJuhdmNbYBcQMN44mUS0oeY=
X-Received: by 2002:a4a:d5c8:: with SMTP id a8mr13017354oot.18.1636201017393;
 Sat, 06 Nov 2021 05:16:57 -0700 (PDT)
MIME-Version: 1.0
References: <20211106104053.98761-1-ajaygargnsit@gmail.com> <dd7e35fc-d5b2-c41b-f03a-cbf467401205@gmail.com>
In-Reply-To: <dd7e35fc-d5b2-c41b-f03a-cbf467401205@gmail.com>
From:   Ajay Garg <ajaygargnsit@gmail.com>
Date:   Sat, 6 Nov 2021 17:46:45 +0530
Message-ID: <CAHP4M8XaWtagZcocGoeT2Rb6F6JeKqMFa2ZzTZ0ddCES0-T-jw@mail.gmail.com>
Subject: Re: [PATCH v2] tty: vt: keyboard: initialize "kbs" so that kfree(kbs)
 runs fine even if kbs is not kmalloced.
To:     Pavel Skripkin <paskripkin@gmail.com>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Pavel,

Thanks for the review.

>
> Please, don't put change log into commit message. It should go under ---
>

Ok, many thanks Pavel.
Will take care in all my future patches.


>
> These is only one caller of vt_do_kdgkb_ioctl, which simple does:
>
>
>         case KDGKBSENT:
>         case KDSKBSENT:
>                 return vt_do_kdgkb_ioctl(cmd, up, perm);
>
> It means, that cmd can not be different from KDGKBSENT and KDSKBSENT.
>
> I guess, you found this "issue" via static analysis tool like smatch or
> smth similar, but this bug is impossible right now.
>

Yes, following was reported by smatch (amongst others) :
vt_do_kdgkb_ioctl() error: uninitialized symbol 'kbs'.


Regarding the current state, "vt_do_kdgkb_ioctl" should ideally behave
correctly independently, without bothering whether a cmd is a valid
one. From that perspective, it makes sense to ensure that kfree never
crashes.

However, I don't have any strong opinions on what is right or what is
wrong, as long as things work fine.

So, if there is a general consensus that the change should not be made
currently, I would be ok.
In case the change should be made, kindly let me know, I will post the
v3 patch (making change as per the review-comment of moving changelog
below ---).


Thanks and Regards,
Ajay
