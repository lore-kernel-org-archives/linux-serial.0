From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 1/2] amba pl011: workaround for uart registers lockup
Date: Thu, 16 Jun 2011 08:16:28 -0700
Message-ID: <20110616151628.GA30881@kroah.com>
References: <1307952693-25232-1-git-send-email-linus.walleij@stericsson.com>
 <BANLkTikSEVCGGsjF_fTCNZsmjvGoic5u=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:37629 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756101Ab1FPPS3 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 16 Jun 2011 11:18:29 -0400
Content-Disposition: inline
In-Reply-To: <BANLkTikSEVCGGsjF_fTCNZsmjvGoic5u=Q@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, Shreshtha Kumar Sahu <shreshthakumar.sahu@stericsson.com>

On Thu, Jun 16, 2011 at 10:17:51AM +0200, Linus Walleij wrote:
> On Mon, Jun 13, 2011 at 10:11 AM, Linus Walleij
> <linus.walleij@stericsson.com> wrote:
> 
> > From: Shreshtha Kumar Sahu <shreshthakumar.sahu@stericsson.com>
> >
> > This workaround aims to break the deadlock situation
> > which raises during continuous transfer of data for long
> > duration over uart with hardware flow control. It is
> > observed that CTS interrupt cannot be cleared in uart
> > interrupt register (ICR). Hence further transfer over
> > uart gets blocked.
> 
> Ping on this, Greg have you picked these two for the tty next tree?

They are in my "to-apply" queue, and not lost, but been busy with "real
work" lately, so have been slow to get to them, sorry.

greg k-h
