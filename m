From: Richard Genoud <richard.genoud@gmail.com>
Subject: Re: [PATCH] tty/serial: atmel: use port->name as name in request_irq()
Date: Thu, 3 May 2018 17:12:28 +0200
Message-ID: <e13476e8-fd19-78c4-bfc2-774136ccda19@sorico.fr>
References: <20180426150625.q5tqcb7fzchvkb5d@linutronix.de>
 <20180426151222.6vw67lwqmu6ffgnw@linutronix.de>
 <0dbf4a4c-71d4-6456-67b9-d4d202acffb7@sorico.fr>
 <20180502191632.tgda4g5v3rhncx7c@linutronix.de>
 <4f3f6e7c-2806-1749-1523-72d5c8eb8229@sorico.fr>
 <20180503124410.n6ze2ngwv6ekjhdr@linutronix.de>
 <921729c6-7c3f-11cd-8634-044a5c52f810@sorico.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <921729c6-7c3f-11cd-8634-044a5c52f810@sorico.fr>
Content-Language: fr
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Rob Herring <robh@kernel.org>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Peter Hurley <peter@hurleysoftware.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>, tglx@linutronix.de, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On 03/05/2018 15:34, Richard Genoud wrote:
> On 03/05/2018 14:44, Sebastian Andrzej Siewior wrote:
>> On 2018-05-03 14:36:03 [+0200], Richard Genoud wrote:
>>> Could resend your patch with Fixes: in the commit message ?
>>
>> will do shortly.
>>
>>> BTW, I didn't manage to reproduce the behavior you describe, could you
>>> give me your .config and describe a little more how you manage to
>>> trigger this bug ?
>> .config sent offlist.
>> Did you not reproduce this even with the second/debug patch I've sent?
> Nope. (I tried on a sam9g35 with buildroot/busybox)
> 
> I have a sama5d3 with a debian as a home server, I'll give it a try.

Ok, I reproduced the use-after-free on a SAMA5D2 and on a SAMA5D3, both
with debian (sid / stretch).
After the patch, no mode funny things in /proc/interrupts.

> 
>>
>>> (do you use the console on serial debug ? which board ? )
>> up to date debian sid booting with systemd. After boot completed I do
>> "cat /proc/interrupts" and check for the "gone" string.
>> This is
>> [    0.000000] OF: fdt:Machine model: SAMA5D3 Xplained
>> [    0.000000] Kernel command line: earlyprintk=ttyS0,115200 console=ttyS0,115200 root=/dev/mmcblk0p2 rootwait
>> [    0.520000] AT91: Detected SoC family: sama5d3
>> [    0.520000] AT91: Detected SoC: sama5d36, revision 2
>>
>> at91-sama5d3_xplained.dtb
>>
>> Is this enough?
> 
> Great,
> 
> Thanks !
> 
