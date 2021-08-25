Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE5ADC4338F
	for <linux-serial@archiver.kernel.org>; Wed, 25 Aug 2021 12:27:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 800386115A
	for <linux-serial@archiver.kernel.org>; Wed, 25 Aug 2021 12:27:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240271AbhHYM1t (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 25 Aug 2021 08:27:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238179AbhHYM1s (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 25 Aug 2021 08:27:48 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01DB3C061757
        for <linux-serial@vger.kernel.org>; Wed, 25 Aug 2021 05:27:03 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id z4so20523473wrr.6
        for <linux-serial@vger.kernel.org>; Wed, 25 Aug 2021 05:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=essensium.com; s=google;
        h=from:subject:to:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=HR1YEVwi08sjGefxmPRZwHfWUBoJGo/Np9pKmvRPjgU=;
        b=NXJjoKk6rmTOj5VlczVF4Ql00deGioanpiJ9KusU/GdyNrKMMDHKX1vAUFmfxW8HLX
         2JYy+bapSRLKElvgbKnSTF7cqxI/rw8mDCx5PTM45w5dySXlv9OUBRFQVDp2n8Vm2mz0
         rMcHmFSbXvs3XqhceaPfc4V4Q/yTfDyEyukTRey05KZseLgssFqacHdzG9lsiF/VrO5b
         6q9n46atn+kB7a7RTPKyqSuwLfE736j+KAb/VpvPnQ/Ib6IbfUXtmTLR2HIRU48zr3kW
         P6yNRoqb82a0igzGy7kicNVlQwyf8Au+wWdPlcvjpJRlYIA9wmwqxy5XHGLjGLKqHgf4
         T1xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=HR1YEVwi08sjGefxmPRZwHfWUBoJGo/Np9pKmvRPjgU=;
        b=HAMasWZqqKY/oLe05JfzAJ8nCOkOD6PbTI3zfyqT2FzFr5KuSq5I3aYYWmuo73hJH3
         cU5xlE214ilvwm9Zjmf/Qb65FM/cqtympf2nXQiS2DBYFdg+gkqyA68H7/GIcnps/giV
         gqkfj8ktmOWtVY2E3wWRyvwyxqSvkgabT7mMy6L/cTLK4XJIqhto5gTaK+ZD7MWlokHK
         EQcnWz0sn2DA/7EDxnb/q8pTyPc22EvelDfuY83qjbGbQUVmaREOo3L/6teZbU1SEvqn
         LKzziZcBdt6Oafbv6fn3Qg001Ikiz+0AR++EcmQeBgDJcdG7brYM+PLcLGdtJ0g2nbR9
         T8ew==
X-Gm-Message-State: AOAM531eE1wii2CUT1ZPE7VdrTPWWi547T4UnYc4iPPiNnGyhfRuoMWv
        bH4T+Loe9oSJ7fI+NvydTI+h4MoTV90R52lm
X-Google-Smtp-Source: ABdhPJzGriXWhRpAvhP3siCw1IkigDq9FL/YuXl0Rv/TWzOlB29//1GwtT0NPx/tIVHmkGNZs71UGw==
X-Received: by 2002:adf:a45b:: with SMTP id e27mr14179158wra.222.1629894421619;
        Wed, 25 Aug 2021 05:27:01 -0700 (PDT)
Received: from [10.8.0.46] (ip-188-118-3-185.reverse.destiny.be. [188.118.3.185])
        by smtp.gmail.com with ESMTPSA id l15sm10338354wrv.84.2021.08.25.05.27.00
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Aug 2021 05:27:01 -0700 (PDT)
From:   Patrick Havelange <patrick.havelange@essensium.com>
Subject: question about uart_state xmit buffer behavior
To:     linux-serial@vger.kernel.org
Message-ID: <0ed97575-cb9f-51b0-9210-29641803040e@essensium.com>
Date:   Wed, 25 Aug 2021 14:26:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hello,

I've been developing a uart_driver for some custom hardware, and I've 
noticed this behavior:
If a software writing a large amount of data is canceled (ctrl-c), then 
some of its previous data is still present in the xmit buffer the next 
time the device is opened by a second program, and thus transmission 
begins again, regardless of the action of the second program.

To be more clear, this is the concrete scenario:
running "seq 1 100000000 > /dev/myttydevice" in order to generate some 
data. Then hitting ctrl-c to abort it.
Then running "stty -F /dev/myttydevice -a" to check the settings.
When stty is started, my driver starts sending some more of the content 
of the previous seq command, and, as this time stty is not canceled, the 
uart_driver is waiting for the transmission to be finished before 
closing, which takes several seconds as there can still be lots of data 
to send.

Thus starting stty in order to check the configuration, resulting in 
transmitting lots of previous data and a long time before the command 
itself finishes seemed strange to me.

After looking into the code, I've come to the conclusion that the xmit 
buffer is cleaned when the flush_buffer callback (uart_flush_buffer()) 
is called from the tty layer.
Which is done from tty_driver_flush_buffer(), which is done from 
tty_port_close_start().
However tty_port_close_start() only calls it if the flag 
tty->flow_stopped has been set, which is only set via some ioctl .

Thus the flush callback is not called in my case, and the xmit buffer is 
not empty the next time the device is opened.

I've been using the kernel 4.14.222. I can't test easily with a more 
recent kernel, as the main kernel would require a non trivial amount of 
patches to be ported to the newer version. However looking at the diff 
between this 4.14 version and the last lts version (5.10.60), I haven't 
seen any changes relevant to that behavior.

As a workaround, I've been calling manually 
uart_circ_clear(&port->state->xmit); in my startup callback.

So, is the described behavior expected ?
Did I forget to do something in my uart_driver that could explain this ?
Or something else that I missed ?


Best Regards,

Patrick Havelange

