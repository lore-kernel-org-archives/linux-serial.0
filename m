From: Andre Przywara <andre.przywara@arm.com>
Subject: Re: [PATCH v13 2/5] uart: pl011: Introduce register accessor
Date: Sat, 19 Sep 2015 22:45:11 +0100
Message-ID: <55FDD767.7070109@arm.com>
References: <1438328959-16177-1-git-send-email-jun.nie@linaro.org>
 <1438328959-16177-3-git-send-email-jun.nie@linaro.org>
 <55FBECCD.2080906@arm.com>
 <CABymUCPKqevt9tBEqLnxT-fen2PLy48QMkCfO+nm7-16wHQ8Og@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CABymUCPKqevt9tBEqLnxT-fen2PLy48QMkCfO+nm7-16wHQ8Og@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Jun Nie <jun.nie@linaro.org>
Cc: "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "peter@hurleysoftware.com" <peter@hurleysoftware.com>, "jason.liu@linaro.org" <jason.liu@linaro.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, Andrew Jackson <Andrew.Jackson@arm.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "shawn.guo@linaro.org" <shawn.guo@linaro.org>, "wan.zhijun@zte.com.cn" <wan.zhijun@zte.com.cn>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

Hi Jun,

thanks for your reply. Just a quick one below...

...
>>> @@ -203,6 +206,24 @@ struct uart_amba_port {
>>>  #endif
>>>  };
>>>
>>> +static unsigned int pl011_readw(struct uart_amba_port *uap, int index)
>>> +{
>>> +       WARN_ON(index > REG_NR);
>>> +       return readw_relaxed(uap->port.membase + (index << 2));
>>> +}
>>> +
>>> +static void pl011_writew(struct uart_amba_port *uap, int val, int index)
>>> +{
>>> +       WARN_ON(index > REG_NR);
>>> +       writew_relaxed(val, uap->port.membase + (index << 2));
>>> +}
>>
>> I wonder if you could rename those to pl011_{read,write}, respectively
>> (loosing the "w" suffix).
>> The SBSA UART spec reads as the registers are actually accessible via
>> 32-bit accesses and rumour has it that there are implementations which
>> rely on that and don't work with ldrh/strh.
>> I am still waiting for reports about actual hardware to fail, but we
>> might be forced to change the access width to 32-bit for the SBSA subset
>> in the future. So having wrapper functions would make that change much
>> easier, but having them without a suffix from the beginning would even
>> be better, as I wouldn't be bothered to rename them later on.
> 
> OK, will change to 32-bit access in future version.

Sorry, there seems to be a misunderstanding here. 16-bit accesses are
totally fine for every _PL011_ part, it is just the SBSA-UART (which
uses this very same driver) which _may_ require 32-bit accesses.

So I was asking just to name the functions pl011_write and pl011_read,
so that their "w" suffix does not delude people into them being forever
16-bit wide. If needed (as said I am still waiting for failure reports),
we can then change the access width inside these functions to the
appropriate size later without requiring a name change again.

So please keep the {write,read}w_relaxed calls in there, just change the
function name.

Thanks!
Andre.
