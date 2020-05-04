Return-Path: <SRS0=QloM=6S=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A99BC3A5A9
	for <linux-serial@archiver.kernel.org>; Mon,  4 May 2020 14:13:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FD2420757
	for <linux-serial@archiver.kernel.org>; Mon,  4 May 2020 14:13:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OtcfT3Xm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728486AbgEDONT (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 4 May 2020 10:13:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728233AbgEDONT (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 4 May 2020 10:13:19 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 277C1C061A0F
        for <linux-serial@vger.kernel.org>; Mon,  4 May 2020 07:13:19 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id g13so21101634wrb.8
        for <linux-serial@vger.kernel.org>; Mon, 04 May 2020 07:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gg7NmM+Hl82lwFdgF23a7OUMDRxdbsm38gnonOFK+XM=;
        b=OtcfT3XmsZeMwk96Rl8rcxQGQ20k09Xulay6gvzipRn3NlRcQkFrbMfWOFPwWD0Udp
         KUxpQ9mpkVnLl4IJpDjdeAFyb7QY1Ztvksf88s71NjcGcFHwGDo3y2eI46Qem/VL545D
         DW1FadNzvOBtVQlPAoFy7v3ZePPe70S17W6p8017ITbzBYHGTYL2oVqGSrOj6Oj8kxNG
         0ctCirWtHZ/lM9u/cbRbG9gzO/ciEm8TLv7S3p5GoZTuhyoHcisnTuDIPOzvPuOAMENe
         10hqktoKB3Thb9hLD9lPf8eUJRAWkyCBvP+JEjye4H+fZN3qPIBF7BVh0WebTFVR1YFs
         7m0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gg7NmM+Hl82lwFdgF23a7OUMDRxdbsm38gnonOFK+XM=;
        b=qaQCFMwnsLNec0oWa2SvybtkVS2SO63qES38TFdi7FT7m2l8JfJyqX6BdvK41HoxgU
         akCc1kzMxFdpmF0OZzVTcwyXxaiViMi67jSmRLa2L1ySB8X2Tdbik5dxedyEFuhOKYpN
         UXOf5bANvC2ixQsAo+BD0mMKo81MlK+rdcNkFm6yjQcD95hOLwjqP0Jy7Im7oU0ZDgDx
         sZ7Et2Cr0rLKaMiao7J7Qyxxe9llL2b+jrZRFdvvy7vNY9lh58eVajpayXwtpB/Kg1LZ
         cXVotmhePw/vbM5z5goQBS0G3YdILvLOlqcZbw1vItdp3ua2XNcrXZtcT27zvHA61tjk
         O6+A==
X-Gm-Message-State: AGi0Puay+AQOyTGdK5+9Ximy713MudvZ9EAzMcz2tPC3KtH7rPyCAhH4
        wW9kfjBixq5LElb5Y7twMom16QvhsAnYXQ==
X-Google-Smtp-Source: APiQypIOX7rEevV8DV08zsAzTwALQGpi+aP6uOBbCyr7RezF9Vt+lnOQuBRpDbnD1Wdb4rh7Uri8gQ==
X-Received: by 2002:adf:b246:: with SMTP id y6mr19864355wra.205.1588601597742;
        Mon, 04 May 2020 07:13:17 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id q187sm13437406wma.41.2020.05.04.07.13.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 07:13:17 -0700 (PDT)
Date:   Mon, 4 May 2020 15:13:15 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     jason.wessel@windriver.com, gregkh@linuxfoundation.org,
        agross@kernel.org, kgdb-bugreport@lists.sourceforge.net,
        catalin.marinas@arm.com, linux-serial@vger.kernel.org,
        sumit.garg@linaro.org, corbet@lwn.net, mingo@redhat.com,
        will@kernel.org, hpa@zytor.com, tglx@linutronix.de,
        frowand.list@gmail.com, bp@alien8.de, bjorn.andersson@linaro.org,
        jslaby@suse.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 07/11] kgdboc: Add kgdboc_earlycon to support early
 kgdb using boot consoles
Message-ID: <20200504141315.oo7uxb6y75l6tv32@holly.lan>
References: <20200428211351.85055-1-dianders@chromium.org>
 <20200428141218.v3.7.I8fba5961bf452ab92350654aa61957f23ecf0100@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200428141218.v3.7.I8fba5961bf452ab92350654aa61957f23ecf0100@changeid>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Apr 28, 2020 at 02:13:47PM -0700, Douglas Anderson wrote:
> We want to enable kgdb to debug the early parts of the kernel.
> Unfortunately kgdb normally is a client of the tty API in the kernel
> and serial drivers don't register to the tty layer until fairly late
> in the boot process.
> 
> Serial drivers do, however, commonly register a boot console.  Let's
> enable the kgdboc driver to work with boot consoles to provide early
> debugging.
> 
> This change co-opts the existing read() function pointer that's part
> of "struct console".  It's assumed that if a boot console (with the
> flag CON_BOOT) has implemented read() that both the read() and write()
> function are polling functions.  That means they work without
> interrupts and read() will return immediately (with 0 bytes read) if
> there's nothing to read.  This should be a safe assumption since it
> appears that no current boot consoles implement read() right now and
> there seems no reason to do so unless they wanted to support
> "kgdboc_earlycon".
> 
> The console API isn't really intended to have clients work with it
> like we're doing.  Specifically there doesn't appear to be any way for
> clients to be notified about a boot console being unregistered.  We'll
> work around this by checking that our console is still valid before
> using it.  We'll also try to transition off of the boot console and
> onto the "tty" API as quickly as possible.
> 
> The normal/expected way to make all this work is to use
> "kgdboc_earlycon" and "kgdboc" together.  You should point them both
> to the same physical serial connection.  At boot time, as the system
> transitions from the boot console to the normal console, kgdb will
> switch over.  If you don't use things in the normal/expected way it's
> a bit of a buyer-beware situation.  Things thought about:
> 
> - If you specify only "kgdboc_earlycon" but not "kgdboc" and the boot
>   console vanishes at a weird time we'll panic if someone tries to
>   drop into kgdb.
> - If you use "keep_bootcon" (which is already a bit of a buyer-beware
>   option) and specify "kgdboc_earlycon" but not "kgdboc" we'll keep
>   trying to use your boot console for kgdb.
> - If your "kgdboc_earlycon" and "kgdboc" devices are not the same
>   device things should work OK, but it'll be your job to switch over
>   which device you're monitoring (including figuring out how to switch
>   over gdb in-flight if you're using it).

