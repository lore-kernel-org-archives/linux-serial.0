From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: bad serial port count when trying to login
Date: Thu, 8 Mar 2012 11:24:42 +0000
Message-ID: <20120308112442.7a6ccd54@pyramind.ukuu.org.uk>
References: <CAMFeL9+jmN9GWfrhkbd+VP-CWH2VjHpUcWr4Sw4TOv+3YRKC7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:59943 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752089Ab2CHLWi (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 8 Mar 2012 06:22:38 -0500
In-Reply-To: <CAMFeL9+jmN9GWfrhkbd+VP-CWH2VjHpUcWr4Sw4TOv+3YRKC7g@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Subodh Nijsure <nijsure.subodh@gmail.com>
Cc: linux-serial@vger.kernel.org

> I am running 3.1.0-rc5 kernel.
> 
> Can someone give me clues as to why this might be and clues on fixing it.

So you have a bug in an older kernel snapshot that isn't a release. I'd
suggest trying to duplicate it in an actual final 3.2 kernel as a
starting point.

Alan
