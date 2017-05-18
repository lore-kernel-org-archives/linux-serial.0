From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 3/4] tty/serdev: add serdev registration interface
Date: Thu, 18 May 2017 17:39:04 +0200
Message-ID: <20170518153904.GA27423@kroah.com>
References: <20170411170731.4085-1-johan@kernel.org>
 <20170411170731.4085-4-johan@kernel.org>
 <20170518144342.GA10503@kroah.com>
 <20170518153101.GA3657@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170518153101.GA3657@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: Johan Hovold <johan@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Thu, May 18, 2017 at 05:31:01PM +0200, Johan Hovold wrote:
> On Thu, May 18, 2017 at 04:43:42PM +0200, Greg Kroah-Hartman wrote:
> > On Tue, Apr 11, 2017 at 07:07:30PM +0200, Johan Hovold wrote:
> > > Add a new interface for registering a serdev controller and clients, and
> > > a helper function to deregister serdev devices (or a tty device) that
> > > were previously registered using the new interface.
> > > 
> > > Once every driver currently using the tty_port_register_device() helpers
> > > have been vetted and converted to use the new serdev registration
> > > interface (at least for deregistration), we can move serdev registration
> > > to the current helpers and get rid of the serdev-specific functions.
> > > 
> > > Signed-off-by: Johan Hovold <johan@kernel.org>
> > > Reviewed-by: Rob Herring <robh@kernel.org>
> > > ---
> > >  drivers/tty/serdev/serdev-ttyport.c |  6 ++-
> > >  drivers/tty/tty_port.c              | 76 +++++++++++++++++++++++++++++++++++++
> > >  include/linux/serdev.h              |  7 +++-
> > >  include/linux/tty.h                 |  9 +++++
> > >  4 files changed, 94 insertions(+), 4 deletions(-)
> > 
> > This patch doesn't apply
> 
> Probably because it was generated against v4.11-rc which did not have
> the write_buf wrapper which you just reverted (after which the patch
> seems to apply just fine again).
> 
> I'll submit a rebased v2 of the two remaining patches anyway.
> 
> > and should it really be a 4.12-final patch?
> 
> I think so. serdev was enabled in 4.11 by hooking into the tty layer at
> the wrong place, which is what this series addresses. I had hoped to get
> at least the revert-patch into 4.11-final, and the rest into 4.12, to
> avoid disabling something which had once been enabled.
> 
> The remaining two patches only re-enables serdev for a subset of tty
> drivers (for which it is safe to do so) by using the new tty-port
> registration functions in serial-core only.
> 
> In effect we'd up with serdev disabled in 4.11 and enabled for
> serial-core in 4.12 (which is the first release that has driver using
> serdev).
> 
> Does that make sense?

Ok, fair enough, now queued up, thanks.

greg k-h
