From: Giulio Benetti <giulio.benetti@micronovasrl.com>
Subject: Re: [PATCH 1/4] serial: 8250: Copy em485 from port to real port.
Date: Thu, 7 Jun 2018 14:43:26 +0200
Message-ID: <0dd0cea7-9c12-dfc8-2a29-fa499d609e32@micronovasrl.com>
References: <CAJs94EZqdQAQG+inWvj89FCQtv06LxhY_J4YgNmK8mtvgDTchQ@mail.gmail.com>
 <20180606094942.71190-1-giulio.benetti@micronovasrl.com>
 <20180606094942.71190-4-giulio.benetti@micronovasrl.com>
 <069f5cd3309e83d13c74929f240720b232ea7251.camel@linux.intel.com>
 <0bc400b1-6178-2021-c9a3-3190d1a1de32@micronovasrl.com>
 <2abe2137e699e5ae3100b97316da469f6d1c9bb9.camel@linux.intel.com>
 <CAJs94EZx2ZdEL14SCEBomEfXLRPN4FfOp4yE44kfpnE+5+Ze-g@mail.gmail.com>
 <d3c4e356-2c04-731f-a665-a445a6bf68af@micronovasrl.com>
 <CAJs94EbY1apGLUK+6ZXy=j5Uitox+WbG903_5SX2kW_tCLQzPw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJs94EbY1apGLUK+6ZXy=j5Uitox+WbG903_5SX2kW_tCLQzPw@mail.gmail.com>
Content-Language: it
Sender: linux-kernel-owner@vger.kernel.org
To: "Matwey V. Kornilov" <matwey.kornilov@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Matthias Brugger <mbrugger@suse.com>, Kees Cook <keescook@chromium.org>, Allen Pais <allen.lkml@gmail.com>, Sean Young <sean@mess.org>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

Il 07/06/2018 09:03, Matwey V. Kornilov ha scritto:
> 2018-06-06 22:15 GMT+03:00 Giulio Benetti <giulio.benetti@micronovasrl.com>:
>> Il 06/06/2018 20:55, Matwey V. Kornilov ha scritto:
>>>
>>> 2018-06-06 16:11 GMT+03:00 Andy Shevchenko
>>> <andriy.shevchenko@linux.intel.com>:
>>>>
>>>> On Wed, 2018-06-06 at 14:15 +0200, Giulio Benetti wrote:
>>>>>
>>>>> Il 06/06/2018 13:56, Andy Shevchenko ha scritto:
>>>>>>
>>>>>> On Wed, 2018-06-06 at 11:49 +0200, Giulio Benetti wrote:
>>>>>>>
>>>>>>> em485 gets lost during
>>>>>>>
>>>>>>> Copy em485 to final uart port.
>>>>>>>
>>>>>>
>>>>>> Is it needed at all?
>>>>>>
>>>>>> The individual driver decides either to use software emulation (and
>>>>>> calls explicitly serial8250_em485_init() for that) or do HW assisted
>>>>>> stuff.
>>>>>
>>>>>
>>>>> In 8250_dw.c, during probe(), I need to call dw8250_rs485_config()
>>>>> against local struct uart_8250_port uart = {};
>>>>> Inside serial8250_register_8250_port() not all uart fields are
>>>>> copied(em485 too).
>>>>> So after probe, em485 is NULL.
>>>>>
>>>>> Another way could be to call dw8250_rs485_config() against real uart
>>>>> port, after calling serial8250_register_8250_port(),
>>>>> would it make sense?
>>>>
>>>>
>>>> Look at OMAP case closely. They have a callback to configure RS485 which
>>>> is called in uart_set_rs485_config()  which is called whenever user
>>>> space does TIOCGRS485 IOCTL.
>>>>
>>>> So, it's completely driven by user space which makes sense by my
>>>> opinion.
>>>
>>>
>>> AFAIU, Giulio wants to add support for rs485-enabled-at-boot-time
>>> device tree option (see bindings/serial/rs485.txt for reference).
>>
>>
>> Yes, I want to add support for "rs485-enabled-at-boot-time" property,
>> maybe I had to write better commit log and a cover letter. Sorry.
>>
>>> I suppose it is only important for use-case when rs485 used as slave
>>> (peripheral role).
>>
>>
>> It's important also for master, because RTS, if RTS_AFTER_SEND is set,
>> remains not asserted(trasnmission) until userspace opens that serial port.
>>
> 
> And it makes no sense, because how are you going to transmit and
> receive not opening the port and not running an application?
> It is master who transmits the data first. So, before all systems
> going to work you have to open the port from userspace.
> 
> In case of slave this of course makes sense.
> 

Yes it's true, my mistake, it works as master, even if bus will be held 
busy by master until port is open.

As slave it keeps bus busy.

IMHO it would be the best to have rs485 free until port is open,
this also reflects the reality:
when rs485 ON and RTS_AFTER_SEND is set, if port is closed or open 
without transmitting RTS must be asserted(pin low, rx mode).
Agree?

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
