From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 7/7] serial/8250: make PIO support optional
Date: Tue, 28 Jun 2011 11:05:00 +0100
Message-ID: <20110628110500.1cf60104@lxorguk.ukuu.org.uk>
References: <1309211120-2803-1-git-send-email-arnd@arndb.de>
	<1309211120-2803-8-git-send-email-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:58739 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755907Ab1F1KCg (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 28 Jun 2011 06:02:36 -0400
In-Reply-To: <1309211120-2803-8-git-send-email-arnd@arndb.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org

> This makes the PIO support in the 8250 driver completely
> conditional on CONFIG_HAS_IOPORT so we can remove the bogus
> definitions from all the places that only need them for 8250.

NAK this as last time.

We had a discussion about how to fix this properly. I even posted some
sketched out patches to show how it could be addressed

Shotgunning the code with ifdefs was not that.


Get the port methods out of the core code as was proposed.
