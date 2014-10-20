From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH V2 4/9] Documentation: DT: Add entries for bcm63xx UART
Date: Mon, 20 Oct 2014 23:20:08 +0200
Message-ID: <6216923.cK1phqtEXn@wuerfel>
References: <1413838448-29464-1-git-send-email-cernekee@gmail.com> <1413838448-29464-5-git-send-email-cernekee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mips-bounce@linux-mips.org>
In-Reply-To: <1413838448-29464-5-git-send-email-cernekee@gmail.com>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
To: Kevin Cernekee <cernekee@gmail.com>
Cc: gregkh@linuxfoundation.org, jslaby@suse.cz, robh@kernel.org, grant.likely@linaro.org, geert@linux-m68k.org, f.fainelli@gmail.com, mbizon@freebox.fr, jogo@openwrt.org, linux-mips@linux-mips.org, linux-serial@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Monday 20 October 2014 13:54:03 Kevin Cernekee wrote:
> +- clock-names: The appropriate output name in the referenced clock node.
> +
> +       uart0: serial@14e00520 {
> +               compatible = "brcm,bcm6345-uart";
> +               reg = <0x14e00520 0x18>;
> +               interrupt-parent = <&periph_intc>;
> +               interrupts = <2>;
> +               clocks = <&periph_clk>;
> +               clock-names = "periph";
> +       };
> +
> +       clocks {
> +               periph_clk: periph_clk@0 {
> +                       compatible = "fixed-clock";
> +                       #clock-cells = <0>;
> +                       clock-frequency = <54000000>;
> +                       clock-output-names = "periph";
> +               };
> +       };

In this example, the clock output name of the clock provider is
the same as the clock input of the consumer, that is almost always
a bug and would not be a good example at all.

I assume the output name is correct and the input is not. If you
have access to the HDL source of the bcm6345-uart, please check
if the input has a proper name, otherwise just call it "uart"
or remove the clock-names property completely.

In the documentation enough, you must document the specific name
of the clock that is supposed to be used by the uart driver.

	Arnd
