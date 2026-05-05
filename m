Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 286703E6DF5;
	Tue,  5 May 2026 07:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777967182; cv=none; b=osbI+cLDSAe9sbDldE+eag7XxzNHbbIdznh0m92eAMFM3r51J29fh9ijc1prnYtdCrqOeutL3t7r0f9Dx5erUNEI+/hZnpBb+Zj1XqRkdaJTaX0qw5uESE1MOQz5Y8u95j+JPLgFG2vT4RmUcIfK2N5oCJ6urRaG3Q5TtQeP1OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777967182; c=relaxed/simple;
	bh=yM7ixh23hTt915v65jWVvesGDMzqA5Q4LFsS6XYpggE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dnyxnb/TunrBVcs6Dqx4UTf/ItVGrGnDCM1jx4C0hYCo9OlcngObnNbjzPp3bwNvTsqqTWv06bAJ1FhDWQ73hry2U86TiqZk/2Y7bXpoQ7FtohZK4O06p9YQ4TF9uAVnWQOq5VRSwSi36SkytR3f+0982q8X0COvhL39YPLY49A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gqokWP1/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gqokWP1/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 632F8C2BCFB;
	Tue,  5 May 2026 07:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777967181;
	bh=yM7ixh23hTt915v65jWVvesGDMzqA5Q4LFsS6XYpggE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gqokWP1/BwjPN/i5hfMbT48Qir87vQojYGx61A9eEv+76YwoGLY4b/+n6yg3V+xyr
	 wnpCSMVlAbokyFNwXJv1lOp0EHu0MKG576qLYNZnVsLWSSestKExplpWf2qM6hBjpE
	 i4PqSNH6i14WHpO3V+M2n/rOjTM8lyxAT7cAODwVGJ9Zc3kTa0Z60NtTYLii7oU7Gl
	 RII1tskB8jWPL+CU7dxHQo11zAGDXu5HUtV1maMQQWze37j8mgMTFEFBy4xJPPxqAY
	 YAvDNtEIr+ZzvdNQBL07MIkWM4GE1Q3FcmUsQjHIgUN3X269k/WveeRFxppsqOw3To
	 pyq08ENtFbN0g==
Message-ID: <b72aac86-7572-467e-9a9e-6611f3820413@kernel.org>
Date: Tue, 5 May 2026 09:46:17 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] serial: jsm: Use named initializers for struct
 pci_device_id
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig_=28The_Capable_Hub=29?=
 <u.kleine-koenig@baylibre.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Lukas Wunner <lukas@wunner.de>, Dave Jiang <dave.jiang@intel.com>,
 Giovanni Cabiddu <giovanni.cabiddu@intel.com>, Kees Cook <kees@kernel.org>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
 Markus Schneider-Pargmann <msp@baylibre.com>
