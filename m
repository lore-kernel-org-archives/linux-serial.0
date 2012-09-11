From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 06/12] tty/serial/kgdboc: Add and wire up clear_irqs
 callback
Date: Tue, 11 Sep 2012 15:15:40 +0100
Message-ID: <20120911151540.362001c6@pyramind.ukuu.org.uk>
References: <20120911093042.GA12471@lizard>
	<1347356106-25368-6-git-send-email-anton.vorontsov@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:53439 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754854Ab2IKOLK (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 11 Sep 2012 10:11:10 -0400
In-Reply-To: <1347356106-25368-6-git-send-email-anton.vorontsov@linaro.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Anton Vorontsov <anton.vorontsov@linaro.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Russell King <linux@arm.linux.org.uk>, Jason Wessel <jason.wessel@windriver.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <alan@linux.intel.com>, Arve =?UTF-8?B?SGrDuG5uZXbDpWc=?= <arve@android.com>, Colin Cross <ccross@android.com>, Brian Swetland <swetland@google.com>, John Stultz <john.stultz@linaro.org>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linaro-kernel@lists.linaro.org, patches@linaro.org, kernel-team@android.com, kgdb-bugreport@lists.sourceforge.net, linux-serial@vger.kernel.org

On Tue, 11 Sep 2012 02:35:00 -0700
Anton Vorontsov <anton.vorontsov@linaro.org> wrote:

> This patch implements a new callback: clear_irqs. It is used for the


This bit I still really don't like. I would like to know what the generic
IRQ folks thing about it and if Thomas Gleixner has any brilliant ideas
here. I don't think its a show stopper it would just be nice if there was
a better solution first.

Alan
