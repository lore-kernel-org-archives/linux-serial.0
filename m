From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Subject: Re: [patch 0/7] staging: speakup: introduce tty-based comms
Date: Tue, 14 Mar 2017 01:47:01 +0100
Message-ID: <20170314004701.kuecu2zu4md5ccrq@var.youpi.perso.aquilenet.fr>
References: <20170313220551.312820470@gmail.com>
 <20170313221404.GA22871@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
Content-Disposition: inline
In-Reply-To: <20170313221404.GA22871@kroah.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: devel@driverdev.osuosl.org, Rob Herring <robh@kernel.org>, okash.khawaja@gmail.com, Kirk Reiser <kirk@reisers.ca>, speakup@linux-speakup.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>, Chris Brannon <chris@the-brannons.com>
List-Id: linux-serial@vger.kernel.org

Hello,

Greg KH, on mar. 14 mars 2017 06:14:04 +0800, wrote:
> On Mon, Mar 13, 2017 at 10:05:51PM +0000, okash.khawaja@gmail.com wrote:
> > This patchset introduces a TTY-based way for the synths to communicate
> > with devices as an alternate for direct serial comms used by the synths
> > at the moment. It then migrates some of the synths to the TTY-based
> > comms. Synths migrated in this patchset are dummy, acntsa, bns and
> > txprt.
> 
> What about using the serbus code that is now in the tree?  That should
> make this a lot easier than your patchset from what I can see.

Mmm... AIUI from reading tty_port_register_device_attr, one
would have to have registered a speakup serdev device driver
*before* tty_port_register_device_attr gets called, so that
serdev_tty_port_register matches the driver in the loop of
of_serdev_register_devices, and no TTY cdev is created?

That would mean that speakup can not be loaded as a module after ttyS0
initialization, that won't fly for our use needs. The line discipline
mechanism allows us to attach ourself to an existing tty.  Could we
imagine a tty_port function which removes the cdev and tries to register
the tty port again to serdev?

What we basically need to be able to say on speakup module load is
e.g. "I'm now attaching a device to ttyS0, use this serdev_device_ops to
discuss with it".

Samuel
