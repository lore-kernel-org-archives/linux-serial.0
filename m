Return-Path: <SRS0=FKjJ=45=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2EC4C10DCE
	for <linux-serial@archiver.kernel.org>; Thu, 12 Mar 2020 14:17:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1EA720650
	for <linux-serial@archiver.kernel.org>; Thu, 12 Mar 2020 14:17:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727365AbgCLORJ (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 12 Mar 2020 10:17:09 -0400
Received: from smtprelay0072.hostedemail.com ([216.40.44.72]:45724 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727123AbgCLORJ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 12 Mar 2020 10:17:09 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 51ABE8139;
        Thu, 12 Mar 2020 14:17:08 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: music20_5b3c53998c133
X-Filterd-Recvd-Size: 2957
Received: from XPS-9350.home (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf17.hostedemail.com (Postfix) with ESMTPA;
        Thu, 12 Mar 2020 14:17:06 +0000 (UTC)
Message-ID: <520264e86bcba45ba8cb721ca54b81e56e5df42e.camel@perches.com>
Subject: Re: [PATCH -next 005/491] ARM/UNIPHIER ARCHITECTURE: Use
 fallthrough;
From:   Joe Perches <joe@perches.com>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Thu, 12 Mar 2020 07:15:23 -0700
In-Reply-To: <20200312134712.GE7159@mit.edu>
References: <cover.1583896344.git.joe@perches.com>
         <dae0878058223a42c77d725b8d7c5845a7ef9dc0.1583896348.git.joe@perches.com>
         <CAK7LNAS7GAk9yXkPhbS3ByU+n9Gb-rk0PeLcXLCNwpW1B22aeg@mail.gmail.com>
         <891a42ad8d8fd7beca911845108e1ded022ef3f7.camel@perches.com>
         <20200312085606.GA154268@kroah.com>
         <CAK7LNAS98yeCeFZpKgNRRKcFhXSKWQ7Ka4vP90YcY=ufScZRCw@mail.gmail.com>
         <fa07756217b3c033c7e5af495a03ff5655947450.camel@perches.com>
         <20200312134712.GE7159@mit.edu>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, 2020-03-12 at 09:47 -0400, Theodore Y. Ts'o wrote:
> On Thu, Mar 12, 2020 at 02:37:31AM -0700, Joe Perches wrote:
> > As I have suggested a few times, better still
> > would be to have a mechanism for scripted patches
> > applied possibly as single treewide patch.
> > 
> > Likely applied only at an -rc1.
> > 
> > The stated negatives to a treewide mechanism
> > have been difficulty to backport to -stable.
> 
> Any time we do a massive, disruptive change to the code base, it's
> going to cause problems to -stable.  It means that bug fix patches
> won't necessarily auto-apply, and some will require manual fixups
> afterwards

That's mostly a tools problem than a real problem.

> Given that this change doesn't really fix any bugs, I'd have to ask
> the question --- is it *worth* it?  We really need to apply a certain
> amount of cost/benefit analysis around this.
> 
> If it were really important, the thing we could do is to apply a
> single treewide patch at some point after the merge window.  I'd
> suggest after -rc2, myself, but reasonable people can differ.  And
> then, if it were *really* important we could run the same script on
> the stable kernels.
> 
> But for changing "/* fallthrough */" to "fallthrough;"
> 
> Does this ***really*** matter?

That depends a bit on whether clang is your
compiler of choice.

> Why are we tying ourselves up in knots
> trying to do this all at once?

Discretely or treewide, all at once or done over time,
the impact problem to backports is the same.


