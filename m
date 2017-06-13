From: Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH 8/9] tty: ircomm: remove dead and broken ioctl code
Date: Tue, 13 Jun 2017 11:57:14 +0200
Message-ID: <20170613095714.GJ10775@localhost>
References: <20170606105441.689-1-johan@kernel.org>
 <20170606105441.689-9-johan@kernel.org>
 <20170606122704.3e328125@lxorguk.ukuu.org.uk>
 <20170613094841.GA31846@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170613094841.GA31846@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Johan Hovold <johan@kernel.org>, Jiri Slaby <jslaby@suse.com>, Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, Samuel Ortiz <samuel@sortiz.org>, "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Tue, Jun 13, 2017 at 11:48:41AM +0200, Greg Kroah-Hartman wrote:
> On Tue, Jun 06, 2017 at 12:27:04PM +0100, Alan Cox wrote:
> > On Tue,  6 Jun 2017 12:54:40 +0200
> > Johan Hovold <johan@kernel.org> wrote:
> > 
> > > Remove three ifdefed and broken implementations of TIOCSSERIAL and
> > > TIOCGICOUNT, and parity handling in set_termios which had suffered
> > > severe bit rot.
> > 
> > I would be amazed if the IRDA code still works. It's not been tested
> > properly for years and it never followed the tty rules properly in the
> > first place - so this looks good, although moving IRDA into staging
> > and /dev/null would IMHO be far better.
> > 
> > IRDA is dead, and IR remotes are handled via completely different code.
> 
> I agree, and we should move it into staging and out of the tree, I'll
> send netdev some patches for that...

Sounds good, but please consider applying this patch before moving to
staging as people have been modifying this dead code as part of
kernel-wide updates even though hasn't even compiled for quite some
time.

Thanks,
Johan
