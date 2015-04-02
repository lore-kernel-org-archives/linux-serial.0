From: Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH v3 -next 11/11] serial: 8250_early: Remove setup_early_serial8250_console()
Date: Thu, 2 Apr 2015 10:23:52 -0700
Message-ID: <CAE9FiQUGeGuf9z0tQyjOujfRW_RtrWe8ELeKe=W6GNFmRVdpfg@mail.gmail.com>
References: <1425932842-21812-1-git-send-email-peter@hurleysoftware.com>
	<1425932842-21812-12-git-send-email-peter@hurleysoftware.com>
	<CAE9FiQVWhfVt8kmj5QumAH2hyp+DRYGeQcBtFrynojXTCOdnQw@mail.gmail.com>
	<551CB5DF.1010108@hurleysoftware.com>
	<CAE9FiQVKY9KLeBOB0shqTPZZipsmAiU=3_8gzfFhsCW9kxo_uA@mail.gmail.com>
	<551D6EEA.6050704@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <551D6EEA.6050704@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Jiri Slaby <jslaby@suse.cz>, Rob Herring <robh@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Thu, Apr 2, 2015 at 9:31 AM, Peter Hurley <peter@hurleysoftware.com> wrote:

> Would you please try the patch below instead?
>
> --- >% ---
> From: Peter Hurley <peter@hurleysoftware.com>
> Subject: [PATCH] earlycon: Fix __earlycon_table stride
>
> Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
> ---
>  include/asm-generic/vmlinux.lds.h | 2 +-
>  include/linux/serial_core.h       | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> index 7b0ef49..2e11f31 100644
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -151,7 +151,7 @@
>  #endif
>
>  #ifdef CONFIG_SERIAL_EARLYCON
> -#define EARLYCON_TABLE() . = ALIGN(8);                         \
> +#define EARLYCON_TABLE() STRUCT_ALIGN();                       \
>                          VMLINUX_SYMBOL(__earlycon_table) = .;  \
>                          *(__earlycon_table)                    \
>                          *(__earlycon_table_end)
> diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
> index 34de168..025dad9 100644
> --- a/include/linux/serial_core.h
> +++ b/include/linux/serial_core.h
> @@ -342,7 +342,7 @@ struct earlycon_device {
>  struct earlycon_id {
>         char    name[16];
>         int     (*setup)(struct earlycon_device *, const char *options);
> -};
> +} __aligned(32);
>
>  extern int setup_earlycon(char *buf);
>  extern int of_setup_earlycon(unsigned long addr,
> --

Great. that works, and less lines change than my version.

ffffffff832049a0 T __earlycon_table
ffffffff832049a0 t __earlycon_uart
ffffffff832049c0 t __earlycon_uart8250
ffffffff832049e0 t __earlycon_table_sentinel

[    0.000000] bootconsole [uart0] enabled
[    0.000000] uart8250 probed_baud_rate: 115200
[    0.000000] size of earlycon_id: 0x20

Thanks

Yinghai
