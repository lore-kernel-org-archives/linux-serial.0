Return-Path: <SRS0=6uIZ=5C=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B304C10F29
	for <linux-serial@archiver.kernel.org>; Tue, 17 Mar 2020 06:10:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FA96205ED
	for <linux-serial@archiver.kernel.org>; Tue, 17 Mar 2020 06:10:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z/aa7ZXe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725783AbgCQGKo (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 17 Mar 2020 02:10:44 -0400
Received: from mail-qv1-f68.google.com ([209.85.219.68]:39943 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbgCQGKo (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 17 Mar 2020 02:10:44 -0400
Received: by mail-qv1-f68.google.com with SMTP id cy12so4367866qvb.7;
        Mon, 16 Mar 2020 23:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Sy+DCV3/0mPLOUw1l/ZG4OHi5SIhsD6Awhdy6a09qv4=;
        b=Z/aa7ZXefa7STGooR0UMVDDrLiuznSwp9ClLGQb4w44ZTJ4VDE9rxNn+0+61dxBxfC
         QRKTFrnWpbYd/LbvQM2RPM0+BGQfixyz3+WsHJ02AbTAIhldbu1Qt83gXpZqX3QueIRb
         VT43t7csfWYoY8PEwY/D5l6pE1hSQY2j3ZcdpXcRCFgnqa1yAffYwlwMVj1MQavsTxBX
         oVbYO7TlNkuX+zFkiVRGJOzbt6zqhS1JIoxiolYz+ky7bshpClnBkFkepaemW0dN6yIk
         hlNkiAyGWl7kCZPk/ib7AnLX0HH2G6N40oJXgSdZXHpOaR5MevoPxk6MX2wNUdKPxv5D
         i7XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Sy+DCV3/0mPLOUw1l/ZG4OHi5SIhsD6Awhdy6a09qv4=;
        b=s4HCryzbe7Slj/loG5fYtvXZRc7HxrJWM1zWmFvPsuTzB6gKG2ynsS/eCHPYUEPk/s
         k+so5cqR+nLNihkUNk1i+U6JrBoVZj03y7uAYniT+871orCQTQgMQPc1zuqk96U74gj5
         R/aPoGFHok8zXSU1S/xYoCOeBJzKADnNieYRctZPnsDErLlmwSVjl9Ukzz5bHaY5yOe5
         iXIW2l5hSHF891YMLXti8WZSoTP4HxIErWsd5dhk6QOWTXjvyad4iaahM6fxp8OR3jkM
         AYOztzoEFDxEADA7TGO7amPViv9kWDrlj/LSZ1lQP52xn5BFmdsGFCCFt9l+6BTcSkii
         DtuQ==
X-Gm-Message-State: ANhLgQ3VPgSYvzk7gFSKFty2J2K/DxW7cInFc//6ERV4Uzlaq8F/aVGB
        /Ub5psia7it0ynO+6kftATWC0QVMlOUnOUzJW2Y=
X-Google-Smtp-Source: ADFU+vvQn6S+icWNa0p5pq0pCDCa3nQI7Y9nT0qRSMa/unA/NzqZGMqTuX84zZRTaYpt9L7OFyy6gF8nkVewV1S9vA0=
X-Received: by 2002:ad4:44b3:: with SMTP id n19mr3424543qvt.65.1584425443690;
 Mon, 16 Mar 2020 23:10:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200316101930.9962-1-zhang.lyra@gmail.com> <20200316101930.9962-2-zhang.lyra@gmail.com>
In-Reply-To: <20200316101930.9962-2-zhang.lyra@gmail.com>
From:   Baolin Wang <baolin.wang7@gmail.com>
Date:   Tue, 17 Mar 2020 14:10:32 +0800
Message-ID: <CADBw62q8AqwMjnnVfwGxecn=UUQYGrfQ8Ry6OxgA2iXH1_Lnkw@mail.gmail.com>
Subject: Re: [PATCH 1/3] serial: sprd: check console via stdout-path in addition
To:     Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Mar 16, 2020 at 6:19 PM Chunyan Zhang <zhang.lyra@gmail.com> wrote:
>
> From: Chunyan Zhang <chunyan.zhang@unisoc.com>
>
> The SPRD serial driver need to know which serial port would be used as
> console in an early period during initialization, the purpose is to
> keep the console port alive as possible even if there's some error
> caused by no clock configured under serial devicetree nodes. But with
> the patch [1], the console port couldn't be identified if missing
> console command line.
>
> So this patch adds using another interface to do check by reading
> stdout-path.
>
> [1] https://lore.kernel.org/lkml/20190826072929.7696-4-zhang.lyra@gmail.com/
>
> Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>

Reviewed-by: Baolin Wang <baolin.wang7@gmail.com>

> ---
>  drivers/tty/serial/sprd_serial.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/tty/serial/sprd_serial.c b/drivers/tty/serial/sprd_serial.c
> index 3d3c70634589..18706333f146 100644
> --- a/drivers/tty/serial/sprd_serial.c
> +++ b/drivers/tty/serial/sprd_serial.c
> @@ -1147,7 +1147,8 @@ static bool sprd_uart_is_console(struct uart_port *uport)
>  {
>         struct console *cons = sprd_uart_driver.cons;
>
> -       if (cons && cons->index >= 0 && cons->index == uport->line)
> +       if ((cons && cons->index >= 0 && cons->index == uport->line) ||
> +           of_console_check(uport->dev->of_node, SPRD_TTY_NAME, uport->line))
>                 return true;
>
>         return false;
> --
> 2.20.1
>


-- 
Baolin Wang
