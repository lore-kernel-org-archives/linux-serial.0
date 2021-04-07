Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7813C433B4
	for <linux-serial@archiver.kernel.org>; Wed,  7 Apr 2021 17:55:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B15A861363
	for <linux-serial@archiver.kernel.org>; Wed,  7 Apr 2021 17:55:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236287AbhDGRzm (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 7 Apr 2021 13:55:42 -0400
Received: from thorn.bewilderbeest.net ([71.19.156.171]:35963 "EHLO
        thorn.bewilderbeest.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236222AbhDGRzm (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 7 Apr 2021 13:55:42 -0400
Received: from hatter.bewilderbeest.net (unknown [IPv6:2600:6c44:7f:ba20::7c6])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: zev)
        by thorn.bewilderbeest.net (Postfix) with ESMTPSA id BEAF986;
        Wed,  7 Apr 2021 10:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
        s=thorn; t=1617818132;
        bh=cSbxWi5s2qegCXpYeUsESGzQY5rhhAwAJw3tA8Mb22M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aHsyeYi8mUAuUSz9Ms8EjG0Mxpa2taDnyTe+z8PVOhzsZ/8p1CQcsCjGAJ9++XvQs
         iee6oJOk9FVHZzjfomi3yGxBceaNHMdSYnQIrm3r3pd7JTR6E8kt5pQjvk/W7zXAie
         wOqwzMPpW/VMxEpAp563swJpCA3up06pGRopK/Mk=
Date:   Wed, 7 Apr 2021 12:55:29 -0500
From:   Zev Weiss <zev@bewilderbeest.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Joel Stanley <joel@jms.id.au>, openbmc@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Andrew Jeffery <andrew@aj.id.au>,
        Rob Herring <robh+dt@kernel.org>,
        Lubomir Rintel <lkundrak@v3.sk>,
        - <devicetree@vger.kernel.org>, linux-serial@vger.kernel.org
Subject: Re: [PATCH v4 1/4] dt-bindings: serial: 8250: deprecate
 aspeed,sirq-polarity-sense
Message-ID: <YG3yEeIRKgTjnDxz@hatter.bewilderbeest.net>
References: <20210402182724.20848-1-zev@bewilderbeest.net>
 <20210402182724.20848-2-zev@bewilderbeest.net>
 <YG3NR4bGRjIGZhgx@kroah.com>
 <YG3kJC+6gLC6RzzQ@hatter.bewilderbeest.net>
 <YG3q9brKTC4pkQbs@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <YG3q9brKTC4pkQbs@kroah.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Apr 07, 2021 at 12:25:09PM CDT, Greg Kroah-Hartman wrote:
>On Wed, Apr 07, 2021 at 11:56:04AM -0500, Zev Weiss wrote:
>> On Wed, Apr 07, 2021 at 10:18:31AM CDT, Greg Kroah-Hartman wrote:
>> > On Fri, Apr 02, 2021 at 01:27:21PM -0500, Zev Weiss wrote:
>> > > This property ties SIRQ polarity to SCU register bits that don't
>> > > necessarily have any direct relationship to it; the only use of it
>> > > was removed in commit c82bf6e133d30e0f9172a20807814fa28aef0f67.
>> >
>> > Please write that as:
>> > 	c82bf6e133d3 ("ARM: aspeed: g5: Do not set sirq polarity")
>> >
>>
>> Ack, will do.
>>
>> > > Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
>> > > Reviewed-by: Joel Stanley <joel@jms.id.au>
>> > > ---
>> > >  Documentation/devicetree/bindings/serial/8250.yaml | 1 +
>> > >  1 file changed, 1 insertion(+)
>> >
>> > What changed from previous versions?  That always goes below the ---
>> > line.
>> >
>>
>> I included an overview of that in the cover letter (https://lore.kernel.org/openbmc/20210402182724.20848-1-zev@bewilderbeest.net/);
>> is it desirable to also have that duplicated in the individual patches in
>> the series?
>
>Any reason why you didn't include all of the relevant people and mailing
>lists in that cover letter?  I've never seen it before :)
>

Ah -- is there a good rule of thumb (or git send-email trick) for that?  
Set-union of get_maintainer.pl over all the patches in the series?  


Zev

