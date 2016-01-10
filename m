From: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: RFC: out-of-tree tty driver breakage (changing ASYNC_ bits)
Date: Sun, 10 Jan 2016 23:44:39 +0000
Message-ID: <20160110234439.4191f3f4@lxorguk.ukuu.org.uk>
References: <5692D054.7050203@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5692D054.7050203@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Linux kernel <linux-kernel@vger.kernel.org>, Greg KH <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>
List-Id: linux-serial@vger.kernel.org

On Sun, 10 Jan 2016 13:42:44 -0800
Peter Hurley <peter@hurleysoftware.com> wrote:

> The tty/serial core uses 5 bits in the tty_port.flags field to
> manage state. They are:
> 
> ASYNCB_INITIALIZED
> ASYNCB_SUSPENDED
> ASYNCB_NORMAL_ACTIVE
> - and -
> ASYNCB_CTS_FLOW
> ASYNCB_CHECK_CD
> 
> Unfortunately, updates to this field (tty_port.flags) are often
> non-atomic. Additionally, the field is visible to/modifiable by
> userspace (the first 3 bits above are not modifiable by userspace
> though). Lastly, the multi-bit ASYNC_SPD_ bitfield is in this
> tty_port.flags field as well.

ASYNC_SPD ought to just get retired, it's been obsolete and warning
people since forever 8)

Two comments:

1. Making something unsigned long doesn't magically make it atomic. You
either use atomic_foo() or you use set_bit() and friends or the compiler
sneaks up on you and does evil things. It might make it "a bit more
atomic" but it doesn't make it correct. The compiler is free to do stupid
things like turn

                x |= 1

into
		store 1 to memory
		or memory with reg (holding old x)

gcc won't afaik ever do that on any platform we support, but it's not
against the rules if its ever optimal !

2. On a lot of architectures it's going to be easier to just use set_bit()
and friends I suspect than take the cache hit of 5 unsigned longs. At the
very least re-order the struct to keep the hot stuff together.

The compiler will also play other games with your intentions. It'll defer
or even eliminate invisible writes that don't get protected by memory
barriers or forced by say function calls.

Alan
