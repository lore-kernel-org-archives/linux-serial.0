From: Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH v13 1/2] arm: dts: mt2712: add uart APDMA to device tree
Date: Thu, 23 May 2019 19:08:57 +0200
Message-ID: <9c7fdd43-dffe-9339-272d-62311a39dbb9@gmail.com>
References: <1558596909-14084-1-git-send-email-long.cheng@mediatek.com>
 <1558596909-14084-2-git-send-email-long.cheng@mediatek.com>
 <434cbd9b-face-de45-0d17-4096ad81a7b9@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <434cbd9b-face-de45-0d17-4096ad81a7b9@gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Long Cheng <long.cheng@mediatek.com>, Vinod Koul <vkoul@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Ryder Lee <ryder.lee@mediatek.com>, Sean Wang <sean.wang@kernel.org>, Nicolas Boichat <drinkcat@chromium.org>
Cc: Dan Williams <dan.j.williams@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Sean Wang <sean.wang@mediatek.com>, dmaengine@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, srv_heupstream@mediatek.com, Yingjoe Chen <yingjoe.chen@mediatek.com>, YT Shen <yt.shen@mediatek.com>, Zhenbao Liu <zhenbao.liu@mediatek.com>
List-Id: linux-serial@vger.kernel.org



On 23/05/2019 19:04, Matthias Brugger wrote:
> 
> 
> On 23/05/2019 09:35, Long Cheng wrote:
>> 1. add uart APDMA controller device node
>> 2. add uart 0/1/2/3/4/5 DMA function
>>
>> Signed-off-by: Long Cheng <long.cheng@mediatek.com>
>> ---
>>  arch/arm64/boot/dts/mediatek/mt2712e.dtsi |   51 +++++++++++++++++++++++++++++
>>  1 file changed, 51 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/mediatek/mt2712e.dtsi b/arch/arm64/boot/dts/mediatek/mt2712e.dtsi
>> index 43307ba..a7a7362 100644
>> --- a/arch/arm64/boot/dts/mediatek/mt2712e.dtsi
>> +++ b/arch/arm64/boot/dts/mediatek/mt2712e.dtsi
>> @@ -300,6 +300,9 @@
>>  		interrupts = <GIC_SPI 127 IRQ_TYPE_LEVEL_LOW>;
>>  		clocks = <&baud_clk>, <&sys_clk>;
>>  		clock-names = "baud", "bus";
>> +		dmas = <&apdma 10
>> +			&apdma 11>;
>> +		dma-names = "tx", "rx";
>>  		status = "disabled";
>>  	};
>>  
>> @@ -369,6 +372,39 @@
>>  			 (GIC_CPU_MASK_RAW(0x13) | IRQ_TYPE_LEVEL_HIGH)>;
>>  	};
>>  
>> +	apdma: dma-controller@11000400 {
>> +		compatible = "mediatek,mt2712-uart-dma",
>> +			     "mediatek,mt6577-uart-dma";
> 
> I was able to find a binding descpription but no actual driver.
> drivers/dma/mediatek only has hsdma and cqdma but no apdma driver.
> 
> Seems there is something missing here.
> 

Sorry I just realized that tje driver got merged from v12.

Regards,
Matthias

> Regards,
> Matthias
> 
>> +		reg = <0 0x11000400 0 0x80>,
>> +		      <0 0x11000480 0 0x80>,
>> +		      <0 0x11000500 0 0x80>,
>> +		      <0 0x11000580 0 0x80>,
>> +		      <0 0x11000600 0 0x80>,
>> +		      <0 0x11000680 0 0x80>,
>> +		      <0 0x11000700 0 0x80>,
>> +		      <0 0x11000780 0 0x80>,
>> +		      <0 0x11000800 0 0x80>,
>> +		      <0 0x11000880 0 0x80>,
>> +		      <0 0x11000900 0 0x80>,
>> +		      <0 0x11000980 0 0x80>;
>> +		interrupts = <GIC_SPI 103 IRQ_TYPE_LEVEL_LOW>,
>> +			     <GIC_SPI 104 IRQ_TYPE_LEVEL_LOW>,
>> +			     <GIC_SPI 105 IRQ_TYPE_LEVEL_LOW>,
>> +			     <GIC_SPI 106 IRQ_TYPE_LEVEL_LOW>,
>> +			     <GIC_SPI 107 IRQ_TYPE_LEVEL_LOW>,
>> +			     <GIC_SPI 108 IRQ_TYPE_LEVEL_LOW>,
>> +			     <GIC_SPI 109 IRQ_TYPE_LEVEL_LOW>,
>> +			     <GIC_SPI 110 IRQ_TYPE_LEVEL_LOW>,
>> +			     <GIC_SPI 111 IRQ_TYPE_LEVEL_LOW>,
>> +			     <GIC_SPI 112 IRQ_TYPE_LEVEL_LOW>,
>> +			     <GIC_SPI 113 IRQ_TYPE_LEVEL_LOW>,
>> +			     <GIC_SPI 114 IRQ_TYPE_LEVEL_LOW>;
>> +		dma-requests = <12>;
>> +		clocks = <&pericfg CLK_PERI_AP_DMA>;
>> +		clock-names = "apdma";
>> +		#dma-cells = <1>;
>> +	};
>> +
>>  	auxadc: adc@11001000 {
>>  		compatible = "mediatek,mt2712-auxadc";
>>  		reg = <0 0x11001000 0 0x1000>;
>> @@ -385,6 +421,9 @@
>>  		interrupts = <GIC_SPI 91 IRQ_TYPE_LEVEL_LOW>;
>>  		clocks = <&baud_clk>, <&sys_clk>;
>>  		clock-names = "baud", "bus";
>> +		dmas = <&apdma 0
>> +			&apdma 1>;
>> +		dma-names = "tx", "rx";
>>  		status = "disabled";
>>  	};
>>  
>> @@ -395,6 +434,9 @@
>>  		interrupts = <GIC_SPI 92 IRQ_TYPE_LEVEL_LOW>;
>>  		clocks = <&baud_clk>, <&sys_clk>;
>>  		clock-names = "baud", "bus";
>> +		dmas = <&apdma 2
>> +			&apdma 3>;
>> +		dma-names = "tx", "rx";
>>  		status = "disabled";
>>  	};
>>  
>> @@ -405,6 +447,9 @@
>>  		interrupts = <GIC_SPI 93 IRQ_TYPE_LEVEL_LOW>;
>>  		clocks = <&baud_clk>, <&sys_clk>;
>>  		clock-names = "baud", "bus";
>> +		dmas = <&apdma 4
>> +			&apdma 5>;
>> +		dma-names = "tx", "rx";
>>  		status = "disabled";
>>  	};
>>  
>> @@ -415,6 +460,9 @@
>>  		interrupts = <GIC_SPI 94 IRQ_TYPE_LEVEL_LOW>;
>>  		clocks = <&baud_clk>, <&sys_clk>;
>>  		clock-names = "baud", "bus";
>> +		dmas = <&apdma 6
>> +			&apdma 7>;
>> +		dma-names = "tx", "rx";
>>  		status = "disabled";
>>  	};
>>  
>> @@ -629,6 +677,9 @@
>>  		interrupts = <GIC_SPI 126 IRQ_TYPE_LEVEL_LOW>;
>>  		clocks = <&baud_clk>, <&sys_clk>;
>>  		clock-names = "baud", "bus";
>> +		dmas = <&apdma 8
>> +			&apdma 9>;
>> +		dma-names = "tx", "rx";
>>  		status = "disabled";
>>  	};
>>  
>>
