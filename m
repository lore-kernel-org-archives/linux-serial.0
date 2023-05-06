Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D449C77B7F
	for <linux-serial@archiver.kernel.org>; Sat,  6 May 2023 06:50:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbjEFGuq (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 6 May 2023 02:50:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbjEFGup (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 6 May 2023 02:50:45 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDB56A5CB
        for <linux-serial@vger.kernel.org>; Fri,  5 May 2023 23:50:43 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-965e4be7541so282082966b.1
        for <linux-serial@vger.kernel.org>; Fri, 05 May 2023 23:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683355842; x=1685947842;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uyLSGcqzev4ScCUTVAy/dI0FShLpsKcG+iQhkbBmwu4=;
        b=AlfRNVG3E3APA+Cf7R720DagAe1db7tpRUYFB5jhqr3xtQD0uysDqwcdi3u6Ezxk7m
         KP70xR7fbiv48VXV98A86UvtqVHK01ERc2R5PuMt5hT6q540GxKOUFECRkrcrqYFdtUY
         cOAVmo4HkSVubck+5re4/FrqcoCKARUE+PqsrOdHpoKh9Z5m+o5OqsVkQlCjK3h2zRyM
         OPuhnNA5r1Z4mHkrQ5Sl7992aAFU/ZyrsLwxTCBDSOPtf2kNcElmYTi1qiJjkrlGxw5z
         SGoZHEf/NoNhESk59YswB3fJz4QcGdJ3e+5zfmD7ixDyi5oA/5Be3+SfDfYZ1Zwn+5Pw
         V6ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683355842; x=1685947842;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uyLSGcqzev4ScCUTVAy/dI0FShLpsKcG+iQhkbBmwu4=;
        b=RyWiXz6XyPtQGt2D9YRrf3hNDqI99HmKNhUTQD4ChBUeWK/bidaxgf9/woayiPssJb
         /kqCaKvuyFZvimMKoODXYR1HVfMTHPDOTTWQgP5ZT0pUNGHcpDXU0MU9OHiTDDDa3WLB
         ulXGuRScBAFEPpcQDiNUk9EnRimORZn+4b50IR3PUXTnKT93BycMposlWZkABFtVGKuh
         St09f9prgTVIB+gUC5jD+JyUX6AmWmgDapbwOzn+z1TiRvX5GLmY2FVuDOmD2VROspT2
         4+7lZmt631l4zpQr9ysSYLjqYErOLpsfOubNgRWiOn6rRCLHHSehYB2VFJ1AddFh7eD1
         v4Rg==
X-Gm-Message-State: AC+VfDxpVREswnHXjbq+WFSeuAqoAjuMZNyD+2EHn7PbOU4hVWskT1ZN
        T7sRfPpY4Ng4IefNSiOSbPQdFg==
X-Google-Smtp-Source: ACHHUZ4qwZlWqW21bAjZx+NhonFjoZxHRzhnBe74050ohLqDg+tEhybkuwIbcn3+p0SMly0JESZ5CQ==
X-Received: by 2002:a17:907:6d1f:b0:94e:f1b9:e933 with SMTP id sa31-20020a1709076d1f00b0094ef1b9e933mr3426437ejc.53.1683355842265;
        Fri, 05 May 2023 23:50:42 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:efe5:7c03:a10a:7a40? ([2a02:810d:15c0:828:efe5:7c03:a10a:7a40])
        by smtp.gmail.com with ESMTPSA id ia24-20020a170907a07800b00959b3c30f2csm1880807ejc.222.2023.05.05.23.50.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 May 2023 23:50:41 -0700 (PDT)
Message-ID: <b799be60-0ba6-c856-517d-0b0ed3adeab7@linaro.org>
Date:   Sat, 6 May 2023 08:50:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v4 tty-next 1/2] dt-bindings: serial: ni,ni16650: add
 bindings
Content-Language: en-US
To:     Brenda Streiff <brenda.streiff@ni.com>
Cc:     ilpo.jarvinen@linux.intel.com,
        Gratian Crisan <gratian.crisan@ni.com>,
        Jason Smith <jason.smith@ni.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230505213850.829639-1-brenda.streiff@ni.com>
 <20230505213850.829639-2-brenda.streiff@ni.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230505213850.829639-2-brenda.streiff@ni.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 05/05/2023 23:38, Brenda Streiff wrote:
> Add bindings for the NI 16550 UART.
> 
> Signed-off-by: Brenda Streiff <brenda.streiff@ni.com>
> Cc: Gratian Crisan <gratian.crisan@ni.com>
> Cc: Jason Smith <jason.smith@ni.com>
> ---

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

