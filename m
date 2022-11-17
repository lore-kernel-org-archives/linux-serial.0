Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F178C4332F
	for <linux-serial@archiver.kernel.org>; Thu, 17 Nov 2022 00:56:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234506AbiKQA4d (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 16 Nov 2022 19:56:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233204AbiKQA4c (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 16 Nov 2022 19:56:32 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE8FE2DAB5
        for <linux-serial@vger.kernel.org>; Wed, 16 Nov 2022 16:56:30 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id 21so397237edv.3
        for <linux-serial@vger.kernel.org>; Wed, 16 Nov 2022 16:56:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1n9Efk70GF888Q8DxstqVav/EqXxYg0mmKjGntmJnKE=;
        b=jfAiRCbUBmzEJVryVoKrNvSRIVoS+m7YdWOdzKGdzU2SLFWxIZppc7/zdSDdZxS94A
         fSKXhPJgpc63X9youj+aXT15h+AF6oXExh9JstLh0qlntszrF2SdHhDIoGha0Vz4M3Qr
         zIOEF9lOEJmiQJRWePqZgcbAykhMpuRNHB9+c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1n9Efk70GF888Q8DxstqVav/EqXxYg0mmKjGntmJnKE=;
        b=jWZHv2RKdqnjaTjAiOpa0SYrnDtexAY9NQCO5T06QarDHRscWZtx5OIS0nkGPTt2ei
         rsR+pL1d3koI5k3iBxQcW2nX7SIJHJEDgHzxiprAW/yBIBo+jN6MXLgbb0DdO1dD8MIO
         +1xrXvAlSkei7LxyQx2VvmHh5u92rcMH5EmzZHLSP7O+xH26S3GeIsQvW+WcvN7A8lte
         WgprsN7YgMJIW2VlvpK2WBEaxyTPRlB4WS+5lwT5a3KwXr2oQUvSc1XMNZFcjHxjtswE
         FBntWzKOCq2J1fK8dKI2bsi2pAecJ1HCLSRRfhz3aeGpmcQRXgwaOYAOcU7OFpkuUxu4
         oKqQ==
X-Gm-Message-State: ANoB5plHfGZOHZImABAimTRG0fnWP3AtC01clyiUe0T/dwvuFRey+grp
        vNvL5srZqF8yid7FitDzREr9hNpEGzJVUWLn
X-Google-Smtp-Source: AA0mqf5dMdbT6aKBGsnp0Vb54zLFdLN1smvQvb2UwXjHm//OBEgToxc55weVCnZOFPqiW0AIcrZhJA==
X-Received: by 2002:a05:6402:5487:b0:468:816f:bbc9 with SMTP id fg7-20020a056402548700b00468816fbbc9mr217106edb.78.1668646587667;
        Wed, 16 Nov 2022 16:56:27 -0800 (PST)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com. [209.85.221.52])
        by smtp.gmail.com with ESMTPSA id ch17-20020a0564021bd100b0046182b3ad46sm8155874edb.20.2022.11.16.16.56.26
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Nov 2022 16:56:27 -0800 (PST)
Received: by mail-wr1-f52.google.com with SMTP id v1so359719wrt.11
        for <linux-serial@vger.kernel.org>; Wed, 16 Nov 2022 16:56:26 -0800 (PST)
X-Received: by 2002:adf:cd82:0:b0:238:b29e:4919 with SMTP id
 q2-20020adfcd82000000b00238b29e4919mr37800wrj.583.1668646586474; Wed, 16 Nov
 2022 16:56:26 -0800 (PST)
MIME-Version: 1.0
References: <20221116162152.193147-1-john.ogness@linutronix.de> <20221116162152.193147-39-john.ogness@linutronix.de>
In-Reply-To: <20221116162152.193147-39-john.ogness@linutronix.de>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 16 Nov 2022 16:56:14 -0800
X-Gmail-Original-Message-ID: <CAD=FV=VouG3ihFCg4gC3dNFs7TqzpDgowHd38y8fR8qiTfRw_A@mail.gmail.com>
Message-ID: <CAD=FV=VouG3ihFCg4gC3dNFs7TqzpDgowHd38y8fR8qiTfRw_A@mail.gmail.com>
Subject: Re: [PATCH printk v5 38/40] tty: serial: kgdboc: use
 console_list_lock to trap exit
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        kgdb-bugreport@lists.sourceforge.net, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi,

On Wed, Nov 16, 2022 at 8:22 AM John Ogness <john.ogness@linutronix.de> wrote:
>
> kgdboc_earlycon_init() uses the console_lock to ensure that no consoles
> are unregistered until the kgdboc_earlycon is setup. The console_list_lock
> should be used instead because list synchronization responsibility will
> be removed from the console_lock in a later change.
>
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
> Reviewed-by: Petr Mladek <pmladek@suse.com>
> ---
>  drivers/tty/serial/kgdboc.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/tty/serial/kgdboc.c b/drivers/tty/serial/kgdboc.c
> index 8c2b7ccdfebf..a3ed9b34e2ab 100644
> --- a/drivers/tty/serial/kgdboc.c
> +++ b/drivers/tty/serial/kgdboc.c
> @@ -558,13 +558,13 @@ static int __init kgdboc_earlycon_init(char *opt)
>          */
>
>         /*
> -        * Hold the console_lock to guarantee that no consoles are
> +        * Hold the console_list_lock to guarantee that no consoles are
>          * unregistered until the kgdboc_earlycon setup is complete.
>          * Trapping the exit() callback relies on exit() not being
>          * called until the trap is setup. This also allows safe
>          * traversal of the console list and race-free reading of @flags.
>          */
> -       console_lock();
> +       console_list_lock();
>         for_each_console(con) {
>                 if (con->write && con->read &&
>                     (con->flags & (CON_BOOT | CON_ENABLED)) &&

Officially don't we need both the list lock and normal lock here since
we're reaching into the consoles?

-Doug
