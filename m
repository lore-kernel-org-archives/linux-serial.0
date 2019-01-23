From: alokc@codeaurora.org
Subject: Re: [PATCH 0/6] Add interconnect support for GENI QUPs
Date: Wed, 23 Jan 2019 12:15:10 +0530
Message-ID: <74b768d6573665fe2a4533a23ad23a9e@codeaurora.org>
References: <1548138816-1149-1-git-send-email-alokc@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1548138816-1149-1-git-send-email-alokc@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, linux-spi@vger.kernel.org, linux-serial@vger.kernel.org, Mark Brown <broonie@kernel.org>
Cc: andy.gross@linaro.org, david.brown@linaro.org, georgi.djakov@linaro.org, dianders@chromium.org, swboyd@chromium.org, bjorn.andersson@linaro.org, linux-arm-msm-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

+Mark Brown

On 2019-01-22 12:03, Alok Chauhan wrote:
> This patch series contains following:
> * Add wrapper framework to support interconnect path from GENI QUPs.
>   This wrapper enabled and help individual SEs to put their BW request.
>   Adding this wrapper make sense because we don't want individual SEs
>   to request to interconnect driver separately and put individual bw
>   votes from QUP.
> 
>   This wrapper framework does the following:
>   - Request for interconnect path handle
>   - Maintain record of individual SEs' avg/peak bw.
>   - Aggregated avg/peak bw based on how many SE's are active and put
>     single bw request from QUP
> 
> * Interconnect wrapper API calling from I2C, SPI & Uart driver
> * dt binding in sdm845 soc for Interconnect path for GENI QUPs
> * dt binding documentation
> 
> 
> Alok Chauhan (6):
>   dt-bindings: soc: qcom: Add interconnect binding for GENI QUP
>   soc: qcom: Add wrapper to support for Interconnect path
>   i2c: i2c-qcom-geni: Add interconnect support
>   spi: spi-geni-qcom: Add interconnect support
>   tty: serial: qcom_geni_serial: Add interconnect support
>   arm64: dts: sdm845: Add interconnect for GENI QUP
> 
>  .../devicetree/bindings/soc/qcom/qcom,geni-se.txt  |  10 ++
>  arch/arm64/boot/dts/qcom/sdm845.dtsi               |  14 +++
>  drivers/i2c/busses/i2c-qcom-geni.c                 |  13 +++
>  drivers/soc/qcom/qcom-geni-se.c                    | 129 
> +++++++++++++++++++++
>  drivers/spi/spi-geni-qcom.c                        |  20 +++-
>  drivers/tty/serial/qcom_geni_serial.c              |  27 ++++-
>  include/linux/qcom-geni-se.h                       |  11 ++
>  7 files changed, 222 insertions(+), 2 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora 
Forum,a Linux Foundation Collaborative Project
