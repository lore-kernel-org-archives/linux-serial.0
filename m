Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D235B3890EE
	for <linux-serial@vger.kernel.org>; Wed,  1 Apr 2026 07:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775030304; cv=none; b=bH3tnay7bKykxreTx6fyeOp9zlEsccbCcB1MwND7oqOJ8m1mmYXHc0MEvDQmGI89pgovPL4kzcyFcOPF0c74ujPdk+Tf0eFWN9jC7IM6DktoNDV3G2VonY1NPspp1qzrJpHNCuxnCTCL1NG/HNFm/BDT95ae/BPfD+d2XSBbXm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775030304; c=relaxed/simple;
	bh=qt1wiBa9PA/qELDqb0nEx0VBBeyEclm+TzLimwabG8g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gOPS3KzxRyrryB4ibM8YtQWDu8oXmVF6u64O6oN+0sUVttRZznAsOz4z41shTR288mJgtYD1TIARSDaMDfYYJyxNt5ZN3YFShVxunErkXMymuguP347xLvUGamB3geAOkgVvVl5RAFHZRVEeIjiu9d5B9k3Zrjmp96Jthz38T8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=1u3371jQ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=YmAbCiY7; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=1u3371jQ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=YmAbCiY7; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1u3371jQ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="YmAbCiY7";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1u3371jQ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="YmAbCiY7"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 322AD5BD4E;
	Wed,  1 Apr 2026 07:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1775030301; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=GUbCXixotbLJQvKhnmalg+wDZ35b+WqTf1PV/5s4pQY=;
	b=1u3371jQTR3AJaG5fpgatzyLFS7tio30mVNMoihZL1cu92WBcsucabuSZcuFi+rGjjZiuQ
	RdfMHnx+AViGqFrVVEnmWCofnGAWaqUgk0zFuQ96ppciIba8RxpvBVTXhCIq85Fth2tQdt
	F9cyQji9OUxbbl55B1yI16wjdfXZwko=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1775030301;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=GUbCXixotbLJQvKhnmalg+wDZ35b+WqTf1PV/5s4pQY=;
	b=YmAbCiY7IJxSY1jWCNXdDCQRJKKsIc38fZXjiSiQ3J+66zKuqg//PuZs6TwxzNvvSkkbFd
	9sNsSd+KoTHUVfDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1775030301; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=GUbCXixotbLJQvKhnmalg+wDZ35b+WqTf1PV/5s4pQY=;
	b=1u3371jQTR3AJaG5fpgatzyLFS7tio30mVNMoihZL1cu92WBcsucabuSZcuFi+rGjjZiuQ
	RdfMHnx+AViGqFrVVEnmWCofnGAWaqUgk0zFuQ96ppciIba8RxpvBVTXhCIq85Fth2tQdt
	F9cyQji9OUxbbl55B1yI16wjdfXZwko=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1775030301;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=GUbCXixotbLJQvKhnmalg+wDZ35b+WqTf1PV/5s4pQY=;
	b=YmAbCiY7IJxSY1jWCNXdDCQRJKKsIc38fZXjiSiQ3J+66zKuqg//PuZs6TwxzNvvSkkbFd
	9sNsSd+KoTHUVfDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E8A7C4A0B0;
	Wed,  1 Apr 2026 07:58:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mLGbNxzQzGk2ZgAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Wed, 01 Apr 2026 07:58:20 +0000
Message-ID: <a2b5aa02-2566-409f-960d-4ecb1419cbd5@suse.de>
Date: Wed, 1 Apr 2026 09:58:20 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/10] lib/fonts: Clean up Makefile
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: deller@gmx.de, gregkh@linuxfoundation.org, jirislaby@kernel.org,
 simona@ffwll.ch, sam@ravnborg.org, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org
References: <20260327130431.59481-1-tzimmermann@suse.de>
 <20260327130431.59481-5-tzimmermann@suse.de>
 <CAMuHMdX1vUuKq-Q1-zA5tC5+LWap4osFJMqQ5pRJ373z++KQLQ@mail.gmail.com>
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
In-Reply-To: <CAMuHMdX1vUuKq-Q1-zA5tC5+LWap4osFJMqQ5pRJ373z++KQLQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: -4.30
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_CC(0.00)[gmx.de,linuxfoundation.org,kernel.org,ffwll.ch,ravnborg.org,vger.kernel.org,lists.freedesktop.org];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmx.de];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:url,suse.de:mid,suse.de:email]
X-Spam-Flag: NO

