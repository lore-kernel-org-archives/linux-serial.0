From: Randy Dunlap <rdunlap-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Subject: Re: [PATCH v2 0/7] Introduce GENI SE Controller Driver
Date: Fri, 19 Jan 2018 10:32:05 -0800
Message-ID: <14fcdf68-e4ee-2182-2c3c-cc446c2c4d25@infradead.org>
References: <1515805547-22816-1-git-send-email-kramasub@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1515805547-22816-1-git-send-email-kramasub-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Karthikeyan Ramasubramanian <kramasub-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, corbet-T1hC0tSOHrs@public.gmane.org, andy.gross-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, david.brown-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org
Cc: linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jslaby-IBi9RG/b67k@public.gmane.org
List-Id: linux-serial@vger.kernel.org

On 01/12/2018 05:05 PM, Karthikeyan Ramasubramanian wrote:
> Generic Interface (GENI) firmware based Qualcomm Universal Peripheral (QUP)
> Wrapper is a next generation programmable module for supporting a wide
> range of serial interfaces like UART, SPI, I2C, I3C, etc. A single QUP
> module can provide upto 8 Serial Interfaces using its internal Serial
> Engines (SE). The protocol supported by each interface is determined by
> the firmware loaded to the Serial Engine.
> 
> This patch series introduces GENI SE Driver to manage the GENI based QUP
> Wrapper and the common aspects of all SEs inside the QUP Wrapper. This
> patch series also introduces the UART and I2C Controller drivers to
> drive the SEs that are programmed with the respective protocols.

Hi,

Will there be follow-up drivers for SPI, I3C, etc.?

Thanks.

> [v2]
>  * Updated device tree bindings to describe the hardware
>  * Updated SE DT node as child node of QUP Wrapper DT node
>  * Moved common AHB clocks to QUP Wrapper DT node
>  * Use the standard "clock-frequency" I2C property
>  * Update compatible field in UART Controller to reflect hardware manual
>  * Addressed other device tree binding specific comments from Rob Herring
> 
> Karthikeyan Ramasubramanian (7):
>   qcom-geni-se: Add QCOM GENI SE Driver summary
>   dt-bindings: soc: qcom: Add device tree binding for GENI SE
>   soc: qcom: Add GENI based QUP Wrapper driver
>   dt-bindings: i2c: Add device tree bindings for GENI I2C Controller
>   i2c: i2c-qcom-geni: Add bus driver for the Qualcomm GENI I2C
>     controller
>   dt-bindings: serial: Add bindings for GENI based UART Controller
>   tty: serial: msm_geni_serial: Add serial driver support for GENI based
>     QUP
> 
>  .../devicetree/bindings/i2c/i2c-qcom-geni.txt      |   35 +
>  .../devicetree/bindings/serial/qcom,geni-uart.txt  |   29 +
>  .../devicetree/bindings/soc/qcom/qcom,geni-se.txt  |   66 +
>  Documentation/qcom-geni-se.txt                     |   56 +
>  drivers/i2c/busses/Kconfig                         |   10 +
>  drivers/i2c/busses/Makefile                        |    1 +
>  drivers/i2c/busses/i2c-qcom-geni.c                 |  656 +++++++++
>  drivers/soc/qcom/Kconfig                           |    8 +
>  drivers/soc/qcom/Makefile                          |    1 +
>  drivers/soc/qcom/qcom-geni-se.c                    | 1016 ++++++++++++++
>  drivers/tty/serial/Kconfig                         |   10 +
>  drivers/tty/serial/Makefile                        |    1 +
>  drivers/tty/serial/qcom_geni_serial.c              | 1414 ++++++++++++++++++++
>  include/linux/qcom-geni-se.h                       |  807 +++++++++++
>  14 files changed, 4110 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/i2c/i2c-qcom-geni.txt
>  create mode 100644 Documentation/devicetree/bindings/serial/qcom,geni-uart.txt
>  create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.txt
>  create mode 100644 Documentation/qcom-geni-se.txt
>  create mode 100644 drivers/i2c/busses/i2c-qcom-geni.c
>  create mode 100644 drivers/soc/qcom/qcom-geni-se.c
>  create mode 100644 drivers/tty/serial/qcom_geni_serial.c
>  create mode 100644 include/linux/qcom-geni-se.h
> 


-- 
~Randy
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
