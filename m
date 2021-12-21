Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BCABC433F5
	for <linux-serial@archiver.kernel.org>; Tue, 21 Dec 2021 10:06:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231712AbhLUKGU (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 21 Dec 2021 05:06:20 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:35440 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbhLUKGU (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 21 Dec 2021 05:06:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 895BFB815A6
        for <linux-serial@vger.kernel.org>; Tue, 21 Dec 2021 10:06:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B36FDC36AE2;
        Tue, 21 Dec 2021 10:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1640081178;
        bh=WJfezBOTBIhblpb34cSk/pZZXYr8CRn0iJO4bHfe/DQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a68bVWi8xfmUFLEtUALwSgeTV50bNTwwLifvSaJ71YnsAB4CSGXlAS9J3CbP/RlcW
         qziCdH2EqD7hY5faeFmdK+2vt671JyrGXPst4SVaaEiDFq31DiJ6wb2ZFuBJpTYqWp
         Tzwzjn9LAlMi9NgbRFFUfAoyhqut83cx1y+X4Heo=
Date:   Tue, 21 Dec 2021 11:06:15 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mathieu Peyrega <mathieu.peyrega@gmail.com>
Cc:     linux-serial@vger.kernel.org, jirislaby@kernel.org,
        giometti@linux.it
Subject: Re: [PATCH] Allow PPS on CTS pin and non-RS232 UARTs
Message-ID: <YcGnF8KC0lJ180Vc@kroah.com>
References: <bc2d427e30e24978be5800c41f921b9d782570e7.camel@gmail.com>
 <YaoXfxwSeVVWUWUJ@kroah.com>
 <14a35918ecc95199066ea78c7814cf71bcd9e52e.camel@gmail.com>
 <YcCkk8ck91Nt4F0R@kroah.com>
 <9d5477e0046927fe95badb63e53af7251c5667a5.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9d5477e0046927fe95badb63e53af7251c5667a5.camel@gmail.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Dec 21, 2021 at 10:36:39AM +0100, Mathieu Peyrega wrote:
> Le lundi 20 décembre 2021 à 16:43 +0100, Greg KH a écrit :
> > On Sat, Dec 04, 2021 at 04:57:56PM +0100, Mathieu Peyrega wrote:
> > > Le vendredi 03 décembre 2021 à 14:11 +0100, Greg KH a écrit :
> > > > On Thu, Dec 02, 2021 at 11:56:10AM +0100, Mathieu Peyrega wrote:
> > > > > 
> > I don't fully understand the point. Isn't the existing pps_ldisc
> > > module
> > > already affecting the whole system ? (with it's builtin fixed
> > > "options"). How different tunable options such as the proposal make
> > > things fundamentally different ? Still I agree that per device
> > > settings
> > > would be better.
> > 
> > Per device settings are required, this would prevent multiple devices
> > working in the same system, one using the existing line discipline
> > functionality, and one with your new changes.
> 
> Is this per device settings requierement valid also for a new line
> discipline module or is it acceptable if a new "module level settable"
> linee discipline module has also a global behaviour (as current one)
> ?If per tty device setting is requiered pointers/doc on possible
> exemples/mecanismes to achieve this are welcome.

If you make this a new line discipline, that is fine, as you can set
each tty device to have their own discipline.

But do not have options for that line discipline, on a module-basis,
that way will not work (think about multiple devices all using the same
line discipline.)

> > Try this as a new line discipline, should be much easier and simpler
> > overall for everyone.
> 
> I have been working a little on this already, was waiting for list
> comments/answers to proceed further.
> Is there a prefered name as the module is mostly a clone of the pps-
> ldisc current one one with first patch changes ? I went for ppsex-ldisc 
> for now.
> Is it Ok to share & modify the C structures of pps-ldisc (especially
> tty_ldisc_ops as per initially proposed patch) or should a full new set
> also be added ?

I do not know, let's see what you think would work and post that and we
can go from there.

thanks,

greg k-h
