Return-Path: <SRS0=PCYV=4X=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64562C10DCE
	for <linux-serial@archiver.kernel.org>; Fri,  6 Mar 2020 18:14:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21FC920578
	for <linux-serial@archiver.kernel.org>; Fri,  6 Mar 2020 18:14:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="Lx0/Y/2X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726231AbgCFSN7 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 6 Mar 2020 13:13:59 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45449 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726194AbgCFSN7 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 6 Mar 2020 13:13:59 -0500
Received: by mail-pf1-f194.google.com with SMTP id 2so1468304pfg.12
        for <linux-serial@vger.kernel.org>; Fri, 06 Mar 2020 10:13:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=A5r22t8RnPQzcWCsNYP4RTrGIgpLaK+HmX8FXjmos5o=;
        b=Lx0/Y/2XKX+4LtXUw0A4wEuvdCD+qugK+BGtJQx+9itY0fWPwP5PGJ72gD6ncOWLP4
         JyQ83kBDrv9iq6Aj3JgTf9T4aMuyDPuuwclqMd4o/sefJ/3lPnw3MGaXKxDkIXdBsw6c
         ZBwgxI7SbT5tGnCLEGhCusPeUMyS3mqymS5nDLWflMC57+tI0CcQlBJyzwOely5Mhbv0
         eBAobp3LLa+KjUERm9aqPzAGEdnHrP+jP6yPDPjRhKhGpzOXwV3hS6GIiTTSpmhCxc7H
         VObppcLeVc1011OEhvzhy8krjr1o5OT4kzBZNuC/muf7615oInfitSv7NHXNPVEgh0ML
         iUVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=A5r22t8RnPQzcWCsNYP4RTrGIgpLaK+HmX8FXjmos5o=;
        b=R1bEgkDkmVoHkdjAQlbMRnReQQcRrLRK/hlx0Zjyl70+KDrG7EfnqlJSslkGNQ0YzU
         wLNiHlykZ9Bdt0t72xKOgRaVH9DpKrz6XhFKqbfKhjAR3J/bZSYvGU7qLjtgIqcazOJs
         ROKDJUZVt4vbM2p2XBSm0hoW+ofXOjcCoKYBcSHPG9RTNMziaD6w8BJ4G2KJw6oSuT1h
         bDpWMCaraNMtnqm4wv4KJvz+Ohau3eh3dQNo3FkRkDS+Y7oPMbrQWhug/nk3lnk8DOnv
         5Q8oqCieFa7LZg4VwN0ogsyrU/hjiVHW4FQ9hckU8SGRIfKXWjk/ouHzzafvI5sfjoei
         uNNQ==
X-Gm-Message-State: ANhLgQ2HvJrSmH/9uwbC179/V3m4TBD4lesTv75C0X6DxMWSQU0N84WJ
        wibTChdFA0BpdDON476u9YJFifYyx28=
X-Google-Smtp-Source: ADFU+vtQNo1LEfG6NL1KkIdn1s/hz7jQfYK5hgLju3hox6x8NaKZkqXyn1/AZ5jC2+nAqOmDUEMMzg==
X-Received: by 2002:aa7:96c7:: with SMTP id h7mr4809574pfq.211.1583518437534;
        Fri, 06 Mar 2020 10:13:57 -0800 (PST)
Received: from localhost ([2620:0:1000:2514:23a5:d584:6a92:3e3c])
        by smtp.gmail.com with ESMTPSA id d10sm9821948pjc.34.2020.03.06.10.13.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2020 10:13:56 -0800 (PST)
Date:   Fri, 06 Mar 2020 10:13:56 -0800 (PST)
X-Google-Original-Date: Fri, 06 Mar 2020 10:13:55 PST (-0800)
Subject:     Re: [PATCH] tty: serial: Add CONSOLE_POLL support to SiFive UART
In-Reply-To: <1583224900-25824-1-git-send-email-vincent.chen@sifive.com>
CC:     linux-serial@vger.kernel.org, linux-riscv@lists.infradead.org,
        vincent.chen@sifive.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     vincent.chen@sifive.com, Greg KH <gregkh@linuxfoundation.org>,
        jslaby@suse.com, Paul Walmsley <paul.walmsley@sifive.com>
Message-ID: <mhng-cf4b7d3b-9841-44a1-9ffd-ac7f4cdeb75d@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, 03 Mar 2020 00:41:40 PST (-0800), vincent.chen@sifive.com wrote:
> Add CONSOLE_POLL support for future KGDB porting.
>
> Signed-off-by: Vincent Chen <vincent.chen@sifive.com>
> ---
>  drivers/tty/serial/sifive.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
>
> diff --git a/drivers/tty/serial/sifive.c b/drivers/tty/serial/sifive.c
> index d5f81b98e4d7..acdbaca4de36 100644
> --- a/drivers/tty/serial/sifive.c
> +++ b/drivers/tty/serial/sifive.c
> @@ -818,6 +818,29 @@ static int __init sifive_serial_console_setup(struct console *co, char *options)
>  	return uart_set_options(&ssp->port, co, baud, parity, bits, flow);
>  }
>
> +#ifdef CONFIG_CONSOLE_POLL
> +static int sifive_serial_poll_get_char(struct uart_port *port)
> +{
> +	struct sifive_serial_port *ssp = port_to_sifive_serial_port(port);
> +	char is_empty, ch;
> +
> +	ch = __ssp_receive_char(ssp, &is_empty);
> +	if (is_empty)
> +		return NO_POLL_CHAR;
> +
> +	return ch;
> +}
> +
> +static void sifive_serial_poll_put_char(struct uart_port *port,
> +					unsigned char c)
> +{
> +	struct sifive_serial_port *ssp = port_to_sifive_serial_port(port);
> +
> +	sifive_serial_console_putchar(port, c);
> +	__ssp_wait_for_xmitr(ssp);

So we still have that TX watermark bug in the SiFive UARTs.  If this function
is supposed to wait until the word is actually out on the line then this isn't
sufficient, but if it's just supposed to wait until the next write won't block
then this is fine.

I'm not really a serial person, so mabye someone else knows?  For those
unfamiliar with the issue, there's a pretty good description in the patch to
fix it

    https://github.com/sifive/sifive-blocks/pull/90

Poking around we don't have any PRE_RATE_CHANGE hook, so I'm going to take a
whack at adding one -- not really related to this patch, though.

> +}
> +#endif /* CONFIG_CONSOLE_POLL */
> +
>  static struct uart_driver sifive_serial_uart_driver;
>
>  static struct console sifive_serial_console = {
> @@ -877,6 +900,10 @@ static const struct uart_ops sifive_serial_uops = {
>  	.request_port	= sifive_serial_request_port,
>  	.config_port	= sifive_serial_config_port,
>  	.verify_port	= sifive_serial_verify_port,
> +#ifdef CONFIG_CONSOLE_POLL
> +	.poll_get_char	= sifive_serial_poll_get_char,
> +	.poll_put_char	= sifive_serial_poll_put_char,
> +#endif
>  };
>
>  static struct uart_driver sifive_serial_uart_driver = {
