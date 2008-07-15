From: Paul Fulghum <paulkf@microgate.com>
Subject: Re: Line disciplines.
Date: Tue, 15 Jul 2008 15:37:45 -0600
Message-ID: <487D18A9.20304@microgate.com>
References: <1216152625.11481.38.camel@wirenth>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from adsl-70-250-156-241.dsl.austtx.swbell.net ([70.250.156.241]:60953
	"EHLO gw.microgate.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753076AbYGOUtW (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 15 Jul 2008 16:49:22 -0400
In-Reply-To: <1216152625.11481.38.camel@wirenth>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: ian <spyro@f2s.com>
Cc: linux-serial@vger.kernel.org

ian wrote:
> Im trying to use a line discipline as a way to hook my kernel module up
> to a serial port.
> 
> I've implemented methods for open, close, and receive_buf, and
> registered the line discipline (Im using N_MOUSE as my number for now)
> 
> I've tried using stty line 2 < /dev/ttyS1 to attach my line discipline
> to a serial port (and tried this on an already open port too (using cat
> to open the port) and my methods never get called.
> 
> I've even written a little userspace program that opens  ttyS1 and uses
> tcsetattr() to select c_line=N_MOUSE.
> 
> It looks like the ldisc is being set because after this stty reports
> ttyS1 to be using '2' which is correct, however my methods are still
> never called.
> 
> What am I missing?

I suspect that since you are using an existing ldisc number
that the existing ldisc module is being loaded instead of
your module.

Do you see the init routine of your module called?
If so, what is the return value from tty_register_ldisc()?

-- 
Paul Fulghum
MicroGate Systems, Ltd.
