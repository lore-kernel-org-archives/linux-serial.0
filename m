Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E1A3C433ED
	for <linux-serial@archiver.kernel.org>; Thu, 20 May 2021 13:55:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1151860FE5
	for <linux-serial@archiver.kernel.org>; Thu, 20 May 2021 13:55:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238127AbhETN5D (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 20 May 2021 09:57:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240022AbhETN5B (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 20 May 2021 09:57:01 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2763DC061760
        for <linux-serial@vger.kernel.org>; Thu, 20 May 2021 06:55:39 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id j14so16037397wrq.5
        for <linux-serial@vger.kernel.org>; Thu, 20 May 2021 06:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iWzw33PkspV7y4yyaFnbDMAVw/W4YT9sq/Y05RvYpbo=;
        b=X9mlvAcF46/y2PCKyoQeXtctw2ARdhTu1su5ycYVMJp5rGCp45ujrZLreinTsXGGKq
         e9V2clmjfdgj3CVEclGVLCgx2iVJp+JRrIEoUfHPfU4/jRkzg59tlXgjNDLZ7pezTlHa
         nANuEju0hmFvkNwEul4yTfjvZJoxBE3j7xHfB6h/Aj5dAeuHKKe2Avye1hR7rynWNXv/
         q2L2FzZHlv/ZsTRKUMuHhwhrAf/KTgKzgDNKDwOHxS/sd/vrPIqo3AOSu/NfPm+ML3XR
         6Gh1DZaoTzpLOLrbom3YaHirJLTrkSYunLhznDaCeDpVD7BzzPwj59TtdOTn4qRGBquE
         NuJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=iWzw33PkspV7y4yyaFnbDMAVw/W4YT9sq/Y05RvYpbo=;
        b=BxRvNLa8FG5vfQxKB0ifqUHEIqJWfpliBxOxe09Dtv4T0Fg10YlmP6Mce2mJpC6v1p
         u0XiXKaHaUNUtJPYXxQXh3WoDp0hntU9FgTq8u88BQHXLoK5qUeuKUtmwXN/MKWOFijC
         FcdfqJPhkjNThbe9DhHsnAX7GkI7UyUt3pDYCNzVnCjhcPUenL/6lmxoA3iKqtoCReqH
         GQxbWwEr0oRT52oHh7K8Xx+6YmYIk/CLiFtcE98+yl3gObzL9ajlCx2koZcqeSLq5nes
         BY1IN7VsCbZKPYFLkiZ+BsoWJjVm6MGD+DW9ZEtBXczlF2PwB2bZi2URNkZguy4FUJi3
         1rtw==
X-Gm-Message-State: AOAM531KrUXS7UIQiCOQxQABUhyy41cPlwqBLBHHm4qdpdn0rGSWDj3h
        +DYKf7QV+gnXD0qJ5IEOC6E+/g==
X-Google-Smtp-Source: ABdhPJw2HGwGgozEkBz9pJr9jphqMHa+rt/tIRCmlyL5OLiPES8jbFSqi9biISOa/iKtTrQrMUJB3Q==
X-Received: by 2002:adf:db42:: with SMTP id f2mr4467026wrj.5.1621518937629;
        Thu, 20 May 2021 06:55:37 -0700 (PDT)
Received: from ?IPv6:2a01:e0a:90c:e290:d88a:b479:b222:83bb? ([2a01:e0a:90c:e290:d88a:b479:b222:83bb])
        by smtp.gmail.com with ESMTPSA id v20sm2910528wmj.15.2021.05.20.06.55.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 May 2021 06:55:36 -0700 (PDT)
Subject: Re: [PATCH 0/3] tty: serial: meson: add amlogic,uart-fifosize
 property
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        jirislaby@kernel.org
References: <20210518075833.3736038-1-narmstrong@baylibre.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
Message-ID: <9c6ce679-1721-be40-c1b2-6ae90503d2cb@baylibre.com>
Date:   Thu, 20 May 2021 15:55:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210518075833.3736038-1-narmstrong@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Greg,

On 18/05/2021 09:58, Neil Armstrong wrote:
> On most of the Amlogic SoCs, the first UART controller in the "Everything-Else"
> power domain has 128bytes of RX & TX FIFO, so add an optional property to describe
> a different FIFO size from the other ports (64bytes).
> 
> This adds a property in the bindings, reads the property from the driver and updates
> the DT with the new property.
> 
> Changes since v2:
> - removed spurious blank line from bindings
> 
> Changes since v1:
> - switched to a more generic "fifo-size"
> 
> Neil Armstrong (3):
>   dt-bindings: serial: amlogic,meson-uart: add fifo-size property
>   tty: serial: meson: retrieve port FIFO size from DT
>   arm64: dts: meson: set 128bytes FIFO size on uart A
> 
>  .../devicetree/bindings/serial/amlogic,meson-uart.yaml       | 5 +++++
>  arch/arm64/boot/dts/amlogic/meson-axg.dtsi                   | 1 +
>  arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi            | 1 +
>  arch/arm64/boot/dts/amlogic/meson-gx.dtsi                    | 1 +
>  drivers/tty/serial/meson_uart.c                              | 5 ++++-
>  5 files changed, 12 insertions(+), 1 deletion(-)
> 

Could you apply patches 1 & 2 ?

Thanks,
Neil
