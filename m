Return-Path: <SRS0=zA/y=5F=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85F58C4332D
	for <linux-serial@archiver.kernel.org>; Fri, 20 Mar 2020 06:58:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5202B20773
	for <linux-serial@archiver.kernel.org>; Fri, 20 Mar 2020 06:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584687483;
	bh=PIsypC08bJWE4+6MHuQaFuvnG+0cWY+CmeuIGkWOgCY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=RhGbDzi0I/OLIYcv1exHd84eJ0w8R7SCbmdaBXtl+NaEf25zb9UgzfZ20K799zFW8
	 e5lUpBb0w+JXFDBi9NM9hLPQDOUqM+8VgnNUlHtvhdwfTNvPfeQkxSuPADZ8/GPUwv
	 2bzxBd5uPEN0k6iCLxWGLIku1iBoFILpvW99EB9w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726602AbgCTG6C (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 20 Mar 2020 02:58:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:58828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726232AbgCTG6C (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 20 Mar 2020 02:58:02 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 39C7220724;
        Fri, 20 Mar 2020 06:58:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584687481;
        bh=PIsypC08bJWE4+6MHuQaFuvnG+0cWY+CmeuIGkWOgCY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HfVVJ8Ed99pmOAmwj9fvwyf8AtF0zak3Pa6CBMSeoWFfBk0ww+GnBdFynv9p6gm8O
         Fy6/2pfT2jRwoq8pN4MIRj/m2k3sLMyEebmJqP+bRuxZPv5njZTlz5EozE9ZqNGK3T
         TxJZ4rLXzGdZyLqjHDDtPz0cUacPKSBO+iZegXFY=
Date:   Fri, 20 Mar 2020 07:57:59 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        Eric Dumazet <edumazet@google.com>,
        Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH v2 1/2] vt: vt_ioctl: fix VT_DISALLOCATE freeing in-use
 virtual console
Message-ID: <20200320065759.GA307955@kroah.com>
References: <20200318222704.GC2334@sol.localdomain>
 <20200318223810.162440-1-ebiggers@kernel.org>
 <20200318223810.162440-2-ebiggers@kernel.org>
 <2f762aee-720b-9bec-620f-61129c724de6@suse.com>
 <20200320051049.GA1315@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200320051049.GA1315@sol.localdomain>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Mar 19, 2020 at 10:10:49PM -0700, Eric Biggers wrote:
> On Thu, Mar 19, 2020 at 08:36:28AM +0100, Jiri Slaby wrote:
> > On 18. 03. 20, 23:38, Eric Biggers wrote:
> > > --- a/drivers/tty/vt/vt.c
> > > +++ b/drivers/tty/vt/vt.c
> > > @@ -1102,6 +1102,9 @@ int vc_allocate(unsigned int currcons)	/* return 0 on success */
> > >  	tty_port_init(&vc->port);
> > >  	INIT_WORK(&vc_cons[currcons].SAK_work, vc_SAK);
> > >  
> > > +	/* if this wasn't the case, we'd have to implement port->ops.destruct */
> > > +	BUILD_BUG_ON(offsetof(struct vc_data, port) != 0);
> > > +
> > 
> > This is 3 lines, implementing destruct would be like 4-5 :)? Please
> > implement destruct instead.
> > 
> > Otherwise looks good.
> > 
> 
> Actually implementing destruct would be 12 lines, see below.  Remember there is
> no tty_port_operations defined yet so we'd have to define it just for destruct.
> 
> Do you still prefer it?
> 
> diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
> index ec34f1f5f3bb5..309a39197be0a 100644
> --- a/drivers/tty/vt/vt.c
> +++ b/drivers/tty/vt/vt.c
> @@ -1075,6 +1075,17 @@ static void visual_deinit(struct vc_data *vc)
>  	module_put(vc->vc_sw->owner);
>  }
>  
> +static void vc_port_destruct(struct tty_port *port)
> +{
> +	struct vc_data *vc = container_of(port, struct vc_data, port);
> +
> +	kfree(vc);
> +}
> +
> +static const struct tty_port_operations vc_port_ops = {
> +	.destruct = vc_port_destruct,
> +};
> +
>  int vc_allocate(unsigned int currcons)	/* return 0 on success */
>  {
>  	struct vt_notifier_param param;
> @@ -1100,11 +1111,9 @@ int vc_allocate(unsigned int currcons)	/* return 0 on success */
>  
>  	vc_cons[currcons].d = vc;
>  	tty_port_init(&vc->port);
> +	vc->port.ops = &vc_port_ops;
>  	INIT_WORK(&vc_cons[currcons].SAK_work, vc_SAK);
>  
> -	/* if this wasn't the case, we'd have to implement port->ops.destruct */
> -	BUILD_BUG_ON(offsetof(struct vc_data, port) != 0);
> -
>  	visual_init(vc, currcons, 1);
>  
>  	if (!*vc->vc_uni_pagedir_loc)


Yes, this is good to have, thanks for doing this.

greg k-h
