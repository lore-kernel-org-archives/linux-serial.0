From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] serial: 8250_pci: Use symbolic constants for EXAR's MPIO
 registers
Date: Wed, 31 Aug 2016 15:58:39 +0200
Message-ID: <20160831135839.GB13298@kroah.com>
References: <8a6646ac-2ba7-cc1b-b547-776fb263ccdd@siemens.com>
 <20160726201420.GA19389@kroah.com>
 <055cacef-1ab0-0541-030d-d2313763cb2e@siemens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <055cacef-1ab0-0541-030d-d2313763cb2e@siemens.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: linux-serial@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Tue, Jul 26, 2016 at 10:44:56PM +0200, Jan Kiszka wrote:
> On 2016-07-26 22:14, Greg Kroah-Hartman wrote:
> > On Tue, Jul 26, 2016 at 09:50:37PM +0200, Jan Kiszka wrote:
> >> Less magics that only require comments.
> >>
> >> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> >> ---
> >>  drivers/tty/serial/8250/8250_pci.c | 42 +++++++++++++++++++-------------------
> >>  include/uapi/linux/serial_reg.h    | 13 ++++++++++++
> >>  2 files changed, 34 insertions(+), 21 deletions(-)
> >>
> >> diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
> >> index c1d4a8f..7f77060 100644
> >> --- a/drivers/tty/serial/8250/8250_pci.c
> >> +++ b/drivers/tty/serial/8250/8250_pci.c
> >> @@ -1796,18 +1796,18 @@ pci_xr17v35x_setup(struct serial_private *priv,
> >>  	 * Setup Multipurpose Input/Output pins.
> >>  	 */
> >>  	if (idx == 0) {
> >> -		writeb(0x00, p + 0x8f); /*MPIOINT[7:0]*/
> >> -		writeb(0x00, p + 0x90); /*MPIOLVL[7:0]*/
> >> -		writeb(0x00, p + 0x91); /*MPIO3T[7:0]*/
> >> -		writeb(0x00, p + 0x92); /*MPIOINV[7:0]*/
> >> -		writeb(0x00, p + 0x93); /*MPIOSEL[7:0]*/
> >> -		writeb(0x00, p + 0x94); /*MPIOOD[7:0]*/
> >> -		writeb(0x00, p + 0x95); /*MPIOINT[15:8]*/
> >> -		writeb(0x00, p + 0x96); /*MPIOLVL[15:8]*/
> >> -		writeb(0x00, p + 0x97); /*MPIO3T[15:8]*/
> >> -		writeb(0x00, p + 0x98); /*MPIOINV[15:8]*/
> >> -		writeb(0x00, p + 0x99); /*MPIOSEL[15:8]*/
> >> -		writeb(0x00, p + 0x9a); /*MPIOOD[15:8]*/
> >> +		writeb(0x00, p + UART_EXAR_MPIOINT_7_0);
> >> +		writeb(0x00, p + UART_EXAR_MPIOLVL_7_0);
> >> +		writeb(0x00, p + UART_EXAR_MPIO3T_7_0);
> >> +		writeb(0x00, p + UART_EXAR_MPIOINV_7_0);
> >> +		writeb(0x00, p + UART_EXAR_MPIOSEL_7_0);
> >> +		writeb(0x00, p + UART_EXAR_MPIOOD_7_0);
> >> +		writeb(0x00, p + UART_EXAR_MPIOINT_15_8);
> >> +		writeb(0x00, p + UART_EXAR_MPIOLVL_15_8);
> >> +		writeb(0x00, p + UART_EXAR_MPIO3T_15_8);
> >> +		writeb(0x00, p + UART_EXAR_MPIOINV_15_8);
> >> +		writeb(0x00, p + UART_EXAR_MPIOSEL_15_8);
> >> +		writeb(0x00, p + UART_EXAR_MPIOOD_15_8);
> >>  	}
> >>  	writeb(0x00, p + UART_EXAR_8XMODE);
> >>  	writeb(UART_FCTR_EXAR_TRGD, p + UART_EXAR_FCTR);
> >> @@ -1843,20 +1843,20 @@ pci_fastcom335_setup(struct serial_private *priv,
> >>  		switch (priv->dev->device) {
> >>  		case PCI_DEVICE_ID_COMMTECH_4222PCI335:
> >>  		case PCI_DEVICE_ID_COMMTECH_4224PCI335:
> >> -			writeb(0x78, p + 0x90); /* MPIOLVL[7:0] */
> >> -			writeb(0x00, p + 0x92); /* MPIOINV[7:0] */
> >> -			writeb(0x00, p + 0x93); /* MPIOSEL[7:0] */
> >> +			writeb(0x78, p + UART_EXAR_MPIOLVL_7_0);
> >> +			writeb(0x00, p + UART_EXAR_MPIOINV_7_0);
> >> +			writeb(0x00, p + UART_EXAR_MPIOSEL_7_0);
> >>  			break;
> >>  		case PCI_DEVICE_ID_COMMTECH_2324PCI335:
> >>  		case PCI_DEVICE_ID_COMMTECH_2328PCI335:
> >> -			writeb(0x00, p + 0x90); /* MPIOLVL[7:0] */
> >> -			writeb(0xc0, p + 0x92); /* MPIOINV[7:0] */
> >> -			writeb(0xc0, p + 0x93); /* MPIOSEL[7:0] */
> >> +			writeb(0x00, p + UART_EXAR_MPIOLVL_7_0);
> >> +			writeb(0xc0, p + UART_EXAR_MPIOINV_7_0);
> >> +			writeb(0xc0, p + UART_EXAR_MPIOSEL_7_0);
> >>  			break;
> >>  		}
> >> -		writeb(0x00, p + 0x8f); /* MPIOINT[7:0] */
> >> -		writeb(0x00, p + 0x91); /* MPIO3T[7:0] */
> >> -		writeb(0x00, p + 0x94); /* MPIOOD[7:0] */
> >> +		writeb(0x00, p + UART_EXAR_MPIOINT_7_0);
> >> +		writeb(0x00, p + UART_EXAR_MPIO3T_7_0);
> >> +		writeb(0x00, p + UART_EXAR_MPIOOD_7_0);
> >>  	}
> >>  	writeb(0x00, p + UART_EXAR_8XMODE);
> >>  	writeb(UART_FCTR_EXAR_TRGD, p + UART_EXAR_FCTR);
> >> diff --git a/include/uapi/linux/serial_reg.h b/include/uapi/linux/serial_reg.h
> >> index 1e5ac4e7..d176448 100644
> >> --- a/include/uapi/linux/serial_reg.h
> >> +++ b/include/uapi/linux/serial_reg.h
> >> @@ -376,5 +376,18 @@
> >>  #define UART_EXAR_TXTRG		0x0a	/* Tx FIFO trigger level write-only */
> >>  #define UART_EXAR_RXTRG		0x0b	/* Rx FIFO trigger level write-only */
> >>  
> >> +#define UART_EXAR_MPIOINT_7_0	0x8f	/* MPIOINT[7:0] */
> >> +#define UART_EXAR_MPIOLVL_7_0	0x90	/* MPIOLVL[7:0] */
> >> +#define UART_EXAR_MPIO3T_7_0	0x91	/* MPIO3T[7:0] */
> >> +#define UART_EXAR_MPIOINV_7_0	0x92	/* MPIOINV[7:0] */
> >> +#define UART_EXAR_MPIOSEL_7_0	0x93	/* MPIOSEL[7:0] */
> >> +#define UART_EXAR_MPIOOD_7_0	0x94	/* MPIOOD[7:0] */
> >> +#define UART_EXAR_MPIOINT_15_8	0x95	/* MPIOINT[15:8] */
> >> +#define UART_EXAR_MPIOLVL_15_8	0x96	/* MPIOLVL[15:8] */
> >> +#define UART_EXAR_MPIO3T_15_8	0x97	/* MPIO3T[15:8] */
> >> +#define UART_EXAR_MPIOINV_15_8	0x98	/* MPIOINV[15:8] */
> >> +#define UART_EXAR_MPIOSEL_15_8	0x99	/* MPIOSEL[15:8] */
> >> +#define UART_EXAR_MPIOOD_15_8	0x9a	/* MPIOOD[15:8] */
> >> +
> > 
> > Why are you putting these in a user api file?  I know it matches the
> > existing ones, but is this something that userspace really cares about?
> 
> Very valid question, and I was wondering the same. Maybe 95% of this
> header is just lazy leftover from 607ca46e97.
> 
> I'm fine with starting off some include/linux/serial_reg.h, provided
> someone gives me a hint what should be moved - I'm not very familiar
> with the serial kernel ABI. Or I just start it off with those defines
> above. You choose.

Just put them in the driver itself for now, no need to add them when no
one is asking for them :)

thanks,

greg k-h
