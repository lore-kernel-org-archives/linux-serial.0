Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2039DC433EF
	for <linux-serial@archiver.kernel.org>; Mon, 20 Jun 2022 08:23:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239814AbiFTIXx (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 20 Jun 2022 04:23:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239743AbiFTIXw (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 20 Jun 2022 04:23:52 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1953F59
        for <linux-serial@vger.kernel.org>; Mon, 20 Jun 2022 01:23:48 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id kq6so19521827ejb.11
        for <linux-serial@vger.kernel.org>; Mon, 20 Jun 2022 01:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=3Ros44lxzdc9H034iRq9XjLHdkZr6Zmv5Tm2gUHzb4k=;
        b=F85Durofj7HACsatoRDfeiLEib0a64WUvlROiLKAKCR23NLMEShsxw9VNc2reTh5B6
         nEn4sUrddK9p57eJkJ26U8cXd0w5NdmweBPdoopqjZbsTVRGQiudD2dcC36iMk2tVD81
         yl8EcvBRXwKvfnhlm/ofgKE4Jm0m4c54ZNdmwlTjxrw4+VQLs8hQlBL4T4COv8K7yJ1Z
         7Y/eQmFlnxlpM3hNHnKwpldLgxG2BQH+d2eSM0EhR3Rqd2QNnuFwIuDQp5/j4LWWCiM1
         nlu3ZFcIaiHq94YrBwbOcIc1BrdBeH1N17YfmPP5oJYEiTYLn54nPBLdg+BECWfqs0Bw
         OZYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=3Ros44lxzdc9H034iRq9XjLHdkZr6Zmv5Tm2gUHzb4k=;
        b=Shf4YgvlimG4xjEgDolxlBXghOMYAm+zNKahpO1zP/uU/0dZqsEUYZ8+5ojay9emfw
         7r/sjZQ1c1r3r1JWbSIAi/xbqirTbD7mjLDfIzb7qQ8imvqXXxFiefgtxY7hFpfOTopj
         H+EM0Tkj7lhwM+wA92h5YtDauDrrpQKipVG0OsCOSFvfsTutobhvbrIaO7GVgbOBwxUn
         3INY/p7gDdoXrsma/bCTlutUybDHKTFGwjsuwllGOCvs6ypKr9RDyHGjdDXBoPg3rHwI
         ptFHWto42pkv8TPqQEuMrcLAi0/ekg7E+iTZQA0tvrEkUjZhcsdWjnwnAhHLOOAv2aUP
         5jVQ==
X-Gm-Message-State: AJIora+jjqs/StlIyO2haL7lXYrvOrQPW2+O4UMO4dAlxakXu3/Flrq0
        09/tfsc0y9jhVOdf63Y0YR99mQ==
X-Google-Smtp-Source: AGRyM1vAjBf1TjIa/EZdSqh6SpnZpGgdVyfpMQp7XUD/Ztd8tGugtH+zYZB5r7Hj++TdtJOvMarXZw==
X-Received: by 2002:a17:906:778b:b0:712:e477:8f33 with SMTP id s11-20020a170906778b00b00712e4778f33mr19958626ejm.42.1655713427224;
        Mon, 20 Jun 2022 01:23:47 -0700 (PDT)
Received: from [192.168.0.207] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id n9-20020a170906840900b006fec56a80a8sm5452387ejx.115.2022.06.20.01.23.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jun 2022 01:23:46 -0700 (PDT)
Message-ID: <14fe8f15-e91f-45e0-39e2-7ae0d5f2ea64@linaro.org>
Date:   Mon, 20 Jun 2022 10:23:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3 10/18] dt-bindings: reset: npcm: Add support for
 NPCM8XX
Content-Language: en-US
To:     Tomer Maimon <tmaimon77@gmail.com>, avifishman70@gmail.com,
        tali.perry1@gmail.com, joel@jms.id.au, venture@google.com,
        yuenn@google.com, benjaminfair@google.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, p.zabel@pengutronix.de,
        gregkh@linuxfoundation.org, daniel.lezcano@linaro.org,
        tglx@linutronix.de, wim@linux-watchdog.org, linux@roeck-us.net,
        catalin.marinas@arm.com, will@kernel.org, arnd@arndb.de,
        olof@lixom.net, jirislaby@kernel.org, shawnguo@kernel.org,
        bjorn.andersson@linaro.org, geert+renesas@glider.be,
        marcel.ziswiler@toradex.com, vkoul@kernel.org,
        biju.das.jz@bp.renesas.com, nobuhiro1.iwamatsu@toshiba.co.jp,
        robert.hancock@calian.com, j.neuschaefer@gmx.net, lkundrak@v3.sk
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20220619151225.209029-1-tmaimon77@gmail.com>
 <20220619151225.209029-11-tmaimon77@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220619151225.209029-11-tmaimon77@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 19/06/2022 17:12, Tomer Maimon wrote:
> Add binding document and device tree binding constants for Nuvoton BMC
> NPCM8XX reset controller.
> 
> Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
