Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6444BC433EF
	for <linux-serial@archiver.kernel.org>; Fri, 19 Nov 2021 06:32:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46F2561154
	for <linux-serial@archiver.kernel.org>; Fri, 19 Nov 2021 06:32:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbhKSGfy (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 19 Nov 2021 01:35:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbhKSGfy (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 19 Nov 2021 01:35:54 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53FD5C061574
        for <linux-serial@vger.kernel.org>; Thu, 18 Nov 2021 22:32:53 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id k4so7347790plx.8
        for <linux-serial@vger.kernel.org>; Thu, 18 Nov 2021 22:32:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=accesio-com.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pitqVTnR52sCvxpnb0+Tu14MFJWNMqrMhYyHvSknELA=;
        b=xz3H6UmTjG0kI/uDX9MZflaKyd9H1dTdKXv3Yyb44XFzwDLc98A1WXNgSXd1NEjTZu
         +3K/7hU6SK/+wYJ4dMIl14LrIFYtcGL5q4d+qDkyagN4vb5Zp6ZPh40BjExTxgz6nts4
         K2A6TfaWw8FPnASm/4JhITJLb3cD7r22BijeCUxt9INV1yggI54hsX8snXO0GGvI5+PM
         HsvkKvy5d4C9Oif/WYUnTKlN6cYB/GhHMLBgBk4I2LkwjxPbH41xnFXezn68hjDKZCJy
         STKCToI6NEyP9DhfLwxV+lxVhDP8fMh3r3wKLKupgd5M00wrfzdqeCSDHtLZqxOSH4EI
         4oTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pitqVTnR52sCvxpnb0+Tu14MFJWNMqrMhYyHvSknELA=;
        b=Z/3C6vrMWrpxXFKks3n0RjwmcnDElffLg8U2yoRdcP0bEZ7ldyA1qfd48QxW65jpz+
         B6hLFUUfFiwBTCQYYs31/78B6w4o87Q0LiqRyTsLjjnVDTqTeiA7dOlAykwbdqyxV0hw
         1C6Vaz1MH0TG+NYEcswpqC5Frx2HijBQz7+t7W3jy1rJC95jHq24ZCShRQKKM5/PAKB2
         qO5FiLVDPP+1ETEzrHbyXWsmBmKBXfxFIyY2mrutLoS2dH/E5DFn8W1y2VvqQCMUFQEO
         Ng76b+lWtJTd5thce6M6ZusW/kQcvp5cWwY7j5Irx0/zXPkgQhcTYtNzYzA4GVp0KART
         TaTw==
X-Gm-Message-State: AOAM531Mg00oyzGJUUaWp3sD3DTWOMexUsNjZ+eGMHOchx5YHxe9VWdx
        NnHgwgtOrRKYSeyzklxgD+sL+TOuhKUL
X-Google-Smtp-Source: ABdhPJytghvkGiCOGjcJVx6q7f8229wvM4d8skJfb4j1wJr7PoZsOIpWZJHI83dI0UzwgXMVAgSzJA==
X-Received: by 2002:a17:90b:17cc:: with SMTP id me12mr1787160pjb.179.1637303572868;
        Thu, 18 Nov 2021 22:32:52 -0800 (PST)
Received: from [172.16.8.241] ([98.149.220.160])
        by smtp.gmail.com with ESMTPSA id h18sm1667272pfh.172.2021.11.18.22.32.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Nov 2021 22:32:52 -0800 (PST)
Subject: Re: [PATCH v1 0/2] serial: 8250_pci: Split Pericom driver
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc:     Jiri Slaby <jirislaby@kernel.org>
References: <20211117145750.43911-1-andriy.shevchenko@linux.intel.com>
From:   Jay Dolan <jay.dolan@accesio.com>
Message-ID: <b99aabbe-add9-9c1e-ed4b-8850c69233de@accesio.com>
Date:   Thu, 18 Nov 2021 22:32:51 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211117145750.43911-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 11/17/21 6:57 AM, Andy Shevchenko wrote:
> Split Pericom driver to a separate module.
> While at it, re-enable high baud rates.
> 
> Jay, can you, please, test this on as many hardware as you have?
> 
> The series depends on the fix-series: https://lore.kernel.org/linux-serial/20211117145502.43645-1-andriy.shevchenko@linux.intel.com/T/#u
> 
> Andy Shevchenko (1):
>    serial: 8250_pci: Split out Pericom driver
> 
> Jay Dolan (1):
>    serial: 8250_pericom: Re-enable higher baud rates
> 
>   drivers/tty/serial/8250/8250_pci.c     | 405 +------------------------
>   drivers/tty/serial/8250/8250_pericom.c | 217 +++++++++++++
>   drivers/tty/serial/8250/Kconfig        |   8 +
>   drivers/tty/serial/8250/Makefile       |   1 +
>   4 files changed, 231 insertions(+), 400 deletions(-)
>   create mode 100644 drivers/tty/serial/8250/8250_pericom.c
> 

I have my current state here: 
https://github.com/accesio/linux/blob/split-pericom-driver/drivers/tty/serial/8250/8250_pericom.c

* Change port type to UPIO_PORT
* Add in pericom_do_startup() because the UPF_MAGIC_MULTIPLIER doesn't 
stick.

When I'm testing baud rates greater than baud_base I'm seeing strange 
things on the scope. Maybe I'm just tired, and it's human error. I 
should be able to get back to it and get it done on Saturday.
