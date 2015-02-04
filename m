From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH_V2 15/34] dt: clk: Add ingenic,jz4740-cgu binding documentation
Date: Wed, 04 Feb 2015 17:27:23 +0100
Message-ID: <33166978.Cd8LolvEG6@wuerfel>
References: <1423063323-19419-1-git-send-email-Zubair.Kakakhel@imgtec.com> <1423063323-19419-16-git-send-email-Zubair.Kakakhel@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mips-bounce@linux-mips.org>
In-Reply-To: <1423063323-19419-16-git-send-email-Zubair.Kakakhel@imgtec.com>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
To: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
Cc: linux-mips@linux-mips.org, devicetree@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, mturquette@linaro.org, sboyd@codeaurora.org, ralf@linux-mips.org, jslaby@suse.cz, tglx@linutronix.de, jason@lakedaemon.net, lars@metafoo.de, paul.burton@imgtec.com
List-Id: linux-serial@vger.kernel.org

On Wednesday 04 February 2015 15:21:44 Zubair Lutfullah Kakakhel wrote:
> 
> +/ {
> +       ext: clock@0 {
> +               compatible = "fixed-clock";
> +               #clock-cells = <0>;
> +               clock-frequency = <12000000>;
> +       };
> +
> +       rtc: clock@1 {
> +               compatible = "fixed-clock";
> +               #clock-cells = <0>;
> +               clock-frequency = <32768>;
> +       };
> +
> +       &cgu {
> +               clocks = <&ext> <&rtc>;
> +               clock-names: "ext", "rtc";
> +       };
> +};
> diff --git a/include/dt-bindings/clock/jz4740-cgu.h b/include/dt-bindings/clock/jz4740-cgu.h
> new file mode 100644
> index 0000000..43153d3
> --- /dev/null
> +++ b/include/dt-bindings/clock/jz4740-cgu.h
> @@ -0,0 +1,37 @@
> +/*
> + * This header provides clock numbers for the ingenic,jz4740-cgu DT binding.
> + *
> + * They are roughly ordered as:
> + *   - external clocks
> + *   - PLLs
> + *   - muxes/dividers in the order they appear in the jz4740 programmers manual
> + *   - gates in order of their bit in the CLKGR* registers
> + */
> +
> +#ifndef __DT_BINDINGS_CLOCK_JZ4740_CGU_H__
> +#define __DT_BINDINGS_CLOCK_JZ4740_CGU_H__
> +
> +#define JZ4740_CLK_EXT         0
> +#define JZ4740_CLK_RTC         1
> +#define JZ4740_CLK_PLL         2
> +#define JZ4740_CLK_PLL_HALF    3

So there are fixed clocks for ext and rtc that are used as inputs
to the cgu, but also outputs with the same name. How do these relate?

	Arnd
