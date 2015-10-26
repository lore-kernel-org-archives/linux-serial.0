From: Andre Przywara <andre.przywara@arm.com>
Subject: Re: [PATCH v13 5/5] uart: pl011: Add support to ZTE ZX296702 uart
Date: Mon, 26 Oct 2015 15:19:26 +0000
Message-ID: <562E447E.6070703@arm.com>
References: <1438328959-16177-1-git-send-email-jun.nie@linaro.org>
 <1438328959-16177-6-git-send-email-jun.nie@linaro.org>
 <55FC16A2.5070207@arm.com>
 <CABymUCOA3oG7Hq83hDyQ_uisQHeipoHshcWONWTtjxKvikzjsQ@mail.gmail.com>
 <CAOZdJXUjZLKkUYScD7oDTMuRUtAEJ6=DopmE4n6Vb9zyv+_viA@mail.gmail.com>
 <CABymUCORU9CDD64Rdw2VX0kLSe6E1zY9iZCap5xittoVFwbOtw@mail.gmail.com>
 <562AFBD5.3050508@codeaurora.org> <562DF96D.6020307@arm.com>
 <562E20B2.4050805@codeaurora.org> <562E3213.8070602@arm.com>
 <562E33AE.2020608@codeaurora.org> <562E3BCF.7010000@arm.com>
 <562E3D02.2040108@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <562E3D02.2040108@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Timur Tabi <timur@codeaurora.org>, Jun Nie <jun.nie@linaro.org>
Cc: "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "peter@hurleysoftware.com" <peter@hurleysoftware.com>, "jason.liu@linaro.org" <jason.liu@linaro.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, Andrew Jackson <Andrew.Jackson@arm.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "shawn.guo@linaro.org" <shawn.guo@linaro.org>, "wan.zhijun@zte.com.cn" <wan.zhijun@zte.com.cn>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

Hi Timur,

On 26/10/15 14:47, Timur Tabi wrote:
> Andre Przywara wrote:
>> I meant that if some hardware does not work with an upstream kernel, I'd
>> expect some kind of failure report or a patch on the public mailing
>> list. I may have missed it, but I couldn't find anything on the list
>> so far.
> 
> We have an internal patch that I'm trying to upstream, but I need the
> amba-pl011 driver to stabilize first.

As mentioned earlier, this looks like the perfect opportunity now to get
the change in (since I see it as a subset of Jun's series). "Waiting for
stabilization" sounds a bit optimistic to me in a general Linux context ;-)

>> As mentioned earlier, I didn't want to change code without good reasons,
>> that's why I was waiting for people to scream.
>>
>> So I just take this as a scream, then;-)
>>
> 
>> Can you elaborate on that? Is your UART a PL011 one (using the arm,pl011
>> DT binding or AMBA ID registers) or are you using the SBSA subset only?
>> Is there some means to identify this particular UART?
> 
> We use ACPI bindings.  It's our ARM64 server-class SOC.  We use the ACPI
> subtype 13 to identify it.

Does "subtype 13" refer to the UUID field here? So instead of using UUID
0 you have some vendor specific field set in your ARMH0011 table? Is
that "just made up" or specified somewhere so that there will be no
other usage of that number later?

>>> >Yes, but I think it changes a lot of things unnecessarily, like the
>>> >register names.
>> Which is unfortunate, but cannot be changed anymore. And as much as I
>> dislike this myself, I guess we cannot ignore this hardware just because
>> it doesn't go easily with our driver code. So instead of having just
>> another driver which is strikingly similar, I'd rather have this in the
>> one-and-only PL011 driver which is much less subject to bit-rot.
> 
> I guess we'll have to agree to disagree.  I'd rather have the other
> driver subjected to bit rot.  I don't understand why Jun's obscure
> hardware is so great that it needs to complicate things for all the
> other ARM vendors.

I am not judging on greatness here, it's just that Jun went through the
proper upstream process, so we considered this change. In the end the
kernel is there to support hardware out there and not to match the
driver architecture pipe dreams of some computer scientists ;-)

But in fact we did not merge the series (at least not in a release
kernel), but send it back to the design stage. And it looks like we are
on a good track to not spoil the driver unnecessarily ...

>> So my idea here was to split Jun's series into introducing the
>> readl/writel wrappers first, and adding the register address mangling on
>> top of that. Given that those changed register addresses seem to be a
>> mishap to me, we could just get away with a ZTE specific translate
>> function, which takes a PL011 register number and returns the actual
>> register offset to use. That isn't very generic, but would hide this
>> ugliness without spoiling the whole driver.
> 
> I'll have to see the code to form an opinion.
> 
>> So both you and me could benefit from the wrapper functions already,
>> while Jun has some patches less to care about.
> 
> Then I suggest that we focus on the wrapper functions now, and then let
> Jun add support for his stuff later.

Yes, that was my idea.
Now with a specific use case for the wrapper functions, we can push this
change first.

Cheers,
Andre.
