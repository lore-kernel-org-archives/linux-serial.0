From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH v3] serial: 8250: Add Quark X1000 to 8250_pci.c
Date: Tue, 23 Sep 2014 10:58:17 +0300
Message-ID: <20140923075817.GA18814@xps8300>
References: <1411431671-26540-1-git-send-email-pure.logic@nexus-software.ie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:40338 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750828AbaIWH6s (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 23 Sep 2014 03:58:48 -0400
Content-Disposition: inline
In-Reply-To: <1411431671-26540-1-git-send-email-pure.logic@nexus-software.ie>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Bryan O'Donoghue <pure.logic@nexus-software.ie>
Cc: gregkh@linuxfoundation.org, jslaby@suse.cz, andriy.shevchenko@linux.intel.com, kean.ho.chew@intel.com, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org

On Tue, Sep 23, 2014 at 01:21:11AM +0100, Bryan O'Donoghue wrote:
> Quark X1000 contains two designware derived 8250 serial ports.
> Each port has a unique PCI configuration space consisting of
> BAR0:UART BAR1:DMA respectively.
> 
> Unlike the standard 8250 the register width is 32 bits for RHR,IER etc
> The Quark UART has a fundamental clock @ 44.2368 MHz allowing for a
> bitrate of up to about 2.76 megabits per second.
> 
> This patch enables standard 8250 mode
> 
> Signed-off-by: Bryan O'Donoghue <pure.logic@nexus-software.ie>

Looks good to me. FWIW..

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

Thanks,

-- 
heikki
