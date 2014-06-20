From: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Subject: Fwd: Re: [PATCH v2 17/20] ARM: sunxi: Introduce
 Allwinner A23 support
Date: Fri, 20 Jun 2014 13:59:07 +0800
Message-ID: <CAGb2v65VMBLBf787UmUkmTqhXAZZxSqmFUMwDAWTFtSi7s0yqQ@mail.gmail.com>
References: <1403016777-15121-1-git-send-email-wens@csie.org>
 <1403016777-15121-18-git-send-email-wens@csie.org> <20140618122646.GS19730@lukather>
 <CAGb2v67zkwvspdDr-rKv=5uT5mvP4e1ZyzHSSOXmvaiOxA+7OA@mail.gmail.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBCMILY6JWQBBBP43R6OQKGQEPNBFFFI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <CAGb2v67zkwvspdDr-rKv=5uT5mvP4e1ZyzHSSOXmvaiOxA+7OA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: "maxime.ripard" <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Emilio Lopez <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Boris BREZILLON <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Luc Verhaegen <libv-AgBVmzD5pcezQB+pC5nmwQ@public.gmane.org>, linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

On Wed, Jun 18, 2014 at 8:26 PM, Maxime Ripard
<maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org> wrote:
> On Tue, Jun 17, 2014 at 10:52:54PM +0800, Chen-Yu Tsai wrote:
>> The Allwinner A23 is a dual-core Cortex-A7-based SoC. It re-uses most of
>> the IPs found in previous SoCs, notably the A31.
>>
>> Signed-off-by: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
>> ---
>>  arch/arm/mach-sunxi/Kconfig |  8 ++++++++
>>  arch/arm/mach-sunxi/sunxi.c | 10 ++++++++++
>>  2 files changed, 18 insertions(+)
>>
>> diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
>> index 0fbd4f1..6434e3b 100644
>> --- a/arch/arm/mach-sunxi/Kconfig
>> +++ b/arch/arm/mach-sunxi/Kconfig
>> @@ -35,4 +35,12 @@ config MACH_SUN7I
>>       select HAVE_ARM_ARCH_TIMER
>>       select SUN5I_HSTIMER
>>
>> +config MACH_SUN8I
>> +     bool "Allwinner A23 (sun8i) SoCs support"
>> +     default ARCH_SUNXI
>> +     select ARCH_HAS_RESET_CONTROLLER
>> +     select ARM_GIC
>> +     select MFD_SUN6I_PRCM
>> +     select RESET_CONTROLLER
>> +
>>  endif
>> diff --git a/arch/arm/mach-sunxi/sunxi.c b/arch/arm/mach-sunxi/sunxi.c
>> index 3f9587b..962ff30 100644
>> --- a/arch/arm/mach-sunxi/sunxi.c
>> +++ b/arch/arm/mach-sunxi/sunxi.c
>> @@ -53,3 +53,13 @@ static const char * const sun7i_board_dt_compat[] = {
>>  DT_MACHINE_START(SUN7I_DT, "Allwinner sun7i (A20) Family")
>>       .dt_compat      = sun7i_board_dt_compat,
>>  MACHINE_END
>> +
>> +static const char * const sun8i_board_dt_compat[] = {
>> +     "allwinner,sun8i-a23",
>> +     NULL,
>> +};
>> +
>> +DT_MACHINE_START(SUN8I_DT, "Allwinner sun8i (A23) Family")
>> +     .init_time      = sun6i_timer_init,
>
> I haven't seen anything in your code that needed to use this
> function. Am I missing something?

(Adding Maxime back to recipients...)

My mistake. From the log I thought all timers needed the reset
controller. Turns out only the high speed timer does.

I'll remove the call in the next version.


ChenYu
