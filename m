Return-Path: <SRS0=JuT/=6L=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D28FBC54FD0
	for <linux-serial@archiver.kernel.org>; Mon, 27 Apr 2020 14:19:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD1FB206BF
	for <linux-serial@archiver.kernel.org>; Mon, 27 Apr 2020 14:19:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Fv6KdKme"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727902AbgD0OT7 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 27 Apr 2020 10:19:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727882AbgD0OT6 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 27 Apr 2020 10:19:58 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E650C03C1A7
        for <linux-serial@vger.kernel.org>; Mon, 27 Apr 2020 07:19:58 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id 188so19734963wmc.2
        for <linux-serial@vger.kernel.org>; Mon, 27 Apr 2020 07:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bee/vT9YZsF5aLuysXN53gVWnahANuP+/H4BtD8nDYA=;
        b=Fv6KdKme0P7Hd6Cv7sn90bDFGKT3FWV4huW02i2XsZ69hzzo1H3u17OS98OzaZnBTB
         278KEthOnv0lxhcPsLu7SX/vgTtq4wPqX+E2pWCx23VhbpaUXDQfoVYsJbx/Kuva3O2S
         PJxvYmNcCpSHd+6bDJnvLSiezLzVKMsooJagwhfuXLnIQQEXEEX67MWfkbn6V0X/Zu98
         UsMjjj0yyJiwg66FMZp3hMqn6vGHm7TvUasx+awqJcZjlvQewIC2DbBCYNbvd62AZtYa
         0AfvcSlUzA3xn+ukScz45mTXRED9CfUSUT8dzrtuQMu+s7czphHXriJF2Q1TTHqpC6ZW
         LZcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bee/vT9YZsF5aLuysXN53gVWnahANuP+/H4BtD8nDYA=;
        b=LiIi98rKYTZIWI/3n/eIpsuuj/URqQMKYLAz9w7WD1yh8fTVsIUZQY10crmSdkFu/9
         SKiW/+0S7BcAxUqtQBnb/HKde77/vJAQ/cY/9DyoTh1zDPPD1DGgzQaGxPcbafQ236zF
         7Zn0T2+Npt95dGg6qdMYJMrNZDlf76gifbgoVJB02vrvS4GaAV3fZpl8Sm+rrPDX3CsC
         31pAJm80oLpFB4sLjrp/sPoSlZuE98dmiTWh1ZlZsg6NMjE1xXOG4S2AVoYEA38NRKNB
         AlQOR6ephL4UYfXEpJl0fzFFo9lQohgQ+8ZCTVQkloXmlcDUL0TRaxxIJBjIcouNH9Uu
         RwVg==
X-Gm-Message-State: AGi0PuZxr7j4Rg2zn0N+nDnIuMZci77jWynM7KPgi3kbTz9vQw+L2SVp
        2l77n9EahZC2rH5AsyBbg1aBIDffnebFNg==
X-Google-Smtp-Source: APiQypL3l+lAat7PP7CR3gM2nPKe8kVnYD5lj6efi+kyjeJHTF/ddP0kz0TZeQ47rwxSl4/e9jMwqQ==
X-Received: by 2002:a1c:9cc6:: with SMTP id f189mr25872640wme.75.1587997197302;
        Mon, 27 Apr 2020 07:19:57 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id i129sm16621988wmi.20.2020.04.27.07.19.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2020 07:19:56 -0700 (PDT)
Date:   Mon, 27 Apr 2020 15:19:54 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     jason.wessel@windriver.com, gregkh@linuxfoundation.org,
        kgdb-bugreport@lists.sourceforge.net, mingo@redhat.com,
        hpa@zytor.com, bp@alien8.de, linux-serial@vger.kernel.org,
        agross@kernel.org, tglx@linutronix.de, frowand.list@gmail.com,
        bjorn.andersson@linaro.org, jslaby@suse.com,
        catalin.marinas@arm.com, corbet@lwn.net, will@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/9] kgdboc: Use a platform device to handle tty
 drivers showing up late
Message-ID: <20200427141954.d55djgbq74e4dme5@holly.lan>
References: <20200421211447.193860-1-dianders@chromium.org>
 <20200421141234.v2.3.I4a493cfb0f9f740ce8fd2ab58e62dc92d18fed30@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200421141234.v2.3.I4a493cfb0f9f740ce8fd2ab58e62dc92d18fed30@changeid>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Apr 21, 2020 at 02:14:41PM -0700, Douglas Anderson wrote:
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

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
