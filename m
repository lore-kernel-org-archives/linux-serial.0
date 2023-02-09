Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A89E4C636D7
	for <linux-serial@archiver.kernel.org>; Thu,  9 Feb 2023 09:12:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbjBIJL7 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 9 Feb 2023 04:11:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbjBIJL5 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 9 Feb 2023 04:11:57 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 551448680
        for <linux-serial@vger.kernel.org>; Thu,  9 Feb 2023 01:11:49 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id r2so1054706wrv.7
        for <linux-serial@vger.kernel.org>; Thu, 09 Feb 2023 01:11:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kxvn5OMzyzBqETwPzu80u7hwe8zuuXrGX7TuXlP4qi0=;
        b=hdwCkAFjfCYSHKqw8+smBlNg4fCdRKpQTd4YEielegmV0s3MRAorwpnoPeMHJRHWHZ
         GSvgXupwKUkkicopfmiS+Mhm7bdK6XBHbi9bzTFk2R/ZzSb++inmoaePtx+UHfa6OMs7
         sOXNRKvNfjnJUQimFfTKrLj6FaEdGF3O+xWdLkEVZM227bDBXkECuoNcOQzzIuseQ3I3
         /UyOU1t2PmDa9FhOgyXYwE6+wn7rO01aREcZeah/2FK6ILNklzPOPZd24gaq7OWtqYS2
         aZJPCbLPFraHKUl8NkZtCXTY50WKCHbt5D0BYV0wu5NcvhmoLDLi5wzzA5EeBOo3fmRO
         YpRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kxvn5OMzyzBqETwPzu80u7hwe8zuuXrGX7TuXlP4qi0=;
        b=e6ngi1CgIG2DtJCfOptxrPEU/4PpmKoBxgiifgVfgEOTpvjyFDuWA4ZjzVlF0ydIW8
         j0t220jb0z21gZQxmPde5aOFv1f+9yYm4vteW0/M1LvAzSUQRVjC5HRX/Fvemak1GmCT
         cQfoGRmzZwBqrhwG9tWJ57nYxt6RQXBSaq6yNXrVHLvPj/jjfS7Z+zMM1UtgQCJHUnJs
         MALe43ih7ZwllZLZHvWhp7ElIWsHjdXpHBm79eX2yXe6y9pI68D1bBSZo67576SfjQVt
         cw94IERKGSz6quUSh3LYuE6DEVibTsenf5uyi4nD7a12XGPz5CEwKiGUbW/HPKRM4L+p
         BeTg==
X-Gm-Message-State: AO0yUKUb/Vyc2pUDcZkF+XhYyy1RoAklAT8rD8kxhRfoWNUVVT29EF+R
        3RcYAj4UOWOyCiFEiLd9EVWzGg==
X-Google-Smtp-Source: AK7set8552ZGuPTfdL9T1or1CEjqNNE+WiEnvbxdUuMToBkzo+xCAMUKemqN2e8NlMREeQahOvMNug==
X-Received: by 2002:a5d:6b4b:0:b0:2c3:ed18:2e96 with SMTP id x11-20020a5d6b4b000000b002c3ed182e96mr9711597wrw.13.1675933907856;
        Thu, 09 Feb 2023 01:11:47 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id s11-20020adfeccb000000b002bfcc9d9607sm720564wro.68.2023.02.09.01.11.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Feb 2023 01:11:47 -0800 (PST)
Message-ID: <7ad7710b-2318-4c20-da2f-b0ee1a1a9cef@linaro.org>
Date:   Thu, 9 Feb 2023 10:11:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v1] dt-bindings: serial: snps-dw-apb-uart: add dma &
 dma-names properties
Content-Language: en-US
To:     Conor Dooley <conor@kernel.org>, robh+dt@kernel.org,
        gregkh@linuxfoundation.org
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        krzysztof.kozlowski+dt@linaro.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230208171715.70862-1-conor@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230208171715.70862-1-conor@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 08/02/2023 18:17, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> Commit 0c559bc8abfb ("dt-bindings: serial: restrict possible child node
> names") exposed the Allwinner D1 devicetrees as users of unevaluated
> properties, with a slew of similar warnings now appearing during
> dtbs_check:
> sun20i-d1-nezha.dtb: serial@2500400: Unevaluated properties are not allowed ('dma-names', 'dmas' were unexpected)
> 
> Document the missing properties.
> 
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof

