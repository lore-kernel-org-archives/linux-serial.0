From: Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [PATCH v2 3/7] soc: qcom: Add GENI based QUP Wrapper driver
Date: Mon, 5 Feb 2018 15:50:53 -0800
Message-ID: <20180205235053.GH9465@builder>
References: <1515805547-22816-1-git-send-email-kramasub@codeaurora.org>
 <1515805547-22816-4-git-send-email-kramasub@codeaurora.org>
 <20180117062002.GA6620@minitux>
 <1faee481-8cb6-4dc6-ac0f-eb89445227e1@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1faee481-8cb6-4dc6-ac0f-eb89445227e1@codeaurora.org>
Sender: linux-doc-owner@vger.kernel.org
To: Karthik Ramasubramanian <kramasub@codeaurora.org>
Cc: corbet@lwn.net, andy.gross@linaro.org, david.brown@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, wsa@the-dreams.de, gregkh@linuxfoundation.org, linux-doc@vger.kernel.org, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-i2c@vger.kernel.org, linux-serial@vger.kernel.org, jslaby@suse.com, Sagar Dharia <sdharia@codeaurora.org>, Girish Mahadevan <girishm@codeaurora.org>
List-Id: linux-serial@vger.kernel.org

On Wed 31 Jan 10:58 PST 2018, Karthik Ramasubramanian wrote:
> On 1/16/2018 11:20 PM, Bjorn Andersson wrote:
> > On Fri 12 Jan 17:05 PST 2018, Karthikeyan Ramasubramanian wrote:
[..]
> > I'm not aware of any non-serial-engine "geni" at Qualcomm, so can we
> > drop the "se" throughout this driver?
> Currently GENI is used to program just the serial engines. But it is not
> restricted to that. It can be used to program other hardware cores. Hence
> keeping "se" will help to clarify that this driver is meant for GENI based
> serial engines only.

Okay, fair enough.

[..]
> > > diff --git a/drivers/soc/qcom/qcom-geni-se.c b/drivers/soc/qcom/qcom-geni-se.c
[..]
> > > +	geni_cgc_ctrl = geni_read_reg(base, GENI_CGC_CTRL);
> > > +	dma_general_cfg = geni_read_reg(base, SE_DMA_GENERAL_CFG);
> > > +	geni_cgc_ctrl |= DEFAULT_CGC_EN;
> > > +	dma_general_cfg |= (AHB_SEC_SLV_CLK_CGC_ON | DMA_AHB_SLV_CFG_ON |
> > > +			DMA_TX_CLK_CGC_ON | DMA_RX_CLK_CGC_ON);
> > 
> > Drop the parenthesis and there's no harm in making multiple assignments
> > in favour of splitting the line.
> Ok.
> > 
> > > +	io_op_ctrl = DEFAULT_IO_OUTPUT_CTRL_MSK;
> > > +	geni_write_reg(geni_cgc_ctrl, base, GENI_CGC_CTRL);
> > > +	geni_write_reg(dma_general_cfg, base, SE_DMA_GENERAL_CFG);
> > 
> > Is there a reason why this chunk of code is a mix of 3 independent
> > register updates?
> I am not sure I understand the context of your question. This is how the
> hardware programming manual is describing to program the registers as part
> of initializing a serial engine. Please let me know if this is not the
> information you are looking for.

Can you please double check with the hardware guys if it really is
required that you do:

a = read(A)
b = read(B)

modify a
modify b
assign c

write(a)
write(b)
write(c)

And if that is the case, then try to make things as easy to read as
possible - e.g. by inlining the value of "c" and adding an empty line
between reads, modifications and writes as I did here.

Regards,
Bjorn
