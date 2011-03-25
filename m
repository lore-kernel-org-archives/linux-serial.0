From: Jiri Slaby <jslaby@suse.cz>
Subject: Re: [PATCH 1/1] TTY: serial_core, fix dtr_rts NULL dereference
Date: Fri, 25 Mar 2011 15:43:27 +0100
Message-ID: <4D8CAA0F.9040204@suse.cz>
References: <4D8C7253.3040204@suse.cz>	<1301049956-6933-1-git-send-email-jslaby@suse.cz> <20110325110040.6866d671@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:43051 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753819Ab1CYOnf (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 25 Mar 2011 10:43:35 -0400
Received: by fxm17 with SMTP id 17so1202437fxm.19
        for <linux-serial@vger.kernel.org>; Fri, 25 Mar 2011 07:43:34 -0700 (PDT)
In-Reply-To: <20110325110040.6866d671@lxorguk.ukuu.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jiri Slaby <jirislaby@gmail.com>, gregkh@suse.de, linux-serial@vger.kernel.org

On 03/25/2011 12:00 PM, Alan Cox wrote:
> On Fri, 25 Mar 2011 11:45:56 +0100
> Jiri Slaby <jslaby@suse.cz> wrote:
> 
>> Under certain circumstances uart_dtr_rts might cause an oops. It dies
>> because port->tty is NULL. To fix this, let's take a reference of
>> port->tty by tty_port_tty_get. And if it is not there already, fail
>> gracefully.
> 
> The uart helper layer assumes here (and a couple of other spots) that the
> IRQ handler for the tty takes the port lock.

The oopsing path is through open BTW:
-> uart_open
 -> tty_port_block_til_ready
  -> tty_port_raise_dtr_rts
   -> uart_dtr_rts

> I think the *right* fix is probably to pass port not port->tty into the
> helper in the first place but that seems to ripple into a lot of drivers.
> 
> (passing port->tty to things that then go tty->port is braindead and
> causes half the mess in the tty/serial code)

I seem to miss the point. uart_update_termios needs tty, not port.

thanks,
-- 
js
suse labs
