Return-Path: <SRS0=XS4C=B5=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B7AFC433E1
	for <linux-serial@archiver.kernel.org>; Wed, 19 Aug 2020 06:51:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7551D2063A
	for <linux-serial@archiver.kernel.org>; Wed, 19 Aug 2020 06:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597819866;
	bh=YtGA+bHMnmTYX3eYCFdXF3Fvq1L2BUr3wwmShDyTZVA=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=AAvvuUzrf9uZ4TBNkNUaGyIMu24mq9+K5mgznbEw6fYz8E/DlGuPFWYP6pZRIrytI
	 qyH1PBt6VxLtu/biCsH0C8BCWNmYU0zbFe4Ih2FPvn1OTKJhJxpmnm7WlG74TR7iUV
	 QEJyvu+rL/SXhbrUREM1QLB0xjlf7R7fCzZqZwuo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbgHSGvG (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 19 Aug 2020 02:51:06 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:36686 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726701AbgHSGvF (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 19 Aug 2020 02:51:05 -0400
Received: by mail-ed1-f67.google.com with SMTP id ba10so17205254edb.3
        for <linux-serial@vger.kernel.org>; Tue, 18 Aug 2020 23:51:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dQdz0YbzAz7fMBAqd5KnzSATkRPJEnTNl6tRwR/LuY8=;
        b=LBmz226DrvevzvJZTBoSYr+fdsMb2FG8kaDHGARfpUAQuC84iYcw4Z/PiC6+kDiCkj
         51sfR4RFYbzDznq0nreQ4zHfpcJSGj/MNqgNH3UkESV2JKHvqg4Ldf4efhdYHh4LDnSq
         aUK/tlXHH/YWptsfVuiy3y1buUoDAyXyBKyKTwQJBqSUIajQY+P1d7DIiGabXONUQVRc
         R2ej68atEMNeiI/dKjmglvxzPq4ZWy+KQdEsQYR5HiI4TLAuaTpkxfP7BRKGnUdibrvt
         2hZ82SWgzwmSltwfn2NBz3BB/Xl2fZVZaoVfcis/Dqj0xU1dCVY72HPvZiuH/J1j9sDH
         7PFA==
X-Gm-Message-State: AOAM530ixcFgrM9dnWR/xeYCpqdFTW7xfXX6zQuha3e6bST57tHIBRaT
        aKq7NSI8e2q26LQaO3fRRKY=
X-Google-Smtp-Source: ABdhPJyAsg5yKt2JAZ31A/3+Uq3jUS9fCzuhg20FM+Epyq6pRK0a1Zs4f72I6wUIWnOacgsja4cRpg==
X-Received: by 2002:aa7:d84d:: with SMTP id f13mr22575735eds.155.1597819863072;
        Tue, 18 Aug 2020 23:51:03 -0700 (PDT)
Received: from ?IPv6:2a0b:e7c0:0:107::49? ([2a0b:e7c0:0:107::49])
        by smtp.gmail.com with ESMTPSA id p23sm13149278edm.31.2020.08.18.23.51.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Aug 2020 23:51:02 -0700 (PDT)
Subject: Re: [PATCH] serial: pl011: Don't leak amba_ports entry on driver
 register error
To:     Lukas Wunner <lukas@wunner.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Russell King <linux@armlinux.org.uk>, linux-serial@vger.kernel.org,
        Tushar Behera <tushar.behera@linaro.org>
References: <138f8c15afb2f184d8102583f8301575566064a6.1597316167.git.lukas@wunner.de>
From:   Jiri Slaby <jirislaby@kernel.org>
Message-ID: <4830ea38-6947-aa34-d04b-c143d74bb022@kernel.org>
Date:   Wed, 19 Aug 2020 08:51:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <138f8c15afb2f184d8102583f8301575566064a6.1597316167.git.lukas@wunner.de>
Content-Type: text/plain; charset=iso-8859-2
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 13. 08. 20, 12:59, Lukas Wunner wrote:
> pl011_probe() calls pl011_setup_port() to reserve an amba_ports[] entry,
> then calls pl011_register_port() to register the uart driver with the
> tty layer.
> 
> If registration of the uart driver fails, the amba_ports[] entry is not
> released.  If this happens 14 times (value of UART_NR macro), then all
> amba_ports[] entries will have been leaked and driver probing is no
> longer possible.  (To be fair, that can only happen if the DeviceTree
> doesn't contain alias IDs since they cause the same entry to be used for
> a given port.)   Fix it.
> 
> Fixes: ef2889f7ffee ("serial: pl011: Move uart_register_driver call to device")
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Cc: stable@vger.kernel.org # v3.15+
> Cc: Tushar Behera <tushar.behera@linaro.org>
> ---
>  drivers/tty/serial/amba-pl011.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
> index cd1ba8d8b0e6..67498594d7d7 100644
> --- a/drivers/tty/serial/amba-pl011.c
> +++ b/drivers/tty/serial/amba-pl011.c
> @@ -2614,7 +2614,7 @@ static int pl011_setup_port(struct device *dev, struct uart_amba_port *uap,
>  
>  static int pl011_register_port(struct uart_amba_port *uap)
>  {
> -	int ret;
> +	int ret, i;
>  
>  	/* Ensure interrupts from this UART are masked and cleared */
>  	pl011_write(0, uap, REG_IMSC);
> @@ -2625,6 +2625,9 @@ static int pl011_register_port(struct uart_amba_port *uap)
>  		if (ret < 0) {
>  			dev_err(uap->port.dev,
>  				"Failed to register AMBA-PL011 driver\n");
> +			for (i = 0; i < ARRAY_SIZE(amba_ports); i++)
> +				if (amba_ports[i] == uap)
> +					amba_ports[i] = NULL;

This doesn't look like the right place to free it. The callers should do
it instead. Or if you really want to do it here, just pass the index to
the function, so that you don't have to find it.

thanks,
-- 
js
suse labs
