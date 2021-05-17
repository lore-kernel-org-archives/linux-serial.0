Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 132A4C433B4
	for <linux-serial@archiver.kernel.org>; Mon, 17 May 2021 08:18:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB14761206
	for <linux-serial@archiver.kernel.org>; Mon, 17 May 2021 08:18:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235316AbhEQIUF (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 17 May 2021 04:20:05 -0400
Received: from mail-wr1-f51.google.com ([209.85.221.51]:45906 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235599AbhEQISq (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 17 May 2021 04:18:46 -0400
Received: by mail-wr1-f51.google.com with SMTP id h4so5355519wrt.12;
        Mon, 17 May 2021 01:16:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/Y2QrCRbgx4kkWGGhnIXaAKNy2eEk4cnk8Q73oTRaog=;
        b=jvqo4v0KjoGK1OiB4y/nt8VZ24osX5AoENqE9tqr7UKRjFpbKKjoAJuiGlkDi3jNlX
         QBNLzMDbvJe7RydLP82jyqFd9AULEkAm4UWUveZ7gn9ZahFKcU9vEqYoljewR1F5M9IO
         nEDFBC5R7TX8j9kHRFVDpP7Td2cpAsrFdAVc4N1e2bpBhMeLBNFRM0T7Psky6Xgxr8J6
         0Sebb8WlnTA/NT2e033oxVPJl9XCnX21YNkzQqyTu8G6ClldoCaWn8g1eKECbWr2H55j
         GA76VBy/XuiXyr1tfyJvLJ0OZacXhnMlsDhGZkrQZ2vaxfKTYH+BpJj1ncXZaK21mon6
         5DTQ==
X-Gm-Message-State: AOAM532YqkCHTAlzu2gWFIOibTUQiI5CfrtyHXAlPAFK24ML5+ceDqH5
        GUYHIcoCLEgqPvmIdNr6RET/1tHmCmlRsw==
X-Google-Smtp-Source: ABdhPJwsaGVaUkWkqBwdPutyb4HRLDGXVw8nVUNEV19this1HDQZShT/AcoiInPmyw3/lx1ajHpG9A==
X-Received: by 2002:a5d:410e:: with SMTP id l14mr27744330wrp.230.1621239405371;
        Mon, 17 May 2021 01:16:45 -0700 (PDT)
Received: from ?IPv6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id f7sm18015993wrg.34.2021.05.17.01.16.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 May 2021 01:16:44 -0700 (PDT)
Subject: Re: [PATCH] serial/liteuart; Add support for earlycon
To:     Stafford Horne <shorne@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Florent Kermarrec <florent@enjoy-digital.fr>,
        Mateusz Holenko <mholenko@antmicro.com>,
        Joel Stanley <joel@jms.id.au>,
        "Gabriel L . Somlo" <gsomlo@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Karol Gugala <kgugala@antmicro.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-doc@vger.kernel.org, linux-serial@vger.kernel.org
References: <20210515084519.167343-1-shorne@gmail.com>
From:   Jiri Slaby <jirislaby@kernel.org>
Message-ID: <adb78be2-18a6-224d-1fa7-36b7912fa1cf@kernel.org>
Date:   Mon, 17 May 2021 10:16:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210515084519.167343-1-shorne@gmail.com>
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 15. 05. 21, 10:45, Stafford Horne wrote:
> Most litex boards using RISC-V soft cores us the sbi earlycon, however
> this is not available for non RISC-V litex SoC.  This patch enables
> earlycon for liteuart which is available on all Litex SoC's making
> support for earycon debugging more widely available.
> 
> Signed-off-by: Stafford Horne <shorne@gmail.com>
> Cc: Florent Kermarrec <florent@enjoy-digital.fr>
> Cc: Mateusz Holenko <mholenko@antmicro.com>
> Cc: Joel Stanley <joel@jms.id.au>
> Cc: Gabriel L. Somlo <gsomlo@gmail.com>
> ---
>   .../admin-guide/kernel-parameters.txt         |  5 +++
>   drivers/tty/serial/Kconfig                    |  1 +
>   drivers/tty/serial/liteuart.c                 | 31 +++++++++++++++++++
>   3 files changed, 37 insertions(+)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 04545725f187..2d4a43af8de2 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -1084,6 +1084,11 @@
>   			the driver will use only 32-bit accessors to read/write
>   			the device registers.
>   
> +		liteuart,<addr>
> +			Start an early console on a litex serial port at the
> +			specified address. The serial port must already be
> +			setup and configured. Options are not yet supported.
> +
>   		meson,<addr>
>   			Start an early, polled-mode console on a meson serial
>   			port at the specified address. The serial port must
> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> index 0c4cd4a348f4..9ceffe6ab6fd 100644
> --- a/drivers/tty/serial/Kconfig
> +++ b/drivers/tty/serial/Kconfig
> @@ -1531,6 +1531,7 @@ config SERIAL_LITEUART
>   	depends on OF || COMPILE_TEST
>   	depends on LITEX
>   	select SERIAL_CORE
> +	select SERIAL_EARLYCON
>   	help
>   	  This driver is for the FPGA-based LiteUART serial controller from LiteX
>   	  SoC builder.
> diff --git a/drivers/tty/serial/liteuart.c b/drivers/tty/serial/liteuart.c
> index 64842f3539e1..38c472487e68 100644
> --- a/drivers/tty/serial/liteuart.c
> +++ b/drivers/tty/serial/liteuart.c
> @@ -372,6 +372,37 @@ static int __init liteuart_console_init(void)
>   console_initcall(liteuart_console_init);
>   #endif /* CONFIG_SERIAL_LITEUART_CONSOLE */
>   
> +#ifdef CONFIG_SERIAL_EARLYCON
> +static void early_liteuart_putc(struct uart_port *port, int c)
> +{
> +	while (litex_read8(port->membase + OFF_TXFULL))
> +		cpu_relax();
> +
> +	litex_write8(port->membase + OFF_RXTX, c);

Hi,

am I missing something or this doesn't differ to liteuart_putchar?

> +}
> +
> +static void early_liteuart_write(struct console *console, const char *s,
> +				    unsigned int count)
> +{
> +	struct earlycon_device *device = console->data;
> +	struct uart_port *port = &device->port;
> +
> +	uart_console_write(port, s, count, early_liteuart_putc);
> +}
> +
> +static int __init early_liteuart_setup(struct earlycon_device *device,
> +				       const char *options)
> +{
> +	if (!device->port.membase)
> +		return -ENODEV;
> +
> +	device->con->write = early_liteuart_write;
> +	return 0;
> +}
> +
> +OF_EARLYCON_DECLARE(liteuart, "litex,liteuart", early_liteuart_setup);
> +#endif /* CONFIG_SERIAL_EARLYCON */
> +
>   static int __init liteuart_init(void)
>   {
>   	int res;
> 


-- 
js
suse labs
