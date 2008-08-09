From: Christopher Gibson <chris@toftronix.com.au>
Subject: RE: [PATCH/RFC] 8250: Auto RS485 direction control
Date: Sat, 09 Aug 2008 20:08:14 +1000
Message-ID: <1218276494.9309.14.camel@thetriton.toftronix.com.au>
References: <000601c8f7e2$1b73e9b0$2e01a8c0@acksys.local>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from toftronix.com.au ([60.241.205.236]:49586 "EHLO
	thetriton.toftronix.com.au" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750965AbYHIKJd (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 9 Aug 2008 06:09:33 -0400
Received: from localhost ([127.0.0.1] ident=chris)
	by thetriton.toftronix.com.au with esmtp (Exim 4.69)
	(envelope-from <chris@toftronix.com.au>)
	id 1KRlMs-0003H0-Pd
	for linux-serial@vger.kernel.org; Sat, 09 Aug 2008 20:08:14 +1000
In-Reply-To: <000601c8f7e2$1b73e9b0$2e01a8c0@acksys.local>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

On Wed, 2008-08-06 at 18:33 +0200, Tosoni wrote:
> 
> > -----Original Message-----
> > From: Christopher Gibson
> >
--- 8< ---
> 
> S.  (Maybe an ill
> > conceived UART is just an ART;)  Also if this is to also be useful
for
> > radio communications then it may be necessary to provide a mechanism
> > where lead in and lead out times can be specified for the control.
> >
> > As far as IOCTL names go I dislike the CRTSTOGGLE, toggling
> > the RTS line
> > is an incorrect description of function.
> 
> It is incorrect only if you introduce the timings. Please note that
Windows
> has RTS_TOGGLE, no extra timings, and nobody seems to complain.
> Wait wait... I am not saying that you are wrong. Last year I had to
write a
> (non unix) driver to handle these kinks of timings. But the case is
not
> usual.
> 

Sorry was being pedantic about naming.  When I said that CRTSTOGGLE was
an incorrect description of function, I was meaning toggle normally
means (in both electronic and mechanical systems) that something
switches between two stable states on application of a signal or force.
(Like the mechanism on the top of a pen to make the nib poke out or
retract.)  For this reason it seems wrong to me call the RTS direction
control a toggle function.

> >  I prefer CARTS as it is not an
> > incorrect description of function.  CARTS - auto request to send is
> > rather ambiguous though.  If I was to suggest a name it would
> > be RTSADC
> > - request to send auto direction control (maybe with a
> > preceding C if it
> > went into termios cflags).

--- 8< ---

On reflection I think I was getting carried away when I suggested adding
timings to the "lead in" and "lead out".  Will discuss this in greater
detail in reply to another email on this thread.

-- 
Christopher Gibson <chris@toftronix.com.au>


