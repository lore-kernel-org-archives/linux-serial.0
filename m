From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 9/9] tty : make receive_room internal to N_TTY line
 discipline
Date: Mon, 5 Mar 2012 10:36:42 +0000
Message-ID: <20120305103642.4b622148@pyramind.ukuu.org.uk>
References: <1330883960-8563-1-git-send-email-castet.matthieu@free.fr>
	<1330883960-8563-10-git-send-email-castet.matthieu@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:53158 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756418Ab2CEKeq (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 5 Mar 2012 05:34:46 -0500
In-Reply-To: <1330883960-8563-10-git-send-email-castet.matthieu@free.fr>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Matthieu CASTET <castet.matthieu@free.fr>
Cc: linux-serial@vger.kernel.org, Felipe Balbi <balbi@ti.com>, Toby Gray <toby.gray@realvnc.com>, Stefan Bigler <stefan.bigler@keymile.com>

On Sun,  4 Mar 2012 18:59:20 +0100
Matthieu CASTET <castet.matthieu@free.fr> wrote:

> NOTE : capi need fixing

capi should be listening to the tty flow control responses too.

You've made another significant undocumented change in this lot - you've
removed the ability of an ldisc to control the largest chunk of data that
may be thrown at it per call to the ldisc. I don't think anyone cares
about it, but it needs checking and clearly documenting as its a
significant API change.
