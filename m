From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH v4 0/3] serial: fsl_lpuart: add DMA support
Date: Mon, 27 Jan 2014 15:50:27 +0800
Message-ID: <20140127075025.GC4765@S2101-09.ap.freescale.net>
References: <1390363773-24108-1-git-send-email-yao.yuan@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from co9ehsobe005.messaging.microsoft.com ([207.46.163.28]:2240 "EHLO
	co9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751098AbaA0HuY (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 27 Jan 2014 02:50:24 -0500
Content-Disposition: inline
In-Reply-To: <1390363773-24108-1-git-send-email-yao.yuan@freescale.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Yuan Yao <yao.yuan@freescale.com>
Cc: gregkh@linuxfoundation.org, linux@arm.linux.org.uk, arnd@arndb.de, mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org

On Wed, Jan 22, 2014 at 12:09:30PM +0800, Yuan Yao wrote:
> Changed in v4:
> - Move dma properties from dtsi to dts.

Why this change?  DMA is a SoC level resource rather than board one.

Shawn

