From: Aleksey Makarov <amakarov.linux@gmail.com>
Subject: Re: [PATCH v3] Revert "tty: serial: pl011: add ttyAMA for matching
 pl011 console"
Date: Thu, 16 Mar 2017 12:31:53 +0300
Message-ID: <008d062d-1095-5a65-3a69-33bee1f648d7@gmail.com>
References: <20170301122602.30025-1-aleksey.makarov@linaro.org>
 <20170301152304.29635-1-aleksey.makarov@linaro.org>
 <d1e067f1-e82f-7692-bcc2-e3549887be63@arm.com>
 <CA+7sy7C6zp3giR+ypFXqbsNY_C3ggUgegS1zEWOAybkRBtCn4w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CA+7sy7C6zp3giR+ypFXqbsNY_C3ggUgegS1zEWOAybkRBtCn4w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Jayachandran C." <c.jayachandran@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Aleksey Makarov <aleksey.makarov@linaro.org>, linux-serial@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>, Jiri Slaby <jslaby@suse.com>, Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org, Sudeep Holla <sudeep.holla@arm.com>
List-Id: linux-serial@vger.kernel.org



On 03/16/2017 10:11 AM, Jayachandran C. wrote:
> Hi Greg,
> 
> On Tue, Mar 14, 2017 at 9:44 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:
>>
>>
>> On 01/03/17 15:23, Aleksey Makarov wrote:
>>> The original patch makes the condition always true, so it is wrong.
>>>
>>> It masks (but not fixes) the bug described in the commit message
>>> but introduces a regression (no console is selected by SPCR)
>>> in regular (no 'console=ttyAMA') case.
>>>
>>> s/||/&&/ would not fix the problem as the root cause was identified
>>> incorrectly.
>>>
>>> This reverts commit aea9a80ba98a0c9b4de88850260e9fbdcc98360b.
>>>
>>
>> Sorry for that, I will test your patches and respond to that. For this
>> patch:
>>
>> Acked-by: Sudeep Holla <sudeep.holla@arm.com>
>>
> 
> This fixes a regression I see in v4.11-rc2
> 
> Tested-by: Jayachandran C <jnair@caviumnetworks.com>
> 
> I don't see it in the tty/serial tree yet

It's commit 713b93f1b849 from tty-next branch of 
https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git

So it looks like it is scheduled for 4.12

Greg, this is a fix for regression.  Can it be applied to 4.11-rcX?

Thank you
Aleksey Makarov

> 
> JC.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-serial" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
