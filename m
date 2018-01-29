From: Karthik Ramasubramanian <kramasub@codeaurora.org>
Subject: Re: [PATCH v2 1/7] qcom-geni-se: Add QCOM GENI SE Driver summary
Date: Mon, 29 Jan 2018 14:52:48 -0700
Message-ID: <bbbdc7bb-6534-2289-4f8d-6826afe0ffc6@codeaurora.org>
References: <1515805547-22816-1-git-send-email-kramasub@codeaurora.org>
 <1515805547-22816-2-git-send-email-kramasub@codeaurora.org>
 <20180116165515.GF478@tuxbook>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
In-Reply-To: <20180116165515.GF478@tuxbook>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
To: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: corbet@lwn.net, andy.gross@linaro.org, david.brown@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, wsa@the-dreams.de, gregkh@linuxfoundation.org, linux-doc@vger.kernel.org, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-i2c@vger.kernel.org, linux-serial@vger.kernel.org, jslaby@suse.com
List-Id: linux-serial@vger.kernel.org


On 1/16/2018 9:55 AM, Bjorn Andersson wrote:
> On Fri 12 Jan 17:05 PST 2018, Karthikeyan Ramasubramanian wrote:
> 
>> Generic Interface (GENI) firmware based Qualcomm Universal Peripheral (QUP)
>> Wrapper is a programmable module that is composed of multiple Serial
>> Engines (SE) and can support various Serial Interfaces like UART, SPI,
>> I2C, I3C, etc. This document provides a high level overview of the GENI
>> based QUP Wrapper.
>>
>> Signed-off-by: Karthikeyan Ramasubramanian <kramasub@codeaurora.org>
> 
> Rather than adding a disconnected chunk of documentation move this into
> the driver(s), using the format described in
> https://www.kernel.org/doc/html/latest/doc-guide/kernel-doc.html?highlight=kernel%20doc#overview-documentation-comments
I will move the documentation into the driver source file.
> 
> Regards,
> Bjorn
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
