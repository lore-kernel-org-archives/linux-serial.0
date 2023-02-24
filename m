Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3D74C64ED8
	for <linux-serial@archiver.kernel.org>; Fri, 24 Feb 2023 21:31:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbjBXVbX (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 24 Feb 2023 16:31:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjBXVbW (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 24 Feb 2023 16:31:22 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4043419F3F
        for <linux-serial@vger.kernel.org>; Fri, 24 Feb 2023 13:31:18 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id da10so2677346edb.3
        for <linux-serial@vger.kernel.org>; Fri, 24 Feb 2023 13:31:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JrE04gOVw81UKFZPld2Vl1EpoZ4FShZtZFABiCjDz1k=;
        b=U7gWuY7WPaAKGddJZQsgblTmmGzM6IGrhyDKpf4MIoCPtxKblnkp7k+m745hxwm/ui
         n52VtteVh03owR4gUOk5R8bZEWbffVclRpm8Y9uVx2kV5WrTXSUIuOGQh0Pt5tHKJcGx
         SgIim4KSTaNjJUhJgo5a4ziG5tr0JjQiKfD1M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JrE04gOVw81UKFZPld2Vl1EpoZ4FShZtZFABiCjDz1k=;
        b=7E6lbojhd3hbAqGlJqzoj5G7Esatn0tfkB463TqXutCZoz68+jop+zdmn/z3tJCKgt
         jXOUVguaouCOOJrW6D+L6r84a0bT4KCgDL+aYeG24cy51rjv6sU3sON2oaiIeApFp3PO
         9nHQ8fsWF1gzr7wnJb0hui1zVNbApdFkKELTv+jc9mk+lXAl61VaPvj5ZtBIC+MNqmkp
         HKVAC2jzA42u3nakICbkd/QRW/nqOhi7bXlkueys3TnGv8ulryd02fUGB4tTgSZR/bZ9
         6OdN11/7f8CxxlQLF6UO0LegavEhVr6Chhzci11qvBtZNchQxgsIWnL5OzSSbjqtqhU9
         snUQ==
X-Gm-Message-State: AO0yUKVoRKdFHB0ApLVLsux3i4V0CK04IjMIg23r3jSmc91K0Eo6rZ3Q
        wK2AHdAAsuob46lTY+bJQJRHUngMXDW34aVp9HDYKw==
X-Google-Smtp-Source: AK7set+Lel3unCwfYJ4rSDyCRlU3IuGR4F+pRyIcUH+LDH8VDTKPv3M5TcjQqDWPOrudRG9XSLtPjg==
X-Received: by 2002:a17:906:10d8:b0:8b1:2dd3:cb45 with SMTP id v24-20020a17090610d800b008b12dd3cb45mr25001354ejv.42.1677274276396;
        Fri, 24 Feb 2023 13:31:16 -0800 (PST)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id d21-20020a1709061f5500b008e6bd130b14sm27142ejk.64.2023.02.24.13.31.15
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Feb 2023 13:31:15 -0800 (PST)
Received: by mail-ed1-f47.google.com with SMTP id da10so2677088edb.3
        for <linux-serial@vger.kernel.org>; Fri, 24 Feb 2023 13:31:15 -0800 (PST)
X-Received: by 2002:a17:907:73c6:b0:8f1:fd:50d0 with SMTP id
 es6-20020a17090773c600b008f100fd50d0mr2763634ejc.0.1677274275171; Fri, 24 Feb
 2023 13:31:15 -0800 (PST)
MIME-Version: 1.0
References: <Y/iywbFbiUAA6ZD3@kroah.com> <CAHk-=whhFCeeuo6vTEmNSx6S-KKkugxgzN_W5Z6v-9yH9gc3Zw@mail.gmail.com>
In-Reply-To: <CAHk-=whhFCeeuo6vTEmNSx6S-KKkugxgzN_W5Z6v-9yH9gc3Zw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 24 Feb 2023 13:30:58 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjyFhdR-M7H6JpH7zF0k_z5xj8+qERaHsh5+0c4uOmv+g@mail.gmail.com>
Message-ID: <CAHk-=wjyFhdR-M7H6JpH7zF0k_z5xj8+qERaHsh5+0c4uOmv+g@mail.gmail.com>
Subject: Re: [GIT PULL] TTY/Serial driver updates for 6.3-rc1
To:     Greg KH <gregkh@linuxfoundation.org>,
        Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>,
        Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Feb 24, 2023 at 1:24 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
>         default SERIAL_8250

Hmm. Looking around, it seems to be a pattern. I'm not convinced any
of them are really valid, except probably the ones that aren't about
specific drivers, but about base support (like the "SERIAL_8250_DMA"
one).

I also do get the feeling that the base "SERIAL_8250" feature might be
better off as a _selected_ option, rather than a "ask if you want it".
I think we've ended up with that SERIAL_8250 being a base option
mainly for historical reasons (ie it was part of the original PC/AT
base specs, and then later it has become a "base driver for a lot of
random cards".

It's probably most legacy by now - it's a long time since I saw a
serial port being used outside of management ports, and even those are
often ethernet these days.

Maybe nobody cares.

             Linus
