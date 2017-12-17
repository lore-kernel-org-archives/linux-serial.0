From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [tty:tty-next 23/34] include/linux/kconfig.h:5:10: fatal error:
 generated/autoconf.h: No such file or directory
Date: Sun, 17 Dec 2017 11:15:37 +0100
Message-ID: <CAMuHMdXNNB7+-J7+M+0k+s=TDvTs_MVM4=AjjSi0x63p2HBaNQ@mail.gmail.com>
References: <201712161029.StXUUOBC%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <201712161029.StXUUOBC%fengguang.wu@intel.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, kbuild test robot <fengguang.wu@intel.com>, kbuild-all@01.org, linux-serial@vger.kernel.org, Linux-Renesas <linux-renesas-soc@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Sat, Dec 16, 2017 at 3:00 AM, kbuild test robot
<fengguang.wu@intel.com> wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-next
> head:   38d5583ff8900c543322a74471b436d1b8b4018a
> commit: f6731485a51978ca0931c787fcb8a0bc4dcc9303 [23/34] tty: serial: sh-sci: Hide number of ports config question
> config: ia64-allyesconfig (attached as .config)
> compiler: ia64-linux-gcc (GCC) 7.2.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout f6731485a51978ca0931c787fcb8a0bc4dcc9303
>         # save the attached .config to linux build tree
>         make.cross ARCH=ia64
>
> All errors (new ones prefixed by >>):
>
>    .config:3814:warning: symbol value '' invalid for SERIAL_SH_SCI_NR_UARTS

config SERIAL_SH_SCI_NR_UARTS
        int "Maximum number of SCI(F) serial ports" if EXPERT
        depends on SERIAL_SH_SCI
        default "3" if H8300
        default "10" if SUPERH
        default "18" if ARCH_RENESAS

Doh, if test compiling for non-H8300/SUPERH/ARCH_RENESAS, "int" doesn't
assign a sane numerical default value to the symbol, but an empty string :-(

So we do need e.g.

        default "2"

at the bottom.

Greg: Do you want a v2, or an incremental patch?

Thanks, and sorry for missing this.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
