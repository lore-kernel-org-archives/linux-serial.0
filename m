From: Daniel Thompson <daniel.thompson@linaro.org>
Subject: Re: [PATCH v2 1/2] kgdboc: Passing ekgdboc to command line causes
 panic
Date: Tue, 14 Aug 2018 14:26:58 +0100
Message-ID: <20180814132658.nadasqcwi3f44duv@holly.lan>
References: <1534250761-824-1-git-send-email-zhe.he@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1534250761-824-1-git-send-email-zhe.he@windriver.com>
Sender: linux-kernel-owner@vger.kernel.org
To: zhe.he@windriver.com
Cc: jason.wessel@windriver.com, gregkh@linuxfoundation.org, jslaby@suse.com, kgdb-bugreport@lists.sourceforge.net, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Tue, Aug 14, 2018 at 08:46:00PM +0800, zhe.he@windriver.com wrote:
> From: He Zhe <zhe.he@windriver.com>
> 
> kgdboc_option_setup does not check input argument before passing it
> to strlen. The argument would be a NULL pointer if "ekgdboc", without
> its value, is set in command line and thus cause the following panic.
> 
> PANIC: early exception 0xe3 IP 10:ffffffff8fbbb620 error 0 cr2 0x0
> [    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 4.18-rc8+ #1
> [    0.000000] RIP: 0010:strlen+0x0/0x20
> ...
> [    0.000000] Call Trace
> [    0.000000]  ? kgdboc_option_setup+0x9/0xa0
> [    0.000000]  ? kgdboc_early_init+0x6/0x1b
> [    0.000000]  ? do_early_param+0x4d/0x82
> [    0.000000]  ? parse_args+0x212/0x330
> [    0.000000]  ? rdinit_setup+0x26/0x26
> [    0.000000]  ? parse_early_options+0x20/0x23
> [    0.000000]  ? rdinit_setup+0x26/0x26
> [    0.000000]  ? parse_early_param+0x2d/0x39
> [    0.000000]  ? setup_arch+0x2f7/0xbf4
> [    0.000000]  ? start_kernel+0x5e/0x4c2
> [    0.000000]  ? load_ucode_bsp+0x113/0x12f
> [    0.000000]  ? secondary_startup_64+0xa5/0xb0
> 
> This patch adds a check to prevent the panic.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: He Zhe <zhe.he@windriver.com>
> ---
> v2:
> - Split out printk cleanups
> - Add cc to stable@vger.kernel.org
> 
>  drivers/tty/serial/kgdboc.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/tty/serial/kgdboc.c b/drivers/tty/serial/kgdboc.c
> index b4ba2b1..206f8c2 100644
> --- a/drivers/tty/serial/kgdboc.c
> +++ b/drivers/tty/serial/kgdboc.c
> @@ -130,6 +130,11 @@ static void kgdboc_unregister_kbd(void)
>  
>  static int kgdboc_option_setup(char *opt)
>  {
> +	if (!opt) {
> +		pr_err("kgdboc: null option\n");

Apologies... I should have picked this up when I replied earlier but
this error message describes what the function gets when I think it
should report what the user actually did. So should be something like:

		pr_err("kgdboc: config string not provided\n");
	
With that (or a very similar) change:
Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.


> +		return -EINVAL;
> +	}
> +
>  	if (strlen(opt) >= MAX_CONFIG_LEN) {
>  		printk(KERN_ERR "kgdboc: config string too long\n");
>  		return -ENOSPC;
> -- 
> 2.7.4
> 
