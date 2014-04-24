From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCHv2] serial: 8250: Fix thread unsafe __dma_tx_complete
 function
Date: Thu, 24 Apr 2014 13:23:17 +0300
Message-ID: <20140424102317.GA23665@xps8300>
References: <1398332088-4905-1-git-send-email-loic.poulain@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:42658 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755613AbaDXKXX (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 24 Apr 2014 06:23:23 -0400
Content-Disposition: inline
In-Reply-To: <1398332088-4905-1-git-send-email-loic.poulain@intel.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Loic Poulain <loic.poulain@intel.com>
Cc: gregkh@linuxfoundation.org, linux-serial@vger.kernel.org

On Thu, Apr 24, 2014 at 11:34:48AM +0200, Loic Poulain wrote:
> __dma_tx_complete is not protected against concurrent
> call of serial8250_tx_dma. it can lead to circular tail
> index corruption or parallel call of serial_tx_dma on the
> same data portion.
> 
> This patch fixes this issue by holding the port lock.
> 
> Signed-off-by: Loic Poulain <loic.poulain@intel.com>

I think this should also go to stable tree. It applies on top of >=v3.9.

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

Thanks!

-- 
heikki
