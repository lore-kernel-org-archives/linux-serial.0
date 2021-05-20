Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D636FC43470
	for <linux-serial@archiver.kernel.org>; Thu, 20 May 2021 16:02:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9E9B611BD
	for <linux-serial@archiver.kernel.org>; Thu, 20 May 2021 16:02:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233461AbhETQDc (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 20 May 2021 12:03:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233404AbhETQDZ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 20 May 2021 12:03:25 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11E6AC061761
        for <linux-serial@vger.kernel.org>; Thu, 20 May 2021 09:02:03 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id d11so18187243wrw.8
        for <linux-serial@vger.kernel.org>; Thu, 20 May 2021 09:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kI0h2gVSUj9JWqorLy8/VvL2RU0jPQm/IzG0Q3Yviek=;
        b=zA2v7Id9RNtXBF1yfPJZXWmlZzKpRxIluaZ+MJG4ysFRqhuqV9gtxi8W0FTlb8w5vs
         mOn5gzPyeakHxZm6gnTCx2RgLqjO7vCnILfN2PTN4jFQXm+dyJIlwBs0hAwUR2xzW5ZW
         YtB53Z7Js8Aha5NVL2BLuOY/+VqqJ14T/75cuvmost68QSlUyp/CFFma5zhLIUkpbbnN
         Bv5sVWiVRFfjMbSwza/onKX4zfNRJ5qBSDxUlLclEC7HOShSI3x3WaRE5ZA6eKhi9YXL
         2EU4E3pA+T8uzDPZHy2pEBtP8OSPfwmbd1BZgpL6ITrUGIrJA78OuCvQ/8zxUDsLm0TE
         ONMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=kI0h2gVSUj9JWqorLy8/VvL2RU0jPQm/IzG0Q3Yviek=;
        b=b96UHdUVvakY0S/UfDz/hTGi98cT1NHmiCR8iUqOklZ/XMfC1mHy6ADnLZ9mOHAHPU
         FWt7NvFIf6gf53qvpTVdomYQdZKlLvvXgmY8YGZI7SIoJsC1w0Nz04eIYVgw1qz1fEAd
         Zjimi2YoOnjE6hwJaaVqh4tDsichCXM/aZFHYcM2sa5sXJUbvAxTqmlV+Jb6V3GHew8d
         uC1zVQpZWlFuWrvxCiHZdlMWVGJdXPUBD6lqlUN80M1v8j1wgtbwu8KQ45aOOhaxD13A
         b/fWxaqqCswG6gjbwXqI79CCMO+vvN9EuF6mxm3bK2YISahxioA5D5T8DLiXarsD9jQ/
         yskg==
X-Gm-Message-State: AOAM5301wBrzc8UdaweSJc5LsR61MLAsXSyoXiZiO0OFfYI5+vz7KD2K
        b1ejsb7JLOX4aSu1C3pG20ejRg==
X-Google-Smtp-Source: ABdhPJxgQAwFG5+mH7h5jPT67M2rVkEPPjlqDBRPWJAWkDvOx5Hw09oefZRhL1be3OStGsdJWAT/UQ==
X-Received: by 2002:adf:f50e:: with SMTP id q14mr5047900wro.408.1621526521508;
        Thu, 20 May 2021 09:02:01 -0700 (PDT)
Received: from ?IPv6:2a01:e0a:90c:e290:d88a:b479:b222:83bb? ([2a01:e0a:90c:e290:d88a:b479:b222:83bb])
        by smtp.gmail.com with ESMTPSA id q3sm3518095wrr.43.2021.05.20.09.02.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 May 2021 09:02:01 -0700 (PDT)
Subject: Re: [PATCH 0/3] tty: serial: meson: add amlogic,uart-fifosize
 property
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        jirislaby@kernel.org
References: <20210518075833.3736038-1-narmstrong@baylibre.com>
 <9c6ce679-1721-be40-c1b2-6ae90503d2cb@baylibre.com>
 <YKZt7lCBhesXzoQP@kroah.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
Message-ID: <9f4f2dce-79ce-bef5-0725-2e3cbf530999@baylibre.com>
Date:   Thu, 20 May 2021 18:02:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YKZt7lCBhesXzoQP@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 20/05/2021 16:10, Greg KH wrote:
> On Thu, May 20, 2021 at 03:55:35PM +0200, Neil Armstrong wrote:
>> Hi Greg,
>>
>> On 18/05/2021 09:58, Neil Armstrong wrote:
>>> On most of the Amlogic SoCs, the first UART controller in the "Everything-Else"
>>> power domain has 128bytes of RX & TX FIFO, so add an optional property to describe
>>> a different FIFO size from the other ports (64bytes).
>>>
>>> This adds a property in the bindings, reads the property from the driver and updates
>>> the DT with the new property.
>>>
>>> Changes since v2:
>>> - removed spurious blank line from bindings
>>>
>>> Changes since v1:
>>> - switched to a more generic "fifo-size"
>>>
>>> Neil Armstrong (3):
>>>   dt-bindings: serial: amlogic,meson-uart: add fifo-size property
>>>   tty: serial: meson: retrieve port FIFO size from DT
>>>   arm64: dts: meson: set 128bytes FIFO size on uart A
>>>
>>>  .../devicetree/bindings/serial/amlogic,meson-uart.yaml       | 5 +++++
>>>  arch/arm64/boot/dts/amlogic/meson-axg.dtsi                   | 1 +
>>>  arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi            | 1 +
>>>  arch/arm64/boot/dts/amlogic/meson-gx.dtsi                    | 1 +
>>>  drivers/tty/serial/meson_uart.c                              | 5 ++++-
>>>  5 files changed, 12 insertions(+), 1 deletion(-)
>>>
>>
>> Could you apply patches 1 & 2 ?
> 
> Sure, will go do so now...
> 

thanks !

Neil
