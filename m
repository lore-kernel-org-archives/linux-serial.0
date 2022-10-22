Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A5E3ECDFA1
	for <linux-serial@archiver.kernel.org>; Sat, 22 Oct 2022 16:35:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbiJVQfz (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 22 Oct 2022 12:35:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbiJVQfs (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 22 Oct 2022 12:35:48 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01544170DDA
        for <linux-serial@vger.kernel.org>; Sat, 22 Oct 2022 09:35:44 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id l5so6593369oif.7
        for <linux-serial@vger.kernel.org>; Sat, 22 Oct 2022 09:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1wTwC4Ee6yw0NAAZ3SkjkNV3Oq2jYBO7PuK3CzZZRGg=;
        b=HBvmicl1Fwkf7MAHF6WZTpDH21RnSjby85piUzyf1FMvYVRuNRNsMXaPW0Q75DjlGr
         IM93T0ucFwz1Y3iEYTgTbNraq5+JVZItTmOBBGpPJTxLrSHqwRsf5e9uNMxMeiP1r2Dp
         VrRGZTQ0pBEKBujkHQhsXE823QFI/+t1tnRMW+B6Lgvxd3EOZwjW88xmGreLn/DiVBvY
         tikviqf4KA4MNmvHi24AKn0qnqHU0PPPCAag5ZeqOM2w5z53xLMJqw63o2PvMENvjwv/
         jNOfDSJ99fCTwHzoMzitJDMzFyjgHsgLe8FDKzIQbf7DgeJQzmxbiXvtQviX2sfkkcgC
         zdbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1wTwC4Ee6yw0NAAZ3SkjkNV3Oq2jYBO7PuK3CzZZRGg=;
        b=BlTx8vUkVf6aom2XcI4G+WMS90xn07nLmDqSsbqEMQoh8va4WHDcFKvGxQdoPZiAvy
         THglvTAAUIItki/I6cgp8sStz7MLMPxEzPdjSWk1rmWCedtJnQs3q7H9wgzIkBSg0+Tl
         XOcnzQ8BFDMFvKB9QuRDFOV5d6/q7RtD0ipnF78Ia9cG7cMcbO6JjLY+YCW8GZPTA2Wd
         UH9SdVCtvh5+rIwpAqYmRDHfC5tm7G9ulUZqZqfNKKZ2DOWN7obNj46DybwM2RP6X+dF
         D2R0/VK+lKr3F7RQqCjRWwGMdDP+j/WOp3kVWn8S3MQ9rWeSILOWTPcYU93sjdvXRBeY
         z/KA==
X-Gm-Message-State: ACrzQf2gvkKF6tBmf8A5LiieCrZIJFffLgBIfvOuyFcPHi3L77R3ZN4k
        N0BF6QsNFMuAKRUoDOb+cbD9Fg==
X-Google-Smtp-Source: AMsMyM4o1osNu1n8drC4opFnWuBRqFxagfUvCY9kQrp6vhkVG0J46HyKHZ9MgpJvekJSSjd9/ktGog==
X-Received: by 2002:a05:6808:1717:b0:334:9342:63f1 with SMTP id bc23-20020a056808171700b00334934263f1mr29244965oib.77.1666456543234;
        Sat, 22 Oct 2022 09:35:43 -0700 (PDT)
Received: from [10.203.8.70] ([205.153.95.177])
        by smtp.gmail.com with ESMTPSA id c6-20020a056830314600b0066195c63f01sm2465033ots.12.2022.10.22.09.35.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Oct 2022 09:35:42 -0700 (PDT)
Message-ID: <d0a212ad-1f01-a824-594c-78c5424d5648@linaro.org>
Date:   Sat, 22 Oct 2022 12:35:40 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH] dt-bindings: serial: renesas,scif: Document r8a779g0
 support
Content-Language: en-US
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
References: <8a2d04651f04a97d652395b4d933af5c3c8d5b5b.1666360789.git.geert+renesas@glider.be>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <8a2d04651f04a97d652395b4d933af5c3c8d5b5b.1666360789.git.geert+renesas@glider.be>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 21/10/2022 10:02, Geert Uytterhoeven wrote:
> Document support for the Serial Communication Interface with FIFO (SCIF)
> in the Renesas R-Car V4H (R8A779G0) SoC.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

