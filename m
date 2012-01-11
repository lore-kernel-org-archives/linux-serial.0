From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: tty/serial: Need clarification on Support for 4+M Baudrate
Date: Wed, 11 Jan 2012 12:30:25 +0000
Message-ID: <20120111123025.244a9cf5@pyramind.ukuu.org.uk>
References: <20120111121901.GA4034@bnru05>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:43603 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753588Ab2AKM3u (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 11 Jan 2012 07:29:50 -0500
In-Reply-To: <20120111121901.GA4034@bnru05>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Rajanikanth H V <rajanikanth.hv@stericsson.com>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, gregkh@sude.de, linux-arm-kernel@lists.infradead.org

On Wed, 11 Jan 2012 17:49:01 +0530
> I have a requirement to interface UART with an external microcontroller 
> using baud rate above 4Mbps, hence following is my approach to apply
> the changes. Can any one review/provide me appropriate approach.

See TCGETS2/TCSETS2 and the BOTHER flag.

The kernel supports aetting arbitary baud rates already.

Alan
