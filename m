From: "David H. Lynch Jr." <dhlii@dlasys.net>
Subject: New Pseudo Serial Driver
Date: Mon, 07 May 2007 03:51:22 -0400
Message-ID: <463EDA7A.3080303@dlasys.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from 24.152.213.223.res-cmts.eph.ptd.net ([24.152.213.223]:50819
	"EHLO mx.dlasys.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754125AbXEGIPS (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 7 May 2007 04:15:18 -0400
Received: from [206.223.20.140]
	by mx.dlasys.net with esmtp (Exim 4.63 #1 (Debian))
	id 1HkxyR-0000sk-TJ
	for <linux-serial@vger.kernel.org>; Mon, 07 May 2007 03:49:35 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org


    I am responsible for the Linux BSP for all Pico computing embedded
systems.
   
    I am working to push Pico Board support into mainline through the
linuxembedded-ppc list.

    However, there are two "pseudo" serial drivers that are part of that BSP
    and they probably should go through linux-serial.

    So I have some questions.

    I beleive I need major/minor numbers for both - what is the process
for requestion that ?
   
    Neither are real UART devices.

    The first, is for the Pico "Keyhole" which is basically a
bi-directional parallel port with dual FIFO's, and a messaging
    protocol supporting multiple virtual serial channels.
    The most common use is as a serial console for Pico cards when they
are in a Linux or Windows host.
    I have done boot through bash support for the keyhole, so there is
not only a final serial driver, but early serial support
    including in the zImage wrapper.

    The 2nd, is more similar to the colinux virtual serial device, in
that there is not even real hardware associated with it.
    It is a layer over top of a much higher speed streams connection
between the Host and the Target that lets a Pico
    Target communicate serially with a host.

    The drivers are real linux serial drivers, making whatever underlies
them real serial devices as far as Linux is concerned.
   
    The are important to the Pico BSP as the norm for development on is
to host the Pico card in a laptop.

    Are these likely to be considered acceptable ?

    The hardware the drivers support does not exist anywhere but on Pico
cards,
    But the Pico BSP would be substantially less usable without them.




   


   
   
 
   

   





-- 
Dave Lynch 					  	    DLA Systems
Software Development:  				         Embedded Linux
717.627.3770 	       dhlii@dlasys.net 	  http://www.dlasys.net
fax: 1.253.369.9244 			           Cell: 1.717.587.7774
Over 25 years' experience in platforms, languages, and technologies too numerous to list.

"Any intelligent fool can make things bigger and more complex... It takes a touch of genius - and a lot of courage to move in the opposite direction."
Albert Einstein

