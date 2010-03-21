From: christian pellegrin <chripell@fsfe.org>
Subject: Re: [PATCH 1/3] max3100: added raise_threaded_irq
Date: Sun, 21 Mar 2010 08:31:39 +0100
Message-ID: <cabda6421003210031k65e9d195u90fc99888ca7633c@mail.gmail.com>
References: <cabda6421003190139h344bc172h3556fca78e4b25cb@mail.gmail.com>
	 <1268987934-22690-1-git-send-email-chripell@fsfe.org>
	 <fa686aa41003191048s5c4c85ablc4588725a3d615ad@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.159]:50181 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751201Ab0CUHbl (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 21 Mar 2010 03:31:41 -0400
In-Reply-To: <fa686aa41003191048s5c4c85ablc4588725a3d615ad@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: feng.tang@intel.com, akpm@linux-foundation.org, greg@kroah.com, david-b@pacbell.net, alan@lxorguk.ukuu.org.uk, spi-devel-general@lists.sourceforge.net, linux-serial@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Hi,


On Fri, Mar 19, 2010 at 6:48 PM, Grant Likely <grant.likely@secretlab.ca> wrote:

> You should cc: Thomas and Ingo and lkml (which I just did) on patches
> to the threaded interrupt code.
>

ok, let me explain the reason for this function. The move from
worqueues to the threaded interrupts was motivated by a reduction of
latency in answering to RX buffer full interrupts. Threaded interrupts
are SCHED_FIFO instead worqueues being SCHED_OTHER. In the case of
MAX31x0 when we transmit a character we could have to receive one
(this is efficient because SPI transfers are quite always
bidirectional). The same routine is used both for tx and rx (an other
things like changing parameters): this makes locking really simple.
With this routine the thread interrupt handler could be the only kind
of deferred work a driver for a simple hardware may ever need.

-- 
Christian Pellegrin, see http://www.evolware.org/chri/
"Real Programmers don't play tennis, or any other sport which requires
you to change clothes. Mountain climbing is OK, and Real Programmers
wear their climbing boots to work in case a mountain should suddenly
spring up in the middle of the computer room."
