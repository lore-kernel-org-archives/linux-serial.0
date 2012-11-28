From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 5/5] serial: 8250_dw: Set FIFO size dynamically
Date: Wed, 28 Nov 2012 13:18:26 +0000
Message-ID: <20121128131826.38391319@pyramind.ukuu.org.uk>
References: <1354106924-11013-1-git-send-email-heikki.krogerus@linux.intel.com>
	<1354106924-11013-6-git-send-email-heikki.krogerus@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:43994 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754562Ab2K1NNK (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 28 Nov 2012 08:13:10 -0500
In-Reply-To: <1354106924-11013-6-git-send-email-heikki.krogerus@linux.intel.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <alan@linux.intel.com>, Jamie Iles <jamie@jamieiles.com>, linux-serial@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

> +	if (!reg || (reg & 0xff) != '*')
> +		return;
> +

That looks bogus. If reg == 0 then reg & 0xFF != '*'

So why the double test ?

