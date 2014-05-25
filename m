From: Theodore Ts'o <tytso@mit.edu>
Subject: Re: UART_IIR_BUSY set for 16550A
Date: Sat, 24 May 2014 20:36:42 -0400
Message-ID: <20140525003642.GC6946@thunk.org>
References: <CAGXD9Ocoo_sUnFmd-pfU52yUQ5oPjWxAHXjvP8facuMiOSUn5w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from imap.thunk.org ([74.207.234.97]:59466 "EHLO imap.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751311AbaEYAgp (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Sat, 24 May 2014 20:36:45 -0400
Content-Disposition: inline
In-Reply-To: <CAGXD9Ocoo_sUnFmd-pfU52yUQ5oPjWxAHXjvP8facuMiOSUn5w@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Prasad Koya <prasad.koya@gmail.com>
Cc: linux-serial@vger.kernel.org, gregkh@linuxfoundation.org

On Fri, May 23, 2014 at 10:08:49AM -0700, Prasad Koya wrote:
> 
> I don't see anyone in kernel using UART_IIR_BUSY bit except Designware
> serial driver. We are using 8250 driver for our 16550A and
> occasionally we see UART_IIR_BUSY set and soon after that console is
> hosed. In what situations is this bit set? I don't see much
> documentation for this.

UART_IIR_BUSY is not a bit, it's a magic bit pattern, which is I
believe a Designware-specific hack.  As far as standard
8250-compatible UART's are concerned, if the low bit (bit 0) is set in
the IIR register, there are no interrupts pending, and so you
shouldn't need to check the 0x06 bits (i.e., bits 1 and 2).

	       	  	    	      - Ted
