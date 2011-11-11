From: Alan Cox <alan@linux.intel.com>
Subject: Re: [PATCH] pch_uart: Fix DMA resource leak issue
Date: Fri, 11 Nov 2011 08:37:40 +0000
Message-ID: <20111111083740.3e02c46a@bob.linux.org.uk>
References: <1320976527-6142-1-git-send-email-tomoya.rohm@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:57553 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752085Ab1KKI0b (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 11 Nov 2011 03:26:31 -0500
In-Reply-To: <1320976527-6142-1-git-send-email-tomoya.rohm@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Tomoya MORINAGA <tomoya.rohm@gmail.com>
Cc: gregkh@suse.de, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, qi.wang@intel.com, yong.y.wang@intel.com, joel.clark@intel.com, kok.howg.ewe@intel.com

> MODIFICATION:
>   Currently, when release DMA channel resource, this driver checks
> dma-flag. However, this specification occurs the above issue.
>   This driver must check whether dma_request_channel is executed or
> not. The values are saved in private data variable "chan_tx/chan_tx".
>   These variables mean if the value is NULL, DMA channel is not
> requested, if not NULL, DMA channel is requested.
> 
> This patch fixes the issue.
> 
> Signed-off-by: Tomoya MORINAGA <tomoya.rohm@gmail.com>

Acked-by: Alan Cox <alan@linux.intel.com>
