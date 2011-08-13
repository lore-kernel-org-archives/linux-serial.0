From: David Brown <davidb@codeaurora.org>
Subject: Re: [PATCH 2/4] msm_serial: Add devicetree support
Date: Sat, 13 Aug 2011 12:46:45 -0700
Message-ID: <20110813194645.GA23710@huya.qualcomm.com>
References: <1313190008-7551-1-git-send-email-davidb@codeaurora.org>
 <1313190008-7551-3-git-send-email-davidb@codeaurora.org>
 <1434305.ibxmc6q715@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1434305.ibxmc6q715@wuerfel>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, David Brown <davidb@codeaurora.org>, Randy Dunlap <rdunlap@xenotime.net>, Daniel Walker <dwalker@fifo99.com>, Bryan Huntsman <bryanh@codeaurora.org>, Alan Cox <alan@linux.intel.com>, Grant Likely <grant.likely@secretlab.ca>, linux-doc@vger.kernel.org, linux-arm-msm@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Sat, Aug 13, 2011 at 10:29:00AM +0200, Arnd Bergmann wrote:
> On Friday 12 August 2011 16:00:06 David Brown wrote:
> > +Required properties:
> > +- compatible :
> > +       - "qcom,msm-uart"
> > +- reg : offset and length of the register set for the device
> > +       for the hsuart operating in compatible mode, there should be a
> > +       second pair describing the gsbi registers.
> > +- interrupts : should contain the uart interrupt.
> > +
> > +Example:
> > +
> > +       uart@19c400000 {
> > +               compatible = "qcom,msm-hsuart", "qcom,msm-uart";
> > +               reg = <0x19c40000 0x1000">,
> > +                     <0x19c00000 0x1000">;
> > +               interrupts = <195>;
> > +       };
> 
> 
> 
> > @@ -920,11 +928,17 @@ static int __devexit msm_serial_remove(struct platform_device *pdev)
> >         return 0;
> >  }
> >  
> > +static struct of_device_id msm_match_table[] = {
> > +       { .compatible = "qcom,msm-hsuart-lite" },
> > +       {}
> > +};
> > +
> 
> Hi David,
> 
> It looks like you changed the value for the "compatible" property in the
> process of making the patch, but did not update all places.
> 
> Should it be qcom,msm-hsuart-lite or qcom,msm-hsuart?

I guess I got the documentation to be different than the code.
Sadily, I think the documentation is probably what I want instead of
the code.

I'm not sure actually what is best to use here.  I'm thinking that the
'lite' identifier should perhaps go away.  MSM's have two UARTS on
them, an older "simple" PIO type of UART, and a newer one that can do
DMA (called the hsuart for high-speed).  The hsuart can also be used
in a non-DMA driver in a mostly compatible way with the old UART.

For non-high-speed applications, the user will probably just want to
use the non-DMA driver.  My question is then: if the device tree
describes it as

	compatible = "qcom,msm-hsuart", "qcom,msm-uart";

and one driver matches qcom,msm-hsuart and another matches
qcom,msm-uart, which driver will get used.  Ideally, it would use the
earliest one in the list.

If that's the case, I'll get rid of the -lite suffix and just make the
non-DMA driver compatible with the plain "qcom,msm-uart".

David

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
