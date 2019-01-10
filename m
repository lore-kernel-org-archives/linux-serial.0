From: Palmer Dabbelt <palmer@sifive.com>
Subject: Re: [PATCH] tty/serial: emit CR before NL in RISC-V SBL console
Date: Thu, 10 Jan 2019 12:54:44 -0800 (PST)
Message-ID: <mhng-e8479556-154c-443f-9d41-dc182aafa2ae@palmer-si-x1c4>
References: <CAAhSdy0suSgKpdz+NUrXzS9Ozp75hMC6ovW4yLf5s0KYJwwocw@mail.gmail.com>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <mvm7efcedop.fsf@suse.de>
In-Reply-To: <CAAhSdy0suSgKpdz+NUrXzS9Ozp75hMC6ovW4yLf5s0KYJwwocw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: schwab@suse.de, anup@brainfault.org
Cc: Greg KH <gregkh@linuxfoundation.org>, jslaby@suse.com, aou@eecs.berkeley.edu, atish.patra@wdc.com, Christoph Hellwig <hch@infradead.org>, robh@kernel.org, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Thu, 10 Jan 2019 07:26:46 PST (-0800), schwab@suse.de wrote:
> On Jan 10 2019, Anup Patel <anup@brainfault.org> wrote:
>
>> Instead of doing '\n' handling here, we should do it in BBL or
>> OpenSBI (i.e. SBI runtime firmware) otherwise all users of
>> SBI_CONSOLE_PUTCHAR (namely, Linux, FreeBSD,
>> FreeRTOS, U-Boot S-mode, etc) will endup having '\n'
>> handling.
>
> I don't think the serial driver should do NLCR handling on its own,
> without being instructed by the tty layer.  Since the earlycon does not
> have a tty layer, it needs to handle it explicitly.

I think it's best if we have the SBI interfaces be defined to be bit-exact.  It
does mean that everyone who uses the interfaces needs to do this handling, but
I think that's actually a feature because it'll be subtly different everywhere.

This also has the advantage of being compatible with what we currently do in
BBL and what we current expect in Linux everywhere but this earlycon driver
(and will do assuming we merge this patch).

On Thu, 10 Jan 2019 08:17:07 PST (-0800), anup@brainfault.org wrote:
> On Thu, Jan 10, 2019 at 8:56 PM Andreas Schwab <schwab@suse.de> wrote:
>>
>> On Jan 10 2019, Anup Patel <anup@brainfault.org> wrote:
>>
>> > Instead of doing '\n' handling here, we should do it in BBL or
>> > OpenSBI (i.e. SBI runtime firmware) otherwise all users of
>> > SBI_CONSOLE_PUTCHAR (namely, Linux, FreeBSD,
>> > FreeRTOS, U-Boot S-mode, etc) will endup having '\n'
>> > handling.
>>
>> I don't think the serial driver should do NLCR handling on its own,
>> without being instructed by the tty layer.  Since the earlycon does not
>> have a tty layer, it needs to handle it explicitly.
>
> I tried to investigate more. What you suggest is correct
> but we should use uart_console_write() API.
>
> Instead of explicitly doing NLCR here, we should do
> something as follows:
>
> static void sbi_putc(struct uart_port *port, int c)
> {
>     sbi_console_putchar(c);
> }
>
> static void sbi_console_write(struct console *con,
>                                                const char *s, unsigned n)
> {
>     struct earlycon_device *dev = con->data;
>     uart_console_write(&dev->port, s, n, sbi_putc);
> }
>
> The uart_console_write() does the NLCR handling.

That does look cleaner.  I'll expect a v2 :)
