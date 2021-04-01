Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A605C433ED
	for <linux-serial@archiver.kernel.org>; Thu,  1 Apr 2021 05:19:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2289C60698
	for <linux-serial@archiver.kernel.org>; Thu,  1 Apr 2021 05:19:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232944AbhDAFS5 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 1 Apr 2021 01:18:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230291AbhDAFSy (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 1 Apr 2021 01:18:54 -0400
Received: from thorn.bewilderbeest.net (thorn.bewilderbeest.net [IPv6:2605:2700:0:5::4713:9cab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41D1AC0613E6;
        Wed, 31 Mar 2021 22:18:54 -0700 (PDT)
Received: from hatter.bewilderbeest.net (unknown [IPv6:2600:6c44:7f:ba20::7c6])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: zev)
        by thorn.bewilderbeest.net (Postfix) with ESMTPSA id EFF316F;
        Wed, 31 Mar 2021 22:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
        s=thorn; t=1617254333;
        bh=fzknu6DQH+qziW2FyNdVu9seQuTeZSZKGJbOYsjJd1Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ILgz/PYefVLlO5ToxdjPA90uL4x7NGH8HYCX4cbRw9WuUzfxcwsk/us21w/YGCTcc
         qTbDTzihV8oxLE/XzKydxbiMEFLcH3EBHawzjx1ih63tMdolMjxe7bPGKTwBWHp3G7
         d9Rp2wyzm8b6rTyOf2APU3/e8by/XqMimHs9w350=
Date:   Thu, 1 Apr 2021 00:18:51 -0500
From:   Zev Weiss <zev@bewilderbeest.net>
To:     Joel Stanley <joel@jms.id.au>
Cc:     Jeremy Kerr <jk@ozlabs.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org
Subject: Re: [PATCH v2 2/3] drivers/tty/serial/8250: add DT property for
 aspeed vuart sirq polarity
Message-ID: <YGVXuyqOyxc8kcQz@hatter.bewilderbeest.net>
References: <YGOuhjD19SmjmQou@hatter.bewilderbeest.net>
 <20210401005702.28271-1-zev@bewilderbeest.net>
 <20210401005702.28271-3-zev@bewilderbeest.net>
 <CACPK8XdPVf1WMmo8C8RJtd-1cH5qV9odEDhDUHWRiMOk=dQNtg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CACPK8XdPVf1WMmo8C8RJtd-1cH5qV9odEDhDUHWRiMOk=dQNtg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Mar 31, 2021 at 11:15:44PM CDT, Joel Stanley wrote:
>On Thu, 1 Apr 2021 at 00:57, Zev Weiss <zev@bewilderbeest.net> wrote:
>>
>> This provides a simple boolean to use instead of the deprecated
>> aspeed,sirq-polarity-sense property.
>>
>> Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
>> ---
>>  drivers/tty/serial/8250/8250_aspeed_vuart.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/tty/serial/8250/8250_aspeed_vuart.c b/drivers/tty/serial/8250/8250_aspeed_vuart.c
>> index c33e02cbde93..e5ef9f957f9a 100644
>> --- a/drivers/tty/serial/8250/8250_aspeed_vuart.c
>> +++ b/drivers/tty/serial/8250/8250_aspeed_vuart.c
>> @@ -482,6 +482,9 @@ static int aspeed_vuart_probe(struct platform_device *pdev)
>>                 of_node_put(sirq_polarity_sense_args.np);
>>         }
>>
>> +       if (of_property_read_bool(np, "aspeed,sirq-active-high"))
>> +               aspeed_vuart_set_sirq_polarity(vuart, 1);
>
>This assumes the default is always low, so we don't need a property to
>set it to that state?
>
>Would it make more sense to have the property describe if it's high or
>low? (I'm happy for the answer to be "no", as we've gotten by for the
>past few years without it).
>

Yeah, that sounds like better way to approach it -- I think I'll 
rearrange as Andrew suggested in 
https://lore.kernel.org/openbmc/d66753ee-7db2-41e5-9fe5-762b1ab678bc@www.fastmail.com/

>This brings up another point. We already have the sysfs file for
>setting the lpc address, from userspace. In OpenBMC land this can be
>set with obmc-console-client (/etc/obmc-console.conf). Should we add
>support to that application for setting the irq polarity too, and do
>away with device tree descriptions?
>

I guess I might lean slightly toward keeping the DT description so that 
if for whatever reason obmc-console-server flakes out and doesn't start 
you're better positioned to try banging on /dev/ttyS* manually if you're 
desperate.  Though I suppose that in turn might imply that I'm arguing 
for adding DT properties for lpc_address and sirq too, and if you're 
really that desperate you can just fiddle with sysfs anyway, so...shrug?  
I could be convinced either way fairly easily.


Zev

