From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH v2 3/4] serial: mrst_max3110: some code cleanup
Date: Fri, 10 Sep 2010 08:46:25 +0200
Message-ID: <20100910064625.GD31090@elte.hu>
References: <1284088220-12276-1-git-send-email-feng.tang@intel.com>
 <1284088220-12276-3-git-send-email-feng.tang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mx2.mail.elte.hu ([157.181.151.9]:47836 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750956Ab0IJGqe (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 10 Sep 2010 02:46:34 -0400
Content-Disposition: inline
In-Reply-To: <1284088220-12276-3-git-send-email-feng.tang@intel.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Feng Tang <feng.tang@intel.com>
Cc: linux-serial@vger.kernel.org, greg@kroah.com, alan@linux.intel.com


* Feng Tang <feng.tang@intel.com> wrote:

> The cleanup for mrst_max3110 includes:
> * remove unneeded head files
> * make the spi_transfer dma safe, so that driver is more portable
> * add more check for error return value
> * use mutex_trylock for read thread
> 
> Signed-off-by: Feng Tang <feng.tang@intel.com>
> Signed-off-by: Alan Cox <alan@linux.intel.com>
> ---
>  drivers/serial/mrst_max3110.c |  323 +++++++++++++++++++++++++----------------
>  drivers/serial/mrst_max3110.h |    1 +
>  2 files changed, 199 insertions(+), 125 deletions(-)
> 
> diff --git a/drivers/serial/mrst_max3110.c b/drivers/serial/mrst_max3110.c
> index f6ad1ec..880dce3 100644
> --- a/drivers/serial/mrst_max3110.c
> +++ b/drivers/serial/mrst_max3110.c
> @@ -1,7 +1,7 @@
>  /*
> - *  max3110.c - spi uart protocol driver for Maxim 3110 on Moorestown
> + *  mrst_max3110.c - spi uart protocol driver for Maxim 3110
>   *
> - *  Copyright (C) Intel 2008 Feng Tang <feng.tang@intel.com>
> + * Copyright (c) 2010, Intel Corporation.

Just a small nit i noticed: please try to never remove old copyright 
notices (even if it's your own company's), but do something like:

> + * Copyright (c) 2008, 2010, Intel Corporation.

Or:

> + * Copyright (c) 2008-2010, Intel Corporation.

If Intel worked on it in 2009 too. (or whatever other copyright notice 
policy Intel has.)

( otherwise i suspect serial folks will review the rest of the patch, i 
  havent checked. )

Thanks,

	Ingo
