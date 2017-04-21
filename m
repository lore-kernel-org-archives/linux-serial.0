From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Commit 18e8cf159177 broke qemu-system-sh4 serial input.
Date: Fri, 21 Apr 2017 09:26:23 +0200
Message-ID: <CAMuHMdWtBHTBCNo2-oO2Zv7O8McypcaEMh+_8DD+D1T7GTxAzw@mail.gmail.com>
References: <41d6bb75-5be0-c563-0569-ea37aab58f1e@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <41d6bb75-5be0-c563-0569-ea37aab58f1e@landley.net>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Rob Landley <rob@landley.net>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Linux-sh list <linux-sh@vger.kernel.org>, Ulrich Hecht <ulrich.hecht+renesas@gmail.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

Hi Rob,

CC Adrian, linux-serial, linux-renesas-soc

On Fri, Apr 21, 2017 at 8:21 AM, Rob Landley <rob@landley.net> wrote:
> In 4.11-rc7 the qemu serial console hangs after the first character you
> type. To reproduce, configure linux with this mini.config:
>
> CONFIG_CPU_SUBTYPE_SH7751R=y
> CONFIG_MMU=y
> CONFIG_MEMORY_START=0x0c000000
> CONFIG_VSYSCALL=y
> CONFIG_SH_FPU=y
> CONFIG_SH_RTS7751R2D=y
> CONFIG_RTS7751R2D_PLUS=y
> CONFIG_SERIAL_SH_SCI=y
> CONFIG_SERIAL_SH_SCI_CONSOLE=y
> CONFIG_EARLY_PRINTK=y
> CONFIG_BLK_DEV_INITRD=y"
> CONFIG_RD_GZIP=y
> CONFIG_BINFMT_ELF=y
> CONFIG_BINFMT_SCRIPT=y
> CONFIG_MISC_FILESYSTEMS=y
> CONFIG_DEVTMPFS=y
>
> Using "make ARCH=sh allnoconfig KCONFIG_ALLCONFIG=mini.conf", then build
> the result, then boot under qemu using the following command line:
>
> qemu-system-sh4 -M r2d -monitor null -serial null -serial stdio
> -nographic -no-reboot -append "panic=1 HOST=sh4 console=ttySC1 noiotrap"
> -kernel zImage -initrd sh4-linux-musl-root.cpio.gz
>
> You'll need a simple cpio.gz initramfs (I built one using
> https://github.com/landley/mkroot and the musl-cross-make cross
> compiler, the cpio.gz is ~450k or I'd attach it here).
>
> I bisected it to commit 18e8cf159177 back in February. If you do this
> with the revision _before_ that commit, typing "ls -l" and hitting enter
> works fine. Afterwards you get an "l" and then it hangs. (If type enough
> it'll eventually deal a burst of characters all at once, and then hang
> again.)

SH7751R has both SCI and SCIF ports. ttySC1 is the second (SCIF) port.

arch/sh/kernel/cpu/sh4/setup-sh7750.c registers a port with type PORT_SCIF,
so that should become SCIx_SH4_SCIF_REGTYPE. Hence I don't think the issue
is caused by changing fifosize to 64 for SCIx_SH7705_SCIF_REGTYPE.

My first guess is that qemu has a bug emulating the triggering.
According to the SH7751R datasheet, SCFCR does have the RTRG1 and RTRG0 bits.
I assume the problem goes away if you comment out the call to scif_set_rtrg()?

Does anyone have access to real hardware to try?
Adrian: does it work on your LANDISK, which also has SH7751R?

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
