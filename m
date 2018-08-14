From: Daniel Thompson <daniel.thompson@linaro.org>
Subject: Re: [PATCH] kgdboc: Passing ekgdboc to command line causes panic
Date: Tue, 14 Aug 2018 10:16:00 +0100
Message-ID: <20180814091600.md6v2dj53wco7lgn@holly.lan>
References: <1533743984-426660-1-git-send-email-zhe.he@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1533743984-426660-1-git-send-email-zhe.he@windriver.com>
Sender: linux-kernel-owner@vger.kernel.org
To: zhe.he@windriver.com
Cc: jason.wessel@windriver.com, gregkh@linuxfoundation.org, jslaby@suse.com, kgdb-bugreport@lists.sourceforge.net, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Wed, Aug 08, 2018 at 11:59:44PM +0800, zhe.he@windriver.com wrote:
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
> This patch adds a check to prevent the panic and changes some printk
> to right fashion.
> 
> Signed-off-by: He Zhe <zhe.he@windriver.com>

For the bug fix portions of this patch you should add the stable kernel
ML to the Cc: of the sign off area: See:
https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

> ---
>  drivers/tty/serial/kgdboc.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/tty/serial/kgdboc.c b/drivers/tty/serial/kgdboc.c
> index b4ba2b1..0003d6c 100644
> --- a/drivers/tty/serial/kgdboc.c
> +++ b/drivers/tty/serial/kgdboc.c
> @@ -130,8 +130,13 @@ static void kgdboc_unregister_kbd(void)
>  
>  static int kgdboc_option_setup(char *opt)
>  {
> +	if (!opt) {
> +		pr_err("kgdboc: null option\n");
> +		return -EINVAL;
> +	}
> +
>  	if (strlen(opt) >= MAX_CONFIG_LEN) {
> -		printk(KERN_ERR "kgdboc: config string too long\n");
> +		pr_err("kgdboc: config string too long\n");

These changes are not bug fixes and are not normally candidates for
backporting. It would therefore be better to put the s/printk KERN_ERR /pr_err(/
changes into a separate patch.


>  		return -ENOSPC;
>  	}
>  	strcpy(config, opt);
> @@ -248,7 +253,7 @@ static int param_set_kgdboc_var(const char *kmessage,
>  	int len = strlen(kmessage);
>  
>  	if (len >= MAX_CONFIG_LEN) {
> -		printk(KERN_ERR "kgdboc: config string too long\n");
> +		pr_err("kgdboc: config string too long\n");
>  		return -ENOSPC;
>  	}
>  
> @@ -259,8 +264,7 @@ static int param_set_kgdboc_var(const char *kmessage,
>  	}
>  
>  	if (kgdb_connected) {
> -		printk(KERN_ERR
> -		       "kgdboc: Cannot reconfigure while KGDB is connected.\n");
> +		pr_err("kgdboc: Cannot reconfigure while KGDB is connected.\n");
>  
>  		return -EBUSY;
>  	}
> -- 
> 2.7.4
> 
