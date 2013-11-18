From: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] tty: Only hangup once
Date: Mon, 18 Nov 2013 23:03:39 +0000
Message-ID: <20131118230339.5402fac4@alan.etchedpixels.co.uk>
References: <1375293945-4087-1-git-send-email-peter@hurleysoftware.com>
	<20131117203850.46df2124@tormoz-pc>
	<20131118134211.17861db3@alan.etchedpixels.co.uk>
	<528A5043.6030901@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:34251 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751301Ab3KRXDy (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 18 Nov 2013 18:03:54 -0500
In-Reply-To: <528A5043.6030901@hurleysoftware.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Heorhi Valakhanovich <valahanovich@tut.by>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, gregkh@linuxfoundation.org

> I doubt this is caused by a race condition; the first hangup would do most
> of the destruction regardless, and a second hangup can't really race with
> the first because of the tty_lock() held for most of the hangup.
> 
> In any event, it's worth discovering what state a subsequent hangup can
> effect that the first hangup left incomplete. I'll look into it.
> 
> Regards,
> Peter Hurley

disassociate_ctty races with tty_hangup.

tty->pgrp is only protected by ctrl_lock

See no_tty and the FIXME note. Sorry the FIXME wasn't clearer.


Alan
