From: Anup Patel <anup@brainfault.org>
Subject: Re: [PATCH] tty/serial: emit CR before NL in RISC-V SBL console
Date: Thu, 10 Jan 2019 20:46:51 +0530
Message-ID: <CAAhSdy3-SaP7RBbgx7kZgkkxeN2W-Ue8QDFXkOgFG5GiAg52-g@mail.gmail.com>
References: <20181204135507.3706-1-anup@brainfault.org> <20181204135507.3706-2-anup@brainfault.org>
 <mvmbm4oehd5.fsf_-_@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <mvmbm4oehd5.fsf_-_@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Andreas Schwab <schwab@suse.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Palmer Dabbelt <palmer@sifive.com>, Albert Ou <aou@eecs.berkeley.edu>, Atish Patra <atish.patra@wdc.com>, Christoph Hellwig <hch@infradead.org>, Rob Herring <robh@kernel.org>, linux-riscv@lists.infradead.org, "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Thu, Jan 10, 2019 at 7:37 PM Andreas Schwab <schwab@suse.de> wrote:
>
> Signed-off-by: Andreas Schwab <schwab@suse.de>
> ---
>  drivers/tty/serial/earlycon-riscv-sbi.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/tty/serial/earlycon-riscv-sbi.c b/drivers/tty/serial/earlycon-riscv-sbi.c
> index e1a551aae3..9c51b945b5 100644
> --- a/drivers/tty/serial/earlycon-riscv-sbi.c
> +++ b/drivers/tty/serial/earlycon-riscv-sbi.c
> @@ -15,8 +15,11 @@ static void sbi_console_write(struct console *con,
>  {
>         int i;
>
> -       for (i = 0; i < n; ++i)
> +       for (i = 0; i < n; ++i) {
> +               if (s[i] == '\n')
> +                       sbi_console_putchar('\r');

Instead of doing '\n' handling here, we should do it in BBL or
OpenSBI (i.e. SBI runtime firmware) otherwise all users of
SBI_CONSOLE_PUTCHAR (namely, Linux, FreeBSD,
FreeRTOS, U-Boot S-mode, etc) will endup having '\n'
handling.

Currently, the BBL does not handle it but we have already
handled this in upcoming OpenSBI.

The SBI_CONSOLE_PUTCHAR is comparable to ARM
semihosting early prints (refer, tty/serial/earlycon-arm-semihost.c).
Even in ARM semihosting early prints the '\n' is not explicitly
handled.

Regards,
Anup
