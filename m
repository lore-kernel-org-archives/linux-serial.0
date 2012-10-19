From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] serial: ifx6x60: del_timer_sync must not be called in
 interrupt context.
Date: Fri, 19 Oct 2012 10:54:19 +0100
Message-ID: <20121019105419.74b5bef6@pyramind.ukuu.org.uk>
References: <1350654690.4332.12.camel@chenjun-workstation>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:45767 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752924Ab2JSJtV (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 19 Oct 2012 05:49:21 -0400
In-Reply-To: <1350654690.4332.12.camel@chenjun-workstation>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Jun Chen <jun.d.chen@intel.com>
Cc: alan@linux.intel.com, linux-serial@vger.kernel.org, russ.gorby@intel.com, chuansheng.liu@intel.com, chao.bi@intel.com

On Fri, 19 Oct 2012 09:51:30 -0400
Jun Chen <jun.d.chen@intel.com> wrote:

> 
> This patch make use of del_timer instead of del_timer_sync in the
> interrupt context.
> The spi_timer function don't use any resources that may release after
> running del_timer,
> so using the del_timer is also safe and enough in this context.
> 
> Signed-off-by: Chen Jun <jun.d.chen@intel.com>

Acked-by: Alan Cox <alan@linux.intel.com>
