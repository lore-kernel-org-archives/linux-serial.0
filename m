Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84F11C4338F
	for <linux-serial@archiver.kernel.org>; Fri,  6 Aug 2021 12:10:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 665D961102
	for <linux-serial@archiver.kernel.org>; Fri,  6 Aug 2021 12:10:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243761AbhHFMKP (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 6 Aug 2021 08:10:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58659 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231860AbhHFMKO (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 6 Aug 2021 08:10:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628251798;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V4AdJPieWv1AGBhnfr6N7NI4S2zg5FETvWvC3QgBc/s=;
        b=JEPYEZFFvUlAZwpOeogyvvAOJAnhKKCwrBDUqA+4Y9VawR93peRiLqAyXz/u2Tl83gcLxU
        AK51AJCXHNCr34iBfavB8YjEZUVkMHCviVNzSRSca5i6q1JBXYjEOhtCixCvyljnknNWJf
        u+wcvfql42tBB2TXJ1DsuayShCbAWtw=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-385-RaltQGvoPgaix2o-IGtkEQ-1; Fri, 06 Aug 2021 08:08:45 -0400
X-MC-Unique: RaltQGvoPgaix2o-IGtkEQ-1
Received: by mail-ej1-f69.google.com with SMTP id ju25-20020a17090798b9b029058c24b55273so3085605ejc.8
        for <linux-serial@vger.kernel.org>; Fri, 06 Aug 2021 05:08:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=V4AdJPieWv1AGBhnfr6N7NI4S2zg5FETvWvC3QgBc/s=;
        b=P9TLEyttkJ7qt3oYlp5IvrFz7IStyDQL3b3orVSmBiUCkae3tkQzH9kHNiB6AGylj4
         n2d9OpCVTeBEtiXJ34jJoQxtFL1+rUyaVK1XLJN6MFUHOU32gx2/DaM2E9qRHh/qrnRY
         gpX6PqzXKgWM16D79vpkKg7gbDQthACq/zRlkuIhMvoUqg3mfPDJCrKRUF+FyumOaUbR
         kv/Q5L7REIFAWTpvn9LT2v4Aw/SIpcmuDGVV6e7pENW9a+IDHxR4crU8q961hPpBxZuH
         R1h8beMPmLxyvcEZsTAogMcrVDBHhV8/9LcCnQVE8yWDeIBIEGdlNAlGgLgd/AW/yuD3
         x0VQ==
X-Gm-Message-State: AOAM532hwuU4HEMdlHfSfxwB5TGLxIylLqNrQgtv1aUwZNbfnxUVXUY6
        NiEbc02317HxE8POOaZsxQPTpgj4dEPrDb1AYDcn6Pu2M7nFBtO+6+21cNvdK+3lytOD/yKGVXZ
        BWjlEOWG2NEIatx3QoO4bke4b
X-Received: by 2002:aa7:c541:: with SMTP id s1mr12750564edr.327.1628251724037;
        Fri, 06 Aug 2021 05:08:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzLIdXKzTovwMCJ/mrOdvKOkViUKmJ8dKu7a05333lEFVX4pxiAwiXziYx/lnIsFREOBCAjjQ==
X-Received: by 2002:aa7:c541:: with SMTP id s1mr12750551edr.327.1628251723909;
        Fri, 06 Aug 2021 05:08:43 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id i10sm3811930edf.12.2021.08.06.05.08.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Aug 2021 05:08:43 -0700 (PDT)
Subject: Re: [PATCH v3 1/2] serdev: Split and export
 serdev_acpi_get_uart_resource()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lee Jones <lee.jones@linaro.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
Cc:     Mark Gross <mgross@linux.intel.com>, Rob Herring <robh@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>
References: <20210806111736.66591-1-andriy.shevchenko@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <a955083a-a985-0b7d-460f-af196c5113c5@redhat.com>
Date:   Fri, 6 Aug 2021 14:08:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210806111736.66591-1-andriy.shevchenko@linux.intel.com>
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

On 8/6/21 1:17 PM, Andy Shevchenko wrote:
> The same as for I²C Serial Bus resource split and export
> serdev_acpi_get_uart_resource(). We have already a few users
> one of which is converted here.
> 
> Rationale of this is to consolidate parsing UART Serial Bus
> resource in one place as it's done, e.g., for I²C Serial Bus.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>

As mentioned before I believe it is best if this series is
merged in its entirety through to the tty tree, here is my
ack for patch 2/2 for that:

Acked-by: Hans de Goede <hdegoede@redhat.com>

Greg, can you pickup the entire series please?

Regards,

Hans


> ---
> v3: amended kernel doc to have RETURN section (Jiri)
>  drivers/tty/serdev/core.c | 36 +++++++++++++++++++++++++++++-------
>  include/linux/serdev.h    | 14 ++++++++++++++
>  2 files changed, 43 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
> index 92498961fd92..f1324fe99378 100644
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
> + * Return: True if resource type is of UARTSerialBus, otherwise false.
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

