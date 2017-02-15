From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v3] tty: pl011: Work around QDF2400 E44 stuck BUSY bit
Date: Wed, 15 Feb 2017 19:50:27 +0000
Message-ID: <20170215195026.GN31733@leverpostej>
References: <20170215180159.11359-1-cov@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170215180159.11359-1-cov@codeaurora.org>
Sender: linux-doc-owner@vger.kernel.org
To: Christopher Covington <cov@codeaurora.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Marc Zyngier <marc.zyngier@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Peter Hurley <peter@hurleysoftware.com>, Aleksey Makarov <aleksey.makarov@linaro.org>, Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org, shankerd@codeaurora.org, timur@codeaurora.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Russell King <linux@armlinux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-acpi@vger.kernel.org, linux-serial@vger.kernel.org, Mark Langsdorf <mlangsdo@redhat.com>, Mark Salter <msalter@redhat.com>, Jon Masters <jcm@redha>
List-Id: linux-serial@vger.kernel.org

On Wed, Feb 15, 2017 at 01:01:59PM -0500, Christopher Covington wrote:
> The Qualcomm Datacenter Technologies QDF2400 family of SoCs contains a
> custom (non-PrimeCell) implementation of the SBSA UART. Occasionally the
> BUSY bit in the Flag Register gets stuck as 1, erratum 44 for both 2432v1
> and 2400v1 SoCs.Checking that the Transmit FIFO Empty (TXFE) bit is 0,
> instead of checking that the BUSY bit is 1, works around the issue.
> 
> To facilitate this substitution of flags and values, introduce
> vendor-specific inversion of Feature Register bits when UART AMBA Port
> (UAP) data is available. For the earlycon case, prior to UAP availability,
> implement alternative putc and early_write functions.
> 
> Similar to what how ARMv8 ACPI PCI quirks are detected during MCFG parsing,
> check the OEM fields of the Serial Port Console Redirection (SPCR) ACPI
> table to determine if the current platform is known to be affected by the
> erratum.
> 
> Signed-off-by: Christopher Covington <cov@codeaurora.org>
> Acked-by: Russell King <rmk+kernel@armlinux.org.uk>
> ---
> Since v2: Formatting and other improvements per Timur's suggestions
> Due to known (although trivial) conflicts in silicon-errata.txt, based on
> http://git.kernel.org/cgit/linux/kernel/git/arm64/linux.git/log/?h=for-next/core
> ---
>  Documentation/arm64/silicon-errata.txt |  2 ++
>  drivers/acpi/spcr.c                    | 23 ++++++++++++
>  drivers/tty/serial/amba-pl011.c        | 66 ++++++++++++++++++++++++++++++----
>  3 files changed, 84 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/arm64/silicon-errata.txt b/Documentation/arm64/silicon-errata.txt
> index a71b8095dbd8..bc3d086bc624 100644
> --- a/Documentation/arm64/silicon-errata.txt
> +++ b/Documentation/arm64/silicon-errata.txt
> @@ -68,3 +68,5 @@ stable kernels.
>  |                |                 |                 |                             |
>  | Qualcomm Tech. | Falkor v1       | E1003           | QCOM_FALKOR_ERRATUM_1003    |
>  | Qualcomm Tech. | Falkor v1       | E1009           | QCOM_FALKOR_ERRATUM_1009    |
> +| Qualcomm Tech. | QDF2432v1 UART  | SoC E44         | N/A                         |
> +| Qualcomm Tech. | QDF2400v1 UART  | SoC E44         | N/A                         |
> diff --git a/drivers/acpi/spcr.c b/drivers/acpi/spcr.c
> index b8019c4c1d38..2b5d0fac81f0 100644
> --- a/drivers/acpi/spcr.c
> +++ b/drivers/acpi/spcr.c
> @@ -16,6 +16,26 @@
>  #include <linux/kernel.h>
>  #include <linux/serial_core.h>
>  
> +/*
> + * Some Qualcomm Datacenter Technologies SoCs have a defective UART BUSY bit.
> + * Detect them by examining the OEM fields in the SPCR header, similiar to PCI
> + * quirk detection in pci_mcfg.c.
> + */
> +static bool qdf2400_erratum_44_present(struct acpi_table_header *h)
> +{
> +	if (memcmp(h->oem_id, "QCOM  ", ACPI_OEM_ID_SIZE))
> +		return false;
> +
> +	if (!memcmp(h->oem_table_id, "QDF2432 ", ACPI_OEM_TABLE_ID_SIZE))
> +		return true;
> +
> +	if (!memcmp(h->oem_table_id, "QDF2400 ", ACPI_OEM_TABLE_ID_SIZE) &&
> +			h->oem_revision == 0)
> +		return true;
> +
> +	return false;
> +}
> +
>  /**
>   * parse_spcr() - parse ACPI SPCR table and add preferred console
>   *
> @@ -93,6 +113,9 @@ int __init parse_spcr(bool earlycon)
>  		goto done;
>  	}
>  
> +	if (qdf2400_erratum_44_present(&table->header))
> +		uart = "qdf2400_e44";
> +

This addresses my concern with using the MIDR; thanks for respinning
this. FWIW:

Acked-by: Mark Rutland <mark.rutland@arm.com>

It might be best to split the silicon-errata doc into a separate patch.
That can go via the arm64 tree without conflict whiel the driver patch
can go via the tty tree.

Thanks,
Mark.
