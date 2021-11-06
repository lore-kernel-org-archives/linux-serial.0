Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2120C433F5
	for <linux-serial@archiver.kernel.org>; Sat,  6 Nov 2021 18:59:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72B7761037
	for <linux-serial@archiver.kernel.org>; Sat,  6 Nov 2021 18:59:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234558AbhKFTB4 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 6 Nov 2021 15:01:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234147AbhKFTBz (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 6 Nov 2021 15:01:55 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 246D2C061570;
        Sat,  6 Nov 2021 11:59:14 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id s19-20020a056830125300b0055ad9673606so17179048otp.0;
        Sat, 06 Nov 2021 11:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w/De7BpxXxHmTIkQQm3S5gIv0fyA+bSz7s084KVq+qk=;
        b=ERp/KaRpAyloDuMsxxYmdvO51oNzew06YZxc7JwgzcXiErKvY0ThENJR16hxtRZPCg
         IgsiruyCAyCUcfeCw6k6DM6KRSKDePpr5hUnSNTwXjTXU9ntOpZ9S9ZcIlnQrANJFjQL
         5Gg0ygVx33VtNMwT7l4IyFLbZXfBKtbLv4AvfOqfrL4h8MPa19fYS+vXzL9F0N8MNv5a
         rbs1JDe3ULkQHfJLwTxr2nu0oHCSia9ERpWPR92m+kwoQ4c6n4pPIa/FLFahDr+0Yv6T
         +42lwk6SnWq/fBUmOG1aS+xt7Tqmj8wnJcD3nbLnq9b5Kr2M2o8jrJTY+rwtf/PIRsk1
         1aVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w/De7BpxXxHmTIkQQm3S5gIv0fyA+bSz7s084KVq+qk=;
        b=BayY93kJ8UxKbo1XbBYN5YFReUAJaLXarAuYN9jkXFKRWgdL1YslHECKSlMIeR+Xxz
         eW7cdmv8BFxiY1HnYCKpvhKY3MCvD9+fVsM9gr9TgoQ0watG9rDfThWUoTXjSpj9J82J
         E7E8eKPjKIpSgjjrE/G7k/5UUUVr/VbRrE8kJpMo6PC459QEcsPdeJ1tEJdCrPh/w3p6
         EWzSs+14S1FZe3ZVeFIwUbaQNoHswna8IYkmrACXMYeAHUFG0HDieSvBmimxB8fLwNoY
         bhHx9HLsnsGRZvKSg30sKDWI8WaruUSjcyeRHAZaYUsrX+7nXHet+5I+BXSfGPisqEVC
         kjvQ==
X-Gm-Message-State: AOAM533yctgtzOJslH8xcAvMEKaTInJxwP3RoHAxuQLKPHDt5DK7XxRi
        sUPkIrJvyDu2hnQWfMvYzqMCtgoksBjDwtXZO6M=
X-Google-Smtp-Source: ABdhPJx8IjEZ/STpiFs4brCB+WtH6ZG/2bsrAawNzpQrp6+wmclzRwBR5BAAKO0tkNm2b1wT6UaQbxCl40PUmbdrXhM=
X-Received: by 2002:a9d:7617:: with SMTP id k23mr36426215otl.351.1636225153438;
 Sat, 06 Nov 2021 11:59:13 -0700 (PDT)
MIME-Version: 1.0
References: <20211106104053.98761-1-ajaygargnsit@gmail.com> <CAHp75VdY8aoF+dCm0j7EA-53BFaWdepvYYv7h5MVz2kVWagOOA@mail.gmail.com>
In-Reply-To: <CAHp75VdY8aoF+dCm0j7EA-53BFaWdepvYYv7h5MVz2kVWagOOA@mail.gmail.com>
From:   Ajay Garg <ajaygargnsit@gmail.com>
Date:   Sun, 7 Nov 2021 00:29:01 +0530
Message-ID: <CAHP4M8Vdj4Eb8q773BeHvsW9n6t=3n1WznuXAR4fZCNi1J6rOg@mail.gmail.com>
Subject: Re: [PATCH v2] tty: vt: keyboard: initialize "kbs" so that kfree(kbs)
 runs fine even if kbs is not kmalloced.
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>, jirislaby@kernel.org,
        kernel@esmil.dk
Cc:     "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

First of all, many thanks to Pavel for all the help and guidance,
nature bless you.
I will make it a point to keep all maintainers in loop, for all my
future patches.

>
> Everybody who is developing for kernel may check this easily, no need
> to have this in the commit message.
>
> As I told you, NAK.
> This is no value in this patch according to the commit message.
>
> If you have a compiler warning you need to provide the command line
> for `make` that makes that warning appear.

"make" as such runs fine, without any blocker (on my x86_64 machine).

The "kbs not initialized" is seen, when the smatch static-analyzer is run.
Thereafter, the patch was floated, to make the method
"vt_do_kdgkb_ioctl" crash-proof by handling kbs properly, without
depending upon external factors on whether a switch-case is hit or
not.

> In that case the better
> solution would be to add default case because some compilers can make
> (wrong) assumptions based on the absence of the default case.
>
> Something like
>
> default:
>    kbs = NULL;
>    break;
>
> at the end of the switch.
>
> But again, your current commit message does not sell.

Hmm, am not sure what to make of this.

I guess, we could follow one of the following approaches :

i)
Leave things as it is, as there is no blocker in the make-compilation/runtime.

ii)
Put the "default: kbs = NULL; break;" case, as suggested, to ensure
"vt_do_kdgkb_ioctl" does its work fine flawlessly, without depending
upon external clients.


Since there is no blocker in functionality, I am ok with whatever
consensus is reached by the maintainers.
If we wish to go with ii), please let me know, I will float next
patch-version with the ii) change, along with a better commit-message.

As of now, since Andy has voted for a NAK, I would not pursue this
further as of now :)


Thanks and Regards,
Ajay
