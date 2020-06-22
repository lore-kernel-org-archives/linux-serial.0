Return-Path: <SRS0=XDGD=AD=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0205C433DF
	for <linux-serial@archiver.kernel.org>; Mon, 22 Jun 2020 16:03:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C99D2074D
	for <linux-serial@archiver.kernel.org>; Mon, 22 Jun 2020 16:03:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OFzgfBlw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729887AbgFVQDF (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 22 Jun 2020 12:03:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729873AbgFVQDE (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 22 Jun 2020 12:03:04 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2271FC061797
        for <linux-serial@vger.kernel.org>; Mon, 22 Jun 2020 09:03:04 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id x16so112389wmj.1
        for <linux-serial@vger.kernel.org>; Mon, 22 Jun 2020 09:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=G7tyEQo0BCpuFpa+wLLnML4BSViFafq4hYNcPsQY6yA=;
        b=OFzgfBlwCkrOzvIyVR98+1/FXds75qvrmXjxqkeiZis2MHuM8t8xekOzHXDkzHuUqC
         /Um6dZ6t4Srg/Fp14boWWHax79dKiFmIXrhDSdg8YDHvC8v2X46ysLHrIqLc49O3yk9v
         g4GxaTx1Hr78vxDccYzfFtECXgXqX1pOyPLoVzuHjWHax5i8FNFSYgOjRmkBoSzvoPVx
         XED1CZ5vMKFHce07Ux4WKGnUSF5k2sMmuddM43Ab1B4iGGnPLHMWo4w5jJUdbh43V0nD
         vSTgBCy/aJDKy9zjT6fEMZ1n9SGFXHZd5sC9LdGsI7hzu2crXDasuj1vY44cIQm7vTNE
         sCmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=G7tyEQo0BCpuFpa+wLLnML4BSViFafq4hYNcPsQY6yA=;
        b=nLHZ0pbk14sy4p4FfklCXtZeBMlswjAxTPhbhD2Zqki9RJ4nVcTi4eSndr1H8VwzXv
         2bERQLTkJSLS1Obxp/j3hCucAQZuMEC3XxR2ekZCj+ELriFu+zGSgK+CCvwm+D4OTVS1
         4p/hqYL3iUgwzQmE9KooCUzLhi3pDbM2FWHc4RkW+yJpViwjKEzfpEVLl9CsLIiGpMHo
         AmAtmKCg4g53Q0g2FjGFWa9NDfPb3SltoXF0EfIeSasouZ8F07wq8BzvNt4dpZ0TXsXf
         gRlMWBASv7O2KjkkdVdd0s5spU3vLRpevP54hps3P1cNTBI5z7SEmw6pwO7rjX3Txw0g
         vgDA==
X-Gm-Message-State: AOAM530oRjHzmc45aRqQAWV9ylnEH17cKkL7SERWW68QbQiY0kGzI9oa
        iB1gGIKfzraIYJWSS3ng+SLwnA==
X-Google-Smtp-Source: ABdhPJwTHUBPzo//TrGs0VsDrKoOp6hfyS3KNMezVrR1B8EvnSENYTaLkUxTvt8cK17P23kZv45cqA==
X-Received: by 2002:a05:600c:2201:: with SMTP id z1mr18818319wml.70.1592841782682;
        Mon, 22 Jun 2020 09:03:02 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id j18sm18502577wrn.59.2020.06.22.09.03.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 09:03:02 -0700 (PDT)
Date:   Mon, 22 Jun 2020 17:03:00 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     kgdb-bugreport@lists.sourceforge.net, linux-serial@vger.kernel.org,
        gregkh@linuxfoundation.org, jason.wessel@windriver.com,
        dianders@chromium.org, jslaby@suse.com, linux@armlinux.org.uk,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/7] kgdb: Add request_nmi() to the io ops table for
 kgdboc
Message-ID: <20200622160300.avgfhnfkpqzqqtsr@holly.lan>
References: <1592835984-28613-1-git-send-email-sumit.garg@linaro.org>
 <1592835984-28613-4-git-send-email-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1592835984-28613-4-git-send-email-sumit.garg@linaro.org>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Jun 22, 2020 at 07:56:20PM +0530, Sumit Garg wrote:
> From: Daniel Thompson <daniel.thompson@linaro.org>
> 
> Add request_nmi() callback to install a non-maskable interrupt handler
> corresponding to IRQ retrieved from polling interface. If NMI handler
> installation fails due to missing support from underlying irqchip driver
> then fallback to install it as normal interrupt handler.
> 
> Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
> Co-developed-by: Sumit Garg <sumit.garg@linaro.org>
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> ---
>  drivers/tty/serial/kgdboc.c | 35 +++++++++++++++++++++++++++++++++++
>  include/linux/kgdb.h        |  7 +++++++
>  2 files changed, 42 insertions(+)
> 
> diff --git a/drivers/tty/serial/kgdboc.c b/drivers/tty/serial/kgdboc.c
> index 84ffede..263afae 100644
> --- a/drivers/tty/serial/kgdboc.c
> +++ b/drivers/tty/serial/kgdboc.c
> @@ -19,6 +19,9 @@
>  #include <linux/console.h>
>  #include <linux/vt_kern.h>
>  #include <linux/input.h>
> +#include <linux/interrupt.h>
> +#include <linux/irq.h>
> +#include <linux/irqdesc.h>
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
>  #include <linux/serial_core.h>
> @@ -390,12 +393,44 @@ static void kgdboc_post_exp_handler(void)
>  	kgdboc_restore_input();
>  }
>  
> +static int kgdb_tty_irq;
> +
> +static int kgdboc_request_nmi(irq_handler_t fn, void *dev_id)
> +{
> +	int irq, res;
> +
> +	/* Better to avoid double allocation in the tty driver! */
> +	if (kgdb_tty_irq)
> +		return 0;
> +
> +	if (!kgdb_tty_driver->ops->poll_get_irq)
> +		return -ENODEV;
> +
> +	irq =
> +	    kgdb_tty_driver->ops->poll_get_irq(kgdb_tty_driver, kgdb_tty_line);
> +	if (irq <= 0)
> +		return irq ? irq : -ENODEV;
> +
> +	irq_set_status_flags(irq, IRQ_NOAUTOEN);
> +	res = request_nmi(irq, fn, IRQF_PERCPU, "kgdboc", dev_id);

Why do we need IRQF_PERCPU here. A UART interrupt is not normally
per-cpu?


> +	if (res) {
> +		res = request_irq(irq, fn, IRQF_SHARED, "kgdboc", dev_id);

IRQF_SHARED?

Currrently there is nothing that prevents concurrent activation of
ttyNMI0 and the underlying serial driver. Using IRQF_SHARED means it
becomes possible for both drivers to try to service the same interrupt.
That risks some rather "interesting" problems.


Daniel.


> +		WARN_ON(res);
> +	}
> +
> +	enable_irq(irq);
> +
> +	kgdb_tty_irq = irq;
> +	return 0;
> +}
> +
>  static struct kgdb_io kgdboc_io_ops = {
>  	.name			= "kgdboc",
>  	.read_char		= kgdboc_get_char,
>  	.write_char		= kgdboc_put_char,
>  	.pre_exception		= kgdboc_pre_exp_handler,
>  	.post_exception		= kgdboc_post_exp_handler,
> +	.request_nmi		= kgdboc_request_nmi,
>  };
>  
>  #if IS_BUILTIN(CONFIG_KGDB_SERIAL_CONSOLE)
> diff --git a/include/linux/kgdb.h b/include/linux/kgdb.h
> index 529116b..b32b044 100644
> --- a/include/linux/kgdb.h
> +++ b/include/linux/kgdb.h
> @@ -16,6 +16,7 @@
>  #include <linux/linkage.h>
>  #include <linux/init.h>
>  #include <linux/atomic.h>
> +#include <linux/interrupt.h>
>  #ifdef CONFIG_HAVE_ARCH_KGDB
>  #include <asm/kgdb.h>
>  #endif
> @@ -276,6 +277,10 @@ struct kgdb_arch {
>   * the I/O driver.
>   * @post_exception: Pointer to a function that will do any cleanup work
>   * for the I/O driver.
> + * @request_nmi: Pointer to a function that can install an non-maskable
> + * interrupt handler that will be called when a character is pending and that
> + * can be cleared by calling @read_char until it returns NO_POLL_CHAR. If NMI
> + * installation fails then fallback to install normal interrupt handler.
>   * @cons: valid if the I/O device is a console; else NULL.
>   */
>  struct kgdb_io {
> @@ -287,6 +292,8 @@ struct kgdb_io {
>  	void			(*deinit) (void);
>  	void			(*pre_exception) (void);
>  	void			(*post_exception) (void);
> +	int			(*request_nmi)(irq_handler_t nmi_handler,
> +					       void *dev_id);
>  	struct console		*cons;
>  };
>  
> -- 
> 2.7.4
> 
