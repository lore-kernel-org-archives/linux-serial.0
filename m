Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 750A9C48BDF
	for <linux-serial@archiver.kernel.org>; Thu, 24 Jun 2021 12:07:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60AF2613DA
	for <linux-serial@archiver.kernel.org>; Thu, 24 Jun 2021 12:07:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbhFXMKF (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 24 Jun 2021 08:10:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbhFXMKE (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 24 Jun 2021 08:10:04 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15CCFC061574;
        Thu, 24 Jun 2021 05:07:45 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id u2so2855396plf.3;
        Thu, 24 Jun 2021 05:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vBxveQ9N2SiHUkclKJH/HA64qFAKR8WNPJmuZ/pFIiY=;
        b=HBAdg9JPWu2WDbkjPTTpX8fQkUl+3hz1sMtctKP8bWlNXEdN6jM8rgW/0f+wI1BLlI
         OT5hg/mz7F/91BPZ0U3KPBN997l5Gp+Gv5Kt4cG5NFiBQjnYbmP7MHRtaCshyGS6SKqW
         YZVE0WuVT8symEDo3PpFVnY90tb48cEMrk79a7NscGPosJh8TY/H3icndWFDGR8a5jz4
         U91t2IWXgN6oTcFg/i5eiT34IxtDffJDfLXT/uDcNl9IQ5e7kCR8GZnfgk8ngURHYkTQ
         pwRI6G/SB6EYnBegmbneSTbguE1dSU6/ixaXUA9Gz4ihIy/XsDn4VJ96nFqHjtvHeaJd
         XJ6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vBxveQ9N2SiHUkclKJH/HA64qFAKR8WNPJmuZ/pFIiY=;
        b=NO83245Y4wzFehBlU1V8OOiw3LQpCxfLtdeNfOK7bXsCX85tJ6kri1gG49k2LP3THq
         hC50MHVTQALyK9o8OUU6O+nv4xVs7NCgJ9kdB92clUgkHLmwEvdO0wj96hL9/aclm7l2
         lZ2dF8yj/AVf1vsqEinmsEjJ9pOhsbaVXWLrJHGnr0JHbI7VSP+J/lXtsNhugWu061iV
         KgN0/qhbAHlI4pfRelKAmnbmhxCzJgt8QN9OyUbjCto9wtKJztZGs5BRw5ZDKaHh1VYj
         Uvp+MaZRX+LMY9y8gDtDQ4PfbWecS+AjGzjgeVcryDj2QkWwpwGfRb/GvSy6Lz9to1ev
         jl9g==
X-Gm-Message-State: AOAM531+C5L046HBGYq91FazNaLuyCwIFmCcy6SCw45gb2BAYczjCBX/
        Oe6AoerrDCPoqfLiiR6y77NPUHDSP/D9PKNl
X-Google-Smtp-Source: ABdhPJxQdyVPVORJqtAMTJxM6jHWNAAbe2Bc300nUdn1s8q+/j8eVGDlQqguYhsY4xr11nXj3AxbUg==
X-Received: by 2002:a17:90a:f488:: with SMTP id bx8mr13165441pjb.91.1624536464573;
        Thu, 24 Jun 2021 05:07:44 -0700 (PDT)
Received: from [192.168.0.118] ([103.242.196.10])
        by smtp.gmail.com with ESMTPSA id u4sm2859893pfu.27.2021.06.24.05.07.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jun 2021 05:07:44 -0700 (PDT)
From:   Saubhik Mukherjee <saubhik.mukherjee@gmail.com>
Subject: Re: [PATCH] tty: serial: owl: Fix data race in owl_uart_remove
To:     Johan Hovold <johan@kernel.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>, jirislaby@kernel.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        ldv-project@linuxtesting.org, andrianov@ispras.ru
References: <20210617110443.6526-1-saubhik.mukherjee@gmail.com>
 <YMswdqNpjb9n1pdW@kroah.com> <ceebf511-9971-6deb-a6dd-458d69de2bbd@gmail.com>
 <YNLfxMZZ0a80qKLg@hovoldconsulting.com>
Message-ID: <a9d43126-acd7-efb0-bf1a-86b06965f0e2@gmail.com>
Date:   Thu, 24 Jun 2021 17:37:38 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YNLfxMZZ0a80qKLg@hovoldconsulting.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 6/23/21 12:46 PM, Johan Hovold wrote:
> On Wed, Jun 23, 2021 at 11:06:53AM +0530, Saubhik Mukherjee wrote:
>> On 6/17/21 4:52 PM, Greg KH wrote:
>>> On Thu, Jun 17, 2021 at 04:34:43PM +0530, Saubhik Mukherjee wrote:
>>>> Suppose the driver is registered and a UART port is added. Once an
>>>> application opens the port, owl_uart_startup is called which registers
>>>> the interrupt handler owl_uart_irq.
>>>>
>>>> We could have the following race condition:
>>>>
>>>> When device is removed, owl_uart_remove is called, which calls
>>>> uart_remove_one_port, which calls owl_uart_release_port, which writes
>>>> NULL to port->membase. At this point parallely, an interrupt could be
>>>> handled by owl_uart_irq which reads port->membase.
>>>>
>>>> This is because it is possible to remove device without closing a port.
>>>> Thus, we need to check it and call owl_uart_shutdown in owl_uart_remove.
> 
> No, this makes no sense at all. The port is deregistered and hung up by
> uart_remove_one_port() (and the interrupt line is consequently disabled
> by the driver) before it is released so this can never happen.

Thanks for the reply. I am not sure I understand. I could not find any 
interrupt disabling in owl_uart_remove. Could you point out where/how is 
the interrupt line is disabled before releasing the port?

A related question question was asked in 
https://lore.kernel.org/linux-serial/YMcpBXd1vtipueQi@kroah.com/.

>>>> Found by Linux Driver Verification project (linuxtesting.org).
> 
> And you clearly did not test this, which you should mention.

This race warning was found by a static analysis tool. The code changes 
are untested.
