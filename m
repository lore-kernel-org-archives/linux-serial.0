From: Paul Walmsley <paul.walmsley@sifive.com>
Subject: Re: [PATCH v3 2/2] tty: serial: add driver for the SiFive UART
Date: Thu, 15 Nov 2018 12:11:12 -0800 (PST)
Message-ID: <alpine.DEB.2.21.9999.1811151146530.25598@viisi.sifive.com>
References: <20181020101045.15991-1-paul.walmsley@sifive.com> <20181020101045.15991-3-paul.walmsley@sifive.com> <CANBLGcy9WoBqBKQnvz-YGQpXossP2HDmW_go8WZD7FfBZdr5VQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CANBLGcy9WoBqBKQnvz-YGQpXossP2HDmW_go8WZD7FfBZdr5VQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Emil Renner Berthing <kernel@esmil.dk>
Cc: paul.walmsley@sifive.com, linux-serial@vger.kernel.org, paul@pwsan.com, Palmer Dabbelt <palmer@sifive.com>, wesley@sifive.com, jslaby@suse.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, julia.lawall@lip6.fr, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-riscv@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

Hi Emil,

On Thu, 15 Nov 2018, Emil Renner Berthing wrote:

> Thanks for the patch!

Thanks for your comments!

> On Sat, 20 Oct 2018 at 12:12, Paul Walmsley <paul.walmsley@sifive.com> wrote:
>
>> +static int __init sifive_serial_console_setup(struct console *co, char *options)
>
> Unfortunately I get this error unless I remove the __init:
> ...
>  GEN     .version
>  CHK     include/generated/compile.h
>  AR      built-in.a
>  LD      vmlinux.o
>  MODPOST vmlinux.o
> WARNING: vmlinux.o(.data+0x14e48): Section mismatch in reference from
> the variable .LANCHOR0 to the function
> .init.text:sifive_serial_console_setup()
> The variable .LANCHOR0 references
> the function __init sifive_serial_console_setup()
> If the reference is valid then annotate the
> variable with __init* or __refdata (see linux/init.h) or name the variable:
> *_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console
>
> FATAL: modpost: Section mismatches detected.
> Set CONFIG_SECTION_MISMATCH_WARN_ONLY=y to allow them.
> make[1]: *** [scripts/Makefile.modpost:98: vmlinux.o] Error 1
> make: *** [Makefile:1040: vmlinux] Error 2
>
> I have
> CONFIG_SERIAL_CORE=y
> CONFIG_SERIAL_CORE_CONSOLE=y
> CONFIG_SERIAL_SIFIVE=y
> CONFIG_SERIAL_SIFIVE_CONSOLE=y
> and it happens both on v4.20-rc2 and v4.19.
> Without the __init everything seems to work fine though.

Thanks for the report.  There are some patches to address this:

https://lore.kernel.org/lkml/20181115005602.30746-1-paul.walmsley@sifive.com/

>> +#else
>> +
>> +#define SIFIVE_SERIAL_CONSOLE  NULL
>> +
>> +static inline void __ssp_add_console_port(struct sifive_serial_port *ssp)
>> +{}
>> +static void __ssp_remove_console_port(struct sifive_serial_port *ssp)
>> +{}
>
> Missing "inline"?

That is indeed an error, but the other way around: I didn't mean for that 
inline to be there.

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/coding-style.rst

I've dropped the inline; thanks for pointing the situation out.

>> +static int __init sifive_serial_init(void)
>> +{
>> +       int r;
>
> If you're sending a v4 anyway, here and in the the probe function
> using int ret; for this kind of variable is a common idiom and
> hence easier to read.

Precedent exists in the kernel for using "r" as a return value also:

$ fgrep -r 'return r;' linux/
4491
$

which probably traces back ultimately to Torvalds' guidance to keep 
variable names short:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/coding-style.rst#n284

But I am not religious about it.   So if this is a big deal for you, I 
guess reply back, and it can be changed.


- Paul
