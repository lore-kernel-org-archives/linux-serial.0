Return-Path: <SRS0=sEmL=27=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C6AEC33CA2
	for <linux-serial@archiver.kernel.org>; Fri, 10 Jan 2020 10:37:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C3452072E
	for <linux-serial@archiver.kernel.org>; Fri, 10 Jan 2020 10:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578652665;
	bh=L/ylI2tq0m4AakHfsFEdMxuJF2BHSZ/xQvxYDm11loo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NZiBeDmpjIQRDLVbAJnINSyP8Uxw2UXJCLUyynId1ahTK7OvZEoH3/4CuHLis2tOX
	 7af+hJwzdxlYJOKhuNVWuoq5XdEYA8tBiFX0b0yj311/irI3Zzn4b8LYUqwHjV6uY9
	 aEHU0reEXPlImqKYZjAn3lK3yHGa4DF1NjVsrZCo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727491AbgAJKhp (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 10 Jan 2020 05:37:45 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:33712 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727366AbgAJKho (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 10 Jan 2020 05:37:44 -0500
Received: by mail-lj1-f193.google.com with SMTP id y6so1654190lji.0;
        Fri, 10 Jan 2020 02:37:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JRe8rmTF1UxDJkj3I8/Vucrz4EL5UQD/SNLC8vy+9mg=;
        b=FDig+8akZMD/99eGY95u9IEN/DWqdGPEtYCtZyI+IFYlHrQI1i8qaS3RqOj5KHWSrK
         +lytTBZwakLu67jlmktghxT8TSa7RDJOU7/bDCgIYg7DIsz+mJ2PB5NVlbQzxFEPE+gm
         BeFWaKrXStWm4vRiJuuEiOxBK3f33KJjxYPo7xei9vPe7Kqh/AZG+gKAfb4MpXnYIfvl
         LXaBZybiE66Zu1Mrcd7sP2k6v9ABsctYXohKFwKDuGVODkKYGEvirq62LgD1ITtCTFHn
         Sbzb6H7NKxpZ1yrjtI8BZfoTDx4ljHbBz9t2ofMOSm1WewqVg0uqd6nTb74AHf7H2syO
         t4sg==
X-Gm-Message-State: APjAAAWj7WIlBXQ2eQvh2tEqCojqfSFhTruep6TJSg1l3MJfhllUr9Yl
        lRAfaip4bi4pz0IOOm8nbej+DeMQ
X-Google-Smtp-Source: APXvYqyJ/3cb5+PxJjjNZK4MQBZrnjDNRpLC4oIWboKPba/6ZGnvIRlsru/xoOXB59UyVlq22hlD1Q==
X-Received: by 2002:a2e:9806:: with SMTP id a6mr2147975ljj.178.1578652662773;
        Fri, 10 Jan 2020 02:37:42 -0800 (PST)
Received: from xi.terra (c-14b8e655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.184.20])
        by smtp.gmail.com with ESMTPSA id e9sm764261ljp.75.2020.01.10.02.37.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2020 02:37:41 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.92.3)
        (envelope-from <johan@kernel.org>)
        id 1iprfs-0001LI-Rk; Fri, 10 Jan 2020 11:37:52 +0100
Date:   Fri, 10 Jan 2020 11:37:52 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-serial@vger.kernel.org
Subject: Re: [GIT PULL] TTY/Serial driver fixes for 5.5-rc3
Message-ID: <20200110103752.GB4273@localhost>
References: <20191220070747.GA2190169@kroah.com>
 <CAHk-=whcLH7EXVZbD0g1Bw7McrofQ-7vwiL2GAeMn=z9PP4VEQ@mail.gmail.com>
 <20191223120651.GC114474@kroah.com>
 <20191227183011.ij5wcawu6kpf52fb@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191227183011.ij5wcawu6kpf52fb@debian>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Dec 27, 2019 at 06:30:11PM +0000, Sudip Mukherjee wrote:
> On Mon, Dec 23, 2019 at 07:06:51AM -0500, Greg KH wrote:
> > On Fri, Dec 20, 2019 at 10:08:03AM -0800, Linus Torvalds wrote:
> > > On Thu, Dec 19, 2019 at 11:07 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> > > >
> > > > The last tty core fix should resolve a long-standing bug with a race
> > > > at port creation time that some people would see, and Sudip finally
> > > > tracked down.
> > > 
> > > Hmm, looks good. But it makes me wonder if we should now try to remove
> > > the second call to tty_port_link_device()?
> > > 
> > > Now we have a number of helpers that do that tty_port_link_device()
> > > call for the driver (eg tty_port_register_device_attr_serdev(),
> > > tty_port_register_device_attr(), and the just added
> > > uart_add_one_port()).
> > > 
> > > But we also have drivers doing it by hand, and presumably we now have
> > > drivers that do it through multiple paths? I guess it's harmless, but
> > > it feels a bit odd. No?
> > 
> > It does.  I'll try to look at this after the holidays unless Sudip beats
> > me to it.
> 
> The second call to tty_port_link_device() is in
> tty_port_register_device_attr_serdev() and tty_port_register_device_attr()
> is being called from many other places apart from uart_add_one_port().
> The attached patch should be safe. I will test and send it properly unless
> someone objects to it.

No, this is horrid. There's certainly room for some clean up here but we
shouldn't make things worse. ;)

Why not look into registering the console only after the port has been
set up and registered and revert fb2b90014d78 ("tty: link tty and port
before configuring it as console") completely instead?

Johan
