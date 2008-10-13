From: "Prabhu Chawandi" <prabhu.chavandi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Regarding Serial consloe
Date: Mon, 13 Oct 2008 15:39:49 +0530
Message-ID: <241b8f7b0810130309n63662051w78f38a313b729380@mail.gmail.com>
References: <241b8f7b0810072221s1c84a45cgb21443fd717d625d@mail.gmail.com>
	 <20081010162654.GA2498@kroah.com>
	 <241b8f7b0810122108v6b1e0212m99dd2644a997eb6d@mail.gmail.com>
	 <241b8f7b0810122120v3020ffb7m1c5574e98ea54c1e@mail.gmail.com>
	 <241b8f7b0810122125j53253073pa7a2f5d13becff1e@mail.gmail.com>
	 <19F8576C6E063C45BE387C64729E739403DC2221DD@dbde02.ent.ti.com>
	 <241b8f7b0810122357vc234c5qe824165194afa4bf@mail.gmail.com>
	 <19F8576C6E063C45BE387C64729E739403DC222237@dbde02.ent.ti.com>
	 <241b8f7b0810130113m6e93d127ldd8b8f95cf6aa109@mail.gmail.com>
	 <19F8576C6E063C45BE387C64729E739403DC2222CB@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <19F8576C6E063C45BE387C64729E739403DC2222CB-/tLxBxkBPtCIQmiDNMet8wC/G2K4zDHf@public.gmane.org>
Content-Disposition: inline
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Gupta, Ajay Kumar" <ajay.gupta-l0cyMroinI0@public.gmane.org>
Cc: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>, Aristeu Rozanski <aris-moeOTchvdi7YtjvyW6yDsg@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "mangoo-Nem3ZqsbT/g@public.gmane.org" <mangoo-Nem3ZqsbT/g@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

Ajay,

   I did all configurations in the clean sandbox ....

Even then I am not getting a log ...

Is it a problem as I am running with 2.6.12 ...

from then onwards pl2303/usb_serial drivers have changed drastically ?

Thanks
Prabhu

