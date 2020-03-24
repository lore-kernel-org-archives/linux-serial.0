Return-Path: <SRS0=BK0i=5J=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33CADC4332B
	for <linux-serial@archiver.kernel.org>; Tue, 24 Mar 2020 11:29:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07EFC20870
	for <linux-serial@archiver.kernel.org>; Tue, 24 Mar 2020 11:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585049390;
	bh=U/4Civ8GXevpEjqpkUOuBd2G0WKgxBb5LGpN+uk3yS0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=QBTXkdRSlqf5lpSq3lfSUsyPJ9w7lliGCutwTSka6suQctMOFi9NkNo47iDU8bdQJ
	 /b8/kNouVPRAIMYM49l0mvLxr2H+YYgm15OSrSJktA+FbS0hL+Y2IC/CVDILqb+5Cy
	 goJ586taJU698rXTujCJf0WPCt7ERUCq0HY0Ba4Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727282AbgCXL3t (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 24 Mar 2020 07:29:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:44992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727217AbgCXL3t (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 24 Mar 2020 07:29:49 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 845DE2070A;
        Tue, 24 Mar 2020 11:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585049389;
        bh=U/4Civ8GXevpEjqpkUOuBd2G0WKgxBb5LGpN+uk3yS0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CFfy9FIVclzTIyDbBwcGXQchi4AFSmvDDBgLorsyDd7g10kuF/9DsjNYvUqMADYTy
         jA2iytrxOGzp70uED07Rx1HbLTL5F8RwG7MKYnehj2uE45ILASIanz0B1v+GbhIAsW
         sgqv3c4ICqqR84KwDGbREEemamGQDnIBSGQuF60s=
Date:   Tue, 24 Mar 2020 12:29:44 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        Eric Dumazet <edumazet@google.com>,
        Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH v3 0/2] vt: fix some vt_ioctl races
Message-ID: <20200324112944.GA2276078@kroah.com>
References: <20200320193424.GM851@sol.localdomain>
 <20200322034305.210082-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200322034305.210082-1-ebiggers@kernel.org>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Sat, Mar 21, 2020 at 08:43:03PM -0700, Eric Biggers wrote:
> Fix VT_DISALLOCATE freeing an in-use virtual console, and fix a
> use-after-free in vt_in_use().
> 
> Changed since v2:
>     - Implemented tty_port_operations::destruct().
>     - Added comments regarding vt_in_use() locking.
> 
> Changed since v1:
>     - Made the vc_data be freed via tty_port refcounting.
>     - Added patch to fix a use-after-free in vt_in_use().
> 
> Eric Biggers (2):
>   vt: vt_ioctl: fix VT_DISALLOCATE freeing in-use virtual console
>   vt: vt_ioctl: fix use-after-free in vt_in_use()
> 
>  drivers/tty/vt/vt.c       | 23 ++++++++++++++++++++++-
>  drivers/tty/vt/vt_ioctl.c | 28 ++++++++++++++++------------
>  2 files changed, 38 insertions(+), 13 deletions(-)


Jiri, any objection to these?

thanks,

greg k-h
