Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25199C433ED
	for <linux-serial@archiver.kernel.org>; Thu,  6 May 2021 05:56:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1EAF613B5
	for <linux-serial@archiver.kernel.org>; Thu,  6 May 2021 05:56:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232985AbhEFF5c (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 6 May 2021 01:57:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:47736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232750AbhEFF51 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 6 May 2021 01:57:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 69E6C61176;
        Thu,  6 May 2021 05:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1620280583;
        bh=5A+cxZCpW9PshKuw+VRDeiYXmxkSDofsAEWN00JBE9M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vWCnPRXYStPE6IhDlhTzMhVUw52AqboMCZVafMFFej62brb9avM8ZrZaoO67uUfz2
         hPwzetDoHXEm0QyOirsSluoPsO8J1I/KgdykiMqvoq0+ANYVU0FgQQsPHOl3qUNtqw
         J+d3LfrFohhNyNCvpiIbd6yXeUEKrdvq3zCHCPtE=
Date:   Thu, 6 May 2021 07:56:19 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Richard Henderson <rth@twiddle.net>
Subject: Re: [PATCH 25/35] tty: remove tty_operations::chars_in_buffer for
 non-buffering
Message-ID: <YJOFAzDSMsVZbu3I@kroah.com>
References: <20210505091928.22010-1-jslaby@suse.cz>
 <20210505091928.22010-26-jslaby@suse.cz>
 <40c8a109-9161-621e-f8cd-c43fdba6dac2@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40c8a109-9161-621e-f8cd-c43fdba6dac2@kernel.org>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, May 06, 2021 at 07:47:04AM +0200, Jiri Slaby wrote:
> On 05. 05. 21, 11:19, Jiri Slaby wrote:
> > The only user of tty_ops::chars_in_buffer is tty_chars_in_buffer. And it
> > considers tty_ops::chars_in_buffer optional. In case it's NULL, zero is
> > returned. So remove all those chars_in_buffer from tty_ops which return
> > zero. (Zero means such driver doesn't buffer.)
> > 
> > Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> 
> 
> > c: Richard Henderson <rth@twiddle.net>
> 
> Uh, "C" is a fugitive. Wanted dead or alive.
> 
> So should I send a v2 with:
> Cc: Richard Henderson <rth@twiddle.net>
> ?

Nah, it should be fine, I can fix it up.

thanks,

greg k-h
