From: "Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: Re: [RFC] firmware: annotate thou shalt not request fw on init or
 probe
Date: Thu, 16 Jun 2016 22:56:16 +0200
Message-ID: <20160616205616.GB11948@wotan.suse.de>
References: <1440811107-861-1-git-send-email-mcgrof@do-not-panic.com>
 <alpine.DEB.2.02.1508291812350.2057@localhost6.localdomain6>
 <20150903013533.GO8051@wotan.suse.de>
 <alpine.DEB.2.02.1509030753140.2037@localhost6.localdomain6>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.02.1509030753140.2037@localhost6.localdomain6>
Sender: linux-doc-owner@vger.kernel.org
To: Julia Lawall <julia.lawall@lip6.fr>, Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>, ming.lei@canonical.com, torvalds@linux-foundation.org, liam.r.girdwood@linux.intel.com, yang.jie@intel.com, tiwai@suse.de, dmitry.torokhov@gmail.com, joonas.lahtinen@linux.intel.com, teg@jklm.no, viro@zeniv.linux.org.uk, gregkh@linuxfoundation.org, kay@vrfy.org, dwmw2@infradead.org, linux-kernel@vger.kernel.org, yalin.wang2010@gmail.com, Jonathan Corbet <corbet@lwn.net>, Gilles Muller <Gilles.Muller@lip6.fr>, Nicolas Palix <nicolas.palix@imag.fr>, Michal Marek <mmarek@suse.com>, linux-doc@vger.kernel.org, cocci@systeme.lip6.fr, Alessandro Rubini <rubini@gnudd.com>, Kevin Cernekee <cernekee@gmail.com>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, Arend Van Spriel <arend@broadcom.com>
List-Id: linux-serial@vger.kernel.org

On Thu, Sep 03, 2015 at 07:56:33AM +0200, Julia Lawall wrote:
> 
> 
> On Thu, 3 Sep 2015, Luis R. Rodriguez wrote:
> 
> > On Sat, Aug 29, 2015 at 06:18:20PM +0200, Julia Lawall wrote:
> > > > +@ defines_module_init exists @
> > > > +declarer name module_init;
> > > > +identifier init;
> > > > +@@
> > > > +
> > > > +module_init(init);
> > > > +
> > > > +@ has_probe depends on defines_module_init @
> > > > +identifier drv_calls, drv_probe;
> > > > +type bus_driver;
> > > > +identifier probe_op =~ "(probe)";
> > > > +@@
> > > > +
> > > > +bus_driver drv_calls = {
> > > > +	.probe_op = drv_probe,
> > > > +};
> > > 
> > > I'm not sure that this is enough.  For example, there is the macro
> > > platform_driver_probe that initializes probe fields.  There is likewise
> > > module_platform_driver, which is a top-level declaration that encapsulates
> > > the module_init and the definition of the module_init function, which in
> > > turn calls platform_driver_probe.  There is also module_platform_driver,
> > > which encapsulates the module_init, but not the initialization of the probe
> > > field.  Are you concerned with any of these cases?
> > 
> > Yes, and also it would seem this would only capture simple one level of
> > routine indirection, for instance if probe called bar() and it was within
> > bar() that the driver code called a fw request call, that would not be picked
> > up, correct?
> 
> By default, Coccinelle is not interprocedural.  You can encode that in the 
> script, though.
> 
> Probably the most convenient approach would be to start with the the call, 
> and then work backward to the entry point.  I have code to do this, if and 
> when it turns out to be useful.

FYI folks, thanks to Coccinelle 1.0.5 this is now easily possible with
Python integration, a follow up patch will be submitted that uses this
mechanism to do a proper full search on the kernel.

  Luis
