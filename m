Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44FC0C433FE
	for <linux-serial@archiver.kernel.org>; Wed, 23 Mar 2022 10:42:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243604AbiCWKn4 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 23 Mar 2022 06:43:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243601AbiCWKnz (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 23 Mar 2022 06:43:55 -0400
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAEE86D1B4;
        Wed, 23 Mar 2022 03:42:25 -0700 (PDT)
Received: by mail-ed1-f53.google.com with SMTP id a17so1299584edm.9;
        Wed, 23 Mar 2022 03:42:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=vd7QNTqcRsNtUiR5SfPXYp8f/qt3tOGwUcaDmokl0Wc=;
        b=eyhA+oz2JcA2xSKhyGqXIInUrJdbRIC+SjFa4trP7EZoEct08vBFqs4XJr++ctFgPU
         aJAGwh9vq5QASRbEFEtYJduTSY33OGKTttYJzmk9olV+O93HMtnZAkVT/nCK922pbW0J
         fc7+UCJGyIO9NFClIcYPqN7OspA4Zg0M/67Hhri2hoFfx8aKAtfplk3R1oL5KbEXGRKb
         YCNcf1v1hBB6ufQwBcDJpm0BN8iCd0ZIns//+dVKTaXww+Xkp4FrkGzoxbX8PIjtbcEc
         /bhTB7U/s0JaEs7Fm2ICl42jb/fMzku969yHJZY4Jb2LYMLNTiV51w6UHcab2Wso+SSA
         mpuw==
X-Gm-Message-State: AOAM531fxCz9yFG77CQ9P7Y7Krv0/DcfnrfK2aaSh1Kq0ctDTP8atTif
        n1s/VloG946gbK9bL3JmTSA=
X-Google-Smtp-Source: ABdhPJzF5mK9OJgDsOl9Uf4V9+esys2ss5Bk0M7g0YKuOv7BY/U0lcMdVqKHlHgW4XH2eLmDEQybqg==
X-Received: by 2002:a05:6402:2553:b0:418:ff6a:ca66 with SMTP id l19-20020a056402255300b00418ff6aca66mr31596593edb.273.1648032144140;
        Wed, 23 Mar 2022 03:42:24 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.googlemail.com with ESMTPSA id gn1-20020a1709070d0100b006e012aaa918sm3928387ejc.139.2022.03.23.03.42.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Mar 2022 03:42:23 -0700 (PDT)
Message-ID: <faa4c924-a523-a02d-3fc8-7333e46c4038@kernel.org>
Date:   Wed, 23 Mar 2022 11:42:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 03/14] dt-bindings: serial: renesas,em-uart: Document
 r9a09g011 bindings
Content-Language: en-US
To:     Phil Edworthy <phil.edworthy@renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-renesas-soc@vger.kernel.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>
References: <20220321154232.56315-1-phil.edworthy@renesas.com>
 <20220321154232.56315-4-phil.edworthy@renesas.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20220321154232.56315-4-phil.edworthy@renesas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 21/03/2022 16:42, Phil Edworthy wrote:
> The Renesas RZ/V2M (r9a09g011) SoC uses a uart that is compatible with the
> EMMA Mobile SoC.
> 
> Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
> Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
>  .../devicetree/bindings/serial/renesas,em-uart.yaml         | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/serial/renesas,em-uart.yaml b/Documentation/devicetree/bindings/serial/renesas,em-uart.yaml
> index e98ec48fee46..42733eaa0ece 100644
> --- a/Documentation/devicetree/bindings/serial/renesas,em-uart.yaml
> +++ b/Documentation/devicetree/bindings/serial/renesas,em-uart.yaml
> @@ -14,7 +14,11 @@ allOf:
>  
>  properties:
>    compatible:
> -    const: renesas,em-uart
> +    oneOf:

No need for oneOf, you have just one element below.

> +      - items:
> +          - enum:
> +              - renesas,r9a09g011-uart    # RZ/V2M
> +          - const: renesas,em-uart        # generic EMMA Mobile compatible UART
>  

Does not look like you tested it...


Best regards,
Krzysztof
