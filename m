From: Rajendra Nayak <rnayak@codeaurora.org>
Subject: Re: [PATCH v2 3/7] soc: qcom: Add GENI based QUP Wrapper driver
Date: Thu, 18 Jan 2018 14:43:58 +0530
Message-ID: <29ed5b45-dd70-fb70-3aa4-4e1a0006d57e@codeaurora.org>
References: <1515805547-22816-1-git-send-email-kramasub@codeaurora.org>
 <1515805547-22816-4-git-send-email-kramasub@codeaurora.org>
 <20180117062002.GA6620@minitux>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20180117062002.GA6620@minitux>
Content-Language: en-US
Sender: linux-doc-owner@vger.kernel.org
To: Bjorn Andersson <bjorn.andersson@linaro.org>, Karthikeyan Ramasubramanian <kramasub@codeaurora.org>
Cc: corbet@lwn.net, andy.gross@linaro.org, david.brown@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, wsa@the-dreams.de, gregkh@linuxfoundation.org, linux-doc@vger.kernel.org, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-i2c@vger.kernel.org, linux-serial@vger.kernel.org, jslaby@suse.com, Sagar Dharia <sdharia@codeaurora.org>, Girish Mahadevan <girishm@codeaurora.org>
List-Id: linux-serial@vger.kernel.org

[]..

>> diff --git a/drivers/soc/qcom/qcom-geni-se.c b/drivers/soc/qcom/qcom-geni-se.c
>> new file mode 100644
>> index 0000000..3f43582
>> --- /dev/null
>> +++ b/drivers/soc/qcom/qcom-geni-se.c
>> @@ -0,0 +1,1016 @@
>> +/*
>> + * Copyright (c) 2017-2018, The Linux Foundation. All rights reserved.
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 and
>> + * only version 2 as published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + *
>> + */
> 
> Please use SPDX style license header, i.e. this file should start with:
> 
> // SPDX-License-Identifier: GPL-2.0
> /*
>  * Copyright (c) 2017-2018, The Linux Foundation. All rights reserved.
>  */

Looks like Mark Brown commented elsewhere [1] that we should use the C++
commenting style even for the Linux Foundation copyright?

[1] https://marc.info/?l=linux-clk&m=151497978626135&w=2 

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
