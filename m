Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AE9DC433B4
	for <linux-serial@archiver.kernel.org>; Wed, 12 May 2021 11:18:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 073EE613D6
	for <linux-serial@archiver.kernel.org>; Wed, 12 May 2021 11:18:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbhELLTt (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 12 May 2021 07:19:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:41748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230037AbhELLTr (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 12 May 2021 07:19:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A767F613CD;
        Wed, 12 May 2021 11:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620818319;
        bh=DwkFFES7CVfs2LyLbM2285mUnjBaco7qJw5/rKCfOwM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IMOwejsRLeFviD/14aLBdPAx1+JB8MJngewMcmeI+vIPNB/7YUV4CwGhzpZjHnS7V
         EH60C3uq8iW2Grhx20nfKOB3/XI3fe6yJ6A94uqcDhFiYmFVSKsEtreYXphJ7CTWS3
         g6h2H4/C0FaRBn0qxLy5GlLx2bZoDzzcOML3RGNQWxAMw5q50FC20OIevU3ra13IEb
         offrtzvuM4EfhjE0MTf2Qp0Nnwf3OoZ2i7hzy6r4t9Ericl+Ae0B5083XUsv3Bdtom
         suM2m1o8XmSVwYZxTqpwn5Du1u/7OLU9vzpR/UMwlo+4gKJ/vO5weE3sinbaoiceIk
         2TQmppxrrmz0g==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1lgmt0-0004bI-7h; Wed, 12 May 2021 13:18:42 +0200
Date:   Wed, 12 May 2021 13:18:42 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Michael Walle <michael@walle.cc>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Angelo Dureghello <angelo.dureghello@timesys.com>,
        Philippe Schenker <philippe.schenker@toradex.com>
Subject: Re: [PATCH 4/8] serial: fsl_lpuart: handle break and make sysrq work
Message-ID: <YJu5ktQT1eziDpaI@hovoldconsulting.com>
References: <20210511200148.11934-1-michael@walle.cc>
 <20210511200148.11934-5-michael@walle.cc>
 <YJugS4fiUBgPvIS6@hovoldconsulting.com>
 <e3e5ad179483508d02305f26fd20800a@walle.cc>
 <YJuozDa5ISIAHw7D@hovoldconsulting.com>
 <7698180da355d6626a72794cf8a172f9@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7698180da355d6626a72794cf8a172f9@walle.cc>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, May 12, 2021 at 12:31:33PM +0200, Michael Walle wrote:
> [dropped fugang.duan@nxp.com, mail bounces with 550 5.4.1 Recipient
> address rejected: Access denied]
> 
> Am 2021-05-12 12:07, schrieb Johan Hovold:

> > But you should get rid of the sysrq trylock hack when switching to
> > uart_unlock_and_check_sysrq().
> 
> Ok. But only for the sport->port.sysrq part right? We'll still
> need it for oops_in_progress.

Right.

Johan
