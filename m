From: Grant Edwards <grante@visi.com>
Subject: Re: [PATCH/RFC] 8250: Auto RS485 direction control
Date: Thu, 7 Aug 2008 13:50:28 +0000 (UTC)
Message-ID: <g7euj4$db9$1@ger.gmane.org>
References: <002101c8f6fa$9273ab10$2e01a8c0@acksys.local>
 <1218033008.6275.86.camel@thetriton.toftronix.com.au>
 <200808071050.35380.laurentp@cse-semaphore.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:38606 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752231AbYHGNui (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 7 Aug 2008 09:50:38 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KR5sx-0005ME-V6
	for linux-serial@vger.kernel.org; Thu, 07 Aug 2008 13:50:35 +0000
Received: from 65.111.170.175 ([65.111.170.175])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Thu, 07 Aug 2008 13:50:35 +0000
Received: from grante by 65.111.170.175 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Thu, 07 Aug 2008 13:50:35 +0000
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

On 2008-08-07, Laurent Pinchart <laurentp@cse-semaphore.com> wrote:

>> From what I can gather through the man pages it seems inappropriate to
>> add this to termios cflag, though the CRTSCTS flag does set a precedent.
>> I'm an advocate of the idea of introducing a new IOCTL for setting up
>> non standard hand-shaking settings.  I would suggest that things that
>> should be considered in the interface are settings for lead-in and
>> lead-out timing on the direction line (for the use of radio modems for
>> example) and means to specify if it's appropriate to have the CPU spin
>> on the shift register empty flag on the last byte of a block, if RTS
>> timing really is that critical.
>
> I don't think we want to introduce software emulation, but
> feel free to prove me wrong.

I think that should be left up to the author of the driver.  It
seems to me that it would be pretty difficult to do a decent
job of it at the line-discipline layer.  If the author of the
driver for a particular UART wants to do SW emulation of
auto-RTS, then I think that's where it belongs.  Only the UART
driver knows whether there's a shift-register empty interrupt
(and whether that interrupt happens before or after that final
stop bit has been transmitted).

-- 
Grant Edwards                   grante             Yow! I KAISER ROLL?!
                                  at               What good is a Kaiser Roll
                               visi.com            without a little COLE SLAW
                                                   on the SIDE?

