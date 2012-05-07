From: Sasha Levin <levinsasha928@gmail.com>
Subject: Re: [PATCH 3/3] tty_lock: Localise the lock
Date: Mon, 7 May 2012 18:03:07 +0200
Message-ID: <CA+1xoqezLCQh_fqJ1iNAs25X7Fm24W=-0J8zTZuVVJQnWTtSLg@mail.gmail.com>
References: <20120503212151.568.91854.stgit@bob.linux.org.uk> <20120503212219.568.15653.stgit@bob.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-gg0-f174.google.com ([209.85.161.174]:47509 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756571Ab2EGQD3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 7 May 2012 12:03:29 -0400
In-Reply-To: <20120503212219.568.15653.stgit@bob.linux.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org

Hi Alan,

On Thu, May 3, 2012 at 11:24 PM, Alan Cox <alan@lxorguk.ukuu.org.uk> wr=
ote:
> diff --git a/drivers/tty/pty.c b/drivers/tty/pty.c
> index 5505ffc..d6fa842 100644
> --- a/drivers/tty/pty.c
> +++ b/drivers/tty/pty.c
> @@ -62,9 +63,7 @@ static void pty_close(struct tty_struct *tty, struc=
t file *filp)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mutex_unlock(&devpts_m=
utex);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0#endif
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 tty_unlock();
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tty_vhangup(tty->link);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 tty_lock();
> =A0 =A0 =A0 =A0}
> =A0}

I don't believe that this change is correct.

Consider the following scenario:

tty_release -> tty_lock -> pty_close -> tty_vhangup -> tty_lock

Which would cause a deadlock.
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
