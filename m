From: "Chen, Jun D" <jun.d.chen@intel.com>
Subject: RE: [PATCH] serial: ifx6x60: Add module parameters to manage the
 modem status through sysfs.
Date: Fri, 16 Nov 2012 01:55:52 +0000
Message-ID: <9E44E06DBBA23A489DED933DBC291A850FD7600F@SHSMSX102.ccr.corp.intel.com>
References: <1352286374.4332.52.camel@chenjun-workstation>
 <20121116005215.GA12849@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:57111 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750784Ab2KPBzz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 15 Nov 2012 20:55:55 -0500
In-Reply-To: <20121116005215.GA12849@kroah.com>
Content-Language: en-US
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Alan Cox <alan@linux.intel.com>, serial <linux-serial@vger.kernel.org>, "Gorby, Russ" <russ.gorby@intel.com>, "Liu, Chuansheng" <chuansheng.liu@intel.com>, "Bi, Chao" <chao.bi@intel.com>

Hi,Greg,
Got it, I will resend the new patch based on the tty-next branch to Alan again.  
Thanks!


-----Original Message-----
From: Greg KH [mailto:gregkh@linuxfoundation.org] 
Sent: Friday, November 16, 2012 8:52 AM
To: Chen, Jun D
Cc: Alan Cox; serial; Gorby, Russ; Liu, Chuansheng; Bi, Chao
Subject: Re: [PATCH] serial: ifx6x60: Add module parameters to manage the modem status through sysfs.

On Wed, Nov 07, 2012 at 06:06:14AM -0500, Jun Chen wrote:
> 
> The Medfield Platform implements a recovery procedure consisting in an 
> escalation from simple and light recovery procedures to stronger ones 
> with increased visibility and impact to end-user.After platform find 
> some problem from Modem,such as no response, platform will try do 
> modem warm reset.If several tries failed, platform will try to do 
> modem cold boot procedure.For Modem Cold Boot, AP is responsible to generate blob (binary object containing PIN code and other necessary information).
> Blob is stored in AP volatile memory. AP decides to read PIN code from 
> cache instead of prompting end-user, and sends it to modem as if end-user had entered it.
> 
> This patch add module parameters to manage the modem status through sysfs.
> Reset_modem can be read and write by user space.When read the 
> reset_modem,user space will get the mdm_reset_state which used to 
> avoid to run twice at once.When set the reset_modem to IFX_COLD_RESET_REQ,modem will do cold reset, other val value will trigger modem reset.
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

This patch fails to apply, can you please refresh it against my tty-next branch and resend it, keeping Alan's ack on it, so I remember it's there?

thanks,

greg k-h
