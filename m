From: Einar Vading <einar.vading@axis.com>
Subject: Re: serial: imx: half-duplex RS485 operation with RTS active low
Date: Mon, 16 Apr 2018 11:57:14 +0200
Message-ID: <20180416095714.hj6lxdoee3zis3mg@lnxeinarv.se.axis.com>
References: <0e88706a05a302201be396d2f03c3e9e@agner.ch>
 <20180416095436.7mxh4cqdvlyleryr@lnxeinarv.se.axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20180416095436.7mxh4cqdvlyleryr@lnxeinarv.se.axis.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Stefan Agner <stefan@agner.ch>
Cc: linux-arm-kernel@lists.infradead.org, s.hauer@pengutronix.de, baruch@tkos.co.il, linux-serial@vger.kernel.org, u.kleine-koenig@pengutronix.de
List-Id: linux-serial@vger.kernel.org

On Mon, Apr 16, 2018 at 11:54:36AM +0200, Einar Vading wrote:
> On Mon, Apr 16, 2018 at 11:14:32AM +0200, Stefan Agner wrote:

Forgot to mention that we are not using DTE-de mode. We tried to but failed.

> > Hi,
> > 
> > Using upstream I noticed that RS-485 does not work in the default
> > configuration for our platforms (Toradex Apalis/Colibri). Closer
> > debugging shows that it is related to "serial: imx: default to half
> > duplex rs485".
> 
> We where struggling a bit with half duplex rs485 too a while ago.
> > 
> > We use the i.MX UART in DTE mode and control the RS-485 transceiver
> > using the RTS signal in low-active mode.
> > 
> > 	uart-has-rtscts;
> > 	fsl,dte-mode;
> > 	linux,rs485-enabled-at-boot-time;
> > 	rs485-rts-active-low;
> > 
> > Using this setting leads to the RTS signal not getting asserted (the
> > oscilloscope only shows a very short fluke before the start bit is
> > sent).
> 
> I think this is what we had too. But if I recall we where supposed to be
> active-high but I think the behavior is the same either way.
> > 
> > However, using
> > 
> > 	uart-has-rtscts;
> > 	fsl,dte-mode;
> > 	linux,rs485-enabled-at-boot-time;
> > 	rs485-rts-active-low;
> > 	rs485-rx-during-tx;
> > 
> > Asserts the RTS signal low active just fine...
> 
> We have a (RTS active high) configuration working for us now with only
> 
>     uart-has-rtscts
> 
> in DT, and then when using the port we do
> 
>     struct serial_rs485 rs485conf;
>     memset(&rs485conf, 0x00, sizeof(struct serial_rs485));
> 
>     rs485conf.flags |= SER_RS485_ENABLED;
>     rs485conf.flags |= SER_RS485_RTS_ON_SEND;
>     rs485conf.flags &= ~(SER_RS485_RTS_AFTER_SEND);
> 
>     f_debug("Calling ioctl...");
>     if (ioctl (fd, TIOCSRS485, &rs485conf) < 0) {
>       f_critical("ioctl serial_rs485 failed");
>       return -1;
>     }
> 
> Hope it helps.
> > 
> > Is this a known problem? Any idea where that could come from? It looks
> > as if the receiver part is actually enabling RTS...?
> > 
> > Also, isn't enabling RX even in half-duplex mode quite common in order
> > to detect collisions?
> > 
> > --
> > Stefan
> 
> // Einar
// Einar
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-serial" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-serial" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
