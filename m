From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH V1] serial: imx: revert setup DCEDTE early and ensure DCD
 and RI irqs to be off
Date: Tue, 23 May 2017 18:08:45 +0200
Message-ID: <20170523160845.wli3z4ukcy5uquzz@pengutronix.de>
References: <20170523123145.E268B3FAD4@swsrvapps-01.diasemi.com>
 <20170523140941.l6cjvfdsvsg76cbx@pengutronix.de>
 <6ED8E3B22081A4459DAC7699F3695FB7018CD8D303@SW-EX-MBX02.diasemi.com>
 <20170523143715.yeg3gpkmvlu4l5kt@pengutronix.de>
 <6ED8E3B22081A4459DAC7699F3695FB7018CD8D328@SW-EX-MBX02.diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <6ED8E3B22081A4459DAC7699F3695FB7018CD8D328@SW-EX-MBX02.diasemi.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Steve Twiss <stwiss.opensource@diasemi.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, LINUX-KERNEL <linux-kernel@vger.kernel.org>, LINUX-SERIAL <linux-serial@vger.kernel.org>, Lucas Stach <l.stach@pengutronix.de>, Support Opensource <Support.Opensource@diasemi.com>, "kernel@pengutronix.de" <kernel@pengutronix.de>
List-Id: linux-serial@vger.kernel.org

Hello Steve,

