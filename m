From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Are calls to activate/shutdown a port serialized?
Date: Fri, 18 Jan 2013 19:26:01 +0000
Message-ID: <20130118192601.26daa89a@pyramind.ukuu.org.uk>
References: <kdc2rv$m4g$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:57580 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753890Ab3ARTTJ (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 18 Jan 2013 14:19:09 -0500
In-Reply-To: <kdc2rv$m4g$1@ger.gmane.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Grant Edwards <grant.b.edwards@gmail.com>
Cc: linux-serial@vger.kernel.org

On Fri, 18 Jan 2013 18:04:47 +0000 (UTC)
Grant Edwards <grant.b.edwards@gmail.com> wrote:

> I ported an old tty driver to the new tty_port_ helper functions.  And
> I'm trying to track down a couple of bugs in the new version of the
> driver.
> 
> Are calls to the port's activate/shutdown methods serialized (either
> globally or per-port)?

The activate and shutdown methods are serialized by the per port mutex.

Alan
