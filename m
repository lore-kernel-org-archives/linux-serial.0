From: Jiri Slaby <jslaby@suse.cz>
Subject: Re: [PATCH -next 05/10] tty: Document defunct ASYNC_* bits in uapi
 header
Date: Fri, 17 Oct 2014 10:46:57 +0200
Message-ID: <5440D781.1080308@suse.cz>
References: <1413492867-20679-1-git-send-email-peter@hurleysoftware.com> <1413492867-20679-6-git-send-email-peter@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:41546 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753360AbaJQIrH (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 17 Oct 2014 04:47:07 -0400
In-Reply-To: <1413492867-20679-6-git-send-email-peter@hurleysoftware.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>

On 10/16/2014, 10:54 PM, Peter Hurley wrote:
> Note the serial_struct flags for which the kernel ignores and performs
> no action. The flags cannot be removed since they form part of the
> userspace interface via the TIOCSSERIAL/TIOCGSERIAL ioctls.

Hello,

would it make sense to mark them deprecated somehow? At build time, or
at least warn in the serial core that "current->comm is using a
deprecated flag"_ratelimited()?

thanks,
-- 
js
suse labs
