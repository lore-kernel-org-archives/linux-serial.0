Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3EE9421EFB;
	Mon, 12 Oct 2026 12:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791806900; cv=none; b=hUEDCuJHRWtR4JGg8r2nFYmb3Nrd628Rve5BF35gs22DuPibTZr33YagbcGlAXi91k1kUXPo5aUD4KETsWqLZ7TtNX4eKUThlok+ttMRm6fapErpD/JGNWt/iXXSghpmn/8hee/VHCXuNha3tC2yEnfh+NF/ydFdXFgO2hpQBZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791806900; c=relaxed/simple;
	bh=xSrGuh9vlWH6PaqJUqXiXJoV/rg2YETpWui1f9Lu7bc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZpzW4WALO9CdvZPBr+2pqejvL6Snx67ijJ/TTd5vZZTby+84YtRSgaJHdnl5S9jl1cFIx90tANvprhqY+vNRQ4o5oQj55DFUHR3LZUpjwYP8l3wMO9T37UeIRhX488YFPrSaxHhG/jPgfCMiUQYibqTZ0vKyQcL5DY5MUF5b6V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=VVLd+1QO; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Ey7fcp18; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=VVLd+1QO; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Ey7fcp18; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="VVLd+1QO";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Ey7fcp18";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="VVLd+1QO";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Ey7fcp18"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E1B7521DF6;
	Mon, 12 Oct 2026 12:08:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1791806895; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=WvADoobcQwjPCCRIQkVH+8ppTjgfgndh1wPf3i42xI0=;
	b=VVLd+1QOJcRdyRMIsD3e2HrVo94LEa7rPhPhVc+XAAnlYJo60INVyl62VSpWU7qFvWlt0f
	6OzxrNSlMNI0DDhPNlArHhUAb6LiLNnfm6tsG/vb44mC9XViGXWDOl+5dTj4DKdId/ct5G
	4sDXvx0kG7WMnoDuOfhDkOOC7cMkLE0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1791806895;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=WvADoobcQwjPCCRIQkVH+8ppTjgfgndh1wPf3i42xI0=;
	b=Ey7fcp18BLwuqlIrNwuZapbPdvMT/LrXSqF7evKRgsScVbyN8xMsqDv/D6azGB49WJefL9
	fLitqGCoXLTajYBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1791806895; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=WvADoobcQwjPCCRIQkVH+8ppTjgfgndh1wPf3i42xI0=;
	b=VVLd+1QOJcRdyRMIsD3e2HrVo94LEa7rPhPhVc+XAAnlYJo60INVyl62VSpWU7qFvWlt0f
	6OzxrNSlMNI0DDhPNlArHhUAb6LiLNnfm6tsG/vb44mC9XViGXWDOl+5dTj4DKdId/ct5G
	4sDXvx0kG7WMnoDuOfhDkOOC7cMkLE0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1791806895;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=WvADoobcQwjPCCRIQkVH+8ppTjgfgndh1wPf3i42xI0=;
	b=Ey7fcp18BLwuqlIrNwuZapbPdvMT/LrXSqF7evKRgsScVbyN8xMsqDv/D6azGB49WJefL9
	fLitqGCoXLTajYBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 743B91342D;
	Mon, 12 Oct 2026 12:08:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Y0oYCq/NzGpLFwAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Mon, 12 Oct 2026 12:08:15 +0000
Message-ID: <07fa4562-6e34-48b4-ba2c-eb053c2aa7b8@suse.de>
Date: Mon, 12 Oct 2026 14:08:14 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] vt: Distinguish between blanking and VESA blank mode
 in con_blank
To: Greg KH <gregkh@linuxfoundation.org>
Cc: jirislaby@kernel.org, deller@gmx.de,
 James.Bottomley@hansenpartnership.com, simona@ffwll.ch,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 linux-fbdev@vger.kernel.org, linux-parisc@vger.kernel.org,
 sashiko-reviews@lists.linux.dev
References: <20261012094114.38549-1-tzimmermann@suse.de>
 <20261012094114.38549-3-tzimmermann@suse.de>
 <2026101255-extending-concrete-2fc7@gregkh>
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
In-Reply-To: <2026101255-extending-concrete-2fc7@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.29 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmx.de];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmx.de,hansenpartnership.com,ffwll.ch,vger.kernel.org,lists.linux.dev];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo,suse.com:url]
X-Spam-Score: -4.29
X-Spam-Level: 
X-Spam-Flag: NO

Hi

