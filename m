Return-Path: <SRS0=ll96=5D=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43A33C10DCE
	for <linux-serial@archiver.kernel.org>; Wed, 18 Mar 2020 10:13:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 186C92076C
	for <linux-serial@archiver.kernel.org>; Wed, 18 Mar 2020 10:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584526425;
	bh=G7H8dYctiDdl1gUqcTaPSxK2kdPyhB5vuVjA+h9mHSc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mCICLa/Au1wJDI4jQNETQID9gMM3TSvrXdrILwij8x47CgYyJHD36OcmHF3Dtmbis
	 qlAeFhz1A/HlpnbwUqf2jDVMH9m0+w8nSfaYLU8AUCx/zeLis0c93eMr0Zw4q2H1iR
	 AVOg0bpc/eOxNNwxX6Bk4WvjWIdKq8ja+XrvZFBA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbgCRKNo (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 18 Mar 2020 06:13:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:54930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726486AbgCRKNo (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 18 Mar 2020 06:13:44 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 713E320768;
        Wed, 18 Mar 2020 10:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584526423;
        bh=G7H8dYctiDdl1gUqcTaPSxK2kdPyhB5vuVjA+h9mHSc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NJjHR17eZ41ZJRJS+wmEC+HlZsd3Yh1YnJH5df2ypBQ76x/LyEwowRZzJnK2zmQFa
         8DJUTR2DmvecrdI986ZdC7VSBkWiw6XIZy3XQPgGId0OhjeIMyajLV3wocUbZeiQrU
         HPT75cRo+2EG+Ac08Hjn/939C+FRs5/XdCFM5T9w=
Date:   Wed, 18 Mar 2020 11:13:40 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Baolin Wang <baolin.wang7@gmail.com>
Cc:     Chunyan Zhang <zhang.lyra@gmail.com>, Jiri Slaby <jslaby@suse.com>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Subject: Re: [PATCH v2 2/2] serial: sprd: cleanup the sprd_port for error case
Message-ID: <20200318101340.GA2081481@kroah.com>
References: <20200318083120.13805-1-zhang.lyra@gmail.com>
 <20200318083120.13805-2-zhang.lyra@gmail.com>
 <CADBw62rSE+MrQB_HSOwVNos_W=x-mHMEuVrZN=jU0Yt1KXFGvw@mail.gmail.com>
 <CADBw62pWhA8n5rAgX2Hud06k9cvF9b3KDfZmH7oX1HEz=MWzYA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADBw62pWhA8n5rAgX2Hud06k9cvF9b3KDfZmH7oX1HEz=MWzYA@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Mar 18, 2020 at 06:06:05PM +0800, Baolin Wang wrote:
> On Wed, Mar 18, 2020 at 5:16 PM Baolin Wang <baolin.wang7@gmail.com> wrote:
> >
> > On Wed, Mar 18, 2020 at 4:31 PM Chunyan Zhang <zhang.lyra@gmail.com> wrote:
> > >
> > > From: Chunyan Zhang <chunyan.zhang@unisoc.com>
> > >
> > > It would be better to cleanup the sprd_port for the device before
> > > return error.
> > >
> > > Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> > > ---
> > >  drivers/tty/serial/sprd_serial.c | 4 +++-
> > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/tty/serial/sprd_serial.c b/drivers/tty/serial/sprd_serial.c
> > > index 9f8c14ff6454..54477de9822f 100644
> > > --- a/drivers/tty/serial/sprd_serial.c
> > > +++ b/drivers/tty/serial/sprd_serial.c
> > > @@ -1204,8 +1204,10 @@ static int sprd_probe(struct platform_device *pdev)
> > >         up->has_sysrq = IS_ENABLED(CONFIG_SERIAL_SPRD_CONSOLE);
> > >
> > >         ret = sprd_clk_init(up);
> > > -       if (ret)
> > > +       if (ret) {
> > > +               sprd_port[index] = NULL;
> >
> > 如果我们强制使用alias, 则这里应该也无需清除了，因为一进probe就会给它重新赋值。 还是我漏了什么？
> 
> Sorry, please ignore my previsous comment. I made a stupid mistake
> when talking with Chunyan.
> 
> So what I mean is we should not add this clean up, cause we will
> always get the correct index with aliases, and it will be overlapped
> when probing again.

So ignore this patch and only take patch 1/2?  If so, can I get your
acked-by for it?

thanks,

greg k-h
