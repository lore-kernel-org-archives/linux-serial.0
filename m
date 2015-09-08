From: Jun Nie <jun.nie@linaro.org>
Subject: Re: [PATCH v2] serial: pl011: Fix earlycon register LUT breakage
Date: Tue, 8 Sep 2015 15:53:28 +0800
Message-ID: <CABymUCNmY+txUSaJDXsn4hb5p=frT5uAN-6Y97t+b7g224dkvw@mail.gmail.com>
References: <1441468654-6923-1-git-send-email-jun.nie@linaro.org>
 <CABymUCPMSKPwqtivYMJa3n-2GWbjhM6u7KDOwD1ypJRCeLZo7Q@mail.gmail.com>
 <CABymUCN4tuNMC1m0AS36OZ9MVOa3HtH3mYC0s04LyUWVPxmZ4A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CABymUCN4tuNMC1m0AS36OZ9MVOa3HtH3mYC0s04LyUWVPxmZ4A@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Marc Zyngier <marc.zyngier@arm.com>, Leif Lindholm <leif.lindholm@linaro.org>, Peter Hurley <peter@hurleysoftware.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, andre.przywara@arm.com, Andrew.Jackson@arm.com, Greg KH <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, Shawn Guo <shawn.guo@linaro.org>, Will Deacon <will.deacon@arm.com>
Cc: Jason Liu <jason.liu@linaro.org>, Jun Nie <jun.nie@linaro.org>, "wan.zhijun" <wan.zhijun@zte.com.cn>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

2015-09-08 15:52 GMT+08:00 Jun Nie <jun.nie@linaro.org>:
> 2015-09-08 10:23 GMT+08:00 Jun Nie <jun.nie@linaro.org>:
>> 2015-09-05 23:57 GMT+08:00 Jun Nie <jun.nie@linaro.org>:
>>> Commit 7b753f318d14 ("uart: pl011: Introduce register accessor")
>>> mistakenly used the register LUT i/o accessors for the pl011
>>> earlycon. Since the port has not been probed at earlycon time,
>>> the struct uart_amba_port (and register LUTs) are uninitialized.
>>>
>>> Use direct register addressing for pl011 earlycon; other h/w supported
>>> by the amba-pl011 driver should declare an alternate earlycon.
>>>
>>> Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
>>> Signed-off-by: Jun Nie <jun.nie@linaro.org>
>>> ---
>>>  drivers/tty/serial/amba-pl011.c | 15 +++------------
>>>  1 file changed, 3 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
>>> index 2af09ab..cce41e0 100644
>>> --- a/drivers/tty/serial/amba-pl011.c
>>> +++ b/drivers/tty/serial/amba-pl011.c
>>> @@ -326,12 +326,6 @@ static void pl011_writew(struct uart_amba_port *uap, int val, int index)
>>>         writew_relaxed(val, uap->port.membase + uap->reg_lut[index]);
>>>  }
>>>
>>> -static void pl011_writeb(struct uart_amba_port *uap, u8 val, int index)
>>> -{
>>> -       WARN_ON(index > REG_NR);
>>> -       writeb_relaxed(val, uap->port.membase + uap->reg_lut[index]);
>>> -}
>>> -
>>>  /*
>>>   * Reads up to 256 characters from the FIFO or until it's empty and
>>>   * inserts them into the TTY layer. Returns the number of characters
>>> @@ -2348,13 +2342,10 @@ static struct console amba_console = {
>>>
>>>  static void pl011_putc(struct uart_port *port, int c)
>>>  {
>>> -       struct uart_amba_port *uap =
>>> -           container_of(port, struct uart_amba_port, port);
>>> -
>>> -       while (pl011_readw(uap, REG_FR) & UART01x_FR_TXFF)
>>> +       while (readw_relaxed(port->membase + UART01x_FR) & UART01x_FR_TXFF)
>>>                 ;
>>> -       pl011_writeb(uap, c, REG_DR);
>>> -       while (pl011_readw(uap, REG_FR) & uap->fr_busy)
>>> +       writeb_relaxed(c, port->membase + UART01x_DR);
>>> +       while (readw_relaxed(port->membase + UART01x_FR) & UART01x_FR_BUSY)
>>>                 ;
>>>  }
>>>
>>> --
>>> 1.9.1
>>>
>>
>> Could anybody help test this earlycon patch on hardware with standard
>> pl011 serial? Your help is appreciated and valuable no matter the
>> previous patch set is carried on or reverted.
>> Thank you very much!
>>
>> Jun

cc linux-arm-kernel@lists.infradead.org in case someone may have
resource to help have a test. Thank you!

Jun
