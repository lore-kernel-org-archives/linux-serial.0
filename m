From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 2/2] tty: serial: bcm63xx: Allow device nodes to be
 renamed to /dev/ttyBCM*
Date: Mon, 10 Nov 2014 13:22:47 -0600
Message-ID: <CAL_JsqLYoUKr71Q-hfLQhXOVL72Gy7PkO-Zd4rBc0Fn-prOqTw@mail.gmail.com>
References: <1415523348-4631-1-git-send-email-cernekee@gmail.com>
 <1415523348-4631-2-git-send-email-cernekee@gmail.com> <CAL_JsqLXznpCo3YjN+XqF6cDG38C6dKzO9DHJmzi6=sNnAU=hQ@mail.gmail.com>
 <CAJiQ=7DUV0isdRooz6112Ncx07+9RE5DS5tMBwxr47hTWA8PAw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <CAJiQ=7DUV0isdRooz6112Ncx07+9RE5DS5tMBwxr47hTWA8PAw@mail.gmail.com>
Sender: stable-owner@vger.kernel.org
To: Kevin Cernekee <cernekee@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Grant Likely <grant.likely@linaro.org>, Florian Fainelli <f.fainelli@gmail.com>, Maxime Bizon <mbizon@freebox.fr>, Jonas Gorski <jogo@openwrt.org>, Linux-MIPS <linux-mips@linux-mips.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, stable@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Mon, Nov 10, 2014 at 9:05 AM, Kevin Cernekee <cernekee@gmail.com> wrote:
> On Mon, Nov 10, 2014 at 6:25 AM, Rob Herring <robh@kernel.org> wrote:
>> On Sun, Nov 9, 2014 at 2:55 AM, Kevin Cernekee <cernekee@gmail.com> wrote:
>>> By default, bcm63xx_uart.c uses the standard 8250 device naming and
>>> major/minor numbers.  There are at least two situations where this could
>>> be a problem:
>>>
>>> 1) Multiplatform kernels that need to support some chips that have 8250
>>> UARTs and other chips that have bcm63xx UARTs.
>>>
>>> 2) Some older chips like BCM7125 have a mix of both UART types.
>>>
>>> Add a new Kconfig option to tell the driver whether to register itself
>>> as ttyS or ttyBCM.  By default it will retain the existing "ttyS"
>>> behavior to avoid surprises.
>>
>> While I understand the desire to have stable names, this is the
>> opposite direction we want to go. Per platform tty names complicates
>> having a generic userspace. It is not so bad since most ARM platforms
>> use ttyS or ttyAMA, but just think what the kernel and userspace side
>> would look like if every single platform did this. We can't change
>> everything to ttyS because the other names are already an ABI.
>>
>> This can be solved with a udev rule to create sym links.
>
> Is it safe to register two console drivers named "ttyS" with the same
> major/minor numbers?  Maybe there is a trick to making them coexist?

No, but I think you can do dynamic minor numbers. I seem to recall
this coming up with the Samsung UARTs a while back.

Rob

> What I found is that everything worked fine on a system with
> bcm63xx_uart hardware until I enabled the 8250 driver in .config.  At
> that point the drivers clashed and I had no serial output
> post-bootconsole.  It didn't even get to userland before it failed.
> There are no DT entries mentioning 8250; the mere presence of the 8250
> driver killed my console.
>
> If this behavior is unexpected I can keep digging to find out what went wrong.
>
>> Or if you
>> just need to know which dev node is h/w uart X, you can get that from
>> sysfs.
>
> Right - I use busybox cttyhack in the init scripts to figure out the
> console name, so the same rootfs image can be used for both ttyS0 and
> ttyBCM0:
>
> # Put a shell on the serial port
> ::respawn:/bin/cttyhack /bin/sh -l
