Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61C8FC6FA82
	for <linux-serial@archiver.kernel.org>; Thu,  8 Sep 2022 12:24:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231767AbiIHMYC (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 8 Sep 2022 08:24:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231772AbiIHMXv (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 8 Sep 2022 08:23:51 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A16B21228CD
        for <linux-serial@vger.kernel.org>; Thu,  8 Sep 2022 05:23:39 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id v6so6281562ljj.0
        for <linux-serial@vger.kernel.org>; Thu, 08 Sep 2022 05:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=lW3x8eMs+QDq4pmRmlvesMk544yrqFctPvdud3q1Yz4=;
        b=CkYzETGDsCABu3zsO3QW53/WMjWRnAk2n2cw87OBtjEJciu9giPSAXdMzemT/KvzhY
         7rNimHGKSlgaTSggRJzN0P1iDIjtFwChqFsUlh6XhZPVVJ2Lr3MOZFlq9nFKEgfLr2hg
         Ufgo25AJyOPpSksY8L+eaKgdHGkuTu6a80KBeoFOmfRSaWHQFM6hiHjJ45p0a4z1F40n
         7QXAYYqQ2cGilSz5IlBJJ8fUU/3SRSivJbsRvw14rrrtb8hT50bKN/1e/s3Dcz4g4QIR
         ZiayeWmK0jrOfzbUQ1b5877p2aCQb/GZbVcvyNk1Xd1EyFrHjm00FzB7vecpIUI2WGk5
         dYBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=lW3x8eMs+QDq4pmRmlvesMk544yrqFctPvdud3q1Yz4=;
        b=k/mZRu3D4NIbzsg9lNDWiSRzDmgKplqKsfR9o2IkgVO79vgpyfu7EhShasDjQCXtou
         iIFqXSpzfe8MLYUQsQ5VBbCasAK5CDjsa8xrfkP83Wt+y36Q/zV+hJI/Ml0XyObjz65Q
         COYAFBp+GRLK6vZLziTNo/WpumSWFxKzH2spfx0uFUsZ1ae/Lkoh6BWHurja3LE89sBI
         DZKDKDh4yEddZ+Apjo0LPcEGnrtKopET/1o2y4O3NK84Vn5E5A6Or0Sp91JPWQ0d5OwI
         fnjn3qRyhoKS0O8HVHjyX4n/6/ywjGQKGKEoIOGKeBIlOQZhy8DaajiGy49wq43HXZ1j
         sNRw==
X-Gm-Message-State: ACgBeo1fW4hmJBuu5MgFKcJCDr0XQdjLlHJ8l3yn6bNYNIVCk2N0IoyW
        VNLg29FCcEr/62dJcDBwwpg9Pg==
X-Google-Smtp-Source: AA6agR7p8K6nBFSlkCpNMVWclPQeCBtyk0lt7btEAXszHKHxjgDr2b7rT8hGCJ1Qq4HE7qhGJO3Bng==
X-Received: by 2002:a2e:bc06:0:b0:266:23b7:283d with SMTP id b6-20020a2ebc06000000b0026623b7283dmr2572196ljf.151.1662639818048;
        Thu, 08 Sep 2022 05:23:38 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id m2-20020a056512358200b004947c4dfde8sm3018216lfr.129.2022.09.08.05.23.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Sep 2022 05:23:37 -0700 (PDT)
Message-ID: <71847bea-f84d-c2ba-fce4-612c179a9d2f@linaro.org>
Date:   Thu, 8 Sep 2022 14:23:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v2 03/13] dt-bindings: mfd: atmel,sama5d2-flexcom: Add SPI
 child node ref binding
Content-Language: en-US
To:     Sergiu Moga <sergiu.moga@microchip.com>, lee@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        claudiu.beznea@microchip.com, richard.genoud@gmail.com,
        radu_nicolae.pirea@upb.ro, gregkh@linuxfoundation.org,
        broonie@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        jirislaby@kernel.org, admin@hifiphile.com,
        kavyasree.kotagiri@microchip.com, tudor.ambarus@microchip.com
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-clk@vger.kernel.org
References: <20220906135511.144725-1-sergiu.moga@microchip.com>
 <20220906135511.144725-4-sergiu.moga@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220906135511.144725-4-sergiu.moga@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 06/09/2022 15:55, Sergiu Moga wrote:
> Another functionality of FLEXCOM is that of SPI. In order for
> the proper validation of the SPI children nodes through the binding
> to occur, the proper binding for SPI must be referenced.
> 
> Signed-off-by: Sergiu Moga <sergiu.moga@microchip.com>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
