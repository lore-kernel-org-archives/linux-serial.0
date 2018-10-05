From: Vinod <vkoul@kernel.org>
Subject: Re: [PATCH v2 2/3] dmaengine: Add Slave and Cyclic mode support for
 Actions Semi Owl S900 SoC
Date: Fri, 5 Oct 2018 20:31:41 +0530
Message-ID: <20181005150141.GN2372@vkoul-mobl>
References: <20180929074637.9766-1-manivannan.sadhasivam@linaro.org>
 <20180929074637.9766-3-manivannan.sadhasivam@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180929074637.9766-3-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: dan.j.williams@intel.com, afaerber@suse.de, robh+dt@kernel.org, gregkh@linuxfoundation.org, jslaby@suse.com, linux-serial@vger.kernel.org, dmaengine@vger.kernel.org, liuwei@actions-semi.com, 96boards@ucrobotics.com, devicetree@vger.kernel.org, daniel.thompson@linaro.org, amit.kucheria@linaro.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, hzhang@ucrobotics.com, bdong@ucrobotics.com, manivannanece23@gmail.com, thomas.liau@actions-semi.com, jeff.chen@actions-semi.com, pn@denx.de, edgar.righi@lsitec.org.br
List-Id: linux-serial@vger.kernel.org

On 29-09-18, 13:16, Manivannan Sadhasivam wrote:
> Add Slave and Cyclic mode support for Actions Semi Owl S900 SoC. The slave
> mode supports bus width of 4 bytes common for all peripherals and 1 byte
> specific for UART.
> 
> The cyclic mode supports only block mode transfer.

Applied after adding driver tag, thanks
-- 
~Vinod
