Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5C4FC433EF
	for <linux-serial@archiver.kernel.org>; Thu, 18 Nov 2021 04:17:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B35B761B44
	for <linux-serial@archiver.kernel.org>; Thu, 18 Nov 2021 04:17:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242887AbhKREUX (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 17 Nov 2021 23:20:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242912AbhKRETy (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 17 Nov 2021 23:19:54 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6D0AC061764
        for <linux-serial@vger.kernel.org>; Wed, 17 Nov 2021 20:16:54 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id d64so2141973pgc.7
        for <linux-serial@vger.kernel.org>; Wed, 17 Nov 2021 20:16:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=accesio-com.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WcEi1WKCV2U5xgYJMZvv856GF8dvLozL2TOif8DrYHI=;
        b=WOAODoeF1orzI+akjNjmojYl6xn/H+4SO2jLHvV5hkYYHwAX28a3RlPVyZM7eXXtNx
         Z/+ZnXFWz8zHERjZ4wumHQoj+Y3Yb5e+VRUGc2qvBkvknt53o+hv3oT1yV8FdmIahc34
         maFWqSsbXDb0/1DzvdXF3XeWI7cP+uio/XADIDNkpMKqDwvegyzwy9AbnSObTEHye6kn
         Ss5fpZ2US2nQWMjnaiQys1+N7dDGSmL/J4fTFtswXnGL70cTcHghK7F/yuCo44zxPFcg
         7S5sWhP05R1cG1ZNYrHVO//09NNNBfqQfUuPWV9OuqBeIQnmDnQ/khOo45YmQyUyo6OA
         UoxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WcEi1WKCV2U5xgYJMZvv856GF8dvLozL2TOif8DrYHI=;
        b=Ce6IJsEGXGCzhcYujoWTeNV9wWBPYukZK4KMTAlv0/gNDj1UaicfJqbbW6DO1RZmXH
         oDo7N0azE4C3wMqSYJC1kAo58oGNMJY1jlvUGQuSjGS2qesqI7Q4QFF+Ohnvxx/5oui2
         ustCS9W5W7muCjCmCQI1BPI7pEgSQMtMvh51CSM6bMxL7xDEPf2hX1NQRbju6hsQEo3y
         N0m3/ZmHftdtTLCyFnorteqes1LGm3Ox0u9mSBo6Lj8S6arBA5Xikl2E66sfVzZSiyAm
         GB1ySI0D7FnYOtU219WEzDDfiiucXHoEexXclvKCZa4Uywa7FAO9kt27Q8y2rkledTVw
         7hZw==
X-Gm-Message-State: AOAM531zo4VYn4cGRgz3/EbLrA3qs6k9mFQGfvoDn7g+kHvV56E8oGT7
        piS6o8rBSrBy+vuTCwtq7T9C
X-Google-Smtp-Source: ABdhPJztQ7H82q5d5wLTNF0WLXnjdJ90/tBKvkGibg6OUzA1MbvGAZh4QlFhV02WE3XB6er9LISXkw==
X-Received: by 2002:a63:42:: with SMTP id 63mr9126426pga.127.1637209014353;
        Wed, 17 Nov 2021 20:16:54 -0800 (PST)
Received: from [172.16.8.241] ([98.149.220.160])
        by smtp.gmail.com with ESMTPSA id w189sm1144224pfd.164.2021.11.17.20.16.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Nov 2021 20:16:53 -0800 (PST)
Subject: Re: [PATCH v2 0/2] serial: 8250_pci patches to address issues with
 pericom_do_set_divisor()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jiri Slaby <jirislaby@kernel.org>
References: <20211117145502.43645-1-andriy.shevchenko@linux.intel.com>
From:   Jay Dolan <jay.dolan@accesio.com>
Message-ID: <89c2f319-b0b9-3c64-e9f8-6c4081cdcce4@accesio.com>
Date:   Wed, 17 Nov 2021 20:16:52 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211117145502.43645-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org



On 11/17/21 6:55 AM, Andy Shevchenko wrote:
> A series patches to address three issues one customer managed to hit
> all at once.
> 
> 1) Fourth port not being setup correctly on some Pericom chips. Fix
> the entries in pci_serial_quirks array.
> 
> 2) Rewrite pericom_do_set_divisor() to always calc divisor and to use
> the uartclk instead of a hard coded value. Always calculate divisor
> without passing control to serial8250_do_set_divisor().
> 
> Jay, can you retest this, please?
I was able to verify that the fourth port was placed at the fixed 
address for the card that previously had it at the wrong offset.
I was also able to verify all of the standard baud rates for 24 and 
14.7456 MHz crystals from 50 to their respective uartclk speed on the 
oscilloscope.
> 
> Changelog v2:
> - dropped no-fixes patch, left only fixes here
> - amended refactoring of the ->set_divisor()
> - fixed Fixes tags
> 
> Jay Dolan (2):
>    serial: 8250_pci: Fix ACCES entries in pci_serial_quirks array
>    serial: 8250_pci: rewrite pericom_do_set_divisor()
> 
>   drivers/tty/serial/8250/8250_pci.c | 39 +++++++++++++++++++-----------
>   1 file changed, 25 insertions(+), 14 deletions(-)
>
