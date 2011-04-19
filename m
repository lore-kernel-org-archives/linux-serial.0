From: viresh kumar <viresh.kumar@st.com>
Subject: Re: [PATCH] dmaengine: implement pause and resume for dw_dmac
Date: Tue, 19 Apr 2011 11:34:23 +0530
Message-ID: <4DAD25E7.4030602@st.com>
References: <1303173092-21785-1-git-send-email-linus.walleij@linaro.org> <4DAD1DA5.7010801@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from eu1sys200aog103.obsmtp.com ([207.126.144.115]:55652 "EHLO
	eu1sys200aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752167Ab1DSGEu (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 19 Apr 2011 02:04:50 -0400
In-Reply-To: <4DAD1DA5.7010801@st.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Vinod Koul <vinod.koul@intel.com>, Dan Williams <dan.j.williams@intel.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, amitgoel <amit.goel@st.com>, Armando VISCONTI <armando.visconti@st.com>, Shiraz HASHIM <shiraz.hashim@st.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "viresh.linux@gmail.com" <viresh.linux@gmail.com>

On 04/19/2011 10:59 AM, viresh kumar wrote:
> On 04/19/2011 06:01 AM, Linus Walleij wrote:
>> > It seems that the SPEAr needs this.
>> > 
>> > Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> Thanks for sending this.
> Actually i wasn't sure that disabling channel will simply pause it, and not
> finish the transfer. So, didn't went for this change.
> 
>> > ---
>> >  drivers/dma/dw_dmac.c      |   22 ++++++++++++++++++++--
>> >  drivers/dma/dw_dmac_regs.h |    1 +
>> >  2 files changed, 21 insertions(+), 2 deletions(-)

Moreover, dwc_tx_status() must be updated to add following code:

	if (dwc->paused)
		return DMA_PAUSED;

Will do that while sending it in my patchset.

-- 
viresh
