From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 2/2] serial: 8250: Add support for 8250/16550 as MFD
 function
Date: Tue, 21 May 2019 16:43:19 +0200
Message-ID: <20190521144319.GA28747@kroah.com>
References: <87bm05mpmx.fsf@haabendal.dk>
 <20190514104741.GO4319@dell>
 <20190514122618.GA18859@kroah.com>
 <87imudky2o.fsf@haabendal.dk>
 <20190521100904.GA13612@kroah.com>
 <87pnocm59v.fsf@haabendal.dk>
 <20190521111817.GA24911@kroah.com>
 <87lfz0m3ge.fsf@haabendal.dk>
 <20190521125651.GA6264@kroah.com>
 <87h89nnajr.fsf@haabendal.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87h89nnajr.fsf@haabendal.dk>
Sender: linux-kernel-owner@vger.kernel.org
To: Esben Haabendal <esben@haabendal.dk>
Cc: Lee Jones <lee.jones@linaro.org>, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>, Nishanth Menon <nm@ti.com>, Vignesh R <vigneshr@ti.com>, Tony Lindgren <tony@atomide.com>, Lokesh Vutla <lokeshvutla@ti.com>, Florian Fainelli <f.fainelli@gmail.com>, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Tue, May 21, 2019 at 04:31:52PM +0200, Esben Haabendal wrote:
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:
> 
> > On Tue, May 21, 2019 at 01:50:25PM +0200, Esben Haabendal wrote:
> >> Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:
> >> 
> >> > On Tue, May 21, 2019 at 01:11:08PM +0200, Esben Haabendal wrote:
> >> >> Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:
> >> >> 
> >> >> >> I will try ad hold back with this thread until you get back to it.
> >> >> >
> >> >> > Ok, I have no idea what is going on here, sorry.  This is a really long
> >> >> > and meandering thread, and I can't even find the original patches in my
> >> >> > queue.
> >> >> >
> >> >> > So can you resend things and we can start over?  :)
> >> >> 
> >> >> Will do.
> >> >> 
> >> >> > But note, using a mfd for a uart seems VERY odd to me...
> >> >> 
> >> >> Ok.  In my case, I have a pcie card with an fpga which includes 5 uart
> >> >> ports, 3 ethernet interfaces and a number of custom IP blocks.
> >> >> I believe that an mfd driver for that pcie card in that case.
> >> >
> >> > I believe you need to fix that fpga to expose individual pci devices
> >> > such that you can properly bind the individual devices to the expected
> >> > drivers :)
> >> 
> >> Well, that is really out-of-scope of what I am doing here.
> >
> > Not really, if you have control over the fpga firmware (and odds are you
> > do), just fix that and instantly your device works with all kernels, no
> > need to change anything.
> >
> > Why not do this?
> 
> Because I do not have control over fpga firmware.

Who does?  Why did they create it this way if it can not be accessed by
an operating system as-is?  Has it passed the PCI tests?  Do you have a
link to where you can get this crazy device?

> >> > Seriously, who makes such a broken fpga device that goes against the PCI
> >> > spec that way?  Well, not so much as "goes against it", as "ignores all
> >> > of the proper ideas of the past 20 years for working with PCI devices".
> >> 
> >> Might be.  But that is the firmware I have to work with here, and I
> >> still hope we can find a good solution for implementing a driver without
> >> having to maintain out-of-tree patches.
> >
> > As this hardware will not work on any operating system as-is, why not
> > fix the firmware to keep from having to support a one-off device that no
> > one else would be crazy enough to create?  :)
> 
> Clearly, someone has been crazy enough.  Hopefully, we can be smart
> enough to make Linux fit to it.

Sometimes you need to go tell the hardware/firmware people not to do
foolish things.  You can not always fix their problems in software.
Please push back on this.

thanks,

greg k-h
