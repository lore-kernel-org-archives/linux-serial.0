From: Rajanikanth H V <rajanikanth.hv@stericsson.com>
Subject: RE: tty/serial: Need clarification on Support for 4+M Baudrate
Date: Fri, 13 Jan 2012 15:36:39 +0100
Message-ID: <2B1D156D95AE9B4EAD379CB9E465FE7324AF2F2087@EXDCVYMBSTM005.EQ1STM.local>
References: <20120111121901.GA4034@bnru05>
	<20120111123025.244a9cf5@pyramind.ukuu.org.uk>
	<2B1D156D95AE9B4EAD379CB9E465FE7324AF2A605A@EXDCVYMBSTM005.EQ1STM.local>
	<20120112114913.21809bed@pyramind.ukuu.org.uk>
	<2B1D156D95AE9B4EAD379CB9E465FE7324AF2A630D@EXDCVYMBSTM005.EQ1STM.local>
 <20120112143900.27b92668@pyramind.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120112143900.27b92668@pyramind.ukuu.org.uk>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "gregkh@sude.de" <gregkh@sude.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Rajanikanth H V <rajanikanth.hv@stericsson.com>
List-Id: linux-serial@vger.kernel.org

Thanks, explicit termios(with flags) structure usage helped(log below), however, 
the dependent Bluetooth uart driver switches the uart baud rates
between 115K(during initialization), 9600(during low power) and
4+M(data tfr), in this juncture I need to handle termios structure switching
accordingly else I see c_cflags getting messed up effecting next baud switch change.

================================
[    9.070648] alloc_set_baud_rate_cmd Setting arbitrary baudrate using BOTHER baudrate:89 c_cflag:020000016260
[    9.164581] tty_termios_encode_baud_rate c_ispeed:4050000 c_ospeed:4050000 c_cflag:020000016260
[    9.173278] tty_termios_encode_baud_rate checking precise weird baudrate c_cflag:020000006260 oclose:0 iclose:81000 ibinput:0
[    9.187103] tty_termios_encode_baud_rate did we find close match? i:31 n_baud_table31 ifound:30 ofound:-1
[    9.197570] tty_termios_encode_baud_rate BOTHER, c_cflag:022003616260
[    9.214630] tty_termios_baud_rate:(Arb'ry baud set) c_cflag:022003616260 cbaud:010000
[    9.222503] pl011_set_termios i_speed:4050000 o_speed:4050000
[    9.231384] tty_termios_baud_rate:(Arb'ry baud set) c_cflag:022003616260 cbaud:010000
[    9.246643] pl011_set_termios baud:4050000 uart_clk:38400000 port:0 IBRD:1 FBRD:12
[    9.254730] XXXXXX-uart XXXXXX-uart.0: Baud rate changed to 4050000 baud
================================

Thanks,
Rajanikanth

> 4.05M Arbitrary Baud Setting Sequence:
> [    9.664703] alloc_set_baud_rate_cmd Setting arbitrary baudrate using BOTHER baudrate:89 c_cflag:020000016262
> [    9.774658] XXXXXX_hci_uart_set_baudrate c_cflag:020000016262 baud:4050000

4050000 seems a bit odd - you want cflag&CBAUD == BOTHER so I'd expect
the low bits to end rather different things to 6262 ?

So something like

	struct ktermios new = *tty->termios;
	new.c_cflag &= ~(CBAUD|CIBAUD);
	new.c_cflag |= BOTHER;
	new.c_ispeed = 4050000;
	new.c_ospeed = 4050000;
	tty_set_termios(tty, &new);	/* Can sleep */

	/* Returned new will now hold actual values selected */

should do the trick providing the low level driver supports the rate.

Alan
