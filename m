From: Prasad Koya <prasad.koya@gmail.com>
Subject: Re: UART_IIR_BUSY set for 16550A
Date: Tue, 27 May 2014 16:33:58 -0700
Message-ID: <CAGXD9OcNT6m+HUJU=E9-DB-UwBVd1Pz_EmcQDzTwou0i7ayKQg@mail.gmail.com>
References: <CAGXD9Ocoo_sUnFmd-pfU52yUQ5oPjWxAHXjvP8facuMiOSUn5w@mail.gmail.com>
	<20140525003642.GC6946@thunk.org>
	<CAGXD9Odvyd_go-x9-gR7Q7_etYPLHekDM3SKRN+PCvDHc__LHg@mail.gmail.com>
	<20140525024414.GF6946@thunk.org>
	<CAGXD9Of8-v9TJ-0uuQ3TDzo5QYhB3uA=B5kMGQkiABSzFrWDng@mail.gmail.com>
	<20140525120409.GG6946@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-vc0-f177.google.com ([209.85.220.177]:54321 "EHLO
	mail-vc0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751198AbaE0Xd7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 27 May 2014 19:33:59 -0400
Received: by mail-vc0-f177.google.com with SMTP id hq11so5626308vcb.8
        for <linux-serial@vger.kernel.org>; Tue, 27 May 2014 16:33:58 -0700 (PDT)
In-Reply-To: <20140525120409.GG6946@thunk.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: linux-serial@vger.kernel.org, gregkh@linuxfoundation.org

Hi Ted,

http://www.lammertbies.nl/comm/info/serial-uart.html says IIR of 0xXC
=3D> "Character timeout (16550)".

http://en.wikibooks.org/wiki/Serial_Programming/8250_UART_Programming
says those bits mean "timeout interrupt pending".

from intel manual:

http://www.intel.com/content/dam/www/public/us/en/documents/datasheets/=
intel-communications-chipset-89xx-series-datasheet.pdf

section 4.13.4.4.3 is about "Character Timeout Interrupt".
=3D=3D=3D=3D=3D

When the receiver FIFO and receiver time out interrupt are enabled, a c=
haracter
timeout interrupt occurs when all of the following conditions exist:
=E2=80=A2 At least one character is in the FIFO.
=E2=80=A2 The last received character was longer than four continuous
character times ago (if
two stop bits are programmed the second one is included in this time de=
lay).
=E2=80=A2 The most recent processor read of the FIFO was longer than fo=
ur continuous
character times ago.
=E2=80=A2 The receive FIFO trigger level is greater than one.
The maximum time between a received character and a timeout interrupt
is 160 ms at
300 baud with a 12-bit receive character (for example, one start,
eight data, one
parity, and two stop bits).
When a time out interrupt occurs, it is cleared and the timer is reset =
when the
processor reads one character from the receiver FIFO. If a timeout
interrupt has not
occurred, the timeout timer is reset after a new character is received
or after the
processor reads the receiver FIFO.
=3D=3D=3D=3D

=46rom what I understand, there is a character in recv FIFO and no othe=
r
characters have been received in last 4 chars time. So why wouldn't
that set UART_LSR_DR?

#define UART_LSR_DR             0x01 /* Receiver data ready */

If my understanding is correct and there is a byte in recv FIFO to be
read, why isn't the driver coded to pick up that byte if IIR is 0xcc.
maybe not all 16550A compatible UARTs don't do this and thats why its
left out?

Infact, if i type a char on console and let it go idle, I'm seeing IIR
register as 0xCC and LSR as 0x61. Since bit 0 of LSR is set, that byte
is getting picked up. So I wonder why at a random time, UART sets IIR
as 0xCC and leaves LSR as 0 and LSR becomes 0x60 after about 350
iterations in that loop and stays that way. For a buggy UART like
that, sounds like one could use that condition as exception to go
ahead and read the receive buffer. What do you say?

Thank you.


On Sun, May 25, 2014 at 5:04 AM, Theodore Ts'o <tytso@mit.edu> wrote:
> On Sat, May 24, 2014 at 11:21:38PM -0700, Prasad Koya wrote:
>> IIR as 0xc2 and LSR as 0x21 and it read 2 chars in that iteration an=
d
>> sent 1 byte of data.
>>
>> Since the interrupt handler services all ports before it returns, in
>> next iteration it sees:
>>
>> [  480.972102] BUG1027: I1: 1571:0xcc 1551:0x0
>>
>> and it continues to see that till iteration 349. and nothing was rea=
d
>> from FIFO or transmitted from iteration 1 to 349.
>
> If there's nothing in the receive FIFO to read, and assuming the
> serial driver is correctly determining that fact (i.e., UART_LSR_DR i=
s
> zero), then something is buggy with your UART.  If IIR is 0xcc, that
> means that the UART is signalling that there is a receive interrupt
> pending, with the FIFO level being below the trigger level but that
> the characters have been in the FIFO long enough that they should get
> picked up.
>
> When the serial driver reads all of the characters from the receive
> buffer, by checking UART_LSR for the UART_LSR_DR bit, and if it is
> set, reading from the receive buffer via serial_in(up, UART_RX), that
> should clear the IIR register of the receive interrupt.
>
>> At next iteration it had 0x60 in LSR and again nothing is read or se=
nt
>> out. This continues till we see that "too much work".
>>
>> [  480.972526] BUG1027: I350: 1571:0xcc 1551:0x60
>
> Yep, buggy UART.  Unfortunately there are lot of crappy
> reimplementations of the 8250/16550A UART's out there.  :-(
>
> Which is precisely why we have the "too much work" safety check.  If
> we didn't, your system would be locked up forever, looping in the
> serial driver.  There is, alas, a lot of crappy hardware out there,
> which is why the serial driver was coded so defensively.
>
> In any case, combination of LSR with the UART_LSR_DR bit clear and II=
R
> set to 0xcc is one of these "this should never happen, under any
> circumstances, with a correctly implemented 8250/16550A compatible
> UART".  Which is why I can't really tell you how to reset the UART,
> since at least in theory, this should never happen, and if it does
> happen, without having access to the hardware and doing a lot of
> frustating testing to reverse engineer the exact nature of the buggy
> hardware, it's hard to figure out how to work around the brain damage=
=2E
> Which is one of the reasons I was happy to get out of the serial
> driver maintenance business.  :-)
>
> Cheers,
>
>                                         - Ted
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
