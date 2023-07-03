Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C259DEB64DC
	for <linux-serial@archiver.kernel.org>; Mon,  3 Jul 2023 13:59:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230007AbjGCN70 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 3 Jul 2023 09:59:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjGCN7X (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 3 Jul 2023 09:59:23 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C243E5C
        for <linux-serial@vger.kernel.org>; Mon,  3 Jul 2023 06:59:22 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-991f956fb5aso422323566b.0
        for <linux-serial@vger.kernel.org>; Mon, 03 Jul 2023 06:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688392760; x=1690984760;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X80ysD/F6wvgJKG8ztSCHOsfQgFC0oL2m6OimzpJAHE=;
        b=xTlawRSml3QjxxqYZhVn+T6lwHkX+LmDoaoGwDF4hdysxEQOSi8mjnnsbImPtglyjv
         +ueYNV2paUwXBQ/3g83aN6gYENvfk733tRTvOo0wmNGy7lqUwIRKTvCmRzjxq0In0lW2
         yaNlNGu2TD8uPiYRncw7dSXirI/BcZc/aIq81+eCdTP1Ve5oz30koqDmcvX1NnpVJ2z2
         FD50Py6puVy3JN6WomELAUvSb4oGicviRNggW+lOCIV8fWgQWZIZJ3SL2vKYR8GzAE0o
         aguWBV3nO+LXRycWErSpsSmQXimW/FUnKhiBQIJ4G5w+FRI1cS5L1stPC3bdnhFdlE3n
         GaVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688392760; x=1690984760;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X80ysD/F6wvgJKG8ztSCHOsfQgFC0oL2m6OimzpJAHE=;
        b=VqL25ZWVy4DGIPoL0Ecnp/mhWUNpI+EDUNDKpEAqACfUfznGYJI4uY7VN+ubfWrQCK
         IYdb+VC0EKmTtNsahRP6s95C1JckLy0sVjGVBYo74nrU5dmFVYs38CP5WBE/gCSBwf3v
         9L8RItmBsQIAD6YxE2LV/bXAnKhYg76r+pI5lXbQ4JUFeOYR4OWzVgM3S4rFJLKgyTq5
         D0JC7Ja6YMuT7NbRuK1BjeLHmdTMZ6qa49ZS7OfUMsVnr3rHlQXmU1oM2dK6cLBs7TVk
         qqWoeJtN37LoIc87rWzbN7Q0udKHiGtF5zhqHHrCZ2DuwQ6X4tF0Oq/L08VRCX6330nE
         9LdQ==
X-Gm-Message-State: ABy/qLaIXK+UVimT+cEKWTcdtM7WNUVZ3c8hajTkc1NKxcfwj+OGLjg4
        fFTOKRhWTU6sp+e1nhxfMm2ZDg==
X-Google-Smtp-Source: APBJJlHWOpmp0L5iU4aJ3V1Luyx61WADzk04WlLGpK/8sKUeSlzfLcnuvKA4rHqVN4V/eGDHm6iOWQ==
X-Received: by 2002:a17:907:76ab:b0:992:d013:1132 with SMTP id jw11-20020a17090776ab00b00992d0131132mr5768360ejc.1.1688392760602;
        Mon, 03 Jul 2023 06:59:20 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id p11-20020a1709060e8b00b00993159ce075sm3726148ejf.210.2023.07.03.06.59.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jul 2023 06:59:20 -0700 (PDT)
Message-ID: <14253982-da00-ceaa-4fe9-c2561258b014@linaro.org>
Date:   Mon, 3 Jul 2023 15:59:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 1/5] dt-bindings: spi: spi-geni-qcom: Allow no qup-core
 icc path
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andi Shyti <andi.shyti@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-i2c@vger.kernel.org
References: <20230703-topic-8250_qup_icc-v1-0-fea39aa07525@linaro.org>
 <20230703-topic-8250_qup_icc-v1-1-fea39aa07525@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230703-topic-8250_qup_icc-v1-1-fea39aa07525@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 03/07/2023 15:31, Konrad Dybcio wrote:
> Some SoCs (like SM8150 and SM8250) don't seem to provide a qup-core path.
> Allow such case.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  .../devicetree/bindings/spi/qcom,spi-geni-qcom.yaml       | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

