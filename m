From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] parport/serial: add support for Timedia/SUNIX cards to
 parport_serial
Date: Mon, 12 Jul 2010 17:56:49 +0100
Message-ID: <20100712175649.59b06a9a@lxorguk.ukuu.org.uk>
References: <1277511823-6973-1-git-send-email-fbriere@fbriere.net>
	<20100708121122.17d3e823@lxorguk.ukuu.org.uk>
	<20100712154448.GA2558@toroia.fbriere.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:56185 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751203Ab0GLQsQ (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 12 Jul 2010 12:48:16 -0400
In-Reply-To: <20100712154448.GA2558@toroia.fbriere.dyndns.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: =?ISO-8859-14?B?RnLpZOlyaWMgQnJp6HJl?= <fbriere@fbriere.net>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, linux-parport@lists.infradead.org

> Note that I did not bother to cache the result of find_quirk(), so it
> will be called twice.  I did not find it worth to add extra complexity
> just for that; let me know if you disagree.

Without seeing the code its hard to be sure - but it sounds reasonable,
serial port loading isn't usually a hot benchmarking path 8)
