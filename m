From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH V1] serial: imx: revert setup DCEDTE early and ensure DCD
 and RI irqs to be off
Date: Wed, 24 May 2017 14:02:11 +0200
Message-ID: <20170524120211.5p3pa4ahca4rj5xp@pengutronix.de>
References: <20170523123145.E268B3FAD4@swsrvapps-01.diasemi.com>
 <CAOMZO5CT5MS1WGm_rCJ61Ambh+rMapsQWD84RXtagtt3HhmZwg@mail.gmail.com>
 <6ED8E3B22081A4459DAC7699F3695FB7018CD8D75E@SW-EX-MBX02.diasemi.com>
 <CAOMZO5D=_L9Dd3gOgQssKBN5TouGqOx+zJnwr+-1HQrVT_yLRQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAOMZO5D=_L9Dd3gOgQssKBN5TouGqOx+zJnwr+-1HQrVT_yLRQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Steve Twiss <stwiss.opensource@diasemi.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, LINUX-KERNEL <linux-kernel@vger.kernel.org>, LINUX-SERIAL <linux-serial@vger.kernel.org>, Lucas Stach <l.stach@pengutronix.de>, Support Opensource <Support.Opensource@diasemi.com>
List-Id: linux-serial@vger.kernel.org

Hey Fabio,

On Wed, May 24, 2017 at 08:52:50AM -0300, Fabio Estevam wrote:
> On Wed, May 24, 2017 at 7:32 AM, Steve Twiss
> <stwiss.opensource@diasemi.com> wrote:
> 
> > The USB to UART connection gets corrupted.
> > If this patch is applied to the kernel, the i.MX6 Q (quad), and only this board as far as
> > we know, starts to fail. This does *not* change the i.MX6DL and other sabre boards
> > have been tested on kernelci.org and do not see a problem.
> >
> > An NXP/Freescale SABRESD i.MX6 Q board is requred.
> >
> > My system for testing is to TFTP the Linux kernel over an ethernet connection. The
> > U-boot executes okay and the UART is working at that point. When the kernel loads
> > the console trace becomes garbled, in the sense that I get the some characters being
> > output to the console, in the style of the kernel starting up, but they are not correct.
> >
> > I expect the kernel has started ok, but I am unable to read/write through the UART
> > console because of corruptions.
> >
> > Console log with the output I am seeing with linux-next/v4.12-rc2
> > --- 8< ---
> > U-Boot 2009.08-00001-gf65536a (Jan 12 2015 - 15:47:19)
> 
> Thanks for your detailed explanation.
> 
> I also have a mx6q sabresd board here, but the error did not happen
> when I use a recent U-Boot version.
> 
> I would like to use the same U-Boot version here as well to help
> debugging this problem.
> 
> Could you please let me know which 2009.08 branch you used? Is it any
> one from git.freescale.com
> http://git.freescale.com/git/cgit.cgi/imx/uboot-imx.git/refs/heads ?

The problem is that RFDIV, RXTL and TXTL are overwritten in the UFCR
register.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
