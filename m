From: Karthik Ramasubramanian <kramasub@codeaurora.org>
Subject: Re: [PATCH v2 3/7] soc: qcom: Add GENI based QUP Wrapper driver
Date: Wed, 31 Jan 2018 11:58:29 -0700
Message-ID: <1faee481-8cb6-4dc6-ac0f-eb89445227e1@codeaurora.org>
References: <1515805547-22816-1-git-send-email-kramasub@codeaurora.org>
 <1515805547-22816-4-git-send-email-kramasub@codeaurora.org>
 <20180117062002.GA6620@minitux>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <20180117062002.GA6620@minitux>
Content-Language: en-US
Sender: linux-arm-msm-owner@vger.kernel.org
To: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: corbet@lwn.net, andy.gross@linaro.org, david.brown@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, wsa@the-dreams.de, gregkh@linuxfoundation.org, linux-doc@vger.kernel.org, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-i2c@vger.kernel.org, linux-serial@vger.kernel.org, jslaby@suse.com, Sagar Dharia <sdharia@codeaurora.org>, Girish Mahadevan <girishm@codeaurora.org>
List-Id: linux-serial@vger.kernel.org



On 1/16/2018 11:20 PM, Bjorn Andersson wrote:
> On Fri 12 Jan 17:05 PST 2018, Karthikeyan Ramasubramanian wrote:
> 
>> This driver manages the Generic Interface (GENI) firmware based Qualcomm
>> Universal Peripheral (QUP) Wrapper. GENI based QUP is the next generation
>> programmable module composed of multiple Serial Engines (SE) and supports
>> a wide range of serial interfaces like UART, SPI, I2C, I3C, etc. This
>> driver also enables managing the serial interface independent aspects of
>> Serial Engines.
>>
>> Signed-off-by: Karthikeyan Ramasubramanian <kramasub@codeaurora.org>
>> Signed-off-by: Sagar Dharia <sdharia@codeaurora.org>
>> Signed-off-by: Girish Mahadevan <girishm@codeaurora.org>
>> ---
>>   drivers/soc/qcom/Kconfig        |    8 +
>>   drivers/soc/qcom/Makefile       |    1 +
>>   drivers/soc/qcom/qcom-geni-se.c | 1016 +++++++++++++++++++++++++++++++++++++++
> 
> I'm not aware of any non-serial-engine "geni" at Qualcomm, so can we
> drop the "se" throughout this driver?
Currently GENI is used to program just the serial engines. But it is not 
restricted to that. It can be used to program other hardware cores. 
Hence keeping "se" will help to clarify that this driver is meant for 
GENI based serial engines only.
> 
>>   include/linux/qcom-geni-se.h    |  807 +++++++++++++++++++++++++++++++
>>   4 files changed, 1832 insertions(+)
>>   create mode 100644 drivers/soc/qcom/qcom-geni-se.c
>>   create mode 100644 include/linux/qcom-geni-se.h
>>
>> diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
>> index b81374b..b306d51 100644
>> --- a/drivers/soc/qcom/Kconfig
>> +++ b/drivers/soc/qcom/Kconfig
>> @@ -3,6 +3,14 @@
>>   #
>>   menu "Qualcomm SoC drivers"
>>   
>> +config QCOM_GENI_SE
>> +	tristate "QCOM GENI Serial Engine Driver"
> 
> Options in drivers/soc/qcom/Kconfig should have "depends on ARCH_QCOM",
> as the makefile in this directory won't be processed when !ARCH_QCOM.
I will update the config to depend on ARCH_QCOM.
> 
>> +	help
>> +	  This module is used to manage Generic Interface (GENI) firmware based
>> +	  Qualcomm Technologies, Inc. Universal Peripheral (QUP) Wrapper. This
>> +	  module is also used to manage the common aspects of multiple Serial
>> +	  Engines present in the QUP.
>> +
>>   config QCOM_GLINK_SSR
>>   	tristate "Qualcomm Glink SSR driver"
>>   	depends on RPMSG
>> diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
>> index 40c56f6..74d5db8 100644
>> --- a/drivers/soc/qcom/Makefile
>> +++ b/drivers/soc/qcom/Makefile
>> @@ -1,4 +1,5 @@
>>   # SPDX-License-Identifier: GPL-2.0
>> +obj-$(CONFIG_QCOM_GENI_SE) +=	qcom-geni-se.o
>>   obj-$(CONFIG_QCOM_GLINK_SSR) +=	glink_ssr.o
>>   obj-$(CONFIG_QCOM_GSBI)	+=	qcom_gsbi.o
>>   obj-$(CONFIG_QCOM_MDT_LOADER)	+= mdt_loader.o
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
>   * Copyright (c) 2017-2018, The Linux Foundation. All rights reserved.
>   */
> 
>> +
>> +#include <linux/clk.h>
>> +#include <linux/slab.h>
>> +#include <linux/dma-mapping.h>
>> +#include <linux/io.h>
>> +#include <linux/list.h>
> 
> This isn't used.
> 
>> +#include <linux/module.h>
>> +#include <linux/of.h>
>> +#include <linux/of_platform.h>
>> +#include <linux/pm_runtime.h>
> 
> Is this used?
> 
>> +#include <linux/qcom-geni-se.h>
>> +#include <linux/spinlock.h>
> 
> Is this used?
I will remove including unused header files.
> 
>> +
>> +#define MAX_CLK_PERF_LEVEL 32
>> +
>> +/**
>> + * @struct geni_se_device - Data structure to represent the QUP Wrapper Core
> 
> Make this name indicate that this is the wrapper; e.g. struct geni_wrapper
geni_wrapper makes sense.
> 
>> + * @dev:		Device pointer of the QUP wrapper core.
>> + * @base:		Base address of this instance of QUP wrapper core.
>> + * @m_ahb_clk:		Handle to the primary AHB clock.
>> + * @s_ahb_clk:		Handle to the secondary AHB clock.
>> + * @geni_dev_lock:	Lock to protect the device elements.
>> + * @num_clk_levels:	Number of valid clock levels in clk_perf_tbl.
>> + * @clk_perf_tbl:	Table of clock frequency input to Serial Engine clock.
>> + */
>> +struct geni_se_device {
>> +	struct device *dev;
>> +	void __iomem *base;
>> +	struct clk *m_ahb_clk;
>> +	struct clk *s_ahb_clk;
> 
> As these two clocks always seems to be operated in tandem use
> clk_bulk_data to keep track of them and use the clk_bulk*() operations
> to simplify your prepare/unprepare sites.
I will use the clk_bulk* approach.
> 
>> +	struct mutex geni_dev_lock;
> 
> There's only one lock and it should be obvious from context that it's
> the lock of the geni_se_device, so naming this "lock" should be
> sufficient.
I will rename it to "lock".
> 
>> +	unsigned int num_clk_levels;
>> +	unsigned long *clk_perf_tbl;
>> +};
>> +
>> +/* Offset of QUP Hardware Version Register */
>> +#define QUP_HW_VER (0x4)
> 
> Drop the parenthesis. It would be nice if this define indicated that
> this is a register and not a value. E.g. call it QUP_HW_VER_REG.
Ok.
> 
>> +
>> +#define HW_VER_MAJOR_MASK GENMASK(31, 28)
>> +#define HW_VER_MAJOR_SHFT 28
>> +#define HW_VER_MINOR_MASK GENMASK(27, 16)
>> +#define HW_VER_MINOR_SHFT 16
>> +#define HW_VER_STEP_MASK GENMASK(15, 0)
>> +
>> +/**
>> + * geni_read_reg_nolog() - Helper function to read from a GENI register
>> + * @base:	Base address of the serial engine's register block.
>> + * @offset:	Offset within the serial engine's register block.
>> + *
>> + * Return:	Return the contents of the register.
>> + */
>> +unsigned int geni_read_reg_nolog(void __iomem *base, int offset)
> 
> Remove this function.
Ok.
> 
>> +{
>> +	return readl_relaxed(base + offset);
>> +}
>> +EXPORT_SYMBOL(geni_read_reg_nolog);
>> +
>> +/**
>> + * geni_write_reg_nolog() - Helper function to write into a GENI register
>> + * @value:	Value to be written into the register.
>> + * @base:	Base address of the serial engine's register block.
>> + * @offset:	Offset within the serial engine's register block.
>> + */
>> +void geni_write_reg_nolog(unsigned int value, void __iomem *base, int offset)
> 
> Ditto
Ok.
> 
>> +{
>> +	return writel_relaxed(value, (base + offset));
>> +}
>> +EXPORT_SYMBOL(geni_write_reg_nolog);
>> +
>> +/**
>> + * geni_read_reg() - Helper function to read from a GENI register
>> + * @base:	Base address of the serial engine's register block.
>> + * @offset:	Offset within the serial engine's register block.
>> + *
>> + * Return:	Return the contents of the register.
> 
> Drop the extra spaces after "Return:" in all your kerneldoc.
Ok.
> 
>> + */
>> +unsigned int geni_read_reg(void __iomem *base, int offset)
>> +{
>> +	return readl_relaxed(base + offset);
>> +}
>> +EXPORT_SYMBOL(geni_read_reg);
>> +
>> +/**
>> + * geni_write_reg() - Helper function to write into a GENI register
>> + * @value:	Value to be written into the register.
>> + * @base:	Base address of the serial engine's register block.
>> + * @offset:	Offset within the serial engine's register block.
>> + */
>> +void geni_write_reg(unsigned int value, void __iomem *base, int offset)
>> +{
>> +	return writel_relaxed(value, (base + offset));
> 
> As written, this function adds no value and I find it quite confusing
> that this is used both for read/writes on the wrapper as well as the
> individual functions.Ok.
> 
> Compare:
> 
> 	geni_write_reg(common_geni_m_irq_en, base, SE_GENI_M_IRQ_EN);
> 
> with just inlining:
> 
> 	writel(common_geni_m_irq_en, base + SE_GENI_M_IRQ_EN);
> 
>> +}
>> +EXPORT_SYMBOL(geni_write_reg);
>> +
>> +/**
>> + * geni_get_qup_hw_version() - Read the QUP wrapper Hardware version
>> + * @wrapper_dev:	Pointer to the corresponding QUP wrapper core.
>> + * @major:		Buffer for Major Version field.
>> + * @minor:		Buffer for Minor Version field.
>> + * @step:		Buffer for Step Version field.
>> + *
>> + * Return:	0 on success, standard Linux error codes on failure/error.
>> + */
>> +int geni_get_qup_hw_version(struct device *wrapper_dev, unsigned int *major,
>> +			    unsigned int *minor, unsigned int *step)
>> +{
>> +	unsigned int version;
>> +	struct geni_se_device *geni_se_dev;
>> +
>> +	if (!wrapper_dev || !major || !minor || !step)
>> +		return -EINVAL;
> 
> This would only happen during development, as the engineer calls the
> function incorrectly. Consider it a contract that these has to be valid
> and skip the checks.
Ok.
> 
>> +
>> +	geni_se_dev = dev_get_drvdata(wrapper_dev);
>> +	if (unlikely(!geni_se_dev))
>> +		return -ENODEV;
> 
> Make the children acquire the geni_se_dev handle (keep the type opaque)
> and pass that instead of wrapper_dev. Then you can just drop this chunk.
Ok.
> 
>> +
>> +	version = geni_read_reg(geni_se_dev->base, QUP_HW_VER);
>> +	*major = (version & HW_VER_MAJOR_MASK) >> HW_VER_MAJOR_SHFT;
>> +	*minor = (version & HW_VER_MINOR_MASK) >> HW_VER_MINOR_SHFT;
>> +	*step = version & HW_VER_STEP_MASK;
>> +	return 0;
> 
> If you implement these two changes there's no way this function can
> fail, so you don't have to return a value here.
Ok.
> 
>> +}
>> +EXPORT_SYMBOL(geni_get_qup_hw_version);
>> +
>> +/**
>> + * geni_se_get_proto() - Read the protocol configured for a serial engine
>> + * @base:	Base address of the serial engine's register block.
>> + *
>> + * Return:	Protocol value as configured in the serial engine.
>> + */
>> +int geni_se_get_proto(void __iomem *base)
> 
> I keep reading this as "geni set get proto", you should be fine just
> dropping _se_ from these function names. And if you want to denote that
> it's the Qualcomm GENI then make it qcom_geni_*.
"_se" prefix is used to help differentiate operations on a serial engine 
from those on the wrapper. I can rename it as geni_se_read_proto to 
avoid the confusion.
> 
> But more importantly, it is not obvious when reading this driver that
> the typeless "base" being passed is that of the individual functional
> block, and not the wrapper.
> 
> If you want to do this in an "object oriented" fashion create a struct
> that's common for all geni instances, include it in the context of the
> individual function devices and pass it into these functions.
There is a structure named geni_se_rsc to group resources associated 
with a serial engine. I can rename it to geni_serial_engine and include 
the opaque "base" address in that structure. That structure can be 
passed as an input parameter to all the serial engine operations.
> 
>> +{
>> +	int proto;
>> +
>> +	proto = ((geni_read_reg(base, GENI_FW_REVISION_RO)
>> +			& FW_REV_PROTOCOL_MSK) >> FW_REV_PROTOCOL_SHFT);
> 
> Don't do everything in one go, as you can't fit it on one line anyways.
> Writing it like this instead makes it easier to read:
> 
> 	u32 val;
> 
> 	val = readl(base + GENI_FW_S_REVISION_RO);
> 
> 	return (val & FW_REV_PROTOCOL_MSK) >> FW_REV_PROTOCOL_SHFT;
Ok.
> 
>> +	return proto;
>> +}
>> +EXPORT_SYMBOL(geni_se_get_proto);
>> +
>> +static int geni_se_irq_en(void __iomem *base)
>> +{
>> +	unsigned int common_geni_m_irq_en;
>> +	unsigned int common_geni_s_irq_en;
> 
> The size of these values isn't unsigned int, it's u32. And if you give
> them a shorter name the function becomes easier to read.
> 
> Further more, as you don't care about ordering you don't need two of
> them either. So you should be able to just do:
> 
> 	u32 val;
> 
> 	val = readl(base + SE_GENI_M_IRQ_EN);
> 	val |= M_COMMON_GENI_M_IRQ_EN;
> 	writel(val, base + SE_GENI_M_IRQ_EN);
> 
> 	val = readl(base + SE_GENI_S_IRQ_EN);
> 	val |= S_COMMON_GENI_S_IRQ_EN;
> 	writel(val, base + SE_GENI_S_IRQ_EN);
Ok.
> 
>> +
>> +	common_geni_m_irq_en = geni_read_reg(base, SE_GENI_M_IRQ_EN);
>> +	common_geni_s_irq_en = geni_read_reg(base, SE_GENI_S_IRQ_EN);
>> +	/* Common to all modes */
>> +	common_geni_m_irq_en |= M_COMMON_GENI_M_IRQ_EN;
>> +	common_geni_s_irq_en |= S_COMMON_GENI_S_IRQ_EN;
>> +
>> +	geni_write_reg(common_geni_m_irq_en, base, SE_GENI_M_IRQ_EN);
>> +	geni_write_reg(common_geni_s_irq_en, base, SE_GENI_S_IRQ_EN);
>> +	return 0;
> 
> And as this can't fail there's no reason to have a return value.
Ok.
> 
>> +}
>> +
>> +
>> +static void geni_se_set_rx_rfr_wm(void __iomem *base, unsigned int rx_wm,
>> +				  unsigned int rx_rfr)
>> +{
>> +	geni_write_reg(rx_wm, base, SE_GENI_RX_WATERMARK_REG);
>> +	geni_write_reg(rx_rfr, base, SE_GENI_RX_RFR_WATERMARK_REG);
>> +}
>> +
>> +static int geni_se_io_set_mode(void __iomem *base)
>> +{
>> +	unsigned int io_mode;
>> +	unsigned int geni_dma_mode;
>> +
>> +	io_mode = geni_read_reg(base, SE_IRQ_EN);
>> +	geni_dma_mode = geni_read_reg(base, SE_GENI_DMA_MODE_EN);
>> +
>> +	io_mode |= (GENI_M_IRQ_EN | GENI_S_IRQ_EN);
>> +	io_mode |= (DMA_TX_IRQ_EN | DMA_RX_IRQ_EN);
>> +	geni_dma_mode &= ~GENI_DMA_MODE_EN;
>> +
>> +	geni_write_reg(io_mode, base, SE_IRQ_EN);
>> +	geni_write_reg(geni_dma_mode, base, SE_GENI_DMA_MODE_EN);
>> +	geni_write_reg(0, base, SE_GSI_EVENT_EN);
>> +	return 0;
> 
> As this function can't fail, don't return a value.
Ok.
> 
>> +}
>> +
>> +static void geni_se_io_init(void __iomem *base)
>> +{
>> +	unsigned int io_op_ctrl;
>> +	unsigned int geni_cgc_ctrl;
>> +	unsigned int dma_general_cfg;
> 
> These are all u32, be explicit.
Ok.
> 
>> +
>> +	geni_cgc_ctrl = geni_read_reg(base, GENI_CGC_CTRL);
>> +	dma_general_cfg = geni_read_reg(base, SE_DMA_GENERAL_CFG);
>> +	geni_cgc_ctrl |= DEFAULT_CGC_EN;
>> +	dma_general_cfg |= (AHB_SEC_SLV_CLK_CGC_ON | DMA_AHB_SLV_CFG_ON |
>> +			DMA_TX_CLK_CGC_ON | DMA_RX_CLK_CGC_ON);
> 
> Drop the parenthesis and there's no harm in making multiple assignments
> in favour of splitting the line.
Ok.
> 
>> +	io_op_ctrl = DEFAULT_IO_OUTPUT_CTRL_MSK;
>> +	geni_write_reg(geni_cgc_ctrl, base, GENI_CGC_CTRL);
>> +	geni_write_reg(dma_general_cfg, base, SE_DMA_GENERAL_CFG);
> 
> Is there a reason why this chunk of code is a mix of 3 independent
> register updates?
I am not sure I understand the context of your question. This is how the 
hardware programming manual is describing to program the registers as 
part of initializing a serial engine. Please let me know if this is not 
the information you are looking for.
> 
>> +
>> +	geni_write_reg(io_op_ctrl, base, GENI_OUTPUT_CTRL);
>> +	geni_write_reg(FORCE_DEFAULT, base, GENI_FORCE_DEFAULT_REG);
>> +}
>> +
>> +/**
>> + * geni_se_init() - Initialize the GENI Serial Engine
>> + * @base:	Base address of the serial engine's register block.
>> + * @rx_wm:	Receive watermark to be configured.
>> + * @rx_rfr_wm:	Ready-for-receive watermark to be configured.
> 
> What's the unit for these?
The unit is the number of hardware FIFO words.
> 
>> + *
>> + * This function is used to initialize the GENI serial engine, configure
>> + * receive watermark and ready-for-receive watermarks.
>> + *
>> + * Return:	0 on success, standard Linux error codes on failure/error.
> 
> As neither geni_se_io_set_mode() nor geni_se_irq_en() can fail there's
> no way geni_se_init() can fail and as such you don't need a return value
> of this function.
Ok.
> 
>> + */
>> +int geni_se_init(void __iomem *base, unsigned int rx_wm, unsigned int rx_rfr)
>> +{
>> +	int ret;
>> +
>> +	geni_se_io_init(base);
>> +	ret = geni_se_io_set_mode(base);
>> +	if (ret)
>> +		return ret;
>> +
>> +	geni_se_set_rx_rfr_wm(base, rx_wm, rx_rfr);
>> +	ret = geni_se_irq_en(base);
> 
> Just inline these two functions here.
> 
>> +	return ret;
>> +}
>> +EXPORT_SYMBOL(geni_se_init);
> 
> This is an excellent candidate for initializing a common "geni
> function"-struct shared among the children, i.e. make this:
> 
> void geni_init_port(struct geni_port *port, struct device *dev,
> 		    size_t rx_wm, rfr_wm);
> 
> And have this do the ioremap of the memory of dev and initialize some
> common "geni_port" struct, then you can pass this to some set of
> geni_port_*() helper functions.
Sure, this sounds like a good place to do ioremap of children and 
initialize common serial engine resources.
> 
>> +
>> +static int geni_se_select_fifo_mode(void __iomem *base)
>> +{
>> +	int proto = geni_se_get_proto(base);
>> +	unsigned int common_geni_m_irq_en;
>> +	unsigned int common_geni_s_irq_en;
>> +	unsigned int geni_dma_mode;
> 
> These are of type u32.
> 
> If you use more succinct names the function will be easier to read; what
> about master, slave and mode? (Or m_en, s_en and mode)
Ok.
> 
>> +
>> +	geni_write_reg(0, base, SE_GSI_EVENT_EN);
>> +	geni_write_reg(0xFFFFFFFF, base, SE_GENI_M_IRQ_CLEAR);
>> +	geni_write_reg(0xFFFFFFFF, base, SE_GENI_S_IRQ_CLEAR);
>> +	geni_write_reg(0xFFFFFFFF, base, SE_DMA_TX_IRQ_CLR);
>> +	geni_write_reg(0xFFFFFFFF, base, SE_DMA_RX_IRQ_CLR);
>> +	geni_write_reg(0xFFFFFFFF, base, SE_IRQ_EN);
> 
> Use lowercase for the hex constants.
Ok.
> 
>> +
>> +	common_geni_m_irq_en = geni_read_reg(base, SE_GENI_M_IRQ_EN);
>> +	common_geni_s_irq_en = geni_read_reg(base, SE_GENI_S_IRQ_EN);
>> +	geni_dma_mode = geni_read_reg(base, SE_GENI_DMA_MODE_EN);
>> +	if (proto != UART) {
>> +		common_geni_m_irq_en |=
>> +			(M_CMD_DONE_EN | M_TX_FIFO_WATERMARK_EN |
>> +			M_RX_FIFO_WATERMARK_EN | M_RX_FIFO_LAST_EN);
> 
> Drop the parenthesis, split the assignment in multiple to make things
> not span 3 lines.
Ok.
> 
>> +		common_geni_s_irq_en |= S_CMD_DONE_EN;
>> +	}
>> +	geni_dma_mode &= ~GENI_DMA_MODE_EN;
> 
> Please group things that are related.
> 
> The compiler doesn't care if you stretch the life time of your local
> variables through your functions, but the brain does.
Ok.
> 
>> +
>> +	geni_write_reg(common_geni_m_irq_en, base, SE_GENI_M_IRQ_EN);
>> +	geni_write_reg(common_geni_s_irq_en, base, SE_GENI_S_IRQ_EN);
>> +	geni_write_reg(geni_dma_mode, base, SE_GENI_DMA_MODE_EN);
>> +	return 0;
> 
> This can't fail, and you ignore the returned value in
> geni_se_select_mode().
Ok.
> 
>> +}
>> +
>> +static int geni_se_select_dma_mode(void __iomem *base)
>> +{
>> +	unsigned int geni_dma_mode = 0;
> 
> This is u32, can be shorten to "mode" and it's first use is an
> assignment - so you don't have to initialize it here.
Ok.
> 
>> +
>> +	geni_write_reg(0, base, SE_GSI_EVENT_EN);
>> +	geni_write_reg(0xFFFFFFFF, base, SE_GENI_M_IRQ_CLEAR);
>> +	geni_write_reg(0xFFFFFFFF, base, SE_GENI_S_IRQ_CLEAR);
>> +	geni_write_reg(0xFFFFFFFF, base, SE_DMA_TX_IRQ_CLR);
>> +	geni_write_reg(0xFFFFFFFF, base, SE_DMA_RX_IRQ_CLR);
>> +	geni_write_reg(0xFFFFFFFF, base, SE_IRQ_EN);
> 
> Please lower case your hex constants.
Ok.
> 
>> +
>> +	geni_dma_mode = geni_read_reg(base, SE_GENI_DMA_MODE_EN);
>> +	geni_dma_mode |= GENI_DMA_MODE_EN;
>> +	geni_write_reg(geni_dma_mode, base, SE_GENI_DMA_MODE_EN);
>> +	return 0;
> 
> Can't fail.
Ok.
> 
>> +}
>> +
>> +/**
>> + * geni_se_select_mode() - Select the serial engine transfer mode
>> + * @base:	Base address of the serial engine's register block.
>> + * @mode:	Transfer mode to be selected.
>> + *
>> + * Return:	0 on success, standard Linux error codes on failure.
>> + */
>> +int geni_se_select_mode(void __iomem *base, int mode)
>> +{
>> +	int ret = 0;
> 
> Drop the return value and "ret", if you want to help the developer of
> child devices you can start off by a WARN_ON(mode != FIFO_MODE && mode
> != SE_DMA);
Ok.
> 
>> +
>> +	switch (mode) {
>> +	case FIFO_MODE:
>> +		geni_se_select_fifo_mode(base);
>> +		break;
>> +	case SE_DMA:
>> +		geni_se_select_dma_mode(base);
>> +		break;
>> +	default:
>> +		ret = -EINVAL;
>> +		break;
>> +	}
>> +
>> +	return ret;
>> +}
>> +EXPORT_SYMBOL(geni_se_select_mode);
>> +
>> +/**
>> + * geni_se_setup_m_cmd() - Setup the primary sequencer
>> + * @base:	Base address of the serial engine's register block.
>> + * @cmd:	Command/Operation to setup in the primary sequencer.
>> + * @params:	Parameter for the sequencer command.
>> + *
>> + * This function is used to configure the primary sequencer with the
>> + * command and its assoicated parameters.
>> + */
>> +void geni_se_setup_m_cmd(void __iomem *base, u32 cmd, u32 params)
>> +{
>> +	u32 m_cmd = (cmd << M_OPCODE_SHFT);
>> +
>> +	m_cmd |= (params & M_PARAMS_MSK);
> 
> Rather than initializing the variable during declaration and then
> amending the value it's cleaner if you do:
> 
> 	val = (cmd << M_OPCODE_SHFT) | (params & M_PARAMS_MSK);
Ok.
> 
>> +	geni_write_reg(m_cmd, base, SE_GENI_M_CMD0);
>> +}
>> +EXPORT_SYMBOL(geni_se_setup_m_cmd);
>> +
> [..]
>> +/**
>> + * geni_se_get_tx_fifo_depth() - Get the TX fifo depth of the serial engine
>> + * @base:	Base address of the serial engine's register block.
>> + *
>> + * This function is used to get the depth i.e. number of elements in the
>> + * TX fifo of the serial engine.
>> + *
>> + * Return:	TX fifo depth in units of FIFO words.
>> + */
>> +int geni_se_get_tx_fifo_depth(void __iomem *base)
>> +{
>> +	int tx_fifo_depth;
>> +
>> +	tx_fifo_depth = ((geni_read_reg(base, SE_HW_PARAM_0)
>> +			& TX_FIFO_DEPTH_MSK) >> TX_FIFO_DEPTH_SHFT);
> 
> It easier to read this way:
> 
> 	u32 val;
> 
> 	val = readl(base, SE_HW_PARAM_0);
> 
> 	return (val & TX_FIFO_DEPTH_MSK) >> TX_FIFO_DEPTH_SHFT;
Ok.
> 
>> +	return tx_fifo_depth;
>> +}
>> +EXPORT_SYMBOL(geni_se_get_tx_fifo_depth);
>> +
>> +/**
>> + * geni_se_get_tx_fifo_width() - Get the TX fifo width of the serial engine
>> + * @base:	Base address of the serial engine's register block.
>> + *
>> + * This function is used to get the width i.e. word size per element in the
>> + * TX fifo of the serial engine.
>> + *
>> + * Return:	TX fifo width in bits
>> + */
>> +int geni_se_get_tx_fifo_width(void __iomem *base)
>> +{
>> +	int tx_fifo_width;
>> +
>> +	tx_fifo_width = ((geni_read_reg(base, SE_HW_PARAM_0)
>> +			& TX_FIFO_WIDTH_MSK) >> TX_FIFO_WIDTH_SHFT);
>> +	return tx_fifo_width;
> 
> Ditto.
Ok.
> 
>> +}
>> +EXPORT_SYMBOL(geni_se_get_tx_fifo_width);
>> +
>> +/**
>> + * geni_se_get_rx_fifo_depth() - Get the RX fifo depth of the serial engine
>> + * @base:	Base address of the serial engine's register block.
>> + *
>> + * This function is used to get the depth i.e. number of elements in the
>> + * RX fifo of the serial engine.
>> + *
>> + * Return:	RX fifo depth in units of FIFO words
>> + */
>> +int geni_se_get_rx_fifo_depth(void __iomem *base)
>> +{
>> +	int rx_fifo_depth;
>> +
>> +	rx_fifo_depth = ((geni_read_reg(base, SE_HW_PARAM_1)
>> +			& RX_FIFO_DEPTH_MSK) >> RX_FIFO_DEPTH_SHFT);
>> +	return rx_fifo_depth;
> 
> Ditto.
Ok.
> 
>> +}
>> +EXPORT_SYMBOL(geni_se_get_rx_fifo_depth);
>> +
>> +/**
>> + * geni_se_get_packing_config() - Get the packing configuration based on input
>> + * @bpw:	Bits of data per transfer word.
>> + * @pack_words:	Number of words per fifo element.
>> + * @msb_to_lsb:	Transfer from MSB to LSB or vice-versa.
>> + * @cfg0:	Output buffer to hold the first half of configuration.
>> + * @cfg1:	Output buffer to hold the second half of configuration.
>> + *
>> + * This function is used to calculate the packing configuration based on
>> + * the input packing requirement and the configuration logic.
>> + */
>> +void geni_se_get_packing_config(int bpw, int pack_words, bool msb_to_lsb,
>> +				unsigned long *cfg0, unsigned long *cfg1)
> 
> This function is used only from geni_se_config_packing() which writes
> the new config to the associated registers and from the serial driver
> that does the same - but here pack_words differ for rx and tx.
> 
> If you improve geni_se_config_packing() to take rx and tx fifo sizes
> independently you don't have to expose this function to the client
> drivers and you don't need to return cfg0 and cfg1 like you do here.
Ok.
> 
>> +{
>> +	u32 cfg[4] = {0};
>> +	int len;
>> +	int temp_bpw = bpw;
>> +	int idx_start = (msb_to_lsb ? (bpw - 1) : 0);
>> +	int idx = idx_start;
>> +	int idx_delta = (msb_to_lsb ? -BITS_PER_BYTE : BITS_PER_BYTE);
>> +	int ceil_bpw = ((bpw & (BITS_PER_BYTE - 1)) ?
>> +			((bpw & ~(BITS_PER_BYTE - 1)) + BITS_PER_BYTE) : bpw);
>> +	int iter = (ceil_bpw * pack_words) >> 3;
>> +	int i;
>> +
>> +	if (unlikely(iter <= 0 || iter > 4)) {
> 
> Don't use unlikely(), this function is not called one per port, there's
> no need to clutter the code to "optimize" it.
> 
>> +		*cfg0 = 0;
>> +		*cfg1 = 0;
>> +		return;
>> +	}
>> +
>> +	for (i = 0; i < iter; i++) {
>> +		len = (temp_bpw < BITS_PER_BYTE) ?
>> +				(temp_bpw - 1) : BITS_PER_BYTE - 1;
>> +		cfg[i] = ((idx << 5) | (msb_to_lsb << 4) | (len << 1));
>> +		idx = ((temp_bpw - BITS_PER_BYTE) <= 0) ?
>> +				((i + 1) * BITS_PER_BYTE) + idx_start :
>> +				idx + idx_delta;
>> +		temp_bpw = ((temp_bpw - BITS_PER_BYTE) <= 0) ?
>> +				bpw : (temp_bpw - BITS_PER_BYTE);
> 
> Each operation in this loop depend on temp_bpw being smaller or larger
> than BITS_PER_BYTE, please rewrite it with a single if/else based on
> this.
> 
>> +	}
>> +	cfg[iter - 1] |= 1;
> 
> The 1 you're writing here looks like an "EOF". It would be nice with a
> comment describing the format of these 4 registers and the meaning of
> BIT(0).
> 
>> +	*cfg0 = cfg[0] | (cfg[1] << 10);
>> +	*cfg1 = cfg[2] | (cfg[3] << 10);
>> +}
>> +EXPORT_SYMBOL(geni_se_get_packing_config);
>> +
>> +/**
>> + * geni_se_config_packing() - Packing configuration of the serial engine
>> + * @base:	Base address of the serial engine's register block.
>> + * @bpw:	Bits of data per transfer word.
>> + * @pack_words:	Number of words per fifo element.
>> + * @msb_to_lsb:	Transfer from MSB to LSB or vice-versa.
>> + *
>> + * This function is used to configure the packing rules for the current
>> + * transfer.
>> + */
>> +void geni_se_config_packing(void __iomem *base, int bpw,
>> +			    int pack_words, bool msb_to_lsb)
>> +{
>> +	unsigned long cfg0, cfg1;
> 
> These are u32.
Ok.
> 
>> +
>> +	geni_se_get_packing_config(bpw, pack_words, msb_to_lsb, &cfg0, &cfg1);
>> +	geni_write_reg(cfg0, base, SE_GENI_TX_PACKING_CFG0);
>> +	geni_write_reg(cfg1, base, SE_GENI_TX_PACKING_CFG1);
>> +	geni_write_reg(cfg0, base, SE_GENI_RX_PACKING_CFG0);
>> +	geni_write_reg(cfg1, base, SE_GENI_RX_PACKING_CFG1);
>> +	if (pack_words || bpw == 32)
>> +		geni_write_reg((bpw >> 4), base, SE_GENI_BYTE_GRAN);
>> +}
>> +EXPORT_SYMBOL(geni_se_config_packing);
>> +
>> +static void geni_se_clks_off(struct geni_se_rsc *rsc)
>> +{
>> +	struct geni_se_device *geni_se_dev;
>> +
>> +	if (unlikely(!rsc || !rsc->wrapper_dev))
> 
> Drop the unlikely(). Why would you be passed a rsc with wrapper_dev
> NULL?
Used it just to handle any development time issues. I will remove the 
unlikely().
> 
>> +		return;
>> +
>> +	geni_se_dev = dev_get_drvdata(rsc->wrapper_dev);
>> +	if (unlikely(!geni_se_dev))
>> +		return;
>> +
>> +	clk_disable_unprepare(rsc->se_clk);
>> +	clk_disable_unprepare(geni_se_dev->s_ahb_clk);
>> +	clk_disable_unprepare(geni_se_dev->m_ahb_clk);
>> +}
>> +
>> +/**
>> + * geni_se_resources_off() - Turn off resources associated with the serial
>> + *                           engine
>> + * @rsc:	Handle to resources associated with the serial engine.
>> + *
>> + * Return:	0 on success, standard Linux error codes on failure/error.
>> + */
>> +int geni_se_resources_off(struct geni_se_rsc *rsc)
>> +{
>> +	int ret = 0;
> 
> No need to initialize ret.
Ok.
> 
>> +	struct geni_se_device *geni_se_dev;
>> +
>> +	if (unlikely(!rsc || !rsc->wrapper_dev))
>> +		return -EINVAL;
>> +
>> +	geni_se_dev = dev_get_drvdata(rsc->wrapper_dev);
>> +	if (unlikely(!geni_se_dev))
> 
> 
> Only child devices would call this, so it's unlikely that this is a
> probe defer.
> 
> Also the returned value is not used.
> 
> And drop the unlikely()
Ok.
> 
>> +		return -ENODEV;
>> +
>> +	ret = pinctrl_select_state(rsc->geni_pinctrl, rsc->geni_gpio_sleep);
>> +	if (ret)
>> +		return ret;
>> +
>> +	geni_se_clks_off(rsc);
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL(geni_se_resources_off);
>> +
>> +static int geni_se_clks_on(struct geni_se_rsc *rsc)
>> +{
>> +	int ret;
>> +	struct geni_se_device *geni_se_dev;
> 
> If you name this "geni" instead, or "wrapper" the rest will be cleaner.
Ok.
> 
>> +
>> +	if (unlikely(!rsc || !rsc->wrapper_dev))
>> +		return -EINVAL;
>> +
>> +	geni_se_dev = dev_get_drvdata(rsc->wrapper_dev);
>> +	if (unlikely(!geni_se_dev))
>> +		return -EPROBE_DEFER;
>> +
>> +	ret = clk_prepare_enable(geni_se_dev->m_ahb_clk);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = clk_prepare_enable(geni_se_dev->s_ahb_clk);
>> +	if (ret) {
>> +		clk_disable_unprepare(geni_se_dev->m_ahb_clk);
>> +		return ret;
>> +	}
> 
> These two could be dealt with in a single clk_bulk_prepare_enable().
Ok.
> 
>> +
>> +	ret = clk_prepare_enable(rsc->se_clk);
>> +	if (ret) {
>> +		clk_disable_unprepare(geni_se_dev->s_ahb_clk);
>> +		clk_disable_unprepare(geni_se_dev->m_ahb_clk);
>> +	}
>> +	return ret;
>> +}
>> +
>> +/**
>> + * geni_se_resources_on() - Turn on resources associated with the serial
>> + *                          engine
>> + * @rsc:	Handle to resources associated with the serial engine.
>> + *
>> + * Return:	0 on success, standard Linux error codes on failure/error.
>> + */
>> +int geni_se_resources_on(struct geni_se_rsc *rsc)
>> +{
>> +	int ret = 0;
>> +	struct geni_se_device *geni_se_dev;
>> +
>> +	if (unlikely(!rsc || !rsc->wrapper_dev))
>> +		return -EINVAL;
>> +
>> +	geni_se_dev = dev_get_drvdata(rsc->wrapper_dev);
>> +	if (unlikely(!geni_se_dev))
> 
> As with geni_se_resources_off()
Ok.
> 
>> +		return -EPROBE_DEFER;
>> +
>> +	ret = geni_se_clks_on(rsc);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = pinctrl_select_state(rsc->geni_pinctrl, rsc->geni_gpio_active);
> 
> pinctrl_pm_select_default_state(rsc->dev);
> 
> So you need the dev associated with the rsc.
> 
>> +	if (ret)
>> +		geni_se_clks_off(rsc);
>> +
>> +	return ret;
>> +}
>> +EXPORT_SYMBOL(geni_se_resources_on);
>> +
>> +/**
>> + * geni_se_clk_tbl_get() - Get the clock table to program DFS
>> + * @rsc:	Resource for which the clock table is requested.
>> + * @tbl:	Table in which the output is returned.
>> + *
>> + * This function is called by the protocol drivers to determine the different
>> + * clock frequencies supported by Serail Engine Core Clock. The protocol
> 
> s/Serail/Serial/
Ok.
> 
>> + * drivers use the output to determine the clock frequency index to be
>> + * programmed into DFS.
>> + *
>> + * Return:	number of valid performance levels in the table on success,
>> + *		standard Linux error codes on failure.
>> + */
>> +int geni_se_clk_tbl_get(struct geni_se_rsc *rsc, unsigned long **tbl)
>> +{
>> +	struct geni_se_device *geni_se_dev;
>> +	int i;
>> +	unsigned long prev_freq = 0;
>> +	int ret = 0;
>> +
>> +	if (unlikely(!rsc || !rsc->wrapper_dev || !rsc->se_clk || !tbl))
> 
> Drop the "unlikely", you're only calling this once.
Ok.
> 
>> +		return -EINVAL;
>> +
>> +	*tbl = NULL;
> 
> Don't touch tbl on error.
Ok.
> 
>> +	geni_se_dev = dev_get_drvdata(rsc->wrapper_dev);
>> +	if (unlikely(!geni_se_dev))
>> +		return -EPROBE_DEFER;
> 
> How would this even be possible? This function should only be called by
> child devices, which per definition means that this device been probed.
I agree. Prior to this patchset, the serial engine nodes were not 
children nodes of wrapper devices. Hence the check existed. Now that the 
device tree nodes are re-structured, this check can be removed.
> 
>> +
>> +	mutex_lock(&geni_se_dev->geni_dev_lock);
>> +	if (geni_se_dev->clk_perf_tbl) {
>> +		*tbl = geni_se_dev->clk_perf_tbl;
>> +		ret = geni_se_dev->num_clk_levels;
>> +		goto exit_se_clk_tbl_get;
>> +	}
> 
> You're never freeing clk_perf_tbl, and the only reason you have
> geni_dev_lock is to protect the "cached" array in geni_se_dev.
> 
> Move the allocation and generation of clk_perf_tbl to geni_se_probe()
> and store the value, then make this function just return that array.
> That way you can drop the lock and the code becomes cleaner.
Currently this driver is initializing in arch_init. It can be moved to 
module_init stage as long as the clk_round_rate() returns -EPROBE_DEFER 
when it is not ready. I will look into it and do the appropriate change.
> 
>> +
>> +	geni_se_dev->clk_perf_tbl = kzalloc(sizeof(*geni_se_dev->clk_perf_tbl) *
>> +						MAX_CLK_PERF_LEVEL, GFP_KERNEL);
> 
> Use kcalloc()
Ok.
> 
>> +	if (!geni_se_dev->clk_perf_tbl) {
>> +		ret = -ENOMEM;
>> +		goto exit_se_clk_tbl_get;
>> +	}
>> +
>> +	for (i = 0; i < MAX_CLK_PERF_LEVEL; i++) {
>> +		geni_se_dev->clk_perf_tbl[i] = clk_round_rate(rsc->se_clk,
>> +								prev_freq + 1);
>> +		if (geni_se_dev->clk_perf_tbl[i] == prev_freq) {
>> +			geni_se_dev->clk_perf_tbl[i] = 0;
> 
> Use a local variable to keep the return value of clk_round_rate(), that
> way you don't have to revert the value here (not that it matters...) and
> you don't need to line wrap the assignment above.
Ok.
> 
>> +			break;
>> +		}
>> +		prev_freq = geni_se_dev->clk_perf_tbl[i];
> 
> ...and then you don't need a separate local variable to keep track of
> the last value...
Ok.
> 
>> +	}
>> +	geni_se_dev->num_clk_levels = i;
>> +	*tbl = geni_se_dev->clk_perf_tbl;
>> +	ret = geni_se_dev->num_clk_levels;
>> +exit_se_clk_tbl_get:
> 
> Name your labels based on what action they perform, e.g. "out_unlock"
> (not err_unlock here because it's the successful path as well)
Ok.
> 
>> +	mutex_unlock(&geni_se_dev->geni_dev_lock);
>> +	return ret;
>> +}
>> +EXPORT_SYMBOL(geni_se_clk_tbl_get);
>> +
>> +/**
>> + * geni_se_clk_freq_match() - Get the matching or closest SE clock frequency
>> + * @rsc:	Resource for which the clock frequency is requested.
>> + * @req_freq:	Requested clock frequency.
>> + * @index:	Index of the resultant frequency in the table.
>> + * @res_freq:	Resultant frequency which matches or is closer to the
>> + *		requested frequency.
>> + * @exact:	Flag to indicate exact multiple requirement of the requested
>> + *		frequency .
>> + *
>> + * This function is called by the protocol drivers to determine the matching
>> + * or closest frequency of the Serial Engine clock to be selected in order
>> + * to meet the performance requirements.
> 
> What's the benefit compared to calling clk_round_rate()?
> 
> Given that the function can return a rate that is a fraction of the
> requested frequency even though "exact" is set, this description isn't
> explaining the entire picture.
I agree, the description makes it look like clk_round_rate(). But it is 
different from clk_round_rate() in the sense that it will try to return 
the matching or exact multiple of the requested frequency. If there is 
no matching or exact multiple value found, then it returns the closest 
floor frequency available. I will update the description accordingly.
> 
>> + *
>> + * Return:	0 on success, standard Linux error codes on failure.
> 
> Returning the new clockrate would make more sense.
> 
>> + */
>> +int geni_se_clk_freq_match(struct geni_se_rsc *rsc, unsigned long req_freq,
>> +			   unsigned int *index, unsigned long *res_freq,
>> +			   bool exact)
>> +{
>> +	unsigned long *tbl;
>> +	int num_clk_levels;
>> +	int i;
>> +
>> +	num_clk_levels = geni_se_clk_tbl_get(rsc, &tbl);
>> +	if (num_clk_levels < 0)
>> +		return num_clk_levels;
>> +
>> +	if (num_clk_levels == 0)
>> +		return -EFAULT;
>> +
>> +	*res_freq = 0;
>> +	for (i = 0; i < num_clk_levels; i++) {
>> +		if (!(tbl[i] % req_freq)) {
>> +			*index = i;
>> +			*res_freq = tbl[i];
> 
> So this will return a frequency that divides the requested frequency
> without a remainder, will index be used to calculate a multiplier from
> this?
The serial interface drivers need to program the hardware register with 
the index of the clock rate from the clock controller source. Hence the 
index is returned.
> 
>> +			return 0;
>> +		}
>> +
>> +		if (!(*res_freq) || ((tbl[i] > *res_freq) &&
>> +				     (tbl[i] < req_freq))) {
>> +			*index = i;
>> +			*res_freq = tbl[i];
> 
> What if there's a previous value in tbl that given some multiplier has a
> smaller difference to the requested frequency?
At this point the requirement is to return matching or exact multiple of 
the requested frequency. If those criteria are not met, return the 
closest floor frequency.
> 
>> +		}
>> +	}
>> +
>> +	if (exact || !(*res_freq))
> 
> *res_freq can't be 0, because in the case that num_clk_levels is 0 you
> already returned -EFAULT above, in all other cases you will assign it at
> least once.
Ok.
> 
>> +		return -ENOKEY;
>> +
>> +	return 0;
> 
> Why not use the return value for the calculated frequency?
With frequency being unsigned long, I dont see a clean way to return any 
error.
> 
>> +}
>> +EXPORT_SYMBOL(geni_se_clk_freq_match);
>> +
>> +/**
>> + * geni_se_tx_dma_prep() - Prepare the Serial Engine for TX DMA transfer
>> + * @wrapper_dev:	QUP Wrapper Device to which the TX buffer is mapped.
>> + * @base:		Base address of the SE register block.
>> + * @tx_buf:		Pointer to the TX buffer.
>> + * @tx_len:		Length of the TX buffer.
>> + * @tx_dma:		Pointer to store the mapped DMA address.
>> + *
>> + * This function is used to prepare the buffers for DMA TX.
>> + *
>> + * Return:	0 on success, standard Linux error codes on error/failure.
>> + */
>> +int geni_se_tx_dma_prep(struct device *wrapper_dev, void __iomem *base,
>> +			void *tx_buf, int tx_len, dma_addr_t *tx_dma)
> 
> All child devices will have a "base", so if you move that into what you
> today call a geni_se_rsc and you pass that to all these functions
> operating on behalf of the child device you have the first two
> parameters passed in the same object.
> 
> A "tx_len" is typically of type size_t.
> 
> Also note that there are no other buf than tx_buf, no other len than
> tx_len and no other dma address than tx_dma in this function, so you can
> drop "tx_" without loosing any information - but improving code
> cleanliness.
Ok.
> 
>> +{
>> +	int ret;
>> +
>> +	if (unlikely(!wrapper_dev || !base || !tx_buf || !tx_len || !tx_dma))
>> +		return -EINVAL;
> 
> Reduce the error checking here.
Ok.
> 
>> +
>> +	ret = geni_se_map_buf(wrapper_dev, tx_dma, tx_buf, tx_len,
>> +				    DMA_TO_DEVICE);
> 
> I think you should pass the wrapper itself to geni_se_tx_dma_prep() and
> if you name this "wrapper" (instead of wrapper_dev) you're under 80
> chars and don't need the line break.
Ok.
> 
>> +	if (ret)
>> +		return ret;
>> +
>> +	geni_write_reg(7, base, SE_DMA_TX_IRQ_EN_SET);
> 
> So that's DMA_RX_IRQ_EN | DMA_TX_IRQ_EN | GENI_M_IRQ_EN?
No, that is DMA_DONE_EN (BIT 0), EOT_EN (BIT 1) and AHB_ERR_EN (BIT 2).
> 
>> +	geni_write_reg((u32)(*tx_dma), base, SE_DMA_TX_PTR_L);
>> +	geni_write_reg((u32)((*tx_dma) >> 32), base, SE_DMA_TX_PTR_H);
> 
> If you return the dma_addr_t from this function you will have the happy
> side effect of being able to use tx_dma directly instead of *tx_dma and
> you can remove some craziness from these calls.
> 
> 
> 
>> +	geni_write_reg(1, base, SE_DMA_TX_ATTR);
> 
> This "1" would be nice to have some clarification on.
This indicates to the hardware that the current buffer is of 
End-of-Transfer Type. I will add a comment here or replace the magic 1 
with an appropriate preprocessor macro.
> 
>> +	geni_write_reg(tx_len, base, SE_DMA_TX_LEN);
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL(geni_se_tx_dma_prep);
>> +
>> +/**
>> + * geni_se_rx_dma_prep() - Prepare the Serial Engine for RX DMA transfer
>> + * @wrapper_dev:	QUP Wrapper Device to which the RX buffer is mapped.
>> + * @base:		Base address of the SE register block.
>> + * @rx_buf:		Pointer to the RX buffer.
>> + * @rx_len:		Length of the RX buffer.
>> + * @rx_dma:		Pointer to store the mapped DMA address.
>> + *
>> + * This function is used to prepare the buffers for DMA RX.
>> + *
>> + * Return:	0 on success, standard Linux error codes on error/failure.
> 
> The only real error that can come out of this is dma_mapping_error(), so
> just return the dma_addr_t.
Ok.
> 
>> + */
>> +int geni_se_rx_dma_prep(struct device *wrapper_dev, void __iomem *base,
>> +			void *rx_buf, int rx_len, dma_addr_t *rx_dma)
> 
> As with tx, drop all the "rx_". And pass that geni_se_rsc object
> instead.
Ok.
> 
>> +{
>> +	int ret;
>> +
>> +	if (unlikely(!wrapper_dev || !base || !rx_buf || !rx_len || !rx_dma))
>> +		return -EINVAL;
>> +
>> +	ret = geni_se_map_buf(wrapper_dev, rx_dma, rx_buf, rx_len,
>> +				    DMA_FROM_DEVICE);
>> +	if (ret)
>> +		return ret;
>> +
>> +	geni_write_reg(7, base, SE_DMA_RX_IRQ_EN_SET);
> 
> We enable same interrupts for rx as tx? Why enable TX interrupt here?
No, the interrupts enabled are DMA_DONE_EN, EOT_EN and AHB_ERR_EN.
> 
>> +	geni_write_reg((u32)(*rx_dma), base, SE_DMA_RX_PTR_L);
>> +	geni_write_reg((u32)((*rx_dma) >> 32), base, SE_DMA_RX_PTR_H);
>> +	/* RX does not have EOT bit */
> 
> Okay? How does this relate to the 0 being written into RX_ATTR?
Instead of EOT bit, this register has RX DMA mode bits. Writing 0 means 
the buffer is a single buffer. Writing 1 means the data is present as 
part of the command itself and 2 means the buffer is scatter-gather buffer.
> 
>> +	geni_write_reg(0, base, SE_DMA_RX_ATTR);
>> +	geni_write_reg(rx_len, base, SE_DMA_RX_LEN);
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL(geni_se_rx_dma_prep);
>> +
>> +/**
>> + * geni_se_tx_dma_unprep() - Unprepare the Serial Engine after TX DMA transfer
>> + * @wrapper_dev:	QUP Wrapper Device to which the RX buffer is mapped.
>> + * @tx_dma:		DMA address of the TX buffer.
>> + * @tx_len:		Length of the TX buffer.
>> + *
>> + * This function is used to unprepare the DMA buffers after DMA TX.
>> + */
>> +void geni_se_tx_dma_unprep(struct device *wrapper_dev,
>> +			   dma_addr_t tx_dma, int tx_len)
>> +{
>> +	if (tx_dma)
>> +		geni_se_unmap_buf(wrapper_dev, &tx_dma, tx_len,
>> +						DMA_TO_DEVICE);
>> +}
>> +EXPORT_SYMBOL(geni_se_tx_dma_unprep);
>> +
>> +/**
>> + * geni_se_rx_dma_unprep() - Unprepare the Serial Engine after RX DMA transfer
>> + * @wrapper_dev:	QUP Wrapper Device to which the RX buffer is mapped.
>> + * @rx_dma:		DMA address of the RX buffer.
>> + * @rx_len:		Length of the RX buffer.
>> + *
>> + * This function is used to unprepare the DMA buffers after DMA RX.
>> + */
>> +void geni_se_rx_dma_unprep(struct device *wrapper_dev,
>> +			   dma_addr_t rx_dma, int rx_len)
>> +{
>> +	if (rx_dma)
>> +		geni_se_unmap_buf(wrapper_dev, &rx_dma, rx_len,
>> +						DMA_FROM_DEVICE);
>> +}
>> +EXPORT_SYMBOL(geni_se_rx_dma_unprep);
>> +
>> +/**
>> + * geni_se_map_buf() - Map a single buffer into QUP wrapper device
> 
> I find the mixture of prepare and map in the API (where prepare also
> maps) confusing, but no-one calls genbi_se_map_buf() can it be made
> internal?
Sure it can be made internal and later exposed when the serial interface 
drivers need it.
> 
>> + * @wrapper_dev:	Pointer to the corresponding QUP wrapper core.
>> + * @iova:		Pointer in which the mapped virtual address is stored.
>> + * @buf:		Address of the buffer that needs to be mapped.
>> + * @size:		Size of the buffer.
>> + * @dir:		Direction of the DMA transfer.
>> + *
>> + * This function is used to map an already allocated buffer into the
>> + * QUP device space.
>> + *
>> + * Return:	0 on success, standard Linux error codes on failure/error.
>> + */
>> +int geni_se_map_buf(struct device *wrapper_dev, dma_addr_t *iova,
>> +		    void *buf, size_t size, enum dma_data_direction dir)
>> +{
>> +	struct device *dev_p;
>> +	struct geni_se_device *geni_se_dev;
>> +
>> +	if (!wrapper_dev || !iova || !buf || !size)
>> +		return -EINVAL;
> 
> No need to check that the programmer of the intermediate function
> checked that the programmer of the client filled all these out
> correctly.
Ok.
> 
>> +
>> +	geni_se_dev = dev_get_drvdata(wrapper_dev);
>> +	if (!geni_se_dev || !geni_se_dev->dev)
>> +		return -ENODEV;
> 
> Pass the geni_se_device from the child driver, to remove the need for
> this.
Ok.
> 
>> +
>> +	dev_p = geni_se_dev->dev;
> 
> Name your variables more succinct and you don't need this local alias.
Ok.
> 
>> +
>> +	*iova = dma_map_single(dev_p, buf, size, dir);
> 
> Just inline dma_map_single() in the functions calling this.
Ok.
> 
>> +	if (dma_mapping_error(dev_p, *iova))
>> +		return -EIO;
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL(geni_se_map_buf);
>> +
>> +/**
>> + * geni_se_unmap_buf() - Unmap a single buffer from QUP wrapper device
>> + * @wrapper_dev:	Pointer to the corresponding QUP wrapper core.
>> + * @iova:		Pointer in which the mapped virtual address is stored.
>> + * @size:		Size of the buffer.
>> + * @dir:		Direction of the DMA transfer.
>> + *
>> + * This function is used to unmap an already mapped buffer from the
>> + * QUP device space.
>> + *
>> + * Return:	0 on success, standard Linux error codes on failure/error.
>> + */
>> +int geni_se_unmap_buf(struct device *wrapper_dev, dma_addr_t *iova,
>> +		      size_t size, enum dma_data_direction dir)
> 
> There's no reason for iova to be a pointer. Just pass the dma_addr_t as
> is.
Ok.
> 
> Should this function really be exposed to the clients?
It can be made internal based on the current use-case.
> 
>> +{
>> +	struct device *dev_p;
>> +	struct geni_se_device *geni_se_dev;
>> +
>> +	if (!wrapper_dev || !iova || !size)
>> +		return -EINVAL;
> 
> Reduce the error checking.
Ok.
> 
>> +
>> +	geni_se_dev = dev_get_drvdata(wrapper_dev);
>> +	if (!geni_se_dev || !geni_se_dev->dev)
>> +		return -ENODEV;
> 
> And pass the geni_se_rsc to this function for symmetry purposes, which
> would give you the wrapper by just following the pointer and then the
> device from there.
Ok.
> 
>> +
>> +	dev_p = geni_se_dev->dev;
>> +	dma_unmap_single(dev_p, *iova, size, dir);
> 
> Just inline dma_unmap_single() in the calling functions.
Ok.
> 
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL(geni_se_unmap_buf);
>> +
>> +static const struct of_device_id geni_se_dt_match[] = {
>> +	{ .compatible = "qcom,geni-se-qup", },
>> +	{}
>> +};
> 
> Move this next to the geni_se_driver below and don't forget the
> MODULE_DEVICE_TABLE()
Ok.
> 
>> +
>> +static int geni_se_probe(struct platform_device *pdev)
>> +{
>> +	struct device *dev = &pdev->dev;
>> +	struct resource *res;
>> +	struct geni_se_device *geni_se_dev;
> 
> Just name this "geni".
Ok.
> 
>> +	int ret = 0;
> 
> No need to initialize ret, it's only ever used after assignment.
Ok.
> 
>> +
>> +	geni_se_dev = devm_kzalloc(dev, sizeof(*geni_se_dev), GFP_KERNEL);
>> +	if (!geni_se_dev)
>> +		return -ENOMEM;
>> +
>> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +	if (!res) {
>> +		dev_err(dev, "%s: Mandatory resource info not found\n",
>> +			__func__);
>> +		devm_kfree(dev, geni_se_dev);
>> +		return -EINVAL;
>> +	}
> 
> It's idiomatic to not check for errors of platform_get_resource() as
> devm_ioremap_resource() will fail gracefully if this happens.
Ok, I will remove the check and use the error returned by 
devm_ioremap_resource, if any.
> 
>> +
>> +	geni_se_dev->base = devm_ioremap_resource(dev, res);
>> +	if (IS_ERR_OR_NULL(geni_se_dev->base)) {
> 
> This should be IS_ERR() only.
Ok.
> 
>> +		dev_err(dev, "%s: Error mapping the resource\n", __func__);
>> +		devm_kfree(dev, geni_se_dev);
>> +		return -EFAULT;
>> +	}
>> +
>> +	geni_se_dev->m_ahb_clk = devm_clk_get(dev, "m-ahb");
>> +	if (IS_ERR(geni_se_dev->m_ahb_clk)) {
>> +		ret = PTR_ERR(geni_se_dev->m_ahb_clk);
>> +		dev_err(dev, "Err getting M AHB clk %d\n", ret);
>> +		devm_iounmap(dev, geni_se_dev->base);
>> +		devm_kfree(dev, geni_se_dev);
> 
> The reason we use the devm_ versions of these is so that we don't have
> to release our resources explicitly.
Ok, I will remove releasing the resources explicitly.
> 
>> +		return ret;
>> +	}
>> +
>> +	geni_se_dev->s_ahb_clk = devm_clk_get(dev, "s-ahb");
>> +	if (IS_ERR(geni_se_dev->s_ahb_clk)) {
>> +		ret = PTR_ERR(geni_se_dev->s_ahb_clk);
>> +		dev_err(dev, "Err getting S AHB clk %d\n", ret);
>> +		devm_clk_put(dev, geni_se_dev->m_ahb_clk);
>> +		devm_iounmap(dev, geni_se_dev->base);
>> +		devm_kfree(dev, geni_se_dev);
>> +		return ret;
>> +	}
> 
> Use devm_clk_bulk_get().
Ok.
> 
>> +
>> +	geni_se_dev->dev = dev;
>> +	mutex_init(&geni_se_dev->geni_dev_lock);
>> +	dev_set_drvdata(dev, geni_se_dev);
>> +	dev_dbg(dev, "GENI SE Driver probed\n");
>> +	return of_platform_populate(pdev->dev.of_node, NULL, NULL, &pdev->dev);
> 
> You're not depopulating these devices when the wrapper goes away. Use
> devm_of_platform_populate() here instead to make that happen.
Ok.
> 
>> +}
>> +
>> +static int geni_se_remove(struct platform_device *pdev)
>> +{
>> +	struct device *dev = &pdev->dev;
>> +	struct geni_se_device *geni_se_dev = dev_get_drvdata(dev);
>> +
>> +	devm_clk_put(dev, geni_se_dev->s_ahb_clk);
>> +	devm_clk_put(dev, geni_se_dev->m_ahb_clk);
>> +	devm_iounmap(dev, geni_se_dev->base);
>> +	devm_kfree(dev, geni_se_dev);
> 
> Again, the reason to use devm_* is so that you don't have to free
> things...so if this is what you have here you don't even need a remove
> function.
Ok.
> 
>> +	return 0;
>> +}
>> +
>> +static struct platform_driver geni_se_driver = {
>> +	.driver = {
>> +		.name = "geni_se_qup",
>> +		.of_match_table = geni_se_dt_match,
>> +	},
>> +	.probe = geni_se_probe,
>> +	.remove = geni_se_remove,
>> +};
>> +
>> +static int __init geni_se_driver_init(void)
>> +{
>> +	return platform_driver_register(&geni_se_driver);
>> +}
>> +arch_initcall(geni_se_driver_init);
>> +
>> +static void __exit geni_se_driver_exit(void)
>> +{
>> +	platform_driver_unregister(&geni_se_driver);
>> +}
>> +module_exit(geni_se_driver_exit);
> 
> Should be fine to just use module_platform_driver(), you need separate
> support for earlycon regardless.
Ok.
> 
>> +
>> +MODULE_DESCRIPTION("GENI Serial Engine Driver");
>> +MODULE_LICENSE("GPL v2");
>> diff --git a/include/linux/qcom-geni-se.h b/include/linux/qcom-geni-se.h
>> new file mode 100644
>> index 0000000..5695da9
>> --- /dev/null
>> +++ b/include/linux/qcom-geni-se.h
>> @@ -0,0 +1,807 @@
>> +/*
>> + * Copyright (c) 2017-2018, The Linux Foundation. All rights reserved.
> [..]
>> + */
>> +
> 
> Use SPDX header as above.
Ok.
> 
>> +#ifndef _LINUX_QCOM_GENI_SE
>> +#define _LINUX_QCOM_GENI_SE
>> +#include <linux/clk.h>
>> +#include <linux/dma-direction.h>
>> +#include <linux/io.h>
>> +#include <linux/list.h>
> 
> I don't think there's a need for io.h or list.h here.
Ok.
> 
>> +
>> +/* Transfer mode supported by GENI Serial Engines */
>> +enum geni_se_xfer_mode {
>> +	INVALID,
>> +	FIFO_MODE,
>> +	SE_DMA,
> 
> These are quite bad names for things in a header file.
I am not sure if you are suggesting me to use a prefix to make these 
definitions look GENI specific. I would prefer some clarification in 
this regard.
> 
>> +};
>> +
>> +/* Protocols supported by GENI Serial Engines */
>> +enum geni_se_protocol_types {
>> +	NONE,
>> +	SPI,
>> +	UART,
>> +	I2C,
>> +	I3C
> 
> Ditto
> 
>> +};
>> +
>> +/**
>> + * struct geni_se_rsc - GENI Serial Engine Resource
>> + * @wrapper_dev:	Pointer to the parent QUP Wrapper core.
>> + * @se_clk:		Handle to the core serial engine clock.
>> + * @geni_pinctrl:	Handle to the pinctrl configuration.
>> + * @geni_gpio_active:	Handle to the default/active pinctrl state.
>> + * @geni_gpi_sleep:	Handle to the sleep pinctrl state.
>> + */
>> +struct geni_se_rsc {
> 
> This looks like the common geni_port or geni_device I requested above.
Yes that is right. I will use it to include the serial engine base address.
> 
>> +	struct device *wrapper_dev;
>> +	struct clk *se_clk;
> 
> The one and only clock can be named "clk".
Ok.
> 
>> +	struct pinctrl *geni_pinctrl;
>> +	struct pinctrl_state *geni_gpio_active;
>> +	struct pinctrl_state *geni_gpio_sleep;
> 
> The associated struct device already has init, default, idle and sleep
> pinctrl states associated through the device->pins struct. Typically
> this means that if you provide a "default" and "sleep" state, the
> default will be selected when the device probes.
> 
> In order to select between the states call
> pinctrl_pm_select_{default,sleep,idle}_state(dev);
Ok.
> 
>> +};
>> +
>> +#define PINCTRL_DEFAULT	"default"
>> +#define PINCTRL_SLEEP	"sleep"
>> +
>> +/* Common SE registers */
> 
> The purpose of the helper functions in the wrapper driver is to hide
> the common details from the individual function drivers, so move these
> defines into the c-file as they shouldn't be needed in the individual
> drivers.
I will move the register definitions that are accessed through helper 
functions inside the source file. I may have to keep those register 
definitions that are common and are directly accessed by the serial 
interface drivers here so that there are no duplicate definitions.
> 
>> +#define GENI_INIT_CFG_REVISION		(0x0)
> 
> Drop the parenthesis.
Ok.
> 
> [..]
>> +#ifdef CONFIG_QCOM_GENI_SE
>> +/**
>> + * geni_read_reg_nolog() - Helper function to read from a GENI register
>> + * @base:	Base address of the serial engine's register block.
>> + * @offset:	Offset within the serial engine's register block.
>> + *
>> + * Return:	Return the contents of the register.
>> + */
> 
> The kerneldoc goes in the implementation, not the header file. And you
> already have a copy there, so remove it from here.
Ok.
> 
>> +unsigned int geni_read_reg_nolog(void __iomem *base, int offset);
> [..]
>> +#else
> 
> I see no point in providing dummy functions for these, just make the
> individual drivers either depend or select the core helpers.
Ok.
> 
>> +static inline unsigned int geni_read_reg_nolog(void __iomem *base, int offset)
>> +{
>> +	return 0;
>> +}
> 
> Regards,
> Bjorn
> 
Regards,
Karthik.
-- 
Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
