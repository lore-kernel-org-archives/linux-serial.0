From: Andrew Jones <drjones@redhat.com>
Subject: Re: [RFC PATCH v3] tty: pl011: Avoid spuriously stuck-off interrupts
Date: Wed, 25 Apr 2018 16:59:28 +0200
Message-ID: <20180425145928.jnrlj3232xmxqix6@kamzik.brq.redhat.com>
References: <1524490888-849-1-git-send-email-Dave.Martin@arm.com>
 <CAFEAcA8Q97YNKomCgkujgoY0MoES3edHoFEk_jjXGMCdzBpd9w@mail.gmail.com>
 <20180425122000.cts26gtvjuje4j7f@kamzik.brq.redhat.com>
 <CAFXrp_djBYwrp664A8tLrqZDw=3L6w4Uadk-Rin_ZTwfE2QwGw@mail.gmail.com>
 <20180425141010.GO16308@e103592.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20180425141010.GO16308@e103592.cambridge.arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Dave Martin <Dave.Martin@arm.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Ciro Santilli <ciro.santilli@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Russell King <linux@armlinux.org.uk>, Wei Xu <xuwei5@hisilicon.com>, linux-serial@vger.kernel.org, arm-mail-list <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

On Wed, Apr 25, 2018 at 03:10:14PM +0100, Dave Martin wrote:
> On Wed, Apr 25, 2018 at 01:47:42PM +0100, Ciro Santilli wrote:
> > On Wed, Apr 25, 2018 at 1:20 PM, Andrew Jones <drjones@redhat.com> wrote:
> > > On Mon, Apr 23, 2018 at 02:49:30PM +0100, Peter Maydell wrote:
> > >> On 23 April 2018 at 14:41, Dave Martin <Dave.Martin@arm.com> wrote:
> > >> > This is an update to a previous RFC v2 [1], to fix a problem observed by
> > >> > the qemu community that causes serial input to hang when booting a
> > >> > simulated system with data already queued in the UART FIFO [2].
> > >> >
> > >> > After discussion, I decided that the approach in [1] was over-
> > >> > engineered: it tries to preserve a guarantee that people shouldn't be
> > >> > relying on anyway, namely that data sent to the UART prior to kernel
> > >> > boot will be received by the kernel; or more generally that data
> > >> > received by the UART while the pl011 driver is not opened will be
> > >> > received (either intact or at all) by the driver.
> > >> >
> > >> > If anyone can please test the following and let me know the results,
> > >> > that would be much appreciated!
> > >> >
> > >> >  a) Check that you can still reproduce the bug on mainline without this
> > >> >     patch.
> > >> >
> > >> >  b) Check whether this patch fixes the problem.
> > >>
> > >> Thanks. I'm cc'ing Ciro and Drew, who are the two people I
> > >> recall reporting this issue to me.
> > >> Link to the patch for their benefit:
> > >>  http://lists.infradead.org/pipermail/linux-arm-kernel/2018-April/573120.html
> > >>
> > >
> > > Hi Dave,
> > >
> > > v3 does not resolve the issue for me. v2 does, and, fwiw, v3 applied on
> > > top of v2 (i.e. applying both), still works.
> > >
> > 
> > I also confirm that v2 + v3 on top of Linux kernel v4.16, QEMU v2.11.0
> > solves the problem on arm and aarch64, otherwise if I hit Ctrl + C
> > during boot my terminal become irresponsive after boot. Test setup:
> > https://github.com/cirosantilli/linux-kernel-module-cheat/tree/14965a40d27c8d9d1ff5b023ace827b288a024ef
> 
> Hmmm, interesting.
> 
> Looking at the code, it looks like RXIS is explicitly cleared twice,
> once in pl011_hwinit() and once in pl011_startup().  The CONFIG_POLL
> code uses hwinit alone, and I'm not sure exactly what properties it
> relies on.
> 
> To be most robust, perhaps we should drain the RX FIFO in both places.
> 
> Can you try applying this on top of the branch and see what happens?
> 
> Cheers
> ---Dave
> 
> 
> diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
> index 73e6f44..841afbd 100644
> --- a/drivers/tty/serial/amba-pl011.c
> +++ b/drivers/tty/serial/amba-pl011.c
> @@ -1652,6 +1652,19 @@ static void pl011_put_poll_char(struct uart_port *port,
>  
>  #endif /* CONFIG_CONSOLE_POLL */
>  
> +/*
> + * RXIS is asserted only when the RX FIFO transitions from below to
> + * above the trigger threshold.  If the RX FIFO is already full to the
> + * threshold this can't happen and RXIS will now be stuck off.
> + * Unless polling the UART, use this function to drain the RX FIFO
> + * explicitly after clearing RXIS.
> + */
> +static void pl011_drain_rx_fifo(struct uart_amba_port *uap)
> +{
> +	while (!(pl011_read(uap, REG_FR) & UART01x_FR_RXFE))
> +		pl011_read(uap, REG_DR);
> +}
> +
>  static int pl011_hwinit(struct uart_port *port)
>  {
>  	struct uart_amba_port *uap =
> @@ -1674,15 +1687,7 @@ static int pl011_hwinit(struct uart_port *port)
>  	pl011_write(UART011_OEIS | UART011_BEIS | UART011_PEIS |
>  		    UART011_FEIS | UART011_RTIS | UART011_RXIS,
>  		    uap, REG_ICR);
> -
> -	/*
> -	 * RXIS is asserted only when the RX FIFO transitions from below
> -	 * to above the trigger threshold.  If the RX FIFO is already
> -	 * full to the threshold this can't happen and RXIS will now be
> -	 * stuck off.  Drain the FIFO explicitly to fix this:
> -	 */
> -	while (!(pl011_read(uap, REG_FR) & UART01x_FR_RXFE))
> -		pl011_read(uap, REG_DR);
> +	pl011_drain_rx_fifo(uap);
>  
>  	/*
>  	 * Save interrupts enable mask, and enable RX interrupts in case if
> @@ -1740,6 +1745,8 @@ static void pl011_enable_interrupts(struct uart_amba_port *uap)
>  
>  	/* Clear out any spuriously appearing RX interrupts */
>  	pl011_write(UART011_RTIS | UART011_RXIS, uap, REG_ICR);
> +	pl011_drain_rx_fifo(uap);
> +
>  	uap->im = UART011_RTIM;
>  	if (!pl011_dma_rx_running(uap))
>  		uap->im |= UART011_RXIM;
> 
> 
>

This worked for me. To be clear, I applied the following, and nothing
else, to my base kernel for the test

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 111e6a9..d64b64f 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -1672,6 +1672,19 @@ static void pl011_put_poll_char(struct uart_port *port,
 
 #endif /* CONFIG_CONSOLE_POLL */
 
+/*
+ * RXIS is asserted only when the RX FIFO transitions from below to
+ * above the trigger threshold.  If the RX FIFO is already full to the
+ * threshold this can't happen and RXIS will now be stuck off.
+ * Unless polling the UART, use this function to drain the RX FIFO
+ * explicitly after clearing RXIS.
+ */
+static void pl011_drain_rx_fifo(struct uart_amba_port *uap)
+{
+       while (!(pl011_read(uap, REG_FR) & UART01x_FR_RXFE))
+               pl011_read(uap, REG_DR);
+}
+
 static int pl011_hwinit(struct uart_port *port)
 {
        struct uart_amba_port *uap =
@@ -1695,6 +1708,8 @@ static int pl011_hwinit(struct uart_port *port)
                    UART011_FEIS | UART011_RTIS | UART011_RXIS,
                    uap, REG_ICR);
 
+       pl011_drain_rx_fifo(uap);
+
        /*
         * Save interrupts enable mask, and enable RX interrupts in case if
         * the interrupt is used for NMI entry.
@@ -1751,6 +1766,8 @@ static void pl011_enable_interrupts(struct uart_amba_port *uap)
 
        /* Clear out any spuriously appearing RX interrupts */
        pl011_write(UART011_RTIS | UART011_RXIS, uap, REG_ICR);
+       pl011_drain_rx_fifo(uap);
+
        uap->im = UART011_RTIM;
        if (!pl011_dma_rx_running(uap))
                uap->im |= UART011_RXIM;


Thanks,
drew 
