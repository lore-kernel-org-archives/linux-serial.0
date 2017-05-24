From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH V1] serial: imx: revert setup DCEDTE early and ensure DCD
 and RI irqs to be off
Date: Wed, 24 May 2017 13:57:30 +0200
Message-ID: <20170524115730.2l6zx5ekinsrmrev@pengutronix.de>
References: <20170523123145.E268B3FAD4@swsrvapps-01.diasemi.com>
 <20170523140941.l6cjvfdsvsg76cbx@pengutronix.de>
 <6ED8E3B22081A4459DAC7699F3695FB7018CD8D303@SW-EX-MBX02.diasemi.com>
 <20170523143715.yeg3gpkmvlu4l5kt@pengutronix.de>
 <6ED8E3B22081A4459DAC7699F3695FB7018CD8D328@SW-EX-MBX02.diasemi.com>
 <20170523160845.wli3z4ukcy5uquzz@pengutronix.de>
 <6ED8E3B22081A4459DAC7699F3695FB7018CD8D750@SW-EX-MBX02.diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <6ED8E3B22081A4459DAC7699F3695FB7018CD8D750@SW-EX-MBX02.diasemi.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Steve Twiss <stwiss.opensource@diasemi.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, LINUX-KERNEL <linux-kernel@vger.kernel.org>, LINUX-SERIAL <linux-serial@vger.kernel.org>, Lucas Stach <l.stach@pengutronix.de>, Support Opensource <Support.Opensource@diasemi.com>, "kernel@pengutronix.de" <kernel@pengutronix.de>
List-Id: linux-serial@vger.kernel.org

Hello Steve,

