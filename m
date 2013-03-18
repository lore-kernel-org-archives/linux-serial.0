From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: Re: [PATCH 3/3] serial: tegra: Convert to devm_ioremap_resource()
Date: Mon, 18 Mar 2013 11:27:52 +0530
Message-ID: <CAK9yfHxYyGC11ZC60xLL96hMOPtkXtmbfLXGvk23dMd6+itWvg@mail.gmail.com>
References: <1359627939-2685-1-git-send-email-sachin.kamat@linaro.org>
	<1359627939-2685-3-git-send-email-sachin.kamat@linaro.org>
	<510AA318.5060208@wwwdotorg.org>
	<CAK9yfHzSq8SpKXQYtFd1Ds+N-AoH+H+BdWrPsPT=OwSPdst1WA@mail.gmail.com>
	<510B436A.20808@wwwdotorg.org>
	<CAK9yfHzJvOC_wvsxvapi7rATq97QX-6exOyqjNTSguhh3RLVvQ@mail.gmail.com>
	<510BF8EC.7090801@wwwdotorg.org>
	<CAK9yfHx1jLPpdCHAb-pC-C7wt81gQLgTnpuvK+0aNKkhuXHcDQ@mail.gmail.com>
	<20130315163803.GA29113@kroah.com>
	<514356D9.2020708@wwwdotorg.org>
	<20130315173331.GA22504@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-oa0-f47.google.com ([209.85.219.47]:45320 "EHLO
	mail-oa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750888Ab3CRF5w (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 18 Mar 2013 01:57:52 -0400
Received: by mail-oa0-f47.google.com with SMTP id o17so5292038oag.34
        for <linux-serial@vger.kernel.org>; Sun, 17 Mar 2013 22:57:52 -0700 (PDT)
In-Reply-To: <20130315173331.GA22504@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Cc: Stephen Warren <swarren@wwwdotorg.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "thierry.reding@avionic-design.de" <thierry.reding@avionic-design.de>, Laxman Dewangan <ldewangan@nvidia.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>

>> There's no need for me to take the patch I think; now that 3.9-rc1 is
>> out, the serial and driver core trees all have whatever dependencies
>> this series needed, so any patches can go through their usual trees, I
>> think... (Sorry, the context of this discussion was little while ago).
>
> Ok, can someone please resend the serial patch then?  I dropped it.
>

You already applied the resent version of this patch.
Thanks Greg :)


-- 
With warm regards,
Sachin
