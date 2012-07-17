From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: ST16C654 stoppes transmitting after a while
Date: Tue, 17 Jul 2012 17:38:47 +0100
Message-ID: <20120717173847.1c5b4863@pyramind.ukuu.org.uk>
References: <20120717074355.80180@gmx.net>
	<20120717105229.17b578a5@pyramind.ukuu.org.uk>
	<20120717100521.219440@gmx.net>
	<20120717122140.075aa7ae@pyramind.ukuu.org.uk>
	<20120717113603.9830@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:37454 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755005Ab2GQQfD (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 17 Jul 2012 12:35:03 -0400
In-Reply-To: <20120717113603.9830@gmx.net>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Tobias Arp <tobiasarp@gmx.de>
Cc: linux-serial@vger.kernel.org

On Tue, 17 Jul 2012 13:36:03 +0200
"Tobias Arp" <tobiasarp@gmx.de> wrote:

> This is a single core arm processor (Cirrus EP9315), could this race condition happen in this case? 

In theory, otoh it ought to be quite easy to test for.

How fast are your links - would it be fair to characterise your
environment as a fairly slow CPU handling a lot of fast serial links

(just trying to understand what the likely places to look might be)

