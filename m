Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C80ECC64E8A
	for <linux-serial@archiver.kernel.org>; Tue,  1 Dec 2020 05:49:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 756E32168B
	for <linux-serial@archiver.kernel.org>; Tue,  1 Dec 2020 05:49:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726284AbgLAFt6 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 1 Dec 2020 00:49:58 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:44376 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725979AbgLAFt5 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 1 Dec 2020 00:49:57 -0500
Received: by mail-ed1-f67.google.com with SMTP id l5so1312693edq.11;
        Mon, 30 Nov 2020 21:49:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=il4OrsFi/+ZmpHKzmwybykJE1rrEwD0WSXk3jzdi72I=;
        b=fLn4lHcnXpH57H3ulw7kQpTsSQnQipnq35POuw4tZHmaTmEmXLB1XPakkRSRdPuWXM
         qGTJwPE+ServoGSlJkVgT91O+yEnO0hrlhCVOrM6OMqH6fwmy6cE2LE0kKQjP324iyAc
         H/f4+9TxriyY0H7dV9xnfBuXkd0VkOGJkSx3oPrBTvNHWR0fw6PeD/1bkVAvag0tQbqP
         Hdu9F95IP7rdaTKSXGbaIao75SYcRYYaIHrsk8RO+LOiz1BYaWA0+hYyfdg/DAnvmS9o
         Br3LZ5NyQNEWxct4yzoFKO88BHLJLJwfOanX4+ISYLn7T3mR5D0fegIAvOtF3PQbqn/n
         5xEA==
X-Gm-Message-State: AOAM530OLdicD/W3IPUZvAXQ9OpcQAEmBdEmdeEJbooVz8kvYCbgzkdP
        X+XxDUm9aXJsvfK8qytNVIBg/1wB8+0=
X-Google-Smtp-Source: ABdhPJwWPMSyk47AyVrRNMUatJNVHKwfArNXreja8lzZqzEHNBW6hFp0/8fHekt7sABXqBrcUmC7GQ==
X-Received: by 2002:a50:fe14:: with SMTP id f20mr1343583edt.61.1606801749749;
        Mon, 30 Nov 2020 21:49:09 -0800 (PST)
Received: from ?IPv6:2a0b:e7c0:0:107::49? ([2a0b:e7c0:0:107::49])
        by smtp.gmail.com with ESMTPSA id g15sm251467edj.49.2020.11.30.21.49.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Nov 2020 21:49:08 -0800 (PST)
Subject: Re: [PATCH 1/5] tty: add port flag to suppress ready signalling on
 open
To:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Mychaela N . Falconia" <falcon@freecalypso.org>,
        linux-serial@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20201130153742.9163-1-johan@kernel.org>
 <20201130153742.9163-2-johan@kernel.org>
From:   Jiri Slaby <jirislaby@kernel.org>
Message-ID: <ffec9dbe-a238-4411-acdb-41bd33719288@kernel.org>
Date:   Tue, 1 Dec 2020 06:49:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201130153742.9163-2-johan@kernel.org>
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 30. 11. 20, 16:37, Johan Hovold wrote:
> --- a/include/linux/tty.h
> +++ b/include/linux/tty.h
> @@ -683,6 +684,19 @@ static inline void tty_port_set_kopened(struct tty_port *port, bool val)
>   		clear_bit(TTY_PORT_KOPENED, &port->iflags);
>   }
>   
> +static inline bool tty_port_nordy(struct tty_port *port)

port can be const here.

> +{
> +	return test_bit(TTY_PORT_NORDY, &port->iflags);
> +}
> +
> +static inline void tty_port_set_nordy(struct tty_port *port, bool val)
> +{
> +	if (val)
> +		set_bit(TTY_PORT_NORDY, &port->iflags);
> +	else
> +		clear_bit(TTY_PORT_NORDY, &port->iflags);

We have assign_bit() for these cases these days.

thanks,
-- 
js
