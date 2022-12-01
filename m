Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE013C4321E
	for <linux-serial@archiver.kernel.org>; Thu,  1 Dec 2022 11:03:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230433AbiLALDf (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 1 Dec 2022 06:03:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbiLALDI (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 1 Dec 2022 06:03:08 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2028C2E6B5
        for <linux-serial@vger.kernel.org>; Thu,  1 Dec 2022 03:03:07 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id j4so1983213lfk.0
        for <linux-serial@vger.kernel.org>; Thu, 01 Dec 2022 03:03:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xZPsJdX0DeKIWrtluUWX3HVvTrGo25QoDXGFCZw1PXk=;
        b=Iymxm2gwfFfqDxv99/Cvwgt5Tt86cvRAlbIcRFWVwq86La55pm/Wo85Vda8Abburiq
         +n3izNS6OKkWrKNxSR7d4nYTKkRisuxhy72xbJdZlPGyodm9rRlv79WAHcEZEQh5ODCF
         3bI2VKbSof5THgzSiG1M/osblrxsXxBEwbET9bJM1ToEZYibo54O/MKYhxPMwN2HTEMF
         xzxmqF6zfBPGlwF2GgpYW38omTN4zE/muv5xZer5SOacWpy09fPs11gsgRsHlzgKI4b6
         2CqKCMUboHskQm8xxv8fyveBOPHoYbQbYxdiFH/eY+rnKKTJ82CRWYT5YdyErzWM+iBc
         E1bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xZPsJdX0DeKIWrtluUWX3HVvTrGo25QoDXGFCZw1PXk=;
        b=gJT+MCgK45z/PDueZG1NgHuxv7tGguiQB+asFnsbwwpZ7hXXtKBYPOrYWSg2mKEnCo
         8svdwUt94Bw0aap/zE+7XV6gSHtZ/GeBV/2/PesV/9R9S9wOKuO6/738VVXjUG4W/1SW
         jRXHJjSZFW0SIoSoBpie9ogczV9ldXVoWj5CGbt6GpKKExVWaWD/suzRxsXk+sUHLYk2
         +fDU3aToygTXeBMbfEbbgMGEqx12YmTjqKBVZRv6ZJVNoFrvyWAr/crCEEI3fsgzpBc6
         6QmFkroWgzQ/hxqPkoleP4iXdoIQYteyYauznPNtHwo5OEq/DRInOPxCE4zuQ+6l+E9v
         ogRQ==
X-Gm-Message-State: ANoB5pk7zfmCkKy9XmkbtDfrzz5bqz+ykOk91SEKhn6NtTNxbaF7X+FG
        7OqCCwurZoesIgwW5qwqhKK2WQ==
X-Google-Smtp-Source: AA0mqf4rvnW0TD1qNBxou5BIbgpN6sDqmoCi83kGXJ7IydthJadNC0OxxCFRj4tbainX/imKqFlpAQ==
X-Received: by 2002:a05:6512:3a8a:b0:4b5:4888:4362 with SMTP id q10-20020a0565123a8a00b004b548884362mr244955lfu.176.1669892585363;
        Thu, 01 Dec 2022 03:03:05 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id j22-20020a056512399600b004b49025f96dsm610425lfu.187.2022.12.01.03.03.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Dec 2022 03:03:03 -0800 (PST)
Message-ID: <be603b02-9357-431f-0f5a-069659bd6ce5@linaro.org>
Date:   Thu, 1 Dec 2022 12:03:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 4/9] dt-bindings: vendor-prefixes: add bouffalolab
Content-Language: en-US
To:     Jisheng Zhang <jszhang@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
References: <20221127132448.4034-1-jszhang@kernel.org>
 <20221127132448.4034-5-jszhang@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221127132448.4034-5-jszhang@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 27/11/2022 14:24, Jisheng Zhang wrote:
> In the following commits, we will support bl808 SoC which is from
> Bouffalo Lab Technology (Nanjing) Co., Ltd.
> 
> Add bouffalolab vendor prefix binding.
> 
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)

Wrong order of commits. You cannot start using something before adding
its description. This should be the first patch in the set.

Best regards,
Krzysztof

