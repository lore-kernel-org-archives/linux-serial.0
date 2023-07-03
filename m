Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D295C001DB
	for <linux-serial@archiver.kernel.org>; Mon,  3 Jul 2023 14:59:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231418AbjGCO7e (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 3 Jul 2023 10:59:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231219AbjGCO7c (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 3 Jul 2023 10:59:32 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EB90E4E
        for <linux-serial@vger.kernel.org>; Mon,  3 Jul 2023 07:59:31 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2b698371937so73583881fa.3
        for <linux-serial@vger.kernel.org>; Mon, 03 Jul 2023 07:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688396369; x=1690988369;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ux3SJsWvIcNtyLBV4pxoycLjvjlI+oYJOk/HoRjmvBw=;
        b=JLt6ff0K6AlkSGvVOXKa26IAS1N0CeL9GHWrBfo8fQ2yXk0dAbFS5PvjOqladIjud4
         +FQJ6XeuAUbxjMjHea3C58hEBpG6I/l8hxYUmf1aplKPnnRpdoH9DCpzuxrfZoJUq8gn
         am2JNiJD2Z0fxpnG7kk6mbUN08JIp2aoJBft3fU/GR3XF0DbZEyg2+WONSsYRq/O/v9z
         /oWq/qLAo7K5yS8yNZ5rBPvBMZ40tvCo/xbjxXpd8+XkFFIxFSOkZvQO0HWr6HR0XXHa
         eTwNWO75TVrZr7cXJsmXkS6duRuqFtmpcTONXafFD7A5H/LRWEMwUOZJR8gFe7dK7ReI
         iGKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688396369; x=1690988369;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ux3SJsWvIcNtyLBV4pxoycLjvjlI+oYJOk/HoRjmvBw=;
        b=WhwhbEhP972OPRXzDo1Fi5GAQlvkmkuRpsPwfAtznWPn6QrjCgM0tH7W3QG9MzRTyR
         A1p3vMBPqyM2I7reqWwkyq2bOhsPPeQI5pgSc+UHw5AGyWF16R//QBLjvR1FfBB7iDPB
         d58zah/HwilLkN2ipdNgXfjLrtYY+jdSgMBiDKJYRb+atuP9JyentDQk6cCeMIDJV7qk
         K7UOMWdaOcR9d8t301fax4089URD5Rjy84FKfvxlQrl0JODzN8GHhBmKcscGaWf2SgCj
         drzIjdHdWkurh07iNpUkdISEKsw0Y2OxoPUfnwWviWuF+fyQ86R0q7wYlpE5byfK+5lE
         4DNA==
X-Gm-Message-State: ABy/qLZLvWXnOTHuGLQVz9b6rBhoNpoeKJL88s3YjmS0m90XLvwHf+dm
        27sUyZZPzv1+mxfayvq4qVWAEA==
X-Google-Smtp-Source: APBJJlEEEcJT6hzruF4LYserl4hMFzP3P6NYtXj0bcH+2GwlEmR0i/2kSlzbMdVfbTYPxSlAn/dPaA==
X-Received: by 2002:a2e:9844:0:b0:2b5:86e4:558e with SMTP id e4-20020a2e9844000000b002b586e4558emr6986594ljj.38.1688396369411;
        Mon, 03 Jul 2023 07:59:29 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id k22-20020a056402049600b0051e0bf5807bsm2280634edv.49.2023.07.03.07.59.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jul 2023 07:59:28 -0700 (PDT)
Message-ID: <4b1beb09-c9ba-82c5-69f0-058025c7f7e2@linaro.org>
Date:   Mon, 3 Jul 2023 16:59:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 3/5] dt-bindings: i2c: qcom,i2c-geni: Allow no qup-core
 icc path
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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
 <20230703-topic-8250_qup_icc-v1-3-fea39aa07525@linaro.org>
 <05869d6f-972b-75e1-6c0f-46baeafca5ff@linaro.org>
In-Reply-To: <05869d6f-972b-75e1-6c0f-46baeafca5ff@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 03/07/2023 16:36, Krzysztof Kozlowski wrote:
> On 03/07/2023 15:31, Konrad Dybcio wrote:
>> Some SoCs (like SM8150 and SM8250) don't seem to provide a qup-core path.
>> Allow such case.
>>
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Un-reviewed. Don't define properties in oneOf, instead use the syntax I
pointed out in other patch. If you remove interconnects from this
example, you will reproduce the error.

This should be something like:
          interconnects:


            minItems: 2
            maxItems: 3

          interconnect-names:
            oneOf:
              - items:
                  - const: qup-config
                  - const: qup-memory

              - items:
                  - const: qup-core
                  - const: qup-config
                  - const: qup-memory


Best regards,
Krzysztof

