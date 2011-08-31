From: Sasha Levin <levinsasha928@gmail.com>
Subject: Re: [PATCH 4/4] TTY: serial, move 68360 driver to staging
Date: Wed, 31 Aug 2011 22:31:26 +0300
Message-ID: <1314819086.30506.3.camel@lappy>
References: <1314818699-10873-1-git-send-email-jslaby@suse.cz>
	 <1314818699-10873-4-git-send-email-jslaby@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:64410 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752110Ab1HaTbe (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 31 Aug 2011 15:31:34 -0400
In-Reply-To: <1314818699-10873-4-git-send-email-jslaby@suse.cz>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Jiri Slaby <jslaby@suse.cz>
Cc: gregkh@suse.de, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, jirislaby@gmail.com, Geert Uytterhoeven <geert@linux-m68k.org>, Alan Cox <alan@linux.intel.com>, linux-m68k@lists.linux-m68k.org

On Wed, 2011-08-31 at 21:24 +0200, Jiri Slaby wrote:
> This driver has been broken at least since 2008. At that time,
> a88487c79b (Fix compile errors in SGI console drivers) broke this
> driver completely.
> 
> And since nobody noticed for the past 3 years, move it into staging. I
> think this will rot there and we will throw it away completely after
> some time. Or maybe someone will volunteer to fix it ;).
> 
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Alan Cox <alan@linux.intel.com>
> ---
> Cc: linux-m68k@lists.linux-m68k.org
>  drivers/staging/Kconfig              |    2 +
>  drivers/staging/Makefile             |    1 +
>  drivers/staging/serial/68360serial.c | 2979 ++++++++++++++++++++++++++++++++++
>  drivers/staging/serial/Kconfig       |   16 +
>  drivers/staging/serial/Makefile      |    1 +
>  drivers/staging/serial/TODO          |    6 +
>  drivers/tty/serial/68360serial.c     | 2979 ----------------------------------
>  drivers/tty/serial/Kconfig           |   17 -
>  drivers/tty/serial/Makefile          |    1 -
>  9 files changed, 3005 insertions(+), 2997 deletions(-)
>  create mode 100644 drivers/staging/serial/68360serial.c
>  create mode 100644 drivers/staging/serial/Kconfig
>  create mode 100644 drivers/staging/serial/Makefile
>  create mode 100644 drivers/staging/serial/TODO
>  delete mode 100644 drivers/tty/serial/68360serial.c

'git mv' and 'git format-patch --find-renames' would make this patch so
much nicer.

-- 

Sasha.