As mentioned in other threads. If we are changing the way we manage the
lifetime of the consoles I think it would be good to squash that change
down and simplify some of these cases.


> When trying to enable "kgdboc_earlycon" it should be noted that the
> names that are registered through the boot console layer and the tty
> layer are not the same for the same port.  For example when debugging
> on one board I'd need to pass "kgdboc_earlycon=qcom_geni
> kgdboc=ttyMSM0" to enable things properly.  Since digging up the boot
> console name is a pain and there will rarely be more than one boot
> console enabled, you can provide the "kgdboc_earlycon" parameter
> without specifying the name of the boot console.  In this case we'll
> just pick the first boot that implements read() that we find.
> 
> This new "kgdboc_earlycon" parameter should be contrasted to the
> existing "ekgdboc" parameter.  While both provide a way to debug very
> early, the usage and mechanisms are quite different.  Specifically
> "kgdboc_earlycon" is meant to be used in tandem with "kgdboc" and
> there is a transition from one to the other.  The "ekgdboc" parameter,
> on the other hand, replaces the "kgdboc" parameter.  It runs the same
> logic as the "kgdboc" parameter but just relies on your TTY driver
> being present super early.  The only known usage of the old "ekgdboc"
> parameter is documented as "ekgdboc=kbd earlyprintk=vga".  It should
> be noted that "kbd" has special treatment allowing it to init early as
> a tty device.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Tested-by: Sumit Garg <sumit.garg@linaro.org>
> ---
> I have kept Greg's Reviewed-by and Sumit's Tested-by tags on this
> commit despite changes that aren't totally trivial.  Please yell if
> you disagree with this.  Reasons:
> - Greg's Reviewed-by seemed more an overall acknowledgment that the
>   series wasn't totally insane rather than a detailed review.  I don't
>   think the changes from v2 to v3 change that.
> - Sumit's Tested-by seemed useful as confirmation that someone else
>   made this work on a machine that wasn't mine.  I don't believe that
>   the changes from v2 to v3 should affect anything here.
> 
> Changes in v3:
> - Add deinit() to I/O ops to know a driver can be replaced.
> - Don't just neuter input, panic if earlycon vanishes.
> - No extra param to kgdb_register_io_module().
> - Renamed earlycon_kgdboc to kgdboc_earlycon.
> - Simplify earlycon_kgdb deinit by using the deinit() function.
> 
> Changes in v2:
> - Assumes we have ("kgdb: Disable WARN_CONSOLE_UNLOCKED for all kgdb")
> - Fix kgdbts, tty/mips_ejtag_fdc, and usb/early/ehci-dbgp
> 
>  drivers/tty/serial/kgdboc.c | 136 ++++++++++++++++++++++++++++++++++++
>  include/linux/kgdb.h        |   4 ++
>  kernel/debug/debug_core.c   |  23 ++++--
>  3 files changed, 159 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/tty/serial/kgdboc.c b/drivers/tty/serial/kgdboc.c
> index 519d8cfbfbed..7aca0a67fc0b 100644
> --- a/drivers/tty/serial/kgdboc.c
> +++ b/drivers/tty/serial/kgdboc.c
> @@ -21,6 +21,7 @@
>  #include <linux/input.h>
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
> +#include <linux/serial_core.h>
>  
>  #define MAX_CONFIG_LEN		40
>  
> @@ -42,6 +43,13 @@ static int			kgdb_tty_line;
>  
>  static struct platform_device *kgdboc_pdev;
>  
> +#ifdef CONFIG_KGDB_SERIAL_CONSOLE

