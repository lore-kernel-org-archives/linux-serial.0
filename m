From: Alan Cox <alan@linux.intel.com>
Subject: Re: [PATCH 5/8] altera_uart: Make it possible to use Altera UART
 and 8250 ports together
Date: Fri, 1 Oct 2010 15:18:41 +0100
Message-ID: <20101001151841.3fad627c@linux.intel.com>
References: <20101001132045.GA9649@oksana.dev.rtsoft.ru>
	<20101001132207.GE25897@oksana.dev.rtsoft.ru>
	<20101001134138.5ea2fb55@linux.intel.com>
	<20101001135254.GA27739@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:61945 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753010Ab0JAPHj (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 1 Oct 2010 11:07:39 -0400
In-Reply-To: <20101001135254.GA27739@oksana.dev.rtsoft.ru>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Anton Vorontsov <cbouatmailru@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, Andrew Morton <akpm@linux-foundation.org>, Tobias Klauser <tklauser@distanz.ch>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org

> I guess the sane maximum number of ports would be 8, but it is still
> possible to do hundreds of them.

In that case you may just want to allocate a dynamic major instead - or
do you actually need a fixed major/minor for your boot up ?

