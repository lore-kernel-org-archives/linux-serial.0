From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 01/30] disallow SERIAL_8250_PNP with SERIAL_8250_CONSOLE
Date: Tue, 24 Mar 2009 21:38:41 +0000
Message-ID: <20090324213841.59d6b299@lxorguk.ukuu.org.uk>
References: <20090324135930.12735.7827.stgit@localhost.localdomain>
	<20090324140145.12735.29459.stgit@localhost.localdomain>
	<20090324151034.GC6859@ports.donpac.ru>
	<20090324152203.6a989d06@lxorguk.ukuu.org.uk>
	<20090324205945.GA28394@srcf.ucam.org>
	<20090324212653.77d6e70c@lxorguk.ukuu.org.uk>
	<20090324213416.GA29507@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:33033 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751706AbZCXVjS (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 24 Mar 2009 17:39:18 -0400
In-Reply-To: <20090324213416.GA29507@srcf.ucam.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Andrey Panin <pazke@donpac.ru>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, torvalds@linux-foundation.org

> > Since the conversion to drivers/serial - so years.
> 
> So everyone using serial console with 8250_PNP enabled gets a crash on 
> boot, and has done for years? Really?

If their console port is PnP listed yes.

