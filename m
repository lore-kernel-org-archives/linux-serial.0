Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 044A7E7849A
	for <linux-serial@archiver.kernel.org>; Mon,  2 Oct 2023 10:20:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236389AbjJBKU3 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 2 Oct 2023 06:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236404AbjJBKU2 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 2 Oct 2023 06:20:28 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 185DDB0
        for <linux-serial@vger.kernel.org>; Mon,  2 Oct 2023 03:20:23 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1c6185cafb3so216555ad.1
        for <linux-serial@vger.kernel.org>; Mon, 02 Oct 2023 03:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696242022; x=1696846822; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wfxsi3rUolUe3A835MzACItI/kOFGspetH8wi1i5DIY=;
        b=t+A6Q3GjLqa3ktvOEDZI/N8bX93R7AOBdbS0LRtBIL/NOnvlsOqYY/4zzKyQaBhM3N
         UNOkvtVaAGSFOCMDFwLu0cFs04KtaptSXvZujHBgWZ33gw4e6tzz8+80NcG8qDXD7ybK
         BXQk7WwrVAJM3FRx09Vs5oMAT/OHSqTxVZ27Li6vgInssxPJsj7iU/7v92Ol+4508OqN
         bFBTHeYvi18vNg3I5KcFRPSq6CcQGuPuUlonC4hCLU+gF1cKF9UExxvQgiWZrZeobIg7
         p1TfSCCkzhpKIGCHJg9lG4I3pg04kDBRJGZlRYGuD72E3SjDMncTYxl9eIWkGqHfkAYW
         SpZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696242022; x=1696846822;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wfxsi3rUolUe3A835MzACItI/kOFGspetH8wi1i5DIY=;
        b=pJWtt4tBv1E1fZfhBj65leGdA/tPT95Ad1Yk1MO9CeAIn9XlttxXK+fKGRUnKnyAaT
         nC4h2+CNzDZODajFkdKhouwyx53otfsMA1V3UjPJ024KU8Cb7hdCtShpeCBmjgmBbaCl
         8agnV/RYZI5AfAKU0ikSLFbE0gRx3EcL4r7yBKdtPcDOlpXkoJpDDt9R2pSK7rXREVY0
         iBlmqGcF/mySJxUNvV2LN8I2uft8TDNMM+F7Gw1xWxYP0FJmIGUaT1gieivzrt/kUTCN
         00dxCh5UYkjIGPFrJTLpCezsk5M+aTl+joUx3LftTcopfJUYbPa1F3Jt/EvPqRFAzWhK
         Yfkg==
X-Gm-Message-State: AOJu0YzJ44AlwX/SjQ5iXv6f5+vleKmoPOBrcFs0gOBsjGxPuDXGqV8t
        v7Zv9AaEinVUENeAQTtQe1eQEatQ+npBkedSR0kY+Q==
X-Google-Smtp-Source: AGHT+IHchCZRUpV6NwJgG6ccmDwgmfcXhM/2BrSTDVL+h1R5tsrVPd96BpWJkqeGytkLXa67Y+jBbWituyuUs4ujeqc=
X-Received: by 2002:a17:902:e549:b0:1c3:90e3:a75b with SMTP id
 n9-20020a170902e54900b001c390e3a75bmr169411plf.15.1696242022265; Mon, 02 Oct
 2023 03:20:22 -0700 (PDT)
MIME-Version: 1.0
References: <2023092939-lagoon-punctual-e312@gregkh> <20230929230534.45142-2-twuufnxlz@gmail.com>
 <2023093049-next-confusion-b812@gregkh> <20230930-quotable-feeble-2bd6513ca643@spud>
In-Reply-To: <20230930-quotable-feeble-2bd6513ca643@spud>
From:   Aleksandr Nogikh <nogikh@google.com>
Date:   Mon, 2 Oct 2023 12:20:10 +0200
Message-ID: <CANp29Y79=Y76i72wHWfOJqU1tg8Z6vpbmwBRr=wcet7t5xdX5A@mail.gmail.com>
Subject: Re: [PATCH] Test for riscv fixes
To:     Conor Dooley <conor@kernel.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Edward AD <twuufnxlz@gmail.com>, alex@ghiti.fr,
        alexghiti@rivosinc.com, aou@eecs.berkeley.edu, guoren@kernel.org,
        jirislaby@kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-serial@vger.kernel.org,
        liushixin2@huawei.com, palmer@dabbelt.com,
        paul.walmsley@sifive.com,
        syzbot+8d2757d62d403b2d9275@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Sat, Sep 30, 2023 at 10:24=E2=80=AFAM Conor Dooley <conor@kernel.org> wr=
ote:
>
> On Sat, Sep 30, 2023 at 08:13:56AM +0200, Greg KH wrote:
> > On Sat, Sep 30, 2023 at 07:05:35AM +0800, Edward AD wrote:
> > > On Fri, 29 Sep 2023 08:04:57 +0200 Greg KH wrote:
> > > > Where are you getting your odd cc: list from?  This has nothing to =
do
> > > > with serial drivers...
> > > https://lore.kernel.org/all/0000000000000170df0605ccf91a@google.com/r=
aw
> >
> > I do not understand this answer.
>
> AIUI, the original report from syzbot "blamed" the serial maintainers.
> Not too sure how it determined that though, given the contents.
>

blame is too strong a word for that auto-inferred hint :)

Yes, the actual problem was in a totally different place, but FWIW
here's how it happened:

Statistically, stacktrace.c and a number of other generic locations
are rather unlikely to actually contain the bug (they can, but the
chances are that it's deeper in the call stack), so syzbot, while
traversing the stack trace, skipped all frames until

[<ffffffff80fa0c7e>] fn_show_state+0x1a/0x22 drivers/tty/vt/keyboard.c:614
[<ffffffff80fa1152>] k_spec drivers/tty/vt/keyboard.c:667 [inline]
[<ffffffff80fa1152>] k_spec+0xce/0x102 drivers/tty/vt/keyboard.c:656
[<ffffffff80fa306c>] kbd_keycode drivers/tty/vt/keyboard.c:1524 [inline]
[<ffffffff80fa306c>] kbd_event+0x5fa/0xa5e drivers/tty/vt/keyboard.c:1543

Per MAINTAINERS, these locations belonged to "TTY LAYER AND SERIAL
DRIVERS". Therefore serial in Cc.

The automation actually attributes a lot of reports correctly, but,
unfortunately, there are also tricky cases like this.

--=20
Aleksandr
