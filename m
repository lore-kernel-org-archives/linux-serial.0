From: Anup Patel <anup@brainfault.org>
Subject: Re: [PATCH] tty/serial: emit CR before NL in RISC-V SBL console
Date: Thu, 10 Jan 2019 21:47:07 +0530
Message-ID: <CAAhSdy0suSgKpdz+NUrXzS9Ozp75hMC6ovW4yLf5s0KYJwwocw@mail.gmail.com>
References: <20181204135507.3706-1-anup@brainfault.org> <20181204135507.3706-2-anup@brainfault.org>
 <mvmbm4oehd5.fsf_-_@suse.de> <CAAhSdy3-SaP7RBbgx7kZgkkxeN2W-Ue8QDFXkOgFG5GiAg52-g@mail.gmail.com>
 <mvm7efcedop.fsf@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <mvm7efcedop.fsf@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Andreas Schwab <schwab@suse.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Palmer Dabbelt <palmer@sifive.com>, Albert Ou <aou@eecs.berkeley.edu>, Atish Patra <atish.patra@wdc.com>, Christoph Hellwig <hch@infradead.org>, Rob Herring <robh@kernel.org>, linux-riscv@lists.infradead.org, "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Thu, Jan 10, 2019 at 8:56 PM Andreas Schwab <schwab@suse.de> wrote:
>
> On Jan 10 2019, Anup Patel <anup@brainfault.org> wrote:
>
> > Instead of doing '\n' handling here, we should do it in BBL or
> > OpenSBI (i.e. SBI runtime firmware) otherwise all users of
> > SBI_CONSOLE_PUTCHAR (namely, Linux, FreeBSD,
> > FreeRTOS, U-Boot S-mode, etc) will endup having '\n'
> > handling.
>
> I don't think the serial driver should do NLCR handling on its own,
> without being instructed by the tty layer.  Since the earlycon does not
> have a tty layer, it needs to handle it explicitly.

I tried to investigate more. What you suggest is correct
but we should use uart_console_write() API.

Instead of explicitly doing NLCR here, we should do
something as follows:

static void sbi_putc(struct uart_port *port, int c)
{
    sbi_console_putchar(c);
}

static void sbi_console_write(struct console *con,
                                               const char *s, unsigned n)
{
    struct earlycon_device *dev = con->data;
    uart_console_write(&dev->port, s, n, sbi_putc);
}

The uart_console_write() does the NLCR handling.

Regards,
Anup
