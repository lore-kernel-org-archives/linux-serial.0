Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42FC848AE16;
	Mon, 12 Oct 2026 12:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791808900; cv=none; b=CxxUmWsm0BdWp7uhRMDlGhtKkqCXa9VL50isvnDt/NS5tjFWEDWboBqZt6CAfahZ0+iBeuwv4Ge5aYjOVOyStSArUgjMsQ9fICFMjYD0+oSdUQ4E75AUebbCNgkdyL/b4fq52ZdZy7jFwInTtKp2aK5bi6jNV5ZxS8HWMyA5jFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791808900; c=relaxed/simple;
	bh=8xQQtEUKtbFefvLBfx1SFIMGR/LJJ6UjcngZhBogxrY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=HpGH7Xf0QvyLn6RfGco2HUCSdTdgEeT9+GtL8a79OkgH/EHFcZkysjG32PEyTIdJXkST2UAUylvdNzSdcNKOcvpcIXnOtAn48C+1/Q0aSpJTeggD6NOqBg1LH8VljJD5iSVOsQGtZ0+9s34Yzj3XkT7I9kyckenDl9itf/yIyso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=lq5pd/DU; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=v1NjmZqM; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=lq5pd/DU; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=v1NjmZqM; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="lq5pd/DU";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="v1NjmZqM";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="lq5pd/DU";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="v1NjmZqM"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0BE0F21E13;
	Mon, 12 Oct 2026 12:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1791808896; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Wx3b/CP6sPbHvBTl/TRuhPXR2iqBWtRrmizKeQZbYdQ=;
	b=lq5pd/DUe8vm38VNzAd8+ZYp63dBk2mMQqOMikpwIITSEckUoOZjDGzwi+X0T1pnVlWiNy
	35LpWXRLF95p737wbrDjMFxmDP+vAcoFWBaMKG5EFdM4qa13DId1bGOqMtDppQBYXNwqfH
	5uK6uqC0ru1s6LHWA8GQQYx7mE0RifI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1791808896;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Wx3b/CP6sPbHvBTl/TRuhPXR2iqBWtRrmizKeQZbYdQ=;
	b=v1NjmZqMSe11GEcb4/nV+uyj6NvCc89SkPYAJZmcysgzncc3RhAKkbB0Su7NHrQF1Ky6Gp
	uTK1PcH345OvG/BQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="lq5pd/DU";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=v1NjmZqM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1791808896; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Wx3b/CP6sPbHvBTl/TRuhPXR2iqBWtRrmizKeQZbYdQ=;
	b=lq5pd/DUe8vm38VNzAd8+ZYp63dBk2mMQqOMikpwIITSEckUoOZjDGzwi+X0T1pnVlWiNy
	35LpWXRLF95p737wbrDjMFxmDP+vAcoFWBaMKG5EFdM4qa13DId1bGOqMtDppQBYXNwqfH
	5uK6uqC0ru1s6LHWA8GQQYx7mE0RifI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1791808896;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Wx3b/CP6sPbHvBTl/TRuhPXR2iqBWtRrmizKeQZbYdQ=;
	b=v1NjmZqMSe11GEcb4/nV+uyj6NvCc89SkPYAJZmcysgzncc3RhAKkbB0Su7NHrQF1Ky6Gp
	uTK1PcH345OvG/BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9058713408;
	Mon, 12 Oct 2026 12:41:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kel3Dn/VzGrPPAAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Mon, 12 Oct 2026 12:41:35 +0000
Message-ID: <6f774188-86ef-4a84-84c9-d8e45fa3db45@suse.de>
Date: Mon, 12 Oct 2026 14:41:34 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] vt: Use boolean as parameter to do_blank_screen() and
 do_unblank_screen()
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: jirislaby@kernel.org, deller@gmx.de,
 James.Bottomley@hansenpartnership.com, simona@ffwll.ch,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 linux-fbdev@vger.kernel.org, linux-parisc@vger.kernel.org,
 sashiko-reviews@lists.linux.dev
References: <20261012094114.38549-1-tzimmermann@suse.de>
 <20261012094114.38549-2-tzimmermann@suse.de>
 <2026101228-unfreeze-drearily-670f@gregkh>
 <1ad9f380-7efe-4323-acbc-a3cca3420184@suse.de>
Content-Language: en-US
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
In-Reply-To: <1ad9f380-7efe-4323-acbc-a3cca3420184@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spam-Score: -4.50
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.50 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	MX_GOOD(-0.01)[];
	FREEMAIL_ENVRCPT(0.00)[gmx.de];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmx.de,hansenpartnership.com,ffwll.ch,vger.kernel.org,lists.linux.dev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:email,suse.de:dkim,suse.com:url];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Level: 
X-Rspamd-Queue-Id: 0BE0F21E13
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org



Am 12.10.26 um 14:28 schrieb Thomas Zimmermann:
> Hi
>
> Am 12.10.26 um 13:30 schrieb Greg KH:
>> On Mon, Oct 12, 2026 at 11:27:38AM +0200, Thomas Zimmermann wrote:
>>> The parameters to do_blank_screen() and do_unblank_screen() signal
>>> whether the call is part of a switch between text and graphics mode.
>>> Convert to boolean. No functional changes.
>>>
>>> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
>>> ---
>>>   drivers/tty/vt/vt.c              | 20 ++++++++++----------
>>>   drivers/tty/vt/vt_ioctl.c        | 12 ++++++------
>>>   drivers/video/fbdev/core/fbcon.c |  4 ++--
>>>   include/linux/vt_kern.h          |  5 +++--
>>>   4 files changed, 21 insertions(+), 20 deletions(-)
>>>
>>> diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
>>> index 57edf37495a8..9e7b4419b422 100644
>>> --- a/drivers/tty/vt/vt.c
>>> +++ b/drivers/tty/vt/vt.c
>>> @@ -3374,7 +3374,7 @@ static void console_callback(struct 
>>> work_struct *ignored)
>>>           scrollback_delta = 0;
>>>       }
>>>       if (blank_timer_expired) {
>>> -        do_blank_screen(0);
>>> +        do_blank_screen(false);
>> Same type of comment here, this bool doesn't really tell what is
>> happening at all (not your fault, 0/1 doesn't either.)
>>
>> I'm all for this patch but shouldn't this be fixed up to be 2 different
>> named functions entirely?
>
> Can you elaborate?  Do you mean there should be a separate helper and 
> callback for switching between KD_TEXT and KD_GRAPHICS?
>
> Looking through the *_blank_screen() helpers and the console 
> implementations, I think we'd mostly duplicate code. Mode-switching 
> and blanking are tightly coupled.  Semantics get a bit cleaner with 
> the change you proposed to patch 1, I think.

And looking even further, it's not entirely clear why consw.con_blank 
even receives the mode_switch parameter.  The consoles track it with 
some internal state, but all of the mode information is available in 
struct vc_data.vc_mode as well.  I think mode_switch and similar 
booleans could be replaced with using vc_mode directly.



-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Stefan Gaiser, Jochen Jaser, Abhinav Puri, (HRB 36809, AG Nürnberg)


