From: Greg KH <gregkh@suse.de>
Subject: Re: [GIT PATCH] TTY/serial driver patches for 3.2
Date: Wed, 26 Oct 2011 15:34:38 +0200
Message-ID: <20111026133438.GA26336@suse.de>
References: <20111026114236.GA22180@kroah.com>
 <CA+55aFycM+nHxJNnFSjEXQvZkeBfHu161ePC0=7sWKZR1toQNA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CA+55aFycM+nHxJNnFSjEXQvZkeBfHu161ePC0=7sWKZR1toQNA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Wed, Oct 26, 2011 at 03:18:21PM +0200, Linus Torvalds wrote:
> On Wed, Oct 26, 2011 at 1:42 PM, Greg KH <gregkh@suse.de> wrote:
> >
> > The one in 8250_pci.c is trivial to fix, the atmel_serial one isn't=
 as
> > easy, but I'm sure you can figure it out :) =A0If you want me to do=
 the
> > merge for it, I'll be glad to do so, just let me know.
>=20
> So I figured it out, but please double-check, especially since it
> seems to be some arm-only driver that I can't even compile-test my
> resolution.

I think it looks correct, but yeah, as I can't build it either, it's
tough to tell.

Nicolas, can you verify that Linus's merge was done correctly?  If not,
can you send a patch?  It is commit
efb8d21b2c6db3497655cc6a033ae8a9883e4063 in Linus's tree right now.

thanks,

greg k-h
