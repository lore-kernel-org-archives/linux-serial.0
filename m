From: Greg KH <greg@kroah.com>
Subject: Re: [PATCHv2 1/2] amba pl011: workaround for uart registers lockup
Date: Thu, 9 Jun 2011 13:11:53 -0700
Message-ID: <20110609201153.GA12792@kroah.com>
References: <20110516172958.GA13011@kroah.com>
 <1305609617-9524-1-git-send-email-shreshthakumar.sahu@stericsson.com>
 <20110517182356.GA17703@kroah.com>
 <20110517185133.GB9105@kroah.com>
 <BANLkTik18mT-AYU=myEohquwgJ12hXZzcA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:49376 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753574Ab1FIUSu (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 9 Jun 2011 16:18:50 -0400
Content-Disposition: inline
In-Reply-To: <BANLkTik18mT-AYU=myEohquwgJ12hXZzcA@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Shreshtha Kumar SAHU <shreshthakumar.sahu@stericsson.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, rmk+kernel@arm.linux.org.uk, linus.walleij@stericsson.com, alan@linux.intel.com

On Thu, Jun 09, 2011 at 09:46:26PM +0200, Linus Walleij wrote:
> On Tue, May 17, 2011 at 8:51 PM, Greg KH <greg@kroah.com> wrote:
> 
> > Do you still want me to take this patch through the serial tree, or will
> > both be going through some ARM tree?
> 
> Hm these two patches appear to be stuck in limbo, missing the
> merge window and all.
> 
> Which is sad, because they fix real issues to us.
> 
> How do we proceed?

Resend them and I'll take them.

thanks,

greg k-h
