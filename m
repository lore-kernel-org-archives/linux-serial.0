From: alokc@codeaurora.org
Subject: Re: [PATCH 3/6] i2c: i2c-qcom-geni: Add interconnect support
Date: Wed, 23 Jan 2019 12:21:30 +0530
Message-ID: <d52763d50d610b44351663e18a960066@codeaurora.org>
References: <1548138816-1149-1-git-send-email-alokc@codeaurora.org>
 <1548138816-1149-4-git-send-email-alokc@codeaurora.org>
 <d44cdb5e-2408-493c-3f86-db97c224dc3f@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <d44cdb5e-2408-493c-3f86-db97c224dc3f@axentia.se>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Rosin <peda@axentia.se>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, linux-spi@vger.kernel.org, linux-serial@vger.kernel.org, Karthikeyan Ramasubramanian <kramasub@codeaurora.org>, andy.gross@linaro.org, david.brown@linaro.org, georgi.djakov@linaro.org, dianders@chromium.org, swboyd@chromium.org, bjorn.andersson@linaro.org, linux-arm-msm-owner@vger.kernel.org, Mark Brown <broonie@kernel.org>
List-Id: linux-serial@vger.kernel.org

On 2019-01-22 14:43, Peter Rosin wrote:
> On 2019-01-22 07:33, Alok Chauhan wrote:
>> Get the interconnect paths for I2C based Serial Engine device
>> and vote accordingly based on maximum supported I2C frequency.
>> 
>> Signed-off-by: Alok Chauhan <alokc@codeaurora.org>
>> ---
>>  drivers/i2c/busses/i2c-qcom-geni.c | 13 +++++++++++++
>>  1 file changed, 13 insertions(+)
>> 
>> diff --git a/drivers/i2c/busses/i2c-qcom-geni.c 
>> b/drivers/i2c/busses/i2c-qcom-geni.c
>> index db075bc..e8fe63a 100644
>> --- a/drivers/i2c/busses/i2c-qcom-geni.c
>> +++ b/drivers/i2c/busses/i2c-qcom-geni.c
>> @@ -14,6 +14,7 @@
>>  #include <linux/pm_runtime.h>
>>  #include <linux/qcom-geni-se.h>
>>  #include <linux/spinlock.h>
>> +#include <linux/interconnect.h>
> 
> Please keep the includes sorted. Probably applies for the other patches
> in the series as well?
> 
> Cheers,
> Peter

Sure, will do. Thanks for your comment.

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora 
Forum,a Linux Foundation Collaborative Project
