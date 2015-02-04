From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH_V2 09/34] MIPS: jz4740: probe interrupt controller via
 DT
Date: Wed, 04 Feb 2015 20:09:38 +0300
Message-ID: <54D25252.2010406@cogentembedded.com>
References: <1423063323-19419-1-git-send-email-Zubair.Kakakhel@imgtec.com> <1423063323-19419-10-git-send-email-Zubair.Kakakhel@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1423063323-19419-10-git-send-email-Zubair.Kakakhel@imgtec.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>, linux-mips@linux-mips.org
Cc: devicetree@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, mturquette@linaro.org, sboyd@codeaurora.org, ralf@linux-mips.org, jslaby@suse.cz, tglx@linutronix.de, jason@lakedaemon.net, lars@metafoo.de, paul.burton@imgtec.com
List-Id: linux-serial@vger.kernel.org

On 02/04/2015 06:21 PM, Zubair Lutfullah Kakakhel wrote:

> From: Paul Burton <paul.burton@imgtec.com>

> Add the appropriate DT node to probe the interrupt controller driver
> using the devicetree, and remove the call to jz4740_intc_init.

> Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> ---
>   arch/mips/boot/dts/jz4740.dtsi | 11 +++++++++++
>   arch/mips/jz4740/setup.c       |  2 --
>   2 files changed, 11 insertions(+), 2 deletions(-)

> diff --git a/arch/mips/boot/dts/jz4740.dtsi b/arch/mips/boot/dts/jz4740.dtsi
> index 2d64765c..3841024 100644
> --- a/arch/mips/boot/dts/jz4740.dtsi
> +++ b/arch/mips/boot/dts/jz4740.dtsi
> @@ -9,4 +9,15 @@
>   		interrupt-controller;
>   		compatible = "mti,cpu-interrupt-controller";
>   	};
> +
> +	intc: intc@10001000 {

    Name it "interrupt-controller@10001000", please. I have faint memories of 
already telling you to do this...

> +		compatible = "ingenic,jz4740-intc";
> +		reg = <0x10001000 0x14>;
> +
> +		interrupt-controller;
> +		#interrupt-cells = <1>;
> +
> +		interrupt-parent = <&cpuintc>;
> +		interrupts = <2>;
> +	};
>   };
[...]

WBR, Sergei
