Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6B6CC25B67
	for <linux-serial@archiver.kernel.org>; Fri, 27 Oct 2023 07:22:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232306AbjJ0HWI (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 27 Oct 2023 03:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230369AbjJ0HWH (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 27 Oct 2023 03:22:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44CFE1AC;
        Fri, 27 Oct 2023 00:22:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69AF7C433C8;
        Fri, 27 Oct 2023 07:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698391324;
        bh=Qg4YTpWg2YhUPY+UM5NUghA/FNgriO1WcVRTdtepE0g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wXGY6vb4/zA35H4eUGZmPVpMsKXmZU9dd5cAz2aTp+nx1+2heJyN+8yOXVM6jTz/3
         QoWc21EtM2aPLnRYMC86f6ZKzUhDmrij9U6yslpqNCGGJxfTI8PMhIYHnW+p2CBkDG
         n9NttdeSqo+XFSS7mxBqQtAg1vbNGqMaux50bvrw=
Date:   Fri, 27 Oct 2023 09:22:01 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "D. Starke" <daniel.starke@siemens.com>
Cc:     linux-serial@vger.kernel.org, jirislaby@kernel.org,
        ilpo.jarvinen@linux.intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] tty: n_gsm: add copyright Siemens Mobility GmbH
Message-ID: <2023102726-divided-improving-efb2@gregkh>
References: <20231027053903.1886-1-daniel.starke@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231027053903.1886-1-daniel.starke@siemens.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Oct 27, 2023 at 07:39:03AM +0200, D. Starke wrote:
> From: Daniel Starke <daniel.starke@siemens.com>
> 
> More than 1/3 of the n_gsm code has been contributed by us in the last
> 1.5 years, completing conformance with the standard and stabilizing the
> driver:
> - added UI (unnumbered information) frame support
> - added PN (parameter negotiation) message handling and function support
> - added optional keep-alive control link supervision via test messages
> - added TIOCM_OUT1 and TIOCM_OUT2 to allow responder to operate as modem
> - added TIOCMIWAIT support on virtual ttys
> - added additional ioctls and parameters to configure the new functions
> - added overall locking mechanism to avoid data race conditions
> - added outgoing data flow to decouple physical from virtual tty handling
>   for better performance and to avoid dead-locks
> - fixed advanced option mode implementation
> - fixed convergence layer type 2 implementation
> - fixed handling of CLD (multiplexer close down) messages
> - fixed broken muxer close down procedure
> - and many more bug fixes
> 
> With this most of our initial RFC has been implemented. It gives the driver
> a quality boost unseen in the decade before.
> 
> Add a copyright notice to the n_gsm files to highlight this contribution.
> 
> Link: https://lore.kernel.org/all/20220225080758.2869-1-daniel.starke@siemens.com/
> Signed-off-by: Daniel Starke <daniel.starke@siemens.com>
> ---
>  drivers/tty/n_gsm.c         | 1 +
>  include/uapi/linux/gsmmux.h | 1 +
>  2 files changed, 2 insertions(+)

Nit, you didn't include what changed from v1 below the --- line.

I'll take this now, but be more careful in the future.

thanks,

greg k-h
