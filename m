From: Giulio Benetti <giulio.benetti@micronovasrl.com>
Subject: Re: [PATCH 4/4] serial: core: Mask mctrl with TIOCM_RTS too if rs485
 on and RTS_AFTER_SEND set.
Date: Wed, 6 Jun 2018 14:07:45 +0200
Message-ID: <5bda9e82-369a-ff5f-fef8-f3933c6f1c64@micronovasrl.com>
References: <CAJs94EZqdQAQG+inWvj89FCQtv06LxhY_J4YgNmK8mtvgDTchQ@mail.gmail.com>
 <20180606094942.71190-1-giulio.benetti@micronovasrl.com>
 <20180606094942.71190-3-giulio.benetti@micronovasrl.com>
 <a156ce90ab7e45ecf6936c29cc5d976c56f49a51.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <a156ce90ab7e45ecf6936c29cc5d976c56f49a51.camel@linux.intel.com>
Content-Language: it
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: matwey.kornilov@gmail.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Matthias Brugger <mbrugger@suse.com>, Kees Cook <keescook@chromium.org>, Sean Young <sean@mess.org>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

Il 06/06/2018 14:03, Andy Shevchenko ha scritto:
> On Wed, 2018-06-06 at 11:49 +0200, Giulio Benetti wrote:
>> If rs485 is enabled and RTS_AFTER_SEND is set on startup need to keep
>> TIOCM_RTS asserted to keep rs485 transceiver in RX when idle.
>>
>> Check if rs485 is on and RTS_AFTER_SEND is set and mask port->mctrl
>> with
>> TIOCM_RTS too and not only TIOCM_DTR.
>>
> 
> This one feels wrong to be in serial_core.c. Perhaps in 8250/8250*.c.

I've tried to avoid modifying serial_core.c but if it masks mctrl only 
with TIOCM_DTR, it forces RTS unasserted.
Another way could be:
If rs485 ON and RTS_AFTER_SEND set, then ignore RTS driving in 
8250_set_mctrl, would it make sense?

Thanks

-- 
Giulio Benetti
CTO

MICRONOVA SRL
Sede: Via A. Niedda 3 - 35010 Vigonza (PD)
Tel. 049/8931563 - Fax 049/8931346
Cod.Fiscale - P.IVA 02663420285
Capitale Sociale € 26.000 i.v.
Iscritta al Reg. Imprese di Padova N. 02663420285
Numero R.E.A. 258642
