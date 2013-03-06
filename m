From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 08/12] serial: mxs-auart: move to use generic DMA
 helper
Date: Wed, 6 Mar 2013 09:36:19 +0800
Message-ID: <20130306013619.GC8260@kroah.com>
References: <1362486244-24593-1-git-send-email-shawn.guo@linaro.org>
 <1362486244-24593-9-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pb0-f53.google.com ([209.85.160.53]:65154 "EHLO
	mail-pb0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751126Ab3CFBf7 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 5 Mar 2013 20:35:59 -0500
Received: by mail-pb0-f53.google.com with SMTP id un1so5231870pbc.26
        for <linux-serial@vger.kernel.org>; Tue, 05 Mar 2013 17:35:57 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1362486244-24593-9-git-send-email-shawn.guo@linaro.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, Vinod Koul <vinod.koul@intel.com>, Arnd Bergmann <arnd@arndb.de>, Marek Vasut <marek.vasut@gmail.com>, Fabio Estevam <fabio.estevam@freescale.com>, Huang Shijie <b32955@freescale.com>, linux-serial@vger.kernel.org

On Tue, Mar 05, 2013 at 08:24:00PM +0800, Shawn Guo wrote:
> With the generic DMA device tree helper supported by mxs-dma driver,
> client devices only need to call dma_request_slave_channel() for
> requesting a DMA channel from dmaengine.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: linux-serial@vger.kernel.org


Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
