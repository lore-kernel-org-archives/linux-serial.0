From: Theodore Ts'o <tytso@mit.edu>
Subject: Re: 16550a baud_base < 9600 ???
Date: Tue, 30 Aug 2005 10:18:23 -0400
Message-ID: <20050830141823.GA25108@thunk.org>
References: <Pine.LNX.4.61.0508291501020.26828@mj.opentvnet.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from thunk.org ([69.25.196.29]:2452 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S932145AbVH3ORq (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 30 Aug 2005 10:17:46 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0508291501020.26828@mj.opentvnet.hu>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Horv?th ?kos P?ter <maxx@inf.bme.hu>
Cc: linux-serial@vger.kernel.org

On Mon, Aug 29, 2005 at 03:05:56PM +0200, Horv?th ?kos P?ter wrote:
> Hi all,
> 
> I need to use serial communication with baud rates under 9600. I tried the 
> uart 16550a linux driver, but found that setserial gives back invalid 
> argument. The cause is that serial_core.c and 8250.c explicitly disallow 
> these settings. Why?
> 
> The quick & dirty solution (simply eliminating these limit checks in 
> serial_core.c and 8250.c) does GPF. Ok :)
> 
> Is it possible now to do serial communication with a device which can only 
> 1200 baud?

You don't need to edit the serial driver to use baud rates under 9600.
The baud_base argument is not what is used to set the baud rate; it is
used to indicate the clock crystal in the serial card utilized to
calculate the baud rate divisor which is programmed into the UART
given a specific required baud rate. 

If you are using setserial to set the baud rate, you're using the
wrong tool, and you're misunderstanding what you need to do.

Use the stty command to set the baud rate on a port.

						- Ted
