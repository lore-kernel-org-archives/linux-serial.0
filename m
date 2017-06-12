From: Neil Armstrong <narmstrong@baylibre.com>
Subject: Re: [PATCH v4 6/7] ARM: dts: meson8: switch to new bindings for UART
 nodes
Date: Mon, 12 Jun 2017 14:49:45 +0200
Message-ID: <bec2573f-ff71-8c69-9581-e74cdd80a551@baylibre.com>
References: <1497001756-942-1-git-send-email-narmstrong@baylibre.com>
 <1497001756-942-7-git-send-email-narmstrong@baylibre.com>
 <1497258823.3086.6.camel@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1497258823.3086.6.camel@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jerome Brunet <jbrunet@baylibre.com>, gregkh@linuxfoundation.org, khilman@baylibre.com
Cc: hgkr.klein@gmail.com, linux-serial@vger.kernel.org, linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 06/12/2017 11:13 AM, Jerome Brunet wrote:
> On Fri, 2017-06-09 at 11:49 +0200, Neil Armstrong wrote:
>> Switch to the stable UART bindings by adding a XTAL node and using the
>> proper compatible strings.
>>
>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>> ---
>>  arch/arm/boot/dts/meson8.dtsi | 23 +++++++++++++++++++----
>>  1 file changed, 19 insertions(+), 4 deletions(-)
> 
> I think this is clashing with the recent change from Martin on meson8 clock
> driver. Kevin just applied it : 
> 
> https://lkml.kernel.org/r/m2d1ad9g38.fsf@baylibre.com
> 
> <&clk81> no longer exists ...
> 
>>
>> diff --git a/arch/arm/boot/dts/meson8.dtsi b/arch/arm/boot/dts/meson8.dtsi
>> index 6993077..a2ea112 100644
>> --- a/arch/arm/boot/dts/meson8.dtsi
>> +++ b/arch/arm/boot/dts/meson8.dtsi
>> @@ -83,6 +83,13 @@
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
>> @@ -199,17 +206,25 @@
>>  };
>>  
>>  &uart_AO {
>> -	clocks = <&clk81>;
>> +	compatible = "amlogic,meson8-uart", "amlogic,meson-ao-uart";
>> +	clocks = <&xtal>, <&clk81>, <&clk81>;
>> +	clock-names = "xtal", "pclk", "baud";
>>  };
>>  
>>  &uart_A {
>> -	clocks = <&clk81>;
>> +	compatible = "amlogic,meson8-uart";
>> +	clocks = <&xtal>, <&clk81>, <&clk81>;
>> +	clock-names = "xtal", "pclk", "baud";
>>  };
>>  
>>  &uart_B {
>> -	clocks = <&clk81>;
>> +	compatible = "amlogic,meson8-uart";
>> +	clocks = <&xtal>, <&clk81>, <&clk81>;
>> +	clock-names = "xtal", "pclk", "baud";
>>  };
>>  
>>  &uart_C {
>> -	clocks = <&clk81>;
>> +	compatible = "amlogic,meson8-uart";
>> +	clocks = <&xtal>, <&clk81>, <&clk81>;
>> +	clock-names = "xtal", "pclk", "baud";
>>  };
> 

I will drop this until martin has a better version, and tested !

Neil
