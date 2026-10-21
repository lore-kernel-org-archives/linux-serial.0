Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792606038;
	b=LgODynLBUR+a7gHg7SWbyZSTglbArXSIoWQmshEfh0HRjJ6UTDRvqs/+0U1P3AWwlwFm
	 8VyNDgAehUMG0ssG7izcHn5gmgjjPQjOfJdOoAKyXs0ZPwgMS636IyFi9Np6e+I9JYr2K
	 eEUWOZu7dHu+rKl/7Z7dUQbvZWS0R9zwyA8R27FgyJaWizQiH9/+gyjMCgZnC1u4DHQ9q
	 f9gWpmg9w6KCGilTMOEzRPKvF7rr6YZURFIwoX1DTkXWg9EB0ELuL1qhOoDyo0OlRApj5
	 O8Hl9vPf6BQfOSSn05sGBvkPUPz9p8OxJZ2s4S/GAQE0lNXmhxYK0MeJ1yTrfWm2gNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792606038;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=15kvgDQ7PMMf6Jfi4drYcstlTrHaHywyRCw4UvsdTmg=;
	b=nZrb7glrEIJ08UKd3JYNC5S8xw3e1r2n1ffc/YtyMNAmLwfOvre5LeRNOLeqnnluqy42
	 P7xuz8K/nVq8CTMlLHtUVJc3/NuzIpQb5Z2xUQ7PlHQBw/WYjc0vYrookFCFwwOYUXwZf
	 JMugsZieRWUNM47KaXpVI8eKA+mKuY/QGsfAPoGZIHi7+b6O5XemY9oe2fimoOhMU/j15
	 ATu58IM9JJ9m9+lVLNPeHj5CRx1mKxNleAKAdR1f5lPUZMiSDO6ZGjSh0fcdudD7q63v5
	 N7M5lxbUT2zV+rdQy8I3PuNIL/FKGHaFzw4bc8OoqBgmzMLnzV0Qy48N+/xhSsUzxXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FhtJCKJA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7173606A31D;
	Wed, 21 Oct 2026 18:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FhtJCKJA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55E3A1F000C1;
	Wed, 21 Oct 2026 18:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792606037;
	bh=15kvgDQ7PMMf6Jfi4drYcstlTrHaHywyRCw4UvsdTmg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=FhtJCKJAA8aBXh3veNhWmwXjeKINGJOtvpNmmoS0cftkVaD2dceXyVwdNqjn/aXPA
	 XyWsVKbMcfaUf4NTGWkrBGMg4h0wllDxZL764dTbejVAGJt517JFW6oi8C0Yc/GLXy
	 5I9w9w6imsQWRR1Tr+LWZ4S8pdBmRsU1b7/eRiooRY/jF/iEO0CoeRlqGKpdW18rij
	 RBR6bIIDwGJznKjQVHIVmllDZ/AOeZts59jEtrDRIxgmWeVtgvkY5uKZ19x+80oA3R
	 0yzaAnJPdmsMNxngDvQ7vHj2SadFJH8O/BeRqqWZ7VlcrLhL4ggSTZBto2KLKrAvnA
	 gv36fC8FxdlCA==
Message-ID: <97dd05c2-0a6f-4856-a473-59183a5b3424@kernel.org>
Date: Wed, 21 Oct 2026 20:07:13 +0200
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] serdev: handle devices without an ACPI or device
 tree node
To: Markus Probst <markus.probst@posteo.de>, ChunAn Wu <an.wu@canonical.com>,
 linux-serial@vger.kernel.org, platform-driver-x86@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
 jirislaby@kernel.org, ilpo.jarvinen@linux.intel.com,
 mpearson-lenovo@squebb.ca, derekjohn.clark@gmail.com
References: <20261021092124.2306053-1-an.wu@canonical.com>
 <250bded6-2a51-457d-9bf2-24c299dbd7a9@kernel.org>
 <59137675cf11f7b034220c3b71c5ababab48f8d0.camel@posteo.de>
From: Hans de Goede <hansg@kernel.org>
Content-Language: en-US, nl
In-Reply-To: <59137675cf11f7b034220c3b71c5ababab48f8d0.camel@posteo.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 21-Oct-26 17:08, Markus Probst wrote:
> On Wed, 2026-10-21 at 16:32 +0200, Hans de Goede wrote:
>> Hi,
>>
>> On 21-Oct-26 11:21, ChunAn Wu wrote:
>>> Driver-created serdev clients may lack an ACPI companion or device tree
>>> node.
>>>
>>> Add a creator-supplied name for these clients. Use it as a serial
>>> modalias fallback and to match a serdev driver of the same name. Keep
>>> returning -ENODEV for unnamed clients.
>>>
>>> Signed-off-by: ChunAn Wu <an.wu@canonical.com>
>>
>> For v3 of this series please include a cover-letter and explain
>> why this series is an improvement over the` existing situation.
>>
>> The dell-uart-backlight and lenovo-yoga-tab2-pro-1380-fastcharger
>> drivers are both pretty special cases and here you are adding
>> a chunk of code to the serdev-core for those special cases,
>> so I wonder: why?
>>
>> The current manual attach approach taking in these 2 special
>> drivers works fine.
>>
>> What does this new approach gain us ?
> 
> That was my review comment [1] that resulted in this.

Thanks, that is useful info and the kinda info I would
expect in a cover-letter :)
> From what I can tell from revision 1, ChunAn Wu is trying to fix that
> accessing uevent and modalias of the device (via sysfs) results in a -
> ENODEV error.

I see. Makes me wonder though how that -ENODEV is a problem,
it is weird. But is it a problem?

The v1 patch writes the following about this:

"This makes the modalias sysfs read fail and suppresses the device
add uevent, even though the device is registered and bound to its driver."

Ok, but the backlight driver ultimately ends up adding a
/sys/class/backlight device which I assume does get
a uevent, or is the problem that one never getting a uevent
because of its parent not getting one ?

And the lenovo-yoga-tab2-pro-1380-fastcharger driver does all
it needs to do fully in kernel and does not even export
a userspace interface.

> As mentioned in my review:
> 
> - "/* TODO: platform modalias */"
> - "/* TODO: platform matching */"
> still exist in the serdev codebase (drivers/tty/serdev/core.c) and are
> unresolved. Resolving those also fixes the issue mentioned above.
> Therefore I think this would be a better approach.

With that said given that there are TODO comments for this
I guess addressing the TODO-s is ok.
> A cover letter is ofc still needed.

Ack.

>> Also if you are going to do this may I suggest looking at doing
>> some sort of of-compatible matching based on a compatible string
>> inside a swnode ? I do not know what that would look like but
>> that is something which seems like it might be generally useful
>> also outside these 2 special cases.
> 
> I haven't used them before, but I don't think of-compatible string
> matching inside a swnode is done anywhere in the kernel (At least I
> haven't found a case).
> 
> They can be added supplementary if needed.

The idea was to make this a generic match mechanism / helper
function busses can call, like the current of and acpi
match (and modalias) helpers. And then have matching by
a compatible string instead of by name since matching by name
only works if there is only 1 instance.

Anyways this is just an idea and somewhat out of scope for
this patch-set.

Regards,

Hans


