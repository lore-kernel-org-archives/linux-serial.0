Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABF07C04A6A
	for <linux-serial@archiver.kernel.org>; Wed, 16 Aug 2023 14:22:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343544AbjHPOV6 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 16 Aug 2023 10:21:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343563AbjHPOVb (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 16 Aug 2023 10:21:31 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D0042705;
        Wed, 16 Aug 2023 07:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692195690; x=1723731690;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=uYNnrWNlBgb9NC8j+cpeuVgiEEZ6uB4cvWrMtU2oYm4=;
  b=Nd8u6XQ7z1RK5bc4WSbzHjkgou8mAcUbJ8CTkn5ur9KuXbBMxhraBXal
   u9McnvjK89ZCCp8+Md9+hb8Oy5ObwNRitK5qJNAIZ3hMEEzZNn7huZVkR
   zS5fvC4nbFNCN0QVlFbAJwgy6RQvCoZZtqAZ78yBNP66vJ/arbSiWRhlb
   72qolizpDw2IKx6qsoQt5ktRKIOYk5endDdtVleBcnt20sXPvJ2/U9Bdo
   9rKU9++1uvWokWYX/cthcu/MTLG8foONue4+S5HuqH8CrSXXDAj05jdQ9
   Xvyh6P5cJ5BVn6+Er5rYT5c3uoxsA4AcS28lhLCGlceD1B1Ug6fNxWTfL
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="352134018"
X-IronPort-AV: E=Sophos;i="6.01,177,1684825200"; 
   d="scan'208";a="352134018"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2023 07:21:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="980756995"
X-IronPort-AV: E=Sophos;i="6.01,177,1684825200"; 
   d="scan'208";a="980756995"
Received: from ilivshiz-mobl.ger.corp.intel.com ([10.251.211.105])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2023 07:21:28 -0700
Date:   Wed, 16 Aug 2023 17:21:26 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
cc:     gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/14] tty: n_tty: use 'retval' for writes' retvals
In-Reply-To: <20230816105822.3685-7-jirislaby@kernel.org>
Message-ID: <b0771d71-dff4-31d-7edb-01056d4c29@linux.intel.com>
References: <20230816105822.3685-1-jirislaby@kernel.org> <20230816105822.3685-7-jirislaby@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, 16 Aug 2023, Jiri Slaby (SUSE) wrote:

> We have a separate misnomer 'c' to hold the retuned value from
> tty->ops->write(). Instead, use already defined and properly typed
> 'retval'.
> 
> We have another variable 'num' to serve the same purpose in the OPOST
> branch. We can use this 'retval' too. But just clear it in case of
> EAGAIN.
> 
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> ---
>  drivers/tty/n_tty.c | 30 ++++++++++++++----------------
>  1 file changed, 14 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
> index f6fa4dbdf78f..e293d87b5362 100644
> --- a/drivers/tty/n_tty.c
> +++ b/drivers/tty/n_tty.c
> @@ -2335,7 +2335,6 @@ static ssize_t n_tty_write(struct tty_struct *tty, struct file *file,
>  {
>  	const u8 *b = buf;
>  	DEFINE_WAIT_FUNC(wait, woken_wake_function);
> -	int c;
>  	ssize_t retval = 0;
>  
>  	/* Job control check -- must be done at start (POSIX.1 7.1.1.4). */
> @@ -2362,15 +2361,16 @@ static ssize_t n_tty_write(struct tty_struct *tty, struct file *file,
>  		}
>  		if (O_OPOST(tty)) {
>  			while (nr > 0) {
> -				ssize_t num = process_output_block(tty, b, nr);
> -				if (num < 0) {
> -					if (num == -EAGAIN)
> -						break;
> -					retval = num;
> -					goto break_out;
> +				retval = process_output_block(tty, b, nr);
> +				if (retval == -EAGAIN) {
> +					retval = 0;
> +					break;
>  				}
> -				b += num;
> -				nr -= num;
> +				if (retval < 0)
> +					goto break_out;
> +
> +				b += retval;
> +				nr -= retval;
>  				if (nr == 0)
>  					break;
>  				if (process_output(*b, tty) < 0)
> @@ -2384,16 +2384,14 @@ static ssize_t n_tty_write(struct tty_struct *tty, struct file *file,
>  
>  			while (nr > 0) {
>  				mutex_lock(&ldata->output_lock);
> -				c = tty->ops->write(tty, b, nr);
> +				retval = tty->ops->write(tty, b, nr);
>  				mutex_unlock(&ldata->output_lock);
> -				if (c < 0) {
> -					retval = c;
> +				if (retval < 0)
>  					goto break_out;
> -				}
> -				if (!c)
> +				if (!retval)
>  					break;
> -				b += c;
> -				nr -= c;
> +				b += retval;
> +				nr -= retval;

Type might be better but these two don't look like a major improvement... 
To me it seems obvious there exists some variable name that is better than 
c or retval for this purpose. ;-)

-- 
 i.

