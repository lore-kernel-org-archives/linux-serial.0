Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E0CFC433EF
	for <linux-serial@archiver.kernel.org>; Sat, 16 Jul 2022 18:21:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230501AbiGPSVH (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 16 Jul 2022 14:21:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbiGPSVG (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 16 Jul 2022 14:21:06 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2460718E26
        for <linux-serial@vger.kernel.org>; Sat, 16 Jul 2022 11:21:06 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id m13so186edc.5
        for <linux-serial@vger.kernel.org>; Sat, 16 Jul 2022 11:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=28RZoulOfay6yh9clXAok7Vj13FsvDAmN9ITtezZqEg=;
        b=KPlvmWUfhHsy6m9FPymE6vCijl6goCmTjdImiiJQo5KaI2aXpYpRAfyGIFR8uXQ9hG
         y2SS3FQrazUfz3ROsbP2r8c1l/KhAWbYNjJ6GaTyPvzCUPbKcXzxomeHBC7uS5ItLS7N
         QAJnl9UadIl0CvYH8iPINZLil84yHyMLjoXvU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=28RZoulOfay6yh9clXAok7Vj13FsvDAmN9ITtezZqEg=;
        b=8BfSIm1WvcL2j0q3TV4zUnkDxBykyAfWC1OScXuq/Ept6+HRozpxclZqjfANsn1Iy8
         iFzS99Jb4dQpoeQU6ooFr8IKarcIUT4haUBaPspecjYIMBq+ghWuuVaP38lQnX8y8O4Y
         J/7CpBts1x68iTmti95Pk0hWMbYxM2DtF8X+jc9FChCmHKkbZ/W9PyjFERqeSj7JixAY
         WGzSMu6pgv8ws7d0JBuZpKj2gK/ZGHhVF9Orx5Kyt2pcchY0pxoCT8/ztkVcMY7ugzPm
         rdb0bLCivb2lUdFOgWgCI6Gb9wKByBbfPSTsq86lvm6aUUs8yKlihRbrtvLsIPBBKOgN
         DVtg==
X-Gm-Message-State: AJIora8lOOvxCRzsOwpkQTGEonloP414MCUpkKZG2WCtXQ7CIRH8t4iY
        IabYSVAS+NZKuaNeMi6tIZSh4XqTR1KZoPdW
X-Google-Smtp-Source: AGRyM1uLi4GQ5sm+HLWO/yyyo+TNhDzBYgtMjbQFB8TI0HjfeARE5bQL7yV2hBehdKEN1+jzg9g1Dw==
X-Received: by 2002:a05:6402:28c4:b0:43a:cdde:e047 with SMTP id ef4-20020a05640228c400b0043acddee047mr15227290edb.368.1657995648886;
        Sat, 16 Jul 2022 11:20:48 -0700 (PDT)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com. [209.85.221.47])
        by smtp.gmail.com with ESMTPSA id n8-20020a170906378800b00705976bcd01sm3436658ejc.206.2022.07.16.11.20.47
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Jul 2022 11:20:47 -0700 (PDT)
Received: by mail-wr1-f47.google.com with SMTP id f2so11023531wrr.6
        for <linux-serial@vger.kernel.org>; Sat, 16 Jul 2022 11:20:47 -0700 (PDT)
X-Received: by 2002:a05:6000:180f:b0:21d:68f8:c4ac with SMTP id
 m15-20020a056000180f00b0021d68f8c4acmr17595471wrh.193.1657995646637; Sat, 16
 Jul 2022 11:20:46 -0700 (PDT)
MIME-Version: 1.0
References: <YtJZegRfm6IsdY/i@kroah.com>
In-Reply-To: <YtJZegRfm6IsdY/i@kroah.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 16 Jul 2022 11:20:30 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiZNSb1BAx9gvU4i-h+11Xgke3Q1XSB96rPw+cDKhL7bg@mail.gmail.com>
Message-ID: <CAHk-=wiZNSb1BAx9gvU4i-h+11Xgke3Q1XSB96rPw+cDKhL7bg@mail.gmail.com>
Subject: Re: [GIT PULL] TTY/Serial driver fixes for 5.19-rc7
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Jul 15, 2022 at 11:24 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
>         - long time bug in pty_write() that has been reported in the
>           past.

Linus goes crazy on grammar, issue #7911: "longtime" and "long time"
are very different things. They have completely different meaning, and
are different parts of speech (adjective vs noun).

English is a crazy language.

             Linus
