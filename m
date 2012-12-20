From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 1/2] tty: remove redundant initialization in
 initialize_tty_struct()
Date: Thu, 20 Dec 2012 15:55:21 +0000
Message-ID: <20121220155521.289b9f42@pyramind.ukuu.org.uk>
References: <1353681708-5413-1-git-send-email-clouds.yan@gmail.com>
	<20121123145107.22bab04c@pyramind.ukuu.org.uk>
	<CAH+=+MEpjwXUnD0Hey18fRbvY56wDHVmD5L1PsHwK_QmHCg4TA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:55352 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751228Ab2LTPsm (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 20 Dec 2012 10:48:42 -0500
In-Reply-To: <CAH+=+MEpjwXUnD0Hey18fRbvY56wDHVmD5L1PsHwK_QmHCg4TA@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Yan Hong <clouds.yan@gmail.com>
Cc: gregkh@linuxfoundation.org, linux-serial@vger.kernel.org

On Fri, 23 Nov 2012 23:04:52 +0800
Yan Hong <clouds.yan@gmail.com> wrote:

> 2012/11/23 Alan Cox <alan@lxorguk.ukuu.org.uk>:
> > On Fri, 23 Nov 2012 22:41:47 +0800
> > Yan Hong <clouds.yan@gmail.com> wrote:
> >
> >> tty_struct is already zeroed, no need to zero its field again.
> >
> > True but its asking for impossible to find bugs later if this changes
> 
> If it's true, we should have concern for all memset() usage. Is this
> case special?

Slowly catchng up on stuff. The problem in this case is that the
allocator and init methods are in different function. As you rightly
observe they don't need to be. Perhaps a better patch would be told fold
them together and remove the memset ?

Alan
