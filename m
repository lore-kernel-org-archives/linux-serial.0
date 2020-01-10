Return-Path: <SRS0=sEmL=27=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2D00C282DD
	for <linux-serial@archiver.kernel.org>; Fri, 10 Jan 2020 16:50:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F38220721
	for <linux-serial@archiver.kernel.org>; Fri, 10 Jan 2020 16:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578675039;
	bh=8HHZgme5mM4iuHU5vOOC3RIkB5rsLaet9CtTH598wQE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=U0UJ/ScPUj5rtEyjzVG9aO0aqOpwrVRlu2IXa/i6TJ3CS8Qkcjs3qEKsn96iy4Hbs
	 SMbjOZYkacMSzBJ0C0ibPVhfZxKweqiURIPjPyUHhKG5bfOutdqpsVrtWdvogF+vOl
	 O9n2xnanQXSrfbCP5uNxrvwVLANOG8/C9N/9w50Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728779AbgAJQuj (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 10 Jan 2020 11:50:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:52020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728510AbgAJQuj (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 10 Jan 2020 11:50:39 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B797206ED;
        Fri, 10 Jan 2020 16:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578675038;
        bh=8HHZgme5mM4iuHU5vOOC3RIkB5rsLaet9CtTH598wQE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mbsT9hmFHzlBovI5kb62PtrpWVcdIB1Hf77VF81OjwBQHu52ay699sufJgYJEhSSB
         1a5p5vaE1VzhF86djjFkzHLG+ji257Vu7yAUjE/cRBOTX56IUoqsU/2r024FPLncBJ
         PxbdfaB2TOOgyFCovo4JsGD3RjMikeUoaugvOnW4=
Date:   Fri, 10 Jan 2020 17:50:36 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Dmitry Safonov <dima@arista.com>
Cc:     linux-kernel@vger.kernel.org,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Jiri Slaby <jslaby@suse.com>,
        Vasiliy Khoruzhick <vasilykh@arista.com>,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH-next 1/3] serial_core: Move sysrq functions from header
 file
Message-ID: <20200110165036.GA1837425@kroah.com>
References: <20200109215444.95995-1-dima@arista.com>
 <20200109215444.95995-2-dima@arista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200109215444.95995-2-dima@arista.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Jan 09, 2020 at 09:54:42PM +0000, Dmitry Safonov wrote:
> It's not worth to have them in every serial driver and I'm about to add
> another helper function.
> 
> Signed-off-by: Dmitry Safonov <dima@arista.com>
> ---
>  drivers/tty/serial/serial_core.c | 83 +++++++++++++++++++++++++++++++
>  include/linux/serial_core.h      | 84 ++------------------------------
>  2 files changed, 88 insertions(+), 79 deletions(-)

This is a nice cleanup, so I took this patch now, but the last two
patches still need a bit of rework.  Please do that and rebase, no need
to send this patch again.

thanks,

greg k-h
