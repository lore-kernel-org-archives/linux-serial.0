Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F2B9C433F5
	for <linux-serial@archiver.kernel.org>; Mon,  8 Nov 2021 12:13:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03DA8611C4
	for <linux-serial@archiver.kernel.org>; Mon,  8 Nov 2021 12:13:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239406AbhKHMPw (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 8 Nov 2021 07:15:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238269AbhKHMPv (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 8 Nov 2021 07:15:51 -0500
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71F42C061570;
        Mon,  8 Nov 2021 04:13:07 -0800 (PST)
Received: by mail-oo1-xc29.google.com with SMTP id o26-20020a4abe9a000000b002b74bffdef0so5791018oop.12;
        Mon, 08 Nov 2021 04:13:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qCahN7Z2eApo7DihO9JmcKwfNfByIlOsczbEOlm60Tk=;
        b=XeW5lJh3+kn77LGm9zJDt6aEreczQgqTVGMv1jleXx6o7p2QR7y5RsLOaFBabVbU/a
         2tsy3mVMf8dCSKdEx0Vu+HdYKquGvP/aQ5zlL6PbdNUyFeeC9lqXTkDhEwUNx+4idUo5
         /U34LYX+EGjjr3B5h1IEyfX+oKj5v6fJXI87LJRQPeKLjSHYR/+kMGRI44nxMeuQz1QG
         o0+ryoytYtGCXH7eFbuDpvS/C/8bymlpKILFqYCl6sifa5iXT8uL3oeLtHR/QMCeHuZs
         ZlSYprhVTNny9kp9SKbiB87FbIrrW0cZq8Kw2ZjDqqI7updu3BvBLJSI2g8g/cALpqZr
         tGGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qCahN7Z2eApo7DihO9JmcKwfNfByIlOsczbEOlm60Tk=;
        b=ebVtwlLdYh6X6+CnpVQOVgF6nrXQCaTDvB6rRvG+arrfHAntIhBvzdydD00YwvR5NE
         8tI0o8zbAxIfqVbTwFpnJ8ZbItruwaXRC+tGOmDUH2VlG6c6kVvIHSw87+7u6jzKEjHZ
         P4jTWsfOlLjxfQJ2PMyId7t1joMLRsfQK9wUrYsd2JYZGZxSJhvFQOAJ7ujGRgnn1/v/
         hGNBeBDvkq24hyUz3yOXdenqNrYYrtTb/jaJEChEuc6c8qlFSoHwn5MQfCBFwcn3xioq
         BEgyio7RSG9HhuoN71+jOQHgn/EPvxkk1yo3S+BDblF7fBmokyiU59ztWg9GpBGvG5xJ
         VgUw==
X-Gm-Message-State: AOAM531pSGB+d6/q9jYPSpQpQ7uLCiKf9N7d/164Y+5pJm0Fg8WXW+HK
        IAOTpsG5Yh8Mse0u82HXuWfohm7C5JE5mJGjJs4=
X-Google-Smtp-Source: ABdhPJzKab/cb+xQJd54Kj1M79OAdiMFP0Y0vHrMtx1CjrYJmD8OYdwvCaEu/DmUNxH4Q8qadabBcjjq6UghPm7ZGac=
X-Received: by 2002:a4a:d5c8:: with SMTP id a8mr21415585oot.18.1636373586714;
 Mon, 08 Nov 2021 04:13:06 -0800 (PST)
MIME-Version: 1.0
References: <20211106092041.43745-1-ajaygargnsit@gmail.com>
 <9eafae1f-d9f0-298d-cf20-212865d0becc@gmail.com> <868025b485b94480ad17d0ec971b3ee9@AcuMS.aculab.com>
 <CAHP4M8Ww0-VqCBKX=iLd=zy1AcDoNdzTOqJuaqRxCGZsMhoX9w@mail.gmail.com>
 <CAHP4M8UcZ=ttB8jbN1yOY6YH8SiQ27NhdEKi9SDH1CWG-GY6eg@mail.gmail.com>
 <6b58a3e1-f2ea-cc4c-03b2-06334b559373@gmail.com> <CAHP4M8Vs8a8u98enuHXaBcC7D4fCZzCOtEq06VnvuPUqhqPK=Q@mail.gmail.com>
 <9717b429-597f-7778-c880-94361bcdee7f@gmail.com> <CAHP4M8XtFiAa1kF5A_rPbcui3DP8L6iyfP8GbwgLLzo0Bo+TNQ@mail.gmail.com>
 <65c45951-08ba-26bb-f96b-3d4442b1d4d4@gmail.com> <CAHP4M8X_D4WdK9TwQoeV=WTEGUyLCs1VV5qWbYbfWJyZ9+C_5w@mail.gmail.com>
 <9e3047a9-ad29-ab83-670b-4d28e6ec6dbf@gmail.com>
In-Reply-To: <9e3047a9-ad29-ab83-670b-4d28e6ec6dbf@gmail.com>
From:   Ajay Garg <ajaygargnsit@gmail.com>
Date:   Mon, 8 Nov 2021 17:42:54 +0530
Message-ID: <CAHP4M8WaGt7q3t3z27df5BjHKNKsErjW-x-=awdoAvuq+jG77Q@mail.gmail.com>
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

Hi Pavel,

>
> Honestly, I can't get what you are trying to achieve with new string
> function.
>
> If caller knows, that there is no possible overflow, it can omit bounds
> checking (like in vt_do_kdgkb_ioctl). If caller needs return value equal
> to destination length it can use strscpy().

Please see the output corresponding for strscpy(), in the example output at
https://lore.kernel.org/linux-hardening/CAHP4M8U=0aTHgfREGJpSboV6J4X+E3Y6+H_kb-PvXxDKtV=n-g@mail.gmail.com/T/#m4a3f524eefe283a42430905fa4c0dfc2c37b2819

As is evident, even though destination length is 9, yet the returned
value is -7 (corresponding to -E2BIG).
So, strscpy() fails.


>
> There is a bunch of str*cpy() functions and every month I see new
> conversations between them on ML. As Andy said it's really chaos. These
> conversation are needed, of course, from security point of view, but
> lib/string is already big. It contains functions for every possible
> scenario, caller just needs to pick right one.

lib/string is big or small, that's not an excuse imho :)
I care about simplicity and easy lives for everyone in present (of
course) and future (more importantly).

As mentioned in :
https://lore.kernel.org/linux-hardening/CAHP4M8U=0aTHgfREGJpSboV6J4X+E3Y6+H_kb-PvXxDKtV=n-g@mail.gmail.com/T/#m4a3f524eefe283a42430905fa4c0dfc2c37b2819

there are several cases in files like fs/kernfs/dir.c, where
strlcpy()'s return value is directly propogated to the clients, and it
is not evident whether or not the return-value is within bounds.

If the new intended method is not added, we need to add checks in all
the clients (which is too much churn).

Instead, the new intended method will simplify lives for the clients,
when all they care is copy as much bytes as possible, and get the
number of bytes actualy copied.




It would be beneficial for all if discussions about the new method are
done on the intended thread.


Thanks and Regards,
Ajay
