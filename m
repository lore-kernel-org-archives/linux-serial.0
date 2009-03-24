From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 01/30] disallow SERIAL_8250_PNP with SERIAL_8250_CONSOLE
Date: Tue, 24 Mar 2009 21:43:21 +0000
Message-ID: <20090324214321.GA29671@srcf.ucam.org>
References: <20090324135930.12735.7827.stgit@localhost.localdomain> <20090324140145.12735.29459.stgit@localhost.localdomain> <20090324151034.GC6859@ports.donpac.ru> <20090324152203.6a989d06@lxorguk.ukuu.org.uk> <20090324205945.GA28394@srcf.ucam.org> <20090324212653.77d6e70c@lxorguk.ukuu.org.uk> <20090324213416.GA29507@srcf.ucam.org> <20090324213841.59d6b299@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:40469 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750868AbZCXVne (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 24 Mar 2009 17:43:34 -0400
Content-Disposition: inline
In-Reply-To: <20090324213841.59d6b299@lxorguk.ukuu.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andrey Panin <pazke@donpac.ru>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, torvalds@linux-foundation.org

On Tue, Mar 24, 2009 at 09:38:41PM +0000, Alan Cox wrote:
> > > Since the conversion to drivers/serial - so years.
> > 
> > So everyone using serial console with 8250_PNP enabled gets a crash on 
> > boot, and has done for years? Really?
> 
> If their console port is PnP listed yes.

So this patch breaks the case where a kernel with PNP support is booted 
on a system without PNP-listed serial ports? Do we know the ratio of 
machines fixed by this compared to the machines broken?

-- 
Matthew Garrett | mjg59@srcf.ucam.org
