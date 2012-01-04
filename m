From: Jiri Slaby <jslaby@suse.cz>
Subject: Re: [PATCH] serial: relocate remaining serial drivers from tty/ to
 tty/serial/
Date: Wed, 04 Jan 2012 21:34:36 +0100
Message-ID: <4F04B7DC.70809@suse.cz>
References: <1325707287-31038-1-git-send-email-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:50628 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752506Ab2ADUek (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 4 Jan 2012 15:34:40 -0500
In-Reply-To: <1325707287-31038-1-git-send-email-paul.gortmaker@windriver.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: alan@linux.intel.com, gregkh@suse.de, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Slaby <jirislaby@gmail.com>

On 01/04/2012 09:01 PM, Paul Gortmaker wrote:
>  rename drivers/tty/{ => serial}/amiserial.c (100%)
>  rename drivers/tty/{ => serial}/cyclades.c (100%)
>  rename drivers/tty/{ => serial}/isicom.c (100%)
>  rename drivers/tty/{ => serial}/moxa.c (100%)
>  rename drivers/tty/{ => serial}/moxa.h (100%)
>  rename drivers/tty/{ => serial}/mxser.c (100%)
>  rename drivers/tty/{ => serial}/mxser.h (100%)
>  rename drivers/tty/{ => serial}/rocket.c (100%)
>  rename drivers/tty/{ => serial}/rocket.h (100%)
>  rename drivers/tty/{ => serial}/rocket_int.h (100%)
>  rename drivers/tty/{ => serial}/synclink.c (100%)
>  rename drivers/tty/{ => serial}/synclink_gt.c (100%)
>  rename drivers/tty/{ => serial}/synclinkmp.c (100%)

Hmm, tty/serial/* used to be for those using serial-core. And tty/ for
those who don't. But FWIW I don't mind the change.

-- 
js
suse labs
