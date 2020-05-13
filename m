Return-Path: <SRS0=7vif=63=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EA66C2D0F8
	for <linux-serial@archiver.kernel.org>; Wed, 13 May 2020 06:59:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A34E20718
	for <linux-serial@archiver.kernel.org>; Wed, 13 May 2020 06:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589353182;
	bh=zxZDltAXJe3Nap9miVFjgcOT4pDcGn1grjxSUVSlpg4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ZiWaKDW3CAfe9ywSew7jMOLvh2lmfXztUb043lkAotBL6shb3Z2w1rTLwsdegQhXb
	 Cle8iM60zWNMNMb/Hp8OITU9Kau8qL8XIX1qtTbTZqyrQZFJOOYfdD5vR2BDd+lYpx
	 hLxQBWyMLTuVhCyOykKQT6LFxLYAnCjTTJttzvzM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728490AbgEMG7m (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 13 May 2020 02:59:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:37138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726020AbgEMG7l (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 13 May 2020 02:59:41 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 92652206F5;
        Wed, 13 May 2020 06:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589353181;
        bh=zxZDltAXJe3Nap9miVFjgcOT4pDcGn1grjxSUVSlpg4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PBjTTdWKQVrfNIV+c0F9sgcgf79yhfKAzQO4hmoCvqL06wln2BSXnCTIvxcv40Z4V
         VguYJQGq7+CsZRExhkO54WRMzt4UDl51+NLrUCc3S8NFpeY7/3jGVC5Omax3KQXs54
         rLZYR7PYD69y+dfyLAppoLZntOd4ZU5zeTl85lSA=
Date:   Wed, 13 May 2020 08:59:38 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     sagar.kadam@sifive.com, linux-serial@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, Atish Patra <Atish.Patra@wdc.com>,
        Anup Patel <Anup.Patel@wdc.com>
Subject: Re: [PATCH v1 1/1] tty: serial: add missing spin_lock_init for
 SiFive serial console
Message-ID: <20200513065938.GA764901@kroah.com>
References: <1589019852-21505-2-git-send-email-sagar.kadam@sifive.com>
 <mhng-b2e9c16c-ee06-4c78-800d-a7725d6c74a3@palmerdabbelt-glaptop1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mhng-b2e9c16c-ee06-4c78-800d-a7725d6c74a3@palmerdabbelt-glaptop1>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, May 12, 2020 at 04:00:23PM -0700, Palmer Dabbelt wrote:
> On Sat, 09 May 2020 03:24:12 PDT (-0700), sagar.kadam@sifive.com wrote:
> > An uninitialised spin lock for sifive serial console raises a bad
> > magic spin_lock error as reported and discussed here [1].
> > Initialising the spin lock resolves the issue.
> > 
> > The fix is tested on HiFive Unleashed A00 board with Linux 5.7-rc4
> > and OpenSBI v0.7
> > 
> > [1] https://lore.kernel.org/linux-riscv/b9fe49483a903f404e7acc15a6efbef756db28ae.camel@wdc.com
> > 
> > Fixes: 45c054d0815b ("tty: serial: add driver for the SiFive UART")
> > Reported-by: Atish Patra <Atish.Patra@wdc.com>
> > Signed-off-by: Sagar Shrikant Kadam <sagar.kadam@sifive.com>
> > ---
> >  drivers/tty/serial/sifive.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/tty/serial/sifive.c b/drivers/tty/serial/sifive.c
> > index 13eadcb..0b5110d 100644
> > --- a/drivers/tty/serial/sifive.c
> > +++ b/drivers/tty/serial/sifive.c
> > @@ -883,6 +883,7 @@ console_initcall(sifive_console_init);
> > 
> >  static void __ssp_add_console_port(struct sifive_serial_port *ssp)
> >  {
> > +	spin_lock_init(&ssp->port.lock);
> >  	sifive_serial_console_ports[ssp->port.line] = ssp;
> >  }
> 
> Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
> Acked-by: Palmer Dabbelt <palmerdabbelt@google.com>
> 
> I'm assuming it's going in through Greg's tree.

Sure, I'll be glad to take it.

greg k-h
