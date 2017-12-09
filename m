From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH/RFC 5/5] ARM: shmobile: defconfig: Disable CONFIG_EMBEDDED
Date: Sat, 9 Dec 2017 09:54:14 +0100
Message-ID: <CAMuHMdXyipUUDnkPFXuijSbdd17vJ9TajYzwXx-sB6Hki=WqrA@mail.gmail.com>
References: <1512047522-16312-1-git-send-email-geert+renesas@glider.be>
 <1512047522-16312-6-git-send-email-geert+renesas@glider.be>
 <20171201083305.5vhvr6dfrbzemqgc@verge.net.au> <CAMuHMdXSWhXXEzPgp8Y35df7B6G+TUkddRK8=p6T3q+ugDNxCA@mail.gmail.com>
 <20171205082833.fqwuyvlmupwektny@verge.net.au> <1ad0fcaa-5edf-9206-4729-d1940842a31a@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1ad0fcaa-5edf-9206-4729-d1940842a31a@landley.net>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Rob Landley <rob@landley.net>
Cc: Simon Horman <horms@verge.net.au>, Geert Uytterhoeven <geert+renesas@glider.be>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Magnus Damm <magnus.damm@gmail.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Jiri Slaby <jslaby@suse.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, "moderated list:H8/300 ARCHITECTURE" <uclinux-h8-devel@lists.sourceforge.jp>, Linux-sh list <linux-sh@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

Hi Rob,

On Sat, Dec 9, 2017 at 3:18 AM, Rob Landley <rob@landley.net> wrote:
> On 12/05/2017 02:28 AM, Simon Horman wrote:
>> On Mon, Dec 04, 2017 at 10:46:22AM +0100, Geert Uytterhoeven wrote:
>>> On Fri, Dec 1, 2017 at 9:33 AM, Simon Horman <horms@verge.net.au> wrote:
>>>> On Thu, Nov 30, 2017 at 02:12:02PM +0100, Geert Uytterhoeven wrote:
>>>>> CONFIG_EXPERT exposes too many config options that do not matter for
>>>>> development. However, CONFIG_EMBEDDED selects CONFIG_EXPERT, so it
>>>>> cannot be disabled.
>>>>>
>>>>> Hence disable CONFIG_EMBEDDED, and compensate for the loss of
>>>>> CONFIG_DEBUG_KERNEL by enabling the latter.
>
> Didn't I already submit a patch to fix this in 2015?
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=560b8c0ed45a
>
> If it came back, it's a regression.

Your patch was for arch/sh/Kconfig, not for (arm32) shmobile_defconfig.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
