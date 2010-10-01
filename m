From: Alan Cox <alan@linux.intel.com>
Subject: Re: [PATCH 5/8] altera_uart: Make it possible to use Altera UART
 and 8250 ports together
Date: Fri, 1 Oct 2010 15:57:56 +0100
Message-ID: <20101001155756.54e9716c@linux.intel.com>
References: <20101001132045.GA9649@oksana.dev.rtsoft.ru>
	<20101001132207.GE25897@oksana.dev.rtsoft.ru>
	<20101001134138.5ea2fb55@linux.intel.com>
	<20101001135254.GA27739@oksana.dev.rtsoft.ru>
	<20101001151841.3fad627c@linux.intel.com>
	<20101001152258.GA14846@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:52155 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751065Ab0JAPqz (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 1 Oct 2010 11:46:55 -0400
In-Reply-To: <20101001152258.GA14846@oksana.dev.rtsoft.ru>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Anton Vorontsov <cbouatmailru@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, Andrew Morton <akpm@linux-foundation.org>, Tobias Klauser <tklauser@distanz.ch>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org

> I don't need it, but someone might.

Why ?

> Plus, it doesn't solve anything as there are only 256 minor
> numbers. ;-) If we ever want  to support the insane number of Altera
> UARTs, we'll have to solve it very differently. For now, I'd vote for
> keeping it simple.

We got past the 256/256 limit some time ago.

Alan
