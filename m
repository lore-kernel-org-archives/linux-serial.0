From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] serial: atmel: add missing dmaengine header
Date: Thu, 16 Oct 2014 11:42:09 +0300
Message-ID: <1413448929.2396.13.camel@linux.intel.com>
References: <1413445197-22304-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:3307 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751035AbaJPImO (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 16 Oct 2014 04:42:14 -0400
In-Reply-To: <1413445197-22304-1-git-send-email-vinod.koul@intel.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, dmaengine@vger.kernel.org

On Thu, 2014-10-16 at 13:09 +0530, Vinod Koul wrote:
> The atmel serial driver uses dmaengine APIs but never included the dmaengine
> header as it was getting inculded thru one of driver headers.
> 
> commit 3d588f83e4d6a5230d9094b97d38621cbaa9a972 - "dmaengine: dw: split
> dma-dw.h to platform and private parts" broke this as it moved headers
> around.  Fix this by doing the right thing to include the dmaengine header
> 

Thanks, I just sent similar idea to Fengguang and you.

I don't know if it would be a stable material. If so, it would be nice
to add:

Fixes: 08f738be88bb (serial: at91: add tx dma support)
Cc: stable@vger.kernel.org

> Reported-by: kbuild test robot <fengguang.wu@intel.com>
> Signed-off-by: Vinod Koul <vinod.koul@intel.com>
> ---
> Greg, since this is path which broke this is sitting in my next, would it be
> okay to carry this thru dmaengine tree as get it merged in current window.
> Planning to send pull request in day or so to Linus
> 
>  drivers/tty/serial/atmel_serial.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
> index d7d4584..edde3ec 100644
> --- a/drivers/tty/serial/atmel_serial.c
> +++ b/drivers/tty/serial/atmel_serial.c
> @@ -37,6 +37,7 @@
>  #include <linux/of_device.h>
>  #include <linux/of_gpio.h>
>  #include <linux/dma-mapping.h>
> +#include <linux/dmaengine.h>
>  #include <linux/atmel_pdc.h>
>  #include <linux/atmel_serial.h>
>  #include <linux/uaccess.h>


-- 
Andy Shevchenko <andriy.shevchenko@intel.com>
Intel Finland Oy

