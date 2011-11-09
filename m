From: Alan Cox <alan@linux.intel.com>
Subject: Re: [PATCH 01/10] TTY: serial, cleanup include file
Date: Wed, 9 Nov 2011 23:25:53 +0000
Message-ID: <20111109232553.5fa24741@bob.linux.org.uk>
References: <1320870831-23778-1-git-send-email-jslaby@suse.cz>
	<20111109215901.16f44570@bob.linux.org.uk>
	<4EBAFA03.40405@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:43676 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752188Ab1KIXOq (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 9 Nov 2011 18:14:46 -0500
In-Reply-To: <4EBAFA03.40405@suse.cz>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Jiri Slaby <jslaby@suse.cz>
Cc: Jiri Slaby <jirislaby@gmail.com>, gregkh@suse.de, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org

On Wed, 09 Nov 2011 23:09:07 +0100
Jiri Slaby <jslaby@suse.cz> wrote:

> On 11/09/2011 10:59 PM, Alan Cox wrote:
> > We need to move the tty_buffer objects into the tty_port.
> 
> Thanks a lot for reminding me. (I remember you telling me about this
> at KS.) So I suppose you prefer this to be done first... OK, I will
> look into that. Leaving the rest of the serial stuff apart for the
> time being.

I'm not really bothered what is done first - it's not as if I am doing
the work! I just thought it might be easier to do it that way around
rather than adding and removing more complexity on the way ?

Alan
