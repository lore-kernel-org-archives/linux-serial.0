From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH -next 05/10] tty: Document defunct ASYNC_* bits in uapi
 header
Date: Fri, 17 Oct 2014 08:44:09 -0400
Message-ID: <54410F19.3040607@hurleysoftware.com>
References: <1413492867-20679-1-git-send-email-peter@hurleysoftware.com> <1413492867-20679-6-git-send-email-peter@hurleysoftware.com> <5440D781.1080308@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout32.mail01.mtsvc.net ([216.70.64.70]:42154 "EHLO
	n23.mail01.mtsvc.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750729AbaJQMoO (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 17 Oct 2014 08:44:14 -0400
In-Reply-To: <5440D781.1080308@suse.cz>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Jiri Slaby <jslaby@suse.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>

Hi Jiri,

On 10/17/2014 04:46 AM, Jiri Slaby wrote:
> On 10/16/2014, 10:54 PM, Peter Hurley wrote:
>> Note the serial_struct flags for which the kernel ignores and performs
>> no action. The flags cannot be removed since they form part of the
>> userspace interface via the TIOCSSERIAL/TIOCGSERIAL ioctls.
> 
> Hello,
> 
> would it make sense to mark them deprecated somehow? At build time

A build warning when the macro is expanded would be best, but my
c-preprocessor-fu is terrible, so I have no idea how to make that work.

> or
> at least warn in the serial core that "current->comm is using a
> deprecated flag"_ratelimited()?

If we just print the message at TIOCSSERIAL if any of the deprecated
bits are set, that would be ok. Probably the only issue would be that
setserial could cause this message at will, so log flooding would be
a concern.

Regards,
Peter Hurley

