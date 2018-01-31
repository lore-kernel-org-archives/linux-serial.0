From: Karthik Ramasubramanian <kramasub@codeaurora.org>
Subject: Re: [PATCH v2 0/7] Introduce GENI SE Controller Driver
Date: Wed, 31 Jan 2018 11:59:27 -0700
Message-ID: <53f9f145-71fe-7ce7-e6b2-02485ea94325@codeaurora.org>
References: <1515805547-22816-1-git-send-email-kramasub@codeaurora.org>
 <14fcdf68-e4ee-2182-2c3c-cc446c2c4d25@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <14fcdf68-e4ee-2182-2c3c-cc446c2c4d25@infradead.org>
Content-Language: en-US
Sender: linux-arm-msm-owner@vger.kernel.org
To: Randy Dunlap <rdunlap@infradead.org>, corbet@lwn.net, andy.gross@linaro.org, david.brown@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, wsa@the-dreams.de, gregkh@linuxfoundation.org
Cc: linux-doc@vger.kernel.org, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-i2c@vger.kernel.org, linux-serial@vger.kernel.org, jslaby@suse.com
List-Id: linux-serial@vger.kernel.org



On 1/19/2018 11:32 AM, Randy Dunlap wrote:
> On 01/12/2018 05:05 PM, Karthikeyan Ramasubramanian wrote:
>> Generic Interface (GENI) firmware based Qualcomm Universal Peripheral (QUP)
>> Wrapper is a next generation programmable module for supporting a wide
>> range of serial interfaces like UART, SPI, I2C, I3C, etc. A single QUP
>> module can provide upto 8 Serial Interfaces using its internal Serial
>> Engines (SE). The protocol supported by each interface is determined by
>> the firmware loaded to the Serial Engine.
>>
>> This patch series introduces GENI SE Driver to manage the GENI based QUP
>> Wrapper and the common aspects of all SEs inside the QUP Wrapper. This
>> patch series also introduces the UART and I2C Controller drivers to
>> drive the SEs that are programmed with the respective protocols.
> 
> Hi,
> 
> Will there be follow-up drivers for SPI, I3C, etc.?
Yes.
> 
> Thanks.
> 
>> [v2]
>>   * Updated device tree bindings to describe the hardware
>>   * Updated SE DT node as child node of QUP Wrapper DT node
>>   * Moved common AHB clocks to QUP Wrapper DT node
>>   * Use the standard "clock-frequency" I2C property
>>   * Update compatible field in UART Controller to reflect hardware manual
>>   * Addressed other device tree binding specific comments from Rob Herring
>>
>> Karthikeyan Ramasubramanian (7):
>>    qcom-geni-se: Add QCOM GENI SE Driver summary
>>    dt-bindings: soc: qcom: Add device tree binding for GENI SE
>>    soc: qcom: Add GENI based QUP Wrapper driver
>>    dt-bindings: i2c: Add device tree bindings for GENI I2C Controller
>>    i2c: i2c-qcom-geni: Add bus driver for the Qualcomm GENI I2C
>>      controller
>>    dt-bindings: serial: Add bindings for GENI based UART Controller
>>    tty: serial: msm_geni_serial: Add serial driver support for GENI based
>>      QUP
>>
>>   .../devicetree/bindings/i2c/i2c-qcom-geni.txt      |   35 +
>>   .../devicetree/bindings/serial/qcom,geni-uart.txt  |   29 +
>>   .../devicetree/bindings/soc/qcom/qcom,geni-se.txt  |   66 +
>>   Documentation/qcom-geni-se.txt                     |   56 +
>>   drivers/i2c/busses/Kconfig                         |   10 +
>>   drivers/i2c/busses/Makefile                        |    1 +
>>   drivers/i2c/busses/i2c-qcom-geni.c                 |  656 +++++++++
>>   drivers/soc/qcom/Kconfig                           |    8 +
>>   drivers/soc/qcom/Makefile                          |    1 +
>>   drivers/soc/qcom/qcom-geni-se.c                    | 1016 ++++++++++++++
>>   drivers/tty/serial/Kconfig                         |   10 +
>>   drivers/tty/serial/Makefile                        |    1 +
>>   drivers/tty/serial/qcom_geni_serial.c              | 1414 ++++++++++++++++++++
>>   include/linux/qcom-geni-se.h                       |  807 +++++++++++
>>   14 files changed, 4110 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/i2c/i2c-qcom-geni.txt
>>   create mode 100644 Documentation/devicetree/bindings/serial/qcom,geni-uart.txt
>>   create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.txt
>>   create mode 100644 Documentation/qcom-geni-se.txt
>>   create mode 100644 drivers/i2c/busses/i2c-qcom-geni.c
>>   create mode 100644 drivers/soc/qcom/qcom-geni-se.c
>>   create mode 100644 drivers/tty/serial/qcom_geni_serial.c
>>   create mode 100644 include/linux/qcom-geni-se.h
>>
> 
> 
Regards,
Karthik.
-- 
Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
