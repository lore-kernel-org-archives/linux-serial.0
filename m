Return-Path: <SRS0=H5Pf=3U=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17ADBC2D0DB
	for <linux-serial@archiver.kernel.org>; Fri, 31 Jan 2020 17:01:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC408206F0
	for <linux-serial@archiver.kernel.org>; Fri, 31 Jan 2020 17:01:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="re5ejHSN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726322AbgAaRBH (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 31 Jan 2020 12:01:07 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53204 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbgAaRBH (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 31 Jan 2020 12:01:07 -0500
Received: by mail-wm1-f66.google.com with SMTP id p9so8737580wmc.2
        for <linux-serial@vger.kernel.org>; Fri, 31 Jan 2020 09:01:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AX+Stoo32gMWwyifE5JONfx++iU4SnwDLz4NN+dPlIo=;
        b=re5ejHSNML/rK9qA56QTC009nNz/VmKwsOkNkf7FFmN2zit4i3WAJ/XQeCggffr2hY
         yhGvXpY014nBIgPsPBfwowA/oGaTTJ+PFP+YOip8lDxldG8N5ap4pTzSQExDSnNRCMXK
         Al/6UhJlDnVIlI6l3JAegj0qQryDZqCZT3kgRnFUzMtW2UMfozijaXSii3pqZqFhEFDo
         mFRp2HTo/wQEAWZP8JRM4bHc3hqFFSGL3d+ziUwEafagCzz4vI/GIWEq+636EjyNJXyb
         5JomjoB9Vhw8lW91zZxisVbRozh0aX/o3anwiYjvuWKyE+0IqBOXb4vyw92n5ChXHmBZ
         Dv+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AX+Stoo32gMWwyifE5JONfx++iU4SnwDLz4NN+dPlIo=;
        b=MYjNGJo1YhoMrce+gbMQYVa7PgrWqQxsYN0Kg2jnas74DQfkgurleI0+Kc42/mkYOi
         Ya9MjI5t75Wc9m+fXYvKmDcL9oF2qJnEBnWBH6eU57yd9XRH9HO6G3DmxQ9jLAPwfQPm
         bdFKbDlyY1Bfd3BECz+C1bmohloaA0ck4ywgGcEoLCcIaEg4yjQsdlmq0jTRCeO/heYz
         fcQZxQUdfYZU+UpU+SSDS2hI3wkkm3a4t2/ij5dYIjIUaFS5sggx4eUJQnUPO44QNIQa
         +C45AdgtwJKcPFgDTi4pWwmGB2Q+guSlebfCTev+lHN5gw5lxrPTjExltO+gixuEQ+d7
         fYKQ==
X-Gm-Message-State: APjAAAVpv/eEUEMB5eDi9EJRF80S26oopdusvTYf4CSzkj3gqtXoeKIK
        i7T5Vs+O407LeTYF1Jqbeditv1uyxRfYIg==
X-Google-Smtp-Source: APXvYqy1CAKfYEEhKGiHPcnFfXiufrbyb/HqRVC8rm5R+aHZkPH2rAdRbJ829UdYzYGCm2by9d1AeQ==
X-Received: by 2002:a1c:9c87:: with SMTP id f129mr13602350wme.26.1580490063549;
        Fri, 31 Jan 2020 09:01:03 -0800 (PST)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id g21sm11587709wmh.17.2020.01.31.09.01.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2020 09:01:02 -0800 (PST)
Date:   Fri, 31 Jan 2020 17:01:01 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Jason Wessel <jason.wessel@windriver.com>,
        kgdb-bugreport@lists.sourceforge.net,
        Douglas Anderson <dianders@chromium.org>,
        linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v1] kgdboc: Use for_each_console() helper
Message-ID: <20200131170101.zjhu2xilrpm6wotz@holly.lan>
References: <20200124161132.65519-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200124161132.65519-1-andriy.shevchenko@linux.intel.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Jan 24, 2020 at 06:11:32PM +0200, Andy Shevchenko wrote:
> Replace open coded single-linked list iteration loop with for_each_console()
> helper in use.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Acked-by: Daniel Thompson <daniel.thompson@linaro.org>

> ---
>  drivers/tty/serial/kgdboc.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/tty/serial/kgdboc.c b/drivers/tty/serial/kgdboc.c
> index c7d51b51898f..c9f94fa82be4 100644
> --- a/drivers/tty/serial/kgdboc.c
> +++ b/drivers/tty/serial/kgdboc.c
> @@ -169,15 +169,13 @@ static int configure_kgdboc(void)
>  	if (!p)
>  		goto noconfig;
>  
> -	cons = console_drivers;
> -	while (cons) {
> +	for_each_console(cons) {
>  		int idx;
>  		if (cons->device && cons->device(cons, &idx) == p &&
>  		    idx == tty_line) {
>  			kgdboc_io_ops.is_console = 1;
>  			break;
>  		}
> -		cons = cons->next;
>  	}
>  
>  	kgdb_tty_driver = p;
> -- 
> 2.24.1
> 
