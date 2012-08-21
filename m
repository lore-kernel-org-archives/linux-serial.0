From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 0/3] serial: make serial_uart_config non-global
Date: Tue, 21 Aug 2012 10:06:11 +0100
Message-ID: <20120821100611.2cfd43c6@pyramind.ukuu.org.uk>
References: <1345506988-15390-1-git-send-email-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:54793 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752903Ab2HUJBx (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 21 Aug 2012 05:01:53 -0400
In-Reply-To: <1345506988-15390-1-git-send-email-paul.gortmaker@windriver.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: linux-serial@vger.kernel.org, Alan Cox <alan@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Hirokazu Takata <takata@linux-m32r.org>, "David S. Miller" <davem@davemloft.net>

On Mon, 20 Aug 2012 19:56:25 -0400
Paul Gortmaker <paul.gortmaker@windriver.com> wrote:

> I happened to notice that serial_uart_config was largely a relic
> of the past and only used by two drivers (one of which was just
> a trivial use case) so it seemed to make sense to reduce its scope
> by removing the trivial use case and giving exclusive ownership
> of the struct to the one real remaining user (sparc's sunsu.c).
> 
> Build tested on sparc64 defconfig and m32r defconfig.

Looks good to me from the tty side.

