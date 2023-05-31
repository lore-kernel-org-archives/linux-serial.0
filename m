Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E050C77B7C
	for <linux-serial@archiver.kernel.org>; Wed, 31 May 2023 07:20:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232273AbjEaHUC (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 31 May 2023 03:20:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234495AbjEaHUA (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 31 May 2023 03:20:00 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FFFB122
        for <linux-serial@vger.kernel.org>; Wed, 31 May 2023 00:19:59 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-9707313e32eso1010231966b.2
        for <linux-serial@vger.kernel.org>; Wed, 31 May 2023 00:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685517597; x=1688109597;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wsS6GDqgpNAmHpKdI6b5w8uOTwICMlebaNtmOgCy3SM=;
        b=UGE5VJOgPZRwK1zQ550I76tAgWk8HJshIRMkpPniZYSi1k21x7Bx8Eab4hLWC2Z+FH
         J+kJAREVWZm+nJ52KpEYA7JyVbjxCPO4faJdV6xr5jeEt4BNjLFOAtYA1K2EkjlzSMls
         xwFSMIXqKN3OEQoHAwSaJgSbJg1FT4njaVSf69Ih0Ao+qvLMh27tEw/YFvtMQbHJygoT
         hYD0szXMmYwY/1G0pTBjcLLQHBNuuU5/VOItBf+HZAS+c8dJnpva6anMSQpE9KcKNqSO
         04Uk3kjE423BN29o2d7IJUJJHNQMwU8gEetZTKRHsp9iL4c91SOQpY46q0STtwIM7gYA
         6SAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685517597; x=1688109597;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wsS6GDqgpNAmHpKdI6b5w8uOTwICMlebaNtmOgCy3SM=;
        b=GHLRBSKZ0ScYiYzct3w/0P5zNLuf2xf7iYI3fhU/7iqKPZ98/aLdUm2X+1OMYc8Qto
         TdfSCR+2H66cfltjSTcb0EnUIkUjTRnAbIO55p+N45sYGSI9Haa4pwjFiXUV+FAcDZ/B
         yHBuUS95XX2WUjLAU0lZJ96zx/8s4CgoY/u+jyRxMPR+uEgSfehEJxHeqiTPHHt8Fl9r
         /sklpPpshNTpxRFuV4z3IXTUVoZqAcc49D6bc2DfJzZslg/36RhqXs95GBdCNVikjGMN
         BdhivfJV8Q0aM8TxDOpQjOPec3mtCaQqyhiS+y5dSoiAni43OfeoVklTFC91bnOtnlI4
         LJjA==
X-Gm-Message-State: AC+VfDx69FElCCbAKCQUWEOPkEp/DedfK7IvxwoC5jRAG97i7Sgep1/m
        B818aGJuDsIwn/f5AB2t7XYINfSnIy3hN84gWhnCyw==
X-Google-Smtp-Source: ACHHUZ5IM1zFOBAGfF7IUiwChLpT0Z/yB8ys3i5QgoDo+K7S/WmPZgCH48k4C3BiMdFd/r678IekOg==
X-Received: by 2002:a17:906:ef06:b0:973:940e:a01d with SMTP id f6-20020a170906ef0600b00973940ea01dmr4563977ejs.67.1685517597596;
        Wed, 31 May 2023 00:19:57 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.199.204])
        by smtp.gmail.com with ESMTPSA id b7-20020a1709062b4700b0096f6a131b9fsm8409136ejg.23.2023.05.31.00.19.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 May 2023 00:19:57 -0700 (PDT)
Message-ID: <dac15aee-1d01-dbfe-4ec3-52f296997a05@linaro.org>
Date:   Wed, 31 May 2023 09:19:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v1] dt-bindings: serial: 8250_omap: add
 rs485-rts-active-high
Content-Language: en-US
To:     Francesco Dolcini <francesco@dolcini.it>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Francesco Dolcini <francesco.dolcini@toradex.com>,
        linux-kernel@vger.kernel.org
References: <20230531064013.16551-1-francesco@dolcini.it>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230531064013.16551-1-francesco@dolcini.it>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 31/05/2023 08:40, Francesco Dolcini wrote:
> From: Francesco Dolcini <francesco.dolcini@toradex.com>
> 
> Add rs485-rts-active-high property, this was removed by mistake.
> In general we just use rs485-rts-active-low property, however the OMAP
> UART for legacy reason uses the -high one.
> 
> Fixes: 767d3467eb60 ("dt-bindings: serial: 8250_omap: drop rs485 properties")
> Reported-by: Francesco Dolcini <francesco.dolcini@toradex.com>

We do not add Reported-by tags for own reports. Otherwise all patches
would carry them. Reported-by is to credit 3rd party reported who did
not write the patch.


Best regards,
Krzysztof

