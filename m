From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [RESEND PATCH] 8250_core: Fix unwanted TX chars write
Date: Thu, 24 Apr 2014 13:24:18 +0300
Message-ID: <20140424102418.GB23665@xps8300>
References: <1398332336-5053-1-git-send-email-loic.poulain@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:25219 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753264AbaDXKYY (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 24 Apr 2014 06:24:24 -0400
Content-Disposition: inline
In-Reply-To: <1398332336-5053-1-git-send-email-loic.poulain@intel.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Loic Poulain <loic.poulain@intel.com>
Cc: gregkh@linuxfoundation.org, linux-serial@vger.kernel.org

On Thu, Apr 24, 2014 at 11:38:56AM +0200, Loic Poulain wrote:
> On transmit-hold-register empty, serial8250_tx_chars
> should be called only if we don't use DMA.
> DMA has its own tx cycle.
> 
> Signed-off-by: Loic Poulain <loic.poulain@intel.com>

This should also go to stable tree.

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

Thanks,

-- 
heikki
