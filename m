Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EFF5C83F33
	for <linux-serial@archiver.kernel.org>; Mon,  4 Sep 2023 06:17:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239873AbjIDGRd (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 4 Sep 2023 02:17:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232234AbjIDGRc (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 4 Sep 2023 02:17:32 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35DD1E6
        for <linux-serial@vger.kernel.org>; Sun,  3 Sep 2023 23:17:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 2DB90CE0204
        for <linux-serial@vger.kernel.org>; Mon,  4 Sep 2023 06:17:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04B6DC433C8;
        Mon,  4 Sep 2023 06:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693808244;
        bh=Pz/bVXPLL+jua8Qtb1n56RzjE2CLDanhm/Fe+ijrF94=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0z4cM7+93bA0uHqRUZ9rwvyBEr6WcSXbTWOw1+0G4ksDZkzIkT5/NMOA+ATHm6y/c
         3jKvpwM35dgACCtiGZMdsUdmYTAn64Od5VmWIp+uAsbgkjJoKk6uNSgS9IVF8ljm/C
         n1TQMTMvkMuxcuoQaNbJt2A8pWRA4O1ZcRyzY+oQ=
Date:   Mon, 4 Sep 2023 07:17:21 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "yiyang (D)" <yiyang13@huawei.com>
Cc:     davem@davemloft.net, jirislaby@kernel.org, jag.raman@oracle.com,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH] tty: vcc: Add check for kstrdup() in vcc_probe()
Message-ID: <2023090400-sweat-algebra-1f34@gregkh>
References: <20230903101322.205537-1-yiyang13@huawei.com>
 <2023090321-conch-stopper-51c7@gregkh>
 <b73d22ba-8f19-286e-9441-ac456bf37be5@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b73d22ba-8f19-286e-9441-ac456bf37be5@huawei.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Sep 04, 2023 at 11:45:11AM +0800, yiyang (D) wrote:
> On 2023/9/3 18:49, Greg KH wrote:
> > On Sun, Sep 03, 2023 at 06:13:22PM +0800, Yi Yang wrote:
> > > Add check for the return value of kstrdup() and return the error, if it
> > > fails in order to avoid NULL pointer dereference.
> > > 
> > > Fixes: 5d171050e28f ("sparc64: vcc: Enable VCC port probe and removal")
> > > Signed-off-by: Yi Yang <yiyang13@huawei.com>
> > > ---
> > >   drivers/tty/vcc.c | 9 +++++++++
> > >   1 file changed, 9 insertions(+)
> > > 
> > > diff --git a/drivers/tty/vcc.c b/drivers/tty/vcc.c
> > > index a39ed981bfd3..420d334f6077 100644
> > > --- a/drivers/tty/vcc.c
> > > +++ b/drivers/tty/vcc.c
> > > @@ -579,6 +579,10 @@ static int vcc_probe(struct vio_dev *vdev, const struct vio_device_id *id)
> > >   		return -ENOMEM;
> > >   	name = kstrdup(dev_name(&vdev->dev), GFP_KERNEL);
> > > +	if (!name) {
> > > +		kfree(port);
> > > +		return -ENOMEM;
> > 
> > Please just add another goto target later in the function like the rest
> > of the error paths follow.
> Ok, i will send v2 patch for this issue.
> > 
> > And how did you test this patch?
> > 
> I use crosstool-ng build sparc arch for open CONFIG_VCC.

That is build-testing, how did you functionally test that this works
properly?

thanks,

greg k-h
