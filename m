Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 340C3C433B4
	for <linux-serial@archiver.kernel.org>; Wed, 12 May 2021 09:31:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F108F61370
	for <linux-serial@archiver.kernel.org>; Wed, 12 May 2021 09:30:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbhELJcG (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 12 May 2021 05:32:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:48634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230385AbhELJb4 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 12 May 2021 05:31:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E337661370;
        Wed, 12 May 2021 09:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620811848;
        bh=7w4IKLLWGrK4vnZyM1MtVo1v8bh6Z4Y+8pWc2Ct3fck=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rZzsduvyu6cjDO678fCA3PqfLWqjiUFVtBfG0zP5zxk7I74y4bLp8156WqVoZRmas
         dEdjie4brnFnzLmdSpVG+YpT3QJD54gQHB3p62B1o9wKOWD2t8LrIdtDlCRhPMujaG
         U2MMXcj0ETFV2yjEc4jg++jIlzOUc/KyOi7F/leByoDF7V3StqvGh506Q4NNZqXsEK
         Y4foRRgzB+70/lcDVlnc4eLbEobSRAdTzCeejLii+ZKbM2SXvWMk3GTp2v7tiyxj3r
         pOFyYsPaCfk+A3PG2wtHNiNcWOURWLywQzG8ItvzBtp7GIP8He31HU/rD47h8cGWh0
         gepVc36LRLpIw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1lglCd-00048t-BC; Wed, 12 May 2021 11:30:52 +0200
Date:   Wed, 12 May 2021 11:30:51 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Michael Walle <michael@walle.cc>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Angelo Dureghello <angelo.dureghello@timesys.com>,
        Fugang Duan <fugang.duan@nxp.com>,
        Philippe Schenker <philippe.schenker@toradex.com>
Subject: Re: [PATCH 4/8] serial: fsl_lpuart: handle break and make sysrq work
Message-ID: <YJugS4fiUBgPvIS6@hovoldconsulting.com>
References: <20210511200148.11934-1-michael@walle.cc>
 <20210511200148.11934-5-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210511200148.11934-5-michael@walle.cc>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, May 11, 2021 at 10:01:44PM +0200, Michael Walle wrote:
> Although there is already (broken) sysrq characters handling, a break
> condition was never detected. There is also a possible deadlock because
> we might call handle_sysrq() while still holding the port lock.

Where's the possible deadlock?

First, as you point out above the driver currently doesn't detect breaks
so the sysrq handler is never called and there's no risk for deadlocks
in the console code.

Second, the driver's console implementation explicitly handles being
called recursively so would not deadlock after you start detecting
breaks either.

> Add support for break detection and use the proper
> uart_unlock_and_check_sysrq() to defer calling handle_sysrq().

Johan
