From: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH tty-next 5/7] n_tty: Refactor input_available_p() by
 call site
Date: Sun, 24 Nov 2013 16:18:58 +0000
Message-ID: <20131124161858.626cc9b2@alan.etchedpixels.co.uk>
References: <1385135965-4235-1-git-send-email-peter@hurleysoftware.com>
	<1385135965-4235-6-git-send-email-peter@hurleysoftware.com>
	<20131124002650.74902872@alan.etchedpixels.co.uk>
	<52915E14.7000703@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:41533 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751343Ab3KXQTO (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 24 Nov 2013 11:19:14 -0500
In-Reply-To: <52915E14.7000703@hurleysoftware.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org

On Sat, 23 Nov 2013 21:01:56 -0500
Peter Hurley <peter@hurleysoftware.com> wrote:

> On 11/23/2013 07:26 PM, One Thousand Gnomes wrote:
> > On Fri, 22 Nov 2013 10:59:23 -0500
> > Peter Hurley <peter@hurleysoftware.com> wrote:
> >
> >> Distinguish if caller is n_tty_poll() or n_tty_read(), and
> >> set the read/wakeup threshold accordingly.
> >>
> >> Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
> >
> > Doh ignore previous.. yes that patch is right.  I should pay attention to
> > 0/7 8)
> 
> Maybe I should add more to the commit message from the cover letter
> description ?

Maybe I should just read the code more carefully 8).

Alan
