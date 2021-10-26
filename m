Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 668D9C433F5
	for <linux-serial@archiver.kernel.org>; Tue, 26 Oct 2021 06:52:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C82D6103B
	for <linux-serial@archiver.kernel.org>; Tue, 26 Oct 2021 06:52:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234347AbhJZGyd (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 26 Oct 2021 02:54:33 -0400
Received: from mail-wm1-f44.google.com ([209.85.128.44]:37488 "EHLO
        mail-wm1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232362AbhJZGyY (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 26 Oct 2021 02:54:24 -0400
Received: by mail-wm1-f44.google.com with SMTP id b133-20020a1c808b000000b0032ca4d18aebso1945272wmd.2;
        Mon, 25 Oct 2021 23:52:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=QfkSZPoMimggynDHL2pT21prgWPy+I2plLgyZXHSGX4=;
        b=LDfdjJ4maZM/F43dNy16W1jHhbY/TSky8zWOCOkdfjNiY14fO/yDN0tDzmY/W1jeiX
         /UercdFqHSWO/Wz+L+xe8raVVjiwev0UWkYApOle2MDSs6o5JxzkPAKg3ZwBldaqecW3
         upBrQQNfy6ulRMd+LUlUwGfWWV9NKw8iK5S9Yh9cMrM7oDo6Iwivyw4OTPUsuxLVJ4Bz
         73Z2GAI7u5ShvXOGoVEtsApiRdXioCrd9graEugmaSwz8l7zoNzOkk5SEKnmtHvQ0f4P
         +PJbv4GfUrd62bQ/ewup9tidwdrDvqk5kKL3YXJU1EjzAZsA0T/1ECeWdNWYGBB0o2VY
         LqUA==
X-Gm-Message-State: AOAM530YQGHLjaRu+afy+XwER4sqvd+tTuoHY1UEHUi7bvPBTH7MIvwJ
        qEoLV/16cRcnPRN93H9/tVA=
X-Google-Smtp-Source: ABdhPJzB6wD/h4ICAeDhAoOhO/a6dSTMsf/apvignhmv2YxCOjIQdkW9AFF/hyHTo0okHPRYyceimA==
X-Received: by 2002:a05:600c:354c:: with SMTP id i12mr25983545wmq.59.1635231119389;
        Mon, 25 Oct 2021 23:51:59 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::49? ([2a0b:e7c0:0:107::49])
        by smtp.gmail.com with ESMTPSA id h1sm17465747wmb.7.2021.10.25.23.51.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Oct 2021 23:51:58 -0700 (PDT)
Message-ID: <415254a7-dcf2-75d8-2d92-6e3f568fc8b2@kernel.org>
Date:   Tue, 26 Oct 2021 08:51:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2 1/3] serial: 8250_pci: Refactor the loop in
 pci_ite887x_init()
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211022135147.70965-1-andriy.shevchenko@linux.intel.com>
 <db3f31f4-46ed-0b6b-89a5-b3cb447e0fa7@kernel.org>
 <YXejtg5qZ3nLeu2S@kroah.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <YXejtg5qZ3nLeu2S@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 26. 10. 21, 8:44, Greg Kroah-Hartman wrote:
> On Tue, Oct 26, 2021 at 07:26:18AM +0200, Jiri Slaby wrote:
>> On 22. 10. 21, 15:51, Andy Shevchenko wrote:
>>> The loop can be refactored by using ARRAY_SIZE() instead of NULL terminator.
>>> This reduces code base and makes it easier to read and understand.
>>
>> Why don't we have array_for_each() BTW?
>>
>>> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>>
>> Reviewed-by: Jiri Slaby <jslaby@kernel.org>
> 
> And now my emails are bouncing as you typed your address incorrectly :(

Sorry for that. My WM currently crashes when I use key shortcuts (key 
input in plasma is not implemented under wayland). So I had to write 
those manually and screwed up. Let me improve my workflow now.

thanks,
-- 
js
suse labs
