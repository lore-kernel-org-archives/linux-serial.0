Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D184AC4338F
	for <linux-serial@archiver.kernel.org>; Wed,  4 Aug 2021 08:08:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A796860C3F
	for <linux-serial@archiver.kernel.org>; Wed,  4 Aug 2021 08:08:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236127AbhHDIIS (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 4 Aug 2021 04:08:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:37898 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236112AbhHDIIR (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 4 Aug 2021 04:08:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628064485;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aZwnnJbZGmY78AaBVHz1xhD58sV1zCT+PSZcOVwS1yk=;
        b=UPqVnThTeDgunlWyQxPrsZwPLrWaHXLZtFhN3SllXfeHO1CdFxsTN7nEZwOnRqO9jUaz0z
        yqSPs3nGr4/1gPYlF2/37f9uMmFJzpekrb12dYuk6eYff21rFD8YQoPIuaFdcYml9VrrxH
        QKYEZveAjgMBUH0TWaiXD5bCGPZQEEg=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-562-OByP-rjFNiOAD95Ked0VVA-1; Wed, 04 Aug 2021 04:08:04 -0400
X-MC-Unique: OByP-rjFNiOAD95Ked0VVA-1
Received: by mail-ej1-f72.google.com with SMTP id p25-20020a170906b219b02905a698022dbaso331162ejz.9
        for <linux-serial@vger.kernel.org>; Wed, 04 Aug 2021 01:08:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aZwnnJbZGmY78AaBVHz1xhD58sV1zCT+PSZcOVwS1yk=;
        b=hjFNCFyIE7eHTfmH9SZ/HPCdlWMQ4HQLtgf/8k0miMh3l5yisuTLKNAq+xlt83HCgC
         sRvJFnWapyRb8o7+Y1QTm3Y5QD6jwawfiGyhYJTFwbRlCSi7XpcVKAx+IWIVH7NjbMjg
         IR0Od4uuEd4gtr0lZIPu3CkVdgGVJ9anMMpFxz9pzJNfIbGgyToUzKvJHJTzRtc+NL4N
         JYkcWz8p4s3waK3iJG7gttWBBs0OeTSgxONDrShDex/EJ5TpNVoGQWDavjQTfopigDxD
         vK7ypr47FJDsQ1OqI2bg7A0mgjIIhBKDG/5G2rxJjwKvQSkfzTJOCFBlxJkeiqOTlgmd
         d4xw==
X-Gm-Message-State: AOAM533RgUVLUiRZZT3crxDDYxzTLGBnf3I54rMDmFvpwqswRaA7lmXv
        hQIaLhRvp49SiE1Qpy2Ws/W0dnc/chK1HHV7lTV+FkNX0zV0qisuxzhLPkqlBE1El7TRQO6ArTn
        HHhuesrGRPYf1dgyv9U089G48
X-Received: by 2002:a17:906:2bd3:: with SMTP id n19mr25281533ejg.232.1628064482375;
        Wed, 04 Aug 2021 01:08:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyJ1+gMYBRSUkrYqo89Yv7xc5DTJIohqhaN0uH5kty9MZlm1Z33Iw3saCry50e7XHi7/2KP0g==
X-Received: by 2002:a17:906:2bd3:: with SMTP id n19mr25281504ejg.232.1628064482121;
        Wed, 04 Aug 2021 01:08:02 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id ha26sm425362ejb.87.2021.08.04.01.08.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Aug 2021 01:08:01 -0700 (PDT)
Subject: Re: [PATCH v1 1/5] serdev: Split and export
 serdev_acpi_get_uart_resource()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-serial@vger.kernel.org
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Mark Gross <mgross@linux.intel.com>,
        Rob Herring <robh@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>
References: <20210803192905.72246-1-andriy.shevchenko@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <035d2579-f64c-b5c2-45ff-4421ad7db6ca@redhat.com>
Date:   Wed, 4 Aug 2021 10:08:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210803192905.72246-1-andriy.shevchenko@linux.intel.com>
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=hdegoede@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi,

On 8/3/21 9:29 PM, Andy Shevchenko wrote:
> The same as for I²C Serial Bus resource split and export
> serdev_acpi_get_uart_resource(). We have already 3 users
> one of which is converted here.
> 
> Rationale of this is to consolidate parsing UART Serial Bus
> resource in one place as it's done, e.g., for I²C Serial Bus.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

*for this patch*

We do need to talk about how to merge this series, I've
NACK-ed patches 3/5 and 4/5 (see my reply there) so that
leaves just 2/5  as depending on this one. I believe it
would be easiest to just merge 1/5 + 2/5 to the tree
which caries serdev patches, which I guess is Greg's
tty tree ?

Greg can you pick up 1/5 and 2/5 ?

Regards,

Hans



> ---
>  drivers/tty/serdev/core.c | 36 +++++++++++++++++++++++++++++-------
>  include/linux/serdev.h    | 14 ++++++++++++++
>  2 files changed, 43 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
> index 92498961fd92..436e3d1ba92c 100644
> --- a/drivers/tty/serdev/core.c
> +++ b/drivers/tty/serdev/core.c
> @@ -562,23 +562,45 @@ struct acpi_serdev_lookup {
>  	int index;
>  };
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
> +}
> +EXPORT_SYMBOL_GPL(serdev_acpi_get_uart_resource);
> +
>  static int acpi_serdev_parse_resource(struct acpi_resource *ares, void *data)
>  {
>  	struct acpi_serdev_lookup *lookup = data;
>  	struct acpi_resource_uart_serialbus *sb;
>  	acpi_status status;
>  
> -	if (ares->type != ACPI_RESOURCE_TYPE_SERIAL_BUS)
> -		return 1;
> -
> -	if (ares->data.common_serial_bus.type != ACPI_RESOURCE_SERIAL_TYPE_UART)
> +	if (!serdev_acpi_get_uart_resource(ares, &sb))
>  		return 1;
>  
>  	if (lookup->index != -1 && lookup->n++ != lookup->index)
>  		return 1;
>  
> -	sb = &ares->data.uart_serial_bus;
> -
>  	status = acpi_get_handle(lookup->device_handle,
>  				 sb->resource_source.string_ptr,
>  				 &lookup->controller_handle);
> @@ -586,7 +608,7 @@ static int acpi_serdev_parse_resource(struct acpi_resource *ares, void *data)
>  		return 1;
>  
>  	/*
> -	 * NOTE: Ideally, we would also want to retreive other properties here,
> +	 * NOTE: Ideally, we would also want to retrieve other properties here,
>  	 * once setting them before opening the device is supported by serdev.
>  	 */
>  
> diff --git a/include/linux/serdev.h b/include/linux/serdev.h
> index 9f14f9c12ec4..3368c261ab62 100644
> --- a/include/linux/serdev.h
> +++ b/include/linux/serdev.h
> @@ -327,4 +327,18 @@ static inline int serdev_tty_port_unregister(struct tty_port *port)
>  }
>  #endif /* CONFIG_SERIAL_DEV_CTRL_TTYPORT */
>  
> +struct acpi_resource;
> +struct acpi_resource_uart_serialbus;
> +
> +#ifdef CONFIG_ACPI
> +bool serdev_acpi_get_uart_resource(struct acpi_resource *ares,
> +				   struct acpi_resource_uart_serialbus **uart);
> +#else
> +static inline bool serdev_acpi_get_uart_resource(struct acpi_resource *ares,
> +						 struct acpi_resource_uart_serialbus **uart)
> +{
> +	return false;
> +}
> +#endif /* CONFIG_ACPI */
> +
>  #endif /*_LINUX_SERDEV_H */
> 

