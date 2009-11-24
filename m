From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] serial: 8250: Add ns16550a to OF compatible list
Date: Tue, 24 Nov 2009 10:33:27 +0000
Message-ID: <200911241033.27938.arnd@arndb.de>
References: <1259054502-28284-1-git-send-email-monstr@monstr.eu> <200911240953.52204.arnd@arndb.de> <4B0BB393.4050302@monstr.eu>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:60619 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932629AbZKXKd3 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 24 Nov 2009 05:33:29 -0500
In-Reply-To: <4B0BB393.4050302@monstr.eu>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: monstr@monstr.eu
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, grant.likely@secretlab.ca, john.williams@petalogix.com, stable@kernel.org, chrisw@sous-sol.org, greg@kroah.com, alonz@discretix.com

On Tuesday 24 November 2009 10:21:07 Michal Simek wrote:
> Arnd Bergmann wrote:
> 
> it is simple almost trivial patch but if you like I can write there some 
> background.

Already submitted again with some text
 
> > 
> > * You did not cc me. Ok, I just noticed I'm missing an entry in the MAINTAINERS
> > file, but scripts/get_maintainer.pl would have given you a good indication of
> > who feels responsible. You also didn't cc Alon, who submitted a similar patch
> > [1] just days ago, which I assume prompted you to send this. If you didn't see
> > his patch, nevermind.
> 
> you are not there. I have never used get_maintainer.pl script - will do.
> 
> I haven't seen his patch in LKML. Which subject?

see the link at the bottom of my mail, referenced through "[1]" above.
It was cross-posted on some mailing lists, but unfortunately not on lkml.

> $ ./scripts/get_maintainer.pl -f drivers/serial/8250.c
> Alan Cox <alan@linux.intel.com>
> Andrew Morton <akpm@linux-foundation.org>
> David Daney <ddaney@caviumnetworks.com>
> Tomaso Paoletti <tpaoletti@caviumnetworks.com>
> Greg Kroah-Hartman <gregkh@suse.de>
> linux-serial@vger.kernel.org
> linux-kernel@vger.kernel.org
 
wrong file: 
./scripts/get_maintainer.pl -f drivers/serial/of_serial.c
Benjamin Herrenschmidt <benh@kernel.crashing.org>
Arnd Bergmann <arnd@arndb.de>
Matthias Fuchs <mfuchs@ma-fu.de>
Dave Mitchell <dmitchell@amcc.com>
Andrew Morton <akpm@linux-foundation.org>
Grant Likely <grant.likely@secretlab.ca>
linux-kernel@vger.kernel.org
devicetree-discuss@lists.ozlabs.org

> > [1] http://www.mail-archive.com/linuxppc-dev@lists.ozlabs.org/msg39015.html
> > [2] http://lkml.indiana.edu/hypermail/linux/kernel/0504.3/1369.html

	Arnd <>< 
