Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4AE5C433ED
	for <linux-serial@archiver.kernel.org>; Thu,  1 Apr 2021 04:58:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB9B76108F
	for <linux-serial@archiver.kernel.org>; Thu,  1 Apr 2021 04:58:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232596AbhDAE53 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 1 Apr 2021 00:57:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232491AbhDAE5T (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 1 Apr 2021 00:57:19 -0400
Received: from thorn.bewilderbeest.net (thorn.bewilderbeest.net [IPv6:2605:2700:0:5::4713:9cab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17E83C0613E6;
        Wed, 31 Mar 2021 21:57:19 -0700 (PDT)
Received: from hatter.bewilderbeest.net (unknown [IPv6:2600:6c44:7f:ba20::7c6])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: zev)
        by thorn.bewilderbeest.net (Postfix) with ESMTPSA id EDFBF6F;
        Wed, 31 Mar 2021 21:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
        s=thorn; t=1617253038;
        bh=/OFrumQsIOz4iJCnXsvYbRHkqc1dbRe2/tQBo/d/ldk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KqKIFjoQeMd0usXeCOewSZVXGqKTaqxtdO2A065RaVsCHjr1ulhCW6cC1/2FEXt1D
         69deZT8CjP6UHfihlRbLw2aAt/sMx4M9AsG/OC0Ek/DDuK2h860pIPpdRlPI9qKxjg
         oSrrcgzqgDZiFNcAH82msjTMpyIZSaEMKyE92tpo=
Date:   Wed, 31 Mar 2021 23:57:16 -0500
From:   Zev Weiss <zev@bewilderbeest.net>
To:     Andrew Jeffery <andrew@aj.id.au>
Cc:     Joel Stanley <joel@jms.id.au>, openbmc@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Lubomir Rintel <lkundrak@v3.sk>,
        - <devicetree@vger.kernel.org>, linux-serial@vger.kernel.org
Subject: Re: [PATCH v2 3/3] dt-bindings: serial: 8250: add
 aspeed,sirq-active-high
Message-ID: <YGVSrCo7mVkSJTeQ@hatter.bewilderbeest.net>
References: <YGOuhjD19SmjmQou@hatter.bewilderbeest.net>
 <20210401005702.28271-1-zev@bewilderbeest.net>
 <20210401005702.28271-4-zev@bewilderbeest.net>
 <d66753ee-7db2-41e5-9fe5-762b1ab678bc@www.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <d66753ee-7db2-41e5-9fe5-762b1ab678bc@www.fastmail.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Mar 31, 2021 at 11:04:44PM CDT, Andrew Jeffery wrote:
>
>
>On Thu, 1 Apr 2021, at 11:27, Zev Weiss wrote:
>> This provides a simpler, more direct alternative to the deprecated
>> aspeed,sirq-polarity-sense property for indicating the polarity of
>> the Aspeed VUART's SIRQ line.
>>
>> Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
>> ---
>>  Documentation/devicetree/bindings/serial/8250.yaml | 13 ++++++++++---
>>  1 file changed, 10 insertions(+), 3 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/serial/8250.yaml
>> b/Documentation/devicetree/bindings/serial/8250.yaml
>> index 491b9297432d..e79bb6ab9d2c 100644
>> --- a/Documentation/devicetree/bindings/serial/8250.yaml
>> +++ b/Documentation/devicetree/bindings/serial/8250.yaml
>> @@ -12,8 +12,9 @@ maintainers:
>>  allOf:
>>    - $ref: /schemas/serial.yaml#
>>    - if:
>> -      required:
>> -        - aspeed,sirq-polarity-sense
>> +      anyOf:
>> +        - required: [ aspeed,sirq-active-high ]
>
>Do you think we could make use of the approach I put forward here?
>
>https://lore.kernel.org/openbmc/20210319062752.145730-18-andrew@aj.id.au/T/#u
>
>Andrew

If you mean using a u32 property (say aspeed,sirq-polarity) with an 
explicit IRQ_TYPE_LEVEL_{LOW,HIGH} instead of a present/absent bool,
sure, I guess that seems like a somewhat clearer, more orthogonal 
arrangement.


Zev

