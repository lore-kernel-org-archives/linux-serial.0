From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 2/2] serial: uartps: Use the same dynamin major number
 for all ports
Date: Mon, 10 Jun 2019 19:13:03 +0200
Message-ID: <20190610171303.GA14134@kroah.com>
References: <c6753260caf8b20cc002b15fcbf22b759c91d760.1560156294.git.michal.simek@xilinx.com>
 <381ea608440345a4424d24296666b2451b1a20ee.1560156294.git.michal.simek@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <381ea608440345a4424d24296666b2451b1a20ee.1560156294.git.michal.simek@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Michal Simek <michal.simek@xilinx.com>
Cc: linux-kernel@vger.kernel.org, monstr@monstr.eu, johan@kernel.org, Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On Mon, Jun 10, 2019 at 10:44:56AM +0200, Michal Simek wrote:
> From: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> 
> Let kernel to find out major number dynamically for the first device and
> then reuse it for other instances.
> This fixes the issue that each uart is registered with a
> different major number.
> 
> After the patch:
> crw-------    1 root     root      253,   0 Jun 10 08:31 /dev/ttyPS0
> crw--w----    1 root     root      253,   1 Jan  1  1970 /dev/ttyPS1
> 
> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
> 
>  drivers/tty/serial/xilinx_uartps.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Does not apply without patch 1/2, so dropping it from my queue.

Which is ALWAYS a good reason why you should submit bug fixes or other
things before code cleanup patches.

thanks,

greg k-h
