From: hhome liu <liuhhome@gmail.com>
Subject: Re: [PATCH] tty: serial_core: Fix the incorrect configuration of baud
 rate and data length at the console serial port resume
Date: Wed, 15 May 2019 17:15:16 +0800
Message-ID: <CAHshu7NGmPO+7KjjPBtJT77vTobk0m7iX1FPnMfzh_G4SCKkRw@mail.gmail.com>
References: <a8bd7d19de25b799098659334de7e19670a806fc.1557379676.git.liuhhome@gmail.com>
 <20190514073457.GI9651@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190514073457.GI9651@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: Johan Hovold <johan@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, baolin.wang@unisoc.com, Baolin Wang <baolin.wang@linaro.org>, jslaby@suse.com, =?UTF-8?B?5YiY5bKa5riFIChMYW5xaW5nIExpdSk=?= <lanqing.liu@unisoc.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, chunyan.zhang@unisoc.com, orson.zhai@unisoc.com, zhang.lyra@gmail.com
List-Id: linux-serial@vger.kernel.org

Johan Hovold <johan@kernel.org> =E4=BA=8E2019=E5=B9=B45=E6=9C=8814=E6=97=A5=
=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=883:35=E5=86=99=E9=81=93=EF=BC=9A

>
> On Thu, May 09, 2019 at 01:42:39PM +0800, Lanqing Liu wrote:
> > When userspace opens a serial port for console, uart_port_startup()
> > is called. This function assigns the uport->cons->cflag value to
> > TTY->termios.c_cflag, then it is cleared to 0. When the user space
> > closes this serial port, the TTY structure will be released, and at
> > this time uport->cons->cflag has also been cleared.
> >
> > On the Spreadtrum platform, in some special scenarios, like charging mo=
de,
> > userspace needs to close the console, which means the uport->cons->cfla=
g
> > has also been cleared. But printing logs is still needed in the kernel.=
 So
> > when system enters suspend and resume, the console needs to be configur=
e
> > the baud rate and data length of the serial port according to its own c=
flag
> > when resuming the console port. At this time, the cflag is 0, which wil=
l
> > cause serial port to produce configuration errors that do not meet user
> > expectations.
>
> This is actually yet another regression due to 761ed4a94582 ("tty:
> serial_core: convert uart_close to use tty_port_close") which
> incidentally removed the call to uart_shutdown() where the cflag was
> being saved precisely to avoid the problem you're describing:
>
>         ae84db9661ca ("serial: core: Preserve termios c_cflag for console=
 resume")

Yes, agree with you.

>
> Judging from a quick look it seems the xmit buf, which is released in
> that function may now be leaking too.

We haven't found this issue before, but we can try to reproduce it on
our platform.

>
> > To fix this, assigning the TTY->termios.c_cflag value to uport->cons->c=
flag
> > before the userspace closes this console serial port. It will ensure th=
at
> > the correct cflag value can be gotten when the console serial port was
> > resumed.
>
> Not sure this is the right fix, but I don't have time to look at this
> right now.

OK. Thanks for your comments.
