Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93211C001B0
	for <linux-serial@archiver.kernel.org>; Thu, 13 Jul 2023 10:43:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234141AbjGMKnP (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 13 Jul 2023 06:43:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234147AbjGMKnO (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 13 Jul 2023 06:43:14 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17235268D
        for <linux-serial@vger.kernel.org>; Thu, 13 Jul 2023 03:43:13 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-3094910b150so683682f8f.0
        for <linux-serial@vger.kernel.org>; Thu, 13 Jul 2023 03:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689244991; x=1691836991;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vjSQrGgpifABN2+Tqa28IPOmkn8g3hXtcUjb3gjMzpE=;
        b=g5GkO/ls/kYH9vWlBFZrSm+lN6F5ll50WGXLMxcUf0uESccn6r+sqGeZZZkcCF4762
         0vk6djImGyZBdB4RhUsWdpRXzOQAAytOD+W+bOm3VElr/zv9KecSNq0SUBWcornzKG70
         suRx4XdHuPMnELtb2s2VSYkrL5bnRzMQh9NpOpiOy9Lwi8qsaOIpOnYyf/YLTEf0lBY3
         +PNiys4Oqs+Y3tYuRwccE+3b3zoipoaWVQi75OP1EnihbQRfn4vNDBjEJaMRyFp5O3OG
         YebU/exORsqOI70tHQmpBbebBsMI0t+WfOq4dn4V09XuTtc4ebWGFDG10cXbDYPPgYYn
         bvqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689244991; x=1691836991;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vjSQrGgpifABN2+Tqa28IPOmkn8g3hXtcUjb3gjMzpE=;
        b=dO82SuQEASnCm61+9py7FwcWkQb9icoVDfEFB0/X3rlhNN5rMUvM1HTXzDcGfaI3Ne
         narMx4jCx0ut7aB8Hlbr6otWLUQYPoihCA/07Rci7+rL9xFjkY0i0qWLhdeFSdkJmJXX
         ImaYG4pzUt3bzkflIS9q1TTO/Jlf73gULWoBDnL7rlZL5Aouwk9wS8VSXAH++ESHwNOW
         BQ+3wCMlAv5TpWvvRkfwpWip0V6+zZVk2qNn3A+2d9xCXlLFg2NVfRKCMWOf6iT1l8RI
         Sgl+yjGvDGUsmFzcoS/HoqdA7kmWwK3nYn+NOmXmoIPlScmUnxtW4qd31WZD9CFk25N7
         g2Aw==
X-Gm-Message-State: ABy/qLZXOh/6PMj2nzhcyLwi57xPLflgSH+KwAI85KIwwGKs2oaOkl7a
        HeJU5+OXShOlw7UAfwmwXxrHyw==
X-Google-Smtp-Source: APBJJlEPziON1PD3aE57V4CJY4W5KzhUlKzeMzf4BNM8sBOOvTnEwKfgIq9PPdsa/SEsivNw3tYFFw==
X-Received: by 2002:a05:6000:11c3:b0:313:f29f:5eb3 with SMTP id i3-20020a05600011c300b00313f29f5eb3mr1206111wrx.32.1689244991501;
        Thu, 13 Jul 2023 03:43:11 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id k3-20020a5d66c3000000b00314398e4dd4sm7562311wrw.54.2023.07.13.03.43.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jul 2023 03:43:10 -0700 (PDT)
Message-ID: <4fdc7ee1-e612-9be2-55b7-bb8ee9cdb161@linaro.org>
Date:   Thu, 13 Jul 2023 12:43:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCHv2 2/2] ARM: dts: at91: sam9x60: fix the SOC detection
Content-Language: en-US
To:     Durai.ManickamKR@microchip.com, Hari.PrasathGE@microchip.com,
        Balamanikandan.Gunasundar@microchip.com,
        Manikandan.M@microchip.com, Varshini.Rajendran@microchip.com,
        Dharma.B@microchip.com, Nayabbasha.Sayed@microchip.com,
        Balakrishnan.S@microchip.com, Cristian.Birsan@microchip.com,
        Nicolas.Ferre@microchip.com, alexandre.belloni@bootlin.com,
        davem@davemloft.net, arnd@arndb.de, olof@lixom.net, soc@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Kavyasree.Kotagiri@microchip.com,
        Horatiu.Vultur@microchip.com, robh+dt@kernel.org, andrew@lunn.ch,
        michael@walle.cc, Jerry.Ray@microchip.com, conor+dt@kernel.org,
        jesper.nilsson@axis.com, andre.przywara@arm.com, ada@thorsis.com,
        radu_nicolae.pirea@upb.ro, richard.genoud@gmail.com,
        gregkh@linuxfoundation.org, linux-spi@vger.kernel.org,
        linux-serial@vger.kernel.org
References: <20230713095111.335346-1-durai.manickamkr@microchip.com>
 <20230713095111.335346-3-durai.manickamkr@microchip.com>
 <204ad135-5358-35d0-2df2-9495acf0432d@linaro.org>
 <9a29d928-d1e6-ea55-c5dc-0a884978b8df@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <9a29d928-d1e6-ea55-c5dc-0a884978b8df@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 13/07/2023 12:28, Durai.ManickamKR@microchip.com wrote:
> 
> On 13/07/23 15:33, Krzysztof Kozlowski wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>>
>> On 13/07/2023 11:51, Durai Manickam KR wrote:
>>> Remove the dbgu compatible strings in the UART submodule of the
>>> flexcom for the proper SOC detection.
>> Why?
>>
>>> Fixes: 99c808335877 (ARM: dts: at91: sam9x60: Add missing flexcom definitions)
>> If this is a bugfix, then please clearly describe the bug and its impact.
> Please check the coverletter (PATCHv2 0/2) for the real problem. But 
> will try to explain the bug a bit more in the next set of patches.

Commit should stand on its own. Cover letters are usually not part of
the commits.

Best regards,
Krzysztof

