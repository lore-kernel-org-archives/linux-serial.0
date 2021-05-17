Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA4A7C433B4
	for <linux-serial@archiver.kernel.org>; Mon, 17 May 2021 08:25:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F44561209
	for <linux-serial@archiver.kernel.org>; Mon, 17 May 2021 08:25:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235658AbhEQI1G (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 17 May 2021 04:27:06 -0400
Received: from mail-ej1-f44.google.com ([209.85.218.44]:37432 "EHLO
        mail-ej1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235599AbhEQI1F (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 17 May 2021 04:27:05 -0400
Received: by mail-ej1-f44.google.com with SMTP id et19so810898ejc.4;
        Mon, 17 May 2021 01:25:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zlEP3w+94KRiLe6VBAU5FX/rnIZsbArHdn1PJkGhu/w=;
        b=rqrye2H5JrwHeNZM/NIhM2t3tXRyM8o6FoaHCUj0ocLwGBe1UOjepDuXf37dE9sUX0
         xF86S5ACLkcJE9HROT9J5wVTXZhEgLL6yuBInnfMj2fPR/IYJ6TPX2+DP0tv4joDH/mR
         OMLdBG6OeyTygGzbaSW5+NfUuoc5kkrvG50VYzYZ7017WUKXqHBxyXveQjptjJVid+Kn
         09jPdGmDgvShZpCjn8kOErEG4Ti940wkbFqEyxn4ugoi8eOa35DK6txJAXebbXOy5OPd
         xxaiP7cNc/uhTTZVN0uG4r7ZTdLqGYrEmy2hJgY2bqgCbNQ9a7AypE/AjHaNeQtP3BAg
         d4mQ==
X-Gm-Message-State: AOAM530CXHO1kRRnwtQ3tqSJ79ZsA7UVf/aOkKTD7MMzyhXQqrAnmQmp
        faHAeSd39m3cOd5pmsLRK9SgBOTQVLT1aA==
X-Google-Smtp-Source: ABdhPJyqqz3mcU71IqpGIyIUK/HQ/Lm1GTsUPyLxcZAw9oL1LIwER0Hox94JVW4oWm3lJmSdGPtG0A==
X-Received: by 2002:a17:906:4155:: with SMTP id l21mr10207322ejk.424.1621239947675;
        Mon, 17 May 2021 01:25:47 -0700 (PDT)
Received: from ?IPv6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id n12sm756976edr.84.2021.05.17.01.25.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 May 2021 01:25:47 -0700 (PDT)
Subject: Re: [PATCH] serial/liteuart; Add support for earlycon
To:     Stafford Horne <shorne@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Florent Kermarrec <florent@enjoy-digital.fr>,
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
 <adb78be2-18a6-224d-1fa7-36b7912fa1cf@kernel.org> <YKIn6PHlGGsK+70W@antec>
From:   Jiri Slaby <jirislaby@kernel.org>
Message-ID: <d17a43ab-facf-8ffb-5147-7492fb85b0b5@kernel.org>
Date:   Mon, 17 May 2021 10:25:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <YKIn6PHlGGsK+70W@antec>
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 17. 05. 21, 10:23, Stafford Horne wrote:
> On Mon, May 17, 2021 at 10:16:43AM +0200, Jiri Slaby wrote:
>> On 15. 05. 21, 10:45, Stafford Horne wrote:
>>> Most litex boards using RISC-V soft cores us the sbi earlycon, however
>>> this is not available for non RISC-V litex SoC.  This patch enables
>>> earlycon for liteuart which is available on all Litex SoC's making
>>> support for earycon debugging more widely available.
>>>
>>> Signed-off-by: Stafford Horne <shorne@gmail.com>
>>> Cc: Florent Kermarrec <florent@enjoy-digital.fr>
>>> Cc: Mateusz Holenko <mholenko@antmicro.com>
>>> Cc: Joel Stanley <joel@jms.id.au>
>>> Cc: Gabriel L. Somlo <gsomlo@gmail.com>
>>> ---
>>>    .../admin-guide/kernel-parameters.txt         |  5 +++
>>>    drivers/tty/serial/Kconfig                    |  1 +
>>>    drivers/tty/serial/liteuart.c                 | 31 +++++++++++++++++++
>>>    3 files changed, 37 insertions(+)
>>>
>>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>>> index 04545725f187..2d4a43af8de2 100644
>>> --- a/Documentation/admin-guide/kernel-parameters.txt
>>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>>> @@ -1084,6 +1084,11 @@
>>>    			the driver will use only 32-bit accessors to read/write
>>>    			the device registers.
>>> +		liteuart,<addr>
>>> +			Start an early console on a litex serial port at the
>>> +			specified address. The serial port must already be
>>> +			setup and configured. Options are not yet supported.
>>> +
>>>    		meson,<addr>
>>>    			Start an early, polled-mode console on a meson serial
>>>    			port at the specified address. The serial port must
>>> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
>>> index 0c4cd4a348f4..9ceffe6ab6fd 100644
>>> --- a/drivers/tty/serial/Kconfig
>>> +++ b/drivers/tty/serial/Kconfig
>>> @@ -1531,6 +1531,7 @@ config SERIAL_LITEUART
>>>    	depends on OF || COMPILE_TEST
>>>    	depends on LITEX
>>>    	select SERIAL_CORE
>>> +	select SERIAL_EARLYCON
>>>    	help
>>>    	  This driver is for the FPGA-based LiteUART serial controller from LiteX
>>>    	  SoC builder.
>>> diff --git a/drivers/tty/serial/liteuart.c b/drivers/tty/serial/liteuart.c
>>> index 64842f3539e1..38c472487e68 100644
>>> --- a/drivers/tty/serial/liteuart.c
>>> +++ b/drivers/tty/serial/liteuart.c
>>> @@ -372,6 +372,37 @@ static int __init liteuart_console_init(void)
>>>    console_initcall(liteuart_console_init);
>>>    #endif /* CONFIG_SERIAL_LITEUART_CONSOLE */
>>> +#ifdef CONFIG_SERIAL_EARLYCON
>>> +static void early_liteuart_putc(struct uart_port *port, int c)
>>> +{
>>> +	while (litex_read8(port->membase + OFF_TXFULL))
>>> +		cpu_relax();
>>> +
>>> +	litex_write8(port->membase + OFF_RXTX, c);
>>
>> Hi,
>>
>> am I missing something or this doesn't differ to liteuart_putchar?
> 
> Hi, No you are right, I missed that thanks for catching it.
> 
> I should be able to remove this function and use putchar below.

OK.

I've just noticed you add an ifdef CONFIG_SERIAL_EARLYCON here, but you 
select SERIAL_EARLYCON in Kconfig above. So the ifdef is sort of 
pointless? (Or you shouldn't select SERIAL_EARLYCON.)

thanks,
-- 
js
suse labs
