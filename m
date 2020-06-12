Return-Path: <SRS0=2C4M=7Z=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48828C433DF
	for <linux-serial@archiver.kernel.org>; Fri, 12 Jun 2020 15:29:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2196620801
	for <linux-serial@archiver.kernel.org>; Fri, 12 Jun 2020 15:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591975766;
	bh=2gcTLGQ/YAq3hCULFYWKp1jg32rkHtZfqYIP+dnmats=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=kPTDanBVOt0FM6UUq60/3mtnFUKwvYhbLMdWDh+CFW6QSxp4WsVGZL6QhPRw6HRyL
	 2Wbtfx6KfpubCCffgaenEuRUr5whclRGMGtjW1VXFGVJdyPnrOrlW1REI1ba13Chgu
	 I89K88E+5f8DmceMM2xurQhIyAGAALKLIH7ojVA0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726272AbgFLP3Z (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 12 Jun 2020 11:29:25 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:41134 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbgFLP3Z (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 12 Jun 2020 11:29:25 -0400
Received: by mail-lj1-f194.google.com with SMTP id 9so11558356ljc.8;
        Fri, 12 Jun 2020 08:29:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QuAjxxaqKlcJRQ0p/qwMZ0zHnlOSAqFpzmJBK0X5aP0=;
        b=ev9mg2I4h0IJtr86/A5+dUEujlPr9enW3Pf4/EfAWGkf0rWsht+erpKC0yGhYMrALi
         +ESH78IbWvHQPu9H/JlGgQS6+fjsN2qsyPE4bnx+gDkdfZQcHMIoYIg+nLTET5NDGAAq
         4VpZcE4zDu4TYinLBYWMFxvw63f9Pzpdvu1ZdRr+3WDjzkywrmzGvLTP2cwXlk/8GB9L
         qkLZ6zMouPjhH5NVbsHk1I32veyTQa0H0b/dWdvjHLULhVmJBmTEIOHTg31np/ugk9dr
         oOIh/LhwKcgjQ4FIjIFW2ARE7yVqMBh7953VqIezzZAGvia1r+u/HjWo3jVqMFdVtd/4
         e2Eg==
X-Gm-Message-State: AOAM530YoXOEtjGm/sCEG9d3wR3t6oh+oo2NIA3/xHJFJ0g7n7Adu3Ez
        dCSSn6xNuKryVUY7xOVcer8=
X-Google-Smtp-Source: ABdhPJzNXjjcNDZ/7ULp47Al+CYcSlnN1Ku7GCqNvR32XQmRfp4aVCQT5OovsZ+JCAhxCKjZ405sCg==
X-Received: by 2002:a2e:8901:: with SMTP id d1mr7378051lji.37.1591975761815;
        Fri, 12 Jun 2020 08:29:21 -0700 (PDT)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id w17sm2183199ljj.108.2020.06.12.08.29.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2020 08:29:20 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1jjlcP-0002oc-77; Fri, 12 Jun 2020 17:29:21 +0200
Date:   Fri, 12 Jun 2020 17:29:21 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Dmitry Safonov <0x7f454c46@gmail.com>
Cc:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] serial: core: fix sysrq overhead regression
Message-ID: <20200612152921.GP19480@localhost>
References: <20200610152232.16925-1-johan@kernel.org>
 <20200610152232.16925-3-johan@kernel.org>
 <19008afb-bfbb-35e2-3bd5-e7fd1b7355cc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19008afb-bfbb-35e2-3bd5-e7fd1b7355cc@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Jun 10, 2020 at 05:24:57PM +0100, Dmitry Safonov wrote:
> Hi Johan,
> 
> On 6/10/20 4:22 PM, Johan Hovold wrote:
> > Commit 8e20fc391711 ("serial_core: Move sysrq functions from header
> > file") converted the inline sysrq helpers to exported functions which
> > are now called for every received character, interrupt and break signal
> > also on systems without CONFIG_MAGIC_SYSRQ_SERIAL instead of being
> > optimised away by the compiler.
> 
> The part with ifdeffing looks good to me.
> 
> > Inlining these helpers again also avoids the function call overhead when
> > CONFIG_MAGIC_SYSRQ_SERIAL is enabled (e.g. when the port is not used as
> > a console).
> 
> But this one, coul you add measures? (it will also help to understand if
> it's a stable material).

Interrupt processing takes 2-3% longer without the inlining with
8250_omap on a beagleboard for example.

> If one function call actually matters here, than should
> uart_insert_char() also go into header?

Good question, it actually was originally intended to be inlined as all
other per-character processing. Separate discussion though.

The point is that we don't want a rarely used debugging feature to incur
unnecessary additional overhead that can easily be avoided.

Johan
