From: Jason Wessel <jason.wessel@windriver.com>
Subject: Re: [PATCH 02/11] kdb: Implement disable_nmi command
Date: Wed, 19 Sep 2012 06:52:08 -0500
Message-ID: <5059B1E8.8050201@windriver.com>
References: <20120913150133.GA16238@lizard> <1347548615-18227-2-git-send-email-anton.vorontsov@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1347548615-18227-2-git-send-email-anton.vorontsov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Anton Vorontsov <anton.vorontsov@linaro.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Russell King <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <alan@linux.intel.com>, =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>, Colin Cross <ccross@android.com>, Brian Swetland <swetland@google.com>, John Stultz <john.stultz@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linaro-kernel@lists.linaro.org, patches@linaro.org, kernel-team@android.com, kgdb-bugreport@lists.sourceforge.net, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 09/13/2012 10:03 AM, Anton Vorontsov wrote:
> This command disables NMI-entry. If NMI source has been previously shared
> with a serial console ("debug port"), this effectively releases the port
> from KDB exclusive use, and makes the console available for normal use.
> 
> Of course, NMI can be reenabled, enable_nmi modparam is used for that:
> 
> 	echo 1 > /sys/module/kdb/parameters/enable_nmi
> 
> Signed-off-by: Anton Vorontsov <anton.vorontsov@linaro.org>
> ---
>  kernel/debug/kdb/kdb_main.c | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
> diff --git a/kernel/debug/kdb/kdb_main.c b/kernel/debug/kdb/kdb_main.c
> index 31df170..9fadff1 100644
> --- a/kernel/debug/kdb/kdb_main.c
> +++ b/kernel/debug/kdb/kdb_main.c
> @@ -21,6 +21,7 @@
>  #include <linux/smp.h>
>  #include <linux/utsname.h>
>  #include <linux/vmalloc.h>
> +#include <linux/atomic.h>
>  #include <linux/module.h>
>  #include <linux/mm.h>
>  #include <linux/init.h>
> @@ -2107,6 +2108,32 @@ static int kdb_dmesg(int argc, const char **argv)
>  	return 0;
>  }
>  #endif /* CONFIG_PRINTK */
> +
> +/* Make sure we balance enable/disable calls, must disable first. */
> +static atomic_t kdb_nmi_disabled;
> +
> +static int kdb_disable_nmi(int argc, const char *argv[])
> +{
> +	if (atomic_read(&kdb_nmi_disabled))
> +		return 0;
> +	atomic_set(&kdb_nmi_disabled, 1);
> +	kgdb_enable_nmi(0);
> +	return 0;
> +}
> +
> +static int kdb_param_enable_nmi(const char *val, const struct kernel_param *kp)
> +{
> +	if (!atomic_add_unless(&kdb_nmi_disabled, -1, 0))
> +		return -EINVAL;
> +	kgdb_enable_nmi(1);
> +	return 0;
> +}
> +
> +static const struct kernel_param_ops kdb_param_ops_enable_nmi = {
> +	.set = kdb_param_enable_nmi,
> +};
> +module_param_cb(enable_nmi, &kdb_param_ops_enable_nmi, NULL, 0600);
> +
>  /*
>   * kdb_cpu - This function implements the 'cpu' command.
>   *	cpu	[<cpunum>]
> @@ -2851,6 +2878,8 @@ static void __init kdb_inittab(void)
>  	kdb_register_repeat("dmesg", kdb_dmesg, "[lines]",
>  	  "Display syslog buffer", 0, KDB_REPEAT_NONE);
>  #endif


Based on what I commented in the 01/11 patch, we don't want to register a command if the architecture doesn't actually have it, because it just leads to confusion.

It needs to have an "if"

if (arch_kgdb_ops->enable_nmi) {


> +	kdb_register_repeat("disable_nmi", kdb_disable_nmi, "",
> +	  "Disable NMI entry to KDB", 0, KDB_REPEAT_NONE);

}

>  	kdb_register_repeat("defcmd", kdb_defcmd, "name \"usage\" \"help\"",
>  	  "Define a set of commands, down to endefcmd", 0, KDB_REPEAT_NONE);
>  	kdb_register_repeat("kill", kdb_kill, "<-signal> <pid>",
> 
