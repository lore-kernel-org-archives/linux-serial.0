Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C624C433EF
	for <linux-serial@archiver.kernel.org>; Mon, 23 May 2022 12:09:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235172AbiEWMJs (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 23 May 2022 08:09:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235148AbiEWMJr (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 23 May 2022 08:09:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EB1E22BE5;
        Mon, 23 May 2022 05:09:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EA799B8109E;
        Mon, 23 May 2022 12:09:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA54AC385A9;
        Mon, 23 May 2022 12:09:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1653307783;
        bh=p6rZ2zM1FC2efZwGYkFt1sj3JIxc0Nuo/u+VEVyj3TE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Sb61cDQjor/fhDAPSF3q0F2C208ENaXhk99lb3vfIBTeph/QlRiS9yMB7Bq20m1qV
         VpfNUOh7tpoYaBsGwl9+cJDqyOiRGk7ylIxaQ82ofK1DQK8nkWmH/nZb5HkLmbnMBf
         sK/JgsECwIZ/PMi3hTQTJG9PoddQLXSR+6rkRFRE=
Date:   Mon, 23 May 2022 14:09:39 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Starke, Daniel" <daniel.starke@siemens.com>
Cc:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "jirislaby@kernel.org" <jirislaby@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/9] tty: n_gsm: fix user open not possible at
 responder until initiator open
Message-ID: <Yot5gwXsdqGvkJCQ@kroah.com>
References: <DB9PR10MB58810877B0B37B6212471415E0D49@DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB9PR10MB58810877B0B37B6212471415E0D49@DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, May 23, 2022 at 08:45:06AM +0000, Starke, Daniel wrote:
> > > +/**
> > > + *	gsm_dlci_wait_open	-	wait for channel open procedure
> > > + *	@dlci: DLCI to open
> > > + *
> > > + *	Wait for a DLCI opening from the other side. Asynchronously wait until
> > > + *	we get a SABM and set off timers and the responses.
> > > + */
> > > +static void gsm_dlci_wait_open(struct gsm_dlci *dlci) {
> > > +	switch (dlci->state) {
> > > +	case DLCI_CLOSED:
> > > +	case DLCI_CLOSING:
> > > +		dlci->state = DLCI_OPENING;
> > > +		break;
> > > +	default:
> > > +		break;
> > > +	}
> > > +}
> > 
> > The documentation for this function is odd, you are not waiting for
> > anything.  You are just changing the state.  This makes no sense as-is,
> > sorry.
> 
> Thank you for your comment. I have prepared a new version. I will send it
> after the other 8 patches have been commented.

No, please fix up and resend the series, it is long gone from my review
queue.

thanks,

greg k-h
