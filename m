Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115D74B04AA;
	Mon, 28 Sep 2026 11:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790595927; cv=none; b=d2OqPuJctPBSPdGqABviykla59XQzxJQOJgMIDfjtpL+BPlQaadW9Vp/RNVewS/j6mXcC80jmU1MBjMXkm55nl5t1TYZAt2+dpw1KuEw1UOzXhxSR0dqxqRFKXWLlwU2clrqueZ2+0x8ELfpgha68+9kIioizJpun0xcLfygCxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790595927; c=relaxed/simple;
	bh=gk1d6iWHSG2fWZvzY7hxPims+zk50DZ0DapJERgkQyg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tXEKiORRMv9EISVt45brg3JMDFpi4xIzjhG9B5pDICT0RA9ZA3iNgNlyfmPHTaZ8hfyY3MyIoaLQHfsqKqFKrqT8mA5YkZLB66K0YZvxZyOn6kyXW3njw2+S8Jx07kaLNIqD1oho1nDgpO5XDIi9Ti63sHZL3QErqAaaR/kET9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=droKwZF4; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=oq1mL7Ef; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=W/4lSq6C; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=EDoFp/Au; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="droKwZF4";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="oq1mL7Ef";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="W/4lSq6C";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="EDoFp/Au"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0C60421C07;
	Mon, 28 Sep 2026 11:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1790595919; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=2WVpFuXjFddjDeRIFbAJvdlTK7EgmkNkTiDhxMr1adY=;
	b=droKwZF4+XAkNO5BnDz5fFgevBpfjIM0g4bBczyWs5IjRYoxodw9aFC90JHrbcZaoJISke
	7MXZD2r7ewdLBzOxdp6GeJ+KE5mLbBPkQ6KNUpBUA4dKz28Nm1NNNFU4Oj6GlyQNj1nKaN
	zH8oeU18inWrT/NkWnbmRgyuO/TEK5M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790595919;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=2WVpFuXjFddjDeRIFbAJvdlTK7EgmkNkTiDhxMr1adY=;
	b=oq1mL7EfoOJA7wJiapCfDPPPmtyexesiZ0no8b0gsnPIyfHfMMRkqa3+hyk01pyR5sRdVw
	g227V8St8MeXO/Aw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="W/4lSq6C";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="EDoFp/Au"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1790595915; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=2WVpFuXjFddjDeRIFbAJvdlTK7EgmkNkTiDhxMr1adY=;
	b=W/4lSq6CkagFNUNwOVpQmrORPmQ6YVyutZFacBfNKMgWu37UpMoFBHTvwlssQyz2obTG0B
	j8gPcnDlGzb58LOv20Y1gKlss/WIiE/TUPwseaY+I8AOo3a0eMgLcR4XjY8ql81yFrCXUT
	3QcVqmTe5rRsBk0igz2NV3i/1R2Guqw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790595915;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=2WVpFuXjFddjDeRIFbAJvdlTK7EgmkNkTiDhxMr1adY=;
	b=EDoFp/AuTUuQmOiohUqBR2hUT9i2l4lwY/8VgVmKQEk0WXBKRC13dSUNyINSZozjzJXg7b
	Mr6un4R4x+FDhbCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A467E133F3;
	Mon, 28 Sep 2026 11:45:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WH1nHEpTumrkTQAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Mon, 28 Sep 2026 11:45:14 +0000
Message-ID: <2c5caf22-1fa4-43d7-95c0-782c111ab3f7@suse.de>
Date: Mon, 28 Sep 2026 13:45:14 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/5] vt: Add cursor-size helpers
To: Jani Nikula <jani.nikula@linux.intel.com>, deller@gmx.de,
 gregkh@linuxfoundation.org, jirislaby@kernel.org, simona@ffwll.ch
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-serial@vger.kernel.org, sashiko-reviews@lists.linux.dev
References: <20260928085724.41660-1-tzimmermann@suse.de>
 <20260928085724.41660-2-tzimmermann@suse.de>
 <7e3cccd612e87e6e85271a026d9fc737a56eaa6c@intel.com>
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
In-Reply-To: <7e3cccd612e87e6e85271a026d9fc737a56eaa6c@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: -4.51
X-Rspamd-Queue-Id: 0C60421C07
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	FREEMAIL_ENVRCPT(0.00)[gmx.de];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[linux.intel.com,gmx.de,linuxfoundation.org,kernel.org,ffwll.ch];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:url,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:email,suse.de:mid];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Flag: NO

