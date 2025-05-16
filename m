Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA2FC1FF7DC;
	Fri, 16 May 2025 06:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747377108; cv=none; b=KY9hsZVxsZvUsezLW1eQQtcvr06lEOKp1VJH0xns9A5srEf604EW3b+l5PqOugEK2VJynA2YXpLbB72gbZRb25y6BjiCOeCEw4Ws0UqxIlr9IpaY7Im34AGqFhiPiTsv07INKF2UjT0lQbftp8KdozFHKqg7vcAB6ay+TrjwYOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747377108; c=relaxed/simple;
	bh=ezqwvE80IS8sf3hJ0C4YdG2Ea1FOROaDMhT4zDNXY20=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hkr2b2G86d1M8+6ucgsganqq8/xfAWkvJFfrdSo8pG17aLdvzU0il3/AkmPGdgWG+QvTsvD0UTfEsZanndU3h2bD7kQrBtl3C7kofe4iFnp2lCJxhuD/ylLcqoSig/N3RF7G2bt/8z/EQAypphe1zHS5H8h3sfLXMn6kexKfZhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yzv/vCmJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yzv/vCmJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60CA1C4CEE4;
	Fri, 16 May 2025 06:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747377107;
	bh=ezqwvE80IS8sf3hJ0C4YdG2Ea1FOROaDMhT4zDNXY20=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Yzv/vCmJQazk338RJdSyI3Bogq2yYl6pNwGzFtTb5PizAllilZAKlB0Wl4ZXtK6Eh
	 BpynlIiHJ0acJ2B4Y0anKGA7ufum3XEqSV6QcI878bfUv6Y+49f39jQmmMZYmCd/Iu
	 hycyfP8ck8w4Ati/uoaHp4RzQndn2rM7wihD+18vx6Oq2ZG4uNtE6ZCw8AoSXsJb28
	 eve8rZVg4FY4ZZUrK3R4jinIE3YbdiPKdphKAdjYExuefMPawwC0HRU3toiYQZzAdW
	 mHj2jjJiJkKMSSlaqf3uGlBoYhdtde2uPEpkkep/INdGL7kEC9tkxg8jqb1fX9Bak4
	 w2dTtsOCEOnmw==
Message-ID: <a5463522-1fa8-4ede-aec9-73f8a0aee196@kernel.org>
Date: Fri, 16 May 2025 08:31:44 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] vt: add VT_GETCONSIZECSRPOS to retrieve console
 size and cursor position
To: Nicolas Pitre <nico@fluxnic.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250514194710.6709-1-nico@fluxnic.net>
 <20250514194710.6709-3-nico@fluxnic.net>
 <8fb2c16f-0e9b-402d-a7f2-4881de8c7bd9@kernel.org>
 <3o3q5896-8540-nro6-534o-307nn81r7r5r@syhkavp.arg>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <3o3q5896-8540-nro6-534o-307nn81r7r5r@syhkavp.arg>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15. 05. 25, 18:02, Nicolas Pitre wrote:
