Return-Path: <SRS0=sEmL=27=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4129C33C99
	for <linux-serial@archiver.kernel.org>; Fri, 10 Jan 2020 07:42:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E4642082E
	for <linux-serial@archiver.kernel.org>; Fri, 10 Jan 2020 07:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578642163;
	bh=SyFqXEAEQ9htrTyJqkOgzYxvwQcGl63NHKSsJGCa4C8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=RxDh1FyO/QHmr4sFmW5SxIIcB2jDuEzjS5LJCGZ/7pzN+Xlzui9D3U4+onMkjOFHa
	 Wx/PGV7I0ECiLYgR6KfK8jePJY9wRaX83tn8LGONxPHRTV9DaIjVuaNO6qKUdkJaC7
	 2IvpZ44IERMvK6VAb4+NTk8k7S0hR/nk6gUS+Ffg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbgAJHmn (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 10 Jan 2020 02:42:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:58554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726276AbgAJHmn (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 10 Jan 2020 02:42:43 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 01A1F2080D;
        Fri, 10 Jan 2020 07:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578642162;
        bh=SyFqXEAEQ9htrTyJqkOgzYxvwQcGl63NHKSsJGCa4C8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qWpkCcFs4oin/xegbjWbrdGlEBylX7cGAnI9HhyX3VgIlvKs4l5An2NdC8YN8YvE2
         s+dVBAd6wz7nWWR94vnCNwMWGfCcp2pePYqfjCeI0qeP/MyzmKpnvVCz9QIP+zUJvc
         q7XYALnQXgc9brY5bZL1kFSmdrbswmBG2FsrZ+uI=
Date:   Fri, 10 Jan 2020 08:42:40 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     rishi gupta <gupt21@gmail.com>
Cc:     robh+dt@kernel.org, jslaby@suse.com, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/3] tty/serial: ttvys: add null modem driver
 emulating serial port
Message-ID: <20200110074240.GA260170@kroah.com>
References: <cover.1578235515.git.gupt21@gmail.com>
 <9fcb02fafd5fc9b31f3fe358b8e62b8a40ae132a.1578235515.git.gupt21@gmail.com>
 <20200106193500.GC754821@kroah.com>
 <CALUj-gsaecfZ9HN_JVAnvJijYCHK-A5qeztDLbDOSOAjTVfTeg@mail.gmail.com>
 <20200110072051.GA124387@kroah.com>
 <CALUj-gvroB_N34i-QkqT6Qn1ccvif+phN+Kszf-NO6v=Q8syqg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALUj-gvroB_N34i-QkqT6Qn1ccvif+phN+Kszf-NO6v=Q8syqg@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Jan 10, 2020 at 01:08:25PM +0530, rishi gupta wrote:
> One problem (: about configfs. Desktop distros like Ubuntu doesn't
> enable configFS by default in kernel config. So users will have to
> build their own version of kernel. For my own purpose, as developer I
> have control over this but for others building kernel suggested ?

I suggest taking that up with Ubuntu :)

Nothing we can do from the kernel side if we provide a good api that
they just don't happen to want their users to use.  Odds are no one
noticed that it was needed for something...

thanks,

greg k-h
