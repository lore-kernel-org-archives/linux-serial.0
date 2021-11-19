Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A51D0C433EF
	for <linux-serial@archiver.kernel.org>; Fri, 19 Nov 2021 14:33:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 833FA61AD0
	for <linux-serial@archiver.kernel.org>; Fri, 19 Nov 2021 14:33:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235496AbhKSOgm (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 19 Nov 2021 09:36:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234808AbhKSOgm (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 19 Nov 2021 09:36:42 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7050FC061574
        for <linux-serial@vger.kernel.org>; Fri, 19 Nov 2021 06:33:40 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id m14so9529627pfc.9
        for <linux-serial@vger.kernel.org>; Fri, 19 Nov 2021 06:33:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=accesio-com.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SuJeGi0xfxjRGp9PgOIOTr6ytZyWO3zrVNLiADusgH4=;
        b=MjjVbXvV/o2y0KyYKYaiikhHMrL506+xXx/VzShePZezOBlvpWIQCQ6W9CNDJ5sQSv
         +RuMCW5F9SQQi3EsW5POdSFzT22ATOf0bQrUbz+R9rjde03U0MdOnX8yO0wPV7XCE2Xz
         eihXC1fFNS+prpvE29Zcq1mYkb+mTmaiK9V5dWYEzycv3XCW0gkUqmb9Ql1CoQ1xNfmL
         vAI+za775EikxJZaJcOlFVRchbps/dzZS0qB5r6NvVKkGHtFpHeu+MM9+twKyk2NnSA4
         izA90DLT+YdzYz7v2RVO0QDkT5Bbf5Ay/7nDtXjxTUTnM/8nY+VZRaqB90CRpe/vvrKF
         iOsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SuJeGi0xfxjRGp9PgOIOTr6ytZyWO3zrVNLiADusgH4=;
        b=LbkWE6Wf/42bNGrVfY83j2dOfEipY6vMKyNb/vSo+Z0YAChz2ngTiha5lqEJkNqsEQ
         sEUw/BvRbt2zJ53TmU3AZ/QbjJB3bYhOEPrDCzVCv4y50GjW0W059wbvG9JHFNXl34ta
         Gmf+OXyJnHfWCY9P/09z3lqiueqCdzTQTHJ7X1JtXML+pvArRmb5uKoqJOCxIBvOgIfx
         74Jx4xwABgagU6hBDQ1GxSetJa7AGuKW1UZ//r1JhBPjVyjNJMmjnCezaVjh6EhWCt3T
         UVhkDNpNGyHiZvTUUlDDrC7Ezjks4qvRTqSta/FiBAJwVVwygKLZQFf1ohucIfk1uTJL
         BERw==
X-Gm-Message-State: AOAM533dbP2JCB5v2rkowotkQl5VKbmIbWqTVCkwjnQew6CjuW1ETKJE
        526y5o+vb1Ebs0BONzAUio8E
X-Google-Smtp-Source: ABdhPJxsrhhw8g7eI1YVzBIznDgRMAmCClrJdNup9ERXc1Nr2x1uIlDg7Wv7InbVU/OHomu6doc/5w==
X-Received: by 2002:a05:6a00:b49:b0:49f:bad2:bd7c with SMTP id p9-20020a056a000b4900b0049fbad2bd7cmr64370383pfo.64.1637332419941;
        Fri, 19 Nov 2021 06:33:39 -0800 (PST)
Received: from [172.16.8.241] ([98.149.220.160])
        by smtp.gmail.com with ESMTPSA id a19sm27029pgv.42.2021.11.19.06.33.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Nov 2021 06:33:39 -0800 (PST)
Subject: Re: [PATCH v1 0/2] serial: 8250_pci: Split Pericom driver
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Jiri Slaby <jirislaby@kernel.org>
References: <20211117145750.43911-1-andriy.shevchenko@linux.intel.com>
 <b99aabbe-add9-9c1e-ed4b-8850c69233de@accesio.com>
 <YZdfAdOcH2Bn1K+W@smile.fi.intel.com>
From:   Jay Dolan <jay.dolan@accesio.com>
Message-ID: <633bbad1-7b13-7299-a570-2bf1a87c47a5@accesio.com>
Date:   Fri, 19 Nov 2021 06:33:38 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YZdfAdOcH2Bn1K+W@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org



On 11/19/21 12:23 AM, Andy Shevchenko wrote:
> On Thu, Nov 18, 2021 at 10:32:51PM -0800, Jay Dolan wrote:
>> On 11/17/21 6:57 AM, Andy Shevchenko wrote:
>>> Split Pericom driver to a separate module.
>>> While at it, re-enable high baud rates.
>>>
>>> Jay, can you, please, test this on as many hardware as you have?
>>>
>>> The series depends on the fix-series: https://lore.kernel.org/linux-serial/20211117145502.43645-1-andriy.shevchenko@linux.intel.com/T/#u
> 
>> I have my current state here: https://github.com/accesio/linux/blob/split-pericom-driver/drivers/tty/serial/8250/8250_pericom.c
>>
>> * Change port type to UPIO_PORT
>> * Add in pericom_do_startup() because the UPF_MAGIC_MULTIPLIER doesn't
>> stick.
> 
> Thanks, I have updated my local tree with these changes.
> 
>> When I'm testing baud rates greater than baud_base I'm seeing strange things
>> on the scope.
> 
> Can you confirm that there are no issues with the first (fixes) series?
Yes. The fixes series has no issues, and was tested up to baud_base for 
both 14 and 24 MHz crystals.
> I have slightly changed your set_divisor() refactoring, it may be that issue
> is there.
> 
>> Maybe I'm just tired, and it's human error. I should be able
>> to get back to it and get it done on Saturday.
> 
> Thank you.
> 
