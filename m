From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: tty_reopen() returning -EIO because port is closing
Date: Sun, 20 Jan 2013 16:52:16 +0000
Message-ID: <20130120165216.261809b5@pyramind.ukuu.org.uk>
References: <kdcefu$dbc$1@ger.gmane.org>
	<20130118215258.263e7c2a@pyramind.ukuu.org.uk>
	<kdch1t$4p0$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:59334 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752309Ab3ATQp3 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 20 Jan 2013 11:45:29 -0500
In-Reply-To: <kdch1t$4p0$1@ger.gmane.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Grant Edwards <grant.b.edwards@gmail.com>
Cc: linux-serial@vger.kernel.org

> If my driver now behaves the same as the "standard" driver where it
> didn't used to, I'm going to claim it's an improvement.

And given any fix for that behaviour in future would be in the generic
shared code it also means you'll automatically pick it up. That's one of
the big reasons for the tty_port code - to kill the hundreds of
replicated differently buggy open implementations we had in drivers

Alan
 
