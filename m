From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] serial: Make SERIAL_MPS2_UART depend on ARCH_MPS2
Date: Fri, 13 May 2016 10:57:56 +0200
Message-ID: <CAMuHMdUCAyrK5hC+erph+6km8LL__3vd7Vr6SMo1N3FLN3zxHw@mail.gmail.com>
References: <1462906570-27684-1-git-send-email-geert+renesas@glider.be>
 <573591C6.1070106@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <573591C6.1070106@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Vladimir Murzin <vladimir.murzin@arm.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sudeep Holla <sudeep.holla@arm.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Jiri Slaby <jslaby@suse.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

Hi Vladimir,

On Fri, May 13, 2016 at 10:35 AM, Vladimir Murzin
<vladimir.murzin@arm.com> wrote:
> On 10/05/16 19:56, Geert Uytterhoeven wrote:
>> Enabling support for the UART on the ARM MPS2 platform only make sense
>> when compiling for the ARM MPS2 platform, unless compile-testing.
>
> What you said is true, but looking around (see SERIAL_STM32 for example)
> I'm wondering what makes MPS2 so special flake?

Nothing. SERIAL_STM32 should be fixed, too.
I only fixed SERIAL_MPS2_UART, as it was a newly-introduced symbol.

> I was under impression that architecture/board specific guard must have
> only if we have something like
>
> #include <asm/xyz.h>
>
> or
>
> #include <mach/xyz.h>
>
> which is not a case for device-tree driven MPS2 uart.
>
> I have no idea what is practice for such things, so would be grateful to
> get it known.

That's why there's an "|| COMPILE_TEST" in the dependency.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
