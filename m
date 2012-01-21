From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 0/2] tty: serial: OMAP: work around broken driver, IP
 block
Date: Sat, 21 Jan 2012 20:46:32 +0000
Message-ID: <20120121204632.17ce598e@pyramind.ukuu.org.uk>
References: <20120121071934.18707.64258.stgit@dusk>
	<20120121125522.GA19027@kroah.com>
	<alpine.DEB.2.00.1201211323410.28153@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:46276 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750863Ab2AUUpl (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 21 Jan 2012 15:45:41 -0500
In-Reply-To: <alpine.DEB.2.00.1201211323410.28153@utopia.booyaka.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Greg KH <greg@kroah.com>, linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Govindraj Raja <govindraj.raja@ti.com>, Kevin Hilman <khilman@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

> I will do it, although I do cling to the hope that others will help.

I always work on the basis that if its had some coverage testing then the
other folks who might have been affected should have reviewed the patch.
They opted not to, within reason - their lookout.

They'll only test it later when it his the tree if they don't do it
earlier 8)

Alan
