Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EAB9CD54A9
	for <linux-serial@archiver.kernel.org>; Tue, 19 Sep 2023 10:10:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbjISKKN (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 19 Sep 2023 06:10:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbjISKKM (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 19 Sep 2023 06:10:12 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97D21E8;
        Tue, 19 Sep 2023 03:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695118206; x=1726654206;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=akKe1so1N51A7hIrM9z2QWs2dwiLL2naA5vljgaXcmk=;
  b=K+tT3TSNBnYdJ+MJ3NBk8azwe6A9a63RneLvk8BRhB91odyM5QDh8FBi
   YXtFvepc66auzrXZ+gjXUoa+NpEbWhx6bhb1t9s3CXXf3KsDt235j81gC
   jFskbgfC8H7qM/2T7Ats3bOS76grXp0Ry1xnoX84bKCmRAH/E3rzardrO
   SbSmDF33v9DuVL8vwDDwi21mgVRaLizalDgK9hUFyfHC+m3RPQgLPdlEb
   SGUbSK5kdbcqwAd9EIgYZiDxydii5nYInhDyuwBxSTXrYDapjVnTSC3DJ
   C6FpNQES5coRcZPkmQg5y3+JzUsp+s4XJ4GVmdbCUtC5CFQielkSaKaZ4
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="378797599"
X-IronPort-AV: E=Sophos;i="6.02,159,1688454000"; 
   d="scan'208";a="378797599"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2023 03:10:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="695855012"
X-IronPort-AV: E=Sophos;i="6.02,159,1688454000"; 
   d="scan'208";a="695855012"
Received: from laichele-mobl1.ger.corp.intel.com ([10.252.38.7])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2023 03:10:02 -0700
Date:   Tue, 19 Sep 2023 13:10:00 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
cc:     gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 12/15] tty: convert THROTTLE constants into enum
In-Reply-To: <20230919085156.1578-13-jirislaby@kernel.org>
Message-ID: <122da55f-d45-923b-953-7a025a7d42f@linux.intel.com>
References: <20230919085156.1578-1-jirislaby@kernel.org> <20230919085156.1578-13-jirislaby@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, 19 Sep 2023, Jiri Slaby (SUSE) wrote:

> And make an explicit constant for zero too. This allows for easier type
> checking of the parameter.
> 
> Note: tty_struct::flow_change is kept as int because include/tty.h
> (tty_struct) doesn't see tty/tty.h (this enum).

And it cannot moved there because of what?

-- 
 i.


> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> ---
>  drivers/tty/tty.h       | 13 +++++++++----
>  drivers/tty/tty_ioctl.c |  2 +-
>  2 files changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/tty/tty.h b/drivers/tty/tty.h
> index 50862f98273e..93cf5ef1e857 100644
> --- a/drivers/tty/tty.h
> +++ b/drivers/tty/tty.h
> @@ -41,15 +41,20 @@ enum {
>  };
>  
>  /* Values for tty->flow_change */
> -#define TTY_THROTTLE_SAFE	1
> -#define TTY_UNTHROTTLE_SAFE	2
> +enum tty_flow_change {
> +	TTY_FLOW_NO_CHANGE,
> +	TTY_THROTTLE_SAFE,
> +	TTY_UNTHROTTLE_SAFE,
> +};
>  
> -static inline void __tty_set_flow_change(struct tty_struct *tty, int val)
> +static inline void __tty_set_flow_change(struct tty_struct *tty,
> +					 enum tty_flow_change val)
>  {
>  	tty->flow_change = val;
>  }
>  
> -static inline void tty_set_flow_change(struct tty_struct *tty, int val)
> +static inline void tty_set_flow_change(struct tty_struct *tty,
> +				       enum tty_flow_change val)
>  {
>  	tty->flow_change = val;
>  	smp_mb();
> diff --git a/drivers/tty/tty_ioctl.c b/drivers/tty/tty_ioctl.c
> index 42c793e9d131..4b499301a3db 100644
> --- a/drivers/tty/tty_ioctl.c
> +++ b/drivers/tty/tty_ioctl.c
> @@ -104,7 +104,7 @@ void tty_unthrottle(struct tty_struct *tty)
>  	if (test_and_clear_bit(TTY_THROTTLED, &tty->flags) &&
>  	    tty->ops->unthrottle)
>  		tty->ops->unthrottle(tty);
> -	tty->flow_change = 0;
> +	tty->flow_change = TTY_FLOW_NO_CHANGE;
>  	up_write(&tty->termios_rwsem);
>  }
>  EXPORT_SYMBOL(tty_unthrottle);
> 
