Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=78.133.224.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793743667;
	b=tuSNQqJkt9ha9iu1os1GrOnvitr1s76Ps2YXK3hRmtxgPdAyhRVnW52q0eScrf8uYJ8N
	 cYoX0KOxkaX7TCnnWtLb7Q1jxNsybGg6G2716CijErs09rbEJKumFZVT45sAka6DpHcHV
	 +7lURZGGIBA2xs5EmdgMcqcbX9sBf4aDNOCQpQf0frH6i8W9CjWGQFYGIB94Lpq0UAYsr
	 PdS/f7PWO5Om0+fXOjMI0YthY7CQPjp0+V7F+6wbj29sBPLD8+qBe/2L4NfSooYLRzkYN
	 9toN71cxMNbdC6Hp4ITlpdwEcJGkzIm9noE3mkzsB25ek7wfbwHExWndQCy/zctQMLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793743667;
	h=DMARC-Filter:Received:Received:Date:From:To:cc:Subject:In-Reply-To:
	 Message-ID:References:User-Agent:MIME-Version:Content-Type;
	bh=UDI7sUsKEij0jrk7ILM/ulFIQjp3W29FDN0HhYS2v4s=;
	b=SVOYW179/9QeaQfU1FwS9pY0JUFzSL8CPzxovVF9suY7ptf/wiGXJOLTFm63xi9ze8Hj
	 q1E24KnzTRkgs5dOHJhhsVkjFBVPZrNxG7QNdVAK5+tBDcv3moqxZEKTE5qgZe0pkOlt6
	 M88um0KNbjyPIblb9+g8eHR2Y910oc2kviXhL+eP6cPZdzMmAl0p7prDfxCxj73dwFuNg
	 w6Om0XvoNFiILSrBKjuHgmPeZiiOoQjBfZOuqaZ3wPZno6P2TOqy704Blg7sKtH4Q77c0
	 Wfe+/8OJ/wsqwgtnskz7OiDYLea0EDc65Veeulm/HVx/tyH4u86TNIkkSRqDeH5CCeA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=orcam.me.uk;
	spf=none smtp.mailfrom=orcam.me.uk;
	arc=none smtp.remote-ip=78.133.224.34
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E694606A32E;
	Tue,  3 Nov 2026 22:07:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8E694606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 0BFE692009E; Tue,  3 Nov 2026 23:07:45 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 0823992009C;
	Tue,  3 Nov 2026 22:07:45 +0000 (GMT)
Date: Tue, 3 Nov 2026 22:07:44 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>
cc: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
    =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>, 
    Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
    Crescent Hsieh <crescentcy.hsieh@moxa.com>, 
    Hugo Villeneuve <hvilleneuve@dimonoff.com>, 
    Johan Hovold <johan@kernel.org>, John Ogness <john.ogness@linutronix.de>, 
    Karl Mehltretter <kmehltretter@gmail.com>, linux-kernel@vger.kernel.org, 
    linux-serial@vger.kernel.org
Subject: [PATCH v3 1/2] serial: core: Unify uart_get_baud_rate() success
 return paths
In-Reply-To: <alpine.DEB.2.21.2611030057510.15685@angie.orcam.me.uk>
Message-ID: <alpine.DEB.2.21.2611032029130.15685@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2611030057510.15685@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

In preparation to adding extra return actions merge the two success 
return paths in uart_get_baud_rate() into one.

Since as from commit 091ea8e5d34e ("serial: core: prevent division by 
zero by always returning non-zero baud rate") it is now guaranteed that 
the B0 baud rate is within [min; max], deferring to the regular return 
path in the B0 case causes no functional change.

That is as long as max >= max(min, 9600), which I believe is always the 
case and none of UART hardware our drivers provide support for has its 
highest baud rate below 9600.

Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
---
New change in v3.
---
 drivers/tty/serial/serial_core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

linux-serial-uart-get-baud-rate-return.diff
Index: linux-macro/drivers/tty/serial/serial_core.c
===================================================================
--- linux-macro.orig/drivers/tty/serial/serial_core.c
+++ linux-macro/drivers/tty/serial/serial_core.c
@@ -515,7 +515,7 @@ uart_get_baud_rate(struct uart_port *por
 		 * Special case: B0 rate.
 		 */
 		if (baud == 0)
-			return max(min, 9600);
+			baud = max(min, 9600);
 
 		if (baud >= min && baud <= max)
 			return baud;
