Return-Path: <SRS0=rV5n=57=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3466DC38A29
	for <linux-serial@archiver.kernel.org>; Wed, 15 Apr 2020 10:34:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12A3A2078A
	for <linux-serial@archiver.kernel.org>; Wed, 15 Apr 2020 10:34:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z40z8v7A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408703AbgDOKel (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 15 Apr 2020 06:34:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408700AbgDOKeM (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 15 Apr 2020 06:34:12 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD422C061A10
        for <linux-serial@vger.kernel.org>; Wed, 15 Apr 2020 03:34:09 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id v8so14609180wma.0
        for <linux-serial@vger.kernel.org>; Wed, 15 Apr 2020 03:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PTNilJgBZZhyWSgq5FQ4sgITJPwkD0fbyzKxpSApE9g=;
        b=Z40z8v7A93xbwxuDomrQ1jlZ+G1cx5ZSJ+kowcM3KaCigmBMo9/9LXdG9Cc9ECiiv4
         uaXolBMvj8X+3L/7OrJcsHjT4DcCPn1zVRMkENksxP4DgkBSVSmH6tJa+xhi0+hwXTLN
         Wy0erTwUemWru+RFm1/W0qL3DPqWvaqnKQdSiU3cUDuJQoU/F6zpKs+9DvTIu91ntF7M
         SGS1foepnmhRpTE4egC6jDeODRIF/hkO7eUYve1V3MoekXkyvZCActFRkx6Gc18V1+y7
         ndXf08u10868l5w+Axdrlp6BHHhD2Z/fCVwcK6Jk6XDeUIbwFr50d9obwFJ+gduNo7OY
         goLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PTNilJgBZZhyWSgq5FQ4sgITJPwkD0fbyzKxpSApE9g=;
        b=eVMXifbSbe/NdJAlmQ6e/GDurXF5GZiRmoI8qt8eg+/IDc3NS1/8nmPK220nrtt60O
         7C2Xkd6OloyiZ6XwKlotNB5iRt5phLstJsa3JmZlHm9OW3xFq5DiQpHXdzs1DPOHnLnd
         0FQWlE9qus/frCJAgiSvBgeKOgk+zavgtrGzjOVDQt+PiGkzEcbyn07NFzmUadPVCQ3y
         qHpfkRjf3qNgZmrkVwNhE+gGU83NIBPBMXTrHwMGIwgVGsg6zkn12zia3AUqJsLL4U7/
         OR1tWYtwJ+9CdTNuZk2zDKdqFgt88hhx2XG7VX2suXeHJSh+Txgcw9lvsR6gJUNlHxSK
         s/Aw==
X-Gm-Message-State: AGi0Pub66mctdF6doDELF8k2W8oWTKOUDqM4/eA/jXtQuDGHVSSp5lu3
        wLvdx07ngLviOKDHap7f9f0N5w==
X-Google-Smtp-Source: APiQypKBXMSKkLl3vKZS5yoXgN9eV8pgAR0WguL01vf0LrSnHKFKhjDONkGJCVMXk1MVAgVMiRcXEA==
X-Received: by 2002:a1c:990d:: with SMTP id b13mr2392392wme.179.1586946848251;
        Wed, 15 Apr 2020 03:34:08 -0700 (PDT)
Received: from [192.168.0.136] ([87.120.218.65])
        by smtp.googlemail.com with ESMTPSA id u7sm24319753wmg.41.2020.04.15.03.34.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Apr 2020 03:34:07 -0700 (PDT)
Subject: Re: [PATCH V3 7/8] spi: spi-qcom-qspi: Add interconnect support
To:     Mark Brown <broonie@kernel.org>
Cc:     Akash Asthana <akashast@codeaurora.org>,
        gregkh@linuxfoundation.org, agross@kernel.org,
        bjorn.andersson@linaro.org, wsa@the-dreams.de,
        mark.rutland@arm.com, robh+dt@kernel.org,
        linux-i2c@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, swboyd@chromium.org,
        mgautam@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-serial@vger.kernel.org, mka@chromium.org,
        dianders@chromium.org, evgreen@chromium.org
References: <1585652976-17481-1-git-send-email-akashast@codeaurora.org>
 <1585652976-17481-8-git-send-email-akashast@codeaurora.org>
 <20200331112352.GB4802@sirena.org.uk>
 <f896d6e4-cc86-db46-a9b9-d7c98071b524@codeaurora.org>
 <20200407105542.GA5247@sirena.org.uk>
 <48c60fdf-03c6-650a-2671-b8f7cc1e5c82@codeaurora.org>
 <5644ef02-f984-0f5b-d745-eca3c9573726@linaro.org>
 <20200409132042.GD5399@sirena.org.uk>
From:   Georgi Djakov <georgi.djakov@linaro.org>
Openpgp: preference=signencrypt
Autocrypt: addr=georgi.djakov@linaro.org; prefer-encrypt=mutual; keydata=
 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
 KEmKjLDvB0pePJkdTw==
Message-ID: <15799ba5-bcbf-92d9-ac2e-a8bea469d005@linaro.org>
Date:   Wed, 15 Apr 2020 13:34:05 +0300
MIME-Version: 1.0
In-Reply-To: <20200409132042.GD5399@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi,

On 4/9/20 16:20, Mark Brown wrote:
> On Thu, Apr 09, 2020 at 04:17:22PM +0300, Georgi Djakov wrote:
>> On 4/8/20 15:17, Akash Asthana wrote:
> 
>>> Can we centralize below logic of peak_bw selection for all the clients to ICC core?
> 
>> I don't think this is a good idea for now, because this is very hardware
>> specific. A scaling factor that works for one client might not work for another.
> 
> AIUI a driver can always override the setting if it's got a better idea.

True.

>> My questions here is how did you decide on this "multiply by two"? I can imagine
>> that the traffic can be bursty on some interfaces, but is the factor here really
>> a "random number" or is this based on some data patterns or performance
>> analysis?
> 
> The reason I'm pushing for this to go into the core is that the numbers
> seem to be just made up and not device specific at all (or at least
> there's a lot of devices with the same values).

I might be a bit too cautious here, but the main question is what this common
number should be then. Maybe the numbers are not device specific, but
communication interface/bus specific? I would rather make the peak 30% higher
than the average, but for low speed interfaces i guess the factor of two should
also be fine?

Thanks,
Georgi
