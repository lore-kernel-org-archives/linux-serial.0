From: Alexander Stein <alexander.stein@systec-electronic.com>
Subject: Re: [PATCH] serial: imx: reduce irq-latency after rx overflow
Date: Mon, 22 Jun 2015 11:47:45 +0200
Message-ID: <3567087.WTnpQKCuCx@ws-stein>
References: <5585A220.5000405@gmx.at> <4275820.CIOTxUBfmF@ws-stein> <5587C53A.9080308@gmx.at>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5587C53A.9080308@gmx.at>
Sender: linux-kernel-owner@vger.kernel.org
To: Manfred Schlaegl <manfred.schlaegl@gmx.at>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Manfred Schlaegl <manfred.schlaegl@ginzinger.com>
List-Id: linux-serial@vger.kernel.org

Hello Manfred,

On Monday 22 June 2015 10:20:10, Manfred Schlaegl wrote:
> On 2015-06-22 08:48, Alexander Stein wrote:
> > Am Samstag, 20. Juni 2015, 19:25:52 schrieb Manfred Schlaegl:
> >> To prevent problems with interrupt latency, and due to the fact, that
> >> the error will be counted anyway (icount.overrun), the dev_err is simply
> >> removed.
> >>
> >> Background:
> >> If an rx-fifo overflow occurs a dev_err message was called in interrupt
> >> context. Since dev_err messages are written to console in a synchronous way
> >> (unbuffered), and console may be a serial terminal, this leads to a
> >> highly increased interrupt-latency (several milliseconds).
> >> As a result of the high latency more rx-fifo overflows will happen, and
> >> therefore a feedback loop of errors is created.
> > 
> > I understand your rationale but removing this error message from kernel log removes the possibility to detect serial overruns by simply check the kernel log or output on kernel console. AFAICS you have to use TIOCGICOUNT to get the error counters.
> > How about introducing a rate limit for this kernel message?
> > 
> 
> Hello!
> 
> I understand your argument, but:
>  1. In my personal opinion kernel error messages should only be used on internal errors (missing resources, asserts, ...) and in cases where no other way is (yet) available to report errors (by counters, return values, ...). Lost RX bytes on uarts seem more like a communication error and should be silently handled by higher layers using error counters, or protocol internal mechanisms.
>  2. I have found no other serial driver (except serial-tegra and imx) that reports this kind of errors using kernel messages.
>  3. Error counters for serial interfaces can also be retrieved from userspace by using procfs -> implemented in serial_core; e.g. /proc/tty/driver/IMX-uart.

Ah, I've just noticed those errors will only be written when > 0. I think this is fine. A bit cumbersome for automatic parsing, but reading manually will be ok.

Acked-By: Alexander Stein <alexander.stein@systec-electronic.com>

Best regards,
Alexander Stein
-- 
Dipl.-Inf. Alexander Stein

SYS TEC electronic GmbH
Am Windrad 2
08468 Heinsdorfergrund
Tel.: 03765 38600-1156
Fax: 03765 38600-4100
Email: alexander.stein@systec-electronic.com
Website: www.systec-electronic.com
 
Managing Director: Dipl.-Phys. Siegmar Schmidt
Commercial registry: Amtsgericht Chemnitz, HRB 28082
