Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FDDCC432BE
	for <linux-serial@archiver.kernel.org>; Wed,  4 Aug 2021 09:36:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6BAF960230
	for <linux-serial@archiver.kernel.org>; Wed,  4 Aug 2021 09:36:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236719AbhHDJgO (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 4 Aug 2021 05:36:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:48314 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236736AbhHDJgO (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 4 Aug 2021 05:36:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628069761;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FO93m/MHnO53a3+8DD5E0AMlevGvUAfJrY9qeoAerNI=;
        b=ULJre6pB7f2HdkyqjfP2IRE2V+wSFJLaY2YkkIRWVrcpm1fIOFFqIcoqYSzcp64I78H/uC
        aXsvbx6Bsgt/iuZ8vhkiEI4tMFQEV2DRWZ1gnIr4WQKr1SWPhs0oEmmXYK6eQLLoc98A/A
        tQXpNa0s6bx8MPwGmoPBN0xhgfX784w=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-76-eo0DZ2SHMv-nKRqPKzTAUw-1; Wed, 04 Aug 2021 05:36:00 -0400
X-MC-Unique: eo0DZ2SHMv-nKRqPKzTAUw-1
Received: by mail-ej1-f69.google.com with SMTP id q19-20020a170906b293b029058a1e75c819so620039ejz.16
        for <linux-serial@vger.kernel.org>; Wed, 04 Aug 2021 02:35:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FO93m/MHnO53a3+8DD5E0AMlevGvUAfJrY9qeoAerNI=;
        b=eeL4V32ElWT3G2EPMh6I7UEa5aVl4BSQF2UUBdE0bvI+om452eKW8AER4rX8M4OR19
         Evun/NhsM3AULDfoCA4kLb+SdCA7JsPP3SXh3w7B/Cme3BDAr3VvdHN3DjmGX/bJaKS5
         dJKbJvKsiYdwtf795NGJbc/hOns4nDPNr1Xa6O0TCRZMTG37PjtoBxdXm/7bdayave5O
         uQpxbi43gIe6c3STDRkcWQBO3rBbKlD3YScuodu//4dv7KC1LHztyYioWOBCwCIM7eof
         85ZQBWKU8XjUXj5LWlPGloWljkP/Ru85Rv7UrPwGiY3aRk4z0bI99HHjhFlv9XKGIB6V
         226Q==
X-Gm-Message-State: AOAM532L/8KoG2s9kMYrI01qmtXJE3IZL0aOBpGbUcj2hAp2hVDAkEyq
        u2WlerGEGXgVIMuEN5egsTlX2JZeZXkWi9nwzUA2tpMHhGSoVbnb5RJSLpkenEaOlnQ0GCLD4O7
        CxPsjYDu3CpOc/GIbdJI6djlq
X-Received: by 2002:a17:906:45b:: with SMTP id e27mr24866218eja.375.1628069758763;
        Wed, 04 Aug 2021 02:35:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyRzA0xOiWv+MdZBbZINy6TPNICI1w6y8fEYuOxR+M5DlIwlzKJ/VmoEu79qig2Z6cZXUohSA==
X-Received: by 2002:a17:906:45b:: with SMTP id e27mr24866200eja.375.1628069758555;
        Wed, 04 Aug 2021 02:35:58 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id kk18sm497493ejc.114.2021.08.04.02.35.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Aug 2021 02:35:58 -0700 (PDT)
Subject: Re: [PATCH v1 3/5] Bluetooth: hci_bcm: Use
 serdev_acpi_get_uart_resource() helper
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-bluetooth@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Mark Gross <mgross@linux.intel.com>,
        Rob Herring <robh@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>
References: <20210803192905.72246-1-andriy.shevchenko@linux.intel.com>
 <20210803192905.72246-3-andriy.shevchenko@linux.intel.com>
 <87778067-5b45-8e83-b624-545b39a0e00d@redhat.com>
 <CAHp75VfLLpmz1b1suHuzLK-oMz89EN-Kce2nBrLfaC983y8bug@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <5a3b2266-8547-0d22-5046-2346ea81bd8d@redhat.com>
Date:   Wed, 4 Aug 2021 11:35:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VfLLpmz1b1suHuzLK-oMz89EN-Kce2nBrLfaC983y8bug@mail.gmail.com>
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

On 8/4/21 10:42 AM, Andy Shevchenko wrote:
> On Wed, Aug 4, 2021 at 11:13 AM Hans de Goede <hdegoede@redhat.com> wrote:
>> On 8/3/21 9:29 PM, Andy Shevchenko wrote:
>>> serdev provides a generic helper to get UART Serial Bus resources.
>>> Use it instead of open coded variant.
> 
> ...
> 
>>> +     if (serdev_acpi_get_uart_resource(ares, &uart)) {
>>> +             dev->init_speed = uart->default_baud_rate;
>>> +             dev->oper_speed = 4000000;
>>> +     }
>>> +
>>
>> You are replacing a nice switch-case which handles all relevant resource
>> types with still having a switch-case + a separate if .. else if .. else if ...
>> (also taking patch 4/5 into account).
>>
>> This does not help the readability of this code at all IMHO, so NACK
>> from me for this patch as well as for 4/5.
> 
> I guess it's a matter of style. The main idea is to try avoiding the
> spreading of the customized ACPI resource extraction here and there.

I agree that the helpers make sense for drivers which care about 1
specific type of resource like an I2cSerialBus resource.

But in cases like this where the driver cares about all the resources
in the resource-list just doing a switch-case on the resource-type
directly in the driver just seems cleaner and it certainly is
easier to read. Helpers are nice, but every level of indirection
also means that a developer needs to go and find the function and
lookup what it does when they want to know what is exactly happening.

So lining up all these factors then just sticking with the
switch-case here seems best IMHO.

Also when there is doubt if a cleanup actually makes things
better, which there seems to be here, then it is best to simply
stick with what we have since every code-change may introduce
regressions, may make backporting fixes later more difficult, etc.

Regards,

Hans

