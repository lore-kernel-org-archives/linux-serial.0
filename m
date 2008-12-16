From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: s3c24xx : TIOCM_CTS handling problem
Date: Tue, 16 Dec 2008 14:15:33 +0000
Message-ID: <20081216141533.7bcc5c9b@lxorguk.ukuu.org.uk>
References: <48D242DC.30102@parrot.com>
	<4947B065.5080405@parrot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:46107 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754544AbYLPOPW (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 16 Dec 2008 09:15:22 -0500
In-Reply-To: <4947B065.5080405@parrot.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Matthieu CASTET <matthieu.castet@parrot.com>
Cc: linux-serial@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>, linux-kernel@vger.kernel.org

> > And easy fix could be to always report TIOCM_CTS.
> > 
> Ping ?
> 
> The bug is still present on git tree and I have got no replies.

Send patches instead then ;)

If the chip can sense the CTS line then you could check on a timer event
but it might be cleaner to add the functionality needed to allow a driver
to say "always call my start_tx" method.

