Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8695CC433EF
	for <linux-serial@archiver.kernel.org>; Tue, 21 Sep 2021 11:36:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69D0361166
	for <linux-serial@archiver.kernel.org>; Tue, 21 Sep 2021 11:36:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232498AbhIULhx (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 21 Sep 2021 07:37:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:50202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232341AbhIULhw (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 21 Sep 2021 07:37:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0B37E61184;
        Tue, 21 Sep 2021 11:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1632224184;
        bh=zWZf2YfsXIWdXNp7ZoylUgLi722Ht+rt6qA4OZk5bu4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UpY7XDOXPp6iGWj5JN5TxJLpOTaKKXgJ909BSopPbJF+Ow4wDYtIKu0Y5W8QXQFPG
         HEFG5RX00HtM/Og1GaITeHa/ctRYWMtF56pRXR4P6udEf2/NGVOIoYfUAqIJYntQ1n
         YDyimCKgh9i4lVnR3HP0Rdp7/xa9ZJe3rZYjqsvY=
Date:   Tue, 21 Sep 2021 13:36:21 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Andreas Koensgen <ajk@comnets.uni-bremen.de>,
        Paul Mackerras <paulus@samba.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: Re: [PATCH 07/16] tty: remove file from tty_ldisc_ops::ioctl and
 compat_ioctl
Message-ID: <YUnDtTEzex5/z90J@kroah.com>
References: <20210914091134.17426-1-jslaby@suse.cz>
 <20210914091134.17426-7-jslaby@suse.cz>
 <YUlY5pQQWf2P2fKn@google.com>
 <9049e956-2865-7309-2eaf-aa4516ab28d6@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9049e956-2865-7309-2eaf-aa4516ab28d6@kernel.org>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Sep 21, 2021 at 12:52:38PM +0200, Jiri Slaby wrote:
> On 21. 09. 21, 6:00, Dmitry Torokhov wrote:
> > Hi Jiri,
> > 
> > On Tue, Sep 14, 2021 at 11:11:25AM +0200, Jiri Slaby wrote:
> > > diff --git a/drivers/input/serio/serport.c b/drivers/input/serio/serport.c
> > > index 17eb8f2aa48d..55e91d0e70ec 100644
> > > --- a/drivers/input/serio/serport.c
> > > +++ b/drivers/input/serio/serport.c
> > > @@ -207,8 +207,8 @@ static void serport_set_type(struct tty_struct *tty, unsigned long type)
> > >    * serport_ldisc_ioctl() allows to set the port protocol, and device ID
> > >    */
> > > -static int serport_ldisc_ioctl(struct tty_struct *tty, struct file *file,
> > > -			       unsigned int cmd, unsigned long arg)
> > > +static int serport_ldisc_ioctl(struct tty_struct *tty, unsigned int cmd,
> > > +		unsigned long arg)
> > 
> > Can we please keep arguments aligned as they were? Otherwise
> 
> Fixed, thanks. Likely, I will send a follow-up -- depending if Greg drops or
> keeps these in the tree.

Up to you.  I can drop them all now if you want to resend a v2 with all
of the aggregate acks, or you can send a follow-up set on top of these.

Your choice.

thanks,

greg k-h
