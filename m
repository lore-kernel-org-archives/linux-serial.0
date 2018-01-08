From: Karthik Ramasubramanian <kramasub-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH RFC 2/7] soc: qcom: Add device tree binding for GENI SE
Date: Mon, 8 Jan 2018 16:57:36 -0700
Message-ID: <4caa6656-8c30-6697-7157-934b7975bff5@codeaurora.org>
References: <1514392046-30602-1-git-send-email-kramasub@codeaurora.org>
 <1514392046-30602-3-git-send-email-kramasub@codeaurora.org>
 <20180102154629.s6rni5r3big2g5sv@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20180102154629.s6rni5r3big2g5sv@rob-hp-laptop>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, andy.gross-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, david.brown-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, corbet-T1hC0tSOHrs@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, jslaby-IBi9RG/b67k@public.gmane.org
List-Id: linux-serial@vger.kernel.org



On 1/2/2018 8:46 AM, Rob Herring wrote:
> On Wed, Dec 27, 2017 at 09:27:21AM -0700, Karthikeyan Ramasubramanian wrote:
>> Add device tree binding support for the QCOM GENI SE driver.
>>
>> Signed-off-by: Karthikeyan Ramasubramanian <kramasub-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
>> ---
>>   .../devicetree/bindings/soc/qcom/qcom,geni-se.txt         | 15 +++++++++++++++
>>   1 file changed, 15 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.txt
>>
>> diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.txt b/Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.txt
>> new file mode 100644
>> index 0000000..5108b62
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.txt
>> @@ -0,0 +1,15 @@
>> +Qualcomm Technologies, Inc. GENI Serial Engine Driver
>> +
>> +GENI Serial Engine Driver manages the GENI firmware based Qualcomm Universal
>> +Peripheral (QUP) Wrapper. GENI SE Driver also manages the common aspects of
>> +individual Serial Engines that composes the QUP Wrapper.
> 
> Bindings describe h/w, not drivers.
I will update the bindings to describe just the h/w and remove any 
driver description.
> 
>> +
>> +Required properties:
>> +- compatible:		Must be "qcom,geni-se-qup".
> 
> Only one version of the h/w?
There is more than one hardware version. The h/w provides registers to 
identify the hardware version. The driver currently uses those registers 
to support any version-specific operations. So I am not sure if the 
compatible field needs to reflect the h/w version.
> 
>> +- reg:			Must contain QUP register address and length.
>> +
>> +Example:
>> +	qup_0: qcom,geni_se_qup_0@8c0000 {
> 
> Don't use '_' in node names.
I will update the bindings to not use '_'.
> 
>> +		compatible = "qcom,geni-se-qup";
>> +		reg = <0x8c0000 0x6000>;
>> +	}
>> -- 
>> Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
>> a Linux Foundation Collaborative Project
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-arm-msm" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
Regards,
Karthik.
-- 
Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
