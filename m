From: Karthik Ramasubramanian <kramasub@codeaurora.org>
Subject: Re: [PATCH RFC 6/7] serial: Add device tree bindings for GENI based
 UART Controller
Date: Tue, 9 Jan 2018 11:36:30 -0700
Message-ID: <068baf4d-963e-f177-311d-d2c76d27a6f9@codeaurora.org>
References: <1514392046-30602-1-git-send-email-kramasub@codeaurora.org>
 <1514392046-30602-7-git-send-email-kramasub@codeaurora.org>
 <20180102155517.j4sqhdtamybtgta4@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <20180102155517.j4sqhdtamybtgta4@rob-hp-laptop>
Content-Language: en-US
Sender: linux-arm-msm-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org, linux-serial@vger.kernel.org, linux-doc@vger.kernel.org, devicetree@vger.kernel.org, andy.gross@linaro.org, david.brown@linaro.org, mark.rutland@arm.com, corbet@lwn.net, wsa@the-dreams.de, gregkh@linuxfoundation.org, jslaby@suse.com, Girish Mahadevan <girishm@codeaurora.org>
List-Id: linux-serial@vger.kernel.org



On 1/2/2018 8:55 AM, Rob Herring wrote:
> On Wed, Dec 27, 2017 at 09:27:25AM -0700, Karthikeyan Ramasubramanian wrote:
>> Add device tree binding support for GENI based UART Controller in the
>> QUP Wrapper.
>>
>> Signed-off-by: Karthikeyan Ramasubramanian <kramasub@codeaurora.org>
>> Signed-off-by: Girish Mahadevan <girishm@codeaurora.org>
>> ---
>>   .../devicetree/bindings/serial/qcom,geni-uart.txt  | 31 ++++++++++++++++++++++
>>   1 file changed, 31 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/serial/qcom,geni-uart.txt
>>
>> diff --git a/Documentation/devicetree/bindings/serial/qcom,geni-uart.txt b/Documentation/devicetree/bindings/serial/qcom,geni-uart.txt
>> new file mode 100644
>> index 0000000..e60ec6a
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/serial/qcom,geni-uart.txt
>> @@ -0,0 +1,31 @@
>> +Qualcomm Technologies Inc. GENI based Serial UART Controller driver
>> +
>> +This serial UART driver supports console use-cases. This driver is meant
>> +only for Generic Interface (GENI) based Qualcomm Universal Peripheral (QUP)
>> +cores and isn't backwards compatible.
>> +
>> +Required properties:
>> +- compatible: should contain "qcom,geni-uart, qcom,geni-console"
> 
> Is console different programming model or just how you are using the
> h/w? for the latter, drop it as we have stdout-path to select a console.
The console programming model is different from a regular UART port and 
hence the compatible field contains console in it.
> 
>> +- reg: Should contain UART register location and length.
>> +- interrupts: Should contain UART core interrupts.
>> +- clocks: clocks needed for UART, includes the core and AHB clock.
>> +- pinctrl-names/pinctrl-0/1: The GPIOs assigned to this core. The names
>> +  Should be "active" and "sleep" for the pin confuguration when core is active
>> +  or when entering sleep state.
>> +- qcom,wrapper-core: Wrapper QUP core containing this UART controller.
>> +
>> +Example:
>> +qup_uart11: qcom,qup_uart@0xa88000 {
> 
> Use generic node names and no '0x':
> 
> serial@a88000
I will update as per the recommendation.
> 
>> +	compatible = "qcom,geni-uart";
>> +	reg = <0xa88000 0x7000>;
>> +	reg-names = "se_phys";
>> +	clock-names = "se-clk", "m-ahb", "s-ahb";
> 
> Not documented.
I will add the documentation for the missing element.
> 
>> +	clocks = <&clock_gcc GCC_QUPV3_WRAP0_S0_CLK>,
>> +		<&clock_gcc GCC_QUPV3_WRAP_0_M_AHB_CLK>,
>> +		<&clock_gcc GCC_QUPV3_WRAP_0_S_AHB_CLK>;
>> +	pinctrl-names = "default", "sleep";
>> +	pinctrl-0 = <&qup_1_uart_3_active>;
>> +	pinctrl-1 = <&qup_1_uart_3_sleep>;
>> +	interrupts = <0 355 0>;
>> +	qcom,wrapper-core = <&qup_0>;
>> +};
>> -- 
>> Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
>> a Linux Foundation Collaborative Project
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-arm-msm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
Regards,
Karthik.
-- 
Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
