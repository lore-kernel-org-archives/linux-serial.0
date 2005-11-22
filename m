From: Paul Fulghum <paulkf@microgate.com>
Subject: Re: PROBLEM: serial port FIONREAD from realtime thread
Date: Tue, 22 Nov 2005 13:53:31 -0600
Message-ID: <4383773B.1070404@microgate.com>
References: <43834F70.4010404@softplc.com> <43836D8C.3040307@microgate.com> <43837248.5050601@softplc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from adsl-70-250-156-241.dsl.austtx.swbell.net ([70.250.156.241]:15841
	"EHLO gw.microgate.com") by vger.kernel.org with ESMTP
	id S965158AbVKVTyG (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 22 Nov 2005 14:54:06 -0500
In-Reply-To: <43837248.5050601@softplc.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Dick Hollenbeck <dick@softplc.com>
Cc: rmk+serial@arm.linux.org.uk, linux-serial@vger.kernel.org

Dick Hollenbeck wrote:
> 1) Can you point me at the source file(s) where I can explore this 
> further? (source file the workqueue written to).

drivers/char/tty_io.c has the flip buffer code

The function tty_flip_buffer_push() is called by
the hardware driver when data has been added to
the flip buffer. This function calls flush_to_ldisc()
either directly (if low_latency is set) or indirectly
through the workqueue.

There is a problem in setting low_latency if
tty_flip_buffer_push() is called in interrupt context,
which many drivers do. You can try setting this and
seeing if your machine crashes and burns.

This code is a moving target at this time.
Alan Cox is working on bringing
a small measure of sanity to the code.

> 2) How do I determine the priority of the events kernel thread (where is 
> it created, and/or priority set).

You should be able to look at the output of
'top' or 'ps' for the 'events/0' entry.

My machine shows a priority of 10.

-- 
Paul Fulghum
Microgate Systems, Ltd.
