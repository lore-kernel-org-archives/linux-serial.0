From: Alan Cox <alan@linux.intel.com>
Subject: Re: [PATCH v7 0/11] KGDB/KDB FIQ (NMI) debugger
Date: Thu, 13 Sep 2012 18:04:57 +0100
Message-ID: <20120913180457.1396637b@bob.linux.org.uk>
References: <20120913150133.GA16238@lizard>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:25471 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758455Ab2IMQrH (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 13 Sep 2012 12:47:07 -0400
In-Reply-To: <20120913150133.GA16238@lizard>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Anton Vorontsov <anton.vorontsov@linaro.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Russell King <linux@arm.linux.org.uk>, Jason Wessel <jason.wessel@windriver.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arve =?ISO-8859-1?B?SGr4bm5l?= =?ISO-8859-1?B?duVn?= <arve@android.com>, Colin Cross <ccross@android.com>, Brian Swetland <swetland@google.com>, John Stultz <john.stultz@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linaro-kernel@lists.linaro.org, patches@linaro.org, kernel-team@android.com, kgdb-bugreport@lists.sourceforge.net, linux-serial@vger.kernel.org

On Thu, 13 Sep 2012 08:01:33 -0700
Anton Vorontsov <anton.vorontsov@linaro.org> wrote:

> Hi all,
> 
> Here comes the lucky v7:
> 
> - Per Alan Cox's suggestion added hangup method and removed a small
>   leftover;
> - Per Colin Cross' suggestion moved IRQ quiescing logic into
>   poll_get_char routine. IIUC, Alan is less unhappy about it.  As a
>   result, clear_irq() callback dropped.

Ok that has my ack. Some of it is not pretty but debugger hooks that
have to run behind the OS while debugging it never are.

Acked-by: Alan Cox <alan@linux.intel.com>