On 10/13/08, Gupta, Ajay Kumar <ajay.gupta-l0cyMroinI0@public.gmane.org> wrote:
> > -----Original Message-----
> > From: Prabhu Chawandi [mailto:prabhu.chavandi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org]
> > Sent: Monday, October 13, 2008 1:43 PM
> > To: Gupta, Ajay Kumar
> > Cc: Greg KH; Aristeu Rozanski; linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org;
> > mangoo-Nem3ZqsbT/g@public.gmane.org
> > Subject: Re: Regarding Serial consloe
> >
> > Ajay,
> >   Here is the link, where same issue is raised ...
> >
> > And for that Greg has told ..  no kernel messages can be loggen on USB-serial.
> >
> > Is that hold good today ? or can we produce logs on uSB serial console..
>
> I tried it on v2.6.18 with prolific-2303 and it did work for me. I was able
> to get console on usb serial.
>
> Some of the bootup message didn't come on usb serial till usb serial part
> got initialized.
>
> Regards,
> Ajay
>
> >
> >
> > link:
> > http://marc.info/?l=linux-usb-devel&m=119384398314558&q=raw
> >
> > Thanks
> > Prabhu
> >
> > On 10/13/08, Gupta, Ajay Kumar <ajay.gupta-l0cyMroinI0@public.gmane.org> wrote:
> > > >   Is USB fs not an auto fs ... ?
> > > > I mean as we put the device we get the /dev/<device_id> created auto...
> > > >
> > > > I can see the /dev/ttyUSB0 entry.
> > >
> > >
> > > If it is auto created then that entry is not required. Another thing that can
> > > be tried is using default baudrate of 9600 as below.
> > >
> > > CONFIG_CMDLINE="rw console=ttyUSB0, 9600 mem =128M"
> > > and in inittab
> > > ttyUSB0::respawn:/bin/getty  -L ttyUSB0 9600 vt102
> > >
> > > Regards,
> > > Ajay
> > >
> > > >
> > > > Thanks
> > > > Prabhu
> > > >
> > > > On 10/13/08, Gupta, Ajay Kumar <ajay.gupta-l0cyMroinI0@public.gmane.org> wrote:
> > > > >
> > > > > > CONFIG_CMDLINE="rw console=ttyUSB0, 115200 mem =128M"
> > > > > >
> > > > > > and in inittab
> > > > > >
> > > > > > ttyUSB0::respawn:/bin/getty  -L ttyUSB0 115200 vt102
> > > > >
> > > > > Apart from this add "mknod /dev/ttyUSB0 c 188 0" in "filesystem/etc/init.d/rcS"
> > > > >
> > > > > This is required if this node is not created during bootup and usb serial
> > > > > device detection.
> > > > >
> > > > > Regards,
> > > > > Ajay
> > > > > >
> > > > > >
> > > > > > --Prabhu
> > > > > >
> > > > > > On 10/13/08, Prabhu Chawandi <prabhu.chavandi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> > > > > > > Some more updates :
> > > > > > >
> > > > > > >   I am using kernel 2.6.12.4.
> > > > > > >
> > > > > > > It was Tomasz Chmielewski who said that  boot messages cant be logged
> > > > > > > on USB-serial. soory for the mistake Aristeu Rozanski .
> > > > > > >
> > > > > > > On 10/13/08, Prabhu Chawandi <prabhu.chavandi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> > > > > > > > Hi,
> > > > > > > >
> > > > > > > >   I am not getting any errors ....
> > > > > > > >
> > > > > > > > I have set the command line parameter. I am booting through  CFE ,
> > > > > > > > This time I am using Serial console while booting I am changing to USB
> > > > > > > > serial...
> > > > > > > >
> > > > > > > > Once the USB -serial driver is loaded I am expecting the rest of the
> > > > > > > > logs on the console but I am getting AT command and no more
> > > > > > > > messages...
> > > > > > > >
> > > > > > > > Later I changed inittab file for the login prompt...
> > > > > > > >
> > > > > > > > I have the other serial connection through which I can control the
> > > > > > > > application. When I close that application, through the normal serial,
> > > > > > > > I am getting login prompt on both USB-serial and normal Serial.
> > > > > > > >
> > > > > > > > If I run the application again I am getting logs now on both serials...
> > > > > > > >
> > > > > > > > I am consfused why I am not getting the boot log messages...
> > > > > > > >
> > > > > > > > I am sure that I have set commandline parameter properly....
> > > > > > > >
> > > > > > > > Aristeu Rozanski has said above that ,,, it is not possoble to log
> > > > > > > > boot messages on the USB-serial ... what might be the techincal reason
> > > > > > > > ?
> > > > > > > >
> > > > > > > > Thanks
> > > > > > > > Prabhu
> > > > > > > >
> > > > > > > >
> > > > > > > >
> > > > > > > >
> > > > > > > >
> > > > > > > >
> > > > > > > >
> > > > > > > >
> > > > > > > > On 10/10/08, Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org> wrote:
> > > > > > > > >
> > > > > > > > > A: No.
> > > > > > > > > Q: Should I include quotations after my reply?
> > > > > > > > >
> > > > > > > > > On Fri, Oct 10, 2008 at 03:28:56PM +0530, Prabhu Chawandi wrote:
> > > > > > > > > > On 10/10/08, Prabhu Chawandi <prabhu.chavandi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> > > > > > > > > > > Yeah...   I did all the configurations.
> > > > > > > > > > >
> > > > > > > > > > > Still not getting the logs :(
> > > > > > > > > > >
> > > > > > > > > > > I feel I am missing the part where USB- serial  will be registered to
> > > > > > > > > > > the tty layer.
> > > > > > > > > > >
> > > > > > > > > > > or Do I need to insert the code where we will be opening the device
> > > > > > > > > > > and performimg the write/read  operations.
> > > > > > > > >
> > > > > > > > > No code needs to be added.
> > > > > > > > >
> > > > > > > > > Please let us know what errors you are seeing, what does your kernel log
> > > > > > > > > messages show, and so on.  It should work properly if you tell the boot
> > > > > > > > > command line to use the usb-serial port for console messages.
> > > > > > > > >
> > > > > > > > > thanks,
> > > > > > > > >
> > > > > > > > > greg k-h
> > > > > > > > >
> > > > > > > >
> > > > > > >
> > > > > > --
> > > > > > To unsubscribe from this list: send the line "unsubscribe linux-usb" in
> > > > > > the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> > > > > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > > > >
> > > > >
> > >
> > >
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
