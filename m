From: Peter Korsgaard <jacmet@sunsite.dk>
Subject: Re: [RFC][PATCH] Xilinx uartlite serial driver
Date: Wed, 04 Oct 2006 17:45:45 +0200
Message-ID: <87d598krti.fsf@slug.be.48ers.dk>
References: <87ac9o3ak3.fsf@sleipner.barco.com>
	<878xlgercm.fsf@slug.be.48ers.dk>
	<20060912093301.77f75bfb@localhost.localdomain>
	<87ejugxqbw.fsf@slug.be.48ers.dk> <871wqfyjgi.fsf@slug.be.48ers.dk>
	<20060913100110.1e33d885@localhost.localdomain>
	<451D7ABF.1010103@dlasys.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from europa.telenet-ops.be ([195.130.137.75]:3720 "EHLO
	europa.telenet-ops.be") by vger.kernel.org with ESMTP
	id S1161250AbWJDPpx (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 4 Oct 2006 11:45:53 -0400
In-Reply-To: <451D7ABF.1010103@dlasys.net> (David H. Lynch, Jr.'s message of
	"Fri, 29 Sep 2006 15:57:51 -0400")
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: "David H. Lynch Jr." <dhlii@dlasys.net>
Cc: linux-serial@vger.kernel.org

>>>>> "David" == David H Lynch <dhlii@dlasys.net> writes:

Hi,

 David> 	You need an "early_serial_setup()" routine inside the
 David> CONFIG_SERIAL_UARTLITE_CONSOLE code.

Isn't that just for early serial support?

-- 
Bye, Peter Korsgaard
