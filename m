From: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Add the ability to layer another driver over the serial
 driver
Date: Mon, 11 Dec 2006 10:20:16 +0000
Message-ID: <20061211102016.43e76da2@localhost.localdomain>
References: <4533B8FB.5080108@mvista.com>
	<20061210201438.tilman@imap.cc>
	<Pine.LNX.4.60.0612102117590.9993@poirot.grange>
	<457CB32A.2060804@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:57623 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1762712AbWLKKMk (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 11 Dec 2006 05:12:40 -0500
In-Reply-To: <457CB32A.2060804@mvista.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Corey Minyard <cminyard@mvista.com>
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Tilman Schmidt <tilman@imap.cc>, linux-serial@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>, Hansjoerg Lipp <hjlipp@web.de>, Russell Doty <rdoty@redhat.com>

On Sun, 10 Dec 2006 19:23:54 -0600
Corey Minyard <cminyard@mvista.com> wrote:

> Nothing has come of this yet.  But we have these two requests and a 
> request from Russell Doty at Redhat.
> 
> It would be nice to know if this type of thing was acceptable or not, 
> and the problems with the patch.  The patch is at 
> http://home.comcast.net/~minyard

This looks wrong. You already have a kernel interface to serial drivers.
It is called a line discipline. We use it for ppp, we use it for slip, we
use it for a few other things such as attaching sync drivers to some
devices.

Discussions of the form  "my line discipline has no way to do 'xyz'" are
the ones that need to happen IMHO.

Alan
