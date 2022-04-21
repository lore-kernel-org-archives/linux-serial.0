Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D61C3C43219
	for <linux-serial@archiver.kernel.org>; Thu, 21 Apr 2022 07:49:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbiDUHwD (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 21 Apr 2022 03:52:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386198AbiDUHwC (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 21 Apr 2022 03:52:02 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AE951B7B2
        for <linux-serial@vger.kernel.org>; Thu, 21 Apr 2022 00:49:13 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id s25so5367639edi.13
        for <linux-serial@vger.kernel.org>; Thu, 21 Apr 2022 00:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=fZwf/2yPqjhAHVbwyiZ/I88oG/G8efeSV4EYSI+qW5M=;
        b=b4Rw8dqvX/DZNJZY/lCo5bYJ4t6peoNV3JUFCnCRVtTw/XN/fG0bJJtx9CsSw4InsR
         +WZtkhMxz3qqRxKZbu8mNRMCGnbw5Y853EDE8sz0ui4BvBsVLAU+Z0wCPhDsXf0CR+UF
         wFgxMHty77dY0ryQiQeLbU9mM72qx/vjY7FcAPIwVT1E2Pk2GBW5fxgFlF1/OpBdBSiA
         KM4SqwoaxyLRzVKmnykl8f9D05eWR+v+EwHcyzl9/DxsY+GLF529fVpgOdq90mfcjDz3
         n+TeuHPpBSEvvBBN/ke7dpG2UsRlI/tT2+xtkEEcqIzsSahz/qptaN23ywlBDt9kFL25
         vQPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=fZwf/2yPqjhAHVbwyiZ/I88oG/G8efeSV4EYSI+qW5M=;
        b=3odTnbZU7ZAC6Gtxeb64Dcv+KskDMYCEtJpKzixX7x6tq9gSg0ZCTZDhN7Gy9togCN
         4X/YZVcTXc3ao7ikL8kgbTA/PlVzc1R6dzPWtcyQUGc3qSF70K3hKMiyiZUxa6jTlENd
         11xxW6eDfTTMfaAO3GV/f/YCQSmp19jy+r6cRBRx/OqBN27N/b9fXhxXpCkfC9TvGzrD
         Z54m/y506UHfhPGaQ6tbDUlTt3EZSliXHDhog466dYbze+vBrqLvKQz1F3U1KB/I+vzN
         b1FsjMPRJrafdWKjAJSKTGTjwWRHzRxyNC2IFjFalc+9dMfbFIiBK8rAm9DPSrTcKVYg
         9ByQ==
X-Gm-Message-State: AOAM533dgeIjjb2PU4lzpj0S90s3u2hj6tLywNMyPZp02JWuavUDyfS0
        7jAfMNnrGL/nTqU5rGsdyz9VkA==
X-Google-Smtp-Source: ABdhPJx1JM9ca7dB2/T+1RieGRvO3xd5RjmUIW3NlFHeQdujxrRZiybGVZ8OrW1dWBAqr1q1ZcS8lg==
X-Received: by 2002:aa7:c895:0:b0:424:882:579b with SMTP id p21-20020aa7c895000000b004240882579bmr11031374eds.266.1650527351658;
        Thu, 21 Apr 2022 00:49:11 -0700 (PDT)
Received: from [192.168.0.226] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id hr35-20020a1709073fa300b006e8b9907b38sm7707349ejc.177.2022.04.21.00.49.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Apr 2022 00:49:11 -0700 (PDT)
Message-ID: <3ca55257-a884-59f8-f61f-1311f4a745d0@linaro.org>
Date:   Thu, 21 Apr 2022 09:49:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 08/15] dt-bindings: serial: renesas,hscif: Document
 r8a779g0 bindings
Content-Language: en-US
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        geert+renesas@glider.be, magnus.damm@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, gregkh@linuxfoundation.org
Cc:     linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org
References: <20220420084255.375700-1-yoshihiro.shimoda.uh@renesas.com>
 <20220420084255.375700-9-yoshihiro.shimoda.uh@renesas.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220420084255.375700-9-yoshihiro.shimoda.uh@renesas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 20/04/2022 10:42, Yoshihiro Shimoda wrote:
> R-Car V4H (R8A779G0) SoC has the R-Car Gen4 compatible HSCIF ports,
> so document the SoC specific bindings.
> 

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
