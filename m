From: Matthias Brugger <mbrugger@suse.com>
Subject: Re: [PATCH v2 1/8] arm64: move acpi/dt decision earlier in boot
 process
Date: Wed, 24 Feb 2016 19:22:12 +0100
Message-ID: <56CDF4D4.6000506@suse.com>
References: <1456333819-13482-1-git-send-email-aleksey.makarov@linaro.org>
 <1456333819-13482-2-git-send-email-aleksey.makarov@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1456333819-13482-2-git-send-email-aleksey.makarov@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Aleksey Makarov <aleksey.makarov@linaro.org>, linux-acpi@vger.kernel.org
Cc: Russell King <linux@arm.linux.org.uk>, Graeme Gregory <graeme.gregory@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, Leif Lindholm <leif.lindholm@linaro.org>, Christopher Covington <cov@codeaurora.org>, linux-serial@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Al Stone <ahs3@redhat.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org



On 24/02/16 18:10, Aleksey Makarov wrote:
> From: Leif Lindholm <leif.lindholm@linaro.org>
>
> In order to support selecting earlycon via either ACPI or DT, move
> the decision on whether to attempt ACPI configuration into the
> early_param handling. Then make acpi_boot_table_init() bail out if
> acpi_disabled.
>
> Signed-off-by: Leif Lindholm <leif.lindholm@linaro.org>
> Signed-off-by: Aleksey Makarov <aleksey.makarov@linaro.org>
> ---
>   arch/arm64/kernel/acpi.c | 62 +++++++++++++++++++++++-------------------------
>   1 file changed, 30 insertions(+), 32 deletions(-)
>
> diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
> index d1ce8e2..3faa323 100644
> --- a/arch/arm64/kernel/acpi.c
> +++ b/arch/arm64/kernel/acpi.c
> @@ -41,26 +41,8 @@ EXPORT_SYMBOL(acpi_disabled);
>   int acpi_pci_disabled = 1;	/* skip ACPI PCI scan and IRQ initialization */
>   EXPORT_SYMBOL(acpi_pci_disabled);
>
> -static bool param_acpi_off __initdata;
>   static bool param_acpi_force __initdata;
>
> -static int __init parse_acpi(char *arg)
> -{
> -	if (!arg)
> -		return -EINVAL;
> -
> -	/* "acpi=off" disables both ACPI table parsing and interpreter */
> -	if (strcmp(arg, "off") == 0)
> -		param_acpi_off = true;
> -	else if (strcmp(arg, "force") == 0) /* force ACPI to be enabled */
> -		param_acpi_force = true;
> -	else
> -		return -EINVAL;	/* Core will print when we return error */
> -
> -	return 0;
> -}
> -early_param("acpi", parse_acpi);
> -
>   static int __init dt_scan_depth1_nodes(unsigned long node,
>   				       const char *uname, int depth,
>   				       void *data)
> @@ -74,6 +56,35 @@ static int __init dt_scan_depth1_nodes(unsigned long node,
>   	return 0;
>   }
>
> +static int __init parse_acpi(char *arg)
> +{
> +	if (!arg)
> +		return -EINVAL;
> +
> +	/*
> +	 * Enable ACPI instead of device tree unless
> +	 * - ACPI has been disabled explicitly (acpi=off), or
> +	 * - the device tree is not empty (it has more than just a /chosen node)
> +	 *   and ACPI has not been force enabled (acpi=force)
> +	 */
> +	if (strcmp(arg, "off") == 0)
> +		return 0;
> +	else if (strcmp(arg, "force") == 0)
> +		param_acpi_force = true;
> +	else if (of_scan_flat_dt(dt_scan_depth1_nodes, NULL))

I think we should strcmp for "on" here and return an error on other 
values. IMHO an update to Documentation/kernel-parameters.txt would be 
convenient.

I still wonder if we really want to change the default to ACPI disabled.
But that's a decision the maintainers have to take.

Regards,
Matthias

> +		return 0;
> +
> +	/*
> +	 * ACPI is disabled at this point. Enable it in order to parse
> +	 * the ACPI tables and carry out sanity checks
> +	 */
> +	enable_acpi();
> +
> +	return 0;
> +}
> +
> +early_param("acpi", parse_acpi);
> +
>   /*
>    * __acpi_map_table() will be called before page_init(), so early_ioremap()
>    * or early_memremap() should be called here to for ACPI table mapping.
> @@ -181,23 +192,10 @@ out:
>    */
>   void __init acpi_boot_table_init(void)
>   {
> -	/*
> -	 * Enable ACPI instead of device tree unless
> -	 * - ACPI has been disabled explicitly (acpi=off), or
> -	 * - the device tree is not empty (it has more than just a /chosen node)
> -	 *   and ACPI has not been force enabled (acpi=force)
> -	 */
> -	if (param_acpi_off ||
> -	    (!param_acpi_force && of_scan_flat_dt(dt_scan_depth1_nodes, NULL)))
> +	if (acpi_disabled)
>   		return;
>
>   	/*
> -	 * ACPI is disabled at this point. Enable it in order to parse
> -	 * the ACPI tables and carry out sanity checks
> -	 */
> -	enable_acpi();
> -
> -	/*
>   	 * If ACPI tables are initialized and FADT sanity checks passed,
>   	 * leave ACPI enabled and carry on booting; otherwise disable ACPI
>   	 * on initialization error.
>
