Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 936F0C433ED
	for <linux-serial@archiver.kernel.org>; Thu, 20 May 2021 15:07:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DE6F61246
	for <linux-serial@archiver.kernel.org>; Thu, 20 May 2021 15:07:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232419AbhETPJL (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 20 May 2021 11:09:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:38974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238578AbhETPJH (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 20 May 2021 11:09:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D9CA061184;
        Thu, 20 May 2021 15:07:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1621523266;
        bh=Wn1M4+UsbaVhUZR2giqAc9Ih5SyelQc6s8D+t56AuSU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=v7Z5kjCtxIONvEvNnF2J0ZxyrNspcPO2Rvb75EwFudWvtmnlcD/Oh72ZqVrj9efwp
         tQRhbHidgk8uCAUD6cfGGihsDPehhpf/uXpEl9qod5y5qW7zl2bwwAy8lgHz9ut7/0
         gj05z4Ja1Wpyofoq2eLa1+B3NoARY4FBdzwY1fIQ=
Date:   Thu, 20 May 2021 17:07:44 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Al Longyear <longyear@netcom.com>,
        "Andrew J. Kroll" <ag784@freenet.buffalo.edu>,
        Andrew Morton <andrewm@uow.edu.eu>,
        Bill Hawes <whawes@star.net>,
        "C. Scott Ananian" <cananian@alumni.princeton.edu>,
        Jiri Slaby <jirislaby@kernel.org>,
        -- <julian@uhunix.uhcc.hawaii.edu>,
        linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org,
        Marko Kohtala <Marko.Kohtala@hut.fi>,
        Michael Callahan <callahan@maths.ox.ac.uk>,
        Michal Simek <michal.simek@xilinx.com>,
        Nick Holloway <alfie@dcs.warwick.ac.uk>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Paul Fulghum <paulkf@microgate.com>,
        Paul Mackerras <Paul.Mackerras@cs.anu.edu.au>,
        processes-Sapan Bhatia <sapan@corewars.org>,
        Rob Herring <robh@kernel.org>,
        Russell King <rmk@arm.linux.org.uk>
Subject: Re: [PATCH 00/11] Rid W=1 warnings from TTY
Message-ID: <YKZ7QA4fFegLbUHH@kroah.com>
References: <20210520121906.3468725-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210520121906.3468725-1-lee.jones@linaro.org>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, May 20, 2021 at 01:18:55PM +0100, Lee Jones wrote:
> This set is part of a larger effort attempting to clean-up W=1
> kernel builds, which are currently overwhelmingly riddled with
> niggly little warnings.

All but 3 applied to my tree, you should rebase and resend those
remaining ones as they conflicted with things that others recently
changed.

thanks,

greg k-h
