From: Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH] 8250: option 'force_polling' for buggy IRQs
Date: Thu, 28 Jul 2016 12:01:45 -0400
Message-ID: <20160728160145.GB27400@thunk.org>
References: <1469468175-15704-1-git-send-email-mstaudt@suse.de>
 <20160725174712.GA5752@kroah.com>
 <b7ed014e-c6be-01ab-d601-08830d72f8cb@suse.de>
 <20160726150856.GA15676@kroah.com>
 <b383129f-b20b-32e3-41d1-e2c4a68665a2@suse.de>
 <20160727130923.4c20524b@lxorguk.ukuu.org.uk>
 <2b140616-c210-e754-a854-cd6a5675277d@suse.de>
 <20160727133348.GB20032@thunk.org>
 <f02610c6-5607-9fdf-23af-5b05d604f473@suse.de>
 <20160728144704.GA12984@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160728144704.GA12984@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Max Staudt <mstaudt@suse.de>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Thu, Jul 28, 2016 at 07:47:04AM -0700, Greg KH wrote:
> > I agree, and I thought about it, but since this is meant for a very limited
> > audience, I think a catch-all is the easiest solution - both in terms of
> > implementation as well as ease of use.
> > 
> > It's not meant for general consumption anyway.
> 
> Then I really don't want to have to maintain and support such a kernel
> option for 20+ years, just because of one broken system out there like
> this.  There are workarounds for this, as you have seen, including
> booting with a "real" userspace, so I don't want to take this patch.

One way to make this a bit more general purpose would be too add a way
to configure ttyS0 completely --- e.g., being able to specify the
port, irq, uart type, flags, etc.  It still wouldn't be needed except
for very rarely (since either serial ports use self-configuring buses
--- e.g., USB, PCI, etc.) or they use the legacy x86 ports.

So perhaps Greg might be more willing to take that kind of change, but
even then, it could be argued that the maintaining such a kernel
option for just a few non-standard or broken systems is still not
worth it, but it would at least be somewhat more general purpose.

						- Ted
