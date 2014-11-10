From: Kevin Cernekee <cernekee@gmail.com>
Subject: Re: [PATCH 2/2] tty: serial: bcm63xx: Allow device nodes to be
 renamed to /dev/ttyBCM*
Date: Mon, 10 Nov 2014 11:50:56 -0800
Message-ID: <CAJiQ=7C5ki+9opnH68Kw9a573PmO=ANeiVutmVROUP2Typn2qw@mail.gmail.com>
References: <1415523348-4631-1-git-send-email-cernekee@gmail.com>
 <1415523348-4631-2-git-send-email-cernekee@gmail.com> <CAL_JsqLXznpCo3YjN+XqF6cDG38C6dKzO9DHJmzi6=sNnAU=hQ@mail.gmail.com>
 <CAJiQ=7DUV0isdRooz6112Ncx07+9RE5DS5tMBwxr47hTWA8PAw@mail.gmail.com> <CAL_JsqLYoUKr71Q-hfLQhXOVL72Gy7PkO-Zd4rBc0Fn-prOqTw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <CAL_JsqLYoUKr71Q-hfLQhXOVL72Gy7PkO-Zd4rBc0Fn-prOqTw@mail.gmail.com>
Sender: stable-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Grant Likely <grant.likely@linaro.org>, Florian Fainelli <f.fainelli@gmail.com>, Maxime Bizon <mbizon@freebox.fr>, Jonas Gorski <jogo@openwrt.org>, Linux-MIPS <linux-mips@linux-mips.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, stable@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Mon, Nov 10, 2014 at 11:22 AM, Rob Herring <robh@kernel.org> wrote:
>>> This can be solved with a udev rule to create sym links.
>>
>> Is it safe to register two console drivers named "ttyS" with the same
>> major/minor numbers?  Maybe there is a trick to making them coexist?
>
> No, but I think you can do dynamic minor numbers. I seem to recall
> this coming up with the Samsung UARTs a while back.

The other variations I've seen in the tree are:

nwpserial: ttySQ, major 4 minor 68 (not 64)

sunhv, sunsab, sunsu, sunzilog: set uart_driver->major to 4 but let
uart_driver->minor default to 0

SERIAL_ATMEL_TTYAT: compile-time selectable between ttySn (4/64) and
ttyATn (204/154).  txx9 does something similar using
SERIAL_TXX9_STDSERIAL.

A whole bunch of other SoC serial drivers use major 204 and a custom
name like "ttyAL".  Some of these show up in
Documentation/devices.txt; others don't.  ~3 drivers use 204/64 from
the middle of the Altix assigned range.

What is the current best practice for new drivers?
