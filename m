Return-Path: <SRS0=2LmE=Z3=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F160C43603
	for <linux-serial@archiver.kernel.org>; Thu,  5 Dec 2019 00:40:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7147C21823
	for <linux-serial@archiver.kernel.org>; Thu,  5 Dec 2019 00:40:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NwIoRKWP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728560AbfLEAke (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 4 Dec 2019 19:40:34 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:45406 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728011AbfLEAke (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 4 Dec 2019 19:40:34 -0500
Received: by mail-io1-f67.google.com with SMTP id i11so1687512ioi.12
        for <linux-serial@vger.kernel.org>; Wed, 04 Dec 2019 16:40:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fO9gtIsalSOE0LJbwjwWOC5kliKZZAsXyfcY1acwND4=;
        b=NwIoRKWP9rsacN/oIOZabiTCAFvcFmwPfU/2JxMX5t4NY71U2tiGRRz1U2SqE7kuWr
         MdsNP3zQqY9F1xmYSzB349Q1PJOAYwKDF9OefiklEiTj9B6ql9L5etsZ+NvtKuoD0Wj3
         30gOu7Vm2UmvSDF2+QVZCj/OdaLHMIGFBnu5U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fO9gtIsalSOE0LJbwjwWOC5kliKZZAsXyfcY1acwND4=;
        b=G8bHKxgs2kDGfvGzSsBXrj6vcL/kKrpbhPmAWLuuanbpVpagNSwulnUK33P27bSyHb
         3ILp84/R+KZKJXLge2q5EwalqgYkDrmc6zHb1iuSfiZAp6in8NAhxy7AYUzf6rrvE+vE
         WlPDSCEW+MjbfrMZE9EdmxtLXCDmynqfusJKXhvQA4tWwmM1+UjvUnsfmCZyqQHpwyW3
         8BPtGKRmNWFsuNxhHMX3EfH18Eqzh7NC0jf7VoSGJ1CK5J2+J+1JedQLQPKmKwNbLSzj
         cXNTbvUWOWWtafVL7Klc10MbxIoULw5+WvL/QFZKY8jmBodIB+Jp4BLxIgEqhhkHz1oL
         MyWQ==
X-Gm-Message-State: APjAAAUqZq3ea0rNlOImrd/NSCWH946mymYOuhMiL14YHyi00gmei0uV
        sQ4ycwI4F0dWRWWqedYSuWN+qZgyCXk=
X-Google-Smtp-Source: APXvYqwNxJfej7hXk1EpU7k76GRnvbxzwCiHeMis0NfcopErCCT0REGVmAI1w7khSf6mB/d/Vl91Dg==
X-Received: by 2002:a5d:860e:: with SMTP id f14mr4453022iol.290.1575506433093;
        Wed, 04 Dec 2019 16:40:33 -0800 (PST)
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com. [209.85.166.170])
        by smtp.gmail.com with ESMTPSA id u23sm1962375ila.27.2019.12.04.16.40.31
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2019 16:40:32 -0800 (PST)
Received: by mail-il1-f170.google.com with SMTP id f6so1361304ilh.9
        for <linux-serial@vger.kernel.org>; Wed, 04 Dec 2019 16:40:31 -0800 (PST)
X-Received: by 2002:a92:3c41:: with SMTP id j62mr6440578ila.269.1575506431610;
 Wed, 04 Dec 2019 16:40:31 -0800 (PST)
MIME-Version: 1.0
References: <20191127141544.4277-1-leo.yan@linaro.org> <20191127141544.4277-2-leo.yan@linaro.org>
In-Reply-To: <20191127141544.4277-2-leo.yan@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 5 Dec 2019 08:40:20 +0800
X-Gmail-Original-Message-ID: <CAD=FV=W2nENJF0fNpTzjuAVOo_AoZQryThua9vdtt-zsMk82qg@mail.gmail.com>
Message-ID: <CAD=FV=W2nENJF0fNpTzjuAVOo_AoZQryThua9vdtt-zsMk82qg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] tty: serial: msm_serial: Fix lockup for sysrq and oops
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Nicolas Dechesne <nicolas.dechesne@linaro.org>,
        Jeffrey Hugo <jeffrey.l.hugo@gmail.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-serial@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi,

On Wed, Nov 27, 2019 at 10:16 PM Leo Yan <leo.yan@linaro.org> wrote:
>
> As the commit 677fe555cbfb ("serial: imx: Fix recursive locking bug")
> has mentioned the uart driver might cause recursive locking between
> normal printing and the kernel debugging facilities (e.g. sysrq and
> oops).  In the commit it gave out suggestion for fixing recursive
> locking issue: "The solution is to avoid locking in the sysrq case
> and trylock in the oops_in_progress case."
>
> This patch follows the suggestion (also used the exactly same code with
> other serial drivers, e.g. amba-pl011.c) to fix the recursive locking
> issue, this can avoid stuck caused by deadlock and print out log for
> sysrq and oops.
>
> Fixes: 04896a77a97b ("msm_serial: serial driver for MSM7K onboard serial peripheral.")
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  drivers/tty/serial/msm_serial.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/tty/serial/msm_serial.c b/drivers/tty/serial/msm_serial.c
> index 3657a24913fc..889538182e83 100644
> --- a/drivers/tty/serial/msm_serial.c
> +++ b/drivers/tty/serial/msm_serial.c
> @@ -1576,6 +1576,7 @@ static void __msm_console_write(struct uart_port *port, const char *s,
>         int num_newlines = 0;
>         bool replaced = false;
>         void __iomem *tf;
> +       int locked = 1;
>
>         if (is_uartdm)
>                 tf = port->membase + UARTDM_TF;
> @@ -1588,7 +1589,13 @@ static void __msm_console_write(struct uart_port *port, const char *s,
>                         num_newlines++;
>         count += num_newlines;
>
> -       spin_lock(&port->lock);
> +       if (port->sysrq)
> +               locked = 0;
> +       else if (oops_in_progress)
> +               locked = spin_trylock(&port->lock);
> +       else
> +               spin_lock(&port->lock);

I don't have tons of experience with the "msm" serial driver, but the
above snippet tickled a memory in my brain for when I was looking at
the "qcom_geni" serial driver, which is a close cousin.

I seemed to remember that the "if (port->sysrq)" was something you
didn't want.  ...but maybe that's only if you do something like commit
336447b3298c ("serial: qcom_geni_serial: Process sysrq at port unlock
time")?  Any way you can try making a similar change to the msm driver
and see if it allow you to remove the special case for "port->sysrq"?

-Doug
