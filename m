From: "Matwey V. Kornilov" <matwey@sai.msu.ru>
Subject: Re: [PATCH] 8250: Hypervisors always export working 16550A UARTs.
Date: Fri, 29 Apr 2016 10:01:08 +0300
Message-ID: <CAJs94EYUs2Gx9z9YmK2htXnOQSE4EobNdbnDCF6W3AebsXmQ+Q@mail.gmail.com>
References: <1461881913-23967-1-git-send-email-rjones@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1461881913-23967-1-git-send-email-rjones@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Richard W.M. Jones" <rjones@redhat.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Peter Hurley <peter@hurleysoftware.com>, andriy.shevchenko@linux.intel.com, phillip.raffeck@fau.de, anton.wuerfel@fau.de, yamada.masahiro@socionext.com, valentinrothberg@gmail.com, linux-serial@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, ddutile@redhat.com
List-Id: linux-serial@vger.kernel.org

2016-04-29 1:18 GMT+03:00 Richard W.M. Jones <rjones@redhat.com>:
> [This is an opinionated patch, mainly for discussion.]
>
> I'm trying to reduce the time taken in the kernel in initcalls, with
> my aim being to reduce the current ~700ms spent in initcalls before
> userspace, down to something like 100ms.  All times on my Broadwell-U
> laptop, under virtualization.  The purpose of this is to be able to
> launch VMs around containers with minimal overhead, like Intel Clear
> Containers, but using standard distro kernels and qemu.
>
> Currently the kernel spends 25ms inspecting the UART that we passed to
> it from qemu to find out whether it's an 8250/16550/16550A perhaps
> with a non-working FIFO or other quirks.  Well, it isn't -- it's a
> working emulated 16550A, with a FIFO and no quirks, and if it isn't,
> we should fix qemu.
>
> So the patch detects if we're running virtualized (perhaps it should
> only check for qemu/KVM?) and if so, shortcuts the tests.

Does anybody know, whether it is possible to pass through real
hardware serial port to a guest? It seems to be as simple as to pass
through an interrupt and memory IO ports.

>
> Rich.
>



-- 
With best regards,
Matwey V. Kornilov.
Sternberg Astronomical Institute, Lomonosov Moscow State University, Russia
119991, Moscow, Universitetsky pr-k 13, +7 (495) 9392382
