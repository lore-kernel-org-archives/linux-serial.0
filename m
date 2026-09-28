Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65BD49D599
	for <linux-serial@vger.kernel.org>; Mon, 28 Sep 2026 11:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790594073; cv=none; b=nCaKa/9qBX+UK2Ex2hW768uHxfVel62BMawx0TT6Q+sfxCRzu6bNgj+9LUo5g+t8i/L8jPp4NNU4zZTwDnw5C0DE9JQ63uObwNYIad4uaTURMHs6m9Y8Zr85VmlJrBY7Ut+chBLTd8UyJfrSFk+wXkeYSs9K8+ETsqUgZk52Dl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790594073; c=relaxed/simple;
	bh=NC9wnH809YPTYJt65n/P6wY667YJxPn2MnmBkvB2JFA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nV9vWcmJEWeoYaZTlEWWY0hcEFEya4gD0ML5nMyA85LoQNK7caeFkuh0wAoXuybG61b5IS+z68IY0u5rHruaxt4ZHpinm29uaHgul1kghaHDeEvZPwzWNnXfL5q+fMEaqMff2fT/G8o7wn7kB8rK9A5YCzMTL36cWV7539hd7Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=AT4CYSk4; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=4FQyDlrb; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=pl0B0tcK; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=+luPtwx4; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="AT4CYSk4";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="4FQyDlrb";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="pl0B0tcK";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="+luPtwx4"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CB45222745;
	Mon, 28 Sep 2026 11:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1790594066; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=T7DQXoqYyJF9JDYKyqmwcaf8DlQ/o6emYbvkFY8yqqY=;
	b=AT4CYSk4i1XzEmUdrBskSLLSn1ANStwZWqEqDhQQ7zccKqO/mVBxf/nNgXFqiQbXk47+Md
	n3Ol0PQStVjieFsr0hQEPMbFhBMCbnWiCTst4QsVulVLlfzapXScUjg6jjP2McS7IOFY5c
	a/dCJNPTTLnMeEK2oVlVMD7L/VuGvro=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790594066;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=T7DQXoqYyJF9JDYKyqmwcaf8DlQ/o6emYbvkFY8yqqY=;
	b=4FQyDlrbtPERYERA36fOl+NTU9KFs7s4dTopt1NSvwSJ/Zxuj4iHYeYL9eL12nTkkB8685
	mt9mE3j9CzSBA+Ag==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=pl0B0tcK;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=+luPtwx4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1790594061; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=T7DQXoqYyJF9JDYKyqmwcaf8DlQ/o6emYbvkFY8yqqY=;
	b=pl0B0tcKiqfdERHTZ9SEzX/P5ok5auRhh6kUEQmkpOCRougIRT796sl0gN5NZSLLZU5Dax
	RcQR3DAMicE7+vo8BVsI0znYKdQKJJWyKB96NS6MnHdu5lg36m4mc8V+BXrwHbIv5LcK0X
	O3tbC5HfNK6YHTlzxKJx3Nz08qkoN6I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790594061;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=T7DQXoqYyJF9JDYKyqmwcaf8DlQ/o6emYbvkFY8yqqY=;
	b=+luPtwx4B8ABmTdZ4ir0C60W/8DnUNm+qUMtslDSKn/9s0xwsX+UzX23o68Usnedi1BG/n
	gyG9N9Ev+jYbOFBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6750713419;
	Mon, 28 Sep 2026 11:14:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id S+yqEQ1MumrWLgAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Mon, 28 Sep 2026 11:14:21 +0000
Message-ID: <9a95df99-3978-46b1-a3a3-17392006f5f1@suse.de>
Date: Mon, 28 Sep 2026 13:14:20 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/5] vt: Add cursor-size helpers
To: sashiko-reviews@lists.linux.dev
Cc: linux-serial@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20260928085724.41660-1-tzimmermann@suse.de>
 <20260928085724.41660-2-tzimmermann@suse.de>
 <20260928090923.E6F9C1F000FF@smtp.kernel.org>
