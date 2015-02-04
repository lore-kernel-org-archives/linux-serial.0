From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH_V2 04/34] MIPS: jz4740: probe CPU interrupt controller
 via DT
Date: Wed, 04 Feb 2015 20:05:18 +0300
Message-ID: <54D2514E.3020409@cogentembedded.com>
References: <1423063323-19419-1-git-send-email-Zubair.Kakakhel@imgtec.com> <1423063323-19419-5-git-send-email-Zubair.Kakakhel@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1423063323-19419-5-git-send-email-Zubair.Kakakhel@imgtec.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>, linux-mips@linux-mips.org
Cc: devicetree@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, mturquette@linaro.org, sboyd@codeaurora.org, ralf@linux-mips.org, jslaby@suse.cz, tglx@linutronix.de, jason@lakedaemon.net, lars@metafoo.de, paul.burton@imgtec.com
List-Id: linux-serial@vger.kernel.org

Hello.

On 02/04/2015 06:21 PM, Zubair Lutfullah Kakakhel wrote:

> From: Paul Burton <paul.burton@imgtec.com>

> Use the generic irqchip_init function to probe irqchip drivers using DT,
> and add the appropriate node to the jz4740 devicetree in place of the
> call to mips_cpu_irq_init.

> Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> ---
>   arch/mips/boot/dts/jz4740.dtsi | 7 +++++++
>   arch/mips/jz4740/irq.c         | 4 ++--
>   2 files changed, 9 insertions(+), 2 deletions(-)

> diff --git a/arch/mips/boot/dts/jz4740.dtsi b/arch/mips/boot/dts/jz4740.dtsi
> index c538691f..2d64765c 100644
> --- a/arch/mips/boot/dts/jz4740.dtsi
> +++ b/arch/mips/boot/dts/jz4740.dtsi
> @@ -2,4 +2,11 @@
>   	#address-cells = <1>;
>   	#size-cells = <1>;
>   	compatible = "ingenic,jz4740";
> +
> +	cpuintc: cpuintc@0 {

    Please name it "interrupt-controller". And why there's <unit-address> if 
there's no "reg" prop?

> +		#address-cells = <0>;
> +		#interrupt-cells = <1>;
> +		interrupt-controller;
> +		compatible = "mti,cpu-interrupt-controller";
> +	};
>   };
[...]

WBR, Sergei
