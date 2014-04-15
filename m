From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: 8250_dw DMA issue with BYT ?
Date: Tue, 15 Apr 2014 09:56:06 +0300
Message-ID: <20140415065606.GA3368@xps8300>
References: <50C3158CF44D924791C15F1437EF2EC65D9BE7@HASMSX104.ger.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:20124 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751050AbaDOG43 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 15 Apr 2014 02:56:29 -0400
Content-Disposition: inline
In-Reply-To: <50C3158CF44D924791C15F1437EF2EC65D9BE7@HASMSX104.ger.corp.intel.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: "Poulain, Loic" <loic.poulain@intel.com>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "Jin, Yao" <yao.jin@intel.com>

On Mon, Apr 14, 2014 at 03:54:31PM +0000, Poulain, Loic wrote:
> Hello Heikki,
> 
> I contact you regarding the 8250_dw driver.
> My setup is an Asus T100TA (baytrail) + kernel 3.14.
> The UART controller is ACPI enumerated (ID is 80860F0A).
> (UART_CAP_AFE capable)
> 
> This uart is used to communicate with a BCM4324 bluetooth chip
> (HCI H4 over uart). However we have many bluetooth instabilities.
> These instabilities are due to the 'hardware error' HCI code sent
> by the BCM chip. This error means that the BCM received an invalid
> H4 packet header or an invalid sized packet => serial sync issue.
> Moreover, Increasing the baudrate increases the hardware error
> frequency.
> 
> This problem seems due to the DMA usage. Indeed, when I disable
> the DMA manually in 8250_dw.c (up->dma = NULL), problem does not
> occur anymore, all baudrates are stable.

I think this is the same issue Jin Yao (CC'd) already spotted. He made
a bug for it:
https://bugzilla.kernel.org/show_bug.cgi?id=73071

> Do you think a specific 8250 DMA configuration could apply for the byt
> case ?
> How/Where can I debug to know if the 8250 DMA works as expected ?

Adding Andy. He maintains the Designware DMA Engine driver that is
used on BYT. He should be the best person to tell how to debug the
DMA.

We are debugging an other issue where the DMA mask for the device is
somehow set wrong. This does not exactly look like the same problem,
but you newer know. Try getting the TX buffer page from the first 16M
of memory..

--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -143,7 +143,7 @@ static int uart_port_startup(struct tty_struct *tty, struct uart_state *state,
         */
        if (!state->xmit.buf) {
                /* This is protected by the per port mutex */
-               page = get_zeroed_page(GFP_KERNEL);
+               page = get_zeroed_page(GFP_KERNEL | GFP_DMA);
                if (!page)
                        return -ENOMEM;


If the issue disappears, we know it's the same problem.

Thanks,

-- 
heikki
