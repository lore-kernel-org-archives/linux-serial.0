From: Timur Tabi <timur@codeaurora.org>
Subject: Re: [PATCH] tty: amba-pl011: Use 32-bit accesses for SBSA UART
Date: Wed, 30 Mar 2016 13:11:17 -0500
Message-ID: <56FC16C5.70402@codeaurora.org>
References: <1457415800-8799-1-git-send-email-cov@codeaurora.org>
 <1457678154-2272-1-git-send-email-cov@codeaurora.org>
 <56E7DF1F.7010006@arm.com> <56FBC6EA.6080909@codeaurora.org>
 <20160330165551.GB23817@kroah.com> <56FC0684.1050109@codeaurora.org>
 <20160330180159.GA24988@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160330180159.GA24988@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Christopher Covington <cov@codeaurora.org>, Andre Przywara <andre.przywara@arm.com>, Russell King <linux@arm.linux.org.uk>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Jon Masters <jcm@redhat.com>, Mark Langsdorf <mlangsdo@redhat.com>, Dave Martin <dave.martin@linaro.org>, Aleksey Makarov <aleksey.makarov@linaro.org>
List-Id: linux-serial@vger.kernel.org

Greg Kroah-Hartman wrote:
> On Wed, Mar 30, 2016 at 12:01:56PM -0500, Timur Tabi wrote:
>> Greg Kroah-Hartman wrote:
>>> If this isn't a bug fix or regression fix, it's not ok for 4.6-final, it
>>> will have to wait for 4.7-rc1.
>>
>> It fixes a problem on our platform (QDF2432).  Without this patch, we can't
>> use the PL011 at all.
>
> Did it ever work before?  Or is this new functionality?

No, it never worked before, so it's not a regression.  I guess it all 
depends on how you define "fix".  The driver loads and attempts to use 
the hardware, but it fails without this patch.  The system locks up 
completely (I guess it throws an unhandled exception or something).

I guess if you take a very limited definition of "fix", then this isn't 
a fix.  I can understand if you didn't want to take it for 4.6-rc7 or 
something, but for 4.6-rc2, I don't think it's inappropriate.

That's my two cents.  We'd like to see it in 4.6-rc2, but the decision 
is yours.

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora
Forum, a Linux Foundation collaborative project.
