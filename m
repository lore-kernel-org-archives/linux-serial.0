From: Graeme Gregory <gg@slimlogic.co.uk>
Subject: Re: [RFC PATCH 00/10] drivers: PL011: add SBSA subset support
Date: Tue, 30 Sep 2014 11:11:12 +0100
Message-ID: <20140930101112.GH3293@xora-haswell.xora.org.uk>
References: <1411129283-17219-1-git-send-email-andre.przywara@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1411129283-17219-1-git-send-email-andre.przywara@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Andre Przywara <andre.przywara@arm.com>
Cc: rob.herring@linaro.org, Russell King <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On Fri, Sep 19, 2014 at 01:21:13PM +0100, Andre Przywara wrote:
> (This version has still issues, but I'd like to have feedback on
> the general feasibility of this approach before wasting even more
> time on debugging).
> 
> The ARM Server Base System Architecture[1] document describes a
> generic UART which is a subset of the PL011 UART.
> It lacks DMA support, baud rate control and modem status line
> control, among other things.
> The idea is to move the UART initialization and setup into the
> firmware (which does this job today already) and let the kernel just
> use the UART for sending and receiving characters.
> 
> This patchset is an attempt to integrate support for this UART subset
> into the existing PL011 driver - basically by refactoring some
> functions and providing a new uart_ops structure for it. It also has
> a separate probe function to be not dependent on AMBA/PrimeCell.
> Beside the obvious effect of code sharing it has the advantage of not
> introducing another serial device prefix, so it can go with ttyAMA,
> which seems to be pretty common.
> 
> There is still one issue in bringing up the UART. On the PL011 we
> send a dummy character via the loopback facility with the FIFOs
> disabled to get things going, but both FIFO control and loopback are
> outside of the SBSA spec. I consider this loopback approach a kludge
> anyway, but am struggling to find a better way of fixing this due to
> my lack of understanding of the TTY/serial layer.
> If someone with more wisdom could enlighten me, I would be grateful.
> 
This is the killer issue at the moment it seems, once we get to usespace
the tty does not work.

> 
> Patch 1/10 contains a bug fix which applies to the PL011 part also,
> it should be considered regardless of the rest of the series.
> Patch 2-7 refactor some PL011 functions by splitting them up into
> smaller pieces, so that most the code can be reused later by the SBSA
> part.
> Patch 8 and 9 introduce two new properties for the vendor structure,
> this is for SBSA functionality which cannot be controlled by
> separate uart_ops members only.
> Patch 10 then finally drops in the SBSA specific code, by providing
> a new uart_ops, vendor struct and probe function for it.
> 
> Please have a look and tell me whether this SBSA driver approach has
> any future.
> 

The patch series looks reasonable to me based on my very limited
knowledge of the tty layer and the pl011 UART.

Graeme


> Regards,
> Andre
> 
> Andre Przywara (10):
>   drivers: PL011: avoid potential unregister_driver call
>   drivers: PL011: refactor pl011_startup()
>   drivers: PL011: refactor pl011_shutdown()
>   drivers: PL011: refactor pl011_set_termios()
>   drivers: PL011: refactor pl011_probe()
>   drivers: PL011: replace UART_MIS reading with _RIS & _IMSC
>   drivers: PL011: move cts_event workaround into separate function
>   drivers: PL011: allow avoiding UART enabling/disabling
>   drivers: PL011: allow to supply fixed option string
>   drivers: PL011: add support for the ARM SBSA generic UART
> 
>  .../devicetree/bindings/serial/arm_sbsa_uart.txt   |    9 +
>  drivers/tty/serial/amba-pl011.c                    |  509 ++++++++++++++------
>  2 files changed, 380 insertions(+), 138 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/serial/arm_sbsa_uart.txt
> 
> -- 
> 1.7.9.5
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
