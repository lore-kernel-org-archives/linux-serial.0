Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 417E8C761AF
	for <linux-serial@archiver.kernel.org>; Thu, 30 Mar 2023 07:29:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbjC3H3E (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 30 Mar 2023 03:29:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjC3H3D (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 30 Mar 2023 03:29:03 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 887B84215
        for <linux-serial@vger.kernel.org>; Thu, 30 Mar 2023 00:29:02 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id t14so18655653ljd.5
        for <linux-serial@vger.kernel.org>; Thu, 30 Mar 2023 00:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680161341;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P604ZsnbOAq+v946nFOReMjJ0gLlyxAiHWhlhNsrYw0=;
        b=xsBSmoe88rD4Sr50VffU0fNEmBXRlUvvh8TDt27Dyhnm/kFhaJgj6ixqWOG1gJEalG
         Gxk7TY4Wedj4oBTt3khUI1y4Wf4zkvkqbiEeEFcns06tTP432Z7/Qmf+NIWItV0n0wfm
         zBO2SfmMO+X7Up696N9Qv7TqKTmGWqpcUiSTWmn10E0hS3OFpGVjzbBIunnVmSwzCpvc
         SSrsRxs3V6XdnLIWDaErDgWxTORmKZUJULS197zoUnxTX13CnlBhQxldDkmByUVrbMAp
         hUtx5UeLkqsZKFNkDn5HxGn2av3vfGwjkW4PkeDiihQ7bXL047YlBzlu51Ozw+p5v1WB
         c2Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680161341;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P604ZsnbOAq+v946nFOReMjJ0gLlyxAiHWhlhNsrYw0=;
        b=yNeGppN9CWG31a7ZYSDZ6mowYpjqT/kl5z9UsHq2QI5l9tkzZGFyfK1X0RgCWkkqEU
         htPC7WnbbtZyuWO/1ZcU1fn0Ckfguyl0GOmJTtfDFjCCXIbSbfCDA6ey4lsqY+YrUViR
         J0kvhwnDzP8WEXhKy7vfoT37d83Aj8oYZGpUQo5xmdsmpV2LSIqgytHsAerN61YJ+KJZ
         YO2ANG/9uzDTuMNhXXPxw7HMJXZzXgrJwXEdRakBuplEyweIn4PBAzLNLuFzmHSP0kdV
         F8aufQbmIjQAjk4V+rpDrB8QsYQxWM3amK+zf6lkKVtncRBpyt4qOQjNc5+IOK5qbVmv
         DtDg==
X-Gm-Message-State: AAQBX9ewSxrKRmakFZblSHpy3+YLiwvAFb3C9IZ1ZC62SsOhD5x9L60a
        YyCanqMA/kha50MBgwqMGOX4Vw==
X-Google-Smtp-Source: AKy350bVCfYhTIWNldmosWbZXHjfLRyA7fmcWVOtAhNhbHkVOr9V9vo2zu0DDDs/zF9aTQKddnDfzA==
X-Received: by 2002:a2e:8496:0:b0:2a0:202c:93a7 with SMTP id b22-20020a2e8496000000b002a0202c93a7mr7000613ljh.14.1680161340777;
        Thu, 30 Mar 2023 00:29:00 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id 2-20020a05651c008200b00295b59fba40sm5768016ljq.25.2023.03.30.00.28.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Mar 2023 00:29:00 -0700 (PDT)
Message-ID: <9cd03cb0-0924-3431-8fe3-4d5f4a27b1a1@linaro.org>
Date:   Thu, 30 Mar 2023 09:28:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH tty-next 1/2] dt-bindings: serial: ni,ni16650: add
 bindings
Content-Language: en-US
To:     Brenda Streiff <brenda.streiff@ni.com>
Cc:     Gratian Crisan <gratian.crisan@ni.com>,
        Jason Smith <jason.smith@ni.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230329154235.615349-1-brenda.streiff@ni.com>
 <20230329154235.615349-2-brenda.streiff@ni.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230329154235.615349-2-brenda.streiff@ni.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 29/03/2023 17:42, Brenda Streiff wrote:
> Add bindings for the NI 16550 UART.
> 
> Signed-off-by: Brenda Streiff <brenda.streiff@ni.com>
> Cc: Gratian Crisan <gratian.crisan@ni.com>
> Cc: Jason Smith <jason.smith@ni.com>
> ---
>  .../bindings/serial/ni,ni16550.yaml           | 53 +++++++++++++++++++
>  1 file changed, 53 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/serial/ni,ni16550.yaml
> 
> diff --git a/Documentation/devicetree/bindings/serial/ni,ni16550.yaml b/Documentation/devicetree/bindings/serial/ni,ni16550.yaml
> new file mode 100644
> index 000000000000..4ac1c96726f8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/serial/ni,ni16550.yaml
> @@ -0,0 +1,53 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/serial/ni,ni16550.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NI 16550 asynchronous serial interface (UART)
> +
> +maintainers:
> +  - Brenda Streiff <brenda.streiff@ni.com>
> +
> +allOf:
> +  - $ref: serial.yaml#
> +
> +properties:
> +  compatible:
> +    items:

You have one item, so remove item.

> +      - enum:
> +          - ni,ni16550

As Rob pointed out - you did not test it at all.

> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clock-frequency: true
> +
> +  transceiver:

Missing description, type and maybe vendor prefix if this is not a
common property. Explain what's this.

> +    items:

Not a list.

> +      - enum:
> +          - RS-232
> +          - RS-485
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clock-frequency
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +      serial@80000000 {

Broken indentation.

Use 4 spaces for example indentation.

> +        compatible = "ni,ni16550", "ns16550a";
> +        reg = <0x80000000 0x8>;
> +        interrupts = <0 30 4>;
> +        clock-frequency = <58824000>;
> +        transceiver = "RS-485";
> +      };
> +
> +...

Best regards,
Krzysztof

