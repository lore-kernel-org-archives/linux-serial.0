From: Steve Twiss <stwiss.opensource@diasemi.com>
Subject: RE: [PATCH V1] serial: imx: revert setup DCEDTE early and ensure
 DCD and RI irqs to be off
Date: Tue, 23 May 2017 14:28:11 +0000
Message-ID: <6ED8E3B22081A4459DAC7699F3695FB7018CD8D303@SW-EX-MBX02.diasemi.com>
References: <20170523123145.E268B3FAD4@swsrvapps-01.diasemi.com>
 <20170523140941.l6cjvfdsvsg76cbx@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170523140941.l6cjvfdsvsg76cbx@pengutronix.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, LINUX-KERNEL <linux-kernel@vger.kernel.org>, LINUX-SERIAL <linux-serial@vger.kernel.org>, Lucas Stach <l.stach@pengutronix.de>, Support Opensource <Support.Opensource@diasemi.com>, "kernel@pengutronix.de" <kernel@pengutronix.de>
List-Id: linux-serial@vger.kernel.org

Hi Uwe,

Thanks for your quick response.

On 23 May 2017 15:10, Uwe Kleine-König wrote:
> Subject: Re: [PATCH V1] serial: imx: revert setup DCEDTE early and ensure DCD and RI irqs to be off
> On Tue, May 23, 2017 at 01:17:26PM +0100, Steve Twiss wrote:
> >
> > Revert the commit e61c38d85b7392e ("serial: imx: setup DCEDTE early and
> > ensure DCD and RI irqs to be off")
> >
> > The patch submitted to setup DCEDTE early and ensure DCD and RI irqs to
> > be off, causes a serial console display problem the i.MX6Q SABRESD board.
> > The console becomes unreadable and unwritable.
> >
> > Tested-by: Steve Twiss <stwiss.opensource@diasemi.com>
> > Signed-off-by: Steve Twiss <stwiss.opensource@diasemi.com>
> 
> You're not the first to report this issue but you still have the chance
> to be the first to test a suggested patch for it.

I've just applied your patch against a clean linux-next/v4.12-rc2
I added your patch ...

> 	http://marc.info/?l=linux-serial&m=149434029912947&w=2

(this one?)

diff --git a/gp_sparse/linux-next/v4.12-rc2/drivers/tty/serial/imx.c b/gp_sparse/linux-next/v4.12-rc2/drivers/tty/serial/imx.c
index 33509b4..2182548 100644
--- a/gp_sparse/linux-next/v4.12-rc2/drivers/tty/serial/imx.c
+++ b/gp_sparse/linux-next/v4.12-rc2/drivers/tty/serial/imx.c
@@ -2193,9 +2193,14 @@ static int serial_imx_probe(struct platform_device *pdev)
                 */
                writel(IMX21_UCR3_RXDMUXSEL | UCR3_ADNIMP | UCR3_DSR,
                       sport->port.membase + UCR3);
-
        } else {
+               unsigned long ucr3 = UCR3_DSR;
+
+               if (!is_imx1_uart(sport))
+                       ucr3 |= IMX21_UCR3_RXDMUXSEL | UCR3_ADNIMP;
+
                writel(0, sport->port.membase + UFCR);
+               writel(ucr3, sport->port.membase + UCR3);
        }
 
        clk_disable_unprepare(sport->clk_ipg);

I've added that to my working directory, but I am still seeing the corrupted
console output on the i.MX6 Q (quad) board.

Best regards
Steve
