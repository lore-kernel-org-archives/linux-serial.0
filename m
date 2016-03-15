From: Andre Przywara <andre.przywara@arm.com>
Subject: Re: [PATCH] tty: amba-pl011: Use 32-bit accesses for SBSA UART
Date: Tue, 15 Mar 2016 10:08:31 +0000
Message-ID: <56E7DF1F.7010006@arm.com>
References: <1457415800-8799-1-git-send-email-cov@codeaurora.org>
 <1457678154-2272-1-git-send-email-cov@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1457678154-2272-1-git-send-email-cov@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Christopher Covington <cov@codeaurora.org>, Russell King <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Timur Tabi <timur@codeaurora.org>, Jon Masters <jcm@redhat.com>, Mark Langsdorf <mlangsdo@redhat.com>, Dave Martin <dave.martin@linaro.org>, Aleksey Makarov <aleksey.makarov@linaro.org>
List-Id: linux-serial@vger.kernel.org

Hi Christopher,

On 11/03/16 06:35, Christopher Covington wrote:
> Version 2 of the Server Base System Architecture (SBSAv2) describes the
> Generic UART registers as 32 bits wide. At least one implementation, found
> on the Qualcomm Technologies QDF2432, only supports 32 bit accesses.
> SBSAv3, which describes supported access sizes in greater detail,
> explicitly requires support for both 16 and 32 bit accesses to all
> registers (and 8 bit accesses to some but not all). Therefore, for broad
> compatibility, simply use 32 bit accessors for the SBSA UART.
> 
> Tested-by: Mark Langsdorf <mlangsdo@redhat.com>
> Signed-off-by: Christopher Covington <cov@codeaurora.org>

So I gave this a try on a Juno and a Midway. Both have a normal PL011,
but I changed the DT to advertise an SBSA UART instead.
This worked fine with the 32bit accessors.
Also according to some research on the hardware size at least the
current ARM PL011 implementation are totally fine with 32-bit (as well
as 16-bit) accesses.
There is some reluctance about whether this is true for _every_ older
PL011 implementation, but they are out of scope here, as we are talking
about the SBSA only.
So:

Tested-by: Andre Przywara <andre.przywara@arm.com>
Acked-by: Andre Przywara <andre.przywara@arm.com>

You can add Juno and Midway to the list of tested systems.

Cheers,
Andre.

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
