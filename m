From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: Re: [PATCH 3/3] serial: tegra: Convert to devm_ioremap_resource()
Date: Fri, 1 Feb 2013 09:50:45 +0530
Message-ID: <CAK9yfHzSq8SpKXQYtFd1Ds+N-AoH+H+BdWrPsPT=OwSPdst1WA@mail.gmail.com>
References: <1359627939-2685-1-git-send-email-sachin.kamat@linaro.org>
	<1359627939-2685-3-git-send-email-sachin.kamat@linaro.org>
	<510AA318.5060208@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-oa0-f51.google.com ([209.85.219.51]:47564 "EHLO
	mail-oa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751582Ab3BAEUp (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 31 Jan 2013 23:20:45 -0500
Received: by mail-oa0-f51.google.com with SMTP id h2so1700132oag.10
        for <linux-serial@vger.kernel.org>; Thu, 31 Jan 2013 20:20:45 -0800 (PST)
In-Reply-To: <510AA318.5060208@wwwdotorg.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: linux-kernel@vger.kernel.org, thierry.reding@avionic-design.de, gregkh@linuxfoundation.org, Laxman Dewangan <ldewangan@nvidia.com>, linux-serial@vger.kernel.org

On 31 January 2013 22:30, Stephen Warren <swarren@wwwdotorg.org> wrote:
> On 01/31/2013 03:25 AM, Sachin Kamat wrote:
>> Use the newly introduced devm_ioremap_resource() instead of
>> devm_request_and_ioremap() which provides more consistent error handling.
>
> Presumably though that function isn't yet available in the tree that
> this new serial driver was merged through is it?

The entire series is merged in Greg's driver-core tree [1] and I
presume all other associated patches would also be picked up by him.
Isn't it Greg?

[1] git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git

-- 
With warm regards,
Sachin
