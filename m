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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6720C4338F
	for <linux-serial@archiver.kernel.org>; Wed,  4 Aug 2021 08:04:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABDCC61037
	for <linux-serial@archiver.kernel.org>; Wed,  4 Aug 2021 08:04:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236068AbhHDIEi (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 4 Aug 2021 04:04:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:24114 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236039AbhHDIEi (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 4 Aug 2021 04:04:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628064263;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C8JhLLtWeVm1W46th06VECpu4490VjDvsxVKWpqBsFE=;
        b=DWh06UpgDh2+A9FgsGgYzR3X7oxfkP9DLLbzxrcKGgn//TGhpqzXBHcl2Wrf/zgUMqw574
        iQbP/X2AHuSy8EHgMxXqWNt2EiZsBTbmSLWaSQizFhzwtEiWmvlDfZqH+HYFPx8kr9MjmU
        /sUeBAfMP3pOBxphc5UGQHBrWOLtlHY=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-72-ctTvokNqPaquzMjybU5cgw-1; Wed, 04 Aug 2021 04:04:22 -0400
X-MC-Unique: ctTvokNqPaquzMjybU5cgw-1
Received: by mail-ed1-f70.google.com with SMTP id d12-20020a50fe8c0000b02903a4b519b413so1057879edt.9
        for <linux-serial@vger.kernel.org>; Wed, 04 Aug 2021 01:04:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=C8JhLLtWeVm1W46th06VECpu4490VjDvsxVKWpqBsFE=;
        b=AOokuCnpFa4UlPx2JTZf78npUXad+pIuGQCmPE58fQlUZMp2amcDF+D/3H1qi4OpBM
         jmzDMtdLjeVoSUAmnme2+Gi+7SwmZcYvY1zp2a4lRSkvs7KIblIbiniIQHa5V9ufR1ge
         PYx52HyGltP1y1AmkkfG3P08WXAbk5CzVesapD+rgrrsp6DC2N5Io5vXW3C87rKUp2cA
         YgPocyp3IVaMJBnKkO5dPDdKL1EN9Rsvod9JKqkdCuoCYPKfD4ZX8RESnkmHKGpmG6Bu
         4VZFhsWWWljdITTDWrpDCw+CSvmNK2m9rig3mHuNll0u26bHhxT9nnlXOjxKSTEylh6O
         DsfQ==
X-Gm-Message-State: AOAM532zMp/0+W0GO66gkOSonqwWwB6sNuirLUIM2eLbJx85zhD2RC80
        qvQ/2Agkobp0HT+VSg+7x+F1OAPixdkyQieZGNysH7Cxj02Ci73gLlaB04tcYi7X+Lhu0SARo94
        /ga55Q7u86J8I86l4G1kUAhZY
X-Received: by 2002:a17:906:12c6:: with SMTP id l6mr25518049ejb.373.1628064260913;
        Wed, 04 Aug 2021 01:04:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwcX3pgtodGX9bn2A2Q9UPigJDSYOZREOJcOSv0/eYTJfsJ0M5wXc9FoFdW+LwQB1tUQ8gJOg==
X-Received: by 2002:a17:906:12c6:: with SMTP id l6mr25518017ejb.373.1628064260652;
        Wed, 04 Aug 2021 01:04:20 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id m21sm617090edc.5.2021.08.04.01.04.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Aug 2021 01:04:20 -0700 (PDT)
Subject: Re: [PATCH v1 4/5] Bluetooth: hci_bcm: Use acpi_gpio_get_*_resource()
 helpers
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
 <20210803192905.72246-4-andriy.shevchenko@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <9fceba7d-627b-bec2-6315-46e66b646534@redhat.com>
Date:   Wed, 4 Aug 2021 10:04:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210803192905.72246-4-andriy.shevchenko@linux.intel.com>
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
> ACPI provides generic helpers to get GPIO interrupt and IO resources.
> Use it instead of open coded variant.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

As explained in my reply to 3/5 this makes the code a lot harder
to read with little to no gain, so NACK from me for this one.

Regards,

Hans

> ---
>  drivers/bluetooth/hci_bcm.c | 15 ++++++---------
>  1 file changed, 6 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
> index 16f854ac19b6..ed99fcde2523 100644
> --- a/drivers/bluetooth/hci_bcm.c
> +++ b/drivers/bluetooth/hci_bcm.c
> @@ -911,15 +911,6 @@ static int bcm_resource(struct acpi_resource *ares, void *data)
>  		dev->irq_active_low = true;
>  		break;
>  
> -	case ACPI_RESOURCE_TYPE_GPIO:
> -		gpio = &ares->data.gpio;
> -		if (gpio->connection_type == ACPI_RESOURCE_GPIO_TYPE_INT) {
> -			dev->gpio_int_idx = dev->gpio_count;
> -			dev->irq_active_low = gpio->polarity == ACPI_ACTIVE_LOW;
> -		}
> -		dev->gpio_count++;
> -		break;
> -
>  	default:
>  		break;
>  	}
> @@ -927,6 +918,12 @@ static int bcm_resource(struct acpi_resource *ares, void *data)
>  	if (serdev_acpi_get_uart_resource(ares, &uart)) {
>  		dev->init_speed = uart->default_baud_rate;
>  		dev->oper_speed = 4000000;
> +	} else if (acpi_gpio_get_irq_resource(ares, &gpio)) {
> +		dev->gpio_int_idx = dev->gpio_count;
> +		dev->irq_active_low = gpio->polarity == ACPI_ACTIVE_LOW;
> +		dev->gpio_count++;
> +	} else if (acpi_gpio_get_io_resource(ares, &gpio)) {
> +		dev->gpio_count++;
>  	}
>  
>  	return 0;
> 

