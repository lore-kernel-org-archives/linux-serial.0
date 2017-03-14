From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH] serial: 8250: 8250_core: Use dev_name() during request_irq()
Date: Tue, 14 Mar 2017 17:59:01 +0200
Message-ID: <CAHp75Vc0Ap53s=6SU2o5QjgdaBDWKC24bym7HUt6jQ69HrpdCg@mail.gmail.com>
References: <20170308121943.29340-1-vigneshr@ti.com> <CAHp75VeFKSbk9hvoJXdK6uOz+JYATD8D057iNv0JDuEnBFS=yw@mail.gmail.com>
 <2a0cf043-6e3f-6807-0794-d9d6f46b77f5@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2a0cf043-6e3f-6807-0794-d9d6f46b77f5@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vignesh R <vigneshr@ti.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

On Tue, Mar 14, 2017 at 3:44 PM, Vignesh R <vigneshr@ti.com> wrote:
> On Monday 13 March 2017 01:35 AM, Andy Shevchenko wrote:
>> On Wed, Mar 8, 2017 at 2:19 PM, Vignesh R <vigneshr@ti.com> wrote:
>>> Passing "serial" as name during request_irq() results in all serial port
>>> irqs have same name. This does not help much to easily identify which
>>> irq belongs to which serial port instance. Therefore pass dev_name()
>>> during request_irq() so that better identifiable name is listed for
>>> serial ports in cat /proc/interrupts output.
>>>
>>> Output of cat /proc/interrupts
>>> Before this patch:
>>>  26:        689          0     GICv2 309 Edge      serial
>>> After this patch:
>>>  26:        696          0     GICv2 309 Edge      2530c00.serial

>  But, this change is making interrupt name more descriptive

It doesn't in PCI case, it makes it worse.

(The world is not DT-centric)

>> Besides that imagine what would be the name of PCI device here.
>> I would suggest adding ID if you need one in a form like
>> "serial%d", where ID may or may not be supplied by the actual 8250 drivers.
>>
>
> Are you suggesting to use serial_index() as ID?

Yes.

-- 
With Best Regards,
Andy Shevchenko
