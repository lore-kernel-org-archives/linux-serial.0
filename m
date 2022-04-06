Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA357C4332F
	for <linux-serial@archiver.kernel.org>; Wed,  6 Apr 2022 19:52:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233408AbiDFTyl (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 6 Apr 2022 15:54:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236809AbiDFTyB (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 6 Apr 2022 15:54:01 -0400
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF7E525FD67;
        Wed,  6 Apr 2022 11:09:21 -0700 (PDT)
Received: by mail-oi1-f175.google.com with SMTP id 12so3199905oix.12;
        Wed, 06 Apr 2022 11:09:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZCv5Z3on9AQtD9yYpps2anAChZwta6wJ94nkSs1cqXY=;
        b=6tNtHGh0XXL8x91EXpnuaSzYGH9VGigyzFELNLpty8TqaiFTb/tHiCrFovm9SOOx0K
         lf/DjaHJj53h8NPHPmgIPg1LXFzn3K/XseX2+THdsgGCYz/nV1RPe6kkNKp56p4Qat6B
         7RjnAV1vveiMf8X/tFq19ecLk+jQkBAIibvMhjY/BSZWHhEY7oYShGORWTA9x8gkg3fI
         VfxuRqOSv3Fg96Zd5AInCi9rZ/VKVYQmV5HPp1bQV35I8e3j8V6Dl/n0AnjJpaEXmsIb
         5XRThCMu6Ebf2VcaO9Y/Dkh324u4Txfu05Is/rD6WjltXeXtkbPlqh8teGBaE2dchaVr
         8CKQ==
X-Gm-Message-State: AOAM530RRf13ASe9KLMLnr4NysFOXFkjV+FuyBTh2aWTwG7I8FGT3xFs
        SAw0JbD3LaDcoqKwkV1NKA==
X-Google-Smtp-Source: ABdhPJx5Gu4gGUEd9ZN30X4nIljJqIliTezdh62bKAP3TJPDFaPvtdOjU2y3V053IinzgSoWLXyQDg==
X-Received: by 2002:a05:6808:4d4:b0:2ec:f4e0:2b84 with SMTP id a20-20020a05680804d400b002ecf4e02b84mr4008798oie.153.1649268560875;
        Wed, 06 Apr 2022 11:09:20 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id o19-20020a4a9593000000b0032176119e65sm6454944ooi.34.2022.04.06.11.09.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 11:09:20 -0700 (PDT)
Received: (nullmailer pid 2516021 invoked by uid 1000);
        Wed, 06 Apr 2022 18:09:19 -0000
Date:   Wed, 6 Apr 2022 13:09:19 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Kuldeep Singh <singh.kuldeep87k@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-serial@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: Re: [PATCH v4 7/9] dt-bindings: serial: qcom,msm-uartdm: convert to
 dtschema
Message-ID: <Yk3XT0n2l75Is4dq@robh.at.kernel.org>
References: <20220405063451.12011-1-krzysztof.kozlowski@linaro.org>
 <20220405063451.12011-8-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220405063451.12011-8-krzysztof.kozlowski@linaro.org>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, 05 Apr 2022 08:34:49 +0200, Krzysztof Kozlowski wrote:
> Convert the Qualcomm MSM Serial UARTDM bindings to DT Schema.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/serial/qcom,msm-uartdm.txt       |  81 -------------
>  .../bindings/serial/qcom,msm-uartdm.yaml      | 112 ++++++++++++++++++
>  2 files changed, 112 insertions(+), 81 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/serial/qcom,msm-uartdm.txt
>  create mode 100644 Documentation/devicetree/bindings/serial/qcom,msm-uartdm.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
