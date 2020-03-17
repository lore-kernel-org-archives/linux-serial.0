Return-Path: <SRS0=6uIZ=5C=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64AB0C18E5B
	for <linux-serial@archiver.kernel.org>; Tue, 17 Mar 2020 06:22:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 325C2206EC
	for <linux-serial@archiver.kernel.org>; Tue, 17 Mar 2020 06:22:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GDlEFyKf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725916AbgCQGWK (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 17 Mar 2020 02:22:10 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:34847 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725536AbgCQGWK (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 17 Mar 2020 02:22:10 -0400
Received: by mail-qk1-f194.google.com with SMTP id d8so30676042qka.2;
        Mon, 16 Mar 2020 23:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vqbUptnPGFtluZo++U9jQHKU2X3z70TGZmJ5ZEKlp7s=;
        b=GDlEFyKfWrk2dt6lmNhkUnWn0df9SPKew4l3n9Q0QU1DCjvchMDRBGLpffKHUR/h46
         6R9VyH45YG58hwx1lNwjM/pQhLyV9fILrD7wLKww4DObLyXtFic3h122H9HYFc3Lmwu9
         LDFuFcgaNwtN1UUrcSTiNq3gDrNHJcHyL8wT8lk4lBEE/Bksbn2PEuqCla/aouEqhEGX
         jQ1kstAtnwlSqgQkSz+A1035NVucYVr3kTX2urNSEKlM+V+vhrMY3PUj6n+EpD5Kz+Jx
         ngZfYDsjCP/OIje02okpO+WAl4Luee9nERulu9hx5kMdBMfUI96dtJxRyJGTOqkjJEc6
         /npw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vqbUptnPGFtluZo++U9jQHKU2X3z70TGZmJ5ZEKlp7s=;
        b=ccgmrRaBYn8fpY2O5kNa9dobyDs5Mav0YT0Q9VWIBrDVvua2oIIYpO1eIn4j2JgSi9
         QNZH7HAhOhk3M/AmL2QTbUOeeKm+Hd+bwPqBDl5cEEDMUiepT6lP+DBTdCis5Gbj+6hd
         9xcQ32qkTB9oQkQzRV5wuHMsN1L4imxC82+OyLYRD5J12AmsipBUWXRnjUwxzHXiBSJ7
         ToO0RRrfocVq2fzGY9/1kzXF5lEl404cl32DXTKvQgiIEyPviggteNZPkIMH+0bTs8XW
         N8RRQMBGxP0nD/+HoEvX+UdO3F4yttvM+8wtPJSBWgUEMwYHA/yKhrPfacsVS9krvtsO
         lkjQ==
X-Gm-Message-State: ANhLgQ2KQ8yj0gOHSKlisNF1tIVmIlew+l8ZlRfcejKt55XvUhqFH1i8
        rp3WeRolGbJeW0MWWu+LSfwFpjZa2JvbvoCkBl0=
X-Google-Smtp-Source: ADFU+vs7JA+Cl0AXEw3+b9IUvGjFumoUCuvPflRGU/4XqbYcPgvKuovPceONlR9nubCnw0ZAokheAAcSkctXrhk1wQo=
X-Received: by 2002:a05:620a:10ae:: with SMTP id h14mr3352065qkk.170.1584426129327;
 Mon, 16 Mar 2020 23:22:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200316101930.9962-1-zhang.lyra@gmail.com> <20200316101930.9962-4-zhang.lyra@gmail.com>
In-Reply-To: <20200316101930.9962-4-zhang.lyra@gmail.com>
From:   Baolin Wang <baolin.wang7@gmail.com>
Date:   Tue, 17 Mar 2020 14:21:57 +0800
Message-ID: <CADBw62rjQMfNdxyDsNCbz-v7Ebz=MFu+CTMJEJORD3VXczVhtQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] serial: sprd: cleanup the sprd_port when return -EPROBE_DEFER
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
> cleanup the sprd_port for the device when its .probe() would be called
> later, and then alloc memory for its sprd_port again.
>
> Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> ---
>  drivers/tty/serial/sprd_serial.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/tty/serial/sprd_serial.c b/drivers/tty/serial/sprd_serial.c
> index 914862844790..9917d7240172 100644
> --- a/drivers/tty/serial/sprd_serial.c
> +++ b/drivers/tty/serial/sprd_serial.c
> @@ -1230,8 +1230,13 @@ static int sprd_probe(struct platform_device *pdev)
>         up->has_sysrq = IS_ENABLED(CONFIG_SERIAL_SPRD_CONSOLE);
>
>         ret = sprd_clk_init(up);
> -       if (ret)
> +       if (ret) {
> +               if (ret == -EPROBE_DEFER) {

I think we can remove the condition and devm_kfree() here, just
simplify the code as below?
if (ret) {
       sprd_port[index] = NULL;
       return ret;
}

> +                       devm_kfree(&pdev->dev, sprd_port[index]);
> +                       sprd_port[index] = NULL;
> +               }
>                 return ret;
> +       }
>
>         res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>         up->membase = devm_ioremap_resource(&pdev->dev, res);
> --
> 2.20.1
>


-- 
Baolin Wang
