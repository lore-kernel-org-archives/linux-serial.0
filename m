From: Jiri Slaby <jslaby@suse.cz>
Subject: Re: [PATCH 01/10] TTY: serial, cleanup include file
Date: Wed, 09 Nov 2011 23:09:07 +0100
Message-ID: <4EBAFA03.40405@suse.cz>
References: <1320870831-23778-1-git-send-email-jslaby@suse.cz> <20111109215901.16f44570@bob.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:60220 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750805Ab1KIWJQ (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 9 Nov 2011 17:09:16 -0500
In-Reply-To: <20111109215901.16f44570@bob.linux.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@linux.intel.com>
Cc: Jiri Slaby <jirislaby@gmail.com>, gregkh@suse.de, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org

On 11/09/2011 10:59 PM, Alan Cox wrote:
> We need to move the tty_buffer objects into the tty_port.

Thanks a lot for reminding me. (I remember you telling me about this at
KS.) So I suppose you prefer this to be done first... OK, I will look
into that. Leaving the rest of the serial stuff apart for the time being.

> This needs every tty of all kinds to have a tty_port even if isn't used
> for anything else.

Heh, out-of-tree driver maintainers will cry once again. It serves them
right.

thanks,
-- 
js
suse labs
