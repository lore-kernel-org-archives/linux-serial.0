From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 23/25] arm64: renesas: r8a7795 dtsi: Add BRG support for (H)SCIF
Date: Fri, 20 Nov 2015 09:17:11 +0100
Message-ID: <CAMuHMdXVuaWj_y6mLMi7+r5yXO2dn4i3k+Vr5qPrNc36sHWsWg@mail.gmail.com>
References: <1447958344-836-1-git-send-email-geert+renesas@glider.be>
	<1447958344-836-24-git-send-email-geert+renesas@glider.be>
	<6606020.G1vmRDrqTj@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <6606020.G1vmRDrqTj@avalon>
Sender: linux-kernel-owner@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

Hi Laurent,

On Thu, Nov 19, 2015 at 10:07 PM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> On Thursday 19 November 2015 19:39:02 Geert Uytterhoeven wrote:
>> Add the device node for the external SCIF_CLK.
>> The presence of the SCIF_CLK crystal and its clock frequency depend on
>> the actual board.
>>
>> Add the two optional clock sources (ZS_CLK and SCIF_CLK for the internal
>> resp. external clock) for the Baud Rate Generator for External Clock
>> (BRG) to all SCIF and HSCIF device nodes.
>>
>> This increases the range and accuracy of supported baud rates on
>> (H)SCIF.
>>
>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>> ---
>>  arch/arm64/boot/dts/renesas/r8a7795.dtsi | 74 +++++++++++++++++++----------
>>  1 file changed, 52 insertions(+), 22 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
>> b/arch/arm64/boot/dts/renesas/r8a7795.dtsi index
>> 53a2a8fb42b7480c..25900761cfde201e 100644
>> --- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
>> +++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
>> @@ -84,6 +84,14 @@
>>               status = "disabled";
>>       };
>>
>> +     /* External SCIF clock - to be overridden by boards that provide it */
>> +     scif_clk: scif {
>> +             compatible = "fixed-clock";
>> +             #clock-cells = <0>;
>> +             clock-frequency = <0>;
>> +             status = "disabled";
>> +     };
>
> I have mixed feelings about this. Defining an external clock that isn't
> present on the board isn't very clean, even more so when the clock has such a

We have precedence of optional external clocks (can_clk, audio_clk_*).
The SoC datasheet clearly calls it "scif_clk", so that makes it an ABI, IMHO.

> generic name. Wouldn't it be better to let board files define the clock when
> they need it ? I know it would require board files to override the clocks and
> clock-names property too. Maybe we need to extend the DTS syntax to allow
> extending list properties instead of overriding them completely ?

As scif_clk is shared between all (H)SCIF instances, that would mean overriding
the clock and clock-names for all of them, which is quite a tedious task.
Most boards seem to provide a SCIF_CLK, to allow having "perfect" standard
baud rates.

Combined all of the above, I think it's sufficiently generic to keep
it that way.

Note that it's different for (H)SCK: these are per-(H)SCIF inputs, and depend
even more on board layout. Adding individual zero-frequency clock nodes for
them would preclude e.g. connecting all (H)SCK inputs to the same crystal.
Hence I didn't add them, and you do have to override all clocks and
clock-names of a node if you want to add an (H)SCK clock input (been there,
done that for testing; long live DT overlays).

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
