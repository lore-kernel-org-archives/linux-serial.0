From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [regression, bisected] 4.11+ imx uarts broken
Date: Tue, 9 May 2017 16:31:29 +0200
Message-ID: <20170509143129.qhv664qmedjwlaym@pengutronix.de>
References: <f6fded83-f062-94da-ec1b-b2ab6e6c5101@nextfour.com>
 <20170509071435.kxt6pjlglzinf2w5@pengutronix.de>
 <a1fa7693-c9e9-fea8-fbb7-a20ebf1dd287@nextfour.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <a1fa7693-c9e9-fea8-fbb7-a20ebf1dd287@nextfour.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mika =?iso-8859-1?Q?Penttil=E4?= <mika.penttila@nextfour.com>
Cc: kernel@pengutronix.de, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Tue, May 09, 2017 at 10:25:40AM +0300, Mika Penttilä wrote:
> On 05/09/2017 10:14 AM, Uwe Kleine-König wrote:
> > Hello Mika,
> > 
> > On Tue, May 09, 2017 at 07:18:09AM +0300, Mika Penttilä wrote:
> >> The following commit e61c38d85b7 makes the uarts on i.MX6 nonfunctional (no data transmitted or received). 
> >> With e61c38d85b7 reverted the uarts work ok.
> >>
> >> -------------------
> >> commit e61c38d85b7392e033ee03bca46f1d6006156175
> >> Author: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> >> Date:   Tue Apr 4 11:18:51 2017 +0200
> >>
> >>     serial: imx: setup DCEDTE early and ensure DCD and RI irqs to be off
> >>  
> >> --------------------
> > 
> > are you operating the UART in DTE or DCE mode? Does this affect all
> > UARTs or only those that are not used in the bootloader?
> 
> I am operating in DCE mode. The debug/console uart works ok, but two others don't.
> 
> > 
> > Looking at the patch I wonder if setting IMX21_UCR3_RXDMUXSEL |
> > UCR3_ADNIMP is missing for you.
> > 
> 
> Probably yes, but I can verify this later and get back to you.

can you please test this patch:

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 33509b4beaec..2182548ff0e1 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -2193,9 +2193,14 @@ static int serial_imx_probe(struct platform_device *pdev)
 		 */
 		writel(IMX21_UCR3_RXDMUXSEL | UCR3_ADNIMP | UCR3_DSR,
 		       sport->port.membase + UCR3);
-
 	} else {
+		unsigned long ucr3 = UCR3_DSR;
+
+		if (!is_imx1_uart(sport))
+			ucr3 |= IMX21_UCR3_RXDMUXSEL | UCR3_ADNIMP;
+
 		writel(0, sport->port.membase + UFCR);
+		writel(ucr3, sport->port.membase + UCR3);
 	}
 
 	clk_disable_unprepare(sport->clk_ipg);

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
