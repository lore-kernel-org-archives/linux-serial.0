From: Lee Howard <faxguy@howardsilvan.com>
Subject: Re: serial flow control appears broken
Date: Fri, 27 Jul 2007 11:00:37 -0700
Message-ID: <46AA32C5.9080705@howardsilvan.com>
References: <46A7FE6A.4030309@howardsilvan.com>	<20070726123420.GA14163@informatik.uni-freiburg.de>	<46A8CB96.1010501@howardsilvan.com>	<20070726174150.4ffcabd4@the-village.bc.nu>	<46A98DFE.3050304@howardsilvan.com> <20070727125655.6a71ab77@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from gateway.howardsilvan.com ([64.146.212.27]:42721 "EHLO
	mail.howardsilvan.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752410AbXG0SBw (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 27 Jul 2007 14:01:52 -0400
In-Reply-To: <20070727125655.6a71ab77@the-village.bc.nu>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: =?ISO-8859-1?Q?Uwe_Kleine-K=F6nig?= <ukleinek@informatik.uni-freiburg.de>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org

Alan Cox wrote:

>As the flow control is driven by software on most 16x50 chips (there are
>a couple of exceptions) if we fail to empty the fifo fast enough then any
>flow control will be asserted too late to save the day.
>
>If you stop the application and do the following
>
>	cat /dev/ttywhatever
>	^Z
>	[stopped]
>
>(so you are asking the OS to buffer data but not ever reading it)
>
>and then fire data at it does the flow control eventually occur ?
>

Yes it does appear to.  I told the application to simply sleep(300) at 
the appropriate moment, and I watched the application and when it began 
the sleep I ran:

  cat /dev/ttyS1
  (lots of "garbage" began spewing forth)
  ^Z
  (about 2 or 3 seconds and the RTS light goes dark)

Thanks,

Lee.

