Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04FD21D9A50;
	Wed, 19 Feb 2025 09:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739957622; cv=none; b=AfIVO2funEXmjb19eGVOQFJ0E1R+yc4vLgQVioP+M0vtwf16xPt+O8jvT2sVvPT1eiDf+YKKQtGphUOg6HAlnITORjFwYCCklIjSlhagrO58ddP8nG2zxF34elQPamOQLCoP1m+cmx82fY/ekkeoRDeFiju+W8vz39LguS0yfOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739957622; c=relaxed/simple;
	bh=tRFglNDJKXhIaBAcopcjlu0IEkazQlWrhYEPSvQAmT0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O0qQqtovYiV1fO9CKzhgisNfht24J7YTdfCn1iRiywl6WEssY2bblv6guEsZTD+zy5Lrtcvf6oKUmWqwz2GA11qHUAbLsCBgw8purhuqHrBt9GUg9dCExdSs67wm1uyXJJ6AxxDEhO4Pyvni4W/PkzuM14mg/66ZM4r+l6HnzKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LKc8XIAO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LKc8XIAO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D71A4C4CED1;
	Wed, 19 Feb 2025 09:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739957621;
	bh=tRFglNDJKXhIaBAcopcjlu0IEkazQlWrhYEPSvQAmT0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=LKc8XIAOAMpl+Y5YkJAzyMtoBcuMrp0Sl1T3x0w9nxT2eJ0DJJfmVPeOAK4v66YKn
	 eqZVMMzeifQkycGzlVamtA07JV5/JkqgCPdqTDixHAYNpFjN1q+SRSMrmeMuCFTWdk
	 spfRuXAG8qhb+QhNy+ZlV/BqAm681AsskOoXqux0GEVgl6N+cY6uZvS64deg/M2Mt7
	 xUaF6xcb4bMzq2spBtgF8VjWM5L4e6qVboK3lynHRzW+rzlTDWXaaqmARVIDAjXmkU
	 5JzmsFdqqj7YcaGUzlP2G6/EDpdyxyW8km4n6Cj5wSHt5FrRMBo04aRJUoN+D9Ztbl
	 jSLXNJz89m2+w==
Message-ID: <8b2200ea-425d-477d-8463-d49eb1c7a66a@kernel.org>
Date: Wed, 19 Feb 2025 10:33:38 +0100
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] tty/vt: Use KVAL instead of use bit operation
To: Alexey Gladkov <legion@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 LKML <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org
References: <cover.1739881707.git.legion@kernel.org>
 <01ee8849ef8dc49c93a77bc4961ad56b9d435b8a.1739881707.git.legion@kernel.org>
 <3d96896d-5bb7-4ae5-a6c9-b586337eaa3f@kernel.org>
 <Z7WjABCTLE4CisKY@example.org>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <Z7WjABCTLE4CisKY@example.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19. 02. 25, 10:23, Alexey Gladkov wrote:
> On Wed, Feb 19, 2025 at 07:24:52AM +0100, Jiri Slaby wrote:
>> On 18. 02. 25, 13:29, Alexey Gladkov wrote:
>>> The K_HANDLERS always gets KVAL as an argument. It is better to use the
>>> KVAL macro itself instead of bit operation.
>>>
>>> Signed-off-by: Alexey Gladkov <legion@kernel.org>
>>> ---
>>>    drivers/tty/vt/keyboard.c | 4 ++--
>>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
>>> index 804355da46f5..7df041ac4d5c 100644
>>> --- a/drivers/tty/vt/keyboard.c
>>> +++ b/drivers/tty/vt/keyboard.c
>>> @@ -885,7 +885,7 @@ static void k_shift(struct vc_data *vc, unsigned char value, char up_flag)
>>>    		if (kbd->kbdmode == VC_UNICODE)
>>>    			to_utf8(vc, npadch_value);
>>>    		else
>>> -			put_queue(vc, npadch_value & 0xff);
>>> +			put_queue(vc, KVAL(npadch_value));
>>
>> While the mask is the same, this is not a kval, right?
> 
> I'm pretty sure it's KVAL, but to be honest I don't understand why it is
> not done for to_utf8() as well. All values passed to to_utf8() must be
> kval.

Not at all, it handles multibyte chars.

> We call to_utf8() in k_unicode, fn_enter (through k_spec), handle_diacr
> (through k_deadunicode or k_unicode). All K_HANDLERS take KVAL as value.

Yes, but pass unicode multibyte to to_utf8().

> If I understand this code correctly, it is more correct to write it like
> this:
> 
> --- a/drivers/tty/vt/keyboard.c
> +++ b/drivers/tty/vt/keyboard.c
> @@ -882,10 +882,11 @@ static void k_shift(struct vc_data *vc, unsigned char value, char up_flag)
> 
>          /* kludge */
>          if (up_flag && shift_state != old_state && npadch_active) {
> +               u32 kval = KVAL(npadch_value);
>                  if (kbd->kbdmode == VC_UNICODE)
> -                       to_utf8(vc, npadch_value);
> +                       to_utf8(vc, kval);

Definitely not, as you want to pass that multibyte char in.

-- 
js
suse labs
