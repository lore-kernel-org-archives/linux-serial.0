Return-Path: <SRS0=rp3o=ZH=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B79DEC432C3
	for <linux-serial@archiver.kernel.org>; Fri, 15 Nov 2019 04:52:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EFA62072B
	for <linux-serial@archiver.kernel.org>; Fri, 15 Nov 2019 04:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573793564;
	bh=X9Awlksr0z2CgRgfURqkxlePLo3ULHdFz2wTUo2KWek=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=C/nT1oam3mUQ7ZxsfDBP+Qkz+ucLIWBy1FGuQUzh1Dc0jvhzMbIDneC5HoCz8Bf0N
	 W+KtZugi/QuN6rQ3BcOctv0WWN2m6VFuE5sJzNWU0LaWVAN0384GAaL91J5WJOvxL7
	 Ha0lQi2DHr9VBPKI0HmS8GpSuRQwrV2foyGnJ2EA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbfKOEwo (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 14 Nov 2019 23:52:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:53460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726755AbfKOEwn (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 14 Nov 2019 23:52:43 -0500
Received: from localhost (unknown [104.132.150.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7F9B82072A;
        Fri, 15 Nov 2019 04:52:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573793563;
        bh=X9Awlksr0z2CgRgfURqkxlePLo3ULHdFz2wTUo2KWek=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yxsQj6BvGubsPI2Nr/0ho4xKj2rG+pnk9pRL+uMis1HYXKBTsGwP8sxr9rojbnLRa
         qgFv9m9EeDdRUEbgGpOSV5wp92y63y9aUuYfggtC4aArpHF+x9GlADL7B4XwEknArI
         xm5uLRgk5SL1pfRZyaQdS0iuJ/lKSnHrEvykrmLs=
Date:   Fri, 15 Nov 2019 12:52:40 +0800
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Akash Asthana <akashast@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org,
        mgautam@codeaurora.org, swboyd@chromium.org,
        msavaliy@codeaurora.org
Subject: Re: [PATCH v5 1/3] tty: serial: qcom_geni_serial: IRQ cleanup
Message-ID: <20191115045240.GA799309@kroah.com>
References: <1573642111-17479-1-git-send-email-akashast@codeaurora.org>
 <20191113105603.GA2083219@kroah.com>
 <8aacf270-7e0f-8f8f-aac6-4cdaf6d3fd21@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8aacf270-7e0f-8f8f-aac6-4cdaf6d3fd21@codeaurora.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Nov 15, 2019 at 10:11:40AM +0530, Akash Asthana wrote:
> 
> On 11/13/2019 4:26 PM, Greg KH wrote:
> > On Wed, Nov 13, 2019 at 04:18:31PM +0530, Akash Asthana wrote:
> > > Move ISR registration from startup to probe function to avoid registering
> > > it everytime when the port open is called for driver.
> > > 
> > > Signed-off-by: Akash Asthana <akashast@codeaurora.org>
> > > ---
> > > Changes in v5:
> > >   - No change.
> > This series does not apply at all to my tty-next branch of my tty git
> > tree.  What did you make it against?  Please rebase it and resend so
> > that it can be applied.
> > 
> > thanks,
> > 
> > greg k-h
> 
> Please revert below 2 commits and apply the patches in series.
> 
> 1) 8b7103f31950443fd5727d7d80d3c65416b5a390   (v2 patch)
> 
> 2) 3e4aaea7a0391d47f6ffff1f10594c658a67c881 (v2 patch)
> 
> I have verified the same on tty-next branch, it's applying cleanly.

Can you please send me a series that does the revert and then has your
new patches?  Or change your patches to work cleanly on the tty-next
branch, I don't want to have to do reverts "by hand" like this.

Also, how in the world was I supposed to know to do this?  Please be
considerate of maintainers, we are overworked as it is...

thanks,

greg k-h
