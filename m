From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2] tty/serial: atmel: use port->name as name in
 request_irq()
Date: Fri, 4 May 2018 15:23:08 -0500
Message-ID: <CAL_JsqJ+84OFyN07XWsb0hSHxtxL_V6gSfO+iMSOU1bceztr3Q@mail.gmail.com>
References: <20180426150625.q5tqcb7fzchvkb5d@linutronix.de>
 <20180426151222.6vw67lwqmu6ffgnw@linutronix.de>
 <0dbf4a4c-71d4-6456-67b9-d4d202acffb7@sorico.fr>
 <20180502191632.tgda4g5v3rhncx7c@linutronix.de>
 <4f3f6e7c-2806-1749-1523-72d5c8eb8229@sorico.fr>
 <20180503124410.n6ze2ngwv6ekjhdr@linutronix.de>
 <921729c6-7c3f-11cd-8634-044a5c52f810@sorico.fr>
 <80203f75-f38e-6214-e9b6-8512c5941647@sorico.fr>
 <20180504081447.enontsm6jod4xa6g@linutronix.de>
 <d62a945c-f81e-d7e5-8431-a7948a0b833c@sorico.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <d62a945c-f81e-d7e5-8431-a7948a0b833c@sorico.fr>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Richard Genoud <richard.genoud@gmail.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>, Peter Hurley <peter@hurleysoftware.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, Jiri Slaby <jslaby@suse.com>, Thomas Gleixner <tglx@linutronix.de>, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

On Fri, May 4, 2018 at 5:28 AM, Richard Genoud <richard.genoud@gmail.com> wrote:
> On 04/05/2018 10:14, Sebastian Andrzej Siewior wrote:
>> I was puzzled while looking at /proc/interrupts and random things showed
>> up between reboots. This occurred more often but I realised it later. The
>> "correct" output should be:
>> |38:      11861  atmel-aic5   2 Level     ttyS0
>>
>> but I saw sometimes
>> |38:       6426  atmel-aic5   2 Level     tty1
>>
>> and accounted it wrongly as correct. This is use after free and the
>> former example randomly got the "old" pointer which pointed to the same
>> content. With SLAB_FREELIST_RANDOM and HARDENED I even got
>> |38:       7067  atmel-aic5   2 Level     E=Started User Manager for UID 0
>>
>> or other nonsense.
>> As it turns out the tty, pointer that is accessed in atmel_startup(), is
>> freed() before atmel_shutdown(). It seems to happen quite often that the
>> tty for ttyS0 is allocated and freed while ->shutdown is not invoked. I
>> don't do anything special - just a systemd boot :)
>>
>> Use port->name as the IRQ name for request_irq(). This exists as long as
>> the driver is loaded so no use-after-free here.
>> For backports before v4.12 I suggest to use `"atmel_serial"' instead
>> `port->name' (that member was introduced in f7048b15900f ("tty: serial_core:
>> Add name field to uart_port struct").
>>
>> Cc: stable@vger.kernel.org
> I think it's safer to use:
> Cc: stable@vger.kernel.org # 4.14
> Because the stable team may miss your comment, and even if they don't, I
> think it's not their role to adapt the patch to 4.9.x (and test it !)
> IMHO, the best way is to add # 4.14 and when it's applied on 4.14.x,
> send a tested backport for 4.9.x
>
> Besides that, you can add my:
> Acked-by: Richard Genoud <richard.genoud@gmail.com>
>
> Rob, do you agree with this fix ?

Yes, one less dependency on tty struct in serial drivers is a good
thing. However, I find port->name to be a somewhat pointless addition.
Most platform drivers (which most serial drivers are) use the device
name for registering their IRQ. And now serial drivers may not even
have a tty with serdev. Using the device name would also solve your
backporting issue. But either way:

Acked-by: Rob Herring <robh@kernel.org>

Rob
