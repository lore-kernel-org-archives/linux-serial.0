From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2] serial: 8250_dw: support high baudrates if possible
Date: Thu, 10 Jul 2014 16:13:42 -0700
Message-ID: <20140710231342.GA9557@kroah.com>
References: <1404227734-14180-1-git-send-email-elder@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1404227734-14180-1-git-send-email-elder@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alex Elder <elder@linaro.org>
Cc: heikki.krogerus@linux.intel.com, david.daney@cavium.com, loic.poulain@intel.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Tue, Jul 01, 2014 at 10:15:34AM -0500, Alex Elder wrote:
> Currently the Synopsys DesignWare 8250 driver assumes its UART clock
> runs at a fixed rate.  If a "real" clock was set up using the common
> clock framework, and that clock's rate is adjustable, it may be
> possible to support a wider range of baud rates by changing the
> UART clock rate.
> 
> This is done by setting up a uart_port->set_termios method that
> requests a clock rate change if a different rate might make it
> more likely to achieve a specified baud.  A new function
> dw8250_adjustable_clk() determines whether such clock rate
> adjustment is an option.
> 
> Signed-off-by: Alex Elder <elder@linaro.org>
> ---
> v2: Limit clock changing to specific compatible devices.
> 
>  drivers/tty/serial/8250/8250_dw.c | 57 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 57 insertions(+)

This no longer applies due to other changes in this driver.  Can you
please refresh it against my tty-next branch of the tty.git tree and
resend?

thanks,

greg k-h
