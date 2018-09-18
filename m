From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: Re: [PATCH 2/3] dmaengine: Add Slave and Cyclic mode support for
 Actions Semi Owl S900 SoC
Date: Tue, 18 Sep 2018 15:52:36 -0700
Message-ID: <20180918225236.GA17306@Mani-XPS-13-9360>
References: <20180901164215.3683-1-manivannan.sadhasivam@linaro.org>
 <20180901164215.3683-3-manivannan.sadhasivam@linaro.org>
 <20180918163512.GE2613@vkoul-mobl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180918163512.GE2613@vkoul-mobl>
Sender: linux-kernel-owner@vger.kernel.org
To: Vinod <vkoul@kernel.org>
Cc: dan.j.williams@intel.com, afaerber@suse.de, robh+dt@kernel.org, gregkh@linuxfoundation.org, jslaby@suse.com, linux-serial@vger.kernel.org, dmaengine@vger.kernel.org, liuwei@actions-semi.com, 96boards@ucrobotics.com, devicetree@vger.kernel.org, daniel.thompson@linaro.org, amit.kucheria@linaro.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, hzhang@ucrobotics.com, bdong@ucrobotics.com, manivannanece23@gmail.com, thomas.liau@actions-semi.com, jeff.chen@actions-semi.com, pn@denx.de, edgar.righi@lsitec.org.br
List-Id: linux-serial@vger.kernel.org

On Tue, Sep 18, 2018 at 09:35:12AM -0700, Vinod wrote:
> On 01-09-18, 22:12, Manivannan Sadhasivam wrote:
> 
> > @@ -364,6 +372,26 @@ static inline int owl_dma_cfg_lli(struct owl_dma_vchan *vchan,
> >  			OWL_DMA_MODE_DT_DCU | OWL_DMA_MODE_SAM_INC |
> >  			OWL_DMA_MODE_DAM_INC;
> >  
> > +		break;
> > +	case DMA_MEM_TO_DEV:
> > +		mode |= OWL_DMA_MODE_TS(vchan->drq)
> > +			| OWL_DMA_MODE_ST_DCU | OWL_DMA_MODE_DT_DEV
> > +			| OWL_DMA_MODE_SAM_INC | OWL_DMA_MODE_DAM_CONST;
> > +
> > +		/* Handle bus width for UART */
> > +		if (sconfig->dst_addr_width == DMA_SLAVE_BUSWIDTH_1_BYTE)
> > +			mode |= OWL_DMA_MODE_NDDBW_8BIT;
> 
> this is fine per se, but not correct way to handle in dmaengine driver.
> You should be agnostic to user of dmaengine, so handle all the buswidths
> the IP block supports and update the values accordingly. That way new
> uses can be added w/o requiring change in dmaengine driver
>

Hi Vinod,

Currently, all members of Owl family supports only 32bit and 8bit
bus widths. 32bit is common for all peripherals and 8bit applies to only
UART since the internal buffer is 8bit wide. So, this makes sense to me!

Thanks,
Mani

> -- 
> ~Vinod