Hi

Am 01.04.26 um 09:48 schrieb Geert Uytterhoeven:
> Hi Thomas,
>
> On Fri, 27 Mar 2026 at 14:05, Thomas Zimmermann <tzimmermann@suse.de> wrote:
>> Simplify the Makefile. Drop font-obj-y and sort the fonts by dictionary
>> order. Done in preparation for supporting optional font rotation.
>>
>> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Thanks for your patch, which is now commit 3f90ea78f5fe9495
> ("lib/fonts: Clean up Makefile") in fbdev/for-next.
>
>> --- a/lib/fonts/Makefile
>> +++ b/lib/fonts/Makefile
>> @@ -1,23 +1,22 @@
>>   # SPDX-License-Identifier: GPL-2.0
>>   # Font handling
>>
>> -font-objs := fonts.o
>> +font-y := fonts.o
>>
>> -font-objs-$(CONFIG_FONT_SUN8x16)   += font_sun8x16.o
>> -font-objs-$(CONFIG_FONT_SUN12x22)  += font_sun12x22.o
>> -font-objs-$(CONFIG_FONT_8x8)       += font_8x8.o
>> -font-objs-$(CONFIG_FONT_8x16)      += font_8x16.o
>> -font-objs-$(CONFIG_FONT_6x11)      += font_6x11.o
>> -font-objs-$(CONFIG_FONT_7x14)      += font_7x14.o
>> -font-objs-$(CONFIG_FONT_10x18)     += font_10x18.o
>> -font-objs-$(CONFIG_FONT_PEARL_8x8) += font_pearl_8x8.o
>> -font-objs-$(CONFIG_FONT_ACORN_8x8) += font_acorn_8x8.o
>> -font-objs-$(CONFIG_FONT_MINI_4x6)  += font_mini_4x6.o
>> -font-objs-$(CONFIG_FONT_6x10)      += font_6x10.o
>> -font-objs-$(CONFIG_FONT_TER10x18)  += font_ter10x18.o
>> -font-objs-$(CONFIG_FONT_TER16x32)  += font_ter16x32.o
>> -font-objs-$(CONFIG_FONT_6x8)       += font_6x8.o
>> +# Built-in fonts
>> +font-$(CONFIG_FONT_10x18)     += font_10x18.o
>> +font-$(CONFIG_FONT_6x10)      += font_6x10.o
>> +font-$(CONFIG_FONT_6x11)      += font_6x11.o
>> +font-$(CONFIG_FONT_6x8)       += font_6x8.o
>> +font-$(CONFIG_FONT_7x14)      += font_7x14.o
>> +font-$(CONFIG_FONT_8x16)      += font_8x16.o
>> +font-$(CONFIG_FONT_8x8)       += font_8x8.o
> Please sort the anonymous entries by increasing font size.

Makes sense. I'll also leave a comment on the sorting order.

Best regards
Thomas

>
>> +font-$(CONFIG_FONT_ACORN_8x8) += font_acorn_8x8.o
>> +font-$(CONFIG_FONT_MINI_4x6)  += font_mini_4x6.o
>> +font-$(CONFIG_FONT_PEARL_8x8) += font_pearl_8x8.o
>> +font-$(CONFIG_FONT_SUN12x22)  += font_sun12x22.o
>> +font-$(CONFIG_FONT_SUN8x16)   += font_sun8x16.o
>> +font-$(CONFIG_FONT_TER10x18)  += font_ter10x18.o
>> +font-$(CONFIG_FONT_TER16x32)  += font_ter16x32.o
>>
>> -font-objs += $(font-objs-y)
>> -
>> -obj-$(CONFIG_FONT_SUPPORT)         += font.o
>> +obj-$(CONFIG_FONT_SUPPORT) += font.o
> Gr{oetje,eeting}s,
>
>                          Geert
>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)


