From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] tty: Only wakeup the line discipline idle queue when
 queue is active
Date: Wed, 2 Jan 2013 11:43:11 +0000
Message-ID: <20130102114311.66215bf5@pyramind.ukuu.org.uk>
References: <1355842130-15482-1-git-send-email-meltedpianoman@gmail.com>
	<50E3FDFA.4070203@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:35004 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752134Ab3ABLhk (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 2 Jan 2013 06:37:40 -0500
In-Reply-To: <50E3FDFA.4070203@suse.cz>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Jiri Slaby <jslaby@suse.cz>
Cc: Ivo Sieben <meltedpianoman@gmail.com>, linux-serial@vger.kernel.org, Alan Cox <alan@linux.intel.com>, Greg KH <gregkh@linuxfoundation.org>, Oleg Nesterov <oleg@redhat.com>, linux-kernel@vger.kernel.org, Andi Kleen <andi@firstfloor.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>


> Looks good, but I would prefer the layer to provide us with
> wake_up_if_active...

Seconded - this is a problem for the wake up logic in the RT tree. Why
would we ever do anything else ?
