From: Grant Edwards <grante@visi.com>
Subject: Re: Suggested patch for linux
Date: Fri, 18 Jul 2008 13:55:38 +0000 (UTC)
Message-ID: <g5q7cp$o4j$1@ger.gmane.org>
References: <487546D5.8050908@freesurf.ch>
 <20080710095904.16dfdb08@the-village.bc.nu>
 <487619C8.7080509@commtech-fastcom.com>
 <200807181219.54170.laurentp@cse-semaphore.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:37518 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753706AbYGRNzx (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 18 Jul 2008 09:55:53 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KJqR1-0007R7-UJ
	for linux-serial@vger.kernel.org; Fri, 18 Jul 2008 13:55:48 +0000
Received: from 65.111.170.175 ([65.111.170.175])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Fri, 18 Jul 2008 13:55:47 +0000
Received: from grante by 65.111.170.175 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Fri, 18 Jul 2008 13:55:47 +0000
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: linux-usb@vger.kernel.org

On 2008-07-18, Laurent Pinchart <laurentp@cse-semaphore.com> wrote:

>> I believe that he is referring to something much simpler than
>> you are thinking.  He is talking about 2-wire RS485
>> transmissions in which the RTS signal is used to enable the
>> driver chips just before transmitting data and disabling
>> (tri-stating) them just after transmitting data.  There are
>> some UARTs that have this behavior built into them.
>
> And that feature is currently not supported by Linux, even
> with UARTs that have hardware support for "Auto RS485" mode,
> such as the 8250-compatible XR16C2850.
>
> The issue is that no flag is defined for the c_cflag field of
> the termios structure to enable that feature. The following
> patch is an example of what would be required.

I'd definitely be in favor of such a flag. It sucks having to
resort to various hacks to control support of that feature in
Linux serial drivers.

-- 
Grant Edwards                   grante             Yow! In Newark the
                                  at               laundromats are open 24
                               visi.com            hours a day!

