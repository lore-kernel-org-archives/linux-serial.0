From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v2 0/5] minitty: a minimal TTY layer alternative for
 embedded systems
Date: Mon, 3 Apr 2017 10:54:31 +0300
Message-ID: <CAHp75VdgEcyXPxENS87nHLtCEHqB5Z-1_T_W1opSiKqqNpeU2A@mail.gmail.com>
References: <20170401222119.25106-1-nicolas.pitre@linaro.org>
 <87pogur0y9.fsf@firstfloor.org> <alpine.LFD.2.20.1704021729470.1847@knanqh.ubzr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.LFD.2.20.1704021729470.1847@knanqh.ubzr>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: Andi Kleen <andi@firstfloor.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

On Mon, Apr 3, 2017 at 12:41 AM, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> On Sun, 2 Apr 2017, Andi Kleen wrote:
>> No PTYs seems like a big limitation. This means no sshd?

> Again, my ultimate system target is in the sub-megabyte of RAM.  I
> really doubt you'll be able to fit an SSH server in there even if PTYs
> were supported, unless sshd (or dropbear) can be made really tiny.

Are you sure you need Linux there? There is a nice Zephyr project
(OpenSource RTOS, POSIX compatible) exactly for microcontrollers.

While I can agree on making Linux stuff less fatty, I can't agree on
doing this way. We have for now two subsystems to serve for serial
devices, you are proposing third one for only narrow class of devices.
>From my point of view is better to achive your goal with existing
system (as a proof of concept maybe even with ugly #ifdef:fery).

-- 
With Best Regards,
Andy Shevchenko
