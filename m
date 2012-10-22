From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] serial: ifx6x60: add_timer is not safe in the
 mrdy_assert function
Date: Mon, 22 Oct 2012 10:55:31 +0100
Message-ID: <20121022105531.072a88f7@pyramind.ukuu.org.uk>
References: <1350915787.4332.27.camel@chenjun-workstation>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:48427 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751451Ab2JVJua (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 22 Oct 2012 05:50:30 -0400
In-Reply-To: <1350915787.4332.27.camel@chenjun-workstation>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Jun Chen <jun.d.chen@intel.com>
Cc: alan@linux.intel.com, linux-serial@vger.kernel.org, russ.gorby@intel.com, chuansheng.liu@intel.com, chao.bi@intel.com

On Mon, 22 Oct 2012 10:23:07 -0400
Jun Chen <jun.d.chen@intel.com> wrote:

> 
> This patch make use of mod_timer instead of add_timer in the mrdy_assert function.
> Because the srdy interrupter can go high when we are running function mrdy_assert and mrdy_assert
> can be called by multi-entry. In our medfield platform, spi stress test can encounter this
> error logs triggered by the BUG_ON of add_timer function.This patch had been tested on
> our medfield platform.
> 
> the scenario:
>       CPU0							CPU1
> mrdy_assert
> set_bit(IFX_SPI_STATE_TIMER_PENDING)
> 								ifx_spi_handle_srdy
> 								...
> 								clear_bit(IFX_SPI_STATE_TIMER_PENDING)
> 								...
> 								mrdy_assert
> 								set_bit(IFX_SPI_STATE_TIMER_PENDING)
> 								...
> 								add_timer
> ...
> add_timer
> 
> cc:liu chuansheng <chuansheng.liu@intel.com>
> cc:Bi Chao <chao.bi@intel.com>
> Signed-off-by: Chen Jun <jun.d.chen@intel.com>

Acked-by: Alan Cox <alan@linux.intel.com>
