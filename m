Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D93F479887;
	Mon, 14 Sep 2026 15:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789400158; cv=none; b=O6q8UTJOhyqcN1Howy9mP/01L8eyN9M03xwOUJsb67p05R7Ld2HRT04MVxO5kYvyEgLbPVtjLk23gAf3ZPAtIiGwocfG50rFpgjqOlMurF/ggQ7NKbE3EmBUbaFsURTmGn+ollfm9J2kWafQApP4IpRbnXL5IGvnFLz+ATrlngk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789400158; c=relaxed/simple;
	bh=MAGPHmXCBIhziBEg26ZvuPjqgU0drVUTwS2yrtaIaIo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JKWmY8aHoUZu0kjKQQy8rjtBmp/G8OkRRbLenpcjbo0qYvhhhjzzmdjrFrMtA1YXUpVQY608ogE65/oV1eLkhvzoBY0tkwn7I8t7JfQBy7AWwDUcFsSEfZvo0bMrHAlfFrNYv0SM/qS8IA+XaoJ1oC5XUEEhxG7AKDvLEX8FasE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=VgiZ38xu; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=bG7oIN5x; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=DBJ3tvPd; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=YC+3iRCm; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="VgiZ38xu";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="bG7oIN5x";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="DBJ3tvPd";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="YC+3iRCm"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0D40421AC5;
	Mon, 14 Sep 2026 15:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1789400150; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Yfhzq82k8L8drMq+Ll2NQnVekhrjDO6tZ7cNiceRBV0=;
	b=VgiZ38xuAJfCHBmpUs4Mc0D+YwMFCv8VljVWlO7WMP7ptTtR5fULuiOh/YfNomSrYzx38O
	7sa0JstEl1eUi3/YJ5GyBhQYyY0NsSY2lkNSLytgQO7Au3RfY6jZsoDwKNLjk4vixj/Wti
	F2zHNNpdfKBto6qaaRKzRChYi8+63r8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1789400150;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Yfhzq82k8L8drMq+Ll2NQnVekhrjDO6tZ7cNiceRBV0=;
	b=bG7oIN5x0Qjs7RcLu0ty7ReoNmGtegRGwSI5P+bCpq/G7fFGgpJWCk+r5xxs/mZXIUnff/
	vxw2to5dg6vDgpDg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=DBJ3tvPd;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=YC+3iRCm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1789400146; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Yfhzq82k8L8drMq+Ll2NQnVekhrjDO6tZ7cNiceRBV0=;
	b=DBJ3tvPdMy3SurN3mbfnllqVEF7yVWFtPK0AWWeu1vbxByxkyow/v72hcRLncOogjGUuDq
	frDLqMH+/o5Epx3CheXva1fiSpR8eXx938NrDwmvlTufdScHsda85AOOgpPqEWLxEflyiF
	zpXIzPKep/WjKTXxodOHz3s5EyvtCng=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1789400146;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Yfhzq82k8L8drMq+Ll2NQnVekhrjDO6tZ7cNiceRBV0=;
	b=YC+3iRCm0/3Do8mGLGAI30Rjnm84lf9hVnTR2+5I8LhOHLqziT8svovyxEfu1W29rHfKy6
	dmZrO6WMNfFrgCCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A9E2C1368C;
	Mon, 14 Sep 2026 15:35:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7NoMKFEUqGo4cgAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Mon, 14 Sep 2026 15:35:45 +0000
Message-ID: <ac910605-ee57-4139-bea7-38fbbe99777f@suse.de>
Date: Mon, 14 Sep 2026 17:35:45 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] vt: Add cursor-size helpers
To: Helge Deller <deller@gmx.de>, gregkh@linuxfoundation.org,
 jirislaby@kernel.org, simona@ffwll.ch
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-serial@vger.kernel.org, sashiko-reviews@lists.linux.dev
References: <20260911094518.78093-1-tzimmermann@suse.de>
 <20260911094518.78093-2-tzimmermann@suse.de>
 <31dfff58-f3c2-4265-b34f-e40bdc61e18c@gmx.de>
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
In-Reply-To: <31dfff58-f3c2-4265-b34f-e40bdc61e18c@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: -4.51
X-Rspamd-Queue-Id: 0D40421AC5
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
	FREEMAIL_TO(0.00)[gmx.de,linuxfoundation.org,kernel.org,ffwll.ch];
	FREEMAIL_ENVRCPT(0.00)[gmx.de];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:url,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:email,suse.de:mid,gmx.de:email];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Flag: NO

Hi

Am 12.09.26 um 21:01 schrieb Helge Deller:
> On 9/11/26 11:25, Thomas Zimmermann wrote:
>> Cursors in the VT subsystem are blocks within a character cell that are
>> filled with the foreground color. The new helpers vc_font_cursor_start()
>> and vc_font_cursor_end() return the scanlines in which the cursor block
>> starts rsp. ends. This is compatible with VGA hardware
>>
>> In terms of cursor design, the new cursor-size helpers follow 
>> established
>> styles in fbcon. The only exception is in underline cursors for fonts 
>> with
>> a size larger than 10. The underlining dash is now one pixel closer to
>> the font-glyph data, so that the cursor looks less detached. This 
>> follows
>> the style used by vgacon.
>>
>> Similar code in vgacon and fbcon ignores the cursor's default size 
>> stored
>> in vt.cur_default. The consoles default to full-block cursors, while vt
>> defaults to underline cursors. The new helper fall back to 
>> cur_default and
>> then underline cursors; in this order.
>>
>> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
>> ---
>>   drivers/tty/vt/vt.c            | 90 ++++++++++++++++++++++++++++++++++
>>   include/linux/console_struct.h |  2 +
>>   2 files changed, 92 insertions(+)
> You may add
> Reviewed-by: Helge Deller <deller@gmx.de>
> to the whole series.

Thanks a lot. I'll send out another revision to address the bot's concerns.

Best regards
Thomas

>
> Thanks!
> Helge
>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, (HRB 36809, AG Nürnberg)


