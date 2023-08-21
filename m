Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DFF5EE4996
	for <linux-serial@archiver.kernel.org>; Mon, 21 Aug 2023 19:37:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbjHUThB (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 21 Aug 2023 15:37:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbjHUThA (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 21 Aug 2023 15:37:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87A9AD9
        for <linux-serial@vger.kernel.org>; Mon, 21 Aug 2023 12:36:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1E2266340E
        for <linux-serial@vger.kernel.org>; Mon, 21 Aug 2023 19:36:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31D3CC433C8;
        Mon, 21 Aug 2023 19:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692646617;
        bh=rl8I9vHfekCec2hB8Jr0vSVQh/5vJOHHeO+sz3YLhVE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NKYgWzXNt+Wfk1QlHylP+0e2bxDDgLu48aMe8ca4j6x7UOvJU7ToPH+KAYp+p1JSb
         8XELuuB/aSH1CbziuqjqawGnfmTlHOTnor+4vdURgvMzfcDNoGgxWwMBxkijtLlxYf
         lyz4xCdLD3R0vCiLt+Ju3C0LZ0AeyWJ25e/6SxVA=
Date:   Mon, 21 Aug 2023 21:36:54 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Matthew Howell <matthew.howell@sealevel.com>
Cc:     linux-serial@vger.kernel.org, jeff.baldwin@sealevel.com,
        james.olson@sealevel.com, ryan.wenglarz@sealevel.com,
        darren.beeson@sealevel.com
Subject: Re: [PATCH 1/2] serial: exar: Remove Sealevel 7xxxC IDs
Message-ID: <2023082111-accustom-snaking-6055@gregkh>
References: <687157c-3d18-e18b-1936-f3f5b98ae760@sealevel.com>
 <2023082147-deduct-absently-186f@gregkh>
 <82dd7d4-2020-639-c63b-5955ccc08b63@sealevel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <82dd7d4-2020-639-c63b-5955ccc08b63@sealevel.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Aug 21, 2023 at 03:09:22PM -0400, Matthew Howell wrote:
> On Mon, 21 Aug 2023, Greg KH wrote:
> 
> > ⚠Caution: External email. Exercise extreme caution with links or attachments.⚠
> > 
> > 
> > On Mon, Aug 21, 2023 at 12:06:17PM -0400, Matthew Howell wrote:
> > > From: Matthew Howell <matthew.howell@sealevel.com>
> > >
> > > These Sealevel 7xxxC IDs are no longer needed because we (Sealevel) will
> > > be releasing the cards with the standard Exar hardware IDs. This is due
> > > to the selected IDs causing unexpected behaviors on some Windows systems.
> > >
> > > Reverts: 14ee78d ("Add support for Sealevel 7xxxC serial cards")
> > 
> > If this is a real "revert", then perhaps just do that revert instead?
> 
> I will try that if that is preferable.

It is please.

> > Also, as per our documentation, you need a sha1 a bit longer than that
> > :)
> 
> Sorry, I thought I had seen them referenced as 7 characters in other 
> posts. Will fix when I resubmit.
> 
> > 
> > And "Reverts:" isn't a valid tag, perhaps "Fixes:"?
> > 
> > And meta-note, your patch series was not linked together, how did you
> > send them?
> 
> I used Alpine. 
> Sorry for the hassle...but could you clarify how they should be linked? Do 
> you mean I should have sent the second patch as a reply to this one?

Yes.  That way our tools automatically pick it up as a patch series.

> I didn't see any specifics about patch linking in the documentation so I 
> am not/was not clear on the intended or 'best practice' way of linking 
> patches.

git send-email does it automatically for you, or you have to do it
manually if you don't use that, sorry.

thanks,

greg k-h
