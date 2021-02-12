Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD23EC433E0
	for <linux-serial@archiver.kernel.org>; Fri, 12 Feb 2021 20:47:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE68864E01
	for <linux-serial@archiver.kernel.org>; Fri, 12 Feb 2021 20:47:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231446AbhBLUry (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 12 Feb 2021 15:47:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231445AbhBLUrw (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 12 Feb 2021 15:47:52 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34341C061574;
        Fri, 12 Feb 2021 12:47:10 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id s15so454977plr.9;
        Fri, 12 Feb 2021 12:47:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9nlPrdgdpUhBT4OqPIpJHurxob/WSRTldRiaZgCuebA=;
        b=mEalseKMxInqyKHV7UpFcJBMqxSyFknnSvj7smKWsPgaa04masHhh4Nf9nN3eNhjPG
         zzzwGLnVafIckFzjBfsEgDgibHfhSz1I47NzHWqMrUX/HbhBoGUFRJ8xzmtpykyQiRQW
         CNwu0Ki4ybC8HpTAeLxosIa6MyIqwnRjMs2n/oNdVu1YhGpy8tXPJzYd08EoqwWzTcIq
         ArAZatvCv4/bAcEFQFIEz5PXhFQI4t4C36gEN82yxrOVDPzumFN2viNJuB690YirePqK
         /6J+GXoQqPFwfdBOVDV+yqPUBOI33H5nobS4jsj+yM5wCTYyPLMzaY9TxsIQlsB4WTwe
         dHgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9nlPrdgdpUhBT4OqPIpJHurxob/WSRTldRiaZgCuebA=;
        b=r3fK26H+WO3CRLnPIZq4ey5col9N556jo05gpIG+pIuiMIlt0IhxRlyct/jWmUQEsn
         rI547Z87gFzum7ZKh9T7QgQ2DQWb/Vgff1xQIyWzw5rRkOjNMr1UFwz/2w5YaMd5QQnn
         ghMp0+a4dwPqJKBZO4BoPYqBkOqyzD07yYlmmWbeyqnbpGegAtYhRmrkufSujMScQZwM
         a390v7DTQpCCHxH/mpE+Zc1LlRxS5wRZpIviCJLD+wbzVyKk8xKfyhkGHCD4taAVsIxe
         /gWR/ZNdGc5CPNYdlQJM6+OpBnyueOA41JvYZH71KTvLPU2iNhGrfXZdiFKGua5IF6It
         aF3g==
X-Gm-Message-State: AOAM530dyH0Q6OnIkOGUhSsrzm+THpp0A3jXRRAA0A3CxxPjPBkB5nWs
        aBVMaohqx2/d8eiRfDDhzZI=
X-Google-Smtp-Source: ABdhPJzS5Lrk7YliIkxbQhanWAw0UsFKk7hCmMvP3GxFB0VhGdCErkgqFxJLgLSLeik+D9D4ORGB9g==
X-Received: by 2002:a17:90a:ce03:: with SMTP id f3mr4230246pju.44.1613162829402;
        Fri, 12 Feb 2021 12:47:09 -0800 (PST)
Received: from [10.230.29.30] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id t22sm10659579pgm.18.2021.02.12.12.47.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Feb 2021 12:47:08 -0800 (PST)
Subject: Re: [PATCH v3 2/2] serial: 8250: Add new 8250-core based Broadcom STB
 driver
To:     Al Cooper <alcooperx@gmail.com>, linux-kernel@vger.kernel.org
Cc:     bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, linux-usb@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Rob Herring <robh+dt@kernel.org>
References: <20210212195736.45328-1-alcooperx@gmail.com>
 <20210212195736.45328-3-alcooperx@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <8cb4bae6-5617-8dd5-4c0f-4c81cb4d741b@gmail.com>
Date:   Fri, 12 Feb 2021 12:47:02 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210212195736.45328-3-alcooperx@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org



On 2/12/2021 11:57 AM, Al Cooper wrote:
> Add a UART driver for the new Broadcom 8250 based STB UART. The new
> UART is backward compatible with the standard 8250, but has some
> additional features. The new features include a high accuracy baud
> rate clock system and DMA support.
> 
> The driver will use the new optional BAUD MUX clock to select the best
> one of the four master clocks (81MHz, 108MHz, 64MHz and 48MHz) to feed
> the baud rate selection logic for any requested baud rate.  This allows
> for more accurate BAUD rates when high speed baud rates are selected.
> 
> The driver will use the new UART DMA hardware if the UART DMA registers
> are specified in Device Tree "reg" property.
> 
> The driver also sets the UPSTAT_AUTOCTS flag when hardware flow control
> is enabled. This flag is needed for UARTs that don't assert a CTS
> changed interrupt when CTS changes and AFE (Hardware Flow Control) is
> enabled.
> 
> The driver also contains a workaround for a bug in the Synopsis 8250
> core. The problem is that at high baud rates, the RX partial FIFO
> timeout interrupt can occur but there is no RX data (DR not set in
> the LSR register). In this case the driver will not read the Receive
> Buffer Register, which clears the interrupt, and the system will get
> continuous UART interrupts until the next RX character arrives. The
> fix originally suggested by Synopsis was to read the Receive Buffer
> Register and discard the character when the DR bit in the LSR was
> not set, to clear the interrupt. The problem was that occasionally
> a character would arrive just after the DR bit check and a valid
> character would be discarded. The fix that was added will clear
> receive interrupts to stop the interrupt, deassert RTS to insure
> that no new data can arrive, wait for 1.5 character times for the
> sender to react to RTS and then check for data and either do a dummy
> read or a valid read. Sysfs error counters were also added and were
> used to help create test software that would cause the error condition.
> The counters can be found at:
> /sys/devices/platform/rdb/*serial/rx_bad_timeout_late_char
> /sys/devices/platform/rdb/*serial/rx_bad_timeout_no_char
> 
> Signed-off-by: Al Cooper <alcooperx@gmail.com>
> ---
>  MAINTAINERS                            |    8 +
>  drivers/tty/serial/8250/8250_bcm7271.c | 1099 ++++++++++++++++++++++++
>  drivers/tty/serial/8250/Kconfig        |   11 +
>  drivers/tty/serial/8250/Makefile       |    1 +
>  drivers/tty/serial/8250/bcm7271_uart.h |  158 ++++
>  5 files changed, 1277 insertions(+)
>  create mode 100644 drivers/tty/serial/8250/8250_bcm7271.c
>  create mode 100644 drivers/tty/serial/8250/bcm7271_uart.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 64c7169db617..bb6ad2fc4376 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3582,6 +3582,14 @@ S:	Supported
>  F:	Documentation/devicetree/bindings/i2c/brcm,brcmstb-i2c.yaml
>  F:	drivers/i2c/busses/i2c-brcmstb.c
>  
> +BROADCOM BRCMSTB UART DRIVER
> +M:	Al Cooper <alcooperx@gmail.com>
> +L:	linux-usb@vger.kernel.org

This should probably be linux-serial, copy pasted from the USB entry
down below presumably.
-- 
Florian
