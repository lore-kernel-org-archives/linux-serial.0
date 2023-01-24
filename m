Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A293FC38142
	for <linux-serial@archiver.kernel.org>; Tue, 24 Jan 2023 09:05:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233348AbjAXJFg (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 24 Jan 2023 04:05:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232654AbjAXJFe (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 24 Jan 2023 04:05:34 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ADF73F29A
        for <linux-serial@vger.kernel.org>; Tue, 24 Jan 2023 01:05:32 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id y1so8674028wru.2
        for <linux-serial@vger.kernel.org>; Tue, 24 Jan 2023 01:05:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wh9YPwUFmU9TlXE8h6aarMlvLtrqOnroY8ktmkM9cF4=;
        b=NZLu/mXW/jR7P3J17bOgR6qP2EvV8pBIAs2EK+EY8boNhE8FtlYTBwgw1o4LP0Ou5l
         7o9Ot2ODWivHgzBSAJ0IBV+AjHzdb/yukmzpiuClYyjEROnI3ViQRRGAxEgPg+Aa8riC
         /AEH2/T5wFH6p7d08431R59fEPkQPu0yfIC+5VFqCfp1HoGp3Pzsb2O0R+lJCpAhsUGS
         dxOGk6V7Uo+G3wxAFhgDfzHRNuEFmH3+71rHT0oNwPvn/PfJj4WULB6tuCfythudkkAk
         Iq3YSBNJYb0c/jvBZfE4g6qZiRcRY90ZDBvI2s9Iu4kIZb8WiN9rzzTZchvcSyXjzL9p
         p4UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wh9YPwUFmU9TlXE8h6aarMlvLtrqOnroY8ktmkM9cF4=;
        b=SH2vwpR2G++ZF5zMzx4CBcTPC/yUzNL0oMKJasQvHA5gwvqCv7oT2Q0tI/fBaLCAwC
         51cxuWeccS811vQw2J+8k33+bs79oXkKqoFuC2wU9tqcTa2grLXujwUDnVf2Ldhhg/a7
         V97DOdgRLyhoGqLeXHAavorzCV0ifyQ0qSrXPxzLF7Gj+RNsKNevegun2Pn5H+hhWPAi
         N9tW4Z68xu8XBE8jWsa2b0Gpr2tReUaYmiLvRqil+YTpERQXE/YpMWcl1wTr1lEYoDnr
         hKEk2nF1jgMcbsTNyszQ3OOw+gsDSNhJLWz+0ML8zzemGUCtfWpyUjaJsguWQfx+Qqb/
         buCw==
X-Gm-Message-State: AFqh2kp31c8+rUm+uJx//sFx9EeJD7m82SrtuXzS7cb9+MQ5j489IJQ5
        RNLIFVEYOrc09YK7MP8qazkhkQ==
X-Google-Smtp-Source: AMrXdXukUC6LKF0R6+9iNiS48zc+9/Y6jhzP7MWyQ85ZuTQuZfZ3Y1McusWuaT27kf+OhuNHIrxGtQ==
X-Received: by 2002:a5d:6b05:0:b0:2bd:cf99:e6ab with SMTP id v5-20020a5d6b05000000b002bdcf99e6abmr22075514wrw.65.1674551131018;
        Tue, 24 Jan 2023 01:05:31 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id l4-20020adfa384000000b00241fab5a296sm1365052wrb.40.2023.01.24.01.05.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jan 2023 01:05:30 -0800 (PST)
Message-ID: <71fd9674-63a7-9887-d602-1f57ae3982aa@linaro.org>
Date:   Tue, 24 Jan 2023 10:05:27 +0100
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

Eh, this is not trivial to solve. The
"intel,ixp4xx-expansion-bus-controller.yaml" bindings add properties to
children nodes, just like spi-peripheral-props:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/bus/intel,ixp4xx-expansion-bus-controller.yaml?h=v6.2-rc5#n147

Any node can be there:
1. serial, which was broken since beginning but errors not visible,
2. flash, which work fine just because mtd-physmap.yaml allows it,
3. more?

Existing DTS of this ixp4xx controller have different nodes, for example:
flash, shared-dma-pool, ns8250, arcom,vulcan-gpio, maxim,max6369:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm/boot/dts/intel-ixp42x-arcom-vulcan.dts?h=v6.2-rc5#n40

Probably we need expansion-bus-controller-peripheral-props.yaml and
include it in every possible child. Does it sound reasonable?

Best regards,
Krzysztof

