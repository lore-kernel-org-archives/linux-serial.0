Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E802C6FD1D
	for <linux-serial@archiver.kernel.org>; Mon, 27 Mar 2023 15:11:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232666AbjC0PL2 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 27 Mar 2023 11:11:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232523AbjC0PL1 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 27 Mar 2023 11:11:27 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED9E33C1B
        for <linux-serial@vger.kernel.org>; Mon, 27 Mar 2023 08:11:16 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id g17so11903186lfv.4
        for <linux-serial@vger.kernel.org>; Mon, 27 Mar 2023 08:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679929875;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=M/m2d2cpr0u0mENErOZs6fKG3ZMIMx4Lh0v4RM7/bmM=;
        b=ZugIrca1ySnU3VFI4e6jpNQjnVMvyDRCO989hZiDcT68tAMd9caRg0w5MAcR3vCTDC
         z4GKjFuTeqCbnYpNDzjv2P2P0orEg6D3DN+pjT5BCMBGj7SE3gvxFa8e9nTurDVxSW1y
         hV5li0S+jrEXSzNnkFJ1mtZpbbrHJzpaDjdyFXlnSBCQhHk0sHgh35hGb/pMjwV+LGs+
         dh+VfzNH2pIzlXIS8r9+KSZPr0umJznCQdYC43v+V2j0Mz7nincsFuYC8bvafHMvomIx
         gwRhEtbJHYPqFfaNYMiaHq7fI2GVRMUiOk7CyVXkdCUKXfTABXE8KtvxNStdbhZVQUJb
         FikQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679929875;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M/m2d2cpr0u0mENErOZs6fKG3ZMIMx4Lh0v4RM7/bmM=;
        b=llu69ID8UJQHokEfRPblszqykhk2RuvDeql0oeWsR+KCwbLy80CjLcGtCu4entVEDI
         E5S14SbIIfHctUwckfed/98LygoTkPLoMa5ros1vbA5PXwe7ftTD6xpkMyVqtpR4436I
         /5312ndJCIt24uIe+JNDwpB356wfrzRs2ehGNTVjOgTYrjYbNm4jVbmgGNJ1H7rv4CHm
         F6XQshmjdh7TO+6Adss9gOEcaRWp67mhU7+llPnQjq0ENEyd2xfHSw0lFnGms0kDod7j
         fhsH3UmtgMcXdREo27s2UxXHIgTsuNZiAwVOa66j3IzzwR+SxKPOo03Nop5fmRFHn1XX
         qETw==
X-Gm-Message-State: AAQBX9cAq+z8gsbV7RH5j0CtbOp1K5PJZd3zAHXtncPiOaKqWOzg6BRl
        Z1dImVgs8ttHb3vob9y7gDQ=
X-Google-Smtp-Source: AKy350Z+oNTAEN1qA2lvwoUrGWwjtShCQ04QsVgluSEB33qfzytXmu9qLbPJfBo0qR2pfSBY/ufybQ==
X-Received: by 2002:ac2:555a:0:b0:4e8:45d5:53bf with SMTP id l26-20020ac2555a000000b004e845d553bfmr3280533lfk.40.1679929875106;
        Mon, 27 Mar 2023 08:11:15 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id u4-20020ac248a4000000b004cb8de497ffsm4652546lfg.154.2023.03.27.08.11.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 08:11:13 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Stefan Wahren <stefan.wahren@i2se.com>
Cc:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Ilpo =?utf-8?Q?J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Stefan Wahren <stefan.wahren@chargebyte.com>,
        linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Tomasz =?utf-8?Q?Mo=C5=84?= <tomasz.mon@camlingroup.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: Regression: serial: imx: overrun errors on debug UART
References: <2c29454b-9369-4360-8eb4-c151f59460cb@i2se.com>
        <d660e3cf-5686-d989-3b59-efe83ec9d590@linux.intel.com>
        <CAOMZO5A+GujiQY-UT3Q-8o0AKujJb_4kY+5L4x1e07ovGfo31w@mail.gmail.com>
        <9e22f237-f3ee-0415-9e6b-89a137769b8f@i2se.com>
        <5d59dec6-9f6f-7b20-1221-f57c94b29cca@i2se.com>
        <20230325151100.mskydt3hwbnspqp4@pengutronix.de>
        <cb16ddb7-f22f-d637-8670-bccc77add0af@i2se.com>
Date:   Mon, 27 Mar 2023 18:11:12 +0300
In-Reply-To: <cb16ddb7-f22f-d637-8670-bccc77add0af@i2se.com> (Stefan Wahren's
        message of "Mon, 27 Mar 2023 16:42:23 +0200")
Message-ID: <87mt3ynsa7.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Stefan Wahren <stefan.wahren@i2se.com> writes:

> Hi,
>
> Am 25.03.23 um 16:11 schrieb Uwe Kleine-König:

[...]

> today i had time to do some testing. At first i tested with different RXTL_DEFAULT values.
>
> 1 No overrun
> 2 No overrun
> 4 No overrun
> 8 Overruns
>
> After that i look at the # echo 0 > /proc/sys/kernel/printk approach,
> but this didn't change anything. The kernel is usually silent about
> log message after boot and the console works still with echo.
> Enforcing some driver to call printk periodically would make the
> console unusuable.

As you figured that printk() is not the cause, it must be something else
that causes overruns, so there is no need to check printk case further.

>
> Finally i tried to disabled the spin_lock in imx_uart_console_write:
>
> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> index f07c4f9ff13c..c342559ff1a2 100644
> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> @@ -2007,14 +2007,12 @@ imx_uart_console_write(struct console *co, const char *s, unsigned int count)
>  	struct imx_port_ucrs old_ucr;
>  	unsigned long flags;
>  	unsigned int ucr1;
> -	int locked = 1;
> +	int locked = 0;
>
>  	if (sport->port.sysrq)
>  		locked = 0;
>  	else if (oops_in_progress)
>  		locked = spin_trylock_irqsave(&sport->port.lock, flags);
> -	else
> -		spin_lock_irqsave(&sport->port.lock, flags);
>
>  	/*
>  	 *	First, save UCR1/2/3 and then disable interrupts
>
> But the overruns still occured. Is this because the serial core
> already helds a lock?

This probably isn't even called when there is no printk() output, as
user-space writes to /dev/console are rather performed through regular
generic code, AFAIK.

Best regards,
-- Sergey Organov
