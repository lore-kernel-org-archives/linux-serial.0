Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DCACC433ED
	for <linux-serial@archiver.kernel.org>; Thu,  6 May 2021 08:36:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C2B2611EE
	for <linux-serial@archiver.kernel.org>; Thu,  6 May 2021 08:36:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233683AbhEFIg7 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 6 May 2021 04:36:59 -0400
Received: from smtprelay0164.hostedemail.com ([216.40.44.164]:52380 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231880AbhEFIg6 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 6 May 2021 04:36:58 -0400
Received: from omf17.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 4F6073AA1;
        Thu,  6 May 2021 08:36:00 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf17.hostedemail.com (Postfix) with ESMTPA id 5723727DD24;
        Thu,  6 May 2021 08:35:59 +0000 (UTC)
Message-ID: <e5ca055cf46147537748c7186a6a031ab7663ad8.camel@perches.com>
Subject: Re: [PATCH 34/35] tty: make tty_get_byte_size available
From:   Joe Perches <joe@perches.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jiri Slaby <jslaby@suse.cz>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Thu, 06 May 2021 01:35:57 -0700
In-Reply-To: <CAHp75Vfq6ABW7ukwaKmZOF2DszmuHD28S=wcLcFowvRdXTnWmg@mail.gmail.com>
References: <20210505091928.22010-1-jslaby@suse.cz>
         <20210505091928.22010-35-jslaby@suse.cz>
         <ef1bd57095e941560530be43806791966a6735ad.camel@perches.com>
         <CAHp75Vfq6ABW7ukwaKmZOF2DszmuHD28S=wcLcFowvRdXTnWmg@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5723727DD24
X-Stat-Signature: ke3k7xx4cm6mimiofs3a5tirptzm3dzu
X-Rspamd-Server: rspamout03
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19x4xpf+W6xR+O8u5Q/AyNDO2+RXwv1hcU=
X-HE-Tag: 1620290159-971624
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, 2021-05-06 at 11:24 +0300, Andy Shevchenko wrote:
> On Thursday, May 6, 2021, Joe Perches <joe@perches.com> wrote:
[]
> > Perhaps clearer not testing account_flags multiple times.
> > 
> > unsigned char tty_get_byte_size(unsigned int cflag, bool account_flags)
> > {
> >         unsigned char bits;
> > 
> >         /* byte size and parity */

nit:  byte size, the parity bit is tested later.

> >         switch (cflag & CSIZE) {
> >         case CS5:
> >                 bits = 5;
> >                 break;
> >         case CS6:
> >                 bits = 6;
> >                 break;
> >         case CS7:
> >                 bits = 7;
> >                 break;
> >         case CS8:
> >         default:
> >                 bits = 8;
> >                 break;
> >         }
> > 
> >         if (account_flags) {
> 
> 
> 
> if (!account_flags)
>   return bits;
> 
> ?

<shrug> six vs half dozen: 2 level indentation vs early return.

I don't think 2 level indentation is too many.

> >                 bits += 2;      /* start/stop bits */
> > 
> >                 if (cflag & CSTOPB)
> >                         bits++;
> > 
> >                 if (cflag & PARENB)
> >                         bits++;
> >         }

Maybe comment each test as CSTOPB and PARENB aren't completely obvious.

