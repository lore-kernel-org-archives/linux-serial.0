From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: [PATCH 2/2] TTY: remove tty_locked
Date: Thu, 14 Jul 2011 14:18:30 +0200
Message-ID: <4E1EDE96.8070700@gmail.com>
References: <201107122325.35013.arnd@arndb.de> <1310553086-27427-1-git-send-email-jslaby@suse.cz> <1310553086-27427-2-git-send-email-jslaby@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-fx0-f52.google.com ([209.85.161.52]:52975 "EHLO
	mail-fx0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754111Ab1GNMSe (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 14 Jul 2011 08:18:34 -0400
In-Reply-To: <1310553086-27427-2-git-send-email-jslaby@suse.cz>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Jiri Slaby <jslaby@suse.cz>
Cc: gregkh@suse.de, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Alan Cox <alan@linux.intel.com>

On 07/13/2011 12:31 PM, Jiri Slaby wrote:
> --- a/drivers/tty/tty_mutex.c
> +++ b/drivers/tty/tty_mutex.c
=2E..
> @@ -25,10 +23,7 @@ void __lockfunc tty_lock(void)
>  {
>  	struct task_struct *task =3D current;

Hmm I overlooked it generates a warning:
drivers/tty/tty_mutex.c: In function =91tty_lock=92:
drivers/tty/tty_mutex.c:24:22: warning: unused variable =91task=92
drivers/tty/tty_mutex.c: In function =91tty_unlock=92:
drivers/tty/tty_mutex.c:32:22: warning: unused variable =91task=92

> -	WARN_ON(__big_tty_mutex_owner =3D=3D task);
> -
>  	mutex_lock(&big_tty_mutex);
> -	__big_tty_mutex_owner =3D task;
>  }

I will send whole series as v2 since it is confusing enough.

thanks,
--=20
js
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
