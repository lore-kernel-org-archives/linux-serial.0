Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4917AC433EF
	for <linux-serial@archiver.kernel.org>; Wed, 16 Feb 2022 15:34:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234276AbiBPPe2 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 16 Feb 2022 10:34:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235357AbiBPPe2 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 16 Feb 2022 10:34:28 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C33A2265528
        for <linux-serial@vger.kernel.org>; Wed, 16 Feb 2022 07:34:14 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id bg21-20020a05600c3c9500b0035283e7a012so1917710wmb.0
        for <linux-serial@vger.kernel.org>; Wed, 16 Feb 2022 07:34:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:to:cc:references
         :from:in-reply-to:content-transfer-encoding;
        bh=vqp/utL9HYONeW1xjD6xb6XD/FxSpEuFWhkHZp5Rrxs=;
        b=MAjyrfyvnoe+Ibgut0vPNC8YcQGt5YtQn2gsJ1haeT3MuQv3drZkvk1x304CZ4ImIh
         xh8jHZaIZW20s9XuTeni/eU+7eUQkBcKJEAIvQX0ZlWTh5fhkrpNtwUqtegaDEHdnemw
         4MwEbp1oCwgyZMa+oUW4+LyaxjocrYpTSqke8r1x9Mz4LIzJ70Lp5SpQzNwIq62eiJK4
         i0Dj/HS601yU/F6kdbItV+ZMGG8BOTyULlw3nmt44pj36E4jmtt5wiNmQjgzAuQanLkQ
         hrdXyAf25RavzhNZJ4wHzkftG/uygT/mm/XDwUYT7T/ngZyyPNflrme26mea/4F87O6+
         l8Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :to:cc:references:from:in-reply-to:content-transfer-encoding;
        bh=vqp/utL9HYONeW1xjD6xb6XD/FxSpEuFWhkHZp5Rrxs=;
        b=BIc2P4PcNtttDRL+JvtVZ0PinttSaaQRf4F4ItM0pcnkMgarpqdYNoOk5wlSOQHprc
         5yj936xTzgrrSsGntgKiHflJD+k78vwsEpDs1GEenQYVuxyUw6oLLwjpSN6jY4Yahr6t
         KYq8GswgfnCQPVOwWOWMp0yu1s2arQQOZbgrm+KHs2+CJR6M9919yNAhYO5+exkqQPrC
         zOQoFhYJ2ISQO6V++m7zJc7BgH5rGLn/nj3uIo0GyymejPTTwu7FwS4H3BtPb3KNhZCz
         nQTN2Lg7rIE7btMXyEzq5sYAnYwktoFzadcI6ub7NXi3pAfGBzORN5H/AWMbEG/01opE
         0QHA==
X-Gm-Message-State: AOAM533Y0oabpfIansLGf+LPX5NrWPzHZlolqIAkA3jb4krtUmVn8fnd
        ZA9bk8OjVKMUkhg1vER2tGFfnA==
X-Google-Smtp-Source: ABdhPJzt8k9jKbzYrRHvA7vI3974wnBqgJAhu+4uYJSGbVq2/LDeONgQo/SCMN9DiY6B3H6K916UvA==
X-Received: by 2002:a05:600c:4f54:b0:37b:fe6a:ea9c with SMTP id m20-20020a05600c4f5400b0037bfe6aea9cmr2141117wmq.169.1645025653382;
        Wed, 16 Feb 2022 07:34:13 -0800 (PST)
Received: from [192.168.187.147] ([86.12.200.143])
        by smtp.gmail.com with ESMTPSA id l11sm25915681wry.77.2022.02.16.07.34.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Feb 2022 07:34:12 -0800 (PST)
Message-ID: <1a646631-5ea1-f65c-8a51-02d3233cab07@raspberrypi.com>
Date:   Wed, 16 Feb 2022 15:34:11 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH] sc16is7xx: Fix for incorrect data being transmitted
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org
References: <20220216150858.1016784-1-phil@raspberrypi.com>
 <Yg0WWr04G2yPo8TG@kroah.com>
From:   Phil Elwell <phil@raspberrypi.com>
In-Reply-To: <Yg0WWr04G2yPo8TG@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 16/02/2022 15:20, Greg Kroah-Hartman wrote:
> On Wed, Feb 16, 2022 at 03:08:58PM +0000, Phil Elwell wrote:
>> UART drivers are meant to use the port spinlock within certain
>> methods, to protect against reentrancy. The sc16is7xx driver does
>> very little locking, presumably because when added it triggers
>> "scheduling while atomic" errors. This is due to the use of mutexes
>> within the regmap abstraction layer, and the mutex implementation's
>> habit of sleeping the current thread while waiting for access.
>> Unfortunately this lack of interlocking can lead to corruption of
>> outbound data, which occurs when the buffer used for I2C transmission
>> is used simultaneously by two threads - a work queue thread running
>> sc16is7xx_tx_proc, and an IRQ thread in sc16is7xx_port_irq, both
>> of which can call sc16is7xx_handle_tx.
>>
>> An earlier patch added efr_lock, a mutex that controls access to the
>> EFR register. This mutex is already claimed in the IRQ handler, and
>> all that is required is to claim the same mutex in sc16is7xx_tx_proc.
>>
>> See: https://github.com/raspberrypi/linux/issues/4885
>>
>> Signed-off-by: Phil Elwell <phil@raspberrypi.com>
>> ---
>>   drivers/tty/serial/sc16is7xx.c | 3 +++
>>   1 file changed, 3 insertions(+)
> 
> What commit id does this fix?

That's a good question, and one you shouldn't have to ask. I was going to say 
[1] because it deleted a previous mutex, but I think it's use of a single 
workqueue for both IRQ and TX tasks made it safe. That leaves [2], which
replaces the IRQ work queue with a threaded IRQ, removing the reentrancy protection.

If you're in agreement I'll send a v2 with the appropriate Fixes: tag.

[1] commit 9e6f0ca3e567 ("sc16is7xx: use kthread_worker for tx_work and irq")
[2] commit 6393ff1c4435 ("sc16is7xx: Use threaded IRQ")

Phil
