Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BC1FC433ED
	for <linux-serial@archiver.kernel.org>; Tue, 18 May 2021 04:57:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D77076135C
	for <linux-serial@archiver.kernel.org>; Tue, 18 May 2021 04:57:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240482AbhERE64 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 18 May 2021 00:58:56 -0400
Received: from mail-wm1-f54.google.com ([209.85.128.54]:37589 "EHLO
        mail-wm1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237133AbhERE6z (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 18 May 2021 00:58:55 -0400
Received: by mail-wm1-f54.google.com with SMTP id f19-20020a05600c1553b02901794fafcfefso57005wmg.2;
        Mon, 17 May 2021 21:57:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8YPdF903pID1kt0ZCEYpZxpjPh8BR3iWLNlHhdqJx4Y=;
        b=W3y0CyO0hTJ9kFu7SfmIHSLhu9g3mrYtUacYmiKk9aS86WQwv3U94tEg8TYsvzr3NB
         3iUMUUy4lGetnU17y/AhlXgjP/htupMx4egtFlqLdzaSyt84SQMlHBy5v43+cOBOpjBt
         1oEYHWkvZLlBFLU+jY2GdO96Fb/VHLZvMYhJOqs+KeKkSmejFavm2ZuPILxCxlF6Zcgt
         gaGjdyzKfMuzFVUEgrRSauedwqiaVe6ToNmHflUpG0OUnp+3z4hXHuYPkeBMl4H4rjUY
         8O3RSM22/eWZxG/yAeS0eXTZevq1Miv0KsxVtzPdZQBQaMYJQ5mu3glojyOLB88u4wNa
         J1IA==
X-Gm-Message-State: AOAM530tCFUr3mF9nyDloo/slFflivzirzVl4SD31bnZyJGDnYDEZv2S
        NLwx6SiWVXKpsJ2TeUZyAaRYudXgwuEPaQ==
X-Google-Smtp-Source: ABdhPJwLFO9Lpex8Hfqil95zpacCNSO+pQ02g82d0FluUzUrrBVDhvtP8qP0Xk5FStjUQ/gl+/cKrw==
X-Received: by 2002:a1c:e90d:: with SMTP id q13mr3214017wmc.163.1621313855807;
        Mon, 17 May 2021 21:57:35 -0700 (PDT)
Received: from ?IPv6:2a0b:e7c0:0:107::49? ([2a0b:e7c0:0:107::49])
        by smtp.gmail.com with ESMTPSA id c14sm19727784wrt.77.2021.05.17.21.57.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 May 2021 21:57:35 -0700 (PDT)
Subject: Re: [PATCH v2] serial: liteuart: Add support for earlycon
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
        Vlastimil Babka <vbabka@suse.cz>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-doc@vger.kernel.org, linux-serial@vger.kernel.org
References: <20210517115453.24365-1-shorne@gmail.com>
From:   Jiri Slaby <jirislaby@kernel.org>
Message-ID: <3810b979-e94e-24dc-9a6f-e9989800f7e7@kernel.org>
Date:   Tue, 18 May 2021 06:57:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210517115453.24365-1-shorne@gmail.com>
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 17. 05. 21, 13:54, Stafford Horne wrote:
> Most litex boards using RISC-V soft cores us the sbi earlycon, however
> this is not available for non RISC-V litex SoC's.  This patch enables
> earlycon for liteuart which is available on all Litex SoC's making
> support for earycon debugging more widely available.
> 
> Signed-off-by: Stafford Horne <shorne@gmail.com>
> Cc: Florent Kermarrec <florent@enjoy-digital.fr>
> Cc: Mateusz Holenko <mholenko@antmicro.com>
> Cc: Joel Stanley <joel@jms.id.au>
> Cc: Gabriel L. Somlo <gsomlo@gmail.com>
> Reviewed-and-tested-by: Gabriel Somlo <gsomlo@gmail.com>

Reviewed-by: Jiri Slaby <jirislaby@kernel.org>

> ---
> Changes since v1:
>   - Fixed subject
>   - Fixed ifdef and config issues pointed out by Jiri
>   - Use liteuart_putchar instead of early_liteuart_putc
> 
>   .../admin-guide/kernel-parameters.txt         |  5 +++++
>   drivers/tty/serial/Kconfig                    |  1 +
>   drivers/tty/serial/liteuart.c                 | 21 +++++++++++++++++++
>   3 files changed, 27 insertions(+)
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
> index 0c4cd4a348f4..af41e534483c 100644
> --- a/drivers/tty/serial/Kconfig
> +++ b/drivers/tty/serial/Kconfig
> @@ -1550,6 +1550,7 @@ config SERIAL_LITEUART_CONSOLE
>   	bool "LiteUART serial port console support"
>   	depends on SERIAL_LITEUART=y
>   	select SERIAL_CORE_CONSOLE
> +	select SERIAL_EARLYCON
>   	help
>   	  Say 'Y' or 'M' here if you wish to use the FPGA-based LiteUART serial
>   	  controller from LiteX SoC builder as the system console
> diff --git a/drivers/tty/serial/liteuart.c b/drivers/tty/serial/liteuart.c
> index 64842f3539e1..1b75a4bf7c56 100644
> --- a/drivers/tty/serial/liteuart.c
> +++ b/drivers/tty/serial/liteuart.c
> @@ -370,6 +370,27 @@ static int __init liteuart_console_init(void)
>   	return 0;
>   }
>   console_initcall(liteuart_console_init);
> +
> +static void early_liteuart_write(struct console *console, const char *s,
> +				    unsigned int count)
> +{
> +	struct earlycon_device *device = console->data;
> +	struct uart_port *port = &device->port;
> +
> +	uart_console_write(port, s, count, liteuart_putchar);
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
>   #endif /* CONFIG_SERIAL_LITEUART_CONSOLE */
>   
>   static int __init liteuart_init(void)
> 

thanks,
-- 
js
suse labs
