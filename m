From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 1/2] serial: mps2-uart: move to dynamic port allocation
Date: Wed, 30 Jan 2019 10:24:05 +0100
Message-ID: <20190130092405.GA27385@kroah.com>
References: <1548425597-38175-1-git-send-email-vladimir.murzin@arm.com>
 <1548425597-38175-2-git-send-email-vladimir.murzin@arm.com>
 <20190130082753.GA24317@kroah.com>
 <0bea8e14-9ade-aed4-c41e-f02ab0b81d24@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <0bea8e14-9ade-aed4-c41e-f02ab0b81d24@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Vladimir Murzin <vladimir.murzin@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, sudeep.holla@arm.com
List-Id: linux-serial@vger.kernel.org

On Wed, Jan 30, 2019 at 08:58:53AM +0000, Vladimir Murzin wrote:
> On 1/30/19 8:27 AM, Greg KH wrote:
> > On Fri, Jan 25, 2019 at 02:13:16PM +0000, Vladimir Murzin wrote:
> >> Some designs, like MPS3, expose number of virtual serial ports which
> >> already close or exceeds MPS2_MAX_PORTS. Increasing MPS2_MAX_PORTS
> >> would have negative impact (in terms of memory consumption) on tiny
> >> MPS2 platform which, in fact, has only one physically populated UART.
> >>
> >> Start with converting existent static port array to idr. As a bonus it
> >> make driver not to fail in case when no alias was specified in device
> >> tree.
> >>
> >> Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
> >> ---
> >>  drivers/tty/serial/mps2-uart.c | 47 ++++++++++++++++++++++++++++--------------
> >>  1 file changed, 31 insertions(+), 16 deletions(-)
> >>
> >> diff --git a/drivers/tty/serial/mps2-uart.c b/drivers/tty/serial/mps2-uart.c
> >> index 9f8f637..6da0633 100644
> >> --- a/drivers/tty/serial/mps2-uart.c
> >> +++ b/drivers/tty/serial/mps2-uart.c
> >> @@ -22,6 +22,7 @@
> >>  #include <linux/serial_core.h>
> >>  #include <linux/tty_flip.h>
> >>  #include <linux/types.h>
> >> +#include <linux/idr.h>
> >>  
> >>  #define SERIAL_NAME	"ttyMPS"
> >>  #define DRIVER_NAME	"mps2-uart"
> >> @@ -397,7 +398,7 @@ static const struct uart_ops mps2_uart_pops = {
> >>  	.verify_port = mps2_uart_verify_port,
> >>  };
> >>  
> >> -static struct mps2_uart_port mps2_uart_ports[MPS2_MAX_PORTS];
> >> +static DEFINE_IDR(ports_idr);
> > 
> > You forgot to call idr_destroy() when your code unloads :(
> 
> Hmm, but code doesn't unload since ce87122911f8 ("serial: mps2-uart: make driver explicitly non-modular")
> or I'm missing something?

Ugh, ok, nevermind, I missed that, sorry.

greg k-h
