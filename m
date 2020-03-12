Return-Path: <SRS0=FKjJ=45=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02861C10DCE
	for <linux-serial@archiver.kernel.org>; Thu, 12 Mar 2020 08:56:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D11E0206FA
	for <linux-serial@archiver.kernel.org>; Thu, 12 Mar 2020 08:56:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584003371;
	bh=8QZh21af5Fq8pk6AVSwtgBWIbWoSoo/av/UThU89jgk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wFAm94HAY24VGoACUEaCy77+EpkwytoU5yVZBQ9Ofr+3D5TH12nJdG4kUsZssjUFT
	 OL9S1hv1jdBdjsmavGVfsSwOVrx73kGD+kvtKkSndGCWNmDqcwtwmfDA45y56xY2l6
	 wNrg6ksKI2z5CyvvEUaLH79ijb2HS8pS2EMGH0iE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725980AbgCLI4L (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 12 Mar 2020 04:56:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:38080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725978AbgCLI4L (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 12 Mar 2020 04:56:11 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 804AB20578;
        Thu, 12 Mar 2020 08:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584003369;
        bh=8QZh21af5Fq8pk6AVSwtgBWIbWoSoo/av/UThU89jgk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sTEfR3h6Df7AETe+7aig03ZmzrrMs3fYM5/vV9O9ydYgT6/GmR43kj99xShU9Dy4y
         hYaKcWsWo9Ni06FAEMg49ds5PlA3w05JlPYen+utH/iySKROYqOBHrnEwv4MvsM7ZU
         yQYjUfOI7rE8qyRSyJxf7hxeaWEjyu1T2x8RL0x8=
Date:   Thu, 12 Mar 2020 09:56:06 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Joe Perches <joe@perches.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next 005/491] ARM/UNIPHIER ARCHITECTURE: Use fallthrough;
Message-ID: <20200312085606.GA154268@kroah.com>
References: <cover.1583896344.git.joe@perches.com>
 <dae0878058223a42c77d725b8d7c5845a7ef9dc0.1583896348.git.joe@perches.com>
 <CAK7LNAS7GAk9yXkPhbS3ByU+n9Gb-rk0PeLcXLCNwpW1B22aeg@mail.gmail.com>
 <891a42ad8d8fd7beca911845108e1ded022ef3f7.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <891a42ad8d8fd7beca911845108e1ded022ef3f7.camel@perches.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Mar 11, 2020 at 07:31:07AM -0700, Joe Perches wrote:
> On Wed, 2020-03-11 at 14:15 +0900, Masahiro Yamada wrote:
> > On Wed, Mar 11, 2020 at 2:07 PM Joe Perches <joe@perches.com> wrote:
> > > Convert the various uses of fallthrough comments to fallthrough;
> > > 
> > > Done via script
> > > Link: https://lore.kernel.org/lkml/b56602fcf79f849e733e7b521bb0e17895d390fa.1582230379.git.joe.com/
> > > 
> > > Signed-off-by: Joe Perches <joe@perches.com>
> > 
> > Acked-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> > 
> > 
> > But, I think the patch subject should be prefixed:
> > "serial: 8250_uniphier:"
> 
> Yeah thanks, that's difficult to script though.
> 
> 

Kernel development is hard :)
