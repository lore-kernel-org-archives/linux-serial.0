From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] the eDMA support for the LPUART send driver
Date: Tue, 7 Jan 2014 09:53:51 +0100
Message-ID: <201401070953.52207.arnd@arndb.de>
References: <1388143449-28640-1-git-send-email-yao.yuan@freescale.com> <20140105145031.GB27432@n2100.arm.linux.org.uk> <0602455564214ab7986348ea985fc820@BL2PR03MB338.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:57251 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752108AbaAGIyC (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 7 Jan 2014 03:54:02 -0500
In-Reply-To: <0602455564214ab7986348ea985fc820@BL2PR03MB338.namprd03.prod.outlook.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Yao Yuan <yao.yuan@freescale.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>

On Tuesday 07 January 2014, Yao Yuan wrote:
> Thanks for your suggestion. It's important for me.
> 
> I read the source code for dma_map_single again. I found that both of them(as first argument is
> dma or uart) worked well. But in my code I found that the *sport->port.dev->dma_mask is not
> zero. By contrast the dma_mask for dma device is zero.

Ah, it seems you found two more bugs then ;-)

> You are right. There should be dma device. But I also have a doubt here. Why I find many other
> driver use the first argument here rather than the dma device pointer.

It's a common mistake. Most other linux device driver interfaces require you to pass the
device you are working on, so it's understandable why people come to the wrong conclusion
here.

	Arnd
