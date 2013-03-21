From: Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Subject: Re: Plug and play for a tty line disciple networking device
Date: Wed, 20 Mar 2013 17:56:04 -0700
Message-ID: <20130321005604.GA28671@kroah.com>
References: <CAKON4OxNV85-J8C-hodpq9pY5tRCT+7aYa=m4T3Vk04XSGhOrA@mail.gmail.com>
 <20130320232645.GC19779@kroah.com>
 <CAKON4Oz+2DfzeOcvmKgi3ADAtyC5ie5-22uUQdfH_gcqeaDSYA@mail.gmail.com>
 <20130321001424.GA27981@kroah.com>
 <CAKON4OyB6Tc_NSYjb9HRjpzZJOTEZowoYB8NeJwtO6T42wegBg@mail.gmail.com>
 <20130321003817.GA28389@kroah.com>
 <CAKON4OxceqF8LJa9L+QZ_jznFbD0VE+2PejdZWTpOC+gdU2vHg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAKON4OxceqF8LJa9L+QZ_jznFbD0VE+2PejdZWTpOC+gdU2vHg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Alan Ott <alan-yzvJWuRpmD1zbRFIqnYvSA@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

On Wed, Mar 20, 2013 at 08:49:50PM -0400, jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org wrote:
> On Wed, Mar 20, 2013 at 8:38 PM, Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org> wrote:
> > On Wed, Mar 20, 2013 at 08:25:15PM -0400, jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org wrote:
> >> On Wed, Mar 20, 2013 at 8:14 PM, Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org> wrote:
> >> > On Wed, Mar 20, 2013 at 08:04:29PM -0400, jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org wrote:
> >> >> On Wed, Mar 20, 2013 at 7:26 PM, Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org> wrote:
> >> >> > On Tue, Mar 19, 2013 at 11:30:05AM -0400, jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org wrote:
> >> >> >> How can you achieve plug and play for a ft2232 based USB serial device
> >> >> >> implementing 802.15.4 networking?
> >> >> >>
> >> >> >> The device has a 802.15.4 SOC with a UART attached to a ft2232. With
> >> >> >> firmware loaded the only thing it can do is talk the 802.15.4 tty line
> >> >> >> discipline, it is not a general purpose serial port.
> >> >> >>
> >> >> >> Right now the device works by plugging it in and it appears as a
> >> >> >> generic USB serial device like ttyUSB0. You then run a user space app
> >> >> >> which sets the line discipline, holds the port open and attaches it to
> >> >> >> the 6lowpan implementation in the networking code. But doing that is
> >> >> >> inconvenient and users needs to be trained to do it. Much simpler if
> >> >> >> we could just plug the device in and it worked.
> >> >> >>
> >> >> >> We can add a EEPROM to the ft2232 to give it a unique USB ID.  Is it
> >> >> >> possible to make a kernel driver that see this ID, sets the line
> >> >> >> discipline and wires the serial port directly into the networking
> >> >> >> code?
> >> >> >
> >> >> > Yes, you can do that.
> >> >>
> >> >> Is there an existing driver in the kernel that does this?
> >> >> So far all of the ones I've checked still need a user space app.
> >> >
> >> > Look at the bluetooth drivers, they have their own line dicipline I
> >> > think.
> >>
> >> Bluetooth drivers use line discipline on UARTs. On USB they have their
> >> own set of Bluetooth descriptors.
> >>
> >> CAN over serial has a line discipline but it needs a user space app.
> >
> > In your driver, just attach the line discipline directly to the tty
> > device you create.  You will not be using the "normal" usb-serial logic
> > at all if you do this, but you should be fine, right?
> 
> USB serial port is based on the FT2232 so we've been using that driver.
> 
> Modifying that driver was my plan for doing this. I was hoping that
> there was a more generic way to achieve the same effect.

No, sorry, stick with doing this from userspace, it's a simple one-line
udev rule, right?

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
