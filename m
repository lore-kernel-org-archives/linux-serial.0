From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] serial: ifx6x60: Add module parameters to manage the
 modem status through sysfs.
Date: Wed, 7 Nov 2012 08:47:54 +0000
Message-ID: <20121107084754.00167bfb@pyramind.ukuu.org.uk>
References: <1352286374.4332.52.camel@chenjun-workstation>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:42386 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750996Ab2KGImq (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 7 Nov 2012 03:42:46 -0500
In-Reply-To: <1352286374.4332.52.camel@chenjun-workstation>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Jun Chen <jun.d.chen@intel.com>
Cc: Alan Cox <alan@linux.intel.com>, serial <linux-serial@vger.kernel.org>, "russ.gorby" <russ.gorby@intel.com>, liu chuansheng <chuansheng.liu@intel.com>, Bi Chao <chao.bi@intel.com>


> Hangup_reasons used to give one interface to user space to know and clear the modem reset reasons.
> Now there are four reasons:SPI timeout, modem initiative reset,modem coredump,spi tranfer error.
> 
> Cc: Bi Chao <chao.bi@intel.com>
> Cc: Liu chuansheng <chuansheng.liu@intel.com>
> Signed-off-by: Chen Jun <jun.d.chen@intel.com>

Acked-by: Alan Cox <alan@linux.intel.com>