On Tue, May 23, 2017 at 03:01:26PM +0000, Steve Twiss wrote:
> On 23 May 2017 15:37, Uwe Kleine-König wrote:
> > Subject: Re: [PATCH V1] serial: imx: revert setup DCEDTE early and ensure DCD and RI irqs to be off
> > On Tue, May 23, 2017 at 02:28:11PM +0000, Steve Twiss wrote:
> > > On 23 May 2017 15:10, Uwe Kleine-König wrote:
> > > > On Tue, May 23, 2017 at 01:17:26PM +0100, Steve Twiss wrote:
> > > > >
> > > > > Revert the commit e61c38d85b7392e ("serial: imx: setup DCEDTE early and
> > > > > ensure DCD and RI irqs to be off")
> > > > > The patch submitted to setup DCEDTE early and ensure DCD and RI irqs to
> > > > > be off, causes a serial console display problem the i.MX6Q SABRESD board.
> > > > > The console becomes unreadable and unwritable.
> > > > >
> > > > > Tested-by: Steve Twiss <stwiss.opensource@diasemi.com>
> > > > > Signed-off-by: Steve Twiss <stwiss.opensource@diasemi.com>
> > > >
> > > > You're not the first to report this issue but you still have the chance
> > > > to be the first to test a suggested patch for it.
> > >
> > > I've just applied your patch against a clean linux-next/v4.12-rc2
> > > I added your patch ...
> > >
> > > > 	http://marc.info/?l=linux-serial&m=149434029912947&w=2
> > >
> [...]
> > > I've added that to my working directory, but I am still seeing the corrupted
> > > console output on the i.MX6 Q (quad) board.
> > 
> > I don't have a failing board (I think). So here are a few questions
> > about yours:
> > 
> >  - how does the dts snippet for your failing device look like?
> 
> I am using the standard DTS from the v4.12-rc2 kernel, no changes.
> I did an earlier test yesterday using the DTS from v4.11 to see if it was the new
> imx7 changes that have recently gone into the kernel but I still see the same
> effect.
> 
> >  - This is not the device the console runs on, right?
> 
> I am connected through the USB to UART, U22 on the i.MX6Q board.
> Terminal set to 115200 baud, no parity, 8bit data.
> 
> >  - Can you initialize the device in the bootloader and check if it is working there?
> 
> I can get U-boot ok for all cases.
> Once I TFTP the kernel across, I am okay until I get to "Starting kernel ...",
> then, the UART is "working" in the sense that I get the some characters in the style
> of the kernel starting up, but they are all garbled.
> 
> I expect the kernel has started ok, but I am unable to read/write through the UART
> console because of corruptions.
> 
> Console log:
> --- 8< ---
> U-Boot 2009.08-00001-gf65536a (Jan 12 2015 - 15:47:19)
> 
> CPU: Freescale i.MX6 family TO1.2 at 792 MHz
> Thermal sensor with ratio = 200
> Temperature:   46 C, calibration data 0x5f15527d

huh, it's hot in your office :-)

> mx6q pll1: 792MHz
> mx6q pll2: 528MHz
> mx6q pll3: 480MHz
> mx6q pll8: 50MHz
> ipg clock     : 66000000Hz
> ipg per clock : 66000000Hz
> uart clock    : 80000000Hz
> cspi clock    : 60000000Hz
> ahb clock     : 132000000Hz
> axi clock   : 264000000Hz
> emi_slow clock: 132000000Hz
> ddr clock     : 528000000Hz
> usdhc1 clock  : 198000000Hz
> usdhc2 clock  : 198000000Hz
> usdhc3 clock  : 198000000Hz
> usdhc4 clock  : 198000000Hz
> nfc clock     : 24000000Hz
> Board: i.MX6Q-SABRESD: unknown-board Board: 0x63012 [WDOG ]
> Boot Device: SD
> I2C:   ready
> DRAM:   1 GB
> MMC:   FSL_USDHC: 0,FSL_USDHC: 1,FSL_USDHC: 2,FSL_USDHC: 3
> In:    serial
> Out:   serial
> Err:   serial
> Found PFUZE100! deviceid=10,revid=11
> Net:   got MAC address from IIM: 00:04:9f:02:e3:0a
> FEC0 [PRIME]
> Hit any key to stop autoboot:  0
> PHY indentify @ 0x1 = 0x004dd074
> FEC: Link is Up 796d
> Using FEC0 device
> TFTP from server 192.168.2.1; our IP address is 192.168.2.2
> Filename 'uImage_dtb.imx6q.v4.12-rc2'.
> Load address: 0x12000000
> Loading: #################################################################
>          #################################################################
>          #################################################################
>          #################################################################
>          #################################################################
>          #################################################################
>          #################################################################
>          #################################################################
>          #################################################################
>          #################################################################
>          #################################################################
>          #################################################################
>          #################################################################
>          #################################################################
>          #################################################################
>          #################################################################
>          #################################################################
>          ##########################################################
> done
> Bytes transferred = 5951108 (5ace84 hex)
> ## Booting kernel from Legacy Image at 12000000 ...
>    Image Name:
>    Image Type:   ARM Linux Kernel Image (uncompressed)
>    Data Size:    5951044 Bytes =  5.7 MB
>    Load Address: 10800000
>    Entry Point:  10800000
>    Verifying Checksum ... OK
>    Loading Kernel Image ... OK
> OK
> 
> Starting kernel ...
> 
> àüüpþàüþüààààüþüàüüþüàüàààüŽàüàüàààà€ààüþüààüüÿ
> ààüŽüþüàüàðààðàààþ~pàœà`þüàüŽàààüàþüþàüàŽààà
> ààüüÿààüŽüþüàüàð€ààààààðààðàüààüðààðàààþüÿüðüüŽàüŽàààüü
> þüÿààüüpðüÀüþüüàààüpÿüààðààðàüàðàüàŽ~8àŽààŽààü€ààðààüp
> ŽààüàààààðàüðààðàüàpþàüðàüðààþàðàüààààààðààðàüüàŽà€üàà
> Žüà~ÿüààààüüŽààüþàü~Žüàðààðààààþà€üààðü~ÿàüŽààüŽüþüàðààà
> Žüà~ÿüàŽààü€þüàðààü€àüðààüüà€àüà€üààŽàüààààãpŽààüü
> þüàüàüŽààüþüààààþàü€üüðààààãpŽà€àüàüŽààüþüààŽü

did you check with an oscilloscope if the baud rate is as expected (hmm,
but I wouldn't expect my patch to change the baud rate).

> --- 8< ---
> 
> >  - Does it make a difference in Linux if the bootloader used the device  before?
> 
> If you mean, if U-boot uses the UART console before loading the kernel, then no.
> Is that what you mean?

I didn't expect that it destroys the console UART so I expected that you
can make use of a 2nd UART in U-Boot somehow to already initialize the
port and check if that makes it magically work in Linux.

Note to myself: So we're taking about the UART at 0x02020000, it is
operated in DCE mode.

> It makes no difference until the kernel is loaded, then the serial
> output gets corrupted.
> 
> >  - Can you dump the register space of the uart with v4.12-rc2 and
> >    v4.12-rc2 + revert of e61c38d85b7392e?
> 
> Difficult to do that I think. The console is unusable in both directions. I can't get any
> response from the console (through typing) once the kernel has started.

ssh or telnet come to mind.

Can you try to just remove the line

	writel(0, sport->port.membase + UFCR);

that was introduced in the last hunk by commit e61c38d85b7?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
