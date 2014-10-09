From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH] serial: 8250_dw: Add DMA support for non-ACPI platforms
Date: Thu, 9 Oct 2014 16:20:42 +0300
Message-ID: <20141009132042.GC9108@kuha.fi.intel.com>
References: <rjui@broadcom.com>
 <1412728547-4126-1-git-send-email-rjui@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:50133 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751195AbaJINUs (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 9 Oct 2014 09:20:48 -0400
Content-Disposition: inline
In-Reply-To: <1412728547-4126-1-git-send-email-rjui@broadcom.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Ray Jui <rjui@broadcom.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Chen-Yu Tsai <wens@csie.org>, Paul Gortmaker <paul.gortmaker@windriver.com>, Loic Poulain <loic.poulain@intel.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, JD Zheng <jdzheng@broadcom.com>, Scott Branden <sbranden@broadcom.com>

On Tue, Oct 07, 2014 at 05:35:47PM -0700, Ray Jui wrote:
> The dma pointer under struct uart_8250_port is currently left
> unassigned for non-ACPI platforms. It should be pointing to the dma
> member in struct dw8250_data like how it was done for ACPI, so the core
> 8250 code will try to request for DMA when registering the port
> 
> If DMA is not enabled in device tree, request DMA will fail and the
> driver will fall back to PIO
> 
> Signed-off-by: Ray Jui <rjui@broadcom.com>
> Reviewed-by: JD (Jiandong) Zheng <jdzheng@broadcom.com>
> Reviewed-by: Scott Branden <sbranden@broadcom.com>
> Tested-by: Scott Branden <sbranden@broadcom.com>

OK by me. FWIW..

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>


-- 
heikki
