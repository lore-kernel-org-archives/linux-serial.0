Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 735FFC32793
	for <linux-serial@archiver.kernel.org>; Wed, 24 Aug 2022 10:27:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236867AbiHXK1A (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 24 Aug 2022 06:27:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236437AbiHXK0n (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 24 Aug 2022 06:26:43 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4CAEC82D2E
        for <linux-serial@vger.kernel.org>; Wed, 24 Aug 2022 03:25:28 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id ACB4092009C; Wed, 24 Aug 2022 12:25:24 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id A315C92009B;
        Wed, 24 Aug 2022 11:25:24 +0100 (BST)
Date:   Wed, 24 Aug 2022 11:25:24 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH 0/8] tty/serial: Convert ->set_termios() related callchains
 to const old ktermios
In-Reply-To: <14ce34f-d67-b0ec-753c-8285e85cc473@linux.intel.com>
Message-ID: <alpine.DEB.2.21.2208241117330.26998@angie.orcam.me.uk>
References: <20220816115739.10928-1-ilpo.jarvinen@linux.intel.com> <CAHp75VeDnT3q9kZMd0H_PXK-2pyhwke6FwOh+-5=RtubjLzsiw@mail.gmail.com> <6368fa4b-4232-9e2c-24e3-70115af88d2e@linux.intel.com> <alpine.DEB.2.21.2208202144450.36368@angie.orcam.me.uk>
 <14ce34f-d67-b0ec-753c-8285e85cc473@linux.intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, 23 Aug 2022, Ilpo Järvinen wrote:

> > My only concern is whether `tty_termios_baud_rate' 
> > can ever return 0 for `old_termios', which would of course never happen 
> > with `uart_get_baud_rate'.
> 
> dz_encode_baud_rate() disallows 0 as baud rate. I don't understand what 
> you're trying to say here.

 I asked a question in case someone knew a definite answer offhand.

> > But new code seems to me to be doing the right thing anyway.  That is if 
> > we're getting out of a hangup (which we don't currently handle with the 
> > modem lines anyway, but that's quite a different and complex matter) with 
> > an invalid baud rate, then we'll fail to encode it, then fail to encode 0, 
> > and finally resort to 9600 baud and write it back to `termios'.  So we'll 
> > get out of a hangup with a baud rate different to one requested, but that 
> > is as much as we can do in that case: we have fulfilled the request the 
> > best we could and `uart_get_baud_rate' would set the rate to 9600 baud 
> > anyway.
> 
> This I kind of agree with but given the precondition where 0 baud rate is 
> always rejected by dz_encode_baud_rate(), I don't think this scenario can 
> materialize at all?

 It was easier for me to just verify we'd do the right thing should the 
old rate ever be 0 than to prove it could not.  You don't always have to 
get to the bottom of something to know the right answer.

  Maciej
