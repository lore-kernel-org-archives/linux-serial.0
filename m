From: "Mark A. Greer" <mgreer@mvista.com>
Subject: Re: [PATCH] serial: mpsc: release port lock on call to tty_flip_buffer_push
Date: Tue, 22 Jul 2008 10:31:43 -0700
Message-ID: <20080722173143.GA12761@mag.az.mvista.com>
References: <20080722162119.GA4376@farnsworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from fw1-az.mvista.com ([65.200.49.156]:24413 "EHLO
	zipcode.az.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750946AbYGVS1A (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 22 Jul 2008 14:27:00 -0400
Content-Disposition: inline
In-Reply-To: <20080722162119.GA4376@farnsworth.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Dale Farnsworth <dale@farnsworth.org>, mgreer@mvista.com

Dale Farnsworth wrote:
>
> We need to release the port lock when we call tty_flip_buffer_push()
> to avoid a deadlock when the serial-core routines try to acquire
> the same lock.  This deadlock has been observed on CONFIG_PREEMPT_RT
> configurations.
> 
> Signed-off-by: Dale Farnsworth <dale@farnsworth.org>
> Cc: <mgreer@mvista.com>
> ---
>  drivers/serial/mpsc.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/serial/mpsc.c b/drivers/serial/mpsc.c
> index c9f53e7..158d748 100644
> --- a/drivers/serial/mpsc.c
> +++ b/drivers/serial/mpsc.c
> @@ -1065,7 +1065,9 @@ next_frame:
>  	if ((readl(pi->sdma_base + SDMA_SDCM) & SDMA_SDCM_ERD) == 0)
>  		mpsc_start_rx(pi);
>  
> +	spin_unlock(&pi->port.lock);
>  	tty_flip_buffer_push(tty);
> +	spin_lock(&pi->port.lock);
>  	return rc;
>  }

Acked-by: Mark A. Greer <mgreer@mvista.com>
