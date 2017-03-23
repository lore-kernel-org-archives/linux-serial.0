From: Vignesh R <vigneshr@ti.com>
Subject: Re: [PATCH 1/2] tty: serial_core: Add name field to uart_port struct
Date: Thu, 23 Mar 2017 17:43:36 +0530
Message-ID: <61fd3976-1160-f0cb-15ce-91c46f3d749e@ti.com>
References: <20170321133636.8814-1-vigneshr@ti.com>
 <20170321133636.8814-2-vigneshr@ti.com>
 <CAHp75VfHtTV6L0GE61kMiHMCQrUSwGJPRxsiNuOCD9mY7MPpZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAHp75VfHtTV6L0GE61kMiHMCQrUSwGJPRxsiNuOCD9mY7MPpZQ@mail.gmail.com>
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
Cc: Jisheng Zhang <jszhang@marvell.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Jiri Slaby <jslaby@suse.com>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org



On Thursday 23 March 2017 12:15 AM, Andy Shevchenko wrote:
> On Tue, Mar 21, 2017 at 3:36 PM, Vignesh R <vigneshr@ti.com> wrote:
>> Introduce a field to store name of uart_port that can be used to easily
>> identify uart port instances on a system that has more than one uart
> 
> uart -> UART
> 
>> instance. The name is of the form ttyXN(eg. ttyS0, ttyAMA0,..) where N
>> is number that particular uart instance.
>> This field will be useful when printing debug info for a particular port
>> or in register irqs with unique irq name. Port name is populated during
> 
> irq(s) -> IRQ(s)
> 
>> uart_add_one_port().
> 
>> +       snprintf(uport->name, sizeof(uport->name), "%s%d", drv->dev_name,
>> +                drv->tty_driver->name_base + uport->line);
> 
> This is fragile. dev_name is defined as pointer, so, it would be any length.
> So, better to use [devm_]kasprintf().
> 

Ok, will you use kasprintf() (and corresponding kfree()) as device is
not yet allocated at this stage to use devm_*.

-- 
Regards
Vignesh
