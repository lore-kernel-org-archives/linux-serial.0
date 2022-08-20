Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D351C25B08
	for <linux-serial@archiver.kernel.org>; Sat, 20 Aug 2022 21:26:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232865AbiHTV0w (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 20 Aug 2022 17:26:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiHTV0w (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 20 Aug 2022 17:26:52 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 33E452A40D
        for <linux-serial@vger.kernel.org>; Sat, 20 Aug 2022 14:26:51 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 6509492009C; Sat, 20 Aug 2022 23:26:50 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 5524592009B;
        Sat, 20 Aug 2022 22:26:50 +0100 (BST)
Date:   Sat, 20 Aug 2022 22:26:50 +0100 (BST)
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
In-Reply-To: <6368fa4b-4232-9e2c-24e3-70115af88d2e@linux.intel.com>
Message-ID: <alpine.DEB.2.21.2208202144450.36368@angie.orcam.me.uk>
References: <20220816115739.10928-1-ilpo.jarvinen@linux.intel.com> <CAHp75VeDnT3q9kZMd0H_PXK-2pyhwke6FwOh+-5=RtubjLzsiw@mail.gmail.com> <6368fa4b-4232-9e2c-24e3-70115af88d2e@linux.intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, 18 Aug 2022, Ilpo Järvinen wrote:

> > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > for all, but patch 3.
> > 
> > I'm not sure we can blindly use old_termios settings, is there any
> > guarantee that old_termios _always_ has a correct baud rate settings?
> 
> Old_termios is just the previous termios the port was using. If the 
> baudrate in termios was invalid already by then, it's another issue that 
> should be fixed (but I cannot see how that could occur assuming the 
> validation works).
> 
> How could it get wrong baud rate settings if the kernel sets (old_)termios 
> (earlier) through these same paths (which validated it)?

 If the old baud rate in termios was invalid, then we would just resort to 
9600 baud, so I wouldn't be concerned here as we need to set the baud rate 
to something anyway.  My only concern is whether `tty_termios_baud_rate' 
can ever return 0 for `old_termios', which would of course never happen 
with `uart_get_baud_rate'.

 But new code seems to me to be doing the right thing anyway.  That is if 
we're getting out of a hangup (which we don't currently handle with the 
modem lines anyway, but that's quite a different and complex matter) with 
an invalid baud rate, then we'll fail to encode it, then fail to encode 0, 
and finally resort to 9600 baud and write it back to `termios'.  So we'll 
get out of a hangup with a baud rate different to one requested, but that 
is as much as we can do in that case: we have fulfilled the request the 
best we could and `uart_get_baud_rate' would set the rate to 9600 baud 
anyway.

 Given the observation above I have acked your patch.  Perhaps you could 
put some of the analysis above into the change description.

  Maciej
