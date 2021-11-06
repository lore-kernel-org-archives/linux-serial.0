Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31A75C433EF
	for <linux-serial@archiver.kernel.org>; Sat,  6 Nov 2021 22:17:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F09D3610FD
	for <linux-serial@archiver.kernel.org>; Sat,  6 Nov 2021 22:17:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234673AbhKFWU3 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 6 Nov 2021 18:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbhKFWU3 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 6 Nov 2021 18:20:29 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1344C061570;
        Sat,  6 Nov 2021 15:17:47 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id g25-20020a9d5f99000000b0055af3d227e8so14518005oti.11;
        Sat, 06 Nov 2021 15:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OLTG0u8ieZ9jRhg6/M47315MShySzmtKj2Fb0QDROGY=;
        b=YhmknN8zjxUrOWDVwhSPJyQ9aiJPSt2+tyolatIz49/tol8F6h7b59v8lcPKKQu+yg
         SxUXwqj9C8Uk9dxUamZNyPuS3v/U/AG9QeWdhi3iAPr0NNBCBWOq2rG/hVH+ma0fnPOK
         V6kETdccqRzyzz6cXTMYGofp1WKLqiu++9HuzX4ew5lZSf58hwVfXS/Y1oXiwR9A4siG
         RVswpfdzW5aa788dwggM93OK628YFZFMgwdbU7VKPwFsDkfKcWHf44NZWLDFU+W1uO6T
         BPS2cwAPlh/+T+tRKkDTMdtLLcEIUoegub5WK4dv281qD3FvY5aKuvf0rmoE0omdydA/
         RmJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OLTG0u8ieZ9jRhg6/M47315MShySzmtKj2Fb0QDROGY=;
        b=BG/ryYkHJ7u6D9GwCKTCJYVJhyF+fI/2RA58zYLONjOBrrKB6vyyhaXHG4tKHZSikp
         DKVp5oaWUeSqsceC6x+u1UpGg3B15pwtg0r1o9LLPMekxYaOTXJPogKVg01g8EuTwC2H
         QmsdvwOHV7vUNjO+13fz6HJ6ItRZ7oOLb5pdFbDy2hNyXlXtUm14laAqZm06JnrlzmSs
         FYZEyBTEb5lprO8LygveONqrII8ifgw9hvmCY69n18ULfgL/EeXsu3X+YxMUYQhjNPOl
         AFfTcs/AiGz0m568uAA1laAh+XrunbuPiQj11Yakp3UoCPhA8QYl3kuTT9SSw1F1Wv7A
         TU6g==
X-Gm-Message-State: AOAM530QauoUHuxlb1VMSTNc8E4cQl/uQQNfSsX49jy/VMO5k4R86oIH
        pYC3oHb4RhdFMkaoyYEgeWhKLoQ9InDIGCz091s=
X-Google-Smtp-Source: ABdhPJwFcfupwD6sjuapJSPicQRE05KcB6C1fqIlAFgUzYwAx6L2WlS/bQmnqhh9O98nF5S/QU/ZJjzWB4q7YSPdwGo=
X-Received: by 2002:a9d:7617:: with SMTP id k23mr37166407otl.351.1636237066953;
 Sat, 06 Nov 2021 15:17:46 -0700 (PDT)
MIME-Version: 1.0
References: <20211106220315.392842-1-ajaygargnsit@gmail.com> <8d0346ba-4819-c25e-f208-0b51116d9147@gmail.com>
In-Reply-To: <8d0346ba-4819-c25e-f208-0b51116d9147@gmail.com>
From:   Ajay Garg <ajaygargnsit@gmail.com>
Date:   Sun, 7 Nov 2021 03:47:34 +0530
Message-ID: <CAHP4M8VmPTiWjVa_PEMs+XT0VzsoAw8BuO-KBo08Uwuf=T1WFw@mail.gmail.com>
Subject: Re: [PATCH v3] tty: vt: keyboard: add default switch-case, to handle
 smatch-warnings in method vt_do_kdgkb_ioctl
To:     Pavel Skripkin <paskripkin@gmail.com>
Cc:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        andriy.shevchenko@linux.intel.com, kernel@esmil.dk,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Sun, Nov 7, 2021 at 3:42 AM Pavel Skripkin <paskripkin@gmail.com> wrote:
>
> On 11/7/21 01:03, Ajay Garg wrote:
> > diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
> > index c7fbbcdcc346..b83e7669658d 100644
> > --- a/drivers/tty/vt/keyboard.c
> > +++ b/drivers/tty/vt/keyboard.c
> > @@ -2090,6 +2090,12 @@ int vt_do_kdgkb_ioctl(int cmd, struct kbsentry __user *user_kdgkb, int perm)
> >
> >               ret = 0;
> >               break;
> > +     default: {
> > +             kbs = NULL;
> > +             ret = -ENOIOCTLCMD;
> > +
> > +             break;
> > +     }
>
> Are these brackets needed here? There are no local variables inside
> default case.

Hmm,

* case KDGKBSENT: uses braces.
* case KDSKBSENT: does not use braces.

I based the layout for default-case on the same lines as case
KDGKBSENT: , as I prefer explicit braces :)
