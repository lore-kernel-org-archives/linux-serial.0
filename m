From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PATCH] TTY/serial driver patches for 3.2
Date: Wed, 26 Oct 2011 15:18:21 +0200
Message-ID: <CA+55aFycM+nHxJNnFSjEXQvZkeBfHu161ePC0=7sWKZR1toQNA@mail.gmail.com>
References: <20111026114236.GA22180@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:40511 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754674Ab1JZNSn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 26 Oct 2011 09:18:43 -0400
In-Reply-To: <20111026114236.GA22180@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg KH <gregkh@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org

On Wed, Oct 26, 2011 at 1:42 PM, Greg KH <gregkh@suse.de> wrote:
>
> The one in 8250_pci.c is trivial to fix, the atmel_serial one isn't a=
s
> easy, but I'm sure you can figure it out :) =A0If you want me to do t=
he
> merge for it, I'll be glad to do so, just let me know.

So I figured it out, but please double-check, especially since it
seems to be some arm-only driver that I can't even compile-test my
resolution.

                 Linus
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
