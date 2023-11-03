Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ABF6C4332F
	for <linux-serial@archiver.kernel.org>; Fri,  3 Nov 2023 08:47:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234631AbjKCIrE (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 3 Nov 2023 04:47:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235102AbjKCIrE (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 3 Nov 2023 04:47:04 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56838D46
        for <linux-serial@vger.kernel.org>; Fri,  3 Nov 2023 01:46:58 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A7B6C433C8;
        Fri,  3 Nov 2023 08:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699001218;
        bh=9KQ+6a6k5saCigQMXLE862UmtEVhLUqokG4D38n2ChQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DsfRIkwPWT3WNNy+AQv+JZWji3AuwEdVvGoKiL++HV/jeO4gCZ1so86IrsoboSNio
         SaT+KmHMu8ZrVSaFS52uGmKU1C/p93coWjmQu3kEIPuuY22NXA8EP42myhkq0A/SmM
         +u4aRkGDu4CuxbgNQ++sZSyxgcnpvNNLVetRM4nk=
Date:   Fri, 3 Nov 2023 09:46:55 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     m.brock@vanmierlo.com
Cc:     linux-serial@vger.kernel.org,
        VAMSHI GAJJELA <vamshigajjela@google.com>
Subject: Re: tldp serial-howto subscribe link
Message-ID: <2023110335-aspect-cauterize-f85b@gregkh>
References: <b20a6176a3c83d2ac5bb708f458e7b89@vanmierlo.com>
 <2023110336-antiviral-gooey-91c5@gregkh>
 <4abb60ed10ae8cf64e4a1b51c5d7e8d2@vanmierlo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4abb60ed10ae8cf64e4a1b51c5d7e8d2@vanmierlo.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Nov 03, 2023 at 09:08:08AM +0100, m.brock@vanmierlo.com wrote:
> Greg KH schreef op 2023-11-03 06:39:
> > On Thu, Nov 02, 2023 at 06:00:29PM +0100, m.brock@vanmierlo.com wrote:
> > > Hello,
> > > 
> > > On the TLDP Serial HOWTO page 22.4 Serial Mailing List it says to
> > > mail to
> > > majordomo@vger.kernel.org to subscribe.
> > > However the link behind the visible text links to
> > > majordomo@vger.rutgers.edu
> > > This looks very dodgy to me.
> > > https://tldp.org/HOWTO/Serial-HOWTO-22.html
> > 
> > Please submit a change to the TLDP author, nothing we can do about it,
> > sorry.
> 
> OK, I will.
> 
> The obvious question remains:
> To subscribe one does have to mail to majordomo@vger.kernel.org, right?
> 
> And also to unsubscribe. I was hoping this was documented somewhere but it
> appears the obvious place is tainted.

The obvious place is on vger.kernel.org, specifically the link from the
front page to here:
	http://vger.kernel.org/majordomo-info.html

thanks,

greg k-h
