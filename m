From: "Maciej W. Rozycki" <macro@linux-mips.org>
Subject: Re: earlycon: no match?
Date: Thu, 7 May 2015 18:09:25 +0100 (BST)
Message-ID: <alpine.LFD.2.11.1505071749370.1538@eddie.linux-mips.org>
References: <20150503211054.GR15254@pengutronix.de> <55477BC1.6000805@hurleysoftware.com> <20150504194229.GR15254@pengutronix.de> <5547D4DB.8060300@hurleysoftware.com> <20150504205241.GT15254@pengutronix.de> <5547E447.9020604@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5547E447.9020604@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Robert Schwebel <r.schwebel@pengutronix.de>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@pengutronix.de
List-Id: linux-serial@vger.kernel.org

On Mon, 4 May 2015, Peter Hurley wrote:

> >> Since 2007, 'console=' is a early param synonym for 'earlycon='; IOW,
> >> the message is new but not the behavior.
> > 
> > "console=" had nothing to do with early param before.
> 
> *Yes, it has* since the commit I referenced in the previous email and
> the email before that when I noted that 'console=' and 'earlycon=' are
> synonyms if CONFIG_SERIAL_EARLYCON=y, and it has been that way since
> 2007.
> 
> The only thing that has changed is that I added a diagnostic; _to repeat_,
> the earlycon matching code has always run in this case, only the
> diagnostic is new.

 What's the point of having two parameters as synonyms whose syntax is not 
compatible to each other in the general case?  I'd expect the following 
cases to be handled:

1. Regular console only (no early console requested) => `console=foo...'.

2. Both early and regular console => `earlycon=blah... console=foo...'.

3. Early console handing over to regular console => `earlycon=blah...'.

Why do you want to support `console=blah...' too (a question to be asked 
back in 2007, but better late than never)?

 If you do need to support such aliasing, then I suggest that you complain 
about no early console match only if `earlycon=blah...' has been truly 
used and avoid the warning where `console=blah...' has been used instead 
(a warning about the latter can be issued where no regular console match 
happened).

  Maciej
