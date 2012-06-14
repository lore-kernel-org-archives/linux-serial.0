From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH V2] serial: pxa: add spin lock for console write
Date: Wed, 13 Jun 2012 20:23:36 -0700
Message-ID: <20120614032336.GA7765@kroah.com>
References: <1337661780-26446-1-git-send-email-chao.xie@marvell.com>
 <20120612223515.GA14008@kroah.com>
 <25B60CDC2F704E4E9D88FFD52780CB4C060E55D5AF@SC-VEXCH1.marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:43599 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755096Ab2FNDXk (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 13 Jun 2012 23:23:40 -0400
Received: by dady13 with SMTP id y13so1934724dad.19
        for <linux-serial@vger.kernel.org>; Wed, 13 Jun 2012 20:23:40 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <25B60CDC2F704E4E9D88FFD52780CB4C060E55D5AF@SC-VEXCH1.marvell.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Haojian Zhuang <hzhuang1@marvell.com>
Cc: Chao Xie <cxie4@marvell.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>

A: No.
Q: Should I include quotations after my reply?

http://daringfireball.net/2007/07/on_top


On Wed, Jun 13, 2012 at 08:14:20PM -0700, Haojian Zhuang wrote:
> V2 moves local_irq_save() after clk_prepare_enable().

Then say that in the patch description please.

> The extra empty line is unnecessary.

Great, please remove it :)

> Greg,
> 
> Would you apply this patch?

Please resend it with the above changes made.

thanks,

greg k-h
