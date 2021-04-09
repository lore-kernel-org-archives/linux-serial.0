Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0623AC433ED
	for <linux-serial@archiver.kernel.org>; Fri,  9 Apr 2021 07:38:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBD8B61168
	for <linux-serial@archiver.kernel.org>; Fri,  9 Apr 2021 07:38:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbhDIHiz (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 9 Apr 2021 03:38:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbhDIHiy (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 9 Apr 2021 03:38:54 -0400
Received: from thorn.bewilderbeest.net (thorn.bewilderbeest.net [IPv6:2605:2700:0:5::4713:9cab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC888C061760;
        Fri,  9 Apr 2021 00:38:41 -0700 (PDT)
Received: from hatter.bewilderbeest.net (unknown [IPv6:2600:6c44:7f:ba20::7c6])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: zev)
        by thorn.bewilderbeest.net (Postfix) with ESMTPSA id 8142986;
        Fri,  9 Apr 2021 00:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
        s=thorn; t=1617953921;
        bh=B4QetOyO+uFZyq4PpiAKXG68c6M2ubQg27N5PfhAomQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WtrW6uKLJrOMTd0j58ovYOAM7amEbDjdunQFF1e7IfmoolkUoPLKI3iZLlUEUFwRn
         BqSxhw4iQWian4v4xB7TGHnv/jZsv/5C0hIGDe+izir8HQ8UQRt4EY8xk37/YKtnSS
         n2iHoBLauDsjJIUTZMXiwgB6PBYsw4MHHj5nNZXg=
Date:   Fri, 9 Apr 2021 02:38:38 -0500
From:   Zev Weiss <zev@bewilderbeest.net>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Joel Stanley <joel@jms.id.au>,
        "openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
Subject: Re: [PATCH v5 2/4] drivers/tty/serial/8250: refactor sirq and lpc
 address setting code
Message-ID: <YHAEfn4li6F8L9JC@hatter.bewilderbeest.net>
References: <20210408011637.5361-1-zev@bewilderbeest.net>
 <20210408011637.5361-3-zev@bewilderbeest.net>
 <CAHp75Vd6kk0E-kALEGOhsg=YHKhmKLY6cpCTdviOFenO4p1-2A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75Vd6kk0E-kALEGOhsg=YHKhmKLY6cpCTdviOFenO4p1-2A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Apr 09, 2021 at 02:24:08AM CDT, Andy Shevchenko wrote:
>On Thursday, April 8, 2021, Zev Weiss <zev@bewilderbeest.net> wrote:
>
>> This splits dedicated aspeed_vuart_set_{sirq,lpc_address}() functions
>> out of the sysfs store functions in preparation for adding DT
>> properties that will be poking the same registers.  While we're at it,
>> these functions now provide some basic bounds-checking on their
>> arguments.
>>
>>
>
>Please, use prefix “serial: 8250_aspeed_vuart:” instead of what you have in
>the subject line. I think I have told this already
>
>

Ah, sorry -- I fixed the cover letter after your first comment (which 
had definitely been under-tagged); for the patches themselves I was 
following the example of the last patch in that particular area 
(8d310c9107a2), though I guess that wasn't the right model to follow.  
I'll use the requested format in the future.


