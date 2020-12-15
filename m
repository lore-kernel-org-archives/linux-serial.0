Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5E4DC4361B
	for <linux-serial@archiver.kernel.org>; Tue, 15 Dec 2020 06:31:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4175F22258
	for <linux-serial@archiver.kernel.org>; Tue, 15 Dec 2020 06:31:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725889AbgLOGbW (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 15 Dec 2020 01:31:22 -0500
Received: from mail-ej1-f66.google.com ([209.85.218.66]:36086 "EHLO
        mail-ej1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbgLOGbW (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 15 Dec 2020 01:31:22 -0500
Received: by mail-ej1-f66.google.com with SMTP id lt17so26024803ejb.3;
        Mon, 14 Dec 2020 22:31:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qgGAx+DcyF9lGkz/ZRv2IXKaY5Dxe1QppBGGQgseKJ4=;
        b=FQxisqPuNlVPg/0SkBnJweRMqcDh0+2Oi7hBCqb5MMkiYj8iRwB2OKxSoTCdn+wuvA
         daAcLjrXeMr4f3frhwrLZ3imLCrA0IP4wCFGI5c5D4Qi9cUix+eoXctnVhA76HMIL4s9
         wmdhAS2mcfX8Qv3Jrb5Sqzvi33PWNjdziCW4MyMassRkf8d5qyhYvtXEq9yJpw3Al5QU
         Z3TgFWbRYEdhEU84Zj0ittkxfkIS7tcOvY/ZYbrD/+APTWoZN9niGYBm5c8dJf0jlwYs
         YXU+6GPVLp1wnNia/rB33XFHFIKa3rkgs/ckuqEhgzLgeVKkcwn08j6u2d1xVj2cj9+5
         vhZQ==
X-Gm-Message-State: AOAM530yvL5SJYHwON9fs+FF1YxR0IWB39vWtY8Igy6t+l+7e/FX6W9h
        +aheS7B0OQyEffkKGkBIw49vpU5JHb1dMw==
X-Google-Smtp-Source: ABdhPJxjIzFgdhTAPNb/qMjFKW8m0UKiIjalpjBP0yFMBKwEdo3P9TOX4O9g1qN42ZyZtx4lu6dQig==
X-Received: by 2002:a17:906:b217:: with SMTP id p23mr26036736ejz.461.1608013840056;
        Mon, 14 Dec 2020 22:30:40 -0800 (PST)
Received: from ?IPv6:2a0b:e7c0:0:107::49? ([2a0b:e7c0:0:107::49])
        by smtp.gmail.com with ESMTPSA id m7sm625463eji.118.2020.12.14.22.30.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Dec 2020 22:30:39 -0800 (PST)
Subject: Re: [PATCH v1] serial: 8250_fintek: Print Fintek chip name
To:     "Ji-Ze Hong (Peter Hong)" <hpeter@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Flavio Suligoi <f.suligoi@asem.it>
Cc:     "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20201214131445.954822-1-f.suligoi@asem.it>
 <X9dr2IvOgPyhsalE@kroah.com> <1b5f557d-165b-d2be-2c61-ef133019edf7@gmail.com>
From:   Jiri Slaby <jirislaby@kernel.org>
Message-ID: <f0009a5e-0501-3af8-e083-f191e33de103@kernel.org>
Date:   Tue, 15 Dec 2020 07:30:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <1b5f557d-165b-d2be-2c61-ef133019edf7@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 15. 12. 20, 1:29, Ji-Ze Hong (Peter Hong) wrote:
> Hi,
> 
> Greg Kroah-Hartman 於 2020/12/14 下午 09:42 寫道:
>>>       pdata->pid = chip;
>>> +
>>> +    pr_info("%s%s%s Fintek %s\n",
>>> +        uart->port.dev ? dev_name(uart->port.dev) : "",
>>> +        uart->port.dev ? ": " : "",
>>> +        uart->port.name,
>>> +        chip_name);
>>
>> Drivers, if all goes well, should not print anything to the kernel log.
>> This isn't ok.
>>
>> And even if it was, dev_info() would be the correct thing to do...
> 
> Maybe can transform pr_info() to dev_dbg() for debug usage ?

And even then, the newly introduced fintek_8250.chip_name is unused.

thanks,
-- 
js
