Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EFB8C54EAA
	for <linux-serial@archiver.kernel.org>; Tue, 24 Jan 2023 07:25:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232459AbjAXHZM (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 24 Jan 2023 02:25:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231538AbjAXHZL (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 24 Jan 2023 02:25:11 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 628EF126EA
        for <linux-serial@vger.kernel.org>; Mon, 23 Jan 2023 23:25:10 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id iv8-20020a05600c548800b003db04a0a46bso590910wmb.0
        for <linux-serial@vger.kernel.org>; Mon, 23 Jan 2023 23:25:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tf2jkhDB/fcmN7gxB9BcFTlLK/uYEMsrGqgyWUEbIpY=;
        b=Ey5ePlReG/n9vBilW4cfQNWTL/l/rns4G9TU3NjLnRqHlJJzRriYkfBLv5xkOYvf6k
         tNxSvygXO6JmhBMATZP+4RWAM/qYoK+q58K2fGxlVf3UbxlZmZosyZyB7cVttv347tmV
         ToZmZNkSArgBvXSky7SGWU5otTh8k17jeKQ6Uh0BaB+2hypaWFk51+cw5M9c8zLR4S3R
         rbDfCUXeYIQrU4d9Pt7pOiZaZYPBWWhjidrvFXtsrwVzlgWlckyPuyElevm1lIgZxXFd
         Sh35CcPBTdxpyV6N59BG7Xin73RUoxjOaqsLKKctlriqnkR8ys0RBffv86iFWpPani9v
         EefQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tf2jkhDB/fcmN7gxB9BcFTlLK/uYEMsrGqgyWUEbIpY=;
        b=LdXl3nV79xeakgjyOxCokriFFogYkSYCVoUARPCGIjHs5YpjrwxAGxtl0gc/09tRZc
         lKlhwhCULtKkAfLSFof9Ax8enAHBfBJKzeQbJh+820JyLzJDQ3u0zq7s5TUzIzs2kgm+
         Jw+/qFfZrhRd5MqSWq6gFHl7a92HZzYcSnQ81+ze7fFZxsS+mBl35IFYMRuGq2wAqmgu
         WcQC56esbXtBtB1cp4F82VnWPPGunFUEY4nYsW4HMzb+0loBe21ADjDgY5AYDxOYMMOn
         64KEx40GIBb2ZN8S2mBGBx3CloQOUMb3222qpMpctonHgan3SVumLJyAAtq8jjkA3unO
         kj2w==
X-Gm-Message-State: AFqh2kqbN6wFamCG36uDQ9YGV/bZfTRCcCm2/HdW8NKVb0+l/WUYoSww
        wyMENMYgo3hAuPt131HVTg9AOF5h/BcZEO8R
X-Google-Smtp-Source: AMrXdXvH5bGz6Fl5hSlEDfijg+poG9+NkFL619URN+WkIB9aNvhttf/yW+RHKBUEvSvYNh4NNDJZuw==
X-Received: by 2002:a05:600c:5386:b0:3cf:9844:7b11 with SMTP id hg6-20020a05600c538600b003cf98447b11mr27831353wmb.23.1674545108902;
        Mon, 23 Jan 2023 23:25:08 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id o25-20020a1c7519000000b003daf6e3bc2fsm1216707wmc.1.2023.01.23.23.25.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jan 2023 23:25:08 -0800 (PST)
Message-ID: <e0dd24e8-9d4b-ea23-d1de-190330c0e825@linaro.org>
Date:   Tue, 24 Jan 2023 08:25:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH 11/13] dt-bindings: serial: restrict possible child node
 names
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, - <devicetree@vger.kernel.org>,
        linux-riscv@lists.infradead.org,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Peter Korsgaard <jacmet@sunsite.dk>,
        Chester Lin <clin@suse.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        Kevin Hilman <khilman@baylibre.com>,
        linux-kernel@vger.kernel.org, Fugang Duan <fugang.duan@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Fabio Estevam <festevam@gmail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Le Ray <erwan.leray@foss.st.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Pragnesh Patel <pragnesh.patel@sifive.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-amlogic@lists.infradead.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-arm-kernel@lists.infradead.org
References: <20230123151302.368277-1-krzysztof.kozlowski@linaro.org>
 <20230123151302.368277-11-krzysztof.kozlowski@linaro.org>
 <167451486467.2795286.1299932821783618559.robh@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <167451486467.2795286.1299932821783618559.robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 24/01/2023 00:05, Rob Herring wrote:
> 
> On Mon, 23 Jan 2023 16:13:00 +0100, Krzysztof Kozlowski wrote:
>> The re-usable serial.yaml schema matches every property with ".*"
>> pattern, thus any other schema referencing it will not report unknown
>> (unevaluated) properties.  This hides several wrong properties.  It is
>> a limitation of dtschema, thus provide a simple workaround: expect
>> children to be only of few names matching upstream usage (Bluetooth,
>> GNSS, GPS and MCU).
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
>>  Documentation/devicetree/bindings/serial/serial.yaml | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/bus/intel,ixp4xx-expansion-bus-controller.example.dtb: serial@1,0: Unevaluated properties are not allowed ('intel,ixp4xx-eb-byte-access', 'intel,ixp4xx-eb-cycle-type', 'intel,ixp4xx-eb-t3', 'intel,ixp4xx-eb-write-enable' were unexpected)
> 	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/serial/8250.yaml

Did I just forgot to test all the bindings (except the changed ones)? It
seems so, therefoer note to myself:

Please run `make dt_binding_check` (see
Documentation/devicetree/bindings/writing-schema.rst for instructions). :)

Best regards,
Krzysztof

