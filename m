From: "Prabhu Chawandi" <prabhu.chavandi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Regarding Serial consloe
Date: Mon, 13 Oct 2008 12:27:33 +0530
Message-ID: <241b8f7b0810122357vc234c5qe824165194afa4bf@mail.gmail.com>
References: <241b8f7b0810072221s1c84a45cgb21443fd717d625d@mail.gmail.com>
	 <241b8f7b0810072256lb3611b3x49966d2d1782789b@mail.gmail.com>
	 <20081008143227.GU5387@cathedrallabs.org>
	 <241b8f7b0810091945w12725f3di4a8bab043d3a1bdc@mail.gmail.com>
	 <241b8f7b0810100258u4a393c96s21d491d62a05e50c@mail.gmail.com>
	 <20081010162654.GA2498@kroah.com>
	 <241b8f7b0810122108v6b1e0212m99dd2644a997eb6d@mail.gmail.com>
	 <241b8f7b0810122120v3020ffb7m1c5574e98ea54c1e@mail.gmail.com>
	 <241b8f7b0810122125j53253073pa7a2f5d13becff1e@mail.gmail.com>
	 <19F8576C6E063C45BE387C64729E739403DC2221DD@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <19F8576C6E063C45BE387C64729E739403DC2221DD-/tLxBxkBPtCIQmiDNMet8wC/G2K4zDHf@public.gmane.org>
Content-Disposition: inline
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Gupta, Ajay Kumar" <ajay.gupta-l0cyMroinI0@public.gmane.org>
Cc: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>, Aristeu Rozanski <aris-moeOTchvdi7YtjvyW6yDsg@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "mangoo-Nem3ZqsbT/g@public.gmane.org" <mangoo-Nem3ZqsbT/g@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

Ajay,

  Is USB fs not an auto fs ... ?
I mean as we put the device we get the /dev/<device_id> created auto...

I can see the /dev/ttyUSB0 entry.

Thanks
Prabhu

On 10/13/08, Gupta, Ajay Kumar <ajay.gupta-l0cyMroinI0@public.gmane.org> wrote:
>
> > CONFIG_CMDLINE="rw console=ttyUSB0, 115200 mem =128M"
> >
> > and in inittab
> >
> > ttyUSB0::respawn:/bin/getty  -L ttyUSB0 115200 vt102
>
> Apart from this add "mknod /dev/ttyUSB0 c 188 0" in "filesystem/etc/init.d/rcS"
>
> This is required if this node is not created during bootup and usb serial
> device detection.
>
> Regards,
> Ajay
> >
> >
> > --Prabhu
> >
> > On 10/13/08, Prabhu Chawandi <prabhu.chavandi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> > > Some more updates :
> > >
> > >   I am using kernel 2.6.12.4.
> > >
> > > It was Tomasz Chmielewski who said that  boot messages cant be logged
> > > on USB-serial. soory for the mistake Aristeu Rozanski .
> > >
> > > On 10/13/08, Prabhu Chawandi <prabhu.chavandi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> > > > Hi,
> > > >
> > > >   I am not getting any errors ....
> > > >
> > > > I have set the command line parameter. I am booting through  CFE ,
> > > > This time I am using Serial console while booting I am changing to USB
> > > > serial...
> > > >
> > > > Once the USB -serial driver is loaded I am expecting the rest of the
> > > > logs on the console but I am getting AT command and no more
> > > > messages...
> > > >
> > > > Later I changed inittab file for the login prompt...
> > > >
> > > > I have the other serial connection through which I can control the
> > > > application. When I close that application, through the normal serial,
> > > > I am getting login prompt on both USB-serial and normal Serial.
> > > >
> > > > If I run the application again I am getting logs now on both serials...
> > > >
> > > > I am consfused why I am not getting the boot log messages...
> > > >
> > > > I am sure that I have set commandline parameter properly....
> > > >
> > > > Aristeu Rozanski has said above that ,,, it is not possoble to log
> > > > boot messages on the USB-serial ... what might be the techincal reason
> > > > ?
> > > >
> > > > Thanks
> > > > Prabhu
> > > >
> > > >
> > > >
> > > >
> > > >
> > > >
> > > >
> > > >
> > > > On 10/10/08, Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org> wrote:
> > > > >
> > > > > A: No.
> > > > > Q: Should I include quotations after my reply?
> > > > >
> > > > > On Fri, Oct 10, 2008 at 03:28:56PM +0530, Prabhu Chawandi wrote:
> > > > > > On 10/10/08, Prabhu Chawandi <prabhu.chavandi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> > > > > > > Yeah...   I did all the configurations.
> > > > > > >
> > > > > > > Still not getting the logs :(
> > > > > > >
> > > > > > > I feel I am missing the part where USB- serial  will be registered to
> > > > > > > the tty layer.
> > > > > > >
> > > > > > > or Do I need to insert the code where we will be opening the device
> > > > > > > and performimg the write/read  operations.
> > > > >
> > > > > No code needs to be added.
> > > > >
> > > > > Please let us know what errors you are seeing, what does your kernel log
> > > > > messages show, and so on.  It should work properly if you tell the boot
> > > > > command line to use the usb-serial port for console messages.
> > > > >
> > > > > thanks,
> > > > >
> > > > > greg k-h
> > > > >
> > > >
> > >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-usb" in
> > the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
