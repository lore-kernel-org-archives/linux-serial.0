From: Matti Aarnio <matti.aarnio@zmailer.org>
Subject: Re: CONFIG_HARD_PPS ?
Date: Fri, 18 Apr 2003 01:15:07 +0300
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <20030417221507.GK29570@mea-ext.zmailer.org>
References: <1050614393.1501.14.camel@amit.metricsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.zmailer.org ([62.240.94.4]:52377 "EHLO mail.zmailer.org")
	by vger.kernel.org with ESMTP id S262642AbTDQWDN (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 17 Apr 2003 18:03:13 -0400
Received: (mea@mea-ext) by mail.zmailer.org id S258636AbTDQWPH (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 18 Apr 2003 01:15:07 +0300
Content-Disposition: inline
In-Reply-To: <1050614393.1501.14.camel@amit.metricsystems.com>
List-Id: linux-serial@vger.kernel.org
To: Amit Kucheria <akucheria@metricsystems.com>
Cc: linux-serial <linux-serial@vger.kernel.org>

On Thu, Apr 17, 2003 at 02:19:52PM -0700, Amit Kucheria wrote:
> Hi,
> 
> I have been studying the serial driver code and found the following
> chunk of code in serial.c (2.4.19):
> 
> ---------------------------------------------------------------
> #ifdef CONFIG_HARD_PPS
> 			if ((info->flags & ASYNC_HARDPPS_CD) &&
> 			    (status & UART_MSR_DCD))
> 				hardpps();
> #endif
> ---------------------------------------------------------------
> 
> There seems to be no reference to it in the current 2.4 and 2.5 kernels.
> There are some reference in the 2.2 kernels. Is this cruft left from
> previous versions?

Sort of.    That is used in externally synchronized time-master-keeper
code, where a "1 pulse per second" line from (these days) GPS receiver
is fed to serial port DCD input pin.

It is indeed pity that the full code-set isn't included in kernel
baseline.  More people could then use Linux as their NTP master.

> Regards,
> Amit
> Amit Kucheria          akucheria@NOSPAMmetricsystems.com
> Metric Systems Corp.   2320 Cousteau Court, Suite 201, Vista, CA 92083

/Matti Aarnio
