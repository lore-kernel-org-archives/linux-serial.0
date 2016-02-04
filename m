From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: Data corruption on serial interface under load
Date: Thu, 4 Feb 2016 12:06:44 -0800
Message-ID: <56B3AF54.2050609@hurleysoftware.com>
References: <CAHp75VehshCyAjKiOyB26zkeu4WUar9-z-XfFNLuchc0swyvSQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHp75VehshCyAjKiOyB26zkeu4WUar9-z-XfFNLuchc0swyvSQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Russell King <linux@arm.linux.org.uk>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

Hi Andy,

On 02/04/2016 10:55 AM, Andy Shevchenko wrote:
> Hi!
> 
> Today I observed interesting bug / feature of uart layer in the kernel.
> I do have a setup which connects two identical devices by serial line.
> I run data transferring in one direction and got data corruption on
> receiver side (in uart layer, not the driver).
> 
> Here is the dump from test suite and real data from 8250 registers:
> 
> === 8< ===
> 
> Needed 16 reads 0 writes Oh oh, inconsistency at pos 1 (0x1).
> 
> Original sample:
> 00000000: 7f 45 4c 46 01 01 01 00  00 00 00 00 00 00 00 00   .ELF............
> 00000010: 02 00 03 00 01 00 00 00  19 8d 04 08 34 00 00 00   ............4...
> 00000020: 2c f2 00 00 00 00 00 00  34 00 20 00 04 00 28 00   ,.......4. ...(.
> 
> Received sample:
> 00000000: 7f 00 45 00 4c 00 46 00  01 00 01 00 01 00 00 00   ..E.L.F.........
> 00000010: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00   ................
> 00000020: 02 00 00 00 03 00 00 00  01 00 00 00 00 19 8d 04   ................
> loops 1 / 1
> 
> cts: 0 dsr: 0 rng: 0 dcd: 0 rx: 53434 tx: 0 frame 0 ovr 34201 par: 0
> brk: 0 buf_ovrr: 0
> 
> === 8< ===
> 
> R 356.360109 IIR 0xc4           RDI interrupt
> R 356.360114 LSR 0x63           DR + OE
> R 356.360119 RX 0x7f
> R 356.360124 LSR 0x63           DR + still OE
> R 356.360128 RX 0x45
> R 356.360133 LSR 0x63           DR + still OE
> R 356.360137 RX 0x4c
> R 356.360142 LSR 0x63           DR + still OE
> R 356.360147 RX 0x46
> R 356.360151 LSR 0x63           DR + still OE
> R 356.360156 RX 0x01
> R 356.360160 LSR 0x63           DR + still OE
> R 356.360165 RX 0x01
> R 356.360169 LSR 0x63
> R 356.360174 RX 0x01
> 
> As we can see the data is corrupted on Linux side. Can we somehow fix
> this bug/feature?

Not quite sure what you see as the issue.

1) That is a lot of overruns. Is that part of the test or are the overruns
   a regression?
2) If you mean the NUL bytes for overruns, I could have some functional mode
   mis-branched in the N_TTY line discipline. What are the termios settings
   on the rx side?

Regards,
Peter Hurley
