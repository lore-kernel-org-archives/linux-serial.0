From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 10/12] tty: amba-pl011: add support for 32-bit register
 access
Date: Mon, 16 Nov 2015 17:52:17 +0000
Message-ID: <20151116175217.GT8644@n2100.arm.linux.org.uk>
References: <20151116173935.GQ8644@n2100.arm.linux.org.uk>
 <E1ZyNls-0003kA-Fe@rmk-PC.arm.linux.org.uk>
 <564A1628.9010900@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <564A1628.9010900@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Timur Tabi <timur@codeaurora.org>
Cc: Peter Hurley <peter@hurleysoftware.com>, Andre Przywara <andre.przywara@arm.com>, Linus Walleij <linus.walleij@linaro.org>, Andrew.Jackson@arm.com, linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Jun Nie <jun.nie@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On Mon, Nov 16, 2015 at 11:45:12AM -0600, Timur Tabi wrote:
> Russell King wrote:
> >Add support for 32-bit register accesses to the AMBA PL011 UART.  This
> >is needed for ZTE UARTs, which require 32-bit accesses as opposed to
> >the more normal 16-bit accesses.
> >
> >Signed-off-by: Russell King<rmk+kernel@arm.linux.org.uk>
> >---
> >  drivers/tty/serial/amba-pl011.c | 15 +++++++++++++--
> >  1 file changed, 13 insertions(+), 2 deletions(-)
> >
> >diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
> >index afa0de7d481f..3470a1e67bbc 100644
> >--- a/drivers/tty/serial/amba-pl011.c
> >+++ b/drivers/tty/serial/amba-pl011.c
> >@@ -93,6 +93,7 @@ static u16 pl011_std_offsets[REG_ARRAY_SIZE] = {
> >  struct vendor_data {
> >  	const u16		*reg_offset;
> >  	unsigned int		ifls;
> >+	bool			access_32b;
> 
> So no love for my suggestion to use port->iotype instead of this new field?
> 
> static void pl011_write(unsigned int val, const struct uart_amba_port *uap,
>     unsigned int reg)
> {
>     void __iomem *addr = uap->port.membase + pl011_reg_to_offset(uap, reg);
> 
>     if (uap->port.iotype == UPIO_MEM32)
>         writel(val, addr);
>     else
>         writew(val, addr);
> }

Well, it looks a bit weird, because we use 16-bit accesses for other
values, and there isn't a UPIO_MEM16 type.  Although that could be
added, it's extending the scope of the patch to touching core files.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
