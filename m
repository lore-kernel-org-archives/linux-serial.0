From: Marek Vasut <marex@denx.de>
Subject: Re: [PATCH] Revert "serial: 8250: Fix clearing FIFOs in RS485 mode
 again"
Date: Mon, 17 Dec 2018 16:43:06 +0100
Message-ID: <52a4b322-5710-1ac0-fa3e-11ed6ef2236d@denx.de>
References: <20181213174834.kxdy6fphaeoivqgh@pburton-laptop>
 <20181216200833.27928-1-paul.burton@mips.com>
 <f5a76d73-862f-3ebc-cd07-effc5c432103@denx.de>
 <20181216213133.kwe24pif3v4wcgwp@pburton-laptop>
 <949fdd3d-535e-d235-f406-d5bde4658c5e@denx.de>
 <CAAEAJfAad75bHX39ETCdVv9vP0dF7PLz2vvFLLqgtyikPHqJyA@mail.gmail.com>
 <20181216222411.5jkexuaqxpfudj7b@pburton-laptop>
 <CAAEAJfAQ9=B6sm=Ard+YTDN5g5r03o=t9xU3Nu2QaKrXXZ4pGw@mail.gmail.com>
 <20181216223510.hxsdotf332ousinh@pburton-laptop>
 <20181217151851.GA21564@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20181217151851.GA21564@kroah.com>
Content-Language: en-US
Sender: stable-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Paul Burton <paul.burton@mips.com>
Cc: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Paul Burton <pburton@wavecomp.com>, Daniel Jedrychowski <avistel@gmail.com>, "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>, stable <stable@vger.kernel.org>, Ezequiel Garcia <ezequiel@collabora.com>
List-Id: linux-serial@vger.kernel.org

On 12/17/2018 04:18 PM, Greg Kroah-Hartman wrote:
> On Sun, Dec 16, 2018 at 10:35:12PM +0000, Paul Burton wrote:
>> Hi Ezequiel,
>>
>> On Sun, Dec 16, 2018 at 07:28:22PM -0300, Ezequiel Garcia wrote:
>>> On Sun, 16 Dec 2018 at 19:24, Paul Burton <paul.burton@mips.com> wrote:
>>>> This helps, but it only addresses one part of one of the 4 reasons I
>>>> listed as motivation for my revert. For example serial8250_do_shutdown()
>>>> also clearly intends to disable the FIFOs.
>>>>
>>>
>>> OK. So, let's fix that :-)
>>
>> I already did, or at least tried to, on Thursday [1].
>>
>>> By all means, it would be really nice to push forward and fix the garbage
>>> issue on JZ4780, as well as the transmission issue on AM335x.
>>>
>>> AM335x is a wildly popular platform, and it's not funny to break it.
>>
>> Well, clearly not if it was broken in v4.10 & only just fixed..? And
>> from Marek's commit message the patch in v4.10 doesn't break the whole
>> system just RS485.
>>
>>> So, let's please stop discussing which board we'll break and just fix both.
>>
>> I completely agree that would be ideal and I wrote a patch hoping to do
>> that on Thursday, but didn't get any response on testing. It's late in
>> the cycle hence a revert made sense. Simple as that.
> 
> A revert makes sense now, I'll go queue this up, thanks.

I don't like this for multiple reasons.
1) There is a better patch posted which doesn't break the AM335x and
   clearly identifies and fixes the problem on the JZ4780 / CI20
2) The JZ4780 8250 core is not a standard 8250 core, since it has extra
   bits in the FCR register (like the UME bit, which disables the whole
   UART block), so the revert IMO would break that core too, it just
   hides the breakage. I'm still trying to understand the implications
   of that in detail, but the discussion wasn't quite constructive.

I'd much rather see Ezequiel's patch applied, since that's far less
destructive approach to fixing the problem than the revert.

-- 
Best regards,
Marek Vasut
