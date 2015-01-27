From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH 2/3] tty/serial: of_serial: add support for PXA/MMP uarts
Date: Tue, 27 Jan 2015 14:43:38 -0500
Message-ID: <54C7EA6A.4010805@hurleysoftware.com>
References: <1422334209-23125-1-git-send-email-robh@kernel.org>
 <1422334209-23125-2-git-send-email-robh@kernel.org>
 <54C78823.7050504@hurleysoftware.com>
 <CAL_Jsq+8jDN+fYyed5RYd2e1K+H_R1NkjT38WXSpKfxTLgsDbQ@mail.gmail.com>
 <54C7AA2D.7080202@hurleysoftware.com>
 <CAL_Jsq+wxY0=S1ff-Fk0xDBxHdhBvNopLpjfCETVoo_mou658w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAL_Jsq+wxY0=S1ff-Fk0xDBxHdhBvNopLpjfCETVoo_mou658w@mail.gmail.com>
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

On 01/27/2015 11:44 AM, Rob Herring wrote:
> On Tue, Jan 27, 2015 at 9:09 AM, Peter Hurley <peter@hurleysoftware.com> wrote:
>> On 01/27/2015 09:30 AM, Rob Herring wrote:
>>> On Tue, Jan 27, 2015 at 6:44 AM, Peter Hurley <peter@hurleysoftware.com> wrote:
>>>> Hi Rob,
>>>>
>>>> On 01/26/2015 11:50 PM, Rob Herring wrote:
>>>>> Add mrvl,pxa-uart and mrvl,mmp-uart compatible strings for the of_serial
>>>>> driver. These are 8250 variants which have a port type of PORT_XSCALE.
>>>>>
>>>>> There is also the serial driver pxa.c with these compatible strings
>>>>> already. However, it can be replaced with the common 8250 driver. It has
>>>>> some issues like it cannot coexist with the 8250 driver due to tty name
>>>>> collision. That also means adding these compatible strings here should
>>>>> not case a problem.
>>>>
>>>> So what determines which driver is controlling the port if both
>>>> drivers are built-in?
>>>
>>> If both are built-in, whoever registers ttyS ports first wins. This
>>> will be the 8250 driver due to link order.
>>
>> Ok, but then I think the commit log should reflect that this patch
>> effectively replaces pxa2xx-uart driver with the 8250 driver for PXA/MMP uarts
>> if both drivers are built-in or both drivers are modules.
> 
> It doesn't always. It is only on DT enabled platforms. But I can be
> more explicit about that.
> 
> There is another patch to remove the PXA driver entirely which I'm
> inquiring about why it was never merged [1]. This is why I went down
> the path of getting the 8250 driver to work rather than trying to fix
> the PXA driver.

Ah. I had seen your inquiry but didn't grasp the significance.
Greg acked that patch over 8 mos ago; it's still stuck somewhere?

OTOH, I didn't realize that patch removed the PXA driver. That driver has
errata workarounds which didn't get integrated into the 8250 core; it seems
a shame to toss that away.

[ Sidebar: I did a trial split of 8250_core into a separate 8250 base module
  and an 8250 universal driver. I keep having to rework the split but it's
  pretty close now; the 8250 base module might be just the thing for simplifying
  the pxa driver and getting console/earlycon/dma for free.

  Let me see what I can do about getting that done.
]

>>> So I guess PXA systems have avoided this by never building in 8250 driver.
>>
>> Platform devices are initialized first, so before this patch the pxa2xx-uart
>> driver would have claimed the platform ports before the 8250 driver, if
>> both were built-in (or both modules).
> 
> That's not exactly what I observed. The console is killed when the
> real driver initializes. I have no other debug output capability after
> that, so I'm not completely sure what was happening. Part of the
> problem is you need to move uart_register_driver to probe from the
> initcall as this is what other serial drivers sharing ttyS have done.

Ah, yep. I missed that subtlety.

> Using 8250 earlycon with the PXA driver seems to cause problems, so
> I'd have to duplicate the earlycon support in the PXA driver.
> 
>> Maybe Kconfig should warn if they're both built-in or both modules?
> 
> Is there a way to do that?

I think so; conf warns if one setting overrides another, so I think there's
probably a way to make that happen in the Kconfig. I'll mess with that later
tonight or tomorrow, and get back to you.

Regards,
Peter Hurley
