Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86A45C43214
	for <linux-serial@archiver.kernel.org>; Wed,  4 Aug 2021 08:12:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6AB4860FC3
	for <linux-serial@archiver.kernel.org>; Wed,  4 Aug 2021 08:12:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236213AbhHDIMh (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 4 Aug 2021 04:12:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:39130 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236234AbhHDIMg (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 4 Aug 2021 04:12:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628064744;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8t1JSAt2GPJocGZpFUqk8Cgpe5URLTsGXT9nu1tj4NI=;
        b=M+PwFaz+dARsILJOsAguCCpxkhHjWgkwauP4gdF//9V9e6+XEXajTieudVlofMTSkT2VRb
        Gf3wzFwrwKc+HjNqDBw72shq7Gzr4Kf67vSqeMxm+lwI0QbUoGi9mbJ4N9Rj6wLwS3wxqX
        cKY9v5xKr8jrTDIJ8B/M3C0mGC5I8qU=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-202-eHu8kpobOCGYxK7HE8VIGQ-1; Wed, 04 Aug 2021 04:12:21 -0400
X-MC-Unique: eHu8kpobOCGYxK7HE8VIGQ-1
Received: by mail-ed1-f70.google.com with SMTP id eg53-20020a05640228b5b02903bd6e6f620cso1044925edb.23
        for <linux-serial@vger.kernel.org>; Wed, 04 Aug 2021 01:12:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8t1JSAt2GPJocGZpFUqk8Cgpe5URLTsGXT9nu1tj4NI=;
        b=nzZAuG+yMp59i+j2oPkX0UNqwwPHa2EPIyd7KOW0spvCgyAHKstiStJ5PPyz2gh8AP
         MBWDrMgmnRzIKnJqzH9YZkTEYpaHlG66JSw1qRN/xIm24RobxyBOyW4PGiKacCXaFtql
         oLMHAqrg4Uf3bXKN1pPGz4tK4tyLP0OHeVvxFnnJychrUyxDL/UCZFZ7yP8WPKXM9vXc
         2SB6NVxRWcq8PHXr+cx0sjnjF27tDddwRqGWEgs6zyfhfZ7Lyhx+nBbSKTL9rzU5Y3wT
         qVvd3WXjQCnsZgSfZW/+JqMRMZ5AaGwW9i8DtiRnH1VHKkqIbGXcjxZ7asRw8umbVLEw
         tIaQ==
X-Gm-Message-State: AOAM532N5ok2KrGU21AO2BCjh7eja+Pl2thxL/p8VGEnsR2Wq++T3roC
        Okcoutc8BsB98R+T8KSYAc3Tvew70C+i8ZzR1bbfPEME4H/vYu4q4s357XLth/4+PBqmg92QTi+
        1npsoovKtsTddAhyrb+jC4/lc
X-Received: by 2002:a17:906:12c6:: with SMTP id l6mr25545398ejb.373.1628064739962;
        Wed, 04 Aug 2021 01:12:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw03BYs6BY5vHPyYikihME9t3aKFHj5sJC9uUJoEIQgXgHqiRvXTBTwlJq0LMp2tCjfdyhwuA==
X-Received: by 2002:a17:906:12c6:: with SMTP id l6mr25545379ejb.373.1628064739834;
        Wed, 04 Aug 2021 01:12:19 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id u5sm624098edv.64.2021.08.04.01.12.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Aug 2021 01:12:19 -0700 (PDT)
Subject: Re: [PATCH v1 3/5] Bluetooth: hci_bcm: Use
 serdev_acpi_get_uart_resource() helper
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
 <20210803192905.72246-3-andriy.shevchenko@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <87778067-5b45-8e83-b624-545b39a0e00d@redhat.com>
Date:   Wed, 4 Aug 2021 10:12:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210803192905.72246-3-andriy.shevchenko@linux.intel.com>
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=hdegoede@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi,

On 8/3/21 9:29 PM, Andy Shevchenko wrote:
> serdev provides a generic helper to get UART Serial Bus resources.
> Use it instead of open coded variant.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/bluetooth/hci_bcm.c | 15 ++++++---------
>  1 file changed, 6 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
> index 3cd57fc56ade..16f854ac19b6 100644
> --- a/drivers/bluetooth/hci_bcm.c
> +++ b/drivers/bluetooth/hci_bcm.c
> @@ -899,9 +899,9 @@ static const struct acpi_gpio_mapping acpi_bcm_int_first_gpios[] = {
>  static int bcm_resource(struct acpi_resource *ares, void *data)
>  {
>  	struct bcm_device *dev = data;
> +	struct acpi_resource_uart_serialbus *uart;
>  	struct acpi_resource_extended_irq *irq;
>  	struct acpi_resource_gpio *gpio;
> -	struct acpi_resource_uart_serialbus *sb;
>  
>  	switch (ares->type) {
>  	case ACPI_RESOURCE_TYPE_EXTENDED_IRQ:
> @@ -920,18 +920,15 @@ static int bcm_resource(struct acpi_resource *ares, void *data)
>  		dev->gpio_count++;
>  		break;
>  
> -	case ACPI_RESOURCE_TYPE_SERIAL_BUS:
> -		sb = &ares->data.uart_serial_bus;
> -		if (sb->type == ACPI_RESOURCE_SERIAL_TYPE_UART) {
> -			dev->init_speed = sb->default_baud_rate;
> -			dev->oper_speed = 4000000;
> -		}
> -		break;
> -
>  	default:
>  		break;
>  	}
>  
> +	if (serdev_acpi_get_uart_resource(ares, &uart)) {
> +		dev->init_speed = uart->default_baud_rate;
> +		dev->oper_speed = 4000000;
> +	}
> +

You are replacing a nice switch-case which handles all relevant resource
types with still having a switch-case + a separate if .. else if .. else if ...
(also taking patch 4/5 into account).

This does not help the readability of this code at all IMHO, so NACK
from me for this patch as well as for 4/5.

Regards,

Hans

