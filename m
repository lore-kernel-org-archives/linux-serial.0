Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F03B2C4338F
	for <linux-serial@archiver.kernel.org>; Fri, 30 Jul 2021 05:25:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC5F260F46
	for <linux-serial@archiver.kernel.org>; Fri, 30 Jul 2021 05:25:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbhG3FZN (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 30 Jul 2021 01:25:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:36122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230108AbhG3FZM (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 30 Jul 2021 01:25:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B10D460E76;
        Fri, 30 Jul 2021 05:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1627622707;
        bh=ESVBrsm80myU8Sk+cQfy5BsOrCGZGHO54b2AzvwiXnU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YFO8hUhm8jvQf9NQ9T99JGWgOMFYceWdyhAFQz9hlUV7VnikT15uLI8MhouHYFBwt
         0NAH4rvEekcYQ9SVVWEvEcfzjZlSw8glgbL7yzWA1ehzlEv3beSz0vlKiecpBevVTQ
         OC7KeXbIyusly5xCm0zuoshl5kjQkuPNQboon7sU=
Date:   Fri, 30 Jul 2021 07:25:04 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sean Anderson <sean.anderson@seco.com>
Cc:     Peter Korsgaard <peter.korsgaard@barco.com>,
        Peter Korsgaard <peter@korsgaard.com>,
        linux-serial@vger.kernel.org,
        Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        Michal Simek <michal.simek@xilinx.com>
Subject: Re: [PATCH 5/5] tty: serial: uartlite: Prevent changing fixed
 parameters
Message-ID: <YQONMMetaYI4aLMJ@kroah.com>
References: <20210723223152.648326-1-sean.anderson@seco.com>
 <20210723223152.648326-6-sean.anderson@seco.com>
 <YQLC4L2Z3T4SuryE@kroah.com>
 <d46e0a4a-d9d4-190f-b41b-9c2b9e4748ae@seco.com>
 <YQLKB5jqx0/eFLR9@kroah.com>
 <79157167-335c-b2b3-8104-e3272226b369@seco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <79157167-335c-b2b3-8104-e3272226b369@seco.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Jul 29, 2021 at 11:43:08AM -0400, Sean Anderson wrote:
> 
> 
> On 7/29/21 11:32 AM, Greg Kroah-Hartman wrote:
> > On Thu, Jul 29, 2021 at 11:26:59AM -0400, Sean Anderson wrote:
> >>
> >>
> >> On 7/29/21 11:01 AM, Greg Kroah-Hartman wrote:
> >> > On Fri, Jul 23, 2021 at 06:31:51PM -0400, Sean Anderson wrote:
> >> > > This device does not support changing baud, parity, data bits, stop
> >> > > bits, or detecting breaks. Disable "changing" these settings to prevent
> >> > > their termios from diverging from the actual state of the uart. To inform
> >> > > users of these limitations, warn if the new termios change these
> >> > > parameters. We only do this once to avoid spamming the log. These
> >> > > warnings are inspired by those in the sifive driver.
> >> > >
> >> > > Signed-off-by: Sean Anderson <sean.anderson@seco.com>
> >> > > ---
> >> > >
> >> > >  drivers/tty/serial/uartlite.c | 52 +++++++++++++++++++++++++++++++++--
> >> > >  1 file changed, 49 insertions(+), 3 deletions(-)
> >> > >
> >> > > diff --git a/drivers/tty/serial/uartlite.c b/drivers/tty/serial/uartlite.c
> >> > > index 39c17ab206ca..0aed70039f46 100644
> >> > > --- a/drivers/tty/serial/uartlite.c
> >> > > +++ b/drivers/tty/serial/uartlite.c
> >> > > @@ -314,7 +314,54 @@ static void ulite_set_termios(struct uart_port *port, struct ktermios *termios,
> >> > >  			      struct ktermios *old)
> >> > >  {
> >> > >  	unsigned long flags;
> >> > > -	unsigned int baud;
> >> > > +	struct uartlite_data *pdata = port->private_data;
> >> > > +	tcflag_t old_cflag;
> >> > > +
> >> > > +	if (termios->c_iflag & BRKINT)
> >> > > +		dev_err_once(port->dev, "BREAK detection not supported\n");
> >> > > +	termios->c_iflag &= ~BRKINT;
> >> > > +
> >> > > +	if (termios->c_cflag & CSTOPB)
> >> > > +		dev_err_once(port->dev, "only one stop bit supported\n");
> >> > > +	termios->c_cflag &= ~CSTOPB;
> >> > > +
> >> > > +	old_cflag = termios->c_cflag;
> >> > > +	termios->c_cflag &= ~(PARENB | PARODD);
> >> > > +	if (pdata->parity == 'e')
> >> > > +		termios->c_cflag |= PARENB;
> >> > > +	else if (pdata->parity == 'o')
> >> > > +		termios->c_cflag |= PARENB | PARODD;
> >> > > +
> >> > > +	if (termios->c_cflag != old_cflag)
> >> > > +		dev_err_once(port->dev, "only '%c' parity supported\n",
> >> > > +			     pdata->parity);
> >> >
> >> > Through all of this, you are warning that nothing is supported, yet you
> >> > are continuing on as if all of this worked just fine.
> >>
> >> We don't. The idea is that we see if (e.g.) CSIZE is something the
> >> hardware can't produce, warn about it (once), and then set it to what we
> >> can support.
> >
> > So you are ignoring what the user wanted, and doing whatever you wanted.
> >
> > As you can only support one setting, why even care?  Just set it to what
> > you want and ignore userspace's requests.
> 
> That is exactly what we are doing. We set it to what we can support and
> ignore what userspace requested.

If you can only support one set of options, just set it and always fail
the tcsetattr call which will allow userspace to know it shouldn't have
tried to do that.

> > Of course that is a pain but
> > no one is going to notice kernel log messages either, right?
> 
> *shrug* Why does sifive_serial_set_termios do it?

I didn't notice it during the review process.  Doesn't mean you should
copy a bad example :)

thanks,

greg k-h
