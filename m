From: Christopher Gibson <chris@toftronix.com.au>
Subject: Re: [PATCH/RFC] 8250: Auto RS485 direction control
Date: Sun, 10 Aug 2008 13:57:46 +1000
Message-ID: <1218340666.9309.58.camel@thetriton.toftronix.com.au>
References: <002101c8f6fa$9273ab10$2e01a8c0@acksys.local>
	 <1218033008.6275.86.camel@thetriton.toftronix.com.au>
	 <200808071050.35380.laurentp@cse-semaphore.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from toftronix.com.au ([60.241.205.236]:53995 "EHLO
	thetriton.toftronix.com.au" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753246AbYHJD66 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 9 Aug 2008 23:58:58 -0400
In-Reply-To: <200808071050.35380.laurentp@cse-semaphore.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Laurent Pinchart <laurentp@cse-semaphore.com>
Cc: linux-serial@vger.kernel.org

Oops.  Meant the code snippet to read as follows.
(Comments have changed).


#define CFLOW_EXT (08000000)
#define CFLOW   (CLOCAL | CRTSCTS | CFLOW_EXT)
#define CRTSADC (CFLOW_EXT)             /*RTS auto direction control*/
#define CDTRADC (CFLOW_EXT | CLOCAL)    /*DTR auto direction control*/


