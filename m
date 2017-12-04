From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH/RFC 5/5] ARM: shmobile: defconfig: Disable CONFIG_EMBEDDED
Date: Mon, 4 Dec 2017 10:46:22 +0100
Message-ID: <CAMuHMdXSWhXXEzPgp8Y35df7B6G+TUkddRK8=p6T3q+ugDNxCA@mail.gmail.com>
References: <1512047522-16312-1-git-send-email-geert+renesas@glider.be>
 <1512047522-16312-6-git-send-email-geert+renesas@glider.be> <20171201083305.5vhvr6dfrbzemqgc@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20171201083305.5vhvr6dfrbzemqgc@verge.net.au>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Simon Horman <horms@verge.net.au>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Magnus Damm <magnus.damm@gmail.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Jiri Slaby <jslaby@suse.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, "moderated list:H8/300 ARCHITECTURE" <uclinux-h8-devel@lists.sourceforge.jp>, Linux-sh list <linux-sh@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

Hi Simon,

On Fri, Dec 1, 2017 at 9:33 AM, Simon Horman <horms@verge.net.au> wrote:
> On Thu, Nov 30, 2017 at 02:12:02PM +0100, Geert Uytterhoeven wrote:
>> CONFIG_EXPERT exposes too many config options that do not matter for
>> development. However, CONFIG_EMBEDDED selects CONFIG_EXPERT, so it
>> cannot be disabled.
>>
>> Hence disable CONFIG_EMBEDDED, and compensate for the loss of
>> CONFIG_DEBUG_KERNEL by enabling the latter.
>>
>> Actual impact:
>>   - CONFIG_NAMESPACES=y,
>>   - CONFIG_SYSCTL_SYSCALL=n,
>>   - CONFIG_SERIAL_SH_SCI_NR_UARTS changed from 20 to 18,
>>   - CONFIG_SERIAL_SH_SCI_EARLYCON=y,
>>   - Some HID support became enabled,
>>   - CONFIG_DEBUG_MEMORY_INIT=y,
>>
>> Refresh the result.
>
> I'm sorry but I don't understand the motivation for this change.
> I understand that it might make the image smaller or build times faster.
> But it seems to be a risky change for those benefits.

My main motivation is to start using the default values for the various SH_SCI
options from the first 4 patches, but that requires disabling CONFIG_EXPERT.
Sorry for not making that clearer.

> What are the side-effects of the changes you describe above?

Enabling CONFIG_NAMESPACES shouldn't hurt (isn't that also needed for
systemd anyway?), just like the HID devices, or CONFIG_DEBUG_MEMORY_INIT
(it does a few more checks, and defaults to yes).

Disabling CONFIG_SYSCTL_SYSCALL also shouldn't hurt (it defaults to no),
except for very old userland not yet using /proc/sys, which might have been
broken along the way by changed binary paths anyway.

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
