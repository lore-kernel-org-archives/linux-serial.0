From: Paul Fulghum <paulkf@microgate.com>
Subject: Re: PROBLEM: serial port FIONREAD from realtime thread
Date: Tue, 22 Nov 2005 13:12:12 -0600
Message-ID: <43836D8C.3040307@microgate.com>
References: <43834F70.4010404@softplc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from adsl-70-250-156-241.dsl.austtx.swbell.net ([70.250.156.241]:32480
	"EHLO gw.microgate.com") by vger.kernel.org with ESMTP
	id S965124AbVKVTMw (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 22 Nov 2005 14:12:52 -0500
In-Reply-To: <43834F70.4010404@softplc.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Dick Hollenbeck <dick@softplc.com>
Cc: rmk+serial@arm.linux.org.uk, linux-serial@vger.kernel.org

Dick Hollenbeck wrote:
> Problem Conditions:
> 
> 1) linux 2.6.11.7, but possibly other kernels too
> 1) realtime thread
> 2) serial port open()ed *either* with NON_BLOCKING or not
> 3) ioctl( FIONREAD ) always returns zero
> ...
> What causes this?   What is the usleep() enabling?

The tty flip buffering uses a workqueue
to push received data to the line discipline.

Your polling loop at raised priority
is probably preventing the workqueue
from being processed by the events
kernel thread.

When you call usleep() your process yields
so receive data can be processed.

Have you tried (just for testing)
lowering your process priority below that
of the events kernel thread?

-- 
Paul Fulghum
Microgate Systems, Ltd.
