Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E80EC54EE9
	for <linux-serial@archiver.kernel.org>; Tue, 20 Sep 2022 08:06:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230449AbiITIGe (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 20 Sep 2022 04:06:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230456AbiITIFb (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 20 Sep 2022 04:05:31 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9187465557;
        Tue, 20 Sep 2022 01:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663660986; x=1695196986;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=wDpKHXz4ew/kTU5ZDEVxB2tmYCz8rWqEJ1pKtGZ1KDE=;
  b=hBZr7csBeRjMqeVZ+ZnDDTWJfDrrZ4HTJ7TCpYbmcDt+rVlSUL3CmiVD
   ARkjEXn91iCR9ZAD+y8BKmfJyJd1TMIcNrj1BVHf6JTaKJirWFRWXHt2+
   Gfmmz7FunXBMCXwClWTorqcmkE4t/sasKA4JY2a1XC//nVNDUXLgmhHbb
   i1L1N4ubbZ89EqpltOphXRGmAH3uqOUwz6X9KWGwvVMztJT3IbFD4+UOk
   ligiku+tq20hATU3y5ZPU04BOgMd+Rsd/TTvXtGCsFI9U/n6ZqQd3kJDa
   Jg3r772OQ68oSQfuq1LMuPqCkFJyhvvuI5JE/AYIOJTL9UaCKpAwUGOIf
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10475"; a="325929611"
X-IronPort-AV: E=Sophos;i="5.93,330,1654585200"; 
   d="scan'208";a="325929611"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2022 01:03:06 -0700
X-IronPort-AV: E=Sophos;i="5.93,330,1654585200"; 
   d="scan'208";a="649485814"
Received: from bdallmer-mobl.ger.corp.intel.com ([10.252.59.238])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2022 01:03:04 -0700
Date:   Tue, 20 Sep 2022 11:03:02 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Jiri Slaby <jslaby@suse.cz>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 04/10] tty: serial: extract lqasc_tx_ready() from
 lqasc_tx_chars()
In-Reply-To: <20220920052049.20507-5-jslaby@suse.cz>
Message-ID: <84e9274-7012-ef18-716c-b373221e7cb2@linux.intel.com>
References: <20220920052049.20507-1-jslaby@suse.cz> <20220920052049.20507-5-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, 20 Sep 2022, Jiri Slaby wrote:

> The condition in lqasc_tx_chars()'s loop is barely readable. Extract it
> to a separate function. This will make the cleanup in the next patches
> easier too.
> 
> (Put it before lqasc_start_tx(), so that we can use it there later.)
> 
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> ---
> 
> Notes:
>     [v4] this is new in v4 -- extracted as a separate change
> 
>  drivers/tty/serial/lantiq.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/lantiq.c b/drivers/tty/serial/lantiq.c
> index 6637b3caa6b7..6da1b7496c6c 100644
> --- a/drivers/tty/serial/lantiq.c
> +++ b/drivers/tty/serial/lantiq.c
> @@ -139,6 +139,13 @@ lqasc_stop_tx(struct uart_port *port)
>  	return;
>  }
>  
> +static bool lqasc_tx_ready(struct uart_port *port)
> +{
> +	u32 fstat = __raw_readl(port->membase + LTQ_ASC_FSTAT);
> +
> +	return (fstat & ASCFSTAT_TXFREEMASK) >> ASCFSTAT_TXFREEOFF;

FIELD_GET(ASCFSTAT_TXFREEMASK, fstat)

> +}
> +
>  static void
>  lqasc_start_tx(struct uart_port *port)
>  {
> @@ -228,8 +235,7 @@ lqasc_tx_chars(struct uart_port *port)
>  		return;
>  	}
>  
> -	while (((__raw_readl(port->membase + LTQ_ASC_FSTAT) &
> -		ASCFSTAT_TXFREEMASK) >> ASCFSTAT_TXFREEOFF) != 0) {
> +	while (lqasc_tx_ready(port)) {
>  		if (port->x_char) {
>  			writeb(port->x_char, port->membase + LTQ_ASC_TBUF);
>  			port->icount.tx++;

There's similar construct in lqasc_console_putchar() that could take 
advantage of the same helper.

With FIELD_GET + the other place using the new helper, ASCFSTAT_TXFREEOFF 
can be dropped as well.


-- 
 i.

