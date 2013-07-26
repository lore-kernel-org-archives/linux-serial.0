From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH 6/9] serial: tegra: move to generic dma DT binding
Date: Fri, 26 Jul 2013 13:41:35 -0600
Message-ID: <51F2D0EF.9070808@wwwdotorg.org>
References: <1374639002-16753-1-git-send-email-rizhao@nvidia.com> <1374639002-16753-7-git-send-email-rizhao@nvidia.com> <51F2D063.5010505@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:43710 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751704Ab3GZTli (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 26 Jul 2013 15:41:38 -0400
In-Reply-To: <51F2D063.5010505@wwwdotorg.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Richard Zhao <rizhao@nvidia.com>
Cc: linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, gregkh@linuxfoundation.org

On 07/26/2013 01:39 PM, Stephen Warren wrote:
> On 07/23/2013 10:09 PM, Richard Zhao wrote:
>> - driver: remove use of nvidia,dma-request-selector
>> 	  use dma_request_slave_channel to request channel
>> - update binding doc
> 
> This patch needs to be amended so that the DMA channel is looked up
> during probe() rather than open(), to guarantee that deferred probe
> works. It's possible to hold off probe, but not possible AFAIK to hold
> off opening the port.

Hmm. I guess this comment actually applies to all/most of these patches.
