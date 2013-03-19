From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 4/7] n_tty: Encapsulate minimum_to_wake within N_TTY
Date: Tue, 19 Mar 2013 07:10:17 -0700
Message-ID: <20130319141017.GB24900@kroah.com>
References: <1362577105-19757-1-git-send-email-peter@hurleysoftware.com>
 <1362577105-19757-5-git-send-email-peter@hurleysoftware.com>
 <20130318231538.GA16280@kroah.com>
 <1363701429.7084.2.camel@thor.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-da0-f44.google.com ([209.85.210.44]:33107 "EHLO
	mail-da0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753448Ab3CSOI6 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 19 Mar 2013 10:08:58 -0400
Received: by mail-da0-f44.google.com with SMTP id z20so339193dae.3
        for <linux-serial@vger.kernel.org>; Tue, 19 Mar 2013 07:08:58 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1363701429.7084.2.camel@thor.lan>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Mar 19, 2013 at 09:57:09AM -0400, Peter Hurley wrote:
> On Mon, 2013-03-18 at 16:15 -0700, Greg Kroah-Hartman wrote:
> > On Wed, Mar 06, 2013 at 08:38:22AM -0500, Peter Hurley wrote:
> > > minimum_to_wake is unique to N_TTY processing, and belongs in
> > > per-ldisc data.
> > > 
> > > Add the ldisc method, ldisc_ops::fasync(), to notify line disciplines
> > > when signal-driven I/O is enabled or disabled. When enabled for N_TTY
> > > (by fcntl(F_SETFL, O_ASYNC)), blocking reader/polls will be woken
> > > for any readable input. When disabled, blocking reader/polls are not
> > > woken until the read buffer is full.
> > > 
> > > Canonical mode (L_ICANON(tty), n_tty_data::icanon) is not affected by
> > > the minimum_to_wake setting.
> > > 
> > > Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
> > 
> > For some reason, this patch doesn't apply.  Care to refresh this one,
> > and the rest in this series, and resend?
> 
> Sorry. There was probably some accidental dependency on one of the other
> patchsets of mine you did apply.
> 
> This and patch 5 now apply without error to tty-next.

Ok, but they are now long gone from my queue.  Can you please resend
what I haven't applied?

thanks,

greg k-h
