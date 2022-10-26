Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECA47ECDFA1
	for <linux-serial@archiver.kernel.org>; Wed, 26 Oct 2022 19:36:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234170AbiJZTgb (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 26 Oct 2022 15:36:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234428AbiJZTga (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 26 Oct 2022 15:36:30 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A26F97C754
        for <linux-serial@vger.kernel.org>; Wed, 26 Oct 2022 12:36:29 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id bn35so15022795ljb.5
        for <linux-serial@vger.kernel.org>; Wed, 26 Oct 2022 12:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2crP+CNTSVg/qssMO0+pA6fHPnsnBY1oB+6tJDNUVrY=;
        b=E68Eqd4yO5pAtgzk93S9wnj833V3o7j6XqjWKC+M2wnIQ4tatOJEuZR2tAIIJkctSZ
         LZ8kVWqp0b/0P/SiykcjHZmqMs6BjDNVrUQmHBJNV/9NX/xT17+8N4C5WMrj67l8/duL
         vYRNYr4n3+DCKoTs0yN5AyWKEzd0uBEw3yr6AwRYEcs6A0CVlL8L5Z0MF705ZRu72GnT
         C8vOzUpcHous9L1imwZPEL81ftSG5sNfXm3PVJWXfMADgR9TmQvRfP4uUYAsBe1q7nsq
         8+sMVRPxwFL26S50oDObtnoVppZGZLl+5z/n+GPU/qYtPNsmxPqz1hb+FOvO4Epk7nfI
         /gsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2crP+CNTSVg/qssMO0+pA6fHPnsnBY1oB+6tJDNUVrY=;
        b=PL/l4JIkf3eTG50mcKE6ijazlWS5z61DHg5vCw3bUdjvjMDHMci5bVP8163/t1T00I
         kZhhruEPfVfBHGTyt5PfMgh58EM8Hl3Nco9muTE4f6cBySH3rcicBTEgraFANSCIzl+S
         VMhviBelsScXL5q/DB3jRBcj9lNSTY7Oii0BnsH2mYuLW5RCU+NxPsPnjzT+vWUuShlq
         gLPeQBDd9V+pDbd2IFwJPEL33kKAZTx9euBz0UKWpf5UbsWAP9EuOufzWG4DtQJHrsoP
         YueZGx5q33aCvmYSRNzU64XtCdMh/MdFo+KhJhz4QAQ8Q9Ujvie1/1qhvpKPVIGelfKo
         VUMg==
X-Gm-Message-State: ACrzQf3UTjReOFuNolvTMrzzDe6y+dwCkJxaD7SDI1SlES8q05Jm08MT
        dmcQE6GvG3cIiW+Qb6TMZXE=
X-Google-Smtp-Source: AMsMyM4Kqfx+vx+3ljOG+fKd4UeaU4Xi+E9nxHr/r2DcxSzNouT+f/W4hFYxRdYC7dB6Go5ChCyIOQ==
X-Received: by 2002:a2e:874e:0:b0:277:38b:212a with SMTP id q14-20020a2e874e000000b00277038b212amr9406417ljj.363.1666812987921;
        Wed, 26 Oct 2022 12:36:27 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id g10-20020ac2538a000000b004a2386b8cf5sm941538lfh.215.2022.10.26.12.36.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 12:36:26 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Francesco Dolcini <francesco@dolcini.it>
Cc:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        linux-serial@vger.kernel.org, Fugang Duan <fugang.duan@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Johan Hovold <johan@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>
Subject: Re: imx serial chars lost issue
References: <20221003110850.GA28338@francesco-nb.int.toradex.com>
        <20221026065604.xp4lzysm2ag7bfmk@pengutronix.de>
        <Y1jok9FxV4K9q6nb@francesco-nb.int.toradex.com>
Date:   Wed, 26 Oct 2022 22:36:25 +0300
In-Reply-To: <Y1jok9FxV4K9q6nb@francesco-nb.int.toradex.com> (Francesco
        Dolcini's message of "Wed, 26 Oct 2022 09:58:11 +0200")
Message-ID: <871qqubcna.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Francesco Dolcini <francesco@dolcini.it> writes:

> On Wed, Oct 26, 2022 at 08:56:04AM +0200, Uwe Kleine-König wrote:
>> On Mon, Oct 03, 2022 at 01:08:50PM +0200, Francesco Dolcini wrote:
>> > recently I have been experiencing an issue with the imx uart on i.MX6ULL
>> > SoC, on the tty console (no flow control, 1152008n1), chars after the 32nd
>> > are lost when typing "fast" (copy/paste or writing to the uart using
>> > automated tools).
>> > 
>> > This was tested on Linux 6.0, however it does not look like a brand new
>> > regression, kernel 5.4 was somehow subject to the same issue, although
>> > it was way more difficult to trigger it.
>> > 
>> > While I do understand that without flow control this is something that
>> > cannot be prevented, it is pretty fishy that is always the chars after
>> > the 32nd.
>> > 
>> > I guess that might be happening is that the FIFO is emptied only by a
>> > timer or when it is full, instead of emptying it when half-full, and the
>> > CPU might not be fast enough leading to an overflow and the chars lost.
>> > 
>> > Any idea?
>> 
>> It's not unheared that there are bugs in the imx serial driver, but I'm
>> at least half confident that it's not a driver issue.
>> 
>> I guess commit 7a637784d517 ("serial: imx: reduce RX interrupt
>> frequency") is relevant, this was added in v5.18-rc1.
>> 
>> If this is really the commit that made the issue easier to reproduce,
>> then this is a hint that there is no functional problem and we're "just"
>> talking about irq latency issues. If enabling flow control solves the
>> issue, this is another hint in the same direction.
>
> I can confirm that reverting 7a637784d517 makes the issue more difficult to
> reproduce, and even when it is reproduced the amount of chars lost is
> decreased. Enabling HW flow control is not trivial to test.
>
>> The other side starts sending chars at a high frequency. Once the RX
>> FIFO fill level reaches 8 an irq is triggered. Now if there are 25 more
>> characters received before the irq is serviced you get an overflow and
>> loose chars. Without 7a637784d517 there is a bit more time (i.e. 7
>> character times).
>> 
>> So either you use a very high baud rate that is hard to handle (compared
>> to the cpu frequency), or this is a side effect of increased irq
>> latency (which is likely a problem somewhere else).
>
> The uart is configured as 115200 8n1, 86usec per char, given the 25
> chars FIFO is 2.150msec to service the irq and get the data out of the
> fifo.
>
> Just thinking at the MHz the CPU is 792MHz, however it can (and will)
> scale down to 198MHz.
>
> I would say that something like that should be reasonable to handle, but
> it's just my gut feeling ...

A wild guess: make sure you don't use Linux kernel console on serial
port, i.e., /proc/consoles is empty. Serial console may disable
interrupts for very long time intervals due to kernel printk()
implementation.

I've got random data loss on serial ports when turning on and off WiFi
on my board (that caused some printk() diagnostic from the kernel) due
to this deficiency. Took ages to isolate.

-- Sergey Organov
