From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 14/18] serial: intel: Add CCF support
Date: Fri, 3 Aug 2018 07:56:40 +0200
Message-ID: <20180803055640.GA32226@kroah.com>
References: <20180803030237.3366-1-songjun.wu@linux.intel.com>
 <20180803030237.3366-15-songjun.wu@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180803030237.3366-15-songjun.wu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Songjun Wu <songjun.wu@linux.intel.com>
Cc: hua.ma@linux.intel.com, yixin.zhu@linux.intel.com, chuanhua.lei@linux.intel.com, qi-ming.wu@intel.com, linux-mips@linux-mips.org, linux-clk@vger.kernel.org, linux-serial@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.com>
List-Id: linux-serial@vger.kernel.org

On Fri, Aug 03, 2018 at 11:02:33AM +0800, Songjun Wu wrote:
> Previous implementation uses platform-dependent API to get the clock.
> Those functions are not available for other SoC which uses the same IP.
> The CCF (Common Clock Framework) have an abstraction based APIs for
> clock. In future, the platform specific code will be removed when the
> legacy soc use CCF as well.
> Change to use CCF APIs to get clock and rate. So that different SoCs
> can use the same driver.
> 
> Signed-off-by: Songjun Wu <songjun.wu@linux.intel.com>
> ---
> 
> Changes in v2: None
> 
>  drivers/tty/serial/lantiq.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/tty/serial/lantiq.c b/drivers/tty/serial/lantiq.c
> index 36479d66fb7c..35518ab3a80d 100644
> --- a/drivers/tty/serial/lantiq.c
> +++ b/drivers/tty/serial/lantiq.c
> @@ -26,7 +26,9 @@
>  #include <linux/clk.h>
>  #include <linux/gpio.h>
>  
> +#ifdef CONFIG_LANTIQ
>  #include <lantiq_soc.h>
> +#endif

That is never how you do this in Linux, you know better.

Please go and get this patchset reviewed and signed-off-by from other
internal Intel kernel developers before resending it next time.  It is
their job to find and fix your basic errors like this, not ours.

greg k-h
