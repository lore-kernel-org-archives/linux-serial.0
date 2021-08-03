Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89E6DC4338F
	for <linux-serial@archiver.kernel.org>; Tue,  3 Aug 2021 19:47:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B2D160F02
	for <linux-serial@archiver.kernel.org>; Tue,  3 Aug 2021 19:47:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240261AbhHCTr1 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 3 Aug 2021 15:47:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239635AbhHCTr0 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 3 Aug 2021 15:47:26 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30802C061757;
        Tue,  3 Aug 2021 12:47:14 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id n12-20020a05600c3b8cb029025a67bbd40aso2489211wms.0;
        Tue, 03 Aug 2021 12:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=P9aiSezR2L9zKHRc/DTVFiGJI8KeD7eYMrBCd83E65k=;
        b=tYo1zDL9AXhMmibS0P/VBJCdntJtJFWIMfe+Wo9MJqu/k0IbIXw0UAeFzSJli19jun
         9SMc0NEzyxyOAG4c2L3piXZc3bxIaixrZY99i744tHNnYrfBE2B9vbdD4eUt1qSmd8j1
         W4+ieRmyfd4DGoBPdfQQ2ocYZvJS0K7V6EM4plFuDFZJ1FHiq57YR9jJ0EUFmeVYg1w5
         LsQ6AX2FrFEyFP9oUBCkhpOYnyMStLS1CcHncqFtvinJnY0jIMULNhgiez1Df/NAUCDZ
         aycpXaOU/hq0DSe+unDSJAC7XB1EKreS/QKtvMCcBi1/NV4S86SmQUoe0ZJ+Retvqmst
         4xZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=P9aiSezR2L9zKHRc/DTVFiGJI8KeD7eYMrBCd83E65k=;
        b=iIlzxvg7PNS/iZtl9Fp/tEoo/nHrpOzB5yMG509Ltne99XtFmFCMEg28aqpax0IcL2
         lKdIJvkVXOcboULBMDathiUDe+6bZ2fs/Qjufx7VMqBpY3XycdxunezhaedeKHdwxHzz
         Wkk6anCGw3MKnj2keQBAI5FC06sDdRLSQTUPxRQBE+bJbU6anIlR0JDUGF1lHFMDX6do
         eNY3pQoB7awMYYJfxqEkX7mQDviPTpmd4HA1dCQt4CAv5ME/Wp+tI3SpnbV7ODBji8AP
         M/Jm7PomLKdvqMKK6iCZW85wVCXwZEEj/mKE6kDZ40FfUP3T6rHA6XVNU9RKtVsMZMbV
         vF8w==
X-Gm-Message-State: AOAM533olOMo/UJEgQgT6wbACZy8L1whN0cNtL6ZQ4tfy5cu3G8LEWI4
        dIs7D51Y+OPQtxt7PgUSbYU=
X-Google-Smtp-Source: ABdhPJxOQ+mrsnCxRAbe4+KT36gd5bmSgkEcJjwha2ymTZXo8EUuNdgVXchqhAl2yaNi+grUpajcMA==
X-Received: by 2002:a7b:c416:: with SMTP id k22mr5964817wmi.177.1628020032791;
        Tue, 03 Aug 2021 12:47:12 -0700 (PDT)
Received: from [192.168.2.202] (pd9e5a13a.dip0.t-ipconnect.de. [217.229.161.58])
        by smtp.gmail.com with ESMTPSA id a12sm3489179wmj.22.2021.08.03.12.47.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Aug 2021 12:47:12 -0700 (PDT)
Subject: Re: [PATCH v1 2/5] platform/surface: aggregator: Use
 serdev_acpi_get_uart_resource() helper
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
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
 <20210803192905.72246-2-andriy.shevchenko@linux.intel.com>
From:   Maximilian Luz <luzmaximilian@gmail.com>
Message-ID: <ae6b9e16-7036-ed23-1fd8-9b10627a8737@gmail.com>
Date:   Tue, 3 Aug 2021 21:47:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210803192905.72246-2-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 8/3/21 9:29 PM, Andy Shevchenko wrote:
> serdev provides a generic helper to get UART Serial Bus resources.
> Use it instead of open coded variant.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Thanks! Looks good to me.

Reviewed-by: Maximilian Luz <luzmaximilian@gmail.com>

> ---
>   drivers/platform/surface/aggregator/core.c | 9 +--------
>   1 file changed, 1 insertion(+), 8 deletions(-)
> 
> diff --git a/drivers/platform/surface/aggregator/core.c b/drivers/platform/surface/aggregator/core.c
> index 279d9df19c01..c61bbeeec2df 100644
> --- a/drivers/platform/surface/aggregator/core.c
> +++ b/drivers/platform/surface/aggregator/core.c
> @@ -301,20 +301,13 @@ static acpi_status ssam_serdev_setup_via_acpi_crs(struct acpi_resource *rsc,
>   						  void *ctx)
>   {
>   	struct serdev_device *serdev = ctx;
> -	struct acpi_resource_common_serialbus *serial;
>   	struct acpi_resource_uart_serialbus *uart;
>   	bool flow_control;
>   	int status = 0;
>   
> -	if (rsc->type != ACPI_RESOURCE_TYPE_SERIAL_BUS)
> +	if (!serdev_acpi_get_uart_resource(rsc, &uart))
>   		return AE_OK;
>   
> -	serial = &rsc->data.common_serial_bus;
> -	if (serial->type != ACPI_RESOURCE_SERIAL_TYPE_UART)
> -		return AE_OK;
> -
> -	uart = &rsc->data.uart_serial_bus;
> -
>   	/* Set up serdev device. */
>   	serdev_device_set_baudrate(serdev, uart->default_baud_rate);
>   
> 
