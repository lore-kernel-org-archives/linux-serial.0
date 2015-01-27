From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH 2/3] tty/serial: of_serial: add support for PXA/MMP uarts
Date: Tue, 27 Jan 2015 10:09:33 -0500
Message-ID: <54C7AA2D.7080202@hurleysoftware.com>
References: <1422334209-23125-1-git-send-email-robh@kernel.org>
 <1422334209-23125-2-git-send-email-robh@kernel.org>
 <54C78823.7050504@hurleysoftware.com>
 <CAL_Jsq+8jDN+fYyed5RYd2e1K+H_R1NkjT38WXSpKfxTLgsDbQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAL_Jsq+8jDN+fYyed5RYd2e1K+H_R1NkjT38WXSpKfxTLgsDbQ@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Rob Herring <robh@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On 01/27/2015 09:30 AM, Rob Herring wrote:
> On Tue, Jan 27, 2015 at 6:44 AM, Peter Hurley <peter@hurleysoftware.com> wrote:
>> Hi Rob,
>>
>> On 01/26/2015 11:50 PM, Rob Herring wrote:
>>> Add mrvl,pxa-uart and mrvl,mmp-uart compatible strings for the of_serial
>>> driver. These are 8250 variants which have a port type of PORT_XSCALE.
>>>
>>> There is also the serial driver pxa.c with these compatible strings
>>> already. However, it can be replaced with the common 8250 driver. It has
>>> some issues like it cannot coexist with the 8250 driver due to tty name
>>> collision. That also means adding these compatible strings here should
>>> not case a problem.
>>
>> So what determines which driver is controlling the port if both
>> drivers are built-in?
> 
> If both are built-in, whoever registers ttyS ports first wins. This
> will be the 8250 driver due to link order.

Ok, but then I think the commit log should reflect that this patch
effectively replaces pxa2xx-uart driver with the 8250 driver for PXA/MMP uarts
if both drivers are built-in or both drivers are modules.

> So I guess PXA systems have avoided this by never building in 8250 driver.

Platform devices are initialized first, so before this patch the pxa2xx-uart
driver would have claimed the platform ports before the 8250 driver, if
both were built-in (or both modules).

Maybe Kconfig should warn if they're both built-in or both modules?

Regards,
Peter Hurley

>>> Signed-off-by: Rob Herring <robh@kernel.org>
>>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>> Cc: Jiri Slaby <jslaby@suse.cz>
>>> Cc: linux-serial@vger.kernel.org
>>> ---
>>>  drivers/tty/serial/of_serial.c | 4 ++++
>>>  1 file changed, 4 insertions(+)
>>>
>>> diff --git a/drivers/tty/serial/of_serial.c b/drivers/tty/serial/of_serial.c
>>> index 3194b42..fbb719c 100644
>>> --- a/drivers/tty/serial/of_serial.c
>>> +++ b/drivers/tty/serial/of_serial.c
>>> @@ -335,6 +335,10 @@ static struct of_device_id of_platform_serial_table[] = {
>>>               .data = (void *)PORT_ALTR_16550_F64, },
>>>       { .compatible = "altr,16550-FIFO128",
>>>               .data = (void *)PORT_ALTR_16550_F128, },
>>> +     { .compatible = "mrvl,mmp-uart",
>>> +             .data = (void *)PORT_XSCALE, },
>>> +     { .compatible = "mrvl,pxa-uart",
>>> +             .data = (void *)PORT_XSCALE, },
>>>  #ifdef CONFIG_SERIAL_OF_PLATFORM_NWPSERIAL
>>>       { .compatible = "ibm,qpace-nwp-serial",
>>>               .data = (void *)PORT_NWPSERIAL, },
>>>
>>
