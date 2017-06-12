From: Neil Armstrong <narmstrong@baylibre.com>
Subject: Re: [PATCH v4 5/7] ARM: dts: meson6: switch to new bindings for UART
 nodes
Date: Mon, 12 Jun 2017 14:49:14 +0200
Message-ID: <85fec9ad-1191-4afb-3938-a3d07918823e@baylibre.com>
References: <1497001756-942-1-git-send-email-narmstrong@baylibre.com>
 <1497001756-942-6-git-send-email-narmstrong@baylibre.com>
 <1497260577.3086.11.camel@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1497260577.3086.11.camel@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jerome Brunet <jbrunet@baylibre.com>, gregkh@linuxfoundation.org, khilman@baylibre.com
Cc: hgkr.klein@gmail.com, linux-serial@vger.kernel.org, linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 06/12/2017 11:42 AM, Jerome Brunet wrote:
> On Fri, 2017-06-09 at 11:49 +0200, Neil Armstrong wrote:
>> Switch to the stable UART bindings by adding a XTAL node and using the
>> proper compatible strings.
>>
>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> 
> Shouldn't this patch be squashed with patch 4 ?
> 

Yep, so it doesn't break bisect.

Neil

> 
>> ---
>>  arch/arm/boot/dts/meson6.dtsi | 28 ++++++++++++++++++++++++++++
>>  1 file changed, 28 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/meson6.dtsi b/arch/arm/boot/dts/meson6.dtsi
>> index b0fc91f..a334fbe 100644
>> --- a/arch/arm/boot/dts/meson6.dtsi
>> +++ b/arch/arm/boot/dts/meson6.dtsi
>> @@ -70,9 +70,37 @@
>>  		};
>>  	};
>>  
>> +	xtal: xtal-clk {
>> +		compatible = "fixed-clock";
>> +		clock-frequency = <24000000>;
>> +		clock-output-names = "xtal";
>> +		#clock-cells = <0>;
>> +	};
>> +
>>  	clk81: clk@0 {
>>  		#clock-cells = <0>;
>>  		compatible = "fixed-clock";
>>  		clock-frequency = <200000000>;
>>  	};
>>  }; /* end of / */
>> +
>> +
>> +&uart_AO {
>> +	clocks = <&xtal>, <&clk81>, <&clk81>;
>> +	clock-names = "xtal", "pclk", "baud";
>> +};
>> +
>> +&uart_A {
>> +	clocks = <&xtal>, <&clk81>, <&clk81>;
>> +	clock-names = "xtal", "pclk", "baud";
>> +};
>> +
>> +&uart_B {
>> +	clocks = <&xtal>, <&clk81>, <&clk81>;
>> +	clock-names = "xtal", "pclk", "baud";
>> +};
>> +
>> +&uart_C {
>> +	clocks = <&xtal>, <&clk81>, <&clk81>;
>> +	clock-names = "xtal", "pclk", "baud";
>> +};
> 
