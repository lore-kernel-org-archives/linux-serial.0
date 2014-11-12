From: Fabio Estevam <festevam@gmail.com>
Subject: Re: Incorrect set_ldisc() for mxs-auart
Date: Wed, 12 Nov 2014 15:31:09 -0200
Message-ID: <CAOMZO5ArmUu30bzYcJa5zyf2ZV7tj2cL-ZGsWhogw6yUPbJEJA@mail.gmail.com>
References: <CAOMZO5BzF5t-TFBP-YLrkLO0tj0n9U-ShbdTHNkpGuxOm=DueA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-la0-f47.google.com ([209.85.215.47]:36116 "EHLO
	mail-la0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752998AbaKLRbK (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 12 Nov 2014 12:31:10 -0500
Received: by mail-la0-f47.google.com with SMTP id gd6so11521651lab.6
        for <linux-serial@vger.kernel.org>; Wed, 12 Nov 2014 09:31:09 -0800 (PST)
In-Reply-To: <CAOMZO5BzF5t-TFBP-YLrkLO0tj0n9U-ShbdTHNkpGuxOm=DueA@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Janusz Uzycki <j.uzycki@elproma.com.pl>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>

On Wed, Nov 12, 2014 at 3:26 PM, Fabio Estevam <festevam@gmail.com> wrote:
> Janusz,
>
> Since commit 36a262782b04 ("serial: mxs-auart: enable PPS support")
> the following build warning is seen:
>
> drivers/tty/serial/mxs-auart.c:962:2: warning: initialization from
> incompatible pointer type
>   .set_ldisc      = mxs_auart_set_ldisc,
>   ^
> drivers/tty/serial/mxs-auart.c:962:2: warning: (near initialization
> for 'mxs_auart_ops.set_ldisc')
>
> The mxs_auart_set_ldisc() function should look like this:
>
> static void mxs_auart_set_ldisc(struct uart_port *port, struct
> ktermios *termios)
>
> instead of
>
> static void mxs_auart_set_ldisc(struct uart_port *port, int new)
>
> Please fix it.

Ok, so the fix is simple and I will submit it. Please give it a test.
