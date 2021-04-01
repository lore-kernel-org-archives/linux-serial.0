Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30B88C433ED
	for <linux-serial@archiver.kernel.org>; Thu,  1 Apr 2021 04:05:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB04661008
	for <linux-serial@archiver.kernel.org>; Thu,  1 Apr 2021 04:05:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbhDAEFM (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 1 Apr 2021 00:05:12 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:45059 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229514AbhDAEFI (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 1 Apr 2021 00:05:08 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 13799580857;
        Thu,  1 Apr 2021 00:05:07 -0400 (EDT)
Received: from imap2 ([10.202.2.52])
  by compute3.internal (MEProxy); Thu, 01 Apr 2021 00:05:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm2; bh=bM72u7Zut+UqToL176LTPYUWVZDWGgs
        ivmdUNPFKxMU=; b=IrQSKxYQzpv/1jouAp11qxZyIIHeQnXCrcT9S70hS3YFos+
        qX1yamOzq5tRUNluxnpDJJaC4BQsGg0fqnKCBN6Uko4thO9s1rf09dj5P72ybqqY
        T7uJ78Xj/NZvZYnhLXyqUNt7D5uHuG9Yi13uTVI67dfVjwYMUl3ST0wiOUW/zWKs
        yZaA0YYviLCftcX2ZdE1XVPXd4orzokOzolQr6l5Dz8+1T/aQYr4zsYD9LTrFzGZ
        0CH9gBy8eUs87ymtI8RVq7Cwx+bIkj5gGmRczRj6RBg/PHbdAjLJOSswY1bgQKfu
        nLkGdJ5pHimIBU0Fp6k28lBc/sNw9bueam+qvJw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=bM72u7
        Zut+UqToL176LTPYUWVZDWGgsivmdUNPFKxMU=; b=flu+nAeG56GJ4xCUCWHFAk
        lpu8FXQMkirsiz9hQpRBsMLmpy2uil4XUE30IFWyKX4eG4RZsJoCmoAeiVpo7qmF
        HXaBKvJq2pgVwljWOyLY2bNru499SaaWUx0bV5GHbSYkf/0RK5pa5sW/MMLHZzGj
        I2BQqGF5Xx3Scxz8izYko3o5EWPtPvcOB7wUj8eibny07vGzxqZTFvQJYWhvOWtX
        cZMz9P0u0WZLDiXMtmudcra28kPmPw+ki6woB2lDdFzgCq1N/e5SDXl99XfcNIYd
        xl2FHT7769A8YVD/RQYnkRLNgTbXcMjrCDiyHhUJNLDixSzQJfVe8ZYWO4bRErow
        ==
X-ME-Sender: <xms:cUZlYJAFHOqSxDwnmsOA0a8s57EnBEMLKb1zkJMbKkSZMQ5RvonblA>
    <xme:cUZlYHjaoyP0oCg4CpUtoO0fiT1il4DSkP3YNPxDCK9Ew_V06DZCCHso2q281nWAI
    4UzQozQOep4j_956w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudeifedgjeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreerjeenucfhrhhomhepfdetnhgu
    rhgvficulfgvfhhfvghrhidfuceorghnughrvgifsegrjhdrihgurdgruheqnecuggftrf
    grthhtvghrnhepudehtddtleektedvfeeitdeljeekveelkeegvdfhtdejhefgfedtfedv
    jeejledtnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrnhgurhgvfiesrghjrdhiugdrrghu
X-ME-Proxy: <xmx:cUZlYEktDNHkVnociacTZn9o_1v1vGrEK6B-J_7z9MLkinn_-CpWhQ>
    <xmx:cUZlYDxKDkUu4S9fKlrpI2gRku7K6cE5wNap_DlMnEsc657fexkrTg>
    <xmx:cUZlYORHW_GgcOHywhUXRNVEczxo1Kj6Xqgkz1MBRmpvURTiy9mlCg>
    <xmx:c0ZlYBH6NEkHP1Z7OxOJv0bSfsi-IUy7ymsHeOje4V9oSQxSlcD2Kw>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 0A181A00073; Thu,  1 Apr 2021 00:05:04 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-273-g8500d2492d-fm-20210323.002-g8500d249
Mime-Version: 1.0
Message-Id: <d66753ee-7db2-41e5-9fe5-762b1ab678bc@www.fastmail.com>
In-Reply-To: <20210401005702.28271-4-zev@bewilderbeest.net>
References: <YGOuhjD19SmjmQou@hatter.bewilderbeest.net>
 <20210401005702.28271-1-zev@bewilderbeest.net>
 <20210401005702.28271-4-zev@bewilderbeest.net>
Date:   Thu, 01 Apr 2021 14:34:44 +1030
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     "Zev Weiss" <zev@bewilderbeest.net>,
        "Joel Stanley" <joel@jms.id.au>
Cc:     openbmc@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Lubomir Rintel" <lkundrak@v3.sk>, - <devicetree@vger.kernel.org>,
        linux-serial@vger.kernel.org
Subject: =?UTF-8?Q?Re:_[PATCH_v2_3/3]_dt-bindings:_serial:_8250:_add_aspeed,sirq-?=
 =?UTF-8?Q?active-high?=
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org



On Thu, 1 Apr 2021, at 11:27, Zev Weiss wrote:
> This provides a simpler, more direct alternative to the deprecated
> aspeed,sirq-polarity-sense property for indicating the polarity of
> the Aspeed VUART's SIRQ line.
> 
> Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
> ---
>  Documentation/devicetree/bindings/serial/8250.yaml | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/serial/8250.yaml 
> b/Documentation/devicetree/bindings/serial/8250.yaml
> index 491b9297432d..e79bb6ab9d2c 100644
> --- a/Documentation/devicetree/bindings/serial/8250.yaml
> +++ b/Documentation/devicetree/bindings/serial/8250.yaml
> @@ -12,8 +12,9 @@ maintainers:
>  allOf:
>    - $ref: /schemas/serial.yaml#
>    - if:
> -      required:
> -        - aspeed,sirq-polarity-sense
> +      anyOf:
> +        - required: [ aspeed,sirq-active-high ]

Do you think we could make use of the approach I put forward here?

https://lore.kernel.org/openbmc/20210319062752.145730-18-andrew@aj.id.au/T/#u

Andrew