Isn't this always set for this file (see Makefile)?

I think all the instances of this check (and the diligent
#else clauses are redundant).

> +static struct kgdb_io		kgdboc_earlycon_io_ops;
> +struct console			*earlycon;

static?


> <snip>
> diff --git a/include/linux/kgdb.h b/include/linux/kgdb.h
> index b072aeb1fd78..77a3c519478a 100644
> --- a/include/linux/kgdb.h
> +++ b/include/linux/kgdb.h
> @@ -1075,15 +1075,21 @@ EXPORT_SYMBOL_GPL(kgdb_schedule_breakpoint);
>   */
>  int kgdb_register_io_module(struct kgdb_io *new_dbg_io_ops)
>  {
> +	struct kgdb_io *old_dbg_io_ops;
>  	int err;
>  
>  	spin_lock(&kgdb_registration_lock);
>  
> -	if (dbg_io_ops) {
> -		spin_unlock(&kgdb_registration_lock);
> +	old_dbg_io_ops = dbg_io_ops;
> +	if (old_dbg_io_ops) {
> +		if (!old_dbg_io_ops->deinit) {
> +			spin_unlock(&kgdb_registration_lock);
>  
> -		pr_err("Another I/O driver is already registered with KGDB\n");
> -		return -EBUSY;
> +			pr_err("KGDB I/O driver %s can't replace %s.\n",
> +				new_dbg_io_ops->name, old_dbg_io_ops->name);
> +			return -EBUSY;
> +		}
> +		old_dbg_io_ops->deinit();
>  	}
>  
>  	if (new_dbg_io_ops->init) {
> @@ -1098,6 +1104,12 @@ int kgdb_register_io_module(struct kgdb_io *new_dbg_io_ops)
>  
>  	spin_unlock(&kgdb_registration_lock);
>  
> +	if (old_dbg_io_ops) {
> +		pr_info("Replaced I/O driver %s with %s\n",
> +			old_dbg_io_ops->name, new_dbg_io_ops->name);

I know that causes no trouble for the current deinit() method does but 
I'd be more comfortable if the core printed this before calling deinit()?


Daniel.
