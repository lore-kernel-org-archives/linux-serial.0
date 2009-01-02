From: Matthias Fuchs <mfuchs@ma-fu.de>
Subject: Re: [PATCH/RFC] serial: Add ioctl to enable auto rs485 mode with some Exar UARTs
Date: Fri, 2 Jan 2009 16:29:37 +0100
Message-ID: <200901021629.38459.mfuchs@ma-fu.de>
References: <200812190048.35249.mfuchs@ma-fu.de> <200812221902.27752.mfuchs@ma-fu.de> <1230038587.17555.68.camel@thetriton.toftronix.com.au>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-in-17.arcor-online.net ([151.189.21.57]:47472 "EHLO
	mail-in-17.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751141AbZABP3q (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 2 Jan 2009 10:29:46 -0500
In-Reply-To: <1230038587.17555.68.camel@thetriton.toftronix.com.au>
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Christopher Gibson <chris@toftronix.com.au>
Cc: linux-serial@vger.kernel.org, Laurent Pinchart <laurentp@cse-semaphore.com>

Hi Christopher,

I checked all your referenced threads. Here is my summary:

1) RS485 seems to be an issue for several people.
2) enabling hardware RS485 via ioct is never totally dismissed.
3) Discussion about software direction control will never end.

So I suggest not to mix hardware and software direction control
as the same issue. When the hardware supports direction control
we should implement it as ioctl. 

Even this sounds a little bit egoistic, it might bring us a little forward.

I will update my initial patch and consider Laurent's comments.

Matthias

> Recent discussions on RS485 auto direction control seem to be split over
> a number of threads.
> 
> Here are the threads that I'm aware of:
> http://marc.info/?t=121805745200001&r=1&w=2
> http://marc.info/?t=121690034200007&r=1&w=2
> http://marc.info/?t=122821576400003&r=1&w=2
> http://marc.info/?t=122822457300004&r=1&w=2
> http://marc.info/?t=122954923400001&r=1&w=2
> http://marc.info/?t=122964426200001&r=1&w=2
> http://marc.info/?t=121566595900001&r=1&w=2
> http://marc.info/?t=121805198200004&r=1&w=2
> 
