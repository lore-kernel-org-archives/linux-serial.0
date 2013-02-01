From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH 3/3] serial: tegra: Convert to devm_ioremap_resource()
Date: Fri, 01 Feb 2013 10:18:36 -0700
Message-ID: <510BF8EC.7090801@wwwdotorg.org>
References: <1359627939-2685-1-git-send-email-sachin.kamat@linaro.org> <1359627939-2685-3-git-send-email-sachin.kamat@linaro.org> <510AA318.5060208@wwwdotorg.org> <CAK9yfHzSq8SpKXQYtFd1Ds+N-AoH+H+BdWrPsPT=OwSPdst1WA@mail.gmail.com> <510B436A.20808@wwwdotorg.org> <CAK9yfHzJvOC_wvsxvapi7rATq97QX-6exOyqjNTSguhh3RLVvQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:59064 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753471Ab3BARSk (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 1 Feb 2013 12:18:40 -0500
In-Reply-To: <CAK9yfHzJvOC_wvsxvapi7rATq97QX-6exOyqjNTSguhh3RLVvQ@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: linux-kernel@vger.kernel.org, thierry.reding@avionic-design.de, gregkh@linuxfoundation.org, Laxman Dewangan <ldewangan@nvidia.com>, linux-serial@vger.kernel.org

On 02/01/2013 02:49 AM, Sachin Kamat wrote:
> On 1 February 2013 09:54, Stephen Warren <swarren@wwwdotorg.org> wrote:
>>>
>>> The entire series is merged in Greg's driver-core tree [1] and I
>>> presume all other associated patches would also be picked up by him.
>>> Isn't it Greg?
>>>
>>> [1] git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git
>>
>> The Tegra serial driver went through Greg's TTY tree. I assume that goes
>> direct to Linus not through driver-core.git first.
> 
> Right. But AFAIK for this specific change he has carried the patches
> in the device-core tree irrespective of the subsystem.

Yes, but the Tegra serial driver is new for 3.9, and hence does not yet
exist in driver-core.git.
