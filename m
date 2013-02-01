From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH 3/3] serial: tegra: Convert to devm_ioremap_resource()
Date: Thu, 31 Jan 2013 21:24:10 -0700
Message-ID: <510B436A.20808@wwwdotorg.org>
References: <1359627939-2685-1-git-send-email-sachin.kamat@linaro.org> <1359627939-2685-3-git-send-email-sachin.kamat@linaro.org> <510AA318.5060208@wwwdotorg.org> <CAK9yfHzSq8SpKXQYtFd1Ds+N-AoH+H+BdWrPsPT=OwSPdst1WA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:55562 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751582Ab3BAEYM (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 31 Jan 2013 23:24:12 -0500
In-Reply-To: <CAK9yfHzSq8SpKXQYtFd1Ds+N-AoH+H+BdWrPsPT=OwSPdst1WA@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: linux-kernel@vger.kernel.org, thierry.reding@avionic-design.de, gregkh@linuxfoundation.org, Laxman Dewangan <ldewangan@nvidia.com>, linux-serial@vger.kernel.org

On 01/31/2013 09:20 PM, Sachin Kamat wrote:
> On 31 January 2013 22:30, Stephen Warren <swarren@wwwdotorg.org> wrote:
>> On 01/31/2013 03:25 AM, Sachin Kamat wrote:
>>> Use the newly introduced devm_ioremap_resource() instead of
>>> devm_request_and_ioremap() which provides more consistent error handling.
>>
>> Presumably though that function isn't yet available in the tree that
>> this new serial driver was merged through is it?
> 
> The entire series is merged in Greg's driver-core tree [1] and I
> presume all other associated patches would also be picked up by him.
> Isn't it Greg?
> 
> [1] git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git

The Tegra serial driver went through Greg's TTY tree. I assume that goes
direct to Linus not through driver-core.git first.

https://git.kernel.org/?p=linux/kernel/git/gregkh/tty.git;a=shortlog;h=refs/heads/tty-next
