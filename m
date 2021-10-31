Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19C60C433EF
	for <linux-serial@archiver.kernel.org>; Sun, 31 Oct 2021 15:34:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E33B260F93
	for <linux-serial@archiver.kernel.org>; Sun, 31 Oct 2021 15:34:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbhJaPh0 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 31 Oct 2021 11:37:26 -0400
Received: from smtprelay0027.hostedemail.com ([216.40.44.27]:34218 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229734AbhJaPh0 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 31 Oct 2021 11:37:26 -0400
Received: from omf01.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id B3D52837F24D;
        Sun, 31 Oct 2021 15:34:53 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf01.hostedemail.com (Postfix) with ESMTPA id CDAEE17277;
        Sun, 31 Oct 2021 15:34:51 +0000 (UTC)
Message-ID: <b42482be11d04963fed0903ce1bd983742efc5c6.camel@perches.com>
Subject: Re: [PATCH] drivers: tty: replace snprintf in show functions with
 sysfs_emit
From:   Joe Perches <joe@perches.com>
To:     Greg KH <gregkh@linuxfoundation.org>, cgel.zte@gmail.com
Cc:     jirislaby@kernel.org, johan@kernel.org, macro@orcam.me.uk,
        fancer.lancer@gmail.com, andrew@aj.id.au, pali@kernel.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jing Yao <yao.jing2@zte.com.cn>, Zeal Robot <zealci@zte.com.cn>
Date:   Sun, 31 Oct 2021 08:34:50 -0700
In-Reply-To: <YXuKMo14CCM1iHMG@kroah.com>
References: <20211028101350.14172-1-yao.jing2@zte.com.cn>
         <YXuKMo14CCM1iHMG@kroah.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: CDAEE17277
X-Stat-Signature: f6n4d7pczgg7tem16s3y5qwpawx7q89o
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18pLsj/JxrLBiU0vma/+p4e2qR0q4Co738=
X-HE-Tag: 1635694491-566448
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, 2021-10-29 at 07:44 +0200, Greg KH wrote:
> On Thu, Oct 28, 2021 at 10:13:50AM +0000, cgel.zte@gmail.com wrote:
> > From: Jing Yao <yao.jing2@zte.com.cn>
> > 
> > Reported-by: Zeal Robot <zealci@zte.com.cn>
> 
> Please fix your broken "robot" before submitting any more patches to the
> Linux kernel project.

There's no indication the robot and the patch author/submitter are
the same.

I think the "robot" _reporting_ the issue is reasonable, but not the
patch author/submitter.

Though whatever the "Zeal Robot" is should likely be public otherwise
the Reported-by: reference isn't useful.


