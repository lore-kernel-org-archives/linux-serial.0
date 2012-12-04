From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH -next 0/9] tty: Fix buffer work access-after-free
Date: Tue, 4 Dec 2012 14:30:01 +0000
Message-ID: <20121204143001.306c9079@pyramind.ukuu.org.uk>
References: <1354604865-10278-1-git-send-email-peter@hurleysoftware.com>
	<20121204085426.389ca79b@bob.linux.org.uk>
	<1354629480.475.7.camel@thor>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:51975 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750765Ab2LDOZc (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 4 Dec 2012 09:25:32 -0500
In-Reply-To: <1354629480.475.7.camel@thor>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Alan Cox <alan@linux.intel.com>, Ilya Zykov <ilya@ilyx.ru>, Jiri Slaby <jslaby@suse.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org

> I assume you mean somewhere other than ml archives:
> https://lkml.org/lkml/2012/12/1/57

Putting in the commit message would be idea given how short it is.

> 
> Setting up a mini-testsuite is good idea. As I noted in that email
> though, that test jig is a derivative work that I'd want a ok from Ilya
> Zykov to put somewhere more permanent.

Sure
