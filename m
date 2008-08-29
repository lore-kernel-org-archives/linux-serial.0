From: Christopher Gibson <chris@toftronix.com.au>
Subject: Re: [PATCH/RFC] 8250: Auto RS485 direction control
Date: Fri, 29 Aug 2008 22:22:14 +1000
Message-ID: <1220012534.19017.73.camel@thetriton.toftronix.com.au>
References: <002101c8f6fa$9273ab10$2e01a8c0@acksys.local>
	 <1218033008.6275.86.camel@thetriton.toftronix.com.au>
	 <200808071050.35380.laurentp@cse-semaphore.com>
	 <1218340666.9309.58.camel@thetriton.toftronix.com.au>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from toftronix.com.au ([60.241.205.236]:35030 "EHLO
	thetriton.toftronix.com.au" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750945AbYH2MVV (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 29 Aug 2008 08:21:21 -0400
In-Reply-To: <1218340666.9309.58.camel@thetriton.toftronix.com.au>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Laurent Pinchart <laurentp@cse-semaphore.com>
Cc: linux-serial@vger.kernel.org

Looks like I knocked the thread dead with my wacky octals ;)

No looks like the thread continues in
Re: [PATCH v1] 8250: add support for DTR/DSR hardware flow control

See you there.

On Sun, 2008-08-10 at 13:57 +1000, Christopher Gibson wrote:
> Oops.  Meant the code snippet to read as follows.
> (Comments have changed).
> 
> 
> #define CFLOW_EXT (08000000)
> #define CFLOW   (CLOCAL | CRTSCTS | CFLOW_EXT)
> #define CRTSADC (CFLOW_EXT)             /*RTS auto direction control*/
> #define CDTRADC (CFLOW_EXT | CLOCAL)    /*DTR auto direction control*/
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-serial" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
-- 
Christopher Gibson <chris@toftronix.com.au>

