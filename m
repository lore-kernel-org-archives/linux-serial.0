Return-Path: <SRS0=FKjJ=45=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39963C1975A
	for <linux-serial@archiver.kernel.org>; Thu, 12 Mar 2020 09:05:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1442D206F1
	for <linux-serial@archiver.kernel.org>; Thu, 12 Mar 2020 09:05:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725980AbgCLJFS (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 12 Mar 2020 05:05:18 -0400
Received: from smtprelay0063.hostedemail.com ([216.40.44.63]:59210 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725978AbgCLJFS (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 12 Mar 2020 05:05:18 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 6D305837F27B;
        Thu, 12 Mar 2020 09:05:17 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: shape63_855ac344c041b
X-Filterd-Recvd-Size: 2102
Received: from XPS-9350.home (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf19.hostedemail.com (Postfix) with ESMTPA;
        Thu, 12 Mar 2020 09:05:16 +0000 (UTC)
Message-ID: <40896bca8a4418b8afe99767cad9a15967617ae1.camel@perches.com>
Subject: Re: [PATCH -next 005/491] ARM/UNIPHIER ARCHITECTURE: Use
 fallthrough;
From:   Joe Perches <joe@perches.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Thu, 12 Mar 2020 02:03:33 -0700
In-Reply-To: <20200312085606.GA154268@kroah.com>
References: <cover.1583896344.git.joe@perches.com>
         <dae0878058223a42c77d725b8d7c5845a7ef9dc0.1583896348.git.joe@perches.com>
         <CAK7LNAS7GAk9yXkPhbS3ByU+n9Gb-rk0PeLcXLCNwpW1B22aeg@mail.gmail.com>
         <891a42ad8d8fd7beca911845108e1ded022ef3f7.camel@perches.com>
         <20200312085606.GA154268@kroah.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, 2020-03-12 at 09:56 +0100, Greg Kroah-Hartman wrote:
> On Wed, Mar 11, 2020 at 07:31:07AM -0700, Joe Perches wrote:
> > On Wed, 2020-03-11 at 14:15 +0900, Masahiro Yamada wrote:
> > > On Wed, Mar 11, 2020 at 2:07 PM Joe Perches <joe@perches.com> wrote:
> > > > Convert the various uses of fallthrough comments to fallthrough;
> > > > 
> > > > Done via script
> > > > Link: https://lore.kernel.org/lkml/b56602fcf79f849e733e7b521bb0e17895d390fa.1582230379.git.joe.com/
> > > > 
> > > > Signed-off-by: Joe Perches <joe@perches.com>
> > > 
> > > Acked-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> > > 
> > > 
> > > But, I think the patch subject should be prefixed:
> > > "serial: 8250_uniphier:"
> > 
> > Yeah thanks, that's difficult to script though.
> > 
> > 
> 
> Kernel development is hard :)

Not really, kernel development processes are pretty stupid sometimes.


