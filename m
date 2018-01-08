From: Karthik Ramasubramanian <kramasub-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH RFC 2/7] soc: qcom: Add device tree binding for GENI SE
Date: Mon, 8 Jan 2018 16:59:06 -0700
Message-ID: <0bee125c-abe3-8372-f7e1-d4ded493e83d@codeaurora.org>
References: <1514392046-30602-1-git-send-email-kramasub@codeaurora.org>
 <1514392046-30602-3-git-send-email-kramasub@codeaurora.org>
 <20180102154734.pbomm5rehyquemp3@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20180102154734.pbomm5rehyquemp3@rob-hp-laptop>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, andy.gross-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, david.brown-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, corbet-T1hC0tSOHrs@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, jslaby-IBi9RG/b67k@public.gmane.org
List-Id: linux-serial@vger.kernel.org



On 1/2/2018 8:47 AM, Rob Herring wrote:
> On Wed, Dec 27, 2017 at 09:27:21AM -0700, Karthikeyan Ramasubramanian wrote:
>> Add device tree binding support for the QCOM GENI SE driver.
> 
> Also, "dt-bindings: ..." is the preferred subject prefix. Same for the
> rest of the series.
I will update the subject-prefix.
> 
>>
>> Signed-off-by: Karthikeyan Ramasubramanian <kramasub-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
>> ---
>>   .../devicetree/bindings/soc/qcom/qcom,geni-se.txt         | 15 +++++++++++++++
>>   1 file changed, 15 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.txt
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
