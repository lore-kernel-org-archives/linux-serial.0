Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C5E4F5E0
	for <linux-serial@vger.kernel.org>; Wed,  1 Apr 2026 09:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775034592; cv=none; b=nI6m+nyib+kxaJRplr+vMtO+W8RovcQuLRTwv9Oz0dpSSD8UfwOwvXP/NuA9pk7EMp/9rI+TrfeUJW+fPyDGvr2dcJKQllC0R9D/9dNkCAcv6xWPGuadMc2HmJiJZ9Dig+w/IOKX2CLtSxcnxknEH2hWZBOju4RCV2fBOEPeSuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775034592; c=relaxed/simple;
	bh=ZX28RN3BXsq1ncmEMtBEJmsdaPdU1NF6VXLzrFIF17U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jJk3JmzgMfr59Za+tKEtVEVHPQq2yzO2EM6uHM/FbaKn9D+XB69gtqqC27ESgsub/PNTSJ/otr32ec3o8T0dvE+druxKnLikDuvl0ZVz5UieFAjKP9Chr5wll1iWJ14IONay/ObY4kxm3zLihbRAYEzlIpryeUBUezop+lr/GYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=sQAItTGJ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=CBEPxWBB; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=sQAItTGJ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=CBEPxWBB; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="sQAItTGJ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="CBEPxWBB";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="sQAItTGJ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="CBEPxWBB"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 762744D2B6;
	Wed,  1 Apr 2026 09:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1775034589; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=X2kHwcaaTizQUXb3Cp0D/jRqbWryLrHJHafaNs9/YmA=;
	b=sQAItTGJuaW7pkWJDFb0kUIXNploqGYxSi3ps0139xpN/NzPWoV/HwOqv8YAcDseoYwRbk
	Bv55QgOnSPNqive09F2I4TSvV9WxzgWClADpxUXkcfRdxfFw3zCVMgK4MgRbVBnqqsG55B
	BlfyS+wPLhMN6s113NDU7fb9a4bs+iY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1775034589;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=X2kHwcaaTizQUXb3Cp0D/jRqbWryLrHJHafaNs9/YmA=;
	b=CBEPxWBBDRAt+I4joMn6KdI/HvH5jqdedrFWwggW18DnuqNT1LK+33nNSoTlcywGZ0jdUv
	aXfKEN6I429NTVDQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=sQAItTGJ;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=CBEPxWBB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1775034589; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=X2kHwcaaTizQUXb3Cp0D/jRqbWryLrHJHafaNs9/YmA=;
	b=sQAItTGJuaW7pkWJDFb0kUIXNploqGYxSi3ps0139xpN/NzPWoV/HwOqv8YAcDseoYwRbk
	Bv55QgOnSPNqive09F2I4TSvV9WxzgWClADpxUXkcfRdxfFw3zCVMgK4MgRbVBnqqsG55B
	BlfyS+wPLhMN6s113NDU7fb9a4bs+iY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1775034589;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=X2kHwcaaTizQUXb3Cp0D/jRqbWryLrHJHafaNs9/YmA=;
	b=CBEPxWBBDRAt+I4joMn6KdI/HvH5jqdedrFWwggW18DnuqNT1LK+33nNSoTlcywGZ0jdUv
	aXfKEN6I429NTVDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 363E04A0B0;
	Wed,  1 Apr 2026 09:09:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id bGvOC93gzGnNMQAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Wed, 01 Apr 2026 09:09:49 +0000
Message-ID: <0840b122-89cf-46e5-a35c-37d77d828e20@suse.de>
Date: Wed, 1 Apr 2026 11:09:48 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/10] lib/fonts: Clean up Makefile
To: Jiri Slaby <jirislaby@kernel.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>
Cc: deller@gmx.de, gregkh@linuxfoundation.org, simona@ffwll.ch,
 sam@ravnborg.org, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org
References: <20260327130431.59481-1-tzimmermann@suse.de>
 <20260327130431.59481-5-tzimmermann@suse.de>
 <CAMuHMdX1vUuKq-Q1-zA5tC5+LWap4osFJMqQ5pRJ373z++KQLQ@mail.gmail.com>
 <a2b5aa02-2566-409f-960d-4ecb1419cbd5@suse.de>
 <7eaf55fd-1ec9-4c30-877f-12961e8f9532@kernel.org>
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
In-Reply-To: <7eaf55fd-1ec9-4c30-877f-12961e8f9532@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FREEMAIL_ENVRCPT(0.00)[gmx.de];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmx.de,linuxfoundation.org,ffwll.ch,ravnborg.org,vger.kernel.org,lists.freedesktop.org];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:url]
X-Rspamd-Queue-Id: 762744D2B6
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spam-Level: 

Hi

Am 01.04.26 um 10:58 schrieb Jiri Slaby:
> On 01. 04. 26, 9:58, Thomas Zimmermann wrote:
>>>> -font-objs-$(CONFIG_FONT_SUN8x16)   += font_sun8x16.o
>>>> -font-objs-$(CONFIG_FONT_SUN12x22)  += font_sun12x22.o
>>>> -font-objs-$(CONFIG_FONT_8x8)       += font_8x8.o
>>>> -font-objs-$(CONFIG_FONT_8x16)      += font_8x16.o
>>>> -font-objs-$(CONFIG_FONT_6x11)      += font_6x11.o
>>>> -font-objs-$(CONFIG_FONT_7x14)      += font_7x14.o
>>>> -font-objs-$(CONFIG_FONT_10x18)     += font_10x18.o
>>>> -font-objs-$(CONFIG_FONT_PEARL_8x8) += font_pearl_8x8.o
>>>> -font-objs-$(CONFIG_FONT_ACORN_8x8) += font_acorn_8x8.o
>>>> -font-objs-$(CONFIG_FONT_MINI_4x6)  += font_mini_4x6.o
>>>> -font-objs-$(CONFIG_FONT_6x10)      += font_6x10.o
>>>> -font-objs-$(CONFIG_FONT_TER10x18)  += font_ter10x18.o
>>>> -font-objs-$(CONFIG_FONT_TER16x32)  += font_ter16x32.o
>>>> -font-objs-$(CONFIG_FONT_6x8)       += font_6x8.o
>>>> +# Built-in fonts
>>>> +font-$(CONFIG_FONT_10x18)     += font_10x18.o
>>>> +font-$(CONFIG_FONT_6x10)      += font_6x10.o
>>>> +font-$(CONFIG_FONT_6x11)      += font_6x11.o
>>>> +font-$(CONFIG_FONT_6x8)       += font_6x8.o
>>>> +font-$(CONFIG_FONT_7x14)      += font_7x14.o
>>>> +font-$(CONFIG_FONT_8x16)      += font_8x16.o
>>>> +font-$(CONFIG_FONT_8x8)       += font_8x8.o
>>> Please sort the anonymous entries by increasing font size.
>>
>> Makes sense. I'll also leave a comment on the sorting order.
>
>>>> +font-$(CONFIG_FONT_SUN12x22)  += font_sun12x22.o
>>>> +font-$(CONFIG_FONT_SUN8x16)   += font_sun8x16.o
>
> I'd sort even the non-anonymous ^^.

My plan is now to sort by font-family, then by font height, then by font 
width. Each in ascending order.

Best regards
Thomas

>
> thanks,

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)


