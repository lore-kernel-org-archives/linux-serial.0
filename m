Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 315F2E92708
	for <linux-serial@archiver.kernel.org>; Thu,  5 Oct 2023 14:47:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239267AbjJEOrD (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 5 Oct 2023 10:47:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239903AbjJEOop (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 5 Oct 2023 10:44:45 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 651959F6DF;
        Thu,  5 Oct 2023 07:22:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6C68C4339A;
        Thu,  5 Oct 2023 06:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696485946;
        bh=rk5p7W6fSQ6pw6CpBqK3HLdmoCK6lM1ieyuWARySvic=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sokU60XWR+EfzHCLK43tEYXy9berTkNUZW7mZfQDwM+Gy8WwKE/QBiiHNzSNYyYZu
         +TZoEIZQJX7vZnZcroCoGDmOlAJGfBIUAPcCjHZAco68IpYXvgsOmE7Eba5u/3V6bt
         Ew4u7dLEay8PA73HpCunzek9VBixgSGGjtb8QJXY=
Date:   Thu, 5 Oct 2023 08:05:43 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org,
        Daniel Starke <daniel.starke@siemens.com>,
        Fedor Pchelkin <pchelkin@ispras.ru>,
        linux-serial@vger.kernel.org,
        syzbot+5f47a8cea6a12b77a876@syzkaller.appspotmail.com
Subject: Re: [PATCH 1/1] tty: n_gsm: Avoid sleeping during .write() whilst
 atomic
Message-ID: <2023100511-unpeeled-dinginess-fefd@gregkh>
References: <20231003170020.830242-1-lee@kernel.org>
 <2023100320-immorally-outboard-573a@gregkh>
 <20231003185500.GD8453@google.com>
 <2023100457-entail-freefall-06fd@gregkh>
 <20231004090918.GB9374@google.com>
 <2023100425-unwieldy-reaffirm-2a1b@gregkh>
 <20231004125758.GB83257@google.com>
 <1c2afee3-6c1b-4703-8b9a-487f96a2526b@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1c2afee3-6c1b-4703-8b9a-487f96a2526b@kernel.org>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Oct 05, 2023 at 06:59:50AM +0200, Jiri Slaby wrote:
> On 04. 10. 23, 14:57, Lee Jones wrote:
> > > > n_gsm is available on all the systems I have available.  The mention of
> > > > 'EXPERIMENTAL' in the module description appears to have zero effect on
> > > > whether distros choose to make it available or not.  If you're saying
> > > > that we know this module is BROKEN however, then perhaps we should mark
> > > > it as such.
> > > 
> > > Also, I think this requires root to set this line discipline to the
> > > console, right?  A normal user can't do that, or am I missing a code
> > > path here?
> > 
> > I haven't been testing long, but yes, early indications show that root
> > is required.
> 
> FWIW I concluded to the same yesterday, so I disputed the connected
> CVE-2023-31082. Waiting for mitre's ack/nack.

Trying to dispute obviously-wrong CVEs is a never-ending task.

Personally, it's fun to see who keeps popping up to attempt to resolve
this issue showing what companies have their security policies dictated
by a random government authority that can be modified by anyone :)

thanks,

greg k-h
