From: jeffy <jeffy.chen@rock-chips.com>
Subject: Re: [RFC PATCH 1/5] serial: arc: Remove __init marking from early
 write
Date: Tue, 18 Jul 2017 14:06:05 +0800
Message-ID: <596DA54D.8060001@rock-chips.com>
References: <1500352203-21513-1-git-send-email-jeffy.chen@rock-chips.com> <1500352203-21513-2-git-send-email-jeffy.chen@rock-chips.com> <20170718050838.GA7529@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170718050838.GA7529@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, briannorris@chromium.org, dianders@chromium.org, peter@hurleysoftware.com, Jiri Slaby <jslaby@suse.com>, Vineet Gupta <vgupta@synopsys.com>, linux-serial@vger.kernel.org, linux-snps-arc@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

Hi Greg,

On 07/18/2017 01:08 PM, Greg KH wrote:
> On Tue, Jul 18, 2017 at 12:29:59PM +0800, Jeffy Chen wrote:
>> The earlycon would be alive outside the init code in these cases:
>> 1/ we have keep_bootcon in cmdline.
>> 2/ we don't have a real console to switch to.
>>
>> So remove the __init marking to avoid invalid memory access.
>>
>> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
>> ---
>>
>
> I can't apply "RFC" patches.  If you have tested and found this series
> to be correct, can you resend it without that on the patch?
oh, sorry, i'll resend it :)

but i'm still not sure how to fix other hang cases(mentioned in the 
cover-letter, earlycon's required clks/pm domain been disabled by ignore 
unused initcalls or serial console driver's runtime suspend).
>
> thanks,
>
> greg k-h
>
>
>
