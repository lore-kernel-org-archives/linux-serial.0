From: Alex Pavloff <apavloff@eason.com>
Subject: RE: your mail
Date: Tue, 27 Aug 2002 09:55:04 -0700
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <D3AF5F134D627243993F2F2FC32EE4D20CE1CE@mailman.eason.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Return-path: <linux-serial-owner@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org
To: 'Gerald Emig' <gme@emig-software.de>
Cc: "'linux-serial@vger.kernel.org'" <linux-serial@vger.kernel.org>


Hi Gerald, here's some more info:

Sending data isn't the problem.  The problem is acting as a slave and
receiving unsolicited packets from a master.   I need to determine when a
packet is complete.  If I was sending the packets (which I have done before
and am doing now), I can cheat a bit because I know the length of the packet
I'm "supposed" to be getting back.   I can't do that when acting as a slave.

This is different that the other protocol I'm familiar with.

GE's SNP uses two packets -- the first fixed size and containing the length
of the second size.
AB's DF1 has a fixed packet structure with many special characaters that
makes it easy to pull in a piece at a time

With Modbus RTU I neither know how long a packet is going to be, nor do I
have a sequence of bytes that can be used to judge the end of a packet.  I
need to be able to understand that 3.5 characters times of nothing means the
end of the packet.

Do I need a line discipline for this one portion of the driver?

Alex Pavloff
Software Engineer
Eason Technology
 


-----Original Message-----
From: Gerald Emig [mailto:gme@emig-software.de]
Sent: Tuesday, August 27, 2002 3:00 AM
To: Alex Pavloff
Cc: 'linux-serial@vger.kernel.org'
Subject: Re: your mail



To wait for at least 3.5 character times you can simply wait for this time
or more using usleep() before sending your data.

On Mon, 26 Aug 2002, Alex Pavloff wrote:

>
> Good (morning/afternoon/evening) folks,
>
> I am writing Modbus RTU code for Linux 2.4.19.  While seeminly simple to
do
> in userspace, there's one big kicker that I can't handle there easily.
> Modbus RTU is a binary serial protocol used in industrial automation.
First
> used by the Modicon PLCs, it's found on a variety of devices from a
variety
> of manufacturers.
>
> The specification is at www.modbus.org, under "Modbus Standard Library",
and
> its the Modbus Serial Protocol Reference Guide.
>
> Here's the part that I don't think I can resolve in userspace:
> -----
> RTU Framing
> In RTU mode, messages start with a silent interval of at least 3.5
character
> times. This is most easily implemented as a multiple of character times at
> the baud rate that is being used on the network (shown as T1-T2-T3-T4 in
the
> figure below). The first field then transmitted is the device address.
>
> The allowable characters transmitted for all fields are hexadecimal 0-9,
> A-F. Networked devices monitor the network bus continuously, including
> during the 'silent' intervals. When the first field (the address field) is
> received, each device decodes it to find out if it is the addressed
device.
>
> Following the last transmitted character, a similar interval of at least
3.5
> character times marks the end of the message. A new message can begin
after
> this interval.
>
> The entire message frame must be transmitted as a continuous stream. If a
> silent interval of more than 1.5 character times occurs before completion
of
> the frame, the receiving device flushes the incomplete message and assumes
> that the next byte will be the address field of a new message.
> -----
>
> 3.5 character times at high baud rates is not something I can pull off
with
> termios.  To get the Modbus RTU frames without resorting to some really
> strange code in userspace, should I write a line-discipline module whose
> sole purpose is to deal with the character timing?
>
> Any comments (yay/nay/huh?) appreciated.
>
> Alex Pavloff
> Software Engineer
> Eason Technology
>
>

Gerald Emig


