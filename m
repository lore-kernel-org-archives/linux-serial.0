Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99B98C35274
	for <linux-serial@archiver.kernel.org>; Thu, 21 Apr 2022 07:46:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386098AbiDUHs4 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 21 Apr 2022 03:48:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386434AbiDUHsP (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 21 Apr 2022 03:48:15 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C219720F71
        for <linux-serial@vger.kernel.org>; Thu, 21 Apr 2022 00:44:07 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id lc2so8197727ejb.12
        for <linux-serial@vger.kernel.org>; Thu, 21 Apr 2022 00:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=wFOM3aTz+LbKb8gZOMS549nd6n0GmljjOzNeZ6+Ou1w=;
        b=ynkd2EDJs/zVMNdxjBj8nHfyCctK+pnpZavAb7r/eORAjJ3gr1daobIoECVEI/nv9Y
         tW5rBB5vk6+trcfRUGAbuavqwTiN2s5omn+NsVRJyYcxKLNzhKe5Hw0ZfhGcagQcNH3k
         nuiagjIChOJEkJq4SdpMw8VRKvPcOmxW+UZ6LjtXmT/CyuvHN5xqM3zXXqVkMVouxzKE
         TRJelcv5j9l5skWNXJhgE7bYectcTt1odNP7SoLe5abu3haL6s836memBK07VFTvqCFt
         v9p6yyoAGVNynA9l+aMTTDJWbPnVB5iKVvxAlVR0X+gHFut8dGdVUWzprUMg5AviU2sx
         cOgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=wFOM3aTz+LbKb8gZOMS549nd6n0GmljjOzNeZ6+Ou1w=;
        b=APfH6q41Sc5rTNkACXHPWXdGsmixlXP7wWHMc2TMH38L6psYxEeYJ+aK1BEBJpys45
         dV0ZqmNQJh0GzTfZzPcn7pLEi+RKZ+byW/RL0D+DhPEj/sa7dCRJWKDiszYg58IBVOGa
         JMRitoKDMzmnRmysdjcJRhtkzZdoJAi3hsf1tB7lD1aZAhO/ZnpkKQmwX5mUv5IkKOrJ
         /CXnrcMrYHaHDi528waw6ySC9A7Ua+spOnU+RXjD727kuaGQI0YNkKpPcWfHNn1HaNvK
         41iwxf0vaA+fkaUvlGdm+q9NzWMr6s42JO+n/291wITtDsi56DNY66OzNM4LPwtrWsq2
         qwAw==
X-Gm-Message-State: AOAM531x7ZxqNTZrUJm4/WIDSRFxtaboDxxbbs/XoWVfpAt1bbGSwZos
        r6YFz00GTT7Ru0L3/rYHjS28ag==
X-Google-Smtp-Source: ABdhPJzWkBkZe1WhiJd8P+EOyRLym8rU+7Ih/yKEoUvviZF+KrrG6fVJu09hs2cLspSwCIw389MaHw==
X-Received: by 2002:a17:906:3104:b0:6ce:6b85:ecc9 with SMTP id 4-20020a170906310400b006ce6b85ecc9mr21560466ejx.339.1650527046224;
        Thu, 21 Apr 2022 00:44:06 -0700 (PDT)
Received: from [192.168.0.226] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id ce21-20020a170906b25500b006e89869cbf9sm7538142ejb.105.2022.04.21.00.44.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Apr 2022 00:44:05 -0700 (PDT)
Message-ID: <ff0711f5-0e41-9aae-0b2f-381f272481bb@linaro.org>
Date:   Thu, 21 Apr 2022 09:44:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 05/15] dt-bindings: power: Add r8a779g0 SYSC power domain
 definitions
Content-Language: en-US
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        geert+renesas@glider.be, magnus.damm@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, gregkh@linuxfoundation.org
Cc:     linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org
References: <20220420084255.375700-1-yoshihiro.shimoda.uh@renesas.com>
 <20220420084255.375700-6-yoshihiro.shimoda.uh@renesas.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220420084255.375700-6-yoshihiro.shimoda.uh@renesas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 20/04/2022 10:42, Yoshihiro Shimoda wrote:
> Add power domain indices for R-Car V4H (r8a779g0).

Are these values used by renesas,rcar-sysc (r8a779g0) - patch 4? If yes,
maybe just squash it?

In any case:

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
