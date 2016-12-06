From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [STLinux Kernel] [PATCH 2/3] serial: st-asc: Provide RTS
 functionality
Date: Tue, 6 Dec 2016 12:45:43 +0000
Message-ID: <20161206124543.GC25385@dell.home>
References: <20161202141146.31281-1-lee.jones@linaro.org>
 <20161202141146.31281-2-lee.jones@linaro.org>
 <5e652529-8dcb-568e-a748-0ec745099211@st.com>
 <20161206123131.GA15382@griffinp-ThinkPad-X1-Carbon-2nd>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161206123131.GA15382@griffinp-ThinkPad-X1-Carbon-2nd>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Griffin <peter.griffin@linaro.org>
Cc: Patrice Chotard <patrice.chotard@st.com>, gregkh@linuxfoundation.org, jslaby@suse.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel@stlinux.com
List-Id: linux-serial@vger.kernel.org

On Tue, 06 Dec 2016, Peter Griffin wrote:
> On Mon, 05 Dec 2016, Patrice Chotard wrote:
> > On 12/02/2016 03:11 PM, Lee Jones wrote:
> > > Until this point, it has not been possible for serial applications
> > > to toggle the UART RTS line.  This can be useful with certain
> > > configurations. For example, when using a Mezzanine on a Linaro
> > > 96board, RTS line is used to take the the on-board microcontroller
> > 
> > typo "the the on"
> > 
> > > in and out of reset.
> > > 
> > > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > > ---
> > >  drivers/tty/serial/st-asc.c | 14 ++++++++++++++
> > >  1 file changed, 14 insertions(+)
> > > 
> > > diff --git a/drivers/tty/serial/st-asc.c b/drivers/tty/serial/st-asc.c
> > > index 379e5bd..ce46898 100644
> > > --- a/drivers/tty/serial/st-asc.c
> > > +++ b/drivers/tty/serial/st-asc.c
> > > @@ -30,6 +30,7 @@
> > >  #include <linux/of_platform.h>
> > >  #include <linux/serial_core.h>
> > >  #include <linux/clk.h>
> > > +#include <linux/gpio/consumer.h>
> > >  
> > >  #define DRIVER_NAME "st-asc"
> > >  #define ASC_SERIAL_NAME "ttyAS"
> > > @@ -38,6 +39,7 @@
> > >  
> > >  struct asc_port {
> > >  	struct uart_port port;
> > > +	struct gpio_desc *rts;
> > >  	struct clk *clk;
> > >  	unsigned int hw_flow_control:1;
> > >  	unsigned int force_m1:1;
> > > @@ -381,12 +383,16 @@ static unsigned int asc_tx_empty(struct uart_port *port)
> > >  
> > >  static void asc_set_mctrl(struct uart_port *port, unsigned int mctrl)
> > >  {
> > > +	struct asc_port *ascport = to_asc_port(port);
> > > +
> > >  	/*
> > >  	 * This routine is used for seting signals of: DTR, DCD, CTS/RTS
> > >  	 * We use ASC's hardware for CTS/RTS, so don't need any for that.
> > >  	 * Some boards have DTR and DCD implemented using PIO pins,
> > >  	 * code to do this should be hooked in here.
> > >  	 */
> > > +
> > > +	gpiod_set_value(ascport->rts, mctrl & TIOCM_RTS);
> 
> This now puts the code and the comment above out of sync with each
> other.
> 
> However just checking the stih410 datasheet and I don't think this patch
> to control RTS via a GPIO is required anyway.
> 
> The correct way of handling this is to add UART10_RTS and UART10_CTS pins
> to the pinctrl_serial0 group so they are properly configured for their cts/rts
> alternate function. Once the pins are correctly configured, the IP block should
> control the signals correctly like the comment says.

That was the first thing I tried.  It didn't work.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
