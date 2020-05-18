Return-Path: <SRS0=kmSd=7A=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84BFEC433DF
	for <linux-serial@archiver.kernel.org>; Mon, 18 May 2020 16:46:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E688207D3
	for <linux-serial@archiver.kernel.org>; Mon, 18 May 2020 16:46:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wWxkOguP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728150AbgERQqY (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 18 May 2020 12:46:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726958AbgERQqU (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 18 May 2020 12:46:20 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 251BDC061A0C
        for <linux-serial@vger.kernel.org>; Mon, 18 May 2020 09:46:19 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id m12so208291wmc.0
        for <linux-serial@vger.kernel.org>; Mon, 18 May 2020 09:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XaV24d+FGuXsoW+r6zmum6BrLxcP3ZeN2pwU+1ivQEw=;
        b=wWxkOguPoVnStzrTdelQewSeyBV1QqIvNe/mvsavT8Pb1KrmxevazXje/h6LxNByaJ
         fnzOwnY4gm/kks+YfSM1/1rIh8VvOAvB8wWkH5E/ljWI/Zhvf3s0R3/ANKmH138lKTO7
         PNDcyJrK5DRbmfKoORdcOl5C+YI9wR2ga5eWq8kQvuscuObfSC1b4zlFeuYNc5Igs/1L
         9s8OhLXB+CcvtpazUXSRgojMi0JMiCfSu/y5NpJ18ASHBuHaSddyxdjWOiFtwUkCEX2F
         gHkKK9td1Y+P5TqZFGD2xwFYw1pusMTuGMCZKpaUwRJVycV7YEDI5Akm/qAPEkFw9GW2
         /OFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XaV24d+FGuXsoW+r6zmum6BrLxcP3ZeN2pwU+1ivQEw=;
        b=c5ZWScR8qs/OTrhSJri6tH9PlKUfA6fQ6M2k/cVy5Yy/MOAR/Pz9OnAZagVCekcxBT
         MQxAtHHpg1HlC38yW55XmvJNuxPH6CTlPZiwXg5pIHRl5YhU/h9m3DeZVG4wdftr/CFd
         xffcdNP7DlwBITy7Nxw+EKZoM2rpBU6Z2iZPAPd9Nf/eqpD3QIFuoQIy00LFKCJEUwfM
         70cKFr6Zw5XLTLhSC1QAbQ8aqYUEHUwRaCG5SU+ktrlrgcFlNUE5JSeBD4m7P2JCbKI+
         nqp6tufo+H7lFMDNOiVhVmN2X4ifAKhO7CCCyIMtLGDWBIpHpxkmEF1rieMqhAertR3u
         g7Bg==
X-Gm-Message-State: AOAM532MiVpZitR8IEYoUGYaTrCIMQvFicwydqxoORL9+Mx/I//lQQVe
        82jLrVUtBf2L3OAiq6Q5xFASOA==
X-Google-Smtp-Source: ABdhPJwKKpy9a5SB5stq/XXQkZqXfBSB6qShBoxgisxe8Pehf0STyszhmyKrLjtnSxt+2Hoe9cgxaA==
X-Received: by 2002:a1c:19c1:: with SMTP id 184mr237914wmz.29.1589820377683;
        Mon, 18 May 2020 09:46:17 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id r2sm17523254wrg.84.2020.05.18.09.46.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 09:46:17 -0700 (PDT)
Date:   Mon, 18 May 2020 17:46:15 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     jason.wessel@windriver.com, gregkh@linuxfoundation.org,
        corbet@lwn.net, frowand.list@gmail.com, bjorn.andersson@linaro.org,
        linux-serial@vger.kernel.org, mingo@redhat.com, hpa@zytor.com,
        jslaby@suse.com, kgdb-bugreport@lists.sourceforge.net,
        sumit.garg@linaro.org, will@kernel.org, tglx@linutronix.de,
        agross@kernel.org, catalin.marinas@arm.com, bp@alien8.de,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 03/12] kgdboc: Use a platform device to handle tty
 drivers showing up late
Message-ID: <20200518164615.xeqjvlg27evajzdx@holly.lan>
References: <20200507200850.60646-1-dianders@chromium.org>
 <20200507130644.v4.3.I4a493cfb0f9f740ce8fd2ab58e62dc92d18fed30@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200507130644.v4.3.I4a493cfb0f9f740ce8fd2ab58e62dc92d18fed30@changeid>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, May 07, 2020 at 01:08:41PM -0700, Douglas Anderson wrote:
> If you build CONFIG_KGDB_SERIAL_CONSOLE into the kernel then you
> should be able to have KGDB init itself at bootup by specifying the
> "kgdboc=..." kernel command line parameter.  This has worked OK for me
> for many years, but on a new device I switched to it stopped working.
> 
> The problem is that on this new device the serial driver gets its
> probe deferred.  Now when kgdb initializes it can't find the tty
> driver and when it gives up it never tries again.
> 
> We could try to find ways to move up the initialization of the serial
> driver and such a thing might be worthwhile, but it's nice to be
> robust against serial drivers that load late.  We could move kgdb to
> init itself later but that penalizes our ability to debug early boot
> code on systems where the driver inits early.  We could roll our own
> system of detecting when new tty drivers get loaded and then use that
> to figure out when kgdb can init, but that's ugly.
> 
> Instead, let's jump on the -EPROBE_DEFER bandwagon.  We'll create a
> singleton instance of a "kgdboc" platform device.  If we can't find
> our tty device when the singleton "kgdboc" probes we'll return
> -EPROBE_DEFER which means that the system will call us back later to
> try again when the tty device might be there.
> 
> We won't fully transition all of the kgdboc to a platform device
> because early kgdb initialization (via the "ekgdboc" kernel command
> line parameter) still runs before the platform device has been
> created.  The kgdb platform device is merely used as a convenient way
> to hook into the system's normal probe deferral mechanisms.
> 
> As part of this, we'll ever-so-slightly change how the "kgdboc=..."
> kernel command line parameter works.  Previously if you booted up and
> kgdb couldn't find the tty driver then later reading
> '/sys/module/kgdboc/parameters/kgdboc' would return a blank string.
> Now kgdb will keep track of the string that came as part of the
> command line and give it back to you.  It's expected that this should
> be an OK change.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
> ---
> 
> Changes in v4: None
> Changes in v3: None
> Changes in v2: None
> 
>  drivers/tty/serial/kgdboc.c | 126 +++++++++++++++++++++++++++++-------
>  1 file changed, 101 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/tty/serial/kgdboc.c b/drivers/tty/serial/kgdboc.c
> index 8a1a4d1b6768..519d8cfbfbed 100644
> --- a/drivers/tty/serial/kgdboc.c
> +++ b/drivers/tty/serial/kgdboc.c
> @@ -20,6 +20,7 @@
>  #include <linux/vt_kern.h>
>  #include <linux/input.h>
>  #include <linux/module.h>
> +#include <linux/platform_device.h>
>  
>  #define MAX_CONFIG_LEN		40
>  
> @@ -27,6 +28,7 @@ static struct kgdb_io		kgdboc_io_ops;
>  
>  /* -1 = init not run yet, 0 = unconfigured, 1 = configured. */
>  static int configured		= -1;
> +DEFINE_MUTEX(config_mutex);

Sparse gently pointed out to me that this should be static. Don't
worry about it though... I will fixup.


Daniel.

>  
>  static char config[MAX_CONFIG_LEN];
>  static struct kparam_string kps = {
> @@ -38,6 +40,8 @@ static int kgdboc_use_kms;  /* 1 if we use kernel mode switching */
>  static struct tty_driver	*kgdb_tty_driver;
>  static int			kgdb_tty_line;
>  
> +static struct platform_device *kgdboc_pdev;
> +
>  #ifdef CONFIG_KDB_KEYBOARD
>  static int kgdboc_reset_connect(struct input_handler *handler,
>  				struct input_dev *dev,
> @@ -133,11 +137,13 @@ static void kgdboc_unregister_kbd(void)
>  
>  static void cleanup_kgdboc(void)
>  {
> +	if (configured != 1)
> +		return;
> +
>  	if (kgdb_unregister_nmi_console())
>  		return;
>  	kgdboc_unregister_kbd();
> -	if (configured == 1)
> -		kgdb_unregister_io_module(&kgdboc_io_ops);
> +	kgdb_unregister_io_module(&kgdboc_io_ops);
>  }
>  
>  static int configure_kgdboc(void)
> @@ -198,20 +204,79 @@ static int configure_kgdboc(void)
>  	kgdb_unregister_io_module(&kgdboc_io_ops);
>  noconfig:
>  	kgdboc_unregister_kbd();
> -	config[0] = 0;
>  	configured = 0;
> -	cleanup_kgdboc();
>  
>  	return err;
>  }
>  
> +static int kgdboc_probe(struct platform_device *pdev)
> +{
> +	int ret = 0;
> +
> +	mutex_lock(&config_mutex);
> +	if (configured != 1) {
> +		ret = configure_kgdboc();
> +
> +		/* Convert "no device" to "defer" so we'll keep trying */
> +		if (ret == -ENODEV)
> +			ret = -EPROBE_DEFER;
> +	}
> +	mutex_unlock(&config_mutex);
> +
> +	return ret;
> +}
> +
> +static struct platform_driver kgdboc_platform_driver = {
> +	.probe = kgdboc_probe,
> +	.driver = {
> +		.name = "kgdboc",
> +		.suppress_bind_attrs = true,
> +	},
> +};
> +
>  static int __init init_kgdboc(void)
>  {
> -	/* Already configured? */
> -	if (configured == 1)
> +	int ret;
> +
> +	/*
> +	 * kgdboc is a little bit of an odd "platform_driver".  It can be
> +	 * up and running long before the platform_driver object is
> +	 * created and thus doesn't actually store anything in it.  There's
> +	 * only one instance of kgdb so anything is stored as global state.
> +	 * The platform_driver is only created so that we can leverage the
> +	 * kernel's mechanisms (like -EPROBE_DEFER) to call us when our
> +	 * underlying tty is ready.  Here we init our platform driver and
> +	 * then create the single kgdboc instance.
> +	 */
> +	ret = platform_driver_register(&kgdboc_platform_driver);
> +	if (ret)
> +		return ret;
> +
> +	kgdboc_pdev = platform_device_alloc("kgdboc", PLATFORM_DEVID_NONE);
> +	if (!kgdboc_pdev) {
> +		ret = -ENOMEM;
> +		goto err_did_register;
> +	}
> +
> +	ret = platform_device_add(kgdboc_pdev);
> +	if (!ret)
>  		return 0;
>  
> -	return configure_kgdboc();
> +	platform_device_put(kgdboc_pdev);
> +
> +err_did_register:
> +	platform_driver_unregister(&kgdboc_platform_driver);
> +	return ret;
> +}
> +
> +static void exit_kgdboc(void)
> +{
> +	mutex_lock(&config_mutex);
> +	cleanup_kgdboc();
> +	mutex_unlock(&config_mutex);
> +
> +	platform_device_unregister(kgdboc_pdev);
> +	platform_driver_unregister(&kgdboc_platform_driver);
>  }
>  
>  static int kgdboc_get_char(void)
> @@ -234,24 +299,20 @@ static int param_set_kgdboc_var(const char *kmessage,
>  				const struct kernel_param *kp)
>  {
>  	size_t len = strlen(kmessage);
> +	int ret = 0;
>  
>  	if (len >= MAX_CONFIG_LEN) {
>  		pr_err("config string too long\n");
>  		return -ENOSPC;
>  	}
>  
> -	/* Only copy in the string if the init function has not run yet */
> -	if (configured < 0) {
> -		strcpy(config, kmessage);
> -		return 0;
> -	}
> -
>  	if (kgdb_connected) {
>  		pr_err("Cannot reconfigure while KGDB is connected.\n");
> -
>  		return -EBUSY;
>  	}
>  
> +	mutex_lock(&config_mutex);
> +
>  	strcpy(config, kmessage);
>  	/* Chop out \n char as a result of echo */
>  	if (len && config[len - 1] == '\n')
> @@ -260,8 +321,30 @@ static int param_set_kgdboc_var(const char *kmessage,
>  	if (configured == 1)
>  		cleanup_kgdboc();
>  
> -	/* Go and configure with the new params. */
> -	return configure_kgdboc();
> +	/*
> +	 * Configure with the new params as long as init already ran.
> +	 * Note that we can get called before init if someone loads us
> +	 * with "modprobe kgdboc kgdboc=..." or if they happen to use the
> +	 * the odd syntax of "kgdboc.kgdboc=..." on the kernel command.
> +	 */
> +	if (configured >= 0)
> +		ret = configure_kgdboc();
> +
> +	/*
> +	 * If we couldn't configure then clear out the config.  Note that
> +	 * specifying an invalid config on the kernel command line vs.
> +	 * through sysfs have slightly different behaviors.  If we fail
> +	 * to configure what was specified on the kernel command line
> +	 * we'll leave it in the 'config' and return -EPROBE_DEFER from
> +	 * our probe.  When specified through sysfs userspace is
> +	 * responsible for loading the tty driver before setting up.
> +	 */
> +	if (ret)
> +		config[0] = '\0';
> +
> +	mutex_unlock(&config_mutex);
> +
> +	return ret;
>  }
>  
>  static int dbg_restore_graphics;
> @@ -320,15 +403,8 @@ __setup("kgdboc=", kgdboc_option_setup);
>  /* This is only available if kgdboc is a built in for early debugging */
>  static int __init kgdboc_early_init(char *opt)
>  {
> -	/* save the first character of the config string because the
> -	 * init routine can destroy it.
> -	 */
> -	char save_ch;
> -
>  	kgdboc_option_setup(opt);
> -	save_ch = config[0];
> -	init_kgdboc();
> -	config[0] = save_ch;
> +	configure_kgdboc();
>  	return 0;
>  }
>  
> @@ -336,7 +412,7 @@ early_param("ekgdboc", kgdboc_early_init);
>  #endif /* CONFIG_KGDB_SERIAL_CONSOLE */
>  
>  module_init(init_kgdboc);
> -module_exit(cleanup_kgdboc);
> +module_exit(exit_kgdboc);
>  module_param_call(kgdboc, param_set_kgdboc_var, param_get_string, &kps, 0644);
>  MODULE_PARM_DESC(kgdboc, "<serial_device>[,baud]");
>  MODULE_DESCRIPTION("KGDB Console TTY Driver");
> -- 
> 2.26.2.645.ge9eca65c58-goog
> 
