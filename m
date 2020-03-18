Return-Path: <SRS0=ll96=5D=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99BFDC5ACD6
	for <linux-serial@archiver.kernel.org>; Wed, 18 Mar 2020 10:55:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AE9B2076C
	for <linux-serial@archiver.kernel.org>; Wed, 18 Mar 2020 10:55:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PZ61sPEp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727177AbgCRKzU (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 18 Mar 2020 06:55:20 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:42445 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726586AbgCRKzT (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 18 Mar 2020 06:55:19 -0400
Received: by mail-lj1-f194.google.com with SMTP id q19so26383281ljp.9;
        Wed, 18 Mar 2020 03:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QVO7l6yWYBz7TXXpPhUYu/h3rhc5sn/5iM8iTrpUO9o=;
        b=PZ61sPEp6A46TUR73bReZneuQnCGdZHRnsvi/uCkPpUx0XnYsuL+9U6ml2pii9xrTG
         +yQ6UaCFa+P9kYVDBkoQlx63wLXgBKlXHTy74gk+Ow2D9Xgq5cuOsEnqtM5++caJkSWl
         8LlILNsEXEfKuq38AiZdP1x4Ocn4YhOe/DfGjxdaXSkODSTXOOyz9KYTb3bBEwVaXFX+
         JS95+VRbU+F0MJIK99oSIrAL4KbHcrGu0FxxW4tHThkqdNr0lPAYrY3kqSuhyvx65fSy
         WMg9uuJkJebQ6KNcP66+rYDxLhIs0Gk81rFGMRxGv0Z1zfzrrYTJzbMmTat5HsDZJFTz
         C9ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QVO7l6yWYBz7TXXpPhUYu/h3rhc5sn/5iM8iTrpUO9o=;
        b=qYKo/CCjqVzUn9MMk0M+6zX409jczmrnje7+Sq5f5dxfqz/8ACccsI7ZBrWuyALKF7
         1Uh3LoZA/RzAsgDZEHEox91VDKwVr40/uLFtZpWAhU9eyRa3M8VP2StJMyoISSDcq3j8
         BHLGriVYFk3ilgNgJsR+ajD89/kTeEEO7aCOCdYYaNWueD6B/TE1cHklfP3e5ruF46uM
         TAnEhKwgzjz5QxlQfqNgsEqUOkq+ST8LJaybWJuFC0TSDIH3BdYRCN19qKdTDB7dvRdr
         fOn5YuCJRijJZbbaJWzbeCgmDeQQ9An3FUY2AOHd0ehl+G5mciNVIp0WnYibO9o18vzc
         +n4g==
X-Gm-Message-State: ANhLgQ2c1ovs8A74NuCOTA8GegR6aEr8sN284EAdIXHy2Lq3bRfLJlKH
        QSwgE2qHIVo+S6JRurMQowiFGcoLrzFZDT69knQ=
X-Google-Smtp-Source: ADFU+vue2m+KCDbqSYh9XO+5V+TtyhxJKUqVa2SGOLA8bia86DcKv4lQ0/Eqy/xeKGsYE9NYlNvxb1PuSMYercmxShU=
X-Received: by 2002:a2e:b0f0:: with SMTP id h16mr1974504ljl.48.1584528916034;
 Wed, 18 Mar 2020 03:55:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200318105049.19623-1-zhang.lyra@gmail.com> <20200318105049.19623-3-zhang.lyra@gmail.com>
In-Reply-To: <20200318105049.19623-3-zhang.lyra@gmail.com>
From:   Baolin Wang <baolin.wang7@gmail.com>
Date:   Wed, 18 Mar 2020 18:55:04 +0800
Message-ID: <CADBw62pMx_S8nhYixUqq=A6Mg_5fX+2Mh6HZV6mX-uNQw2+D5A@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] serial: sprd: remove redundant sprd_port cleanup
To:     Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Mar 18, 2020 at 6:51 PM Chunyan Zhang <zhang.lyra@gmail.com> wrote:
>
> From: Chunyan Zhang <chunyan.zhang@unisoc.com>
>
> We don't need to cleanup sprd_port anymore, since we've dropped the way
> of using the sprd_port[] array to get port index.
>
> Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>

Looks good to me.
Reviewed-by: Baolin Wang <baolin.wang7@gmail.com>

> ---
>  drivers/tty/serial/sprd_serial.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/tty/serial/sprd_serial.c b/drivers/tty/serial/sprd_serial.c
> index e9d148d47bec..cefdd051b2d0 100644
> --- a/drivers/tty/serial/sprd_serial.c
> +++ b/drivers/tty/serial/sprd_serial.c
> @@ -1237,10 +1237,8 @@ static int sprd_probe(struct platform_device *pdev)
>         sprd_ports_num++;
>
>         ret = uart_add_one_port(&sprd_uart_driver, up);
> -       if (ret) {
> -               sprd_port[index] = NULL;
> +       if (ret)
>                 sprd_remove(pdev);
> -       }
>
>         platform_set_drvdata(pdev, up);
>
> --
> 2.20.1
>


-- 
Baolin Wang
