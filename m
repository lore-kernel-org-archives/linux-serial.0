From: Feng Tang <feng.tang@intel.com>
Subject: Re: [PATCH v4] serial: spi: add spi-uart driver for Maxim 3110
Date: Tue, 2 Mar 2010 11:38:17 +0800
Message-ID: <20100302113817.155f78aa@feng-i7>
References: <20100224131130.61530b62@feng-i7>
	<20100226114729.679bb933@feng-i7>
	<201002260959.o1Q9xIVA021953@imail.sm.sony.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:62233 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751231Ab0CBDgo (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 1 Mar 2010 22:36:44 -0500
In-Reply-To: <201002260959.o1Q9xIVA021953@imail.sm.sony.co.jp>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Masakazu Mokuno <mokuno@sm.sony.co.jp>
Cc: Greg KH <greg@kroah.com>, David Brownell <dbrownell@users.sourceforge.net>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, spi-devel-list <spi-devel-general@lists.sourceforge.net>, Andrew Morton <akpm@linux-foundation.org>, "alan@lxorguk.ukuu.org.uk" <alan@lxorguk.ukuu.org.uk>, Grant Likely <grant.likely@secretlab.ca>

On Fri, 26 Feb 2010 17:59:38 +0800
Masakazu Mokuno <mokuno@sm.sony.co.jp> wrote:

> Hi,
> 
> > +	u8 *pbuf, valid_str[M3110_RX_FIFO_DEPTH];
> > +	int i, j;
> > +
> > +	memset(obuf, 0, sizeof(obuf));
> > +	memset(obuf, 0, sizeof(ibuf));
> 
> memset(ibuf, 0, sizeof(ibuf))?

thanks for the catch, here is a follow on patch


diff --git a/drivers/serial/max3110.c b/drivers/serial/max3110.c
index 3283ba6..3dd2082 100644
--- a/drivers/serial/max3110.c
+++ b/drivers/serial/max3110.c
@@ -142,7 +142,7 @@ static int max3110_read_multi(struct uart_max3110 *max, u8 *buf)
 	int i, j;
 
 	memset(obuf, 0, sizeof(obuf));
-	memset(obuf, 0, sizeof(ibuf));
+	memset(ibuf, 0, sizeof(ibuf));
 
 	if (max3110_write_then_read(max, obuf, ibuf,
 				M3110_RX_FIFO_DEPTH * 2, 1))
