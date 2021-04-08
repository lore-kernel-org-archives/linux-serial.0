Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AFB6C433ED
	for <linux-serial@archiver.kernel.org>; Thu,  8 Apr 2021 06:37:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FAEB6113E
	for <linux-serial@archiver.kernel.org>; Thu,  8 Apr 2021 06:37:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbhDHGh0 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 8 Apr 2021 02:37:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:37816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229691AbhDHGhZ (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 8 Apr 2021 02:37:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5785E610A5;
        Thu,  8 Apr 2021 06:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617863834;
        bh=hdn0RucHG6wQm39zVXEr9bkiyYJ1su7yvPXnXwKhJ88=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PHeSY1cXFiZaeAbp1jIO5q2YjnT5HhmrOUKbPC7gM99Oj+kBBZMyZqLmAkaCbqdO+
         baK5JT4ByT1MLYDY1y2e38tskVEwXDFHpyNtqxSRXQ51/8Pd0TKZvfmI8hbJ96AtEe
         dvig75abgvOnmYC5rbIVhdmRP9M+KsXW4dQFmmas=
Date:   Thu, 8 Apr 2021 08:37:12 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Zev Weiss <zev@bewilderbeest.net>
Cc:     Joel Stanley <joel@jms.id.au>, openbmc@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Andrew Jeffery <andrew@aj.id.au>,
        Rob Herring <robh+dt@kernel.org>,
        Lubomir Rintel <lkundrak@v3.sk>,
        - <devicetree@vger.kernel.org>, linux-serial@vger.kernel.org
Subject: Re: [PATCH v4 1/4] dt-bindings: serial: 8250: deprecate
 aspeed,sirq-polarity-sense
Message-ID: <YG6kmNBhGhe0JGwA@kroah.com>
References: <20210402182724.20848-1-zev@bewilderbeest.net>
 <20210402182724.20848-2-zev@bewilderbeest.net>
 <YG3NR4bGRjIGZhgx@kroah.com>
 <YG3kJC+6gLC6RzzQ@hatter.bewilderbeest.net>
 <YG3q9brKTC4pkQbs@kroah.com>
 <YG3yEeIRKgTjnDxz@hatter.bewilderbeest.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YG3yEeIRKgTjnDxz@hatter.bewilderbeest.net>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Apr 07, 2021 at 12:55:29PM -0500, Zev Weiss wrote:
> On Wed, Apr 07, 2021 at 12:25:09PM CDT, Greg Kroah-Hartman wrote:
> > On Wed, Apr 07, 2021 at 11:56:04AM -0500, Zev Weiss wrote:
> > > On Wed, Apr 07, 2021 at 10:18:31AM CDT, Greg Kroah-Hartman wrote:
> > > > On Fri, Apr 02, 2021 at 01:27:21PM -0500, Zev Weiss wrote:
> > > > > This property ties SIRQ polarity to SCU register bits that don't
> > > > > necessarily have any direct relationship to it; the only use of it
> > > > > was removed in commit c82bf6e133d30e0f9172a20807814fa28aef0f67.
> > > >
> > > > Please write that as:
> > > > 	c82bf6e133d3 ("ARM: aspeed: g5: Do not set sirq polarity")
> > > >
> > > 
> > > Ack, will do.
> > > 
> > > > > Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
> > > > > Reviewed-by: Joel Stanley <joel@jms.id.au>
> > > > > ---
> > > > >  Documentation/devicetree/bindings/serial/8250.yaml | 1 +
> > > > >  1 file changed, 1 insertion(+)
> > > >
> > > > What changed from previous versions?  That always goes below the ---
> > > > line.
> > > >
> > > 
> > > I included an overview of that in the cover letter (https://lore.kernel.org/openbmc/20210402182724.20848-1-zev@bewilderbeest.net/);
> > > is it desirable to also have that duplicated in the individual patches in
> > > the series?
> > 
> > Any reason why you didn't include all of the relevant people and mailing
> > lists in that cover letter?  I've never seen it before :)
> > 
> 
> Ah -- is there a good rule of thumb (or git send-email trick) for that?
> Set-union of get_maintainer.pl over all the patches in the series?

There might be a git send-email trick, but I don't know it :(
