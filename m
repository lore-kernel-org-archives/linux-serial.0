Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83A0DC4332F
	for <linux-serial@archiver.kernel.org>; Wed, 21 Dec 2022 17:27:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234674AbiLUR1j (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 21 Dec 2022 12:27:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbiLUR1i (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 21 Dec 2022 12:27:38 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B067A6359
        for <linux-serial@vger.kernel.org>; Wed, 21 Dec 2022 09:26:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671643611;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NuanpIiit3pxf0DfbjP3/X8tU6mOQsYwFdbXpF1jEBw=;
        b=DvVylG8l1CN6snTGw6dp0XduVpbL2wxCPbaVcXtUqsLgmcdw/q3QLky/dxZXSqhldOwz7V
        MfJCJ4m2kWO0HKAaSm2CAdyGXIZif8xeHkUHd1ynMAXJ9h5EgsdA91M+pxbrG1uJcHhjAt
        lkw9A7vqvdPxuuJQVls82nyG7siJa7Q=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-592-0_a2JBmpPICNPD_r2fSO_g-1; Wed, 21 Dec 2022 12:26:50 -0500
X-MC-Unique: 0_a2JBmpPICNPD_r2fSO_g-1
Received: by mail-wr1-f71.google.com with SMTP id h5-20020adfa4c5000000b0026755f9b55eso1201453wrb.11
        for <linux-serial@vger.kernel.org>; Wed, 21 Dec 2022 09:26:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NuanpIiit3pxf0DfbjP3/X8tU6mOQsYwFdbXpF1jEBw=;
        b=lTo+70sT+9/9hOpLvB1AhG6fNOgUufoDK+XBvSM9u2cbTYYxVFjaP8QxfGPOChKQ6u
         JZxcKb5pTaaKCTYWqXsFqjoN8o4NFAQkyNxD8GM30GGN+v58nurOpYjaC3tS+Bbzaqcl
         60Sk0mwWOwGEoMZrioZ3Zw20yfykWnLtS5I8Okl9s/l9kwwr3jZJY13mObZ8PhHmVXin
         LCw/8f7woxzRRfz5zm+3tC5Gw9NqrcfNfBQ2xhvZZbI7f3mI4mgma35RXs2B2VKuK6UO
         v7MYNuwIN5Ff6KqpBVQ4P6Njm0Xf+nGYRkk7wXx1S5ngrr6TP2z/A4+2RJ81iLc4wl15
         cofA==
X-Gm-Message-State: AFqh2kpro0ltc8b2tdfaLavFrNWyQ0QTzQRs52lf4nDZBR6Xg6IKUmS1
        At0C5R+m2IctXBa7ZBHL9gb1NDiF1vIQbsPT4AB8N0Q12AJQLLHQrnruZ97MQVEd6xxW/a/tvzS
        nizTEKuiROqG8c4e/ywcBkVg=
X-Received: by 2002:a05:600c:1f12:b0:3cf:8155:2adc with SMTP id bd18-20020a05600c1f1200b003cf81552adcmr2334955wmb.33.1671643609357;
        Wed, 21 Dec 2022 09:26:49 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtmCCrwZo4nu1X4aGkuZsQZJ+WKxm5A/pgzSMDNUisKMUrHcMJkTIyFUzoV5mJaknfoOilw9A==
X-Received: by 2002:a05:600c:1f12:b0:3cf:8155:2adc with SMTP id bd18-20020a05600c1f1200b003cf81552adcmr2334924wmb.33.1671643609137;
        Wed, 21 Dec 2022 09:26:49 -0800 (PST)
Received: from [192.168.9.16] (net-2-34-28-158.cust.vodafonedsl.it. [2.34.28.158])
        by smtp.gmail.com with ESMTPSA id g15-20020a05600c310f00b003b47e75b401sm3174983wmo.37.2022.12.21.09.26.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Dec 2022 09:26:48 -0800 (PST)
Message-ID: <d34b021c-eec4-905e-f352-734db2d8338a@redhat.com>
Date:   Wed, 21 Dec 2022 18:26:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v7 4/4] tty: serial: 8250: add DFL bus driver for Altera
 16550.
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        matthew.gerlach@linux.intel.com
Cc:     hao.wu@intel.com, yilun.xu@intel.com, russell.h.weight@intel.com,
        basheer.ahmed.muddebihal@intel.com, trix@redhat.com,
        mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        tianfei.zhang@intel.com, corbet@lwn.net,
        gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        jirislaby@kernel.org, geert+renesas@glider.be,
        niklas.soderlund+renesas@ragnatech.se, macro@orcam.me.uk,
        johan@kernel.org, lukas@wunner.de, ilpo.jarvinen@linux.intel.com,
        bagasdotme@gmail.com
References: <20221220163652.499831-1-matthew.gerlach@linux.intel.com>
 <20221220163652.499831-5-matthew.gerlach@linux.intel.com>
 <Y6HsQJQMDnHgTesF@smile.fi.intel.com>
From:   Marco Pagani <marpagan@redhat.com>
In-Reply-To: <Y6HsQJQMDnHgTesF@smile.fi.intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org



On 2022-12-20 18:09, Andy Shevchenko wrote:
> On Tue, Dec 20, 2022 at 08:36:52AM -0800, matthew.gerlach@linux.intel.com wrote:
>> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>>
>> Add a Device Feature List (DFL) bus driver for the Altera
>> 16550 implementation of UART.
> 
> In general the code here looks good to me, but one thing to discuss due to
> comment to the previous patch(es).
> 
> ...
> 
>> +	u64 *p;
>> +
>> +	p = dfh_find_param(dfl_dev, DFHv1_PARAM_ID_CLK_FRQ);
>> +	if (!p)
>> +		return dev_err_probe(dev, -EINVAL, "missing CLK_FRQ param\n");
>> +
>> +	p++;
>> +	uart->port.uartclk = *p;
> 
> So, here and the below is using always the second u64 from the returned data.
> Does it mean:
> - we always skip the first u64 from the returned buffer and hence... (see below)
> - we may actually return the second u64 as a plain number (not a pointer) from
>   (an additional?) API? In such case we would not need to take care about this
>   p++; lines here and there.
> - we have fixed length of the data, returned by find_param(), i.e. 2 u64 words?
> 

I also had the impression that this method of getting and incrementing a pointer
to the beginning of the parameter block is a bit more error-prone than necessary.
Since parameter blocks are now standardized, wouldn't be easier and safer to wrap
the access logic into a helper function like:

u16 dfh_get_param_data(struct dfl_device *dfl_dev, u16 param_id, u64 *data)

that directly provides a copy of the parameter's data into a pointer provided by
the caller and returns the parameter version or an error if not found?

Thanks,
Marco

