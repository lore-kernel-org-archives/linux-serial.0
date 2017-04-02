From: Nicolas Pitre <nicolas.pitre@linaro.org>
Subject: Re: [PATCH v2 0/5] minitty: a minimal TTY layer alternative for
 embedded systems
Date: Sun, 2 Apr 2017 17:41:10 -0400 (EDT)
Message-ID: <alpine.LFD.2.20.1704021729470.1847@knanqh.ubzr>
References: <20170401222119.25106-1-nicolas.pitre@linaro.org> <87pogur0y9.fsf@firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87pogur0y9.fsf@firstfloor.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On Sun, 2 Apr 2017, Andi Kleen wrote:

> Nicolas Pitre <nicolas.pitre@linaro.org> writes:
> >
> > Of course, making it "mini" means there are limitations to what it does:
> >
> > - This supports serial ports only. No VT's, no PTY's.
> 
> No PTYs seems like a big limitation. This means no sshd?

Again, my ultimate system target is in the sub-megabyte of RAM.  I 
really doubt you'll be able to fit an SSH server in there even if PTYs 
were supported, unless sshd (or dropbear) can be made really tiny. 
Otherwise you most probably have sufficient resources to run the regular 
TTY code.

That being said, maybe there could be a way to cheaply support PTYs. I 
just didn't investigate it.

> > But again, most small embedded systems simply don't need those things.
> 
> They don't need a (debug) way to login over the network? Hard to
> believe.

This most likely won't be via a standard shell.


Nicolas