Am 12.10.26 um 13:29 schrieb Greg KH:
> On Mon, Oct 12, 2026 at 11:27:39AM +0200, Thomas Zimmermann wrote:
>> The con_blank callback in struct consw encodes blanking and display
>> blank mode in a single parameter named blank. Its semantics equal
>> the FB_BLANK constants from the fbdev subsystems. Yet it is of type
>> enum vesa_blank_mode, which describes VESA DPMS levels of the attached
>> monitor. Although related, this is something else.
>>
>> For this reason, calls to con_blank fill the blank parameter with
>> values that appear non-sensical at first. For example, to blank the
>> console, but keep the monitor on, vt passes VESA_VSYNC_SUSPEND (eq '1').
>> This is because consoles interpret '1' as pixels-off-but-monitor-on.
>> The constant VESA_VSYNC_SUSPEND actually means monitor-vsync-off. And
>> the argument used for monitor-vsync-off is VESA_VSYNC_SUSPEND+1.
>>
>> To fix this by splitting blank into two parameters, blank and blank_mode.
>> The new blank is a boolean to control the display blanking. If cleared,
>> the console creates display output, if set the console does not. The
>> new parameter blank_mode specifies the VESA blank mode for the monitor
>> and equals VESA DPMS levels. If blank is set, blank_mode gives a hint
>> to the console, on how to set up the signal to the monitor.
>>
>> The actual interpretation is up to the console. Newportcon and sticon
>> only handle blank or not-blank. Fbcon and vgacon implement blank plus
>> the VESA DPMS handling. The implementation of both consoles is again
>> somewhat confusing because types and values do not match. Clean up
>> both with the new blank/blank_mode logic.
>>
>> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
>> ---
>>   drivers/tty/vt/vt.c                 | 11 ++++----
>>   drivers/video/console/dummycon.c    |  4 +--
>>   drivers/video/console/newport_con.c |  4 +--
>>   drivers/video/console/sticon.c      |  4 +--
>>   drivers/video/console/vgacon.c      | 44 +++++++++++++++--------------
>>   drivers/video/fbdev/core/fbcon.c    | 19 +++++++------
>>   include/linux/console.h             |  9 ++++--
>>   7 files changed, 51 insertions(+), 44 deletions(-)
>>
>> diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
>> index 9e7b4419b422..f762c965351d 100644
>> --- a/drivers/tty/vt/vt.c
>> +++ b/drivers/tty/vt/vt.c
>> @@ -4671,7 +4671,7 @@ void do_blank_screen(bool entering_gfx)
>>   	if (console_blanked) {
>>   		if (blank_state == blank_vesa_wait) {
>>   			blank_state = blank_off;
>> -			vc->vc_sw->con_blank(vc, vesa_blank_mode + 1, false);
>> +			vc->vc_sw->con_blank(vc, true, vesa_blank_mode, false);
> I hate adding random bool to function parameters as now you need to go
> look them up to try to determine exactly what happened.
>
> Why not just 2 different callbacks:

Sounds like a cleaner design.


>
>> -static bool vgacon_blank(struct vc_data *c, enum vesa_blank_mode blank,
>> +static bool vgacon_blank(struct vc_data *c, bool blank, enum vesa_blank_mode blank_mode,
>>   			 bool mode_switch)
>>   {
>> -	switch (blank) {
>> -	case VESA_NO_BLANKING:		/* Unblank */
>> +	if (blank) {
>> +		switch (blank_mode) {
>> +		case VESA_NO_BLANKING:	/* Normal blanking */
>> +			if (!mode_switch && vga_video_type == VIDEO_TYPE_VGAC) {
>> +				vga_pal_blank(&vgastate);
>> +				vga_palette_blanked = true;
>> +				return 0;
>> +			}
>> +			vgacon_set_origin(c);
>> +			scr_memsetw((void *)vga_vram_base, BLANK,
>> +				    c->vc_screenbuf_size);
>> +			if (mode_switch)
>> +				vga_is_gfx = true;
>> +			return 1;
>> +		default:		/* VESA blanking */
>> +			if (vga_video_type == VIDEO_TYPE_VGAC) {
>> +				vga_vesa_blank(&vgastate, blank_mode);
>> +				vga_vesa_blanked = blank_mode;
>> +			}
>> +			return 0;
>> +		}
>> +	} else { /* Unblank */
>>   		if (vga_vesa_blanked) {
>>   			vga_vesa_unblank(&vgastate);
>>   			vga_vesa_blanked = VESA_NO_BLANKING;
>> @@ -814,24 +834,6 @@ static bool vgacon_blank(struct vc_data *c, enum vesa_blank_mode blank,
>>   		vga_is_gfx = false;
>>   		/* Tell console.c that it has to restore the screen itself */
>>   		return 1;
>> -	case VESA_VSYNC_SUSPEND:	/* Normal blanking */
>> -		if (!mode_switch && vga_video_type == VIDEO_TYPE_VGAC) {
>> -			vga_pal_blank(&vgastate);
>> -			vga_palette_blanked = true;
>> -			return 0;
>> -		}
>> -		vgacon_set_origin(c);
>> -		scr_memsetw((void *) vga_vram_base, BLANK,
>> -			    c->vc_screenbuf_size);
>> -		if (mode_switch)
>> -			vga_is_gfx = true;
>> -		return 1;
>> -	default:		/* VESA blanking */
>> -		if (vga_video_type == VIDEO_TYPE_VGAC) {
>> -			vga_vesa_blank(&vgastate, blank - 1);
>> -			vga_vesa_blanked = blank;
>> -		}
>> -		return 0;
>>   	}
> This can be vgacon_blank() and vgacon_unblank(), right?  That way we
> have a hint as to what is happening and don't have to try to remember
> that a bool as parameter 2 is blank/unblank.

Yeah, we can do that.  We'd also not need the VESA mode in the unblank 
case. It's always VESA_NO_BLANKING there.

Best regards
Thomas

>
> thanks,
>
> greg k-h
>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Stefan Gaiser, Jochen Jaser, Abhinav Puri, (HRB 36809, AG Nürnberg)


