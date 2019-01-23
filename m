From: alokc@codeaurora.org
Subject: Re: [PATCH 4/6] spi: spi-geni-qcom: Add interconnect support
Date: Wed, 23 Jan 2019 12:45:30 +0530
Message-ID: <775cdd29a7d536772330a15a7013f251@codeaurora.org>
References: <1548138816-1149-1-git-send-email-alokc@codeaurora.org>
 <1548138816-1149-5-git-send-email-alokc@codeaurora.org>
 <20190122202924.GL7579@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190122202924.GL7579@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, linux-spi@vger.kernel.org, linux-serial@vger.kernel.org, andy.gross@linaro.org, david.brown@linaro.org, georgi.djakov@linaro.org, dianders@chromium.org, swboyd@chromium.org, bjorn.andersson@linaro.org, linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 2019-01-23 01:59, Mark Brown wrote:
> On Tue, Jan 22, 2019 at 12:03:34PM +0530, Alok Chauhan wrote:
> 
>> Get the interconnect paths for SPI based Serial Engine device
>> and vote accordingly based on maximum supported SPI frequency.
> 
> Still not seeing anything except this patch here in my inbox - like I
> said what's the story with dependencies?

I've added linux-spi mailing list to all the patches sent as part of 
this series. Not sure why you didn't get other patches. Today I've 
explicitly added you in all the patches.
This change series basically enabled interconnect (as per 
bindings/interconnect/interconnect.txt) support in GENI QUPs based 
drivers so appropriate BW request can be put based on SE usages.
here is my complete change series: 
https://lore.kernel.org/lkml/1548069703-26595-1-git-send-email-alokc@codeaurora.org/
I hope I answer to your question properly.


-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora 
Forum,a Linux Foundation Collaborative Project
