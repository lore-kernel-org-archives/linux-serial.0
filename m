From: Theodore Ts'o <tytso@mit.edu>
Subject: Re: UART_IIR_BUSY set for 16550A
Date: Thu, 29 May 2014 02:18:37 -0400
Message-ID: <20140529061837.GD25041@thunk.org>
References: <CAGXD9Ocoo_sUnFmd-pfU52yUQ5oPjWxAHXjvP8facuMiOSUn5w@mail.gmail.com>
 <20140525003642.GC6946@thunk.org>
 <CAGXD9Odvyd_go-x9-gR7Q7_etYPLHekDM3SKRN+PCvDHc__LHg@mail.gmail.com>
 <20140525024414.GF6946@thunk.org>
 <CAGXD9Of8-v9TJ-0uuQ3TDzo5QYhB3uA=B5kMGQkiABSzFrWDng@mail.gmail.com>
 <20140525120409.GG6946@thunk.org>
 <CAGXD9OcNT6m+HUJU=E9-DB-UwBVd1Pz_EmcQDzTwou0i7ayKQg@mail.gmail.com>
 <20140528050339.GA18258@thunk.org>
 <CAGXD9OdyXxpVZVR44N-ZKe5Nwz9EVbH_YgZncVbskRfsAq6Htw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from imap.thunk.org ([74.207.234.97]:38698 "EHLO imap.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756838AbaE2GSk (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 29 May 2014 02:18:40 -0400
Content-Disposition: inline
In-Reply-To: <CAGXD9OdyXxpVZVR44N-ZKe5Nwz9EVbH_YgZncVbskRfsAq6Htw@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Prasad Koya <prasad.koya@gmail.com>
Cc: linux-serial@vger.kernel.org, gregkh@linuxfoundation.org

On Tue, May 27, 2014 at 10:47:05PM -0700, Prasad Koya wrote:
> 
> if char received is garbage then as you hinted it must be that
> transmit ready interrupt that is not getting set. 

This was typo on my part.  What I meant to say was that it is the
"receive ready interrupt" (not transmit) getting set when it shouldn't
be.

That is, the fact that DR bit was clear was indeed correct --- the
receive FIFO really was empty, but for some reason some other part of
the UART was convinced that it should be trying to trigger a receive
interrupt, hence the value in IIR.

In that case, if you force the DR bit to be set, then you'll be
looping forever loading garbage into the tty flip buffer until it
overflows.  This is why I said you should put in a counter that only
does this workaround a limited number of times, and which point you
send a printk of the saying "Buggy Intel UART, abandon all hope", and
then submit a patch to the kernel cc'ing someone from Intel, in the
hopes that they will fix the bug....

Cheers,

						- Ted
