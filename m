From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 2/9] 8250/Kconfig: add config option
 CONFIG_SERIAL_8250_AMD
Date: Fri, 4 Dec 2015 12:11:14 +0100
Message-ID: <20151204111114.GC21177@pd.tnic>
References: <1449199466-6081-1-git-send-email-annie.wang@amd.com>
 <1449199466-6081-3-git-send-email-annie.wang@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1449199466-6081-3-git-send-email-annie.wang@amd.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Wang Hongcheng <annie.wang@amd.com>
Cc: Vinod Koul <vinod.koul@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, dmaengine@vger.kernel.org, iommu@lists.linux-foundation.org, Huang Rui <ray.huang@amd.com>, Wan Zongshun <vincent.wan@amd.com>, Ken Xue <ken.xue@amd.com>, Tony Li <tony.li@amd.com>
List-Id: linux-serial@vger.kernel.org

On Fri, Dec 04, 2015 at 11:24:19AM +0800, Wang Hongcheng wrote:
> Add config option  CONFIG_SERIAL_8250_AMD in use of AMD carrizo.
> Because carrizo's UART DMA device is an amba device, it selects
> ARM_AMBA option. Anything uses amba devices must select ARM_AMBA.
> 
> Signed-off-by: Wang Hongcheng <annie.wang@amd.com>
> ---
>  drivers/tty/serial/8250/Kconfig | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
> index 6412f14..d9717c1 100644
> --- a/drivers/tty/serial/8250/Kconfig
> +++ b/drivers/tty/serial/8250/Kconfig
> @@ -378,3 +378,11 @@ config SERIAL_8250_MID
>  	  Selecting this option will enable handling of the extra features
>  	  present on the UART found on Intel Medfield SOC and various other
>  	  Intel platforms.
> +
> +config SERIAL_8250_AMD
> +        bool "AMD carrizo serial port support"
> +        depends on SERIAL_8250
> +	select ARM_AMBA
> +        help
> +           If you have a Carrizo  based board and want to use the
> +           serial port, say Y to this option. If unsure, say N.

Please do not use "Carrizo" in any user-visible text because the vendors
and their marketing departments naming are confusing us to hell already.
Use F15h, models 0x60-0x6F (I believe CZ is this range but I'm not sure
myself anymore either) so that people *actually* can know what kind of
CPU it is by looking at /proc/cpuinfo.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
