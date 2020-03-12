Return-Path: <SRS0=FKjJ=45=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72748C10DCE
	for <linux-serial@archiver.kernel.org>; Thu, 12 Mar 2020 13:47:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 459CE2071B
	for <linux-serial@archiver.kernel.org>; Thu, 12 Mar 2020 13:47:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbgCLNr3 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 12 Mar 2020 09:47:29 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:36694 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725978AbgCLNr2 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 12 Mar 2020 09:47:28 -0400
Received: from callcc.thunk.org (pool-72-93-95-157.bstnma.fios.verizon.net [72.93.95.157])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 02CDlCBO022469
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Mar 2020 09:47:14 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id BD68C420E5E; Thu, 12 Mar 2020 09:47:12 -0400 (EDT)
Date:   Thu, 12 Mar 2020 09:47:12 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Joe Perches <joe@perches.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next 005/491] ARM/UNIPHIER ARCHITECTURE: Use fallthrough;
Message-ID: <20200312134712.GE7159@mit.edu>
References: <cover.1583896344.git.joe@perches.com>
 <dae0878058223a42c77d725b8d7c5845a7ef9dc0.1583896348.git.joe@perches.com>
 <CAK7LNAS7GAk9yXkPhbS3ByU+n9Gb-rk0PeLcXLCNwpW1B22aeg@mail.gmail.com>
 <891a42ad8d8fd7beca911845108e1ded022ef3f7.camel@perches.com>
 <20200312085606.GA154268@kroah.com>
 <CAK7LNAS98yeCeFZpKgNRRKcFhXSKWQ7Ka4vP90YcY=ufScZRCw@mail.gmail.com>
 <fa07756217b3c033c7e5af495a03ff5655947450.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa07756217b3c033c7e5af495a03ff5655947450.camel@perches.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Mar 12, 2020 at 02:37:31AM -0700, Joe Perches wrote:
> As I have suggested a few times, better still
> would be to have a mechanism for scripted patches
> applied possibly as single treewide patch.
> 
> Likely applied only at an -rc1.
> 
> The stated negatives to a treewide mechanism
> have been difficulty to backport to -stable.

Any time we do a massive, disruptive change to the code base, it's
going to cause problems to -stable.  It means that bug fix patches
won't necessarily auto-apply, and some will require manual fixups
afterwards

Given that this change doesn't really fix any bugs, I'd have to ask
the question --- is it *worth* it?  We really need to apply a certain
amount of cost/benefit analysis around this.

If it were really important, the thing we could do is to apply a
single treewide patch at some point after the merge window.  I'd
suggest after -rc2, myself, but reasonable people can differ.  And
then, if it were *really* important we could run the same script on
the stable kernels.

But for changing "/* fallthrough */" to "fallthrough;"

Does this ***really*** matter?  Why are we tying ourselves up in knots
trying to do this all at once?

					- Ted
