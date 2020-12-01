Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31202C64E7A
	for <linux-serial@archiver.kernel.org>; Tue,  1 Dec 2020 06:54:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8CF22085B
	for <linux-serial@archiver.kernel.org>; Tue,  1 Dec 2020 06:54:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727350AbgLAGyy (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 1 Dec 2020 01:54:54 -0500
Received: from mail-ej1-f66.google.com ([209.85.218.66]:40628 "EHLO
        mail-ej1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727096AbgLAGyy (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 1 Dec 2020 01:54:54 -0500
Received: by mail-ej1-f66.google.com with SMTP id x16so1853277ejj.7;
        Mon, 30 Nov 2020 22:54:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZV1alx9cQi5DBVKj0PE/L98oT12k3PzvYdb0ghwF4C4=;
        b=rELu+H7yE8kRgGfehqRgplHMpcvkCpYAQn+jIlP9rKdu+VenW93OBoMzlTNG8NPWet
         +hy+5CNsIweKCYN2zQEzDUfDagsO7VDsbc8RkCxpRKmYvMbL+pQWjbu+z1Q4mIcjzIfU
         fXTqa46Zw/QqgaNIpFcWW07M0/q7/P8TXu60GM27sv9kFpj0bB3djLr0vmF/k2l4QR48
         ppl/E3C+VwVtQTzWeiKkuY0KsOV+2dXJyCKja/Mcpo4FSI/DLcbw4K2vj8kiB0ejPkPz
         mlzcms0pbv3fTJ9WdTCenUBoavE1GOSGxuDBekDdjAfyQfzYN33nawRx7has7HUMSvOl
         ofCw==
X-Gm-Message-State: AOAM533j4jP6i4xBbLHTyk+EM+uT2ccmb8r5Dnrv+XiGaPXE8wzPHXfK
        j2FkHaESqhRKltWBVjm20gU4m/r5muY=
X-Google-Smtp-Source: ABdhPJwNIqGisXxyQClu1V6mBMWKF8EilDuHvcrDMxrc7dIoYhoSYBJ5tMb3H/7AzRiV1IOcbQwVcA==
X-Received: by 2002:a17:906:4348:: with SMTP id z8mr1659550ejm.119.1606805651808;
        Mon, 30 Nov 2020 22:54:11 -0800 (PST)
Received: from ?IPv6:2a0b:e7c0:0:107::49? ([2a0b:e7c0:0:107::49])
        by smtp.gmail.com with ESMTPSA id b17sm343622eju.76.2020.11.30.22.54.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Nov 2020 22:54:10 -0800 (PST)
Subject: Re: [PATCH 5/5] USB: serial: ftdi_sio: add support for FreeCalypso
 DUART28C adapter
To:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Mychaela N . Falconia" <falcon@freecalypso.org>,
        linux-serial@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20201130153742.9163-1-johan@kernel.org>
 <20201130153742.9163-6-johan@kernel.org>
From:   Jiri Slaby <jirislaby@kernel.org>
Message-ID: <8f38320e-0f1c-c8a0-208e-2fa689be52f0@kernel.org>
Date:   Tue, 1 Dec 2020 07:54:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201130153742.9163-6-johan@kernel.org>
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 30. 11. 20, 16:37, Johan Hovold wrote:
> --- a/drivers/usb/serial/ftdi_sio.c
> +++ b/drivers/usb/serial/ftdi_sio.c
...
> @@ -2386,6 +2393,21 @@ static int ftdi_stmclite_probe(struct usb_serial *serial)
>   	return 0;
>   }
>   
> +/*
> + * FreeCalypso DUART28C is an FT2232D-based USB to dual UART adapter
> + * with a special quirk: Channel B RTS and DTR outputs (BDBUS2 and BDBUS4
> + * on the chip) have been repurposed to drive PWON and RESET controls.
> + */
> +static void ftdi_duart28c_setup(struct usb_serial_port *port)
> +{
> +	struct usb_serial *serial = port->serial;
> +	struct usb_interface *intf = serial->interface;
> +	int ifnum = intf->cur_altsetting->desc.bInterfaceNumber;
> +
> +	if (ifnum == 1)
> +		tty_port_set_nordy(&port->port, 1);

So s/1/true, provided the parameter is defined as bool now.

thanks,
-- 
js
