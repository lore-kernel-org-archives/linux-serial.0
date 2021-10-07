Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39BD0C4332F
	for <linux-serial@archiver.kernel.org>; Thu,  7 Oct 2021 13:12:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1088561390
	for <linux-serial@archiver.kernel.org>; Thu,  7 Oct 2021 13:12:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241308AbhJGNOt (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 7 Oct 2021 09:14:49 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:50932
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241341AbhJGNOr (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 7 Oct 2021 09:14:47 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 611E43FFFE
        for <linux-serial@vger.kernel.org>; Thu,  7 Oct 2021 13:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1633612373;
        bh=iirK3i9WG+HMUrskVNYjHF1PRpxBdgd8IKVUip8gjUQ=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=UzN7h64Id7SHnxwBiLhjP5D9qD3+3i5DPAyiKndQPadyaA84P6kLZ3dvOu9aW8BIp
         YjrwummcSVlZ0mE7Hw8kcgnJtXrVxP745ShPJ6sERP2DOmu1Ch7r4jglRXogA8StXZ
         thJZdmzoTVZoFW/qpA/5nWuUatIFLxD71hh4PoSN3IX1aHrrBNSVpujXrN0QskAH0h
         AMS7aXXhPrZ51zudiCTil9Sdu91v0aQs+y5oMXeEgxwNCrWAh/wMq4MoTQaYSMU6jD
         IanjnqdxT1UVCPj0V26/j6M6nxsV2ZCu4aZO+w48bwMbq1RI2FHh/4wCFjSzz7e33h
         fdZQbiqERP08g==
Received: by mail-wr1-f70.google.com with SMTP id a10-20020a5d508a000000b00160723ce588so4653956wrt.23
        for <linux-serial@vger.kernel.org>; Thu, 07 Oct 2021 06:12:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iirK3i9WG+HMUrskVNYjHF1PRpxBdgd8IKVUip8gjUQ=;
        b=PXo5IxeUmzpQsWipwcJhUDMGUIkvKUGxAikcf7DzbyjZIY/SQBdBhEBMygeZ2j6uit
         Hdwg8MTM9ObV75bmDUeBa9dvr+QhRY/RMaPwKRGJtrJNIj4AGwfTsksx//DaEDWut+On
         kFhz/ptnXrfXsh+jyd7++9lmenLhn7Wkz8FUJ6b76+D9ajyqaZRgjd8bPWqulOMr/KTH
         DKCMqXDqRTjgheytToLolroKhc5dnTkhGsIBkJUdhBwHKqHH3bv+JNwxkmwMKEWa1YYc
         CEOAopeW6zSFYMuotqn5XiJT5Hdqq2eL/rB3HGiNw561oyhoYVkSiWy7tvleDZeco68g
         6OIw==
X-Gm-Message-State: AOAM532QyREvL2lCpPK0gncoPwcGXB1jrhikrQVu5Gasjhs/XATr6FIC
        FuBnjwA07ktP5uNTszBH3+tCAdbtz+l+yxUnlWzjYdgxRyKVjxcXA+t3wzXyqGR/DD6PL4FILmq
        JEQ3Mya/58IFyYRj1XCEiASvNrKdfUTS3Yi20YRTHEA==
X-Received: by 2002:adf:e8d2:: with SMTP id k18mr5360888wrn.219.1633612372784;
        Thu, 07 Oct 2021 06:12:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw3hpfP4OSaat1L3xt+PSv3NTONOShlxrR7nAUJcdNm/g+TtJbmwx0s/MXDAzkDO+Y0ZGjeDw==
X-Received: by 2002:adf:e8d2:: with SMTP id k18mr5360863wrn.219.1633612372674;
        Thu, 07 Oct 2021 06:12:52 -0700 (PDT)
Received: from [192.168.1.115] (xdsl-188-155-186-13.adslplus.ch. [188.155.186.13])
        by smtp.gmail.com with ESMTPSA id p13sm5355062wma.22.2021.10.07.06.12.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Oct 2021 06:12:51 -0700 (PDT)
Subject: Re: [PATCH 2/7] dt-bindings: power: Add apple,pmgr-pwrstate binding
To:     Hector Martin <marcan@marcan.st>,
        linux-arm-kernel@lists.infradead.org
Cc:     Marc Zyngier <maz@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-serial@vger.kernel.org
References: <20211005155923.173399-1-marcan@marcan.st>
 <20211005155923.173399-3-marcan@marcan.st>
 <b5b3fcb4-077b-d33d-03cc-ac0611cb56a1@canonical.com>
 <5b89aed0-f9b7-fdba-16d8-a8bd9e2d7437@marcan.st>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <6e92a8d3-798a-267a-d24e-6b9ff0c3c645@canonical.com>
Date:   Thu, 7 Oct 2021 15:12:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <5b89aed0-f9b7-fdba-16d8-a8bd9e2d7437@marcan.st>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 06/10/2021 17:59, Hector Martin wrote:
> On 06/10/2021 16.05, Krzysztof Kozlowski wrote:
>>> +  IP cores belonging to a power domain should contain a
>>> +  "power-domains" property that is a phandle for the
>>> +  power domain node representing the domain.
>>
>> Skip this last paragraph - it is obvious in usage of power domains.
>> Specific bindings should not duplicate generic knowledge.
> 
> Ack, I'll drop it.
> 
>>> +properties:
>>> +  $nodename:
>>> +    pattern: "^power-controller@[0-9a-f]+$"
>>
>> Usually we call nodes as power-domain.
> 
> I had it as that originally, but these aren't power domains. These are 
> power management domains (they can clock *and* power gate separately, 
> where supported) plus also do reset management. So I wasn't sure if it 
> was really fair calling them "power-domain" at that point.

OK, thanks for explanation.

> 
>>> +  power-domains:
>>> +    description:
>>> +      Reference to parent power domains. A domain may have multiple parents,
>>> +      and all will be powered up when it is powered.
>>
>> How many items?
> 
> One or more (if there are none the property should not exist). I guess 
> that should be encoded.

Probably this should not go without any constraints. Are you sure it
could have more than one? It would mean more than one parent.



Best regards,
Krzysztof
