From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: kmscon: replacing CONFIG_VT
Date: Wed, 16 May 2012 17:14:21 +0100
Message-ID: <20120516171421.5fca49f3@pyramind.ukuu.org.uk>
References: <CANq1E4SGoRZaGjNZqPOA6g4COQmXxNr4kFBPMhxAonZqO_aOtQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:47245 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751991Ab2EPQL0 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 16 May 2012 12:11:26 -0400
In-Reply-To: <CANq1E4SGoRZaGjNZqPOA6g4COQmXxNr4kFBPMhxAonZqO_aOtQ@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: David Herrmann <dh.herrmann@googlemail.com>
Cc: linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>

> That's just some of my ideas on this topic. Maybe you can give me some
> hints whether it actually makes sense ;)

For a lot of hardware it may not matter. If it goes bang you boot with a
debugging kernel (one containing a vt driver)

If your user space goes castors up early then you are going to need input
facilities anyway (consider the fedora rescue mode in dracut for example) 

As far as compatibility goes we have the ttyprintk driver which just
provides a fake tty which types nothing and whose output goes to the
console.

Alan
