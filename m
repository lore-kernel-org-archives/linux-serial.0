Return-Path: <SRS0=Gon6=DF=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7408C2D0A8
	for <linux-serial@archiver.kernel.org>; Mon, 28 Sep 2020 20:11:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A864206E5
	for <linux-serial@archiver.kernel.org>; Mon, 28 Sep 2020 20:11:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B1pnla2Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbgI1ULf (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 28 Sep 2020 16:11:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726732AbgI1ULf (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 28 Sep 2020 16:11:35 -0400
Received: from mail-ua1-x942.google.com (mail-ua1-x942.google.com [IPv6:2607:f8b0:4864:20::942])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88569C061755
        for <linux-serial@vger.kernel.org>; Mon, 28 Sep 2020 13:11:34 -0700 (PDT)
Received: by mail-ua1-x942.google.com with SMTP id j12so2628853ual.7
        for <linux-serial@vger.kernel.org>; Mon, 28 Sep 2020 13:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=egVBIQ7+I6ydt8wO/MFdyJyyx7SFuZumZFU4PdBZEqE=;
        b=B1pnla2ZGuDFjCK32WQi8nl+dtfGF6esMi6IO6o7iknuB9sazAC/VMVe5dMizVcbwS
         5I6dvfiwxkOb28yQ01O6qGMwsWdmlHZ1lyhQOn5vxNJeTURDW6yxITr+G3fq8HY5TH3D
         E59AAZvIOZPM5Ar8t0imj/PucLlZ6XdvjzJt1hli0wgl1vesb0lileUAZcC54s4/7pVH
         97lEnWG6AraElfZMMhdZT5xcmbuwhIwzHeU4dSlZ6EIpVSIPFJDLHrEGWxDgNwzXBlEm
         DpYfd+4DLWlRyyuuLKDGMnAAH0XEixHTHOWPBOwb/IOOcFD3WKbnGo83VrNyqo6Hk4Sa
         y+tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=egVBIQ7+I6ydt8wO/MFdyJyyx7SFuZumZFU4PdBZEqE=;
        b=MGtOYAcGD3X/W/ClDy8Okm3ygQkeT1fEzXXfbhtlNQhK3cAEZxeMOznvx+zZyYSan+
         HW+0IzqPbEtH+fj4ugfrsqKB+S78YJlYSTce03pacci44MJLXPpP3JsYYLi5dCds1QC0
         Gtdgy/+3Be4CeL9UAApE/JSUPPnzxWyu3zGsA4d+yYwVJ7NnG1gdYg/PU57oaE/hFkk7
         8jVzTD21I9a1Kb0nTdHQ44+9Ds0LIDEgDFA0NpClPbtQBxhCbNe8j8xcmQThxLRyOCEM
         mvvu6WkHANCjVU+32+8nSIy0ajPmwVd0R7Kf5QbIu6NAUCWs/neaqK/WAqNoDABGQa9r
         HJCg==
X-Gm-Message-State: AOAM5338+9xB/unfDQKNifb1kUc2ju6TNrFUD01PHHPT7CFui63KwN1j
        vWt+znQIQuY9fV+cy3ObL06RnhSHBtI+1H+ToS3eZA==
X-Google-Smtp-Source: ABdhPJwiA3vRQoLn9pVnXBzneJmi7DWWA/XPq+Ktc/SPS1RiATzILuZwgUAgzKyxrZfiXpqmPwCrSAoU1fQPnceh2z4=
X-Received: by 2002:ab0:d93:: with SMTP id i19mr2131336uak.7.1601323893634;
 Mon, 28 Sep 2020 13:11:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200918021455.2067301-1-sashal@kernel.org> <20200918021455.2067301-64-sashal@kernel.org>
In-Reply-To: <20200918021455.2067301-64-sashal@kernel.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 29 Sep 2020 01:41:22 +0530
Message-ID: <CA+G9fYuT_qF2sbmCV76C3B=KS7tSjo9XDkCLwm0A4ZBLJ_eBtw@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 4.9 64/90] serial: uartps: Wait for tx_empty in
 console setup
To:     Sasha Levin <sashal@kernel.org>,
        Raviteja Narayanam <raviteja.narayanam@xilinx.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        linux- stable <stable@vger.kernel.org>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        lkft-triage@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, 18 Sep 2020 at 07:55, Sasha Levin <sashal@kernel.org> wrote:
>
> From: Raviteja Narayanam <raviteja.narayanam@xilinx.com>
>
> [ Upstream commit 42e11948ddf68b9f799cad8c0ddeab0a39da33e8 ]
>
> On some platforms, the log is corrupted while console is being
> registered. It is observed that when set_termios is called, there
> are still some bytes in the FIFO to be transmitted.
>
> So, wait for tx_empty inside cdns_uart_console_setup before calling
> set_termios.
>
> Signed-off-by: Raviteja Narayanam <raviteja.narayanam@xilinx.com>
> Reviewed-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> Link: https://lore.kernel.org/r/1586413563-29125-2-git-send-email-raviteja.narayanam@xilinx.com
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>

stable rc 4.9 arm64 build broken.

drivers/tty/serial/xilinx_uartps.c: In function 'cdns_uart_console_setup':
drivers/tty/serial/xilinx_uartps.c:1286:40: error: 'TX_TIMEOUT'
undeclared (first use in this function); did you mean 'ETIMEDOUT'?
  time_out = jiffies + usecs_to_jiffies(TX_TIMEOUT);
                                        ^~~~~~~~~~
                                        ETIMEDOUT
drivers/tty/serial/xilinx_uartps.c:1286:40: note: each undeclared
identifier is reported only once for each function it appears in
  CC      drivers/usb/core/port.o
scripts/Makefile.build:304: recipe for target
'drivers/tty/serial/xilinx_uartps.o' failed
make[5]: *** [drivers/tty/serial/xilinx_uartps.o] Error 1

Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>

full test log link,
https://ci.linaro.org/view/lkft/job/openembedded-lkft-linux-stable-rc-4.9/DISTRO=lkft,MACHINE=hikey,label=docker-lkft/996/consoleText


> ---
>  drivers/tty/serial/xilinx_uartps.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
> index eb61a07fcbbc3..07ea71a611678 100644
> --- a/drivers/tty/serial/xilinx_uartps.c
> +++ b/drivers/tty/serial/xilinx_uartps.c
> @@ -1268,6 +1268,7 @@ static int cdns_uart_console_setup(struct console *co, char *options)
>         int bits = 8;
>         int parity = 'n';
>         int flow = 'n';
> +       unsigned long time_out;
>
>         if (co->index < 0 || co->index >= CDNS_UART_NR_PORTS)
>                 return -EINVAL;
> @@ -1281,6 +1282,13 @@ static int cdns_uart_console_setup(struct console *co, char *options)
>         if (options)
>                 uart_parse_options(options, &baud, &parity, &bits, &flow);
>
> +       /* Wait for tx_empty before setting up the console */
> +       time_out = jiffies + usecs_to_jiffies(TX_TIMEOUT);
> +
> +       while (time_before(jiffies, time_out) &&
> +              cdns_uart_tx_empty(port) != TIOCSER_TEMT)
> +               cpu_relax();
> +
>         return uart_set_options(port, co, baud, parity, bits, flow);
>  }
>
> --
> 2.25.1
>


-- 
Linaro LKFT
https://lkft.linaro.org
