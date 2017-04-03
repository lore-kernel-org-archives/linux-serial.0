From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 2/2] drivers/serial: Add driver for Aspeed virtual UART
Date: Mon, 3 Apr 2017 09:25:16 -0500
Message-ID: <20170403142516.5rqv7yznkapryteu@rob-hp-laptop>
References: <20170328054458.29341-1-joel@jms.id.au>
 <20170328054458.29341-3-joel@jms.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170328054458.29341-3-joel@jms.id.au>
Sender: linux-kernel-owner@vger.kernel.org
To: Joel Stanley <joel@jms.id.au>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Mark Rutland <mark.rutland@arm.com>, Jeremy Kerr <jk@ozlabs.org>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org, devicetree@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>
List-Id: linux-serial@vger.kernel.org

On Tue, Mar 28, 2017 at 04:14:58PM +1030, Joel Stanley wrote:
> From: Jeremy Kerr <jk@ozlabs.org>
> 
> This change adds a driver for the 16550-based Aspeed virtual UART
> device. We use a similar process to the of_serial driver for device
> probe, but expose some VUART-specific functions through sysfs too.
> 
> OpenPOWER host firmware doesn't like it when the host-side of the
> VUART's FIFO is not drained. This driver only disables host TX discard
> mode when the port is in use. We set the VUART enabled bit when we bind
> to the device, and clear it on unbind.
> 
> We don't want to do this on open/release, as the host may be using this
> bit to configure serial output modes, which is independent of whether
> the devices has been opened by BMC userspace.
> 
> Signed-off-by: Jeremy Kerr <jk@ozlabs.org>
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
>  Documentation/devicetree/bindings/serial/8250.txt |   2 +

For the binding:

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/tty/serial/Kconfig                        |  10 +
>  drivers/tty/serial/Makefile                       |   1 +
>  drivers/tty/serial/aspeed-vuart.c                 | 335 ++++++++++++++++++++++
>  4 files changed, 348 insertions(+)
>  create mode 100644 drivers/tty/serial/aspeed-vuart.c
