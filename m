From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH 2/3] tty/serial: of_serial: add support for PXA/MMP uarts
Date: Fri, 30 Jan 2015 15:24:08 -0500
Message-ID: <54CBE868.3080100@hurleysoftware.com>
References: <1422334209-23125-1-git-send-email-robh@kernel.org>
 <1422334209-23125-2-git-send-email-robh@kernel.org>
 <54C78823.7050504@hurleysoftware.com>
 <CAL_Jsq+8jDN+fYyed5RYd2e1K+H_R1NkjT38WXSpKfxTLgsDbQ@mail.gmail.com>
 <54C7AA2D.7080202@hurleysoftware.com>
 <CAL_Jsq+wxY0=S1ff-Fk0xDBxHdhBvNopLpjfCETVoo_mou658w@mail.gmail.com>
 <54C91E67.2070501@hurleysoftware.com>
 <CAL_Jsq+6jg7C0z=0ZS=yp32_6yWzfx_zr5dtu-n3mv0JWiGq2g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAL_Jsq+6jg7C0z=0ZS=yp32_6yWzfx_zr5dtu-n3mv0JWiGq2g@mail.gmail.com>
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

On 01/30/2015 02:51 PM, Rob Herring wrote:
> On Wed, Jan 28, 2015 at 11:37 AM, Peter Hurley <peter@hurleysoftware.com> wrote:
>> On 01/27/2015 11:44 AM, Rob Herring wrote:
>>> On Tue, Jan 27, 2015 at 9:09 AM, Peter Hurley <peter@hurleysoftware.com> wrote:
>>
>> [...]
>>
>>>> Maybe Kconfig should warn if they're both built-in or both modules?
>>>
>>> Is there a way to do that?
>>
>> Well, it's not what I had in mind originally, but the diff below
>> generates a broken dependencies warning without causing build problems:
>>         $ scripts/kconfig/mconf Kconfig
>>         warning: (SERIAL_PXA) selects TTYS_DRIVER_PXA which has unmet direct dependencies (TTY && HAS_IOMEM && !TTYS_DRIVER)
>>
>> (My original idea was thwarted by the requirement that choice/endchoice
>> requires prompts).
> 
> Okay, but this should be a separate patch. The problem exists with or
> without my patch.

Yeah, don't worry about this. The solution of how to deal with multiple
ttyS drivers needs to address this problem.

>> That said, for PXA, I think we agree splitting out a standalone 8250 platform
>> driver is the solution.
> 
> So after all the discussion, you are okay with the original patch?

With a more specific commit log, yes. At a minimum, noting under what
circumstances the 8250 driver replaces the pxa2xx-uart driver. (And maybe
noting that this doesn't break hardware that needs those workarounds in
pxa.c).

Regards,
Peter Hurley
