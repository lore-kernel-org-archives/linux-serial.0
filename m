Return-Path: <SRS0=7vif=63=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 182FCC2D0F8
	for <linux-serial@archiver.kernel.org>; Wed, 13 May 2020 05:35:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E918920659
	for <linux-serial@archiver.kernel.org>; Wed, 13 May 2020 05:35:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="txZr0XeH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728726AbgEMFfc (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 13 May 2020 01:35:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725977AbgEMFfc (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 13 May 2020 01:35:32 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33193C061A0C;
        Tue, 12 May 2020 22:35:32 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id b190so1750890pfg.6;
        Tue, 12 May 2020 22:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=N6F6FfdsbXnl/SVK+3lEcJ6QSNPZpV7bb51snrOs/po=;
        b=txZr0XeHuO7k5BX0CUgXyG6VP+PiWZiHNGupxtphY/hX0tcBvm1GfmNP/og2vyHwOv
         00Jwu6eowQehKsMOEiAPV4i9Vi5NAE2moFkGfslHOj3x05Tdu9JQJDxth4vfV4mf/kn+
         KJvAsVzXd50wZPI1Gn3PtnYQhTMzDplkzXUja26WzfwUbj8IP0XbaXT7ZJzw/kbBqxPe
         Hm1tw3kNPsV9/iC/4vsOiL/mfbhn0I1ofsTUcua2lOGO1OgkRRSvWR6IYrl2qxVq3Opp
         6Qh5w/cHLZc1GgIQcizNm38dCKEq8WzKQVg0OUePgccFTt8XZyn+vCSYfnI44YihTSBb
         yWZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=N6F6FfdsbXnl/SVK+3lEcJ6QSNPZpV7bb51snrOs/po=;
        b=XkRXzRG8BGcP0XcP+yuGxoG81gRiQVDE1HrRCRiJq+KzHRt8bLJn6S0U9X7LFb2FeK
         GuZKiLIA92tSge0utBjcdjxmBFCEB84OUSTbXpyE1wzCvQ8AytLWVw7qRWQP/KVpKaxr
         Yh0NyRbkFQ8crQ5CIYt2Bz6Oirow/EbCF+U+T/+wufZxPbp/urIhPAdCqjDhXsnRPhtV
         yYEK42sZKFP6IJIA0tvEjrQflyoPmufdZUHyBSLl8yzVRlMKV37nm2XF1RUz7YtSgER3
         KljMfWAV1vVumx0tfDHL+QQTJTubBWhw/sf4QDoRZcshYsBPYEK6nlxFTzO67CiaJAXy
         mh0Q==
X-Gm-Message-State: AGi0PuYUzt0zT7JY0wiehaZEOR+X6ns87u2C6lvPo8DApGYETGPd0hdf
        yWyS5Pb9GaUx2aR015Uz8cY=
X-Google-Smtp-Source: APiQypKbmkqhqS7o4ermQSolZR+cfuqa+pjV4dqn2sJsZ4yPaDy9SgV2EtYA1EalVbPrFoB3VL2yMQ==
X-Received: by 2002:a62:2bcb:: with SMTP id r194mr24565356pfr.26.1589348131658;
        Tue, 12 May 2020 22:35:31 -0700 (PDT)
Received: from localhost ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id q16sm3263402pgm.91.2020.05.12.22.35.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 22:35:30 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date:   Wed, 13 May 2020 14:35:29 +0900
To:     Alper Nebi Yasak <alpernebiyasak@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-serial@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        "David S. Miller" <davem@davemloft.net>,
        Feng Tang <feng.tang@intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: Re: [RFC PATCH v2 1/3] printk: Add function to set console to
 preferred console's driver
Message-ID: <20200513053529.GL413@jagdpanzerIV.localdomain>
References: <20200430161438.17640-1-alpernebiyasak@gmail.com>
 <20200430161438.17640-2-alpernebiyasak@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200430161438.17640-2-alpernebiyasak@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On (20/04/30 19:14), Alper Nebi Yasak wrote:
[..]
> +int update_console_to_preferred(void)
> +{
> +	struct console_cmdline *c = NULL;
> +	struct console *con = NULL;
> +	struct console *tmp = NULL;
> +
> +	if (preferred_console >= 0)
> +		c = &console_cmdline[preferred_console];
> +
> +	if (!c || !c->name[0])
> +		return 0;
> +
> +	for_each_console(con) {
> +		if (!con->next || !(con->next->flags & CON_ENABLED))
> +			continue;
> +		if (strcmp(c->name, con->next->name) != 0)
> +			continue;

This matches the consoles by exact name. Consoles can have aliases,
but matching by alias is rather complex and it has some side effects.

Let me Cc more people on this. VT has a console takeover logic,
I wonder if we can extend the takeover code somehow.

Daniel, any thoughts?

https://lore.kernel.org/lkml/20200430161438.17640-1-alpernebiyasak@gmail.com

	-ss
