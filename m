From: Marek Vasut <marex@denx.de>
Subject: Re: [PATCH] Revert "serial: 8250: Fix clearing FIFOs in RS485 mode
 again"
Date: Sun, 16 Dec 2018 22:45:23 +0100
Message-ID: <949fdd3d-535e-d235-f406-d5bde4658c5e@denx.de>
References: <20181213174834.kxdy6fphaeoivqgh@pburton-laptop>
 <20181216200833.27928-1-paul.burton@mips.com>
 <f5a76d73-862f-3ebc-cd07-effc5c432103@denx.de>
 <20181216213133.kwe24pif3v4wcgwp@pburton-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181216213133.kwe24pif3v4wcgwp@pburton-laptop>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Burton <paul.burton@mips.com>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Paul Burton <pburton@wavecomp.com>, Daniel Jedrychowski <avistel@gmail.com>, "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>, stable <stable@vger.kernel.org>, Ezequiel Garcia <ezequiel@collabora.com>
List-Id: linux-serial@vger.kernel.org

On 12/16/2018 10:31 PM, Paul Burton wrote:
> Hi Marek,

Hi,

> On Sun, Dec 16, 2018 at 09:32:19PM +0100, Marek Vasut wrote:
>> I am unable to test it on such a short notice as I'm currently ill, so I
>> cannot tell if your change breaks the OMAP3/AM335x boards or not. Given
>> that there are very few CI20 boards in use, I'd like to ask you for some
>> extra time to investigate this on the OMAP3 too.
> 
> I'm sorry to hear that you're ill, but your patch is getting awfully
> close to becoming part of a stable kernel release & it causes
> regressions. Even if it didn't break a board I use, I think the patch
> would be broken & risky for the reasons I outlined in my revert's commit
> message.

That's what the incremental releases are for, so that minor problems can
get fixed there. Sure, it's great to have things perfect in the first
release, but if that breaks other systems, too bad.

> Ultimately it's Greg's decision but it sounds like you're asking me to
> say it's OK to break the JZ4780 in a stable kernel with a patch that I
> think would be risky anyway, and I won't do that.

I am saying this revert breaks AM335x, so this is a stalemate. I had a
discussion with Ezequiel (on CC) and he seems to have a different
smaller patch coming for this problem.

[...]

-- 
Best regards,
Marek Vasut
