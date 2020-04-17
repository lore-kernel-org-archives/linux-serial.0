Return-Path: <SRS0=oPkf=6B=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41435C2D0EF
	for <linux-serial@archiver.kernel.org>; Fri, 17 Apr 2020 13:23:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E7EA20724
	for <linux-serial@archiver.kernel.org>; Fri, 17 Apr 2020 13:23:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587129789;
	bh=ibA2rFMmnIgq8C4ss7cZI9qOp+zQGjoWhmj6CGUWqAg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=B8rDCQErbMro6Vq64JVf5qCtKbqMdmSZ7AVutEDDDcQcxmwLVlJBVSomF6DS0p3JH
	 cox3Yi+wvKmiU/DEj4ClIG2alxMHJVE904l7/xipn6gceGVCLxsg+SpsJdveDAVZPT
	 JoXh4GQtyS7AwG4S/sPL2nSxp3df4gIHsGweLPUo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730575AbgDQNXF (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 17 Apr 2020 09:23:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:59272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730059AbgDQNXF (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 17 Apr 2020 09:23:05 -0400
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6724E2087E;
        Fri, 17 Apr 2020 13:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587129784;
        bh=ibA2rFMmnIgq8C4ss7cZI9qOp+zQGjoWhmj6CGUWqAg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=pvPiMKv7ntfk8qZOizcPdx7MlEsmGycUZQCRnRz4+G33Qnrb37pOO/AkBi/nBjNGz
         JGawS9KGQmeiK+KZ4CVHbiAykxm7qsStvYfaITLAWWvZ9vb3WTdPNYPHKZCsaMrHnM
         /cSjDsDb8DkSjBk3ViQf2w2ZFSt60p7OA7aLRC48=
Received: by mail-qk1-f174.google.com with SMTP id v7so2337747qkc.0;
        Fri, 17 Apr 2020 06:23:04 -0700 (PDT)
X-Gm-Message-State: AGi0Pub7VXXzN9GufKJILZdYdC6P1muKOdyDbHiGXDl4QG+m5uIedbQW
        t9DLXnu5p/RPSKHuke0tmdSbh9PaNM9o+J6D9g==
X-Google-Smtp-Source: APiQypIIPofmnn66BHXTWvxdCOKv9Ze/AyzaJMMc0phMuil4lY+bjO9YsYMgACjlOuTWT0n/sVIjD7KyQSkUmsGI8g4=
X-Received: by 2002:a37:7dc6:: with SMTP id y189mr3324472qkc.223.1587129783565;
 Fri, 17 Apr 2020 06:23:03 -0700 (PDT)
MIME-Version: 1.0
References: <1587012974-21219-1-git-send-email-gupt21@gmail.com>
 <CAL_JsqLWMTpHG=bOmWgy1kg6d7vxRGbCda+febq=FnqbuRbPyQ@mail.gmail.com> <CALUj-gsuUFQbRLKX=nTbA+y6oTyEAnX7OaxkAX375rBBgNc44g@mail.gmail.com>
In-Reply-To: <CALUj-gsuUFQbRLKX=nTbA+y6oTyEAnX7OaxkAX375rBBgNc44g@mail.gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 17 Apr 2020 08:22:52 -0500
X-Gmail-Original-Message-ID: <CAL_JsqL1_3ZZW1F=J6J0J1rhsKu4psc-OF6OUqJ9+-H+Jpb8WQ@mail.gmail.com>
Message-ID: <CAL_JsqL1_3ZZW1F=J6J0J1rhsKu4psc-OF6OUqJ9+-H+Jpb8WQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] dt-bindings: ttyvs: document serial null modem
 driver bindings
To:     rishi gupta <gupt21@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Jonathan Corbet <corbet@lwn.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        devicetree@vger.kernel.org,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Apr 17, 2020 at 12:14 AM rishi gupta <gupt21@gmail.com> wrote:
>

Please don't top post.

> Initially there was no DT support but later it was added as CONFIGFS
> is optional.

Make configfs required.

> DT is giving flexibility to use the driver.

The DT belongs in the firmware for a platform like BIOS/EFI on your
PC. Would you want to configure your driver in the BIOS?

Rob

>
> On Fri, Apr 17, 2020 at 2:08 AM Rob Herring <robh+dt@kernel.org> wrote:
> >
> > On Wed, Apr 15, 2020 at 11:56 PM Rishi Gupta <gupt21@gmail.com> wrote:
> > >
> > > The ttyvs driver creates virtual tty devices. These devices can
> > > also be created through device tree. This commit document this.
> >
> > Device tree is for real h/w devices. You have a configfs interface to
> > set these up. I don't think we need both.
> >
> > Rob
