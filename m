From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [v7] serial: 8250_dw: Add support for big-endian MMIO accesses
Date: Sat, 17 Oct 2015 21:06:14 -0700
Message-ID: <20151018040614.GA15152@kroah.com>
References: <1444113590-19722-1-git-send-email-noamc@ezchip.com>
 <1444121610-11832-1-git-send-email-noamc@ezchip.com>
 <1444121610-11832-2-git-send-email-noamc@ezchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1444121610-11832-2-git-send-email-noamc@ezchip.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Noam Camus <noamc@ezchip.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, jslaby@suse.com, peter@hurleysoftware.com, fransklaver@gmail.com, Alexey.Brodkin@synopsys.com, vgupta@synopsys.com
List-Id: linux-serial@vger.kernel.org

On Tue, Oct 06, 2015 at 11:53:30AM +0300, Noam Camus wrote:
> From: Noam Camus <noamc@ezchip.com>
> 
> Add support for UPIO_MEM32BE in addition to UPIO_MEM32.
> dw8250_serial_out32() extra functionality that is not part of
> the 8250 core driver was moved to new function called
> dw8250_check_LCR().
> 
> For big endian we use 2 new accessors similar to little endian,
> called dw8250_serial_out32be() and dw8250_serial_in32be().
> Both little and big endian accessors use dw8250_check_LCR()
> for their dw8250_serial_out32{,be}().
> 
> In addition I added another 2 accessors inside private_data field of
> uart_port. This second level accessors are set during probe in
> private_data field of uart_port. Now any direct call to readl/writel
> is replaced with those accessors which are endianness aware.
> 
> Last issue:
> readl() for UCV and CPR will not work for port type UPIO_MEM32BE.
> Instead we use the serial_in32() accessor which is initialized
> properly according to endianness.
> 
> Signed-off-by: Noam Camus <noamc@ezchip.com>
> ---
>  drivers/tty/serial/8250/8250_dw.c |   72 ++++++++++++++++++++++++++++++++----
>  1 files changed, 64 insertions(+), 8 deletions(-)

This patch still doesn't apply at all to my tty-next branch, what are
you making it against?

Please fix it up and resend.

thanks,

greg k-h
