Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32218C2B9F4
	for <linux-serial@archiver.kernel.org>; Fri, 25 Jun 2021 07:52:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11FA461351
	for <linux-serial@archiver.kernel.org>; Fri, 25 Jun 2021 07:52:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbhFYHyj (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 25 Jun 2021 03:54:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229474AbhFYHyj (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 25 Jun 2021 03:54:39 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53360C061574;
        Fri, 25 Jun 2021 00:52:19 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id k6so7363490pfk.12;
        Fri, 25 Jun 2021 00:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fmnMOH13s9fHpp424cL+5TDyRw9czufBkKSD0sxgjcg=;
        b=IES7naOlxzpgwuI/xJPxIJOesXyQiZ7O4ibSZkj96clDB/0dvvZYHKbhQxLb58ih7p
         m0ijuQCxyDRy9YhoiZvFujgC2viTikR3BYL/Is5ahOy9hl0Z1QGzXS/pmZZb9GKtSwPu
         pUkHZf6vItsRKhz4ZoR80QAwR7tVVJf+wa4E2izzYWc7971UsgRNeJd/yJprLwmEMOjw
         +qRWJfpwd3h896Dz/ENDZm1oJYdBxxbf+P2ZNYTsHkhnA7KY1QjkFRA+owZP36X1564Q
         SBg35fSXF7vIS8ndS6bflCBXUK1GCcz4nLJXhR4UNnfiAJqY0w7lxjUiFuK/tIKdRYVS
         ie2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fmnMOH13s9fHpp424cL+5TDyRw9czufBkKSD0sxgjcg=;
        b=q1X3NqhGyIY3I+uknrJ2lfko7fuCrwFZ5ZiDf4pBPxZT4wozfSoZ/sa5q0Ul+GmtHX
         a3ANF0/DRRGHZ78+1nLvrpQGqmF6qfkesLOvhEAaVopOQpovosOq8ZOUVHUJ3Sr0JZ2d
         VtscRBxWqEYeue0yNq5qCJ5mDBsc0NguEdSJZh8kVa6XQyk7iB6jPkcZ+AwTj3/Ujx/Z
         bj0Wierv2Bf5Uwu4beeAmpg/Pt9ti3SmlGY+0xXh0CLF3K9farkH9UQSrlCk2esH6c9s
         yKHclGS5XL6q2RYh8RLyOQVNHocdBODRvwyTSHh+WJSBRHWzQvR50+PJzeUHDtPr1bzE
         v4uA==
X-Gm-Message-State: AOAM533DPoC5Cv78l8Tb54uWWD1sfluiIowQ+FWGSOhL2UBqtdiSZWJ2
        L7Qbqeqa/JnTC4/Nat2PErs=
X-Google-Smtp-Source: ABdhPJxMcBZ7FY3IvPyG2MonIOQe818xdSVSqXg0UYxMc9UlT2SD7Ue8J/ixZoaWuiFuPm9WTpakHA==
X-Received: by 2002:a65:5c4a:: with SMTP id v10mr8400622pgr.142.1624607538832;
        Fri, 25 Jun 2021 00:52:18 -0700 (PDT)
Received: from [192.168.0.118] ([103.242.196.10])
        by smtp.gmail.com with ESMTPSA id 195sm5041416pfw.133.2021.06.25.00.52.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Jun 2021 00:52:17 -0700 (PDT)
Subject: Re: [PATCH] tty: serial: owl: Fix data race in owl_uart_remove
To:     Johan Hovold <johan@kernel.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>, jirislaby@kernel.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        ldv-project@linuxtesting.org, andrianov@ispras.ru
References: <20210617110443.6526-1-saubhik.mukherjee@gmail.com>
 <YMswdqNpjb9n1pdW@kroah.com> <ceebf511-9971-6deb-a6dd-458d69de2bbd@gmail.com>
 <YNLfxMZZ0a80qKLg@hovoldconsulting.com>
 <a9d43126-acd7-efb0-bf1a-86b06965f0e2@gmail.com>
 <YNR6uEbCJOa9s3hG@hovoldconsulting.com>
From:   Saubhik Mukherjee <saubhik.mukherjee@gmail.com>
Message-ID: <ff208383-aefa-17d0-891c-ee5a10edd1fe@gmail.com>
Date:   Fri, 25 Jun 2021 13:22:11 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YNR6uEbCJOa9s3hG@hovoldconsulting.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 6/24/21 5:59 PM, Johan Hovold wrote:
> On Thu, Jun 24, 2021 at 05:37:38PM +0530, Saubhik Mukherjee wrote:
>> On 6/23/21 12:46 PM, Johan Hovold wrote:
>>> On Wed, Jun 23, 2021 at 11:06:53AM +0530, Saubhik Mukherjee wrote:
>>>> On 6/17/21 4:52 PM, Greg KH wrote:
>>>>> On Thu, Jun 17, 2021 at 04:34:43PM +0530, Saubhik Mukherjee wrote:
>>>>>> Suppose the driver is registered and a UART port is added. Once an
>>>>>> application opens the port, owl_uart_startup is called which registers
>>>>>> the interrupt handler owl_uart_irq.
>>>>>>
>>>>>> We could have the following race condition:
>>>>>>
>>>>>> When device is removed, owl_uart_remove is called, which calls
>>>>>> uart_remove_one_port, which calls owl_uart_release_port, which writes
>>>>>> NULL to port->membase. At this point parallely, an interrupt could be
>>>>>> handled by owl_uart_irq which reads port->membase.
>>>>>>
>>>>>> This is because it is possible to remove device without closing a port.
>>>>>> Thus, we need to check it and call owl_uart_shutdown in owl_uart_remove.
>>>
>>> No, this makes no sense at all. The port is deregistered and hung up by
>>> uart_remove_one_port() (and the interrupt line is consequently disabled
>>> by the driver) before it is released so this can never happen.
>>
>> Thanks for the reply. I am not sure I understand. I could not find any
>> interrupt disabling in owl_uart_remove. Could you point out where/how is
>> the interrupt line is disabled before releasing the port?
> 
> The interrupt line is disabled by owl_uart_shutdown(), which is called
> when uart_remove_one_port() hangs up an open tty. And as I mentioned
> this happens after deregistering the port (so no new opens) and before
> releasing the port.
> 
> Johan
> 

Thank you very much for the explanation. So, indeed shutdown is called 
before releasing port. There is no need for a patch.
