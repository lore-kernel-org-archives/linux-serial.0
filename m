From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: ioremap warning fix for jsm driver.
Date: Wed, 1 Jun 2011 20:32:58 +0100
Message-ID: <20110601203258.01f3249f@lxorguk.ukuu.org.uk>
References: <20110601183841.GJ21345@caffeine.csclub.uwaterloo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:47272 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757970Ab1FATbM (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 1 Jun 2011 15:31:12 -0400
In-Reply-To: <20110601183841.GJ21345@caffeine.csclub.uwaterloo.ca>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Cc: linux-serial@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, greg@kroah.com

On Wed, 1 Jun 2011 14:38:41 -0400
lsorense@csclub.uwaterloo.ca (Lennart Sorensen) wrote:

> I saw a warning about ioremap from the jsm driver on a system which
> looked like this:
> 
> resource map sanity check conflict: 0xe0200800 0xe02017ff 0xe0200800 0xe0200fff 0000:01:08.0
> 
> Turns out the warning is valid.  The jsm driver has been asking to ioremap
> 0x1000 forever, but in fact only 8 port chips have 0x1000 bytes of memory.
> 4 port chips have 0x800 and 2 port chips have 0x400 according to the
> data sheet.  It makes more sense to map the size of the region rather
> than a hard coded value.  If you happen to have the regiong legitimately
> mapped to a base addres that is not 4K aligned, ioremap complains
> otherwise.
> 
> Signed-off-by: Len Sorensen <lsorense@csclub.uwaterloo.ca>

Acked-by: Alan Cox <alan@linux.intel.com>
