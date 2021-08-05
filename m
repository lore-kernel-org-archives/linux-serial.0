Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE001C432BE
	for <linux-serial@archiver.kernel.org>; Thu,  5 Aug 2021 07:33:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2CBE60F94
	for <linux-serial@archiver.kernel.org>; Thu,  5 Aug 2021 07:33:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238641AbhHEHdZ (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 5 Aug 2021 03:33:25 -0400
Received: from mail-wm1-f48.google.com ([209.85.128.48]:42843 "EHLO
        mail-wm1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232167AbhHEHdZ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 5 Aug 2021 03:33:25 -0400
Received: by mail-wm1-f48.google.com with SMTP id e25-20020a05600c4b99b0290253418ba0fbso2995047wmp.1;
        Thu, 05 Aug 2021 00:33:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5wZuuujjZhQ98/456Q9kMIghIjkA/UTIrOKycSTFZHw=;
        b=H5uRawg+3/PV+62FETLflOrEfACrfLgNTNrSBJaBIBc7W6d+WoRr6mgFuhhGD+BrE6
         j2y5iKK7JKrF5RvdPcaqwd7lSB4Df8B3PPCwtMPi7/uOQE3nXmPoO9o7g22Dl94uZKN+
         rdPlRPMiyDzzIXZHX2LwXx3I4Ft5eMRktKR0wl6l13EGuAcPkwy0vvbLQYSWD8yD1Zk9
         zbLkAsYWTo7gUmGEUyh8WIJQxInBeOVHdEBuvpgQCuZREpRHLUbjv9WLJt5X5+Zhfj6B
         H4kgOAdq2UccYcHFHRpaQelEV7NqQEO1sgQV/4a0Xn7oVgmYfKMQGq2sC1Vf5YbpFShr
         CFWw==
X-Gm-Message-State: AOAM53000eolJ9tj7Jl5hkNB/FS5u30lx0qQrYQfeHFnCugHx+7k2S4l
        SdRMeWkWwF6OGdZAyG/Zm6E=
X-Google-Smtp-Source: ABdhPJwMxu6tlerwNRVlrgAqXcf81Rys3idaRL/j+fVDB3fD4clgvFygF84qShZoyM/IkQSC2Snqjw==
X-Received: by 2002:a05:600c:1c89:: with SMTP id k9mr3483984wms.78.1628148790559;
        Thu, 05 Aug 2021 00:33:10 -0700 (PDT)
Received: from ?IPv6:2a0b:e7c0:0:107::49? ([2a0b:e7c0:0:107::49])
        by smtp.gmail.com with ESMTPSA id b6sm5982857wrn.9.2021.08.05.00.33.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Aug 2021 00:33:10 -0700 (PDT)
Subject: Re: [PATCH v2 1/2] serdev: Split and export
 serdev_acpi_get_uart_resource()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lee Jones <lee.jones@linaro.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
Cc:     Mark Gross <mgross@linux.intel.com>, Rob Herring <robh@kernel.org>
References: <20210804142959.67981-1-andriy.shevchenko@linux.intel.com>
From:   Jiri Slaby <jirislaby@kernel.org>
Message-ID: <e34fdf56-4fdb-b422-17d6-0b35779e37b7@kernel.org>
Date:   Thu, 5 Aug 2021 09:33:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210804142959.67981-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 04. 08. 21, 16:29, Andy Shevchenko wrote:
> The same as for I²C Serial Bus resource split and export
> serdev_acpi_get_uart_resource(). We have already a few users
> one of which is converted here.
> 
> Rationale of this is to consolidate parsing UART Serial Bus
> resource in one place as it's done, e.g., for I²C Serial Bus.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> ---
> v2: added Rb tag (Hans)
>   drivers/tty/serdev/core.c | 36 +++++++++++++++++++++++++++++-------
>   include/linux/serdev.h    | 14 ++++++++++++++
>   2 files changed, 43 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
> index 92498961fd92..436e3d1ba92c 100644
> --- a/drivers/tty/serdev/core.c
> +++ b/drivers/tty/serdev/core.c
> @@ -562,23 +562,45 @@ struct acpi_serdev_lookup {
>   	int index;
>   };
>   
> +/**
> + * serdev_acpi_get_uart_resource - Gets UARTSerialBus resource if type matches
> + * @ares:	ACPI resource
> + * @uart:	Pointer to UARTSerialBus resource will be returned here
> + *
> + * Checks if the given ACPI resource is of type UARTSerialBus.
> + * In this case, returns a pointer to it to the caller.
> + *
> + * Returns true if resource type is of UARTSerialBus, otherwise false.

Better to write:
  * Return: True if resource type is of UARTSerialBus, otherwise false.
which is recognized by sphinx.

> + */
> +bool serdev_acpi_get_uart_resource(struct acpi_resource *ares,
> +				   struct acpi_resource_uart_serialbus **uart)
> +{
> +	struct acpi_resource_uart_serialbus *sb;
> +
> +	if (ares->type != ACPI_RESOURCE_TYPE_SERIAL_BUS)
> +		return false;
> +
> +	sb = &ares->data.uart_serial_bus;
> +	if (sb->type != ACPI_RESOURCE_SERIAL_TYPE_UART)
> +		return false;
> +
> +	*uart = sb;
> +	return true;

Why don't you return NULL, or sb, thus eliminating the parameter?

> +}
> +EXPORT_SYMBOL_GPL(serdev_acpi_get_uart_resource);

thanks,
-- 
js
suse labs
