From: Vinod Koul <vkoul@infradead.org>
Subject: Re: [PATCH v2 2/3] serial: mxs-auart: add the DMA support for mx28
Date: Thu, 25 Oct 2012 16:38:00 +0530
Message-ID: <1351163280.7077.11.camel@vkoul-udesk3>
References: <1351074456-25863-1-git-send-email-b32955@freescale.com>
	 <1351074456-25863-3-git-send-email-b32955@freescale.com>
	 <1351138689.5263.68.camel@vkoul-udesk3> <5088D336.7040206@freescale.com>
	 <1351145272.7077.8.camel@vkoul-udesk3>  <5089033F.9040100@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:36815 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755377Ab2JZE7c (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 26 Oct 2012 00:59:32 -0400
In-Reply-To: <5089033F.9040100@freescale.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Huang Shijie <b32955@freescale.com>
Cc: vinod.koul@intel.com, linux@arm.linux.org.uk, gregkh@linuxfoundation.org, lauri.hintsala@bluegiga.com, linux-serial@vger.kernel.org, shawn.guo@linaro.org, linux-arm-kernel@lists.infradead.org, alan@linux.intel.com

On Thu, 2012-10-25 at 17:15 +0800, Huang Shijie wrote:
> yes. I have to setup the register. Could you told me which API is the 
> right API?
dmaengine_slave_config() should be used to send the slave specfic
parameters
> 
> It seems to the mxs-dma needs a patch again. 
Yes definitely :)

-- 
Vinod Koul
Intel Corp.

