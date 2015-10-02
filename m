From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] serial: Enable Freescale 16550 workaround on arm
Date: Sat, 03 Oct 2015 00:22:38 +0200
Message-ID: <5286230.7Dic6OMiYf@wuerfel>
References: <20151002001616.GA3885@home.buserror.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20151002001616.GA3885@home.buserror.net>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org
Cc: Scott Wood <scottwood@freescale.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Stuart Yoder <stuart.yoder@freescale.com>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Thursday 01 October 2015 19:16:16 Scott Wood wrote:
> 
> +#ifdef CONFIG_SERIAL_8250_FSL
> +       if (of_device_is_compatible(np, "fsl,ns16550") ||
> +           of_device_is_compatible(np, "fsl,16550-FIFO64"))
> +               port->handle_irq = fsl8250_handle_irq;
> +#endif
> +
> 

Can you change this to use

	if (IS_ENABLED(CONFIG_SERIAL_8250_FSL)) && ...

The resulting code will be the same, it just get a little easier
on the eye.

Other than that, I wonder if we should do this completely differently
and have the respective entries in of_platform_serial_table[] with
an appropriate PORT_* constant to handle the freescale case.

	Arnd
