Return-Path: <SRS0=JuT/=6L=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EC1DC54FCB
	for <linux-serial@archiver.kernel.org>; Mon, 27 Apr 2020 13:43:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B624206B6
	for <linux-serial@archiver.kernel.org>; Mon, 27 Apr 2020 13:43:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PciYzbFD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726945AbgD0NnL (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 27 Apr 2020 09:43:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727961AbgD0NlE (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 27 Apr 2020 09:41:04 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76DCAC03C1A7
        for <linux-serial@vger.kernel.org>; Mon, 27 Apr 2020 06:41:04 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id d15so18982466wrx.3
        for <linux-serial@vger.kernel.org>; Mon, 27 Apr 2020 06:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qskqBCfdzREjKA9fa2frF/rmcEBt4W75Oo1RINDuL60=;
        b=PciYzbFDVyI+JIUgP7z4s9KZGSe0p7vVs8ALpXX7D9YagVDMkP0ZpacdKqu66I6N/u
         hC5mNmb0O2xFCsNlb7xP1snYcqKl0rKblIFQ7SYdNaxwK8juEMldsh6AQOHPq9ozka+S
         5PuQZAkMb4QA61dJhgB+1fcjyw3ImIVCCYZE2jhOOVBo70juqnWxqPEDuJ1KHsILhuCx
         kOwyDktgGgvnwEoRrLT6nUugVCPR6c9sLIG7eiXuSfbR8JkhYKVgRtyaE8mUXpEzpsKt
         RfWosq4o2vWaAdyfQMbmJDAiTBko0YxymWfDbCbHxndy2oQcwNUOjClfoa0f9cm15KOp
         /x3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qskqBCfdzREjKA9fa2frF/rmcEBt4W75Oo1RINDuL60=;
        b=VZS3YV7bIJCDJ6E1c+qX9T1RvQPG2vsYOqI2oTg3fMmqd8dxSfiuBd+tCFi0bD0CcV
         +UMSuyEGA3XCDBE+ATDpq1JGWIlXfndFD5p7cgdV6Fqh9V5uGSBGbi1VWn+gK6Z34KV3
         Ef+CxinNFhp88l3VqoAs4m7gym3+PCMNx4wRmwU6Mctx/NXifP8RXFbVON2KGrEWl2We
         ajZsizrXOD69lonIA6PsxT2OzIyO1k6MwATnB/Koj0khoy6rJTXY8lMVjHWL5TiR1ckq
         M24UfOXJBWSgr6BIBW0bPeDObH74j4FqmFioBQdsI+wHwI5BILTQJwnGIk8M4VgECBEo
         XDqA==
X-Gm-Message-State: AGi0PuZAlE12iVhCC3ha7ZPU4zC9IaoA4Rsc3nyJ0kMcR0AsRDidj8NT
        wPclWBCRWUQP4qKhE1j0bdhPsw==
X-Google-Smtp-Source: APiQypI6s4BTjOqupT6wBSh+mk+0hEHoVYYO9xG3m/ikx3pp//H2vgP4TgZVdIglgNonn1iTVoGdYA==
X-Received: by 2002:a5d:51c6:: with SMTP id n6mr27292826wrv.314.1587994863218;
        Mon, 27 Apr 2020 06:41:03 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id d133sm17469376wmc.27.2020.04.27.06.41.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2020 06:41:02 -0700 (PDT)
Date:   Mon, 27 Apr 2020 14:41:00 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     jason.wessel@windriver.com, gregkh@linuxfoundation.org,
        kgdb-bugreport@lists.sourceforge.net, mingo@redhat.com,
        hpa@zytor.com, bp@alien8.de, linux-serial@vger.kernel.org,
        agross@kernel.org, tglx@linutronix.de, frowand.list@gmail.com,
        bjorn.andersson@linaro.org, jslaby@suse.com,
        catalin.marinas@arm.com, corbet@lwn.net, will@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/9] Revert "kgdboc: disable the console lock when in
 kgdb"
Message-ID: <20200427134100.h7hrjn2wfokyfii7@holly.lan>
References: <20200421211447.193860-1-dianders@chromium.org>
 <20200421141234.v2.2.I02258eee1497e55bcbe8dc477de90369c7c7c2c5@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200421141234.v2.2.I02258eee1497e55bcbe8dc477de90369c7c7c2c5@changeid>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Apr 21, 2020 at 02:14:40PM -0700, Douglas Anderson wrote:
> This reverts commit 81eaadcae81b4c1bf01649a3053d1f54e2d81cf1.
> 
> Commit 81eaadcae81b ("kgdboc: disable the console lock when in kgdb")
> is no longer needed now that we have the patch ("kgdb: Disable
> WARN_CONSOLE_UNLOCKED for all kgdb").  Revert it.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
