Return-Path: <SRS0=Gen4=44=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96606C10F25
	for <linux-serial@archiver.kernel.org>; Wed, 11 Mar 2020 05:16:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E298208C4
	for <linux-serial@archiver.kernel.org>; Wed, 11 Mar 2020 05:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583903768;
	bh=LlF5ctAEjJDdjvoW8h21v26PbNVIN5sEBNVN0kT1peo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ysP+htWe2o6lDlXqiLAJ6nZEiDt+pl4tAYOvRotRAnXPuQuCHP5jzj3ZIqzeFor5R
	 nW+RVO7N+J3MmdV4UcVMnNC6tDoDd1b0DqgsgB8N6lgnrw+Dk9yYMQtHujEJK7qwoc
	 Lr+JgzdDPwtIHAwGm1LLuJfyzzaUAP2uZsWCNoKo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725976AbgCKFQI (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 11 Mar 2020 01:16:08 -0400
Received: from conssluserg-03.nifty.com ([210.131.2.82]:63734 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725813AbgCKFQH (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 11 Mar 2020 01:16:07 -0400
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id 02B5FkZZ020142;
        Wed, 11 Mar 2020 14:15:47 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 02B5FkZZ020142
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1583903747;
        bh=AfcAhhaYncg48rG2V8lvHQMNiBncmFjUl9msHr0LZLM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KvW0KXepxAE2RCGteQEv1YSqRNHr0J2XMAXuIYCj1s+nNf63JyYw/9OC9czBm81xE
         clTtP0F838rdSrlae7fdZfuzjmaW0k88pzKs1nbAHtt3Uyh7o4zAnMyop6uGwQMinE
         NUBaWFVGEx5beaInaYhJb4d+us0M18Nqvb1KiMlrWdMedpw91/J8E1PkpEXG7Ht7zT
         rVUpsbRqkZkR22fGL28i63NHiw+bHariqNs76uyEyY8rldbzsX0Sk34pYYQb0u70Nz
         ULCMR1b9jSK/sN8ZGBLFycql4/3VhoWvwXQ13Iufs7qQd+LmBIQEq4ymjyhFCl2QBq
         HF1nFpJqD1/Zg==
X-Nifty-SrcIP: [209.85.217.50]
Received: by mail-vs1-f50.google.com with SMTP id o24so526334vsp.4;
        Tue, 10 Mar 2020 22:15:46 -0700 (PDT)
X-Gm-Message-State: ANhLgQ1iS79NXyHGjr5Ln4CBuy9C5hQ1nfkb0VZG1E7q4wBgFYqfNZEX
        MP3pryAH7yS5gil8kKLCes5O8O84eMHvsF2wTA0=
X-Google-Smtp-Source: ADFU+vueM9zpX/w41+7KRQJKMve2nE9ggiD45SMOr/dEVd886cFoVN80tyg4r4qMFhRNb5dCuud4jNxETWUlZpLQMEc=
X-Received: by 2002:a05:6102:8f:: with SMTP id t15mr878244vsp.215.1583903745980;
 Tue, 10 Mar 2020 22:15:45 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1583896344.git.joe@perches.com> <dae0878058223a42c77d725b8d7c5845a7ef9dc0.1583896348.git.joe@perches.com>
In-Reply-To: <dae0878058223a42c77d725b8d7c5845a7ef9dc0.1583896348.git.joe@perches.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 11 Mar 2020 14:15:10 +0900
X-Gmail-Original-Message-ID: <CAK7LNAS7GAk9yXkPhbS3ByU+n9Gb-rk0PeLcXLCNwpW1B22aeg@mail.gmail.com>
Message-ID: <CAK7LNAS7GAk9yXkPhbS3ByU+n9Gb-rk0PeLcXLCNwpW1B22aeg@mail.gmail.com>
Subject: Re: [PATCH -next 005/491] ARM/UNIPHIER ARCHITECTURE: Use fallthrough;
To:     Joe Perches <joe@perches.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Mar 11, 2020 at 2:07 PM Joe Perches <joe@perches.com> wrote:
>
> Convert the various uses of fallthrough comments to fallthrough;
>
> Done via script
> Link: https://lore.kernel.org/lkml/b56602fcf79f849e733e7b521bb0e17895d390fa.1582230379.git.joe.com/
>
> Signed-off-by: Joe Perches <joe@perches.com>


Acked-by: Masahiro Yamada <yamada.masahiro@socionext.com>


But, I think the patch subject should be prefixed:
"serial: 8250_uniphier:"



> ---
>  drivers/tty/serial/8250/8250_uniphier.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/tty/serial/8250/8250_uniphier.c b/drivers/tty/serial/8250/8250_uniphier.c
> index e0b73a5..a2978ab 100644
> --- a/drivers/tty/serial/8250/8250_uniphier.c
> +++ b/drivers/tty/serial/8250/8250_uniphier.c
> @@ -75,7 +75,7 @@ static unsigned int uniphier_serial_in(struct uart_port *p, int offset)
>                 break;
>         case UART_LCR:
>                 valshift = 8;
> -               /* fall through */
> +               fallthrough;
>         case UART_MCR:
>                 offset = UNIPHIER_UART_LCR_MCR;
>                 break;
> @@ -101,7 +101,7 @@ static void uniphier_serial_out(struct uart_port *p, int offset, int value)
>         case UART_SCR:
>                 /* No SCR for this hardware.  Use CHAR as a scratch register */
>                 valshift = 8;
> -               /* fall through */
> +               fallthrough;
>         case UART_FCR:
>                 offset = UNIPHIER_UART_CHAR_FCR;
>                 break;
> @@ -109,7 +109,7 @@ static void uniphier_serial_out(struct uart_port *p, int offset, int value)
>                 valshift = 8;
>                 /* Divisor latch access bit does not exist. */
>                 value &= ~UART_LCR_DLAB;
> -               /* fall through */
> +               fallthrough;
>         case UART_MCR:
>                 offset = UNIPHIER_UART_LCR_MCR;
>                 break;
> --
> 2.24.0
>


-- 
Best Regards
Masahiro Yamada