> On Thu, 15 May 2025, Jiri Slaby wrote:
> 
>> On 14. 05. 25, 21:42, Nicolas Pitre wrote:
>>> From: Nicolas Pitre <npitre@baylibre.com>
>>>
>>> The console dimension and cursor position are available through the
>>> /dev/vcsa interface already. However the /dev/vcsa header format uses
>>> single-byte fields therefore those values are clamped to 255.
>>>
>>> As surprizing as this may seem, some people do use 240-column 67-row
>>> screens (a 1920x1080 monitor with 8x16 pixel fonts) which is getting
>>> close to the limit. Monitors with higher resolution are not uncommon
>>> these days (3840x2160 producing a 480x135 character display) and it is
>>> just a matter of time before someone with, say, a braille display using
>>> the Linux VT console and BRLTTY on such a screen reports a bug about
>>> missing and oddly misaligned screen content.
>>>
>>> Let's add VT_GETCONSIZECSRPOS for the retrieval of console size and cursor
>>> position without byte-sized limitations. The actual console size limit as
>>> encoded in vt.c is 32767x32767 so using a short here is appropriate. Then
>>> this can be used to get the cursor position when /dev/vcsa reports 255.
>>>
>>> The screen dimension may already be obtained using TIOCGWINSZ and adding
>>> the same information to VT_GETCONSIZECSRPOS might be redundant. However
>>> applications that care about cursor position also care about display
>>> size and having 2 separate system calls to obtain them separately is
>>> wasteful. Also, the cursor position can be queried by writing "\e[6n" to
>>> a tty and reading back the result but that may be done only by the actual
>>> application using that tty and not a sideline observer.
>>>
>>> Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
>>> ---
>>>    drivers/tty/vt/vt_ioctl.c | 16 ++++++++++++++++
>>>    include/uapi/linux/vt.h   |  9 +++++++++
>>>    2 files changed, 25 insertions(+)
>>>
>>> diff --git a/drivers/tty/vt/vt_ioctl.c b/drivers/tty/vt/vt_ioctl.c
>>> index 4b91072f3a4e..83a3d49535e5 100644
>>> --- a/drivers/tty/vt/vt_ioctl.c
>>> +++ b/drivers/tty/vt/vt_ioctl.c
>>> @@ -951,6 +951,22 @@ int vt_ioctl(struct tty_struct *tty,
>>>     				(unsigned short __user *)arg);
>>>     case VT_WAITEVENT:
>>>    		return vt_event_wait_ioctl((struct vt_event __user *)arg);
>>> +
>>> +	case VT_GETCONSIZECSRPOS:
>>> +	{
>>> +		struct vt_consizecsrpos concsr;
>>> +
>>> +		console_lock();
>>> +		concsr.con_cols = vc->vc_cols;
>>> +		concsr.con_rows = vc->vc_rows;
>>> +		concsr.csr_col = vc->state.x;
>>> +		concsr.csr_row = vc->state.y;
>>> +		console_unlock();
>>
>> Makes a lot of sense!
>>
>>> +		if (copy_to_user(up, &concsr, sizeof(concsr)))
>>> +			return -EFAULT;
>>> +		return 0;
>>> +	}
>>> +
>>>     default:
>>>     	return -ENOIOCTLCMD;
>>>    	}
>>> diff --git a/include/uapi/linux/vt.h b/include/uapi/linux/vt.h
>>> index e9d39c48520a..e93c8910133b 100644
>>> --- a/include/uapi/linux/vt.h
>>> +++ b/include/uapi/linux/vt.h
>>> @@ -84,4 +84,13 @@ struct vt_setactivate {
>>>    
>>>    #define VT_SETACTIVATE	0x560F	/* Activate and set the mode of a
>>>    console */
>>>    
>>> +struct vt_consizecsrpos {
>>> +	unsigned short con_rows;	/* number of console rows */
>>> +	unsigned short con_cols;	/* number of console columns */
>>> +	unsigned short csr_row;		/* current cursor's row */
>>> +	unsigned short csr_col;		/* current cursor's column */
>>
>> Use __u16 pls.
> 
> I beg to differ. Not because __u16 is fundamentally wrong.

Fundamentaly wrong -- for what reason? These types are exactly what 
should be used in userspace APIs instead of bare C types.

> But
> everything else in this file uses only basic C types already and adding
> one struct with __u16 would look odd.

The whole file needs to be fixed, eventually. It's no reason to add 
another bad entry.

> And adding some include to define
> that type would be needed since there are currently no such includes in
> that file currently, and that could potentially cause issues with
> existing consumers of that header file that didn't expect extra
> definitions, etc.

On one side yes, on the other side, sticking with ancient coding style 
while being afraid to include basic headers would be moot.

> So I think that such a change, if it is to happen,
> should be done for the whole file at once and in a separate patch.

Let me bite the bullet and send something. (Likely on Mon -- now queued 
up in my queue for build tests).

>>> +};
>>> +
>>> +#define VT_GETCONSIZECSRPOS 0x5610  /* get console size and cursor position
>>> */
>>
>> Can we define that properly as
>>    _IOR(0x56, 0x10, struct vt_consizecsrpos)
>> ? Note this would still differ from "conflicting":
>> #define VIDIOC_G_FBUF            _IOR('V', 10, struct v4l2_framebuffer)
> 
> Similarly as the reason above: given that no other definitions in that
> file use the _IO*() scheme for historical reasons, it is preferable to
> follow what's already there to avoid unsuspected confusion. The VT layer
> is pretty much unlykely to grow many additional ioctls in the
> foreseeable future so I'd lean towards keeping things simple and in line
> with the existing code.

I tend to disagree. We should not follow bad practices only because they 
are already there.

-- 
js
suse labs