References: <20260505073044.2258674-2-u.kleine-koenig@baylibre.com>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <20260505073044.2258674-2-u.kleine-koenig@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 05. 05. 26, 9:30, Uwe Kleine-König (The Capable Hub) wrote:
> Initializing structures using list initializers is harder to read than
> using named initializers. Seeing the member name is more ideomatic and
> easier to understand.
> 
> Use named initializers for the driver's pci_device_id array. While at it
> also drop an explicit zero in the terminating array entry.
> 
> There are no changes to the compiled result of the array; verified with
> builds for x86 and arm64.
> 
> Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
> ---
> Hello,
> 
> this is a preparing change for making struct pci_device_id::driver_data an
> anonymous union (similar to
> https://lore.kernel.org/all/cover.1776579304.git.u.kleine-koenig@baylibre.com/).
> This requires named initializers for .driver_data. But even without that
> this is a nice cleanup making the array better readable.
> 
> Having said that I didn't find where .driver_data is used, so unless I
> missed something the assignments can just go away???
> 
> For earlier patches of this type against other drivers I got the
> feedback to use PCI_DEVICE_DATA() but I don't like that as it mixes
> hardware properties (.vendor and .device) with driver specific software
> properties (.driver_data) and thus I prefer the explicit listing
> (involving more repetition) over the shorter variant (being more opaque
> and harder to read).
> 
> Best regards
> Uwe
> 
>   drivers/tty/serial/jsm/jsm_driver.c | 75 +++++++++++++++++++++--------
>   1 file changed, 56 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/tty/serial/jsm/jsm_driver.c b/drivers/tty/serial/jsm/jsm_driver.c
> index 4b73e51f83fb..422cac8d8d71 100644
> --- a/drivers/tty/serial/jsm/jsm_driver.c
> +++ b/drivers/tty/serial/jsm/jsm_driver.c
> @@ -296,25 +296,62 @@ static void jsm_remove_one(struct pci_dev *pdev)
>   }
>   
>   static const struct pci_device_id jsm_pci_tbl[] = {
> -	{ PCI_DEVICE(PCI_VENDOR_ID_DIGI, PCI_DEVICE_ID_NEO_2DB9), 0, 0, 0 },
> -	{ PCI_DEVICE(PCI_VENDOR_ID_DIGI, PCI_DEVICE_ID_NEO_2DB9PRI), 0, 0, 1 },
> -	{ PCI_DEVICE(PCI_VENDOR_ID_DIGI, PCI_DEVICE_ID_NEO_2RJ45), 0, 0, 2 },
> -	{ PCI_DEVICE(PCI_VENDOR_ID_DIGI, PCI_DEVICE_ID_NEO_2RJ45PRI), 0, 0, 3 },
> -	{ PCI_DEVICE(PCI_VENDOR_ID_DIGI, PCIE_DEVICE_ID_NEO_4_IBM), 0, 0, 4 },
> -	{ PCI_DEVICE(PCI_VENDOR_ID_DIGI, PCI_DEVICE_ID_DIGI_NEO_8), 0, 0, 5 },
> -	{ PCI_DEVICE(PCI_VENDOR_ID_DIGI, PCI_DEVICE_ID_NEO_4), 0, 0, 6 },
> -	{ PCI_DEVICE(PCI_VENDOR_ID_DIGI, PCI_DEVICE_ID_NEO_1_422), 0, 0, 7 },
> -	{ PCI_DEVICE(PCI_VENDOR_ID_DIGI, PCI_DEVICE_ID_NEO_1_422_485), 0, 0, 8 },
> -	{ PCI_DEVICE(PCI_VENDOR_ID_DIGI, PCI_DEVICE_ID_NEO_2_422_485), 0, 0, 9 },
> -	{ PCI_DEVICE(PCI_VENDOR_ID_DIGI, PCIE_DEVICE_ID_NEO_8), 0, 0, 10 },
> -	{ PCI_DEVICE(PCI_VENDOR_ID_DIGI, PCIE_DEVICE_ID_NEO_4), 0, 0, 11 },
> -	{ PCI_DEVICE(PCI_VENDOR_ID_DIGI, PCIE_DEVICE_ID_NEO_4RJ45), 0, 0, 12 },
> -	{ PCI_DEVICE(PCI_VENDOR_ID_DIGI, PCIE_DEVICE_ID_NEO_8RJ45), 0, 0, 13 },
> -	{ PCI_DEVICE(PCI_VENDOR_ID_DIGI, PCI_DEVICE_ID_CLASSIC_4), 0, 0, 14 },
> -	{ PCI_DEVICE(PCI_VENDOR_ID_DIGI, PCI_DEVICE_ID_CLASSIC_4_422), 0, 0, 15 },
> -	{ PCI_DEVICE(PCI_VENDOR_ID_DIGI, PCI_DEVICE_ID_CLASSIC_8), 0, 0, 16 },
> -	{ PCI_DEVICE(PCI_VENDOR_ID_DIGI, PCI_DEVICE_ID_CLASSIC_8_422), 0, 0, 17 },
> -	{ 0, }
> +	{
> +		PCI_DEVICE(PCI_VENDOR_ID_DIGI, PCI_DEVICE_ID_NEO_2DB9),
> +		.driver_data = 0,
> +	}, {

Sorry, but this is definitely NOT "making the array better readable". 
Esp. due to the split to multiple lines. PCI_DEVICE_DATA() would be far 
better IMO. Or PCI_VDEVICE() + .driver_data on a single line...

Anyway, you're right, pci_device_id is not currently used at all. 
Instead, there are big switches in the probe doing the casing. This 
should be rewritten to actually use driver_data and drop the whole 
switch-case stuff from probe.

So you can likely drop driver_data completely for now. It won't/can't be 
used in the current form anyway.

thanks,
-- 
js
suse labs
