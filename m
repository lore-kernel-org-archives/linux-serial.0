Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F202C07E99
	for <linux-serial@archiver.kernel.org>; Fri,  9 Jul 2021 14:20:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12B69613B5
	for <linux-serial@archiver.kernel.org>; Fri,  9 Jul 2021 14:20:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231797AbhGIOXQ (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 9 Jul 2021 10:23:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:38710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231764AbhGIOXQ (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 9 Jul 2021 10:23:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 60B8A613B7;
        Fri,  9 Jul 2021 14:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1625840431;
        bh=2EBNLEHxe5/5UlnhGK1H1LyRAqcZYhaT9n2+AEngdoM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IvQs1lDelj81O+LcqB11HMdXNIm7XIf7wu/E5iJZDduea03tJERpgM1vG+4ieES5B
         1Fbfw4nAHHn+YHA8e7EAu4Pl7c4Exq/N+5jH3nm67yZs6cVD5XacRu7E5vFN9DKyXJ
         oyFTZLDqz8J57UVIrNixQ/ebykbFkqIrEXimWD9A=
Date:   Fri, 9 Jul 2021 16:20:29 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Zheyu Ma <zheyuma97@gmail.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] tty: serial: jsm: allocate queue buffer at probe time
Message-ID: <YOhbLaeGKGJEFEOe@kroah.com>
References: <1625489588-26079-1-git-send-email-zheyuma97@gmail.com>
 <fde46fee-fad9-8f3b-79b0-ad426fd379dd@kernel.org>
 <CAHp75Vceenv5ctk6f_eEtXBVzodXHhnpuudaniLM9A1edqYrXA@mail.gmail.com>
 <ffa624c5-fc2a-780a-17d2-404cd94a289a@kernel.org>
 <CAMhUBjmGD+KH_faMJyZGBpufxPVWw7uz4tUgFtrenx-HovjxZg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMhUBjmGD+KH_faMJyZGBpufxPVWw7uz4tUgFtrenx-HovjxZg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Jul 09, 2021 at 10:00:32PM +0800, Zheyu Ma wrote:
> On Thu, Jul 8, 2021 at 3:13 AM Jiri Slaby <jirislaby@kernel.org> wrote:
> >
> > On 07. 07. 21, 14:52, Andy Shevchenko wrote:
> > > On Wed, Jul 7, 2021 at 10:50 AM Jiri Slaby <jirislaby@kernel.org> wrote:
> > >> On 05. 07. 21, 14:53, Zheyu Ma wrote:
> > >
> > >> So how it comes an interrupt came before
> > >> neo_param() in jsm_tty_open was called?
> > >
> > > If IRQ is shared we have a special debug feature to test shared IRQs
> > > on freeing IRQ stage (*).
> > > But it doesn't matter, the IRQ handler must survive at any stage after
> > > the action has been listed.
> >
> > Yes, but IRQ_NONE is returned from the ISR in that case.
> >
> > The issue the patch is fixing is for a "malicious" device and I am not
> > sure we want to fix this -- if I can put in a malicious device, I can
> > use hammer to kill the box too…
> 
> Well, this threat assumption is indeed strong, but this attack may be
> real. For example, some programmable USB devices (such as FaceDancer)
> may exploit vulnerabilities in the USB device driver to attack. Of
> course, there has not been such an attack in the real world for PCI
> devices. Or, some devices with DMA functions may also send malicious
> data and some previous kernel commits have also fixed such bugs.
> 
> Anyway, thanks for your patient comments.

Right now, yes, we treat USB devices as "possibly malicious".  We do not
do so for PCI devices yet.  If we want to do that, then we need to do a
lot of work, not just "this one call in this one driver" type of thing
as there are much bigger issues involved here.

If you wish to take on this work, as you feel PCI devices should be
treated this way, please do so!  But start in the PCI core at the very
least, before worrying about the thousands of individual drivers.

good luck!

greg k-h
