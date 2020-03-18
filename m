Return-Path: <SRS0=ll96=5D=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BFEFC10DCE
	for <linux-serial@archiver.kernel.org>; Wed, 18 Mar 2020 10:46:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E4F82076C
	for <linux-serial@archiver.kernel.org>; Wed, 18 Mar 2020 10:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584528406;
	bh=YCkhHQT5F00h28WJRm1j10thT0wzc5xpiIsvaeObjFQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=gsBJ+G7z6TringZ4G+LjVJhZtG3Y39pVKZz3/7MIaViP2w2Lgqoh+dD4MPkx4puL0
	 3jzm7uT6K3vqAPzEEuDLr4vEv4t6GIF0csC/0GflqGGur5a2XF5Tlb9WmMYVqVf19C
	 +Rhaadlpu5ihbmbipZS9oJW+KTjJROsTobaoLNzg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727547AbgCRKqq (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 18 Mar 2020 06:46:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:42120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727520AbgCRKqq (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 18 Mar 2020 06:46:46 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA64720768;
        Wed, 18 Mar 2020 10:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584528405;
        bh=YCkhHQT5F00h28WJRm1j10thT0wzc5xpiIsvaeObjFQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QsI0+uM5KzC5PRFGa4dVpvIE4jo070uGn45uwG6KoSEjNtkU71p0Xyn+nvWKDsM3l
         DJ3RGmeWw2/PFvVSlov34Oi/IkSQvlVsFh56HNgV1mDgUMa03XXQR55O7a4CSooPxE
         hegmYlmRqJk+nsOsG6E31I01EoEES7oYZFRwRRcA=
Date:   Wed, 18 Mar 2020 11:46:42 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     Baolin Wang <baolin.wang7@gmail.com>, Jiri Slaby <jslaby@suse.com>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Subject: Re: [PATCH v2 2/2] serial: sprd: cleanup the sprd_port for error case
Message-ID: <20200318104642.GA2304200@kroah.com>
References: <20200318083120.13805-1-zhang.lyra@gmail.com>
 <20200318083120.13805-2-zhang.lyra@gmail.com>
 <CADBw62rSE+MrQB_HSOwVNos_W=x-mHMEuVrZN=jU0Yt1KXFGvw@mail.gmail.com>
 <CADBw62pWhA8n5rAgX2Hud06k9cvF9b3KDfZmH7oX1HEz=MWzYA@mail.gmail.com>
 <20200318101340.GA2081481@kroah.com>
 <CAAfSe-t7e0Cd3Lm_x9u=OhuBBtTexx3+qyg-+F71LK=C1V5pNA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAfSe-t7e0Cd3Lm_x9u=OhuBBtTexx3+qyg-+F71LK=C1V5pNA@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Mar 18, 2020 at 06:16:43PM +0800, Chunyan Zhang wrote:
> On Wed, 18 Mar 2020 at 18:13, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Wed, Mar 18, 2020 at 06:06:05PM +0800, Baolin Wang wrote:
> > > On Wed, Mar 18, 2020 at 5:16 PM Baolin Wang <baolin.wang7@gmail.com> wrote:
> > > >
> > > > On Wed, Mar 18, 2020 at 4:31 PM Chunyan Zhang <zhang.lyra@gmail.com> wrote:
> > > > >
> > > > > From: Chunyan Zhang <chunyan.zhang@unisoc.com>
> > > > >
> > > > > It would be better to cleanup the sprd_port for the device before
> > > > > return error.
> > > > >
> > > > > Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> > > > > ---
> > > > >  drivers/tty/serial/sprd_serial.c | 4 +++-
> > > > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/drivers/tty/serial/sprd_serial.c b/drivers/tty/serial/sprd_serial.c
> > > > > index 9f8c14ff6454..54477de9822f 100644
> > > > > --- a/drivers/tty/serial/sprd_serial.c
> > > > > +++ b/drivers/tty/serial/sprd_serial.c
> > > > > @@ -1204,8 +1204,10 @@ static int sprd_probe(struct platform_device *pdev)
> > > > >         up->has_sysrq = IS_ENABLED(CONFIG_SERIAL_SPRD_CONSOLE);
> > > > >
> > > > >         ret = sprd_clk_init(up);
> > > > > -       if (ret)
> > > > > +       if (ret) {
> > > > > +               sprd_port[index] = NULL;
> > > >
> > > > 如果我们强制使用alias, 则这里应该也无需清除了，因为一进probe就会给它重新赋值。 还是我漏了什么？
> > >
> > > Sorry, please ignore my previsous comment. I made a stupid mistake
> > > when talking with Chunyan.
> > >
> > > So what I mean is we should not add this clean up, cause we will
> > > always get the correct index with aliases, and it will be overlapped
> > > when probing again.
> >
> > So ignore this patch and only take patch 1/2?  If so, can I get your
> > acked-by for it?
> 
> Hi Greg,
> 
> There's something I need to modify on 1/2 as well, I will send the
> whole patch-set later, please ignore these two patches.
> 
> Sorry for the noise!

Discussion about patches is _never_ noise, that's what this list/group
is for :)
