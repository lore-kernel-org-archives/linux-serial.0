From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] serial_core: fix printk format warnings
Date: Sat, 20 Sep 2008 18:15:12 -0700 (PDT)
Message-ID: <20080920.181512.80505160.davem@davemloft.net>
References: <20080921011131.GA16153@orion>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:41058
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1751583AbYIUBPZ (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 20 Sep 2008 21:15:25 -0400
In-Reply-To: <20080921011131.GA16153@orion>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: a.beregalov@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, alan@lxorguk.ukuu.org.uk, akpm@linux-foundation.org

From: Alexander Beregalov <a.beregalov@gmail.com>
Date: Sun, 21 Sep 2008 05:11:31 +0400

> drivers/serial/serial_core.c:2158: warning: format '%x' expects type
> 'unsigned int', but argument 4 has type 'long unsigned int'
> drivers/serial/serial_core.c:2162: warning: format '%x' expects type
> 'unsigned int', but argument 4 has type 'long unsigned int
> 
> Signed-off-by: Alexander Beregalov <a.beregalov@gmail.com>

This is because of a patch of mine that Andrew added to -mm,
which changed the ioport to be an unsigned long.

I have some updates which I'll send to Andrew which should
cure this.