Content-Language: en-US
From: Thomas Zimmermann <tzimmermann@suse.de>
Autocrypt: addr=tzimmermann@suse.de; keydata=
 xsBNBFs50uABCADEHPidWt974CaxBVbrIBwqcq/WURinJ3+2WlIrKWspiP83vfZKaXhFYsdg
 XH47fDVbPPj+d6tQrw5lPQCyqjwrCPYnq3WlIBnGPJ4/jreTL6V+qfKRDlGLWFjZcsrPJGE0
 BeB5BbqP5erN1qylK9i3gPoQjXGhpBpQYwRrEyQyjuvk+Ev0K1Jc5tVDeJAuau3TGNgah4Yc
 hdHm3bkPjz9EErV85RwvImQ1dptvx6s7xzwXTgGAsaYZsL8WCwDaTuqFa1d1jjlaxg6+tZsB
 9GluwvIhSezPgnEmimZDkGnZRRSFiGP8yjqTjjWuf0bSj5rUnTGiyLyRZRNGcXmu6hjlABEB
 AAHNJ1Rob21hcyBaaW1tZXJtYW5uIDx0emltbWVybWFubkBzdXNlLmRlPsLAjgQTAQgAOAIb
 AwULCQgHAgYVCgkICwIEFgIDAQIeAQIXgBYhBHIX+6yM6c9jRKFo5WgNwR1TC3ojBQJftODH
 AAoJEGgNwR1TC3ojx1wH/0hKGWugiqDgLNXLRD/4TfHBEKmxIrmfu9Z5t7vwUKfwhFL6hqvo
 lXPJJKQpQ2z8+X2vZm/slsLn7J1yjrOsoJhKABDi+3QWWSGkaGwRJAdPVVyJMfJRNNNIKwVb
 U6B1BkX2XDKDGffF4TxlOpSQzdtNI/9gleOoUA8+jy8knnDYzjBNOZqLG2FuTdicBXblz0Mf
 vg41gd9kCwYXDnD91rJU8tzylXv03E75NCaTxTM+FBXPmsAVYQ4GYhhgFt8S2UWMoaaABLDe
 7l5FdnLdDEcbmd8uLU2CaG4W2cLrUaI4jz2XbkcPQkqTQ3EB67hYkjiEE6Zy3ggOitiQGcqp
 j//OwE0EWznS4AEIAMYmP4M/V+T5RY5at/g7rUdNsLhWv1APYrh9RQefODYHrNRHUE9eosYb
 T6XMryR9hT8XlGOYRwKWwiQBoWSDiTMo/Xi29jUnn4BXfI2px2DTXwc22LKtLAgTRjP+qbU6
 3Y0xnQN29UGDbYgyyK51DW3H0If2a3JNsheAAK+Xc9baj0LGIc8T9uiEWHBnCH+RdhgATnWW
 GKdDegUR5BkDfDg5O/FISymJBHx2Dyoklv5g4BzkgqTqwmaYzsl8UxZKvbaxq0zbehDda8lv
 hFXodNFMAgTLJlLuDYOGLK2AwbrS3Sp0AEbkpdJBb44qVlGm5bApZouHeJ/+n+7r12+lqdsA
 EQEAAcLAdgQYAQgAIAIbDBYhBHIX+6yM6c9jRKFo5WgNwR1TC3ojBQJftOH6AAoJEGgNwR1T
 C3ojVSkIALpAPkIJPQoURPb1VWjh34l0HlglmYHvZszJWTXYwavHR8+k6Baa6H7ufXNQtThR
 yIxJrQLW6rV5lm7TjhffEhxVCn37+cg0zZ3j7zIsSS0rx/aMwi6VhFJA5hfn3T0TtrijKP4A
 SAQO9xD1Zk9/61JWk8OysuIh7MXkl0fxbRKWE93XeQBhIJHQfnc+YBLprdnxR446Sh8Wn/2D
 Ya8cavuWf2zrB6cZurs048xe0UbSW5AOSo4V9M0jzYI4nZqTmPxYyXbm30Kvmz0rYVRaitYJ
 4kyYYMhuULvrJDMjZRvaNe52tkKAvMevcGdt38H4KSVXAylqyQOW5zvPc4/sq9c=
In-Reply-To: <20260928090923.E6F9C1F000FF@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: -4.51
X-Rspamd-Queue-Id: CB45222745
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:email,suse.de:mid];
	MID_RHS_MATCH_FROM(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Flag: NO



Am 28.09.26 um 11:09 schrieb sashiko-bot@kernel.org:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] vt: unprivileged log injection via pr_warn_once in cursor sizing

FYI this is by intention. In DRM land, we usually allow for warn_once to 
be triggered by user-space code.  If that's not an option for vt, let's 
use pr_debug() instead.

> --
>
> commit 4874174842fbef217a6215957d5bf1bff1442b36
> Author: Thomas Zimmermann <tzimmermann@suse.de>
>
> vt: Add cursor-size helpers
>
> The new helpers vc_cursor_start() and vc_cursor_end() return the scanlines
> in which the cursor block starts respectively ends. Users can control the
> cursor size with the vt module's parameter cur_default or with the ESC
> sequence \e[?Nc. In case of an invalid setting, the new helpers fall back
> to cur_default and then underline cursors.
>
>> diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
>> index 57edf37495a81..8141296ccad05 100644
>> --- a/drivers/tty/vt/vt.c
>> +++ b/drivers/tty/vt/vt.c
> [ ... ]
>
>> @@ -264,6 +265,109 @@ unsigned int vc_font_size(const struct vc_font *font)
>>   }
>>   EXPORT_SYMBOL_GPL(vc_font_size);
>>   
>> +/*
>> + * Cursors
>> + */
>> +
>> +static unsigned int vc_cursor_size(unsigned int cursor_size)
>> +{
>> +	const unsigned int cursor_default_size = CUR_SIZE(READ_ONCE(cur_default));
>> +
>> +retry:
>> +	switch (cursor_size) {
>> +	case CUR_NONE:
>> +	case CUR_UNDERLINE:
>> +	case CUR_LOWER_THIRD:
>> +	case CUR_LOWER_HALF:
>> +	case CUR_TWO_THIRDS:
>> +	case CUR_BLOCK:
>> +		return cursor_size;
>> +	default:
>> +		pr_warn_once("Unknown cursor %u\n", cursor_size);
>> +		fallthrough;
> [Severity: Low]
> Is it expected that an unprivileged user can trigger this warning message?
>
> An unprivileged user can write a specific DEC escape sequence (e.g.,
> \e[?103c) to the VT, which parses an unhandled size into
> vc->vc_cursor_type via CSI_MAKE.
>
> When the console driver later updates the cursor, vc_cursor_size() hits
> the default case and emits this warning.
>
> Since pr_warn_once() is rate-limited to once per boot, it cannot cause
> a denial of service, but it still allows local unprivileged users with
> write access to a VT to add a warning line to the kernel log.
>
>> +	case CUR_DEF:
>> +		/*
>> +		 * Use user-given default size, or underline if
>> +		 * the given default is invalid.
>> +		 */
>> +		if (cursor_size != cursor_default_size)
>> +			cursor_size = cursor_default_size;
>> +		else
>> +			cursor_size = CUR_UNDERLINE;
>> +		goto retry;
>> +	}
>> +}
> [ ... ]
>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Stefan Gaiser, Jochen Jaser, Abhinav Puri, (HRB 36809, AG Nürnberg)


