Return-Path: <SRS0=FKjJ=45=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EBD1C10DCE
	for <linux-serial@archiver.kernel.org>; Thu, 12 Mar 2020 09:39:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 448A92071B
	for <linux-serial@archiver.kernel.org>; Thu, 12 Mar 2020 09:39:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725978AbgCLJjR (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 12 Mar 2020 05:39:17 -0400
Received: from smtprelay0161.hostedemail.com ([216.40.44.161]:35044 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725268AbgCLJjR (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 12 Mar 2020 05:39:17 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 2FF6710FA8;
        Thu, 12 Mar 2020 09:39:16 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: match59_8af9430b5bd5c
X-Filterd-Recvd-Size: 3208
Received: from XPS-9350.home (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf16.hostedemail.com (Postfix) with ESMTPA;
        Thu, 12 Mar 2020 09:39:14 +0000 (UTC)
Message-ID: <fa07756217b3c033c7e5af495a03ff5655947450.camel@perches.com>
Subject: Re: [PATCH -next 005/491] ARM/UNIPHIER ARCHITECTURE: Use
 fallthrough;
From:   Joe Perches <joe@perches.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Thu, 12 Mar 2020 02:37:31 -0700
In-Reply-To: <CAK7LNAS98yeCeFZpKgNRRKcFhXSKWQ7Ka4vP90YcY=ufScZRCw@mail.gmail.com>
References: <cover.1583896344.git.joe@perches.com>
         <dae0878058223a42c77d725b8d7c5845a7ef9dc0.1583896348.git.joe@perches.com>
         <CAK7LNAS7GAk9yXkPhbS3ByU+n9Gb-rk0PeLcXLCNwpW1B22aeg@mail.gmail.com>
         <891a42ad8d8fd7beca911845108e1ded022ef3f7.camel@perches.com>
         <20200312085606.GA154268@kroah.com>
         <CAK7LNAS98yeCeFZpKgNRRKcFhXSKWQ7Ka4vP90YcY=ufScZRCw@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, 2020-03-12 at 18:02 +0900, Masahiro Yamada wrote:
> On Thu, Mar 12, 2020 at 5:56 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> > On Wed, Mar 11, 2020 at 07:31:07AM -0700, Joe Perches wrote:
> > > On Wed, 2020-03-11 at 14:15 +0900, Masahiro Yamada wrote:
> > > > On Wed, Mar 11, 2020 at 2:07 PM Joe Perches <joe@perches.com> wrote:
> > > > > Convert the various uses of fallthrough comments to fallthrough;
> > > > > 
> > > > > Done via script
> > > > > Link: https://lore.kernel.org/lkml/b56602fcf79f849e733e7b521bb0e17895d390fa.1582230379.git.joe.com/
> > > > > 
> > > > > Signed-off-by: Joe Perches <joe@perches.com>
> > > > 
> > > > Acked-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> > > > 
> > > > 
> > > > But, I think the patch subject should be prefixed:
> > > > "serial: 8250_uniphier:"
> > > 
> > > Yeah thanks, that's difficult to script though.
> > > 
> > > 
> > 
> > Kernel development is hard :)
> 
> It is strange to process this per-platform
> and to send out a giant series that
> consists of 491 patches.
> 
> This is very trivial conversion.
> 
> I think it is better to have a single patch
> to convert all files under drivers/tty/serial/,
> with the patch subject "serial:".

The difficulty there is determining where these
subsystem spanning blocks should begin and end.

That could not be done for instance with drivers/net.

As I have suggested a few times, better still
would be to have a mechanism for scripted patches
applied possibly as single treewide patch.

Likely applied only at an -rc1.

The stated negatives to a treewide mechanism
have been difficulty to backport to -stable.

Perhaps a mechanism like

	git format-patch --stdout <treewide_commit_to_backport> | \
	git apply --include=<specific_files>

with some automated rewrite of the treewide patch subject
then commit could help.


