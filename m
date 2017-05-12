From: Dong Aisheng <dongas86@gmail.com>
Subject: Re: [PATCH 4/6] tty: serial: lpuart: add imx7ulp support
Date: Fri, 12 May 2017 21:28:00 +0800
Message-ID: <20170512132800.GA31087@b29396-OptiPlex-7040>
References: <1494316248-24052-1-git-send-email-aisheng.dong@nxp.com>
 <1494316248-24052-5-git-send-email-aisheng.dong@nxp.com>
 <697fae59cb4e5ff921bb83614325b3f1@agner.ch>
 <CAA+hA=RDjRwwT-O5Y3z-AAQxtPDU7agZdGe6KeFTT=QoW3ufFw@mail.gmail.com>
 <434c613240c36181a828ea090938b8c1@agner.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <434c613240c36181a828ea090938b8c1@agner.ch>
Sender: linux-kernel-owner@vger.kernel.org
To: Stefan Agner <stefan@agner.ch>
Cc: Dong Aisheng <aisheng.dong@nxp.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, gregkh <gregkh@linuxfoundation.org>, jslaby@suse.com, Fugang Duan <fugang.duan@nxp.com>, Mingkai.Hu@nxp.com, yangbo.lu@nxp.com
List-Id: linux-serial@vger.kernel.org

On Wed, May 10, 2017 at 01:37:07PM -0700, Stefan Agner wrote:
> On 2017-05-09 23:14, Dong Aisheng wrote:
> > Hi Stefan,
> > 
> > On Wed, May 10, 2017 at 12:10 PM, Stefan Agner <stefan@agner.ch> wrote:
> >> On 2017-05-09 00:50, Dong Aisheng wrote:
> >>> The lpuart of imx7ulp is basically the same as ls1021a. It's also
> >>> 32 bit width register, but unlike ls1021a, it's little endian.
> >>> Besides that, imx7ulp lpuart has a minor different register layout
> >>> from ls1021a that it has four extra registers (verid, param, global,
> >>> pincfg) located at the beginning of register map, which are currently
> >>> not used by the driver and less to be used later.
> >>>
> >>> To ease the register difference handling, we add a reg_off member
> >>> in lpuart_soc_data structure to represent if the normal
> >>> lpuart32_{read|write} requires plus a offset to hide the issue.
> >>>
> >>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >>> Cc: Jiri Slaby <jslaby@suse.com>
> >>> Cc: Fugang Duan <fugang.duan@nxp.com>
> >>> Cc: Stefan Agner <stefan@agner.ch>
> >>> Cc: Mingkai Hu <Mingkai.Hu@nxp.com>
> >>> Cc: Yangbo Lu <yangbo.lu@nxp.com>
> >>> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> >>> ---
> >>>  drivers/tty/serial/fsl_lpuart.c | 21 ++++++++++++++++++---
> >>>  1 file changed, 18 insertions(+), 3 deletions(-)
> >>>
> >>> diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
> >>> index bddd041..1cdb3f9 100644
> >>> --- a/drivers/tty/serial/fsl_lpuart.c
> >>> +++ b/drivers/tty/serial/fsl_lpuart.c
> >>> @@ -231,7 +231,11 @@
> >>>  #define DEV_NAME     "ttyLP"
> >>>  #define UART_NR              6
> >>>
> >>> +/* IMX lpuart has four extra unused regs located at the beginning */
> >>> +#define IMX_REG_OFF  0x10
> >>> +
> >>>  static bool lpuart_is_be;
> >>> +static u8 lpuart_reg_off;
> >>
> >> Global variables? That hardly works once you have two UARTs...
> >>
> > 
> > lpuart_reg_off is SoC specific and there's no two UART
> > with two different reg offset.
> > 
> >> Instead of adding a fixed offset to any write you could just add the
> >> offset to sport->port.membase...
> >>
> > 
> > That's intended as i don't want the changes to be too intrusive.
> > If adding offset in sport->port.xxx, then we have to change the basic
> > lpuart32_read/write API which is called through the whole driver.
> 
> Every lpuart32_write/read call passes port.membase, so if you offset
> port.membase when it is assigned in probe you should be fine not?
> 

Got your point now and that do seem better.
Thanks for the suggestion.
Will change in V2.

Regards
Dong Aisheng
