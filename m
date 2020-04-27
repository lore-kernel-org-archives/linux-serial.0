Return-Path: <SRS0=JuT/=6L=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26451C54FD0
	for <linux-serial@archiver.kernel.org>; Mon, 27 Apr 2020 16:36:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1C5A20663
	for <linux-serial@archiver.kernel.org>; Mon, 27 Apr 2020 16:36:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J+l24Czb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727805AbgD0Qgt (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 27 Apr 2020 12:36:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727077AbgD0Qgt (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 27 Apr 2020 12:36:49 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAF08C03C1A8
        for <linux-serial@vger.kernel.org>; Mon, 27 Apr 2020 09:36:48 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id x17so20584559wrt.5
        for <linux-serial@vger.kernel.org>; Mon, 27 Apr 2020 09:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=frZBOQ1exjgMsqYWxD4jj/K/xqa6G08eQzpRHiR5nTU=;
        b=J+l24CzbgJktxLUevNZPjpit4TbFXi3jk5YnyD+0k/2Ku/+za8eEbNlI69ZyBPVMbT
         vuTbo96a+BD6XMEr9sH3ZwuF/GS2YsZpo2C1p63rXkNAW7bcbPtLPJNw8aaASb75rbHZ
         hRdjVpIJxpMDiDRpaJowp1wlpvcSgD61y76oyKQilJUfHKrCIKcb3I//qJ0P2J7lqQI6
         rmwTDmSmZnVLC75pKNUTBgaG34qM8EnPe6ok3UdU4ulVR5LosoOv68fvZOJ16WnHT8My
         Fz720nNThTNVGr5qIQTDS/0NN6SA1GrvUzLlWQSJnWkxHmr9TtedlTaLmOG0b3PrMUYh
         bD/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=frZBOQ1exjgMsqYWxD4jj/K/xqa6G08eQzpRHiR5nTU=;
        b=UDoJGFziQsMVbNwvCTvy78WwXIrmOP49jOBbplAbv51FS0bDL0xUijJRPosDx6Wkc9
         n9merykQ8cgxfnuubTp4EWg4NOPE/GVeMu1DOsVWU+x1I7pBFaC90XOFA7aLj9D4utqA
         WRQojdMT4qdg/1UyLervMRBTj2JLLqHQ49PBMAT3X/hQivI2kLNnLujd30b9unUJbNBE
         ILqR4sMIpKqS7K6SEEIxQn9pq2jA1q/Yl4yaJcHxOIHNBFEp+5AXcN0llhNPmYT1UjKT
         JDvMEvVmdsc74E1zWzBE10I+e0YyGmpz8/1XoKMClHtxO7x9j4GUetLeYfrntu2szcAU
         vYUQ==
X-Gm-Message-State: AGi0PuY+Xbrn42TgC2Tlul4J+OQ9icIFMb9F5n1Ad7RC3/aK2FohfocM
        9/Skn+CqeX+eEIKYFvbbSqX8Sw==
X-Google-Smtp-Source: APiQypKwmGT9y4n9NVOISStfo5tsoEWTnbYN+HhCb+ZzPzRaPu66IhD1NBCl8E84+GWB6GpgjhoysQ==
X-Received: by 2002:adf:ff84:: with SMTP id j4mr27535400wrr.305.1588005407084;
        Mon, 27 Apr 2020 09:36:47 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id k14sm22072396wrp.53.2020.04.27.09.36.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2020 09:36:46 -0700 (PDT)
Date:   Mon, 27 Apr 2020 17:36:44 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     jason.wessel@windriver.com, gregkh@linuxfoundation.org,
        kgdb-bugreport@lists.sourceforge.net, mingo@redhat.com,
        hpa@zytor.com, bp@alien8.de, linux-serial@vger.kernel.org,
        agross@kernel.org, tglx@linutronix.de, frowand.list@gmail.com,
        bjorn.andersson@linaro.org, jslaby@suse.com,
        catalin.marinas@arm.com, corbet@lwn.net, will@kernel.org,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH v2 6/9] kgdboc: Add earlycon_kgdboc to support early kgdb
 using boot consoles
Message-ID: <20200427163644.pyolyoxdxo3u5w6e@holly.lan>
References: <20200421211447.193860-1-dianders@chromium.org>
 <20200421141234.v2.6.I8fba5961bf452ab92350654aa61957f23ecf0100@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200421141234.v2.6.I8fba5961bf452ab92350654aa61957f23ecf0100@changeid>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Apr 21, 2020 at 02:14:44PM -0700, Douglas Anderson wrote:
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
> "earlycon_kgdboc".
> 
> The console API isn't really intended to have clients work with it
> like we're doing.  Specifically there doesn't appear to be any way for
> clients to be notified about a boot console being unregistered.  We'll
> work around this by checking that our console is still valid before
> using it.  We'll also try to transition off of the boot console and
> onto the "tty" API as quickly as possible.
> 
> The normal/expected way to make all this work is to use
> "earlycon_kgdboc" and "kgdboc" together.  You should point them both
> to the same physical serial connection.  At boot time, as the system
> transitions from the boot console to the normal console, kgdb will
> switch over.  If you don't use things in the normal/expected way it's
> a bit of a buyer-beware situation.  Things thought about:
> 
> - If you specify only "earlycon_kgdboc" but not "kgdboc" you still
>   might end up dropping into kgdb upon a crash/sysrq but you may not
>   be able to type.
> - If you use "keep_bootcon" (which is already a bit of a buyer-beware
>   option) and specify "earlycon_kgdboc" but not "kgdboc" we'll keep
>   trying to use your boot console for kgdb.
> - If your "earlycon_kgdboc" and "kgdboc" devices are not the same
>   device things should work OK, but it'll be your job to switch over
>   which device you're monitoring (including figuring out how to switch
>   over gdb in-flight if you're using it).
> 
> When trying to enable "earlycon_kgdboc" it should be noted that the
> names that are registered through the boot console layer and the tty
> layer are not the same for the same port.  For example when debugging
> on one board I'd need to pass "earlycon_kgdboc=qcom_geni
> kgdboc=ttyMSM0" to enable things properly.  Since digging up the boot
> console name is a pain and there will rarely be more than one boot
> console enabled, you can provide the "earlycon_kgdboc" parameter
> without specifying the name of the boot console.  In this case we'll
> just pick the first boot that implements read() that we find.
> 
> This new "earlycon_kgdboc" parameter should be contrasted to the
> existing "ekgdboc" parameter.  While both provide a way to debug very
> early, the usage and mechanisms are quite different.  Specifically
> "earlycon_kgdboc" is meant to be used in tandem with "kgdboc" and
> there is a transition from one to the other.  The "ekgdboc" parameter,
> on the other hand, replaces the "kgdboc" parameter.  It runs the same
> logic as the "kgdboc" parameter but just relies on your TTY driver
> being present super early.  The only known usage of the old "ekgdboc"
> parameter is documented as "ekgdboc=kbd earlyprintk=vga".  It should
> be noted that "kbd" has special treatment allowing it to init early as
> a tty device.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Again, very happy with the overall approach, just a few quibbles.


> ---
> This patch touches files in several different subsystems, but it
> touches a single line and that line is related to kgdb.  I'm assuming
> this can all go through the kgdb tree, but if needed I can always
> introduce a new API call instead of modifying the old one and then
> just have the old API call be a thin wrapper on the new one.

Funny you should say that!

I don't really like that extra argument although it is nothing to do
with simplifying merges...

 
> diff --git a/drivers/tty/serial/kgdboc.c b/drivers/tty/serial/kgdboc.c
> index 519d8cfbfbed..2f526f2d2bea 100644
> --- a/drivers/tty/serial/kgdboc.c
> +++ b/drivers/tty/serial/kgdboc.c
> @@ -409,6 +465,80 @@ static int __init kgdboc_early_init(char *opt)
>  }
>  
>  early_param("ekgdboc", kgdboc_early_init);
> +
> +static int earlycon_kgdboc_get_char(void)
> +{
> +	char c;
> +
> +	if (earlycon_neutered || !earlycon->read(earlycon, &c, 1))
> +		return NO_POLL_CHAR;
> +
> +	return c;
> +}
> +
> +static void earlycon_kgdboc_put_char(u8 chr)
> +{
> +	if (!earlycon_neutered)
> +		earlycon->write(earlycon, &chr, 1);
> +}
> +
> +static void earlycon_kgdboc_pre_exp_handler(void)
> +{
> +	/*
> +	 * We don't get notified when the boot console is unregistered.
> +	 * Double-check when we enter the debugger.  Unfortunately we
> +	 * can't really unregister ourselves now, but at least don't crash.
> +	 */
> +	if (earlycon && !earlycon_neutered && !is_earlycon_still_valid()) {
> +		pr_warn("Neutering kgdb since boot console vanished\n");
> +		earlycon_neutered = true;

This is, IMHO, too subtle.

I don't think this is merely a warning with a gentle message about
neutering. IIUC the system is (or will shortly be) dead in the water.
After diligently stopping all the CPUs the debug-core will then start
waiting for a character that cannot possibly come!

I think this might be one of those vanishingly rare places where
panicing might actually the right thing to do... although only after 
neutering" the kgdb panic handler first ;-).


> +	}
> +}
> +
> +static struct kgdb_io earlycon_kgdboc_io_ops = {
> +	.name			= "earlycon_kgdboc",
> +	.read_char		= earlycon_kgdboc_get_char,
> +	.write_char		= earlycon_kgdboc_put_char,
> +	.pre_exception		= earlycon_kgdboc_pre_exp_handler,
> +	.is_console		= true,
> +};
> +
> +static int __init earlycon_kgdboc_init(char *opt)
> +{
> +	struct console *con;
> +
> +	kdb_init(KDB_INIT_EARLY);

This is normally taken care of by debug-core.c . Could this be
integrated into kgdb_register_io_module() ?


> +
> +	/*
> +	 * Look for a matching console, or if the name was left blank just
> +	 * pick the first one we find.
> +	 */
> +	console_lock();
> +	for_each_console(con) {
> +		if (con->write && con->read &&
> +		    (con->flags & (CON_BOOT | CON_ENABLED)) &&
> +		    (!opt || !opt[0] || strcmp(con->name, opt) == 0))
> +			break;
> +	}
> +	console_unlock();
> +
> +	if (!con) {
> +		pr_info("Couldn't find kgdb earlycon\n");
> +		return 0;
> +	}
> +
> +	earlycon = con;
> +	pr_info("Going to register kgdb with earlycon '%s'\n", con->name);
> +	if (kgdb_register_io_module(&earlycon_kgdboc_io_ops, false) != 0) {
> +		earlycon = NULL;
> +		pr_info("Failed to register kgdb with earlycon\n");
> +		return 0;
> +	}
> +
> +	return 0;
> +}
> +
> +early_param("earlycon_kgdboc", earlycon_kgdboc_init);
>  #endif /* CONFIG_KGDB_SERIAL_CONSOLE */
>  
>  module_init(init_kgdboc);
> diff --git a/kernel/debug/debug_core.c b/kernel/debug/debug_core.c
> index 8f178239856d..1b5435c6d92a 100644
> --- a/kernel/debug/debug_core.c
> +++ b/kernel/debug/debug_core.c
> @@ -1074,16 +1074,21 @@ EXPORT_SYMBOL_GPL(kgdb_schedule_breakpoint);
>  /**
>   *	kgdb_register_io_module - register KGDB IO module
>   *	@new_dbg_io_ops: the io ops vector
> + *	@replace: If true it's OK if there were old ops.  This is used
> + *		  to transition from early kgdb to normal kgdb.  It's
> + *		  assumed these are the same device so kgdb can continue.
>   *
>   *	Register it with the KGDB core.
>   */
> -int kgdb_register_io_module(struct kgdb_io *new_dbg_io_ops)
> +int kgdb_register_io_module(struct kgdb_io *new_dbg_io_ops, bool replace)

As I said I'm not a big fan of the extra argument. It makes the call
sites harder to read.

Could earlycon_kgdboc be registered with a boolean flag set so that
a subsequent register will automatically replace the old one
(maybe "is_replaceable" or "is_temporary")?

For bonus marks the core could also enforce that a replaceable io ops
table must have init set to null (because there is no deinit).


Daniel.
