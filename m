Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76281C433F5
	for <linux-serial@archiver.kernel.org>; Thu, 20 Jan 2022 21:53:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237213AbiATVxA (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 20 Jan 2022 16:53:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234489AbiATVxA (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 20 Jan 2022 16:53:00 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D45BFC061574
        for <linux-serial@vger.kernel.org>; Thu, 20 Jan 2022 13:52:59 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id c66so14628346wma.5
        for <linux-serial@vger.kernel.org>; Thu, 20 Jan 2022 13:52:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=references:user-agent:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version;
        bh=xzD+fvNee9njgyoYpg+UfIIsMfFdbgQCkyRxjeUcLZs=;
        b=DOWC4rjbw8rnosLNZZjD93f0SMG2hWCl/mdKZ1MaUzw8y2wcHsCnDSRlQSc6TE1Wnf
         rlW4qh3oWy3Qeo9Wu5FOz1HVlrMU5Wr2Yg+y1ols/BK+Vl36ZyNqKxQ7I72o4pR+Mbpg
         MQvrlYZsegGKzXFRHPCA9H/0X27k3IyKvaK/ISWR4tCvqfL6w6WLJGYC+d1M9O0tkzqX
         Re3ru0cS6l/egUk7HyrhiE/AegRHQVZ5sOvdhK4zBW8VBNDlssyaOLW/yH3OqbAv+TxH
         fvcJLPm+w/qoLyXWzcrr19ttNrrD+507D1gYj0MGAbNUL2mQuqA9tEz9sz9pPdL6optS
         eRrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject:date
         :in-reply-to:message-id:mime-version;
        bh=xzD+fvNee9njgyoYpg+UfIIsMfFdbgQCkyRxjeUcLZs=;
        b=0anZ32rEQCG1v2lPqUg3wvMYTXzL9ShGSnIPmSkrCPDoDZ8nBFM7CSh9xaS414oT1L
         Ejhdz87GWikNHzGMo1XauQfjDyt7Vu77LPPIo/GQDbAEYFwG9PtoV4yzcNG/bNvTK93P
         AofuCvF5OJSiW7W5PAPdc3c7il9JeBkwilE8NARirzJoBfdZaqmdkw9mj+pPk1r03Iaz
         a0K+I7zq3PJAXlUmZdRoVuBmsirC1j4RSe4c6ksPWRqX2oQajutK4QXzGO007IAEwQUN
         RUj1n5PpIcdk3HYiMWJxsGlXEsbQ/ylB2+ZsqBAfvhHhcW42dxH4nySqD8nxi0pUhPt6
         Tr+g==
X-Gm-Message-State: AOAM5333liO+TBqIZolEJ9odFeHkWQfmWicU/d0gD6HuMLuk7iZkj+4o
        pv200ymAKSXrITdZ5cm/BGIxNw==
X-Google-Smtp-Source: ABdhPJxQ7umiOemEiVDSGIoLE5STLtbE5klLfGxPCsiVM1g38HO04FwYGlUrBw0KI+h5aWAwhv4J1g==
X-Received: by 2002:adf:f804:: with SMTP id s4mr933990wrp.672.1642715578424;
        Thu, 20 Jan 2022 13:52:58 -0800 (PST)
Received: from localhost (82-65-169-74.subs.proxad.net. [82.65.169.74])
        by smtp.gmail.com with ESMTPSA id a26sm8552337wmb.37.2022.01.20.13.52.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jan 2022 13:52:57 -0800 (PST)
References: <20220118030911.12815-1-yu.tu@amlogic.com>
 <20220118030911.12815-5-yu.tu@amlogic.com>
User-agent: mu4e 1.6.10; emacs 27.1
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Yu Tu <yu.tu@amlogic.com>, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH V6 4/5] tty: serial: meson: Make some bit of the REG5
 register writable
Date:   Thu, 20 Jan 2022 22:49:28 +0100
In-reply-to: <20220118030911.12815-5-yu.tu@amlogic.com>
Message-ID: <1j7dau2hxi.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


On Tue 18 Jan 2022 at 11:09, Yu Tu <yu.tu@amlogic.com> wrote:

> The UART_REG5 register defaults to 0. The console port is set in
> ROMCODE. But other UART ports default to 0, so make bit24 and
> bit[26,27] writable so that the UART can choose a more
> appropriate clock.

Suggestion: Instead of talking bits (which is a bit cryptic) tell us
what is actually does

Something like:
 Make the internal clock source mux and divider writeable, allowing the
 uart to deviate from the settings intially applied by the ROMCode and
 using the most appropriate clocks

>
> Signed-off-by: Yu Tu <yu.tu@amlogic.com>
> ---
>  drivers/tty/serial/meson_uart.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/tty/serial/meson_uart.c b/drivers/tty/serial/meson_uart.c
> index 92fa91c825e6..4e7b2b38ab0a 100644
> --- a/drivers/tty/serial/meson_uart.c
> +++ b/drivers/tty/serial/meson_uart.c
> @@ -678,7 +678,7 @@ static int meson_uart_probe_clocks(struct uart_port *port)
>  							CLK_SET_RATE_NO_REPARENT,
>  							port->membase + AML_UART_REG5,
>  							26, 2,
> -							CLK_DIVIDER_READ_ONLY,
> +							CLK_DIVIDER_ROUND_CLOSEST,
>  							xtal_div_table, NULL);
>  		if (IS_ERR(hw))
>  			return PTR_ERR(hw);
> @@ -708,7 +708,7 @@ static int meson_uart_probe_clocks(struct uart_port *port)
>  					CLK_SET_RATE_PARENT,
>  					port->membase + AML_UART_REG5,
>  					24, 0x1,
> -					CLK_MUX_READ_ONLY,
> +					CLK_MUX_ROUND_CLOSEST,
>  					NULL, NULL);
>  	if (IS_ERR(hw))
>  		return PTR_ERR(hw);

