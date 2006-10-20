From: Peter Korsgaard <jacmet@sunsite.dk>
Subject: Re: [RFC][PATCH] Xilinx uartlite serial driver
Date: Fri, 20 Oct 2006 14:22:58 +0200
Message-ID: <87ac3ryy59.fsf@slug.be.48ers.dk>
References: <87ac9o3ak3.fsf@sleipner.barco.com>
	<878xlgercm.fsf@slug.be.48ers.dk>
	<20060912093301.77f75bfb@localhost.localdomain>
	<87ejugxqbw.fsf@slug.be.48ers.dk> <871wqfyjgi.fsf@slug.be.48ers.dk>
	<20061019180659.200d7763@pb15>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from europa.telenet-ops.be ([195.130.137.75]:5332 "EHLO
	europa.telenet-ops.be") by vger.kernel.org with ESMTP
	id S964795AbWJTMXN (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 20 Oct 2006 08:23:13 -0400
In-Reply-To: <20061019180659.200d7763@pb15> (Olof Johansson's message of "Thu,
	19 Oct 2006 18:06:59 -0500")
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Olof Johansson <olof@lixom.net>
Cc: rmk+serial@arm.linux.org.uk, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org

>>>>> "Olof" == Olof Johansson <olof@lixom.net> writes:

 >> +static int __devinit ulite_probe(struct platform_device *pdev)

 Olof> You never fill in the 'line' member here, so probing of a second
 Olof> uartlite port will fail.

Ah yes, sorry about that. I'll send a patch to Andrew.

-- 
Bye, Peter Korsgaard
