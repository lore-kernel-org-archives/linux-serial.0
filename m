From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 2/4] msm_serial: Add devicetree support
Date: Sat, 13 Aug 2011 23:34:15 +0200
Message-ID: <65679699.l4XXDScc0T@wuerfel>
References: <1313190008-7551-1-git-send-email-davidb@codeaurora.org> <1434305.ibxmc6q715@wuerfel> <20110813194645.GA23710@huya.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:58781 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752295Ab1HMVep (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 13 Aug 2011 17:34:45 -0400
In-Reply-To: <20110813194645.GA23710@huya.qualcomm.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: David Brown <davidb@codeaurora.org>
Cc: linux-arm-kernel@lists.infradead.org, Randy Dunlap <rdunlap@xenotime.net>, Daniel Walker <dwalker@fifo99.com>, Bryan Huntsman <bryanh@codeaurora.org>, Alan Cox <alan@linux.intel.com>, Grant Likely <grant.likely@secretlab.ca>, linux-doc@vger.kernel.org, linux-arm-msm@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org

On Saturday 13 August 2011 12:46:45 David Brown wrote:
> 
> I'm not sure actually what is best to use here.  I'm thinking that the
> 'lite' identifier should perhaps go away.  MSM's have two UARTS on
> them, an older "simple" PIO type of UART, and a newer one that can do
> DMA (called the hsuart for high-speed).  The hsuart can also be used
> in a non-DMA driver in a mostly compatible way with the old UART.
> 
> For non-high-speed applications, the user will probably just want to
> use the non-DMA driver.  My question is then: if the device tree
> describes it as
> 
>         compatible = "qcom,msm-hsuart", "qcom,msm-uart";
> 
> and one driver matches qcom,msm-hsuart and another matches
> qcom,msm-uart, which driver will get used.  Ideally, it would use the
> earliest one in the list.
> 
> If that's the case, I'll get rid of the -lite suffix and just make the
> non-DMA driver compatible with the plain "qcom,msm-uart".

I believe that unfortunately the answer is that the first driver that
matches anything will get used. There are two possible ways that I can
see to make it do what you want anyway:

1. In the probe function for the slow driver, you return an error
when the device you get passed matches "qcom,msm-hsuart", possibly
dependent on whether the other driver also got built.

2. You register one platform driver that handles both names and
gives the device to just one of the two drivers. This would probably
require linking the two drivers into the same module, or having
the non-DMA speed driver just act as a library.

	Arnd
