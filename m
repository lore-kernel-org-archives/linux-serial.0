From: Vignesh R <vigneshr@ti.com>
Subject: Re: [PATCH] serial: 8250: 8250_core: Use dev_name() during
 request_irq()
Date: Wed, 15 Mar 2017 17:12:17 +0530
Message-ID: <01911ed2-d64b-6f81-5ca2-7efa9b63d70f@ti.com>
References: <20170308121943.29340-1-vigneshr@ti.com>
 <CAHp75VeFKSbk9hvoJXdK6uOz+JYATD8D057iNv0JDuEnBFS=yw@mail.gmail.com>
 <2a0cf043-6e3f-6807-0794-d9d6f46b77f5@ti.com>
 <CAHp75Vc0Ap53s=6SU2o5QjgdaBDWKC24bym7HUt6jQ69HrpdCg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAHp75Vc0Ap53s=6SU2o5QjgdaBDWKC24bym7HUt6jQ69HrpdCg@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Jiri Slaby <jslaby@suse.com>
List-Id: linux-serial@vger.kernel.org



On Tuesday 14 March 2017 09:29 PM, Andy Shevchenko wrote:
> On Tue, Mar 14, 2017 at 3:44 PM, Vignesh R <vigneshr@ti.com> wrote:
>> On Monday 13 March 2017 01:35 AM, Andy Shevchenko wrote:
>>> On Wed, Mar 8, 2017 at 2:19 PM, Vignesh R <vigneshr@ti.com> wrote:
>>>> Passing "serial" as name during request_irq() results in all serial port
>>>> irqs have same name. This does not help much to easily identify which
>>>> irq belongs to which serial port instance. Therefore pass dev_name()
>>>> during request_irq() so that better identifiable name is listed for
>>>> serial ports in cat /proc/interrupts output.
>>>>
>>>> Output of cat /proc/interrupts
>>>> Before this patch:
>>>>  26:        689          0     GICv2 309 Edge      serial
>>>> After this patch:
>>>>  26:        696          0     GICv2 309 Edge      2530c00.serial
> 
>>  But, this change is making interrupt name more descriptive
> 
> It doesn't in PCI case, it makes it worse.
> 
> (The world is not DT-centric)
> 
>>> Besides that imagine what would be the name of PCI device here.
>>> I would suggest adding ID if you need one in a form like
>>> "serial%d", where ID may or may not be supplied by the actual 8250 drivers.
>>>
>>
>> Are you suggesting to use serial_index() as ID?
> 
> Yes.
> 

Ok thanks, I will send on incremental fix as this patch is already applied.

-- 
Regards
Vignesh
