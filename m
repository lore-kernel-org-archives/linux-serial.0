From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 2/2] serial: fsl_lpuart: add DMA support
Date: Thu, 16 Jan 2014 11:47:12 +0100
Message-ID: <201401161147.13522.arnd@arndb.de>
References: <1389763265-27300-2-git-send-email-yao.yuan@freescale.com> <201401151025.34628.arnd@arndb.de> <4a519c52821b4ceb841cbefcf2a0432b@BL2PR03MB338.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:49406 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752563AbaAPKsF (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 16 Jan 2014 05:48:05 -0500
In-Reply-To: <4a519c52821b4ceb841cbefcf2a0432b@BL2PR03MB338.namprd03.prod.outlook.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Yao Yuan <yao.yuan@freescale.com>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "shawn.guo@linaro.org" <shawn.guo@linaro.org>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>

On Thursday 16 January 2014, Yao Yuan wrote:
> > This part will result in a slight increase in data size even if dma
> > support is turned off at compile time.
> > 
> 
> Yes, someone also want me define a independent struct for dma and allocate the memory when dma be use.
> But I think this way will add a more memory access time, like a->b->c and a->c. And the variable 
> about dma is just a few bytes but used frequently. So I think I'd better define the variable about dma in lpuart_port struct.

I agree. Just leave it unconditionally in here to make the code simpler.

	Arnd
