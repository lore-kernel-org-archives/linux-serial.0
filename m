Return-Path: <SRS0=pdp3=6O=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94F34C8300A
	for <linux-serial@archiver.kernel.org>; Thu, 30 Apr 2020 12:09:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70EE820757
	for <linux-serial@archiver.kernel.org>; Thu, 30 Apr 2020 12:09:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JNArPiV8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbgD3MJi (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 30 Apr 2020 08:09:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726550AbgD3MJh (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 30 Apr 2020 08:09:37 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60975C035495
        for <linux-serial@vger.kernel.org>; Thu, 30 Apr 2020 05:09:37 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id d17so6553252wrg.11
        for <linux-serial@vger.kernel.org>; Thu, 30 Apr 2020 05:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Y0xip88alJJHgT8WR4VPvH6LdcIpB6H16swF0bscE1E=;
        b=JNArPiV8SKWe12+WTT62TxAuEUSJkcGqCY/lyz7LWfYheOeYHkEnRiz1UNNh1M5p7R
         QCGf8zmPUmyXeT0Xfzk7z10GE5yUKRQ3SnHrl4OtC93ChJ3fwC8qmpjInb4cHGvil0sC
         /SW4W/JAKbrCSNeHW2271i7nHI2OYosToLTdFLRxI1xSvfARux23tLuqyhvuyIG99ug/
         BN0TNVp5l8Svi8ORjkEQcqmZD5QVWYOcN9kSlwsUK7NrIQtQePdY7voHxvPpIM/lwP0u
         xQTTNuhLcaQabtLRNLnTcsWruRO4HcW8emzrCy8MCr6qegyGQTgP0I7x86Ngozd4qIHF
         6Dkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Y0xip88alJJHgT8WR4VPvH6LdcIpB6H16swF0bscE1E=;
        b=LGpyujs2sN35Y5zjdB1qHe82zCjFNgzRsavTsf7Eb3rtHuPlvTuaD4vUUDDUCB6Qzl
         S0t6RO9DaLhUWBkteQybejJ98hEHbCF4kTV9DeVzl/lOb7NegIlnG7cYQIVawlpYx8vq
         S0FVf7rXM82OXNOOKCs48Usjz+faHEgL+mUSIXApOzf9CB4mW/21IGuIFaA2kk9WOI+Z
         gSggVTLj+8fJA4eteCEByH3DYHz3oYvNcDL1N4FvyPwWS04DW2DGTTD0qvHwmXtcDyaG
         Rq1KosMQTz2jbh4j3d3BPaCCMoxLZt4S2UxNr/IBkFrWTifGsUcws9bdhei6bwpExxwr
         z6gA==
X-Gm-Message-State: AGi0PuagMYGy3NpyDrhgnE6gvu7LiI09+j3wH6WgK0AGHjUDGn4yvuuD
        gLzG8ejU9elkshICcxI3+Fo1xQ==
X-Google-Smtp-Source: APiQypLlZinGM8RIVlKd61kiepPD3usy2U3s7d+i3fJt6CalwK/t241E0xaQtUX0ft7N1lGwAHb+7g==
X-Received: by 2002:adf:ff89:: with SMTP id j9mr3527161wrr.245.1588248576067;
        Thu, 30 Apr 2020 05:09:36 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id u3sm3594603wrt.93.2020.04.30.05.09.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 05:09:35 -0700 (PDT)
Date:   Thu, 30 Apr 2020 13:09:33 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        linux-serial@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Patch Tracking <patches@linaro.org>
Subject: Re: [PATCH] serial: earlycon: Allow earlier DT scan is acpi=off
Message-ID: <20200430120933.r33oraqvt7p4lu2v@holly.lan>
References: <20200428162227.687978-1-daniel.thompson@linaro.org>
 <CAD=FV=VTkO5AULJe1ksyhKLLxpywqX-RLC_T4ENyDf3ONJNMKg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=FV=VTkO5AULJe1ksyhKLLxpywqX-RLC_T4ENyDf3ONJNMKg@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Apr 29, 2020 at 05:40:10PM -0700, Doug Anderson wrote:
> Hi,
> 
> On Tue, Apr 28, 2020 at 9:22 AM Daniel Thompson
> <daniel.thompson@linaro.org> wrote:
> >
> > Currently if the kernel has support for ACPI SPCR parsing then earlycon
> > without arguments is processed later than the full earlycon=...
> > alternative.
> >
> > If ACPI has been explicitly disabled on the kernel command line then
> > there is not need to defer since the ACPI code (both x86 and arm64)
> > will never actually run.
> >
> > Or, put another way it allows lazy people to throw "acpi=off earlycon"
> > onto the command line of a DT systems and be confident the console will
> > start as early as possible without them having to lookup the driver
> > and address needed for a specific platform.
> >
> > Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
> > ---
> >  drivers/tty/serial/earlycon.c | 28 +++++++++++++++++++++++++++-
> >  1 file changed, 27 insertions(+), 1 deletion(-)
> 
> I wonder if a cleaner option is to just add a special "earlycon" value
> like "earlycon=not_acpi".  This wouldn't require any special peeking
> and would just be a sentinel that just says "you should autodetect the
> earlycon, but don't worry about waiting for ACPI".  ...that in itself
> is a bit of a hack, but at least it's more self contained in the
> earlycon driver and maybe more discoverable when someone is figuring
> out how to setup earlycon?

Taking this idea further I wonder if we could even make this earlycon=acpi.
In other words if the loader provided a DT and earlycon has no arguments
when we use the DT to setup the earlycon regardless of any later
decision to adopt ACPI.

I think the only time this would do the wrong thing is if the DT and
ACPI tables are both passed to the kernel and have different early
consoles. This would be a very weird thing for the firmware to do
by, just in case, we could offer earlycon=acpi to accommodate it.

Naturally I do have to code and test it ;-).


Daniel.
