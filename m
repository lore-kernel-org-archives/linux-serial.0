From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH] serial: 8250_dma: call serial8250_tx_dma unconditionally
Date: Wed, 15 Oct 2014 15:53:10 +0300
Message-ID: <20141015125310.GA3509@kuha.fi.intel.com>
References: <1412772129-22816-1-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:9424 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751584AbaJOMxN (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 15 Oct 2014 08:53:13 -0400
Content-Disposition: inline
In-Reply-To: <1412772129-22816-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org

On Wed, Oct 08, 2014 at 03:42:09PM +0300, Andy Shevchenko wrote:
> Since we have the same check inside the function we may drop it away in
> __dma_tx_complete().
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Looks good to me. FWIW..

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>


Thanks,

-- 
heikki
