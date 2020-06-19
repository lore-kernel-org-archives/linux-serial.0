Return-Path: <SRS0=VMdU=AA=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EFFDC433E0
	for <linux-serial@archiver.kernel.org>; Fri, 19 Jun 2020 03:17:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19C572070A
	for <linux-serial@archiver.kernel.org>; Fri, 19 Jun 2020 03:17:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727869AbgFSDRy (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 18 Jun 2020 23:17:54 -0400
Received: from kernel.crashing.org ([76.164.61.194]:50180 "EHLO
        kernel.crashing.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726878AbgFSDRy (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 18 Jun 2020 23:17:54 -0400
Received: from localhost (gate.crashing.org [63.228.1.57])
        (authenticated bits=0)
        by kernel.crashing.org (8.14.7/8.14.7) with ESMTP id 05J3H8O5032301
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 18 Jun 2020 22:17:12 -0500
Message-ID: <412032fa04259cbb7f4d286b8346c551e370214a.camel@kernel.crashing.org>
Subject: Re: [PATCH v1 5/6] console: Propagate error code from console
 ->setup()
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org
Date:   Fri, 19 Jun 2020 13:17:07 +1000
In-Reply-To: <20200618164751.56828-6-andriy.shevchenko@linux.intel.com>
References: <20200618164751.56828-1-andriy.shevchenko@linux.intel.com>
         <20200618164751.56828-6-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, 2020-06-18 at 19:47 +0300, Andy Shevchenko wrote:
> Since console ->setup() hook returns meaningful error codes,
> propagate it to the caller of try_enable_new_console().
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

> ---A
>  kernel/printk/printk.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 8c14835be46c..aaea3ad182e1 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -2668,7 +2668,7 @@ early_param("keep_bootcon", keep_bootcon_setup);
>  static int try_enable_new_console(struct console *newcon, bool user_specified)
>  {
>  	struct console_cmdline *c;
> -	int i;
> +	int i, err;
>  
>  	for (i = 0, c = console_cmdline;
>  	     i < MAX_CMDLINECONSOLES && c->name[0];
> @@ -2691,8 +2691,8 @@ static int try_enable_new_console(struct console *newcon, bool user_specified)
>  				return 0;
>  
>  			if (newcon->setup &&
> -			    newcon->setup(newcon, c->options) != 0)
> -				return -EIO;
> +			    (err = newcon->setup(newcon, c->options)) != 0)
> +				return err;
>  		}
>  		newcon->flags |= CON_ENABLED;
>  		if (i == preferred_console) {

