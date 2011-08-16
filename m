From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/2] tty: serial8250: add helpers for the DesignWare 8250
Date: Tue, 16 Aug 2011 18:57:58 +0200
Message-ID: <201108161857.58613.arnd@arndb.de>
References: <1313513267-25955-1-git-send-email-jamie@jamieiles.com> <1313513267-25955-2-git-send-email-jamie@jamieiles.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:63677 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751684Ab1HPQ6L (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 16 Aug 2011 12:58:11 -0400
In-Reply-To: <1313513267-25955-2-git-send-email-jamie@jamieiles.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Jamie Iles <jamie@jamieiles.com>
Cc: linux-serial@vger.kernel.org, alan@lxorguk.ukuu.org.uk, Alan Cox <alan@linux.intel.com>, Greg Kroah-Hartman <gregkh@suse.de>

On Tuesday 16 August 2011, Jamie Iles wrote:
> The Synopsys DesignWare 8250 is an 8250 that has an extra interrupt that
> gets raised when writing to the LCR when busy.  To handle this we need
> special serial_out, serial_in and handle_irq methods.  Add a new
> function serial8250_use_designware_io() that configures a uart_port with
> these accessors.
> 
> Cc: Alan Cox <alan@linux.intel.com>
> Cc: Greg Kroah-Hartman <gregkh@suse.de>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Jamie Iles <jamie@jamieiles.com>

Hmm, this looks about as good as the solution that I had in mind (doing
a new platform_driver). I can't any obvious advantages either way, so
I guess you get to have your version ;-)

Acked-by: Arnd Bergmann <arnd@arndb.de>
