From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 01/30] disallow SERIAL_8250_PNP with SERIAL_8250_CONSOLE
Date: Wed, 25 Mar 2009 15:32:35 +0000
Message-ID: <20090325153235.1b9eaaa2@lxorguk.ukuu.org.uk>
References: <20090324151034.GC6859@ports.donpac.ru>
	<20090324152203.6a989d06@lxorguk.ukuu.org.uk>
	<20090324205945.GA28394@srcf.ucam.org>
	<20090324212653.77d6e70c@lxorguk.ukuu.org.uk>
	<20090324213416.GA29507@srcf.ucam.org>
	<20090324213841.59d6b299@lxorguk.ukuu.org.uk>
	<20090324214321.GA29671@srcf.ucam.org>
	<20090324221816.50e7ccc2@lxorguk.ukuu.org.uk>
	<20090324222934.GA30503@srcf.ucam.org>
	<20090324223632.66680ebd@lxorguk.ukuu.org.uk>
	<20090324225812.GA30827@srcf.ucam.org>
	<20090325092203.139bb144@torg>
	<20090325101831.1322b00f@torg>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:55713 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754456AbZCYPdO (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 25 Mar 2009 11:33:14 -0400
In-Reply-To: <20090325101831.1322b00f@torg>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Clark Williams <williams@redhat.com>
Cc: Matthew Garrett <mjg@redhat.com>, Andrey Panin <pazke@donpac.ru>, linux-serial@vger.kernel.org, torvalds@linux-foundation.org


> I don't see this panic in the 2.6.24 series, nor do I see it in the
> 2.6.29 series, so it seems that I only saw it in 2.6.26.  I'll keep an
> eye out for this behavior again, but still no complaint if this patch
> gets dropped.

I can dup it to order in 2.6.29 

