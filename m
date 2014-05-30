From: Huang Shijie <b32955@freescale.com>
Subject: Re: [PATCH 1/2] serial: imx: remove the DMA wait queue
Date: Fri, 30 May 2014 17:01:30 +0800
Message-ID: <20140530090128.GA4380@shlinux1.ap.freescale.net>
References: <1400819575-20435-1-git-send-email-b32955@freescale.com>
 <857E9EDCA6C0904DB3357321AA9123EBE14B5A2C@NA-MBX-03.mgc.mentorg.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-bn1blp0186.outbound.protection.outlook.com ([207.46.163.186]:57959
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755275AbaE3KXD (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 30 May 2014 06:23:03 -0400
Content-Disposition: inline
In-Reply-To: <857E9EDCA6C0904DB3357321AA9123EBE14B5A2C@NA-MBX-03.mgc.mentorg.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: "Wang, Jiada (ESD)" <Jiada_Wang@mentor.com>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "Behme, Dirk - Bosch" <dirk.behme@de.bosch.com>

On Fri, May 30, 2014 at 09:27:20AM +0000, Wang, Jiada (ESD) wrote:
> Hi Shijie
> 
> After apply this patch into our kernel,
> We are facing data hang issue when sending big size file (2M used in test) to uart port
> Note: Rx port is also keep receiving data.
> 
> After read the implementation of uart_stop(),
> I feel like, stop_tx() is used to perform flow control when like a XOFF is received.
> Which means no data should be dropped, as they may need to be sent out,
> When next start_tx() is called.
> 
> But by calling dmaengine_termiate_all(), the data already be submitted to DMA engine,
> May be lost, thus cause data hang.
> 
> What do you think?
This patch has been reverted by Greg.

I also noticed the data loss issue. 

thanks
Huang Shijie
