From: list@feamane.org
Subject: Stallion ONboard multiport serial card on 2.4 without devfs?
Date: Thu, 31 Aug 2006 01:52:01 -0500
Message-ID: <OF432470F5.F29643FB-ON862571DB.0023DE27@feamane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from h-72-245-221-18.chcgilgm.covad.net ([72.245.221.18]:14536 "EHLO
	sun1.feamane.org") by vger.kernel.org with ESMTP id S1750824AbWHaGwD
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 31 Aug 2006 02:52:03 -0400
Received: from library.feamane.org ([192.168.0.42])
	by sun1.feamane.org with esmtp (Exim 4.50 #1 (Debian))
	id 1GIgPB-0000CM-8L
	for <linux-serial@vger.kernel.org>; Thu, 31 Aug 2006 01:52:01 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

Hi,

I've been trying to figure this out for several weeks with no luck.  I 
changed over from Redhat with 2.2 kernel to Sarge with 2.4.  But my 
hardware includes a Stallion ONboard ISA card.  This worked fine before, 
but now I get:

devfs_register(cue): could not append to parent, err: -17

...when I try to load the istallion.o module.

If I've done my homework well the difference seems to be that the new 
istallion.o uses devfs, while the old one used /dev/cuaE* & ttyS* files. I 
don't have devfs installed on my system, and it seems too complicated to 
install just to get this one driver to work (plus it's going away anyway).

I'd much rather get a istallion.o or .c that works with 2.4 without devfs. 
 I tried to compile the old istallion.c with the kernel-source for Sarge, 
but no surprise that didn't work.  Not a coder so hacking the istallion.c 
and .h that comes with the kernel-source is way over my head.

I've been searching like crazy, is there someplace I can look in hopes of 
finding the istallion driver for 2.4 that just uses the old /dev 
devices???  The company that bought Stallion doesn't support it anymore, 
but somebody out there has been updating the driver for newer kernels -- 
I've seen the names James Nelson, Herbert Xu, and Adrian Bunk associated 
with this but I don't know if they are the right people anymore.

Any point in the right direction would be greatly appreciated.

Regards,
DJ
