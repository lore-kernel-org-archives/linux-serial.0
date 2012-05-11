From: grego rigolo <gregorigolo2002@yahoo.fr>
Subject: auto-RTS and TL16C754C
Date: Fri, 11 May 2012 13:18:27 +0100 (BST)
Message-ID: <1336738707.83536.YahooMailNeo@web28605.mail.ukl.yahoo.com>
Reply-To: grego rigolo <gregorigolo2002@yahoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from nm21-vm2.bullet.mail.ukl.yahoo.com ([217.12.10.34]:46679 "HELO
	nm21-vm2.bullet.mail.ukl.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1758387Ab2EKMZG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 11 May 2012 08:25:06 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>

Hi all,
I am using a TL16C754C in my design and i was wondering why the Auto-RT=
S was not enabled.
Indeed in the 8250.c source code we can read

=46IXME:
=A0=A0=A0 =A0=A0=A0 =A0* - TI16C752 requires control thresholds to be s=
et.
=A0=A0=A0 =A0=A0=A0 =A0* - UART_MCR_RTS is ineffective if auto-RTS mode=
 is enabled

In the serial-omap.c, i saw that auto-rts had been enabled:
/* Hardware Flow Control Configuration */

=A0=A0=A0 if (termios->c_cflag & CRTSCTS)
 {
=A0=A0=A0 =A0=A0=A0 efr |=3D (UART_EFR_CTS | UART_EFR_RTS);
=A0=A0=A0 =A0=A0=A0 serial_out(up, UART_LCR, UART_LCR_CONF_MODE_A);

=A0=A0=A0 =A0=A0=A0 up->mcr =3D serial_in(up, UART_MCR);
=A0=A0=A0 =A0=A0=A0 serial_out(up, UART_MCR, up->mcr | UART_MCR_TCRTLR)=
;

=A0=A0=A0 =A0=A0=A0 serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B);
=A0=A0=A0 =A0=A0=A0 up->efr =3D serial_in(up, UART_EFR);
=A0=A0=A0 =A0=A0=A0 serial_out(up, UART_EFR, up->efr | UART_EFR_ECB);

=A0=A0=A0 =A0=A0=A0 serial_out(up, UART_TI752_TCR, OMAP_UART_TCR_TRIG);
=A0=A0=A0 =A0=A0=A0 serial_out(up, UART_EFR, efr); /* Enable AUTORTS an=
d AUTOCTS */
=A0=A0=A0 =A0=A0=A0 serial_out(up, UART_LCR, UART_LCR_CONF_MODE_A);
=A0=A0=A0 =A0=A0=A0 serial_out(up,
 UART_MCR, up->mcr | UART_MCR_RTS);
=A0=A0=A0 =A0=A0=A0 serial_out(up, UART_LCR, cval);


Thanks in advance for your comments

greg
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