On Wed, May 24, 2017 at 10:28:58AM +0000, Steve Twiss wrote:
> On 23 May 2017 17:09, Uwe Kleine-König wrote:
> 
> > On Tue, May 23, 2017 at 03:01:26PM +0000, Steve Twiss wrote:
> > > On 23 May 2017 15:37, Uwe Kleine-König wrote:
> > > > Subject: Re: [PATCH V1] serial: imx: revert setup DCEDTE early and ensure DCD and RI irqs to be off
> > > > On Tue, May 23, 2017 at 02:28:11PM +0000, Steve Twiss wrote:
> > > > > On 23 May 2017 15:10, Uwe Kleine-König wrote:
> > > > > > On Tue, May 23, 2017 at 01:17:26PM +0100, Steve Twiss wrote:
> > > > > > >
> > > > > > > Revert the commit e61c38d85b7392e ("serial: imx: setup DCEDTE early and
> > > > > > > ensure DCD and RI irqs to be off")
> > > > > > > The patch submitted to setup DCEDTE early and ensure DCD and RI irqs to
> > > > > > > be off, causes a serial console display problem the i.MX6Q SABRESD board.
> > > > > > > The console becomes unreadable and unwritable.
> > > > > > >
> > > > > > > Tested-by: Steve Twiss <stwiss.opensource@diasemi.com>
> > > > > > > Signed-off-by: Steve Twiss <stwiss.opensource@diasemi.com>
> > > > > >
> > > > > > You're not the first to report this issue but you still have the chance
> > > > > > to be the first to test a suggested patch for it.
> > > > >
> > > > > I've just applied your patch against a clean linux-next/v4.12-rc2
> > > > > I added your patch ...
> > > > >
> > > > > > 	http://marc.info/?l=linux-serial&m=149434029912947&w=2
> > > > >
> > > [...]
> > > > > I've added that to my working directory, but I am still seeing the corrupted
> > > > > console output on the i.MX6 Q (quad) board.
> > > >
> > > > I don't have a failing board (I think). So here are a few questions
> > > > about yours:
> > > >
> > > >  - how does the dts snippet for your failing device look like?
> > >
> > > I am using the standard DTS from the v4.12-rc2 kernel, no changes.
> > > I did an earlier test yesterday using the DTS from v4.11 to see if it was the new
> > > imx7 changes that have recently gone into the kernel but I still see the same
> > > effect.
> > >
> > > >  - This is not the device the console runs on, right?
> > >
> > > I am connected through the USB to UART, U22 on the i.MX6Q board.
> > > Terminal set to 115200 baud, no parity, 8bit data.
> > >
> > > >  - Can you initialize the device in the bootloader and check if it is working
> > there?
> > >
> > > I can get U-boot ok for all cases.
> > > Once I TFTP the kernel across, I am okay until I get to "Starting kernel ...",
> > > then, the UART is "working" in the sense that I get the some characters in the style
> > > of the kernel starting up, but they are all garbled.
> > >
> > > I expect the kernel has started ok, but I am unable to read/write through the UART
> > > console because of corruptions.
> > >
> > > Console log:
> > > --- 8< ---
> [...]
> > > Starting kernel ...
> > >
> > àüüpþàüþüààààüþüàüüþüàüàààüŽàüàüàà
> [...]
> > 
> > did you check with an oscilloscope if the baud rate is as expected (hmm,
> > but I wouldn't expect my patch to change the baud rate).
> 
> I did try several different baudrates on the terminal connection, but I didn't find any
> that worked. I've only checked the obvious ones however. I have not tried to debug
> this problem any further than diagnosing what kernel commit caused the difference.
> 
> We also swapped compilers to begin with, when the first investigation began.
> I noticed kernelci.org had some i.MX sabre boards, but used a different compiler
> and did not see any problem.
> Swapping the compiler made no difference and led us to find it only happened 
> on the i.MX6Q  not the i.MX6DL. The kernelci.org site does not test any i.MX6Q
> boards.
> 
> > > >  - Does it make a difference in Linux if the bootloader used the device before?
> > >
> > > If you mean, if U-boot uses the UART console before loading the kernel, then no.
> > > Is that what you mean?
> > 
> > I didn't expect that it destroys the console UART so I expected that you
> > can make use of a 2nd UART in U-Boot somehow to already initialize the
> > port and check if that makes it magically work in Linux.
> > 
> > Note to myself: So we're taking about the UART at 0x02020000, it is
> > operated in DCE mode.
> 
> > > It makes no difference until the kernel is loaded, then the serial
> > > output gets corrupted.
> > >
> > > >  - Can you dump the register space of the uart with v4.12-rc2 and
> > > >    v4.12-rc2 + revert of e61c38d85b7392e?
> > >
> > > Difficult to do that I think. The console is unusable in both directions. I can't get any
> > > response from the console (through typing) once the kernel has started.
> > 
> > ssh or telnet come to mind.
> 
> Yup. We thought of that also, but finding the time at this side is the problem. 
> I am looking at this Linux kernel i.MX6Q problem, but other customers are taking my
> priority at the moment, so this does not have a very high level (probably because
> we have found a "fix", at least to unblock our testing).
> Dialog do want to assist the Linux community however. So I will try to help where I can.
> 
> > Can you try to just remove the line
> > 	writel(0, sport->port.membase + UFCR);
> > that was introduced in the last hunk by commit e61c38d85b7?
> 
> Yep. I can do this.
> If I make this change, to the stock linux-next/v4.12-rc2 kernel, like this:
> 
> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> index 33509b4..68cfd3e 100644
> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> @@ -2194,9 +2194,7 @@ static int serial_imx_probe(struct platform_device *pdev)
>                 writel(IMX21_UCR3_RXDMUXSEL | UCR3_ADNIMP | UCR3_DSR,
>                        sport->port.membase + UCR3);
>  
> -       } else {
> -               writel(0, sport->port.membase + UFCR);
> -       }
> +       } 
>  
>         clk_disable_unprepare(sport->clk_ipg);
> 
> This console works okay.

OK, thanks for testing. I understand now what is broken. I will check
where I can squeeze in a timeslot to create a patch.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
