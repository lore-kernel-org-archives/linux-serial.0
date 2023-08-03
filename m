Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8C0FC04A6A
	for <linux-serial@archiver.kernel.org>; Thu,  3 Aug 2023 11:38:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231926AbjHCLiS (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 3 Aug 2023 07:38:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234201AbjHCLiR (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 3 Aug 2023 07:38:17 -0400
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EA3E1FC2;
        Thu,  3 Aug 2023 04:38:16 -0700 (PDT)
Received: from quatroqueijos.cascardo.eti.br (1.general.cascardo.us.vpn [10.172.70.58])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id F25AA41E37;
        Thu,  3 Aug 2023 11:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1691062694;
        bh=xx4Tcbc2ObE5c7kZDfQSL8uT46BntCbhbdol+jV52Ak=;
        h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
         Content-Type:In-Reply-To;
        b=nLg6gIsIlr2+pfos/c66qyRIdcGwpYvlGpI8gaNykg1zcdHnVu1H0NEQK3b2BbsWy
         OzG0HCxn5qw0WvdBcHRpu9dDv6HoyOtjnQoKIReDqqfhYoT0FNKlEbsLFu+lcR0chB
         BLVXnaSVhm1nz1YC/TR2QxcvfQ+vpHOT7gEagrnsQ18XVTO/r9LDP9ztHC9ph5kQnE
         ZHuqjCSSC9wP5Wzqn4rOqS4HpKZjQ09O2lF1S7nncGlmt9qDTi80SNLsqoyg1bLzf/
         OkQtJDQrrZcP03VMSvwYOBjty3bxb80q/43LyssvakoBKTgghGApODUbcQbR1kfU4A
         +xXBmGQW5FDiQ==
Date:   Thu, 3 Aug 2023 08:38:08 -0300
From:   Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jirislaby@kernel.org>, ofono@ofono.org
Subject: Re: [PATCH] tty: n_gsm: require CAP_NET_ADMIN to attach N_GSM0710
 ldisc
Message-ID: <ZMuRoDbMcQrsCs3m@quatroqueijos.cascardo.eti.br>
References: <20230731185942.279611-1-cascardo@canonical.com>
 <2023080111-lucid-stiffness-ccfa@gregkh>
 <ZMkCWL4r9Z35j3hC@quatroqueijos.cascardo.eti.br>
 <2023080344-happiness-duffel-c6ee@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023080344-happiness-duffel-c6ee@gregkh>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Aug 03, 2023 at 09:48:24AM +0200, Greg Kroah-Hartman wrote:
> On Tue, Aug 01, 2023 at 10:02:16AM -0300, Thadeu Lima de Souza Cascardo wrote:
> > On Tue, Aug 01, 2023 at 06:53:30AM +0200, Greg Kroah-Hartman wrote:
> > > On Mon, Jul 31, 2023 at 03:59:42PM -0300, Thadeu Lima de Souza Cascardo wrote:
> > > > Any unprivileged user can attach N_GSM0710 ldisc, but it requires
> > > > CAP_NET_ADMIN to create a GSM network anyway.
> > > > 
> > > > Require initial namespace CAP_NET_ADMIN to do that.
> > > > 
> > > > Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
> > > 
> > > What commit id does this fix?  Or has this always been a problem?
> > > 
> > > thanks,
> > > 
> > > greg k-h
> > 
> > This has always been like this. It is not really fixing a specific commit, but
> > introducing further restriction on access.
> 
> So by restricting access, will this now break existing userspace tools
> that do not have this permission?  I'm all for tightening up
> permissions, but we can't break existing workflows without a good
> reason.
> 
> thanks,
> 
> greg k-h

Yes, this will break any userspace trying to attach this without those
permissions.

I was under the impression that some operations on the line discipline also
required those same permissions, but they are actually operations on the
virtual demux ttys. So, at least we should change that on the commit
message.

The good reason to do it is reducing attack surface, given known bugs
in this code (see
https://lore.kernel.org/all/CA+UBctCZok5FSQ=LPRA+A-jocW=L8FuMVZ_7MNqhh483P5yN8A@mail.gmail.com/T/#u).

This has been done for N_HCI too
(https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c05731d0c6bd9a625e27ea5c5157ebf1303229e0).

The only significant user I found looking at codesearch.debian.net was
ofono, but I am having trouble finding out if the project is still active.
I am copying their list anyway here, in case it finds anyone who could tell
us that they are fine requiring such privileges.

Cascardo.
