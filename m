Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C334815886C
	for <linux-serial@vger.kernel.org>; Mon, 16 Sep 2024 14:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726495431; cv=none; b=avPnbmRXX8QA0QrZXXvj3APDykeoBpMd+k5tgCuJkRnWgQDQUPvAnT9Qo21JM+aOjz8PA3jkg18M9tVofwAAXtB93eDGzR3GcUWwTq8MuctWzYsF0x3SyHFTTUtB6F0M90bVG3KYdF3Z4MXmAVo6FeUO2KWzbab6o16jIg+RuRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726495431; c=relaxed/simple;
	bh=6FQ+akix6fp4+5qKrgUyCLmB2eaE2NK4LAOw7l3wQc8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=R5feqr9HgQT5Nk0EsFXb2/9lpTVMeCpVNXOxgJopvyVYwslDRDbuL4NnsSwbieTu9c0T+ZiylWmX0sLKu8hNyRLabn4pRqL/+Yit8/CkWxrHIPNShtky55pdmNSZmufiEDAhYQ38vdO5hU3bJc5edWJmi3UGHdRTTxsMQCeLPFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=niqjEtxb; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="niqjEtxb"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 54D03E0005;
	Mon, 16 Sep 2024 14:03:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1726495427;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+Mxh67e9dF/mltcOGspqSv4G+nz32DUK7Yfe1Wi6Xzk=;
	b=niqjEtxbe1NFK08sVtSfvVkzjktOBGb6//7+r9vPEjUWG6Xkxd8k8AfVyAB7h81wJqMcTf
	/YYe9MfBVgSI4mwUmrdCZ2g72wlrdwQa0V9V4xfo5SQX0P+UawFdU+hZzLx92fbLVtm6gn
	UkSLmzK27gunO2RxJcA1CbCr/QofxqdSIcXRNCOU0naser4QujTwwOXt3iHzKhvGtQ+Y5v
	TK6fgN9XHNmwN9MIOzLLlLvYutjMVkxDFNueb3ghsTbVYtXJVfAurrADTuRIp1/rl02TeF
	c3/gyjX30o9HbwUDxP2/SQ3La48kk5wXgIZO9+DvNgRQuru+zdKH7f1YGk7Saw==
Message-ID: <3fbe606e-fb0e-4ff8-924b-a8bbe046ee4b@bootlin.com>
Date: Mon, 16 Sep 2024 16:03:46 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] serial: 8250_omap: Set the console genpd always on if no
 console suspend
From: Thomas Richard <thomas.richard@bootlin.com>
To: Kevin Hilman <khilman@kernel.org>, Greg KH <gregkh@linuxfoundation.org>
Cc: jirislaby@kernel.org, tony@atomide.com, linux-serial@vger.kernel.org,
 gregory.clement@bootlin.com, u-kumar1@ti.com, d-gole@ti.com,
 thomas.petazzoni@bootlin.com
References: <20231017130540.1149721-1-thomas.richard@bootlin.com>
 <7hzfplplfs.fsf@baylibre.com> <2024081318-litigator-slinky-8f0b@gregkh>
 <7ha5hgpchq.fsf@baylibre.com>
 <b8faffb0-7ae6-4f20-a8fb-34222535b623@bootlin.com>
Content-Language: en-US
In-Reply-To: <b8faffb0-7ae6-4f20-a8fb-34222535b623@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: thomas.richard@bootlin.com

On 8/20/24 11:15, Thomas Richard wrote:
> On 8/13/24 19:18, Kevin Hilman wrote:
>> Greg KH <gregkh@linuxfoundation.org> writes:
>>
>>> On Fri, Aug 09, 2024 at 12:04:23PM -0700, Kevin Hilman wrote:
>>>> Thomas Richard <thomas.richard@bootlin.com> writes:
>>>>
>>>>> If the console suspend is disabled, the genpd of the console shall not
>>>>> be powered-off during suspend.
>>>>> Set the flag GENPD_FLAG_ALWAYS_ON to the corresponding genpd during
>>>>> suspend, and restore the original value during the resume.
>>>>>
>>>>> Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
>>>>
>>>> Hmm, this patch got merged upstream (commit 68e6939ea9ec) even after
>>>> disagreements about the approach.
>>>>
>>>> Even worse, it actually causes a crash during suspend on platforms that
>>>> don't use PM domains (like AM335x Beaglebone Black.)
>>>>
>>>> Details on why this crashes below.
>>>>
>>>> Thomas, could you please submit a revert for this (with a Fixes: tag)
>>>> and then follow up with the approach as discussed later in this thread?
>>>
>>> Did this revert happen yet?
>>
>> No.
>>
>> Could you revert it since it's caused regressions?  I will follow up
>> with Thomas on the right fix for the original issue (as discussed later
>> in this thread.)
> 
> Hello Kevin,
> 
> The series, which implements Théo's proposal, was ready to be sent when
> I tried to go back to suspend after a resume. This causes a kernel panic
> during the suspend.
> 
> There is the issue in both cases (console suspend and no console suspend).
> 
> The issue comes from the other uarts (not the one used by the console).
> If I disable all other uarts, there is no panic.
> 
> It seems the uarts are not resumed correctly.
> 
> More investigation is needed.

Hello Kevin,

I finally found the culprit.
Just adding the GENPD_FLAG_ACTIVE_WAKEUP flag by default caused the
panic, even without the call of device_set_wakeup_path().

With some debug, I found that the wakeup_path of all my uarts (even
other uarts not used by the console) was set.
So the corresponding power domains were not powered off [1].
Consequently they are not powered on during the resume [2].

But on my platform (J7200), the SoC is fully off during suspend-to-ram.
Even if a power domain is not powered off by Linux, at the end all the
SoC is off.
And if Linux doesn't power off a power domain, it doesn't power on it.

The wakeup_path of all my uarts is set here [3] because devices are
wakeup capable [4].
It was added by commit 8512220c5782d [5].
If I remove the wakeup_path modification (diff at the end of the email),
Théo's proposal works well. But it's probably too rough, and I have no
idea about the impact on other platforms.

If you have an idea to fix correctly this wakeup_path issue, please let
me know :)

[1]
https://elixir.bootlin.com/linux/v6.11/source/drivers/pmdomain/core.c#L1372
[2]
https://elixir.bootlin.com/linux/v6.11/source/drivers/pmdomain/core.c#L1427
[3]
https://elixir.bootlin.com/linux/v6.10.10/source/drivers/base/power/main.c#L1687
[4]
https://elixir.bootlin.com/linux/v6.11/source/drivers/tty/serial/8250/8250_omap.c#L1526
[5]
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=8512220c5782d

Best Regards,

Thomas

8< -------------------------------
diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index 4a67e83300e1..e3d9153a9a81 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -1683,9 +1683,6 @@ static int device_suspend(struct device *dev,
pm_message_t state, bool async)
  End:
        if (!error) {
                dev->power.is_suspended = true;
-               if (device_may_wakeup(dev))
-                       dev->power.wakeup_path = true;
-
                dpm_propagate_wakeup_to_parent(dev);
                dpm_clear_superiors_direct_complete(dev);
        }
@@ -1795,8 +1792,6 @@ static int device_prepare(struct device *dev,
pm_message_t state)

        device_lock(dev);

-       dev->power.wakeup_path = false;
-
        if (dev->power.no_pm_callbacks)
                goto unlock;
