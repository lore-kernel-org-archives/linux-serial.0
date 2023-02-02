Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B288C61DA4
	for <linux-serial@archiver.kernel.org>; Thu,  2 Feb 2023 11:26:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbjBBL0T (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 2 Feb 2023 06:26:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbjBBL0S (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 2 Feb 2023 06:26:18 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B45689FB4
        for <linux-serial@vger.kernel.org>; Thu,  2 Feb 2023 03:26:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675337178; x=1706873178;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=xwGkWvvYI1hxz540D2ydQkne/d8yXLiUs7Q9bCLE/pQ=;
  b=Km3IO7LswnuWB8F5SGjVOjZQY6Bcs09iU7UlS0r/1z6MW2+X5mNKgaex
   Eh/XU50zNBAskTPQnNSvRE9CAsf6g4AI0BkI1l6r6KbzadHFycJj0Omy8
   Iur8pNO4kHTvIjcHt7C+iuzq5IfJ9nDZ8ZYaNZPq+m/eEZGWdwQ/v33qx
   Z5931fBdf3vvdTkafm/2leva09UAJSABMGvtLm6jOOqO6DqTcW8QcyHAA
   S2OGavTJ1H4wU8YB+4BsUda5dF8aRIPLC6IyoV0lHstyXy0Ecs7WWAHuK
   NcGQoT74dH/ptdYT+rboD1a/7dIEs2bWikeDQsUqNU1dRkTH3UvWY+YPM
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="414627253"
X-IronPort-AV: E=Sophos;i="5.97,267,1669104000"; 
   d="scan'208";a="414627253"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2023 03:26:17 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="910728187"
X-IronPort-AV: E=Sophos;i="5.97,267,1669104000"; 
   d="scan'208";a="910728187"
Received: from apaczko-mobl3.ger.corp.intel.com ([10.252.36.45])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2023 03:26:14 -0800
Date:   Thu, 2 Feb 2023 13:26:08 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     =?ISO-8859-15?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-serial <linux-serial@vger.kernel.org>,
        kernel@pengutronix.de
Subject: Re: [PATCH] serial: 8250: Fix mismerge regarding serial_lsr_in()
In-Reply-To: <20230202104501.264686-1-u.kleine-koenig@pengutronix.de>
Message-ID: <f157ed1b-3856-7ac9-f054-265536ba3b3@linux.intel.com>
References: <20230202104501.264686-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-2127987035-1675337176=:2215"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-2127987035-1675337176=:2215
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Thu, 2 Feb 2023, Uwe Kleine-König wrote:

> The relevant history introducing serial_lsr_in() looks as follows:
> 
> 	$ git log --graph --oneline --boundary 9fafe733514b..df36f3e3fbb7 -- drivers/tty/serial/8250/8250_port.c
> 	*   df36f3e3fbb7 Merge tag 'v5.19-rc3' into tty-next
> 	|\
> 	| * be03b0651ffd serial: 8250: Store to lsr_save_flags after lsr read
> 	* | ...
> 	* | bdb70c424df1 serial: 8250: Create serial_lsr_in()
> 	* | ce338e4477cf serial: 8250: Store to lsr_save_flags after lsr read
> 	* | ...
> 	|/
> 	o 9fafe733514b tty: remove CMSPAR ifdefs
> 
> So the patch "serial: 8250: Store to lsr_save_flags after lsr read" was
> introduced twice and in one branch it was followed up by commit
> bdb70c424df1 ("serial: 8250: Create serial_lsr_in()") which moved
> explicit lsr_saved_flags handling into a new function serial_lsr_in().
> When the two branches were merged in commit df36f3e3fbb7, we got both,
> serial_lsr_in() and the explicit lsr_saved_flags handling.
> 
> So drop the explicit lsr_saved_flags handling.
> 
> Fixes: df36f3e3fbb7 ("Merge tag 'v5.19-rc3' into tty-next")
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/tty/serial/8250/8250_port.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
> index 33be7aad11ef..e61753c295d5 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -1512,8 +1512,6 @@ static inline void __stop_tx(struct uart_8250_port *p)
>  		u16 lsr = serial_lsr_in(p);
>  		u64 stop_delay = 0;
>  
> -		p->lsr_saved_flags |= lsr & LSR_SAVE_FLAGS;
> -
>  		if (!(lsr & UART_LSR_THRE))
>  			return;
>  		/*

I don't know if Fixes tag is appropriate here. This fixes the mismerge 
yes, however, the removed line itself seems harmless so there's no real 
problem to fix.

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

-- 
 i.

--8323329-2127987035-1675337176=:2215--