Hi

Am 28.09.26 um 11:07 schrieb Jani Nikula:
> On Mon, 28 Sep 2026, Thomas Zimmermann <tzimmermann@suse.de> wrote:
>> Cursors in the VT subsystem are blocks within a character cell that are
>> filled with the foreground color. The new helpers vc_cursor_start() and
>> vc_cursor_end() return the scanlines in which the cursor block starts rsp.
>> ends. This is compatible with VGA hardware.
>>
>> In terms of cursor design, the new cursor-size helpers follow established
>> styles in fbcon. The only exception is in underline cursors for fonts with
>> a size larger than 10. The underlining dash is now one pixel closer to
>> the font-glyph data, so that the cursor looks less detached. This follows
>> the style used by vgacon.
>>
>> Users control the cursor size with the vt module's parameter cur_default
>> or with the ESC sequence \e[?Nc, where N is the cursor-size constant. In
>> case of an invalid setting, the new helpers fall back to cur_default and
>> then underline cursors; in this order.
>>
>> Similar code in vgacon and fbcon ignores the cursor's default size stored
>> in vt.cur_default. The consoles default to full-block cursors, while vt
>> defaults to underline cursors. VGA BIOSes also tend to use underline by.
>> default. Upon initialization vt applies its default to the console, but
>> each console might fall back to it own default. For example, running the
>> ESC code from above with the invalid constant of 8 magically flips the
>> cursor from underline to block size on vgacon. Another call with N set
>> to 0 (i.e., default) magically flips it back to underlyine. Making
>> underline the new default everywhere harmonizes vt, fbcon and most VGA
>> BIOSes.
>>
>> v3:
>> - mention user interfaces to control cursor size in commit message (GregKH)
>> - elaborate defaults (GregKH)
>> - move retry logic into helper
>> - handle CUR_DEF
>> v2:
>> - export non-font interface for vgacon
>> - avoid interference from concurrent user space (Sashiko)
>> - fix function docs (Sashiko)
>>
>> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
>> Reviewed-by: Helge Deller <deller@gmx.de>
>> ---
>>   drivers/tty/vt/vt.c            | 104 +++++++++++++++++++++++++++++++++
>>   include/linux/console_struct.h |   7 +++
>>   2 files changed, 111 insertions(+)
>>
>> diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
>> index 57edf37495a8..8141296ccad0 100644
>> --- a/drivers/tty/vt/vt.c
>> +++ b/drivers/tty/vt/vt.c
>> @@ -71,6 +71,7 @@
>>    * by Adam Tla/lka <atlka@pg.gda.pl>, Aug 2006
>>    */
>>   
>> +#include <linux/compiler.h>
>>   #include <linux/module.h>
>>   #include <linux/types.h>
>>   #include <linux/sched/signal.h>
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
> Complete bikeshed, but IMO goto for retries is ugly. It's fine for error
> handling, but this could trivially be a loop.

Ok. I have no strong opinion about it.

Best regards
Thomas

>
> BR,
> Jani.
>
>> +	}
>> +}
>> +
>> +/**
>> + * vc_cursor_start - Calculates the cursor's first scanline within a character cell
>> + * @cell_height: The overall height of the character cell
>> + * @cursor_size: The size constant of cursor pattern
>> + *
>> + * The parameter @cell_height is the height of the character cell as
>> + * displayed by the console. The argument given in @cursor_size is one
>> + * of the CUR_ constants, as stored in struct @vc_data.vc_cursor_type.
>> + * For unknown values, the helper draws the default cursor or an underline
>> + * dash.
>> + *
>> + * Returns:
>> + * The index of the cursor's first scanline within the character cell
>> + */
>> +unsigned int vc_cursor_start(unsigned int cell_height, unsigned int cursor_size)
>> +{
>> +	switch (vc_cursor_size(cursor_size)) {
>> +	case CUR_NONE:
>> +		return cell_height;
>> +	case CUR_UNDERLINE:
>> +	default:
>> +		if (cell_height < 10)
>> +			return cell_height - 1;
>> +		else
>> +			return cell_height - 3;
>> +	case CUR_LOWER_THIRD:
>> +		return cell_height - cell_height / 3;
>> +	case CUR_LOWER_HALF:
>> +		return cell_height - cell_height / 2;
>> +	case CUR_TWO_THIRDS:
>> +		return cell_height - (cell_height * 2) / 3;
>> +	case CUR_BLOCK:
>> +		return 0;
>> +	}
>> +}
>> +EXPORT_SYMBOL_GPL(vc_cursor_start);
>> +
>> +/**
>> + * vc_cursor_end - Calculates the first scanline after the cursor within a character cell
>> + * @cell_height: The overall height of the character cell
>> + * @cursor_size: The size constant of cursor pattern
>> + *
>> + * The parameter @cell_height is the height of the character cell as
>> + * displayed by the console. The argument given in @cursor_size is one
>> + * of the CUR_ constants, as stored in struct @vc_data.vc_cursor_type.
>> + * For unknown values, the helper draws the default cursor or an underline
>> + * dash.
>> + *
>> + * Returns:
>> + * The index of the first scanline after the cursor within the character cell
>> + */
>> +unsigned int vc_cursor_end(unsigned int cell_height, unsigned int cursor_size)
>> +{
>> +	switch (vc_cursor_size(cursor_size)) {
>> +	case CUR_UNDERLINE:
>> +	default:
>> +		if (cell_height < 10)
>> +			return cell_height;
>> +		else
>> +			return cell_height - 1;
>> +	case CUR_NONE:
>> +	case CUR_LOWER_THIRD:
>> +	case CUR_LOWER_HALF:
>> +	case CUR_TWO_THIRDS:
>> +	case CUR_BLOCK:
>> +		return cell_height;
>> +	}
>> +}
>> +EXPORT_SYMBOL_GPL(vc_cursor_end);
>> +
>>   /*
>>    * /sys/class/tty/tty0/
>>    *
>> diff --git a/include/linux/console_struct.h b/include/linux/console_struct.h
>> index fe915afdece5..1d37c7898ea0 100644
>> --- a/include/linux/console_struct.h
>> +++ b/include/linux/console_struct.h
>> @@ -204,6 +204,10 @@ struct vc {
>>   extern struct vc vc_cons [MAX_NR_CONSOLES];
>>   extern void vc_SAK(struct work_struct *work);
>>   
>> +/*
>> + * Cursors
>> + */
>> +
>>   #define CUR_MAKE(size, change, set)	((size) | ((change) << 8) |	\
>>   		((set) << 16))
>>   #define CUR_SIZE(c)		 ((c) & 0x00000f)
>> @@ -222,6 +226,9 @@ extern void vc_SAK(struct work_struct *work);
>>   #define CUR_CHANGE(c)		 ((c) & 0x00ff00)
>>   #define CUR_SET(c)		(((c) & 0xff0000) >> 8)
>>   
>> +unsigned int vc_cursor_start(unsigned int cell_height, unsigned int cursor_size);
>> +unsigned int vc_cursor_end(unsigned int cell_height, unsigned int cursor_size);
>> +
>>   bool con_is_visible(const struct vc_data *vc);
>>   
>>   #endif /* _LINUX_CONSOLE_STRUCT_H */

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Stefan Gaiser, Jochen Jaser, Abhinav Puri, (HRB 36809, AG Nürnberg)


