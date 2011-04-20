From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] tty/serial: add support for Xilinx PS UART
Date: Wed, 20 Apr 2011 10:39:28 +0100
Message-ID: <20110420103928.4049573f@lxorguk.ukuu.org.uk>
References: <e35578a9-909d-4594-bbe4-41d89b5f9b3e@VA3EHSMHS014.ehs.local>
	<20110419221530.7370d013@lxorguk.ukuu.org.uk>
	<8d05c32c-9ff1-4eda-9563-6857ede6541a@VA3EHSMHS020.ehs.local>
	<20110419232141.GA27491@kroah.com>
	<68925dd6-03b8-48af-9f96-0a3f611712e1@VA3EHSMHS020.ehs.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:49901 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751388Ab1DTJic (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 20 Apr 2011 05:38:32 -0400
In-Reply-To: <68925dd6-03b8-48af-9f96-0a3f611712e1@VA3EHSMHS020.ehs.local>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: John Linn <John.Linn@xilinx.com>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org

> Reading up on it a bit as I'm not an expert on it (like you). 
> It's not clear to me what the device driver uses for it's major/minor in
> this case.  

If you don't specify then the kernel picks one. udev can then create the
right /dev/ttyPS1/2/3 nodes itself. If you have devtmpfs enabled then
devtmpfs is a virtual file system which will just have the nodes in at as
specified by the drivers. It eliminates all the hard work maintaining
device nodes/ranges in user space.

> The only reason we didn't just use ttyS0 was that it's not a 8250 really

If you'd attempted to use ttyS0 you would indeed have been told to change
it
> and
> since we have are an FPGA people can add real 8250s in soft logic and
> then
> the system would get confusing.

and that's exactly why !

Alan
