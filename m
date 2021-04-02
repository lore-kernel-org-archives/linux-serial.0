Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D657CC43460
	for <linux-serial@archiver.kernel.org>; Fri,  2 Apr 2021 01:19:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6CBC6105A
	for <linux-serial@archiver.kernel.org>; Fri,  2 Apr 2021 01:19:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234211AbhDBBTv (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 1 Apr 2021 21:19:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233786AbhDBBTu (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 1 Apr 2021 21:19:50 -0400
Received: from thorn.bewilderbeest.net (thorn.bewilderbeest.net [IPv6:2605:2700:0:5::4713:9cab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B23BC0613E6;
        Thu,  1 Apr 2021 18:19:50 -0700 (PDT)
Received: from hatter.bewilderbeest.net (unknown [IPv6:2600:6c44:7f:ba20::7c6])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: zev)
        by thorn.bewilderbeest.net (Postfix) with ESMTPSA id 077D4198;
        Thu,  1 Apr 2021 18:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
        s=thorn; t=1617326389;
        bh=G8rBZRZvYmpd8o2JnBLz+E9kxXF/0mTp2nuOMD0ePt4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HfKFGPOy/jqFi/BvkNmXkrnBaEFVbosfT3gvTTCGAShQzSfVHKvS8LGi909Oo6cjT
         DjdjMlrA7IeRZLDE0t4Xq0nZrycHq1uarkkOLR+Z213w1EOBcqy1QseADj3NDeigjE
         DnygHZ1rUPTyHGMr6FPzHpWt9aM8ljyDbZuG9XjQ=
Date:   Thu, 1 Apr 2021 20:19:47 -0500
From:   Zev Weiss <zev@bewilderbeest.net>
To:     Andrew Jeffery <andrew@aj.id.au>
Cc:     Joel Stanley <joel@jms.id.au>, openbmc@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Lubomir Rintel <lkundrak@v3.sk>,
        - <devicetree@vger.kernel.org>, linux-serial@vger.kernel.org
Subject: Re: [PATCH v3 4/4] dt-bindings: serial: 8250: add aspeed,lpc-address
 and aspeed,sirq
Message-ID: <YGZxM31x0All76gm@hatter.bewilderbeest.net>
References: <20210402004716.15961-1-zev@bewilderbeest.net>
 <20210402004716.15961-5-zev@bewilderbeest.net>
 <639f957f-a0d7-4a06-8598-90da0e17820b@beta.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <639f957f-a0d7-4a06-8598-90da0e17820b@beta.fastmail.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Apr 01, 2021 at 08:14:39PM CDT, Andrew Jeffery wrote:
>
>
>On Fri, 2 Apr 2021, at 11:17, Zev Weiss wrote:
>> These correspond to the existing lpc_address, sirq, and sirq_polarity
>> sysfs attributes; the second element of aspeed,sirq provides a
>> replacement for the deprecated aspeed,sirq-polarity-sense property.
>>
>> Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
>> ---
>>  .../devicetree/bindings/serial/8250.yaml      | 27 ++++++++++++++++---
>>  1 file changed, 24 insertions(+), 3 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/serial/8250.yaml
>> b/Documentation/devicetree/bindings/serial/8250.yaml
>> index 491b9297432d..a6e01f9b745f 100644
>> --- a/Documentation/devicetree/bindings/serial/8250.yaml
>> +++ b/Documentation/devicetree/bindings/serial/8250.yaml
>> @@ -12,8 +12,13 @@ maintainers:
>>  allOf:
>>    - $ref: /schemas/serial.yaml#
>>    - if:
>> -      required:
>> -        - aspeed,sirq-polarity-sense
>> +      anyOf:
>> +        - required:
>> +            - aspeed,lpc-address
>
>Why not aspeed,lpc-io-reg like the KCS binding?
>
>There are some things we can do to improve it, but we shouldn't go and invent something different. I prefer aspeed,lpc-io-reg because it's name derives from the generic 'reg' property as does it's behaviour (if you assume a related `#size-cells = 0`).
>
>> +        - required:
>> +            - aspeed,sirq
>
>Why not aspeed,lpc-interrupts like the KCS binding?
>
>The generic IRQ property is 'interrupts', so like aspeed,lpc-io-reg the interrupts proposal for KCS follows in name and form. I'm hiding it behind the aspeed vendor prefix for now while I'm not satisfied that I understand the requirements of non-aspeed parts. Similarly, I added the lpc prefix because we don't tend to describe the host devicetree in the BMC devicetree (and so there's no parent interrupt controller that we can reference via a phandle) and we need a way to differentiate from the local interrupts property.
>
>I don't see a reason for either of them to differ from what we already have for KCS, and I don't see any reason to continue the sysfs naming scheme in the binding.
>

Ah, OK -- I was aiming for consistency with the existing vuart sysfs 
attributes, but if that's not a worthwhile concern I'm fine with 
aspeed,lpc-io-reg & aspeed,lpc-interrupts.


Zev

