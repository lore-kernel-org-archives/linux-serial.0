From: Anand Moon <linux.amoon@gmail.com>
Subject: Re: [PATCHv2] serial: samsung: drop the spinlock around uart_write_wakeup
Date: Mon, 22 Feb 2016 09:01:12 +0530
Message-ID: <CANAwSgR7hhf=Ww6n-tChKhj=drm9c7TbXXs5B2vF6MxUM=GC5w@mail.gmail.com>
References: <1455858937-2380-1-git-send-email-linux.amoon@gmail.com>
 <56C76D3D.3010009@hurleysoftware.com> <CAJKOXPfJDwcis0-FkAEKqz4ESAuEV0arDYr7hfa8vb_5_UVirg@mail.gmail.com>
 <CANAwSgSVHPVWBwaO6b4QvUEopCFSKXrFbHkY837+gG62wpc-Jg@mail.gmail.com> <56CA5174.3050706@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <56CA5174.3050706@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Peter Hurley <peter@hurleysoftware.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>, =?UTF-8?Q?Robert_Ba=C5=82dyga?= <r.baldyga@samsung.com>
List-Id: linux-serial@vger.kernel.org

Hi Krzysztof,

On 22 February 2016 at 05:38, Krzysztof Kozlowski
<k.kozlowski@samsung.com> wrote:
> On 21.02.2016 11:59, Anand Moon wrote:
>> Hi Krzysztof,
>>
>> On 21 February 2016 at 07:07, Krzysztof Kozlowski
>> <k.kozlowski@samsung.com> wrote:
>>> 2016-02-20 4:30 GMT+09:00 Peter Hurley <peter@hurleysoftware.com>:
>>>> [ +cc Krzysztof Kozlowski ]
>>>>
>>>> On 02/18/2016 09:15 PM, Anand Moon wrote:
>>>>> From: Anand Moon <linux.amoon@gmail.com>
>>>>>
>>>>> drop the spin_unlock/lock around uart_write_wakeup to protect
>>>>> write wakeup for uart port.
>>>>
>>>> What Krzysztof was saying wrt v1 of this patch is that the
>>>> changelog should provide as much information as possible to
>>>> the maintainer(s) and driver author(s), and that you should
>>>> test that outcome.
>>>>
>>>> Here's what I would have written for a commit message:
>>>>
>>>>
>>>>   Remove deadlock workaround for line disciplines that invoke
>>>>   the tty driver's write() method directly from their write_wakeup()
>>>>   method. As documented for the write_wakeup() line discipline method
>>>>   in tty_ldisc.h, line disciplines must not attempt i/o directly
>>>>   from write_wakeup() as this will deadlock. Reviews of in-tree line
>>>>   disciplines confirm all defer i/o.
>>>>
>>>>   NB: This workaround was added in commit c15c3747ee32
>>>>   ("serial: samsung: fix potential soft lockup during uart write")
>>>>   which notes both slip and bluetooth hci attempt i/o directly from
>>>>   write_wakeup(). These issues were fixed in commits 661f7fda21b1
>>>>   ("slip: Fix deadlock in write_wakeup") and da64c27d3c93
>>>>   ("bluetooth: hci_ldisc: fix deadlock condition"), respectively.
>>>
>>> Thanks Peter for thorough analysis. It shouldn't be done by you but by
>>> the patch submitter... and I have big worries that Anand did not
>>> perform that analysis.
>>>
>>> Anand, could you at least test that this lockup does not happen
>>> anymore? You will need board with Bluetooth for that (and not USB
>>> Bluetooth...). If you cannot test it, maybe guys from Polish R&D could
>>> help you (Cc-ed), because they were working on DMA for serial used in
>>> Bluetooth.
>>>
>>> Best regards,
>>> Krzysztof
>>
>> I have looked into the history of the changes,
>> commit c15c3747ee32 (serial: samsung: fix potential soft lockup during
>> uart write)
>> was added long time ago, that's why have missed this.
>>
>> I don't have on-board Bluetooth enable boards with me,
>> so if their is potential lockup you people observer
>> do not consider this patch.
>
> Which means that you cannot test it... Find someone who can test it with
> Bluetooth (or SLIP) and will provide you a Tested-by tag.
>
> Best regards,
> Krzysztof
>

It will be better if some body can verify the change.

Best Regards.
-Anand Moon
