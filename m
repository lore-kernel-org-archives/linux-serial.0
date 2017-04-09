From: Okash Khawaja <okash.khawaja@gmail.com>
Subject: Re: [patch 0/7] staging: speakup: introduce tty-based comms
Date: Sun, 9 Apr 2017 17:54:34 +0100
Message-ID: <20170409165434.GA1919@sanghar>
References: <20170313220551.312820470@gmail.com>
 <20170313221404.GA22871@kroah.com>
 <20170314004701.kuecu2zu4md5ccrq@var.youpi.perso.aquilenet.fr>
 <20170314011814.p3t4zfcx3cxhgvwl@var.youpi.perso.aquilenet.fr>
 <CAL_JsqJVfG2pFoNtj89e0E9OKye4wGEUi98NOnMBwNF+Yp-rPA@mail.gmail.com>
 <20170315150323.pjda5qnxauxk5pcf@var.youpi.perso.aquilenet.fr>
 <20170322000524.7k653z7ui2zzgan6@var.youpi.perso.aquilenet.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
Content-Disposition: inline
In-Reply-To: <20170322000524.7k653z7ui2zzgan6@var.youpi.perso.aquilenet.fr>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
To: Samuel Thibault <samuel.thibault@ens-lyon.org>, Rob Herring <robh@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, devel@driverdev.osuosl.org, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Kirk Reiser <kirk@reisers.ca>, Chris Brannon <chris@the-brannons.com>, speakup@linux-speakup.org
List-Id: linux-serial@vger.kernel.org

Hi,

Any updates on this? We can start working in
tty_port_register_serdev_device() if that's okay?

Thanks,
Okash

On Wed, Mar 22, 2017 at 01:05:24AM +0100, Samuel Thibault wrote:
> Hello,
> 
> So Rob, how do you see this going?  Shall we introduce a serdev_device
> *tty_port_register_serdev_device(tty, device)? Will you work on it or
> should I give it a try?
> 
> Samuel
> 
> Samuel Thibault, on mer. 15 mars 2017 16:03:23 +0100, wrote:
> > Rob Herring, on mer. 15 mars 2017 09:45:59 -0500, wrote:
> > > On Mon, Mar 13, 2017 at 8:18 PM, Samuel Thibault
> > > <samuel.thibault@ens-lyon.org> wrote:
> > > > Samuel Thibault, on mar. 14 mars 2017 01:47:01 +0100, wrote:
> > > >> Greg KH, on mar. 14 mars 2017 06:14:04 +0800, wrote:
> > > >> > On Mon, Mar 13, 2017 at 10:05:51PM +0000, okash.khawaja@gmail.com wrote:
> > > >> > > This patchset introduces a TTY-based way for the synths to communicate
> > > >> > > with devices as an alternate for direct serial comms used by the synths
> > > >> > > at the moment. It then migrates some of the synths to the TTY-based
> > > >> > > comms. Synths migrated in this patchset are dummy, acntsa, bns and
> > > >> > > txprt.
> > > >> >
> > > >> > What about using the serbus code that is now in the tree?  That should
> > > >> > make this a lot easier than your patchset from what I can see.
> > > >>
> > > >> Mmm... AIUI from reading tty_port_register_device_attr, one
> > > >> would have to have registered a speakup serdev device driver
> > > >> *before* tty_port_register_device_attr gets called, so that
> > > >> serdev_tty_port_register matches the driver in the loop of
> > > >> of_serdev_register_devices, and no TTY cdev is created?
> > > 
> > > Not exactly. The driver doesn't have to be registered nor loaded, but
> > > the device does have to be present so no tty cdev is created. The only
> > > way a device is present currently is when a node is in the DT. I
> > > expect the x86 folks will be adding ACPI support soon.
> > 
> > Ok, but in our case there is no hardware device that the system can
> > see/probe, it's just plugged externally.
> > 
> > > >> That would mean that speakup can not be loaded as a module after ttyS0
> > > >> initialization, that won't fly for our use needs. The line discipline
> > > >> mechanism allows us to attach ourself to an existing tty.  Could we
> > > >> imagine a tty_port function which removes the cdev and tries to register
> > > >> the tty port again to serdev?
> > > >>
> > > >> What we basically need to be able to say on speakup module load is
> > > >> e.g. "I'm now attaching a device to ttyS0, use this serdev_device_ops to
> > > >> discuss with it".
> > > >
> > > > That for_each_available_child_of_node loop is really way more complex
> > > > than what we need.  And what's more, it's not working without CONFIG_OF
> > > > (!)
> > > >
> > > > It would really make sense to me to have a
> > > >
> > > > serdev_device *tty_port_register_serdev_device(tty, device)
> > > >
> > > > which unregisters the character device of the tty, and creates instead a
> > > > controler with the given device plugged to it. Really much like a line
> > > > discipline, but way simpler :)
> > > 
> > > What would trigger calling this function?
> > 
> > From the user point of view, loading the speakup module for the external
> > device, typically, with "ttyS0" as module parameter. Then the speakup
> > init function can do whatever it needs to achieve this :)
