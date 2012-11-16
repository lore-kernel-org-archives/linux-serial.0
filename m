From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] serial: ifx6x60: Add module parameters to manage the
 modem status through sysfs.
Date: Thu, 15 Nov 2012 16:52:15 -0800
Message-ID: <20121116005215.GA12849@kroah.com>
References: <1352286374.4332.52.camel@chenjun-workstation>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:34827 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750911Ab2KPAwT (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 15 Nov 2012 19:52:19 -0500
Received: by mail-pa0-f46.google.com with SMTP id hz1so1469226pad.19
        for <linux-serial@vger.kernel.org>; Thu, 15 Nov 2012 16:52:19 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1352286374.4332.52.camel@chenjun-workstation>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Jun Chen <jun.d.chen@intel.com>
Cc: Alan Cox <alan@linux.intel.com>, serial <linux-serial@vger.kernel.org>, "russ.gorby" <russ.gorby@intel.com>, liu chuansheng <chuansheng.liu@intel.com>, Bi Chao <chao.bi@intel.com>

On Wed, Nov 07, 2012 at 06:06:14AM -0500, Jun Chen wrote:
> 
> The Medfield Platform implements a recovery procedure consisting in an escalation
> from simple and light recovery procedures to stronger ones with increased visibility
> and impact to end-user.After platform find some problem from Modem,such as no response,
> platform will try do modem warm reset.If several tries failed, platform will try to
> do modem cold boot procedure.For Modem Cold Boot, AP is responsible to generate
> blob (binary object containing PIN code and other necessary information).
> Blob is stored in AP volatile memory. AP decides to read PIN code from cache instead of
> prompting end-user, and sends it to modem as if end-user had entered it.
> 
> This patch add module parameters to manage the modem status through sysfs.
> Reset_modem can be read and write by user space.When read the reset_modem,user space will
> get the mdm_reset_state which used to avoid to run twice at once.When set the reset_modem to
> IFX_COLD_RESET_REQ,modem will do cold reset, other val value will trigger modem reset.
> 
> Hangup_reasons used to give one interface to user space to know and clear the modem reset reasons.
> Now there are four reasons:SPI timeout, modem initiative reset,modem coredump,spi tranfer error.
> 
> Cc: Bi Chao <chao.bi@intel.com>
> Cc: Liu chuansheng <chuansheng.liu@intel.com>
> Signed-off-by: Chen Jun <jun.d.chen@intel.com>
> Acked-by: Alan Cox <alan@linux.intel.com>
> ---
>  drivers/tty/serial/Kconfig   |    2 +-
>  drivers/tty/serial/ifx6x60.c |  194 +++++++++++++++++++++++++++++++++++++++++-
>  drivers/tty/serial/ifx6x60.h |    8 ++
>  3 files changed, 202 insertions(+), 2 deletions(-)

This patch fails to apply, can you please refresh it against my tty-next
branch and resend it, keeping Alan's ack on it, so I remember it's
there?

thanks,

greg k-h
