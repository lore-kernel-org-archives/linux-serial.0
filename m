From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] tty: add a DesignWare 8250 driver
Date: Fri, 26 Aug 2011 18:04:02 +0200
Message-ID: <201108261804.02784.arnd@arndb.de>
References: <1314368925-13097-1-git-send-email-jamie@jamieiles.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:50423 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754352Ab1HZQEK (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 26 Aug 2011 12:04:10 -0400
In-Reply-To: <1314368925-13097-1-git-send-email-jamie@jamieiles.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Jamie Iles <jamie@jamieiles.com>
Cc: linux-serial@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, Alan Cox <alan@linux.intel.com>, Greg Kroah-Hartman <gregkh@suse.de>

On Friday 26 August 2011, Jamie Iles wrote:
> The Synopsys DesignWare 8250 is an 8250 that has an extra interrupt that
> gets raised when writing to the LCR when busy.  To handle this we need
> special serial_out, serial_in and handle_irq methods.  Add a new
> platform driver that uses these accessors.
> 
> Cc: Alan Cox <alan@linux.intel.com>
> Cc: Greg Kroah-Hartman <gregkh@suse.de>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Jamie Iles <jamie@jamieiles.com>

The driver looks good to me,

Acked-by: Arnd Bergmann <arnd@arndb.de>

Is the patch to export serial8250_handle_irq already in Greg's tree or is that
still missing?

	Arnd
