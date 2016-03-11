From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH] tty: amba-pl011: Use 32-bit accesses for SBSA UART
Date: Fri, 11 Mar 2016 07:02:14 -0800
Message-ID: <56E2DDF6.2000107@hurleysoftware.com>
References: <1457415800-8799-1-git-send-email-cov@codeaurora.org>
 <1457678154-2272-1-git-send-email-cov@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1457678154-2272-1-git-send-email-cov@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Christopher Covington <cov@codeaurora.org>, Russell King <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Timur Tabi <timur@codeaurora.org>, Jon Masters <jcm@redhat.com>, Mark Langsdorf <mlangsdo@redhat.com>, Andre Przywara <andre.przywara@arm.com>, Dave Martin <dave.martin@linaro.org>, Aleksey Makarov <aleksey.makarov@linaro.org>
List-Id: linux-serial@vger.kernel.org

Hi Christopher,

On 03/10/2016 10:35 PM, Christopher Covington wrote:
> Version 2 of the Server Base System Architecture (SBSAv2) describes the
> Generic UART registers as 32 bits wide. At least one implementation, found
> on the Qualcomm Technologies QDF2432, only supports 32 bit accesses.
> SBSAv3, which describes supported access sizes in greater detail,
> explicitly requires support for both 16 and 32 bit accesses to all
> registers (and 8 bit accesses to some but not all). Therefore, for broad
> compatibility, simply use 32 bit accessors for the SBSA UART.

So this eliminates the need to configure SBSA port via ACPI, correct?
Thus, Aleksey can drop his "serial: pl011: use SPCR to setup 32-bit access"?


> Tested-by: Mark Langsdorf <mlangsdo@redhat.com>
> Signed-off-by: Christopher Covington <cov@codeaurora.org>
> ---
> Changes new in v2:
> * Fixed from address
> * Elaborated on forward (SBSAv3) compatibility in commit message
> * Included Mark Langsdorf's Tested-by, which now covers:
>     QDF2432
>     Seattle
>     X-Gene 1
> ---
>  drivers/tty/serial/amba-pl011.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
> index c0da0cc..ffb5eb8 100644
> --- a/drivers/tty/serial/amba-pl011.c
> +++ b/drivers/tty/serial/amba-pl011.c
> @@ -121,6 +121,7 @@ static struct vendor_data vendor_arm = {
>  
>  static struct vendor_data vendor_sbsa = {
>  	.reg_offset		= pl011_std_offsets,
> +	.access_32b		= true,
>  	.oversampling		= false,
>  	.dma_threshold		= false,
>  	.cts_event_workaround	= false,
> 
