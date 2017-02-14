From: Christopher Covington <cov@codeaurora.org>
Subject: Re: [PATCH 1/2] tty: pl011: Work around QDF2400 E44 stuck BUSY bit
Date: Tue, 14 Feb 2017 18:43:06 -0500
Message-ID: <5b771f8f-5a39-4c57-34a1-8e3f6d729a11@codeaurora.org>
References: <20170208005736.18724-1-cov@codeaurora.org>
 <bd4a0127-0f32-a8be-c8ee-34c1cccc6d5d@codeaurora.org>
 <6afb0a98-0973-33ec-0b76-fc6378e64309@codeaurora.org>
 <5e18324f-d09d-d652-df23-d4a3f8f053fd@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <5e18324f-d09d-d652-df23-d4a3f8f053fd@codeaurora.org>
Sender: linux-doc-owner@vger.kernel.org
To: Timur Tabi <timur@codeaurora.org>, Jonathan Corbet <corbet@lwn.net>, Marc Zyngier <marc.zyngier@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org, shankerd@codeaurora.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Russell King <linux@armlinux.org.uk>, linux-serial@vger.kernel.org
Cc: Mark Langsdorf <mlangsdo@redhat.com>, Mark Salter <msalter@redhat.com>, Jon Masters <jcm@redhat.com>, Neil Leeder <nleeder@codeaurora.org>
List-Id: linux-serial@vger.kernel.org

On 02/08/2017 06:04 PM, Timur Tabi wrote:
> On 02/08/2017 04:22 PM, Christopher Covington wrote:
>>>> >> -    while (pl011_read(uap, REG_FR) & uap->vendor->fr_busy)
>>>> >> +    while ((pl011_read(uap, REG_FR) ^ uap->vendor->inv_fr)
>>>> >> +                        & uap->vendor->fr_busy)
>>> >
>>> > I really think the XOR logic needs to be documented wherever it's
>>> > used. It's just too confusing.
>> References such as the following for basic bit operations like
>> setting, clearing, and toggling are easy enough to come by.
>>
>> http://stackoverflow.com/questions/47981/how-do-you-set-clear-and-toggle-a-single-bit-in-c-c
> 
> I know what XOR does. I was thinking a more high-level comment would
> be appropriate. With E44, we want to ignore the BUSY bit and use TXFE
> instead. So was hoping to a comment that says that:
> 
> /* Normally, we poll until BUSY=0, but E44 says we should poll until
> TXFE=1 instead. So with E44, we set fr_busy to TXFE, but we have to
> invert it. */

Oh, yeah, that'd be good. I'll include better comments in v2.

Cheers,
Cov

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc. Qualcomm Technologies, Inc. is a member of the Code
Aurora Forum, a Linux Foundation Collaborative Project.
