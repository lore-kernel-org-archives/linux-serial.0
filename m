Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1E27C4743B
	for <linux-serial@archiver.kernel.org>; Tue, 19 Jan 2021 18:29:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88B012333C
	for <linux-serial@archiver.kernel.org>; Tue, 19 Jan 2021 18:29:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389671AbhASSRt (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 19 Jan 2021 13:17:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392438AbhASSQw (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 19 Jan 2021 13:16:52 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2379BC0617A0;
        Tue, 19 Jan 2021 10:16:20 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id q4so10974493plr.7;
        Tue, 19 Jan 2021 10:16:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yO2k+wmEJJ8xH/LdKcVR5jElonjFD3LzbOdCVG89a24=;
        b=JuAp4fE1Om8r2jXXlMjO5EQi5ELsiLrAOz/7Zy1G6MLGJZu8BbcFwCxCtNHSUrn1jj
         MmAgtIXKIPipjExj1ugO237PHHtr7KE34SawUz5NB/gwppYKIcabT5jjH6rEn489hG83
         Twr9iCkqfYBF6/5myQHtdrcFuDYyeMk+PZEoL1SnFS7OzMNVmYArnSDx6s+tCQlvDqCN
         6xQVc4dtO2sI24n/ZN3pbXuADpSQFPslbOAnByTeZLqLeijMXFupmKD0uTal0iwxDJsM
         DGSJKnbxDZGnib4SEKELE+G0FY2R3UdBGwyAV22p7zhKnNuggW5IsRdFUN4vGoctgcKS
         TMQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yO2k+wmEJJ8xH/LdKcVR5jElonjFD3LzbOdCVG89a24=;
        b=tvVZ+XiEXpmPnk5Xv6+ARucPt2VssILU20tFcZnxgztVo8YnyrJgTTJium7SNiPUvv
         cpQXA94wI2FKsjWeH+AI2HXEIA13EAh/zj0v1aohnTn14OXv5euGo/ERDdwqNY2kexx+
         Nb4UMA/dE9bmCUNkB8IraVHsADkjALmQXPHsVRSJC9Ohhi6a+VkNactrieV0sf6muj/c
         YPJ23quoq5nRiaEwPUzSNAq+kLiRJtP1FkPYhXjtdRmk2r+ZY+x2aTZlXUJWyhk0yRpg
         /MzrfI354q3zujLa3YoTsqgyoibehQeitReyZA5FXaUy0p7GyzbHZPO3NqTn7g6cY3Hd
         a+Vg==
X-Gm-Message-State: AOAM531mlBd/ZobnFJoqllNfH9i9Xs0QWK6CuxF0fQIY+20IxmNSoQni
        wp3TEJHQYQki4vkbpQFKb+80kjJcOZE=
X-Google-Smtp-Source: ABdhPJzcggUh79T/vPrFJplztZOgRtqaMxMfiR3jkAw2gStudADC7DJRMqW/nK/e4Tb6fVJmNFZXqw==
X-Received: by 2002:a17:90b:4d09:: with SMTP id mw9mr990860pjb.199.1611080179615;
        Tue, 19 Jan 2021 10:16:19 -0800 (PST)
Received: from [10.230.29.29] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id k128sm8187958pfd.137.2021.01.19.10.16.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Jan 2021 10:16:18 -0800 (PST)
Subject: Re: [PATCH v2 2/2] serial: 8250: Add new 8250-core based Broadcom STB
 driver
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Al Cooper <alcooperx@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        devicetree <devicetree@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        USB <linux-usb@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Rob Herring <robh+dt@kernel.org>
References: <20210115211543.33563-1-alcooperx@gmail.com>
 <20210115211543.33563-3-alcooperx@gmail.com>
 <CAHp75VdQPQK8jTF3QDKx6mF1QzOg-qiuHrTiojnWn7GskokfoA@mail.gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <71d58a3e-2707-69d7-8074-c67235912e06@gmail.com>
Date:   Tue, 19 Jan 2021 10:16:16 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <CAHp75VdQPQK8jTF3QDKx6mF1QzOg-qiuHrTiojnWn7GskokfoA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org



On 1/19/2021 7:21 AM, Andy Shevchenko wrote:
> On Fri, Jan 15, 2021 at 11:19 PM Al Cooper <alcooperx@gmail.com> wrote:
>>
>> Add a UART driver for the new Broadcom 8250 based STB UART. The new
>> UART is backward compatible with the standard 8250, but has some
>> additional features. The new features include a high accuracy baud
>> rate clock system and DMA support.
>>
>> The driver will use the new optional BAUD MUX clock to select the best
>> one of the four master clocks (81MHz, 108MHz, 64MHz and 48MHz) to feed
>> the baud rate selection logic for any requested baud rate.  This allows
>> for more accurate BAUD rates when high speed baud rates are selected.
>>
>> The driver will use the new UART DMA hardware if the UART DMA registers
>> are specified in Device Tree "reg" property. The DMA functionality can
>> be disabled on kernel boot with the argument:
>> "8250_bcm7271.disable_dma=Y".
>>
>> The driver also set the UPSTAT_AUTOCTS flag when hardware flow control
>> is enabled. This flag is needed for UARTs that don't assert a CTS
>> changed interrupt when CTS changes and AFE (Hardware Flow Control) is
>> enabled.
>>
>> The driver also contains a workaround for a bug in the Synopsis 8250
>> core. The problem is that at high baud rates, the RX partial FIFO
>> timeout interrupt can occur but there is no RX data (DR not set in
>> the LSR register). In this case the driver will not read the Receive
>> Buffer Register, which clears the interrupt, and the system will get
>> continuous UART interrupts until the next RX character arrives. The
>> fix originally suggested by Synopsis was to read the Receive Buffer
>> Register and discard the character when the DR bit in the LSR was
>> not set, to clear the interrupt. The problem was that occasionally
>> a character would arrive just after the DR bit check and a valid
>> character would be discarded. The fix that was added will clear
>> receive interrupts to stop the interrupt, deassert RTS to insure
>> that no new data can arrive, wait for 1.5 character times for the
>> sender to react to RTS and then check for data and either do a dummy
>> read or a valid read. Sysfs error counters were also added and were
>> used to help create test software that would cause the error condition.
>> The counters can be found at:
>> /sys/devices/platform/rdb/*serial/rx_bad_timeout_late_char
>> /sys/devices/platform/rdb/*serial/rx_bad_timeout_no_char
> 
> Brief looking into the code raises several questions:
>  - is it driver from the last decade?

Work on this driver started back in 2018, that was indeed the last decade.

>  - why it's not using what kernel provides?
>  - we have a lot of nice helpers:
>    - DMA Engine API

Not sure this makes sense, given that the DMA hardware that was added to
this UART block is only used by the UART block and no other pieces of HW
in the system, nor will they ever be. Not sure it makes sense to pay the
cost of an extra indirection and subsystem unless there are at least two
consumers of that DMA hardware to warrant modeling it after a dmaengine
driver. I also remember that Al researched before whether 8250_dma.c
could work, and came to the conclusion that it would not, but I will let
him comment on the specifics.


>    - BIT() and GENMASK() macros
>    - tons of different helpers like regmap API (if you wish to dump
> registers via debugfs)
> 
> Can you shrink this driver by 20-30% (I truly believe it's possible)
> and split DMA driver to drivers/dma (which may already have something
> similar there)?

See previous response.
-- 
Florian
