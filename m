Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C1D8EB64DC
	for <linux-serial@archiver.kernel.org>; Sun, 25 Jun 2023 10:13:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231552AbjFYKNx (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 25 Jun 2023 06:13:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231429AbjFYKNv (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 25 Jun 2023 06:13:51 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DF601B7
        for <linux-serial@vger.kernel.org>; Sun, 25 Jun 2023 03:13:50 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-98bcc533490so266062266b.0
        for <linux-serial@vger.kernel.org>; Sun, 25 Jun 2023 03:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687688029; x=1690280029;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=syq8wmqi5sxbhlG4LN2N7LL4Y7J7QS2HpSjUCteE4Go=;
        b=cj3kWNllURT0OTH7YF0bMiyfeZtq66AVLq2miBl6vvw6h4OEYAlcRcVTlbWXgAPAXv
         0C8xmW1ClUaBTaP0AfCgGu6A6ObdzuJucwt/nedD8JngLILtbQ9RUTYj9SaaPzvDK7rU
         ozv7fVHFxeQGEFfT97L6uZd3JlrNjL/uUDvmbHbOd8dp7Hq9iJy/0qraVRXrISitKmao
         FxhFF8Qx7JMCJH/3KFZBm6aoTunGqtEScQ3v1/WxYJ37RL1svytm5okfJTTkkatO5zPT
         zSqOShQlndDpr4v5ETkxX5BX97gCeAI8TNDw0LKj01WGkhSD+4xcgaFpO4Gtdo2koskg
         vSHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687688029; x=1690280029;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=syq8wmqi5sxbhlG4LN2N7LL4Y7J7QS2HpSjUCteE4Go=;
        b=k/x31OBWQ5tW4T9kq+vAVDFnm9ZC2P8x8MsJmlJA3oFqOJKtiBTb/6jv3H/qK+hb+e
         nrPrt2gesu09VCYr23PEeqBUY5lJ7AFuNmLd3r8EtotUBnwwOyPoVHfzIr73onP38XEZ
         GCEIuKY33AJ03U/LxUigjr+wxdn+xdvn+/hnNGk8Djal0LSBy3Syt3DOJO/0BV5OHDU/
         rN3nT1mpjaPiZv7M1+aXmQR6rxEyZUKGK0HA1hJ+ejaBM1oTpouWoQdtOEgDBzFCZqPS
         RZ0w9POw6kEJLyf9aYREDosw7E9bKMXW9COaTDYdxF5qXxOjKvJj3vDiUVoMHJRWNFRa
         4+jg==
X-Gm-Message-State: AC+VfDxonB3dJsK6yCqeZ88jPueL3c4Ui5Ko9ZMs8DCuV8mAZMcr72sx
        KXAwXwqoXtE+fMhWiSSi4ROpMg==
X-Google-Smtp-Source: ACHHUZ6ue7nK+iXT+Gmb02ASDhOsmXu9P1FKk9ZoHujhTYqVKduxYzP5wOr0r58/UwUeL3oIS/UWxA==
X-Received: by 2002:a17:907:6095:b0:989:1cc5:24a with SMTP id ht21-20020a170907609500b009891cc5024amr14860344ejc.13.1687688028779;
        Sun, 25 Jun 2023 03:13:48 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id u12-20020a170906068c00b0098856d1470csm1903726ejb.75.2023.06.25.03.13.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Jun 2023 03:13:47 -0700 (PDT)
Message-ID: <41d0313b-f791-b274-d5a2-fd40b4be0fea@linaro.org>
Date:   Sun, 25 Jun 2023 12:13:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 2/4] arm64: dts: imx8ulp: remove "fsl,imx7ulp-lpuart"
 compatible for i.MX8ULP
Content-Language: en-US
To:     Sherry Sun <sherry.sun@nxp.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com,
        shenwei.wang@nxp.com, gregkh@linuxfoundation.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com
References: <20230625094857.29644-1-sherry.sun@nxp.com>
 <20230625094857.29644-3-sherry.sun@nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230625094857.29644-3-sherry.sun@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 25/06/2023 11:48, Sherry Sun wrote:
> i.MX8ULP has specific "fsl,imx8ulp-lpuart" compatible in lpuart driver,
> "fsl,imx7ulp-lpuart" compatible is no longer needed, and i.MX8ULP is not
> fully compatible with i.MX7ULP, for example, i.MX8ulp can support
> EOP(end-of-packet) function while i.MX7ulp doesn't, so remove
> "fsl,imx7ulp-lpuart" compatible.

That's not how compatibility works. Your commit msg says that new device
comes with new features, but your code says they are incompatible. These
are two different things.

Either drop the patch or provide correct rationale.

Best regards,
Krzysztof

