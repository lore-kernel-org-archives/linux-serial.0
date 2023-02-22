Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9508BC6379F
	for <linux-serial@archiver.kernel.org>; Wed, 22 Feb 2023 08:44:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbjBVIo4 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 22 Feb 2023 03:44:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230280AbjBVIoz (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 22 Feb 2023 03:44:55 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3919311CE
        for <linux-serial@vger.kernel.org>; Wed, 22 Feb 2023 00:44:53 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id l1so6643398wry.10
        for <linux-serial@vger.kernel.org>; Wed, 22 Feb 2023 00:44:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ja0PIExg7QtVH8CkMZQt+gow5bQ/IjTXAb1rvOQO5SE=;
        b=n3aTRm08QWqkCXP6vWRdaQXRkdjlZsw1/FZSbNhF5J2z38ZrYuFSqUuDpdsxR6Rl9U
         4ln0hp9gHLzfu91SseG8N2Fmmmdd0uoRNqJl8LrmS2mYCSGPUvdqjwL/Un1kbTjwYUdQ
         ckCovcEjCdsmNVQVuB23xCWDuQASxGOCB9x2KFWxyEvqxOOmnyRMzuPoigQJ/bCBbycD
         7o30YI4FgReuJWZuSjZImRX2Pb+DYHPg2ENcUAd5nuEAgz72e3jtG1/5wIZrqiNmzaTO
         LULu8Ai4TeFabQ+clEZqlOhMdlsh+5rzg+uu95PBNi5J8p5ad/1pG2JhIDSv/E0V4ChW
         q0mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ja0PIExg7QtVH8CkMZQt+gow5bQ/IjTXAb1rvOQO5SE=;
        b=Mf/8RGn7Hu2Ls0rrOv7NPujnbEMxDhqS+O4GNSByJy1AZmlwPCQxEbf20vxeajhNdX
         y+7yKPIm+l9PVdvjw0+7saNMlqZA7FsiAvZNP+Hcrs3WNVegG1x8Zw1GThidxWr3qIiF
         0JrRBhX3+CJhhnECmmpsILVSYqMjG6/0saJhMr0UnByG1+14caiXqwb5TwIDzOf/Dkcr
         a6/6g2jNwjqQvmW29kLKOO7V85qxAAERfNjX70pNnwkpM4QXJyUX2he5naXrovc9KMHh
         A9pYhUD1mmIZr10Vf2UuKnVaztRfXVynagr0ZhbU85ejuKHgrGstjcC3ZNZCGCT503/i
         sUtA==
X-Gm-Message-State: AO0yUKW60wJYBGz2OAmTwJ87zoE7ctF84CqLY0X0HFe/g5Ewu36aMZni
        Sz2f06T4H6ovIVFiFyHdXu0wtQ==
X-Google-Smtp-Source: AK7set/INtiIeiEqLq31GfS7NEouC9iSfOFGLmINDVsTxUJtiLClf3hIlMhSpnkMFZiPKAEgx/xM/w==
X-Received: by 2002:adf:fe07:0:b0:2c3:f0ed:4beb with SMTP id n7-20020adffe07000000b002c3f0ed4bebmr4635634wrr.70.1677055492115;
        Wed, 22 Feb 2023 00:44:52 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id a5-20020a05600c224500b003dc1a525f22sm4428625wmm.25.2023.02.22.00.44.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Feb 2023 00:44:51 -0800 (PST)
Message-ID: <ef019382-61a8-c663-773b-21791413889d@linaro.org>
Date:   Wed, 22 Feb 2023 09:44:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v4 2/3] dt-bindings: net: bluetooth: Add NXP bluetooth
 support
Content-Language: en-US
To:     Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, marcel@holtmann.org,
        johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        alok.a.tiwari@oracle.com, hdanton@sina.com,
        ilpo.jarvinen@linux.intel.com, leon@kernel.org
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-serial@vger.kernel.org, amitkumar.karwar@nxp.com,
        rohit.fule@nxp.com, sherry.sun@nxp.com
References: <20230221162541.3039992-1-neeraj.sanjaykale@nxp.com>
 <20230221162541.3039992-3-neeraj.sanjaykale@nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230221162541.3039992-3-neeraj.sanjaykale@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 21/02/2023 17:25, Neeraj Sanjay Kale wrote:
> Add binding document for NXP bluetooth chipsets attached over UART.
> 
> Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
> ---
> v2: Resolved dt_binding_check errors. (Rob Herring)
> v2: Modified description, added specific compatibility devices, corrected indentations. (Krzysztof Kozlowski)
> v3: Modified description, renamed file (Krzysztof Kozlowski)
> v4: Resolved dt_binding_check errors, corrected indentation. (Rob
> Herring, Krzysztof Kozlowski)
> ---
>  .../bindings/net/bluetooth/nxp,w8987-bt.yaml  | 38 +++++++++++++++++++
>  MAINTAINERS                                   |  6 +++
>  2 files changed, 44 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/bluetooth/nxp,w8987-bt.yaml
> 
> diff --git a/Documentation/devicetree/bindings/net/bluetooth/nxp,w8987-bt.yaml b/Documentation/devicetree/bindings/net/bluetooth/nxp,w8987-bt.yaml
> new file mode 100644
> index 000000000000..de361ce4ab73
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/bluetooth/nxp,w8987-bt.yaml
> @@ -0,0 +1,38 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/bluetooth/nxp,w8987-bt.yaml#

I think list of compatibles changed... now they are nxp,88w8987-bt, so
shouldn't the filename be "nxp,88w8987-bt.yaml"?

> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NXP Bluetooth chips
> +
> +description:
> +  This binding describes UART-attached NXP bluetooth chips.
> +  These chips are dual-radio chips supporting WiFi and Bluetooth.
> +  The bluetooth works on standard H4 protocol over 4-wire UART.
> +  The RTS and CTS lines are used during FW download.
> +  To enable power save mode, the host asserts break signal
> +  over UART-TX line to put the chip into power save state.
> +  De-asserting break wakes-up the BT chip.
> +
> +maintainers:
> +  - Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - nxp,88w8987-bt
> +      - nxp,88w8997-bt
> +
> +required:
> +  - compatible
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    uart2 {

This is a friendly reminder during the review process.

It seems my previous comments were not fully addressed. Maybe my
feedback got lost between the quotes, maybe you just forgot to apply it.
Please go back to the previous discussion and either implement all
requested changes or keep discussing them.

Thank you.

Best regards,
Krzysztof

