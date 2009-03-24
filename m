From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 01/30] disallow SERIAL_8250_PNP with SERIAL_8250_CONSOLE
Date: Tue, 24 Mar 2009 21:26:53 +0000
Message-ID: <20090324212653.77d6e70c@lxorguk.ukuu.org.uk>
References: <20090324135930.12735.7827.stgit@localhost.localdomain>
	<20090324140145.12735.29459.stgit@localhost.localdomain>
	<20090324151034.GC6859@ports.donpac.ru>
	<20090324152203.6a989d06@lxorguk.ukuu.org.uk>
	<20090324205945.GA28394@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:46168 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752232AbZCXV1u (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 24 Mar 2009 17:27:50 -0400
In-Reply-To: <20090324205945.GA28394@srcf.ucam.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Andrey Panin <pazke@donpac.ru>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, torvalds@linux-foundation.org

On Tue, 24 Mar 2009 20:59:47 +0000
Matthew Garrett <mjg59@srcf.ucam.org> wrote:

> On Tue, Mar 24, 2009 at 03:22:03PM +0000, Alan Cox wrote:
> > > This patch looks very controversial from my POV. Now distro people must decide
> > > what to enable SERIAL_8250_PNP or SERIAL_8250_CONSOLE. And no matter what you 
> > 
> > They do already, otherwise your machine crashes at boot.
> 
> We don't. The effect of this patch would be to silently disable 8250_PNP 
> (since we don't build with CONFIG_EMBEDDED) and cause a surprising 
> reduction in hardware support. How long has this been broken for?

Since the conversion to drivers/serial - so years.

Alan
