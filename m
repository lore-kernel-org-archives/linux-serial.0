From: Matthew Garrett <mjg@redhat.com>
Subject: Re: [PATCH 01/30] disallow SERIAL_8250_PNP with SERIAL_8250_CONSOLE
Date: Wed, 25 Mar 2009 15:38:58 +0000
Message-ID: <20090325153857.GA17045@srcf.ucam.org>
References: <20090324213416.GA29507@srcf.ucam.org> <20090324213841.59d6b299@lxorguk.ukuu.org.uk> <20090324214321.GA29671@srcf.ucam.org> <20090324221816.50e7ccc2@lxorguk.ukuu.org.uk> <20090324222934.GA30503@srcf.ucam.org> <20090324223632.66680ebd@lxorguk.ukuu.org.uk> <20090324225812.GA30827@srcf.ucam.org> <20090325092203.139bb144@torg> <20090325101831.1322b00f@torg> <20090325153235.1b9eaaa2@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:32939 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760258AbZCYPjI (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 25 Mar 2009 11:39:08 -0400
Content-Disposition: inline
In-Reply-To: <20090325153235.1b9eaaa2@lxorguk.ukuu.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Clark Williams <williams@redhat.com>, Andrey Panin <pazke@donpac.ru>, linux-serial@vger.kernel.org, torvalds@linux-foundation.org

On Wed, Mar 25, 2009 at 03:32:35PM +0000, Alan Cox wrote:
> 
> > I don't see this panic in the 2.6.24 series, nor do I see it in the
> > 2.6.29 series, so it seems that I only saw it in 2.6.26.  I'll keep an
> > eye out for this behavior again, but still no complaint if this patch
> > gets dropped.
> 
> I can dup it to order in 2.6.29 

It's still fixing one configuration by breaking another. There's no harm 
in maintaining the status quo.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
