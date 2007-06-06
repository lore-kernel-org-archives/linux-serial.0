From: "Hello Bello" <domician@gmail.com>
Subject: Re: serial port cannot be read in linux
Date: Wed, 6 Jun 2007 19:38:52 +0200
Message-ID: <730b6c6b0706061038s7d872ab1kf04bac33e69fa9f8@mail.gmail.com>
References: <730b6c6b0706021439w41923cddvbf9fe953255190c0@mail.gmail.com>
	 <730b6c6b0706021440y7bb07837l104f1afbc25ee4fa@mail.gmail.com>
	 <Pine.LNX.4.64.0706040845390.23789@schoen3.schoen.mine.nu>
	 <730b6c6b0706051644j16cefd81y882b52602bad98f6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.173]:35492 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757309AbXFFRiy (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 6 Jun 2007 13:38:54 -0400
Received: by ug-out-1314.google.com with SMTP id j3so499068ugf
        for <linux-serial@vger.kernel.org>; Wed, 06 Jun 2007 10:38:52 -0700 (PDT)
In-Reply-To: <730b6c6b0706051644j16cefd81y882b52602bad98f6@mail.gmail.com>
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: kees <kees@schoen.mine.nu>, linux-serial@vger.kernel.org, dhlii@dlasys.net

Hello Folks,

Thank you very much for your help. Based on your input, I could figure
out that the troblemaker was the gpm driver. It was configured to be
launched at boot time, and it has reserved the serial port for itself.
Without gpm, it works as I have always expected.

Let me once more thank you your feedback and help.
Regards,
Gabor

2007/6/6, Hello Bello <domician@gmail.com>:
> Hello,
>
> stty -a </dev/ttyS0 says:
> speed 9600 baud; rows 0; columns 0; line = 0;
> intr = ^C; quit = ^\; erase = ^?; kill = ^U; eof = ^D; eol = <undef>;
> eol2 = <undef>; start = ^Q; stop = ^S; susp = ^Z;
> rprnt = ^R; werase = ^W; lnext = ^V; flush = ^O; min = 1; time = 0;
> -parenb -parodd cs8 hupcl -cstopb cread clocal -crtscts
> -ignbrk -brkint -ignpar -parmrk -inpck -istrip -inlcr -igncr icrnl
> ixon -ixoff -iuclc -ixany -imaxbel
> opost -olcuc -ocrnl onlcr -onocr -onlret -ofill -ofdel nl0 cr0 tab0 bs0 vt0 ff0
> isig icanon iexten echo echoe echok -echonl -noflsh -xcase -tostop
> -echoprt echoctl echoke
>
>
> whereas stty -a </dev/ttyS2 says:
> speed 9600 baud; rows 0; columns 0; line = 0;
> intr = ^C; quit = ^\; erase = ^?; kill = ^U; eof = ^D; eol = <undef>;
> eol2 = <undef>; start = ^Q; stop = ^S; susp = ^Z;
> rprnt = ^R; werase = ^W; lnext = ^V; flush = ^O; min = 1; time = 0;
> -parenb -parodd cs8 hupcl -cstopb cread clocal -crtscts
> -ignbrk -brkint -ignpar -parmrk -inpck -istrip -inlcr -igncr icrnl
> ixon -ixoff -iuclc -ixany -imaxbel
> opost -olcuc -ocrnl onlcr -onocr -onlret -ofill -ofdel nl0 cr0 tab0 bs0 vt0 ff0
> isig icanon iexten echo echoe echok -echonl -noflsh -xcase -tostop
> -echoprt echoctl echoke
>
> I guess that one of these ports are the infrared port.
>
> Best regards,
> Gabor
>
>
> 2007/6/4, kees <kees@schoen.mine.nu>:
> > Hi,
> >
> > What does stty -a </dev/ttyS0 return to you?
> >
> > regards
> >
> > Kees
> >
> >
> > On Sat, 2 Jun 2007, Hello Bello wrote:
> >
> > > Hello,
> > >
> > > I am trying to use a serial port in linux. My architecture is:
> > > -compaq evo n600c
> > > -debian GNU Linux 3.1
> > > -vanilla kernel: Linux furge 2.6.21 #2 SMP Sat Jun 2 21:25:42 CEST
> > > 2007 i686 GNU/Linux
> > >
> > > This is my dmesg output:
> > > serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
> > > serial8250: ttyS2 at I/O 0x3e8 (irq = 3) is a 16550A
> > > 00:02: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
> > >
> > > I am trying to test the serial port by jumpering the receive and
> > > transmit pins of the serial port.
> > >
> > > Using this hardware, windows XP serial port tester program echos back
> > > the characters written to the port, so the hardware is ok.
> > >
> > > However, in Linux, the port stays dumb. I can write to it, but there
> > > is nothing to be read from it.
> > > e.g.
> > > cat /dev/ttyS0 > /tmp/serial.txt &; echo "a" > /dev/ttyS0; cat
> > > /tmp/serial.txt
> > > or
> > > cp /dev/ttyS0 /dev/tty1; echo "a" > /dev/ttyS0
> > >
> > > I have read through the "Cannot write but not read" topic in this
> > > mailing list, but without any success.
> > > Also I have tried several serial port testing programs, all in vain.
> > > Kernel recompilations made no luck.
> > >
> > >
> > > I would really appreciate your help,
> > > Thanks,
> > > Gabor
> > > -
> > > To unsubscribe from this list: send the line "unsubscribe linux-serial" in
> > > the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > >
> >
>
