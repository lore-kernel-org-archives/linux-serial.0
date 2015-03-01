From: Kevin Cernekee <cernekee@gmail.com>
Subject: Re: [PATCH] serial: core: Fix iotype userspace breakage
Date: Sun, 1 Mar 2015 07:44:32 -0800
Message-ID: <CAJiQ=7D-MKjh4aEcAAvqmSf7dAKY99iQf+8tOGZAOViQPpuFeg@mail.gmail.com>
References: <1425223096-17635-1-git-send-email-peter@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1425223096-17635-1-git-send-email-peter@hurleysoftware.com>
Sender: stable-owner@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, stable@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Sun, Mar 1, 2015 at 7:18 AM, Peter Hurley <peter@hurleysoftware.com> wrote:
> commit 3ffb1a8193bea ("serial: core: Add big-endian iotype")
> re-numbered userspace-dependent values; ioctl(TIOCSSERIAL) can
> assign the port iotype (which is expected to match the selected
> i/o accessors), so iotype values must not be changed.
>
> Cc: Kevin Cernekee <cernekee@gmail.com>
> Cc: <stable@vger.kernel.org> # 3.19+
> Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
> ---
>  include/linux/serial_core.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
> index a3fd182..85fdd89 100644
> --- a/include/linux/serial_core.h
> +++ b/include/linux/serial_core.h
> @@ -147,9 +147,9 @@ struct uart_port {
>  #define UPIO_HUB6              (1)                     /* Hub6 ISA card */
>  #define UPIO_MEM               (2)                     /* 8b MMIO access */
>  #define UPIO_MEM32             (3)                     /* 32b little endian */
> -#define UPIO_MEM32BE           (4)                     /* 32b big endian */
> -#define UPIO_AU                        (5)                     /* Au1x00 and RT288x type IO */
> -#define UPIO_TSI               (6)                     /* Tsi108/109 type IO */
> +#define UPIO_AU                        (4)                     /* Au1x00 and RT288x type IO */
> +#define UPIO_TSI               (5)                     /* Tsi108/109 type IO */
> +#define UPIO_MEM32BE           (6)                     /* 32b big endian */

Whoops, I had no clue userland cared about these... thanks for the fix.

Reviewed-by: Kevin Cernekee <cernekee@gmail.com>
