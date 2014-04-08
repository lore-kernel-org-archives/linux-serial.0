From: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: post 3.14 serial regression
Date: Tue, 8 Apr 2014 12:27:26 +0100
Message-ID: <20140408122726.227f3da8@alan.etchedpixels.co.uk>
References: <5343416F.8010201@sr71.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:35733 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756216AbaDHL2Z (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 8 Apr 2014 07:28:25 -0400
In-Reply-To: <5343416F.8010201@sr71.net>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Dave Hansen <dave@sr71.net>
Cc: Geert Uytterhoeven <geert+renesas@linux-m68k.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, LKML <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org, jslaby@suse.cz

> At the end, you can see that init is somehow dying.  If I revert this
> patch, init is happy again and doesn't die, and the serial console works
> like before.

Can you check if init is getting a SIGHUP - possibly its opening the
device and when it goes away gets a hangup which it isn't catching ?

Alan
