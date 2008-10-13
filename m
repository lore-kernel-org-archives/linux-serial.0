From: "Prabhu Chawandi" <prabhu.chavandi@gmail.com>
Subject: Re: Regarding Serial consloe
Date: Mon, 13 Oct 2008 09:55:14 +0530
Message-ID: <241b8f7b0810122125j53253073pa7a2f5d13becff1e@mail.gmail.com>
References: <241b8f7b0810072221s1c84a45cgb21443fd717d625d@mail.gmail.com>
	 <241b8f7b0810072253l57f0fc0bm8356798972089b10@mail.gmail.com>
	 <241b8f7b0810072256lb3611b3x49966d2d1782789b@mail.gmail.com>
	 <20081008143227.GU5387@cathedrallabs.org>
	 <241b8f7b0810091945w12725f3di4a8bab043d3a1bdc@mail.gmail.com>
	 <241b8f7b0810100258u4a393c96s21d491d62a05e50c@mail.gmail.com>
	 <20081010162654.GA2498@kroah.com>
	 <241b8f7b0810122108v6b1e0212m99dd2644a997eb6d@mail.gmail.com>
	 <241b8f7b0810122120v3020ffb7m1c5574e98ea54c1e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.233]:50144 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750733AbYJMEZP (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 13 Oct 2008 00:25:15 -0400
Received: by rv-out-0506.google.com with SMTP id k40so1646090rvb.1
        for <linux-serial@vger.kernel.org>; Sun, 12 Oct 2008 21:25:15 -0700 (PDT)
In-Reply-To: <241b8f7b0810122120v3020ffb7m1c5574e98ea54c1e@mail.gmail.com>
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: Aristeu Rozanski <aris@ruivo.org>, linux-usb@vger.kernel.org, linux-serial@vger.kernel.org, mangoo@wpkg.org

CONFIG_CMDLINE="rw console=ttyUSB0, 115200 mem =128M"

and in inittab

ttyUSB0::respawn:/bin/getty  -L ttyUSB0 115200 vt102


--Prabhu

On 10/13/08, Prabhu Chawandi <prabhu.chavandi@gmail.com> wrote:
> Some more updates :
>
>   I am using kernel 2.6.12.4.
>
> It was Tomasz Chmielewski who said that  boot messages cant be logged
> on USB-serial. soory for the mistake Aristeu Rozanski .
>
> On 10/13/08, Prabhu Chawandi <prabhu.chavandi@gmail.com> wrote:
> > Hi,
> >
> >   I am not getting any errors ....
> >
> > I have set the command line parameter. I am booting through  CFE ,
> > This time I am using Serial console while booting I am changing to USB
> > serial...
> >
> > Once the USB -serial driver is loaded I am expecting the rest of the
> > logs on the console but I am getting AT command and no more
> > messages...
> >
> > Later I changed inittab file for the login prompt...
> >
> > I have the other serial connection through which I can control the
> > application. When I close that application, through the normal serial,
> > I am getting login prompt on both USB-serial and normal Serial.
> >
> > If I run the application again I am getting logs now on both serials...
> >
> > I am consfused why I am not getting the boot log messages...
> >
> > I am sure that I have set commandline parameter properly....
> >
> > Aristeu Rozanski has said above that ,,, it is not possoble to log
> > boot messages on the USB-serial ... what might be the techincal reason
> > ?
> >
> > Thanks
> > Prabhu
> >
> >
> >
> >
> >
> >
> >
> >
> > On 10/10/08, Greg KH <greg@kroah.com> wrote:
> > >
> > > A: No.
> > > Q: Should I include quotations after my reply?
> > >
> > > On Fri, Oct 10, 2008 at 03:28:56PM +0530, Prabhu Chawandi wrote:
> > > > On 10/10/08, Prabhu Chawandi <prabhu.chavandi@gmail.com> wrote:
> > > > > Yeah...   I did all the configurations.
> > > > >
> > > > > Still not getting the logs :(
> > > > >
> > > > > I feel I am missing the part where USB- serial  will be registered to
> > > > > the tty layer.
> > > > >
> > > > > or Do I need to insert the code where we will be opening the device
> > > > > and performimg the write/read  operations.
> > >
> > > No code needs to be added.
> > >
> > > Please let us know what errors you are seeing, what does your kernel log
> > > messages show, and so on.  It should work properly if you tell the boot
> > > command line to use the usb-serial port for console messages.
> > >
> > > thanks,
> > >
> > > greg k-h
> > >
> >
>
