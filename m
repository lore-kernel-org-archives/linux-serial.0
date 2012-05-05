From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] usb: cp210x: Added support for GPIO (CP2103/4/5)
Date: Sat, 5 May 2012 12:01:37 +0100
Message-ID: <20120505120137.11a45c86@pyramind.ukuu.org.uk>
References: <1335817637-2862-1-git-send-email-preston.fick@silabs.com>
	<20120503213456.77c55c51@pyramind.ukuu.org.uk>
	<20120505003208.GA30718@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:59958 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754491Ab2EEK6y (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 5 May 2012 06:58:54 -0400
In-Reply-To: <20120505003208.GA30718@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Preston Fick <pffick@gmail.com>, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, preston.fick@silabs.com, "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>

> Will the new ldisc mess with the tty stuff to prevent "normal" serial
> data and line settings from being handled properly?  If not, that all
> looks very good to me, thanks for working this out.

It'll have no effect on that. What it will do is provide a way for things
like ISO7816 ldiscs to use the extra pins (as they can call from the
ldisc into the gpio layer) and to know the mapping of the extra control
wires, which varies by device.

Alan
