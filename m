From: "Andrew Dyer" <amdyer@gmail.com>
Subject: Re: [PATCH] serial: imx: add console polling routines for kgdboc
Date: Fri, 15 Aug 2008 10:10:03 -0500
Message-ID: <c166aa9f0808150810r6aba0889w5ceef50d7b6d6b73@mail.gmail.com>
References: <48A29AFB.9070502@tripeaks.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.237]:31590 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753599AbYHOPKE (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 15 Aug 2008 11:10:04 -0400
Received: by wr-out-0506.google.com with SMTP id 69so1074085wri.5
        for <linux-serial@vger.kernel.org>; Fri, 15 Aug 2008 08:10:03 -0700 (PDT)
In-Reply-To: <48A29AFB.9070502@tripeaks.co.jp>
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Atsuo Igarashi <atsuo_igarashi@tripeaks.co.jp>
Cc: linux-serial@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk, kernel@pengutronix.de

On Wed, Aug 13, 2008 at 3:27 AM, Atsuo Igarashi
<atsuo_igarashi@tripeaks.co.jp> wrote:
> Add console polling routines for the imx uart with kgdboc.
>
> Signed-off-by Atsuo Igarashi <atsuo_igarashi@tripeaks.co.jp>
>

In imx_get_poll_char() the code returns the result of reading the urxd
register.  That register has the 8 bits of receive data in it, but in
the next byte up also has 4 bits of error flags (overrun, frame,
break, parity) and an error summary bit which are being ignored.
Maybe something like this?

static int imx_get_poll_char(struct uart_port *port)
{
	struct imx_port *sport = (struct imx_port *)port;
	int ch;

	while (1) {
                while (!(readl(sport->port.membase + USR2) & USR2_RDR));

	        ch = readl(sport->port.membase + URXD0);

                if (!(ch & URXD_ERR))
                        return(ch & 0xff);
                /* else throw away the char with the error and try
again (or return an error value?) */
        }
}


-- 
Hardware, n.:
 The parts of a computer system that can be kicked.
