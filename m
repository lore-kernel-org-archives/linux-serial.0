Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16213C1F;
	Mon, 31 Aug 2026 06:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788157223; cv=none; b=fDY+XWqRw+15HdAZdR+SVaoXhQGiSPE2yFCp8AjrIJehT+eFjBBdYqBZPCaxS0dvRfAnRZx+MT2UmJ3viBxbFxRamncwxpmpiQTLpRdqJ/cW1xuUXY6HliOuzv+GzzsBCUG/PGk+H7k6AOHWSl2nMAqsvDc0k3X4U4fzDgyc7NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788157223; c=relaxed/simple;
	bh=ej00dXDU46bYPXgKOioeidpY1fO7JmH66JARiZrVfE0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kk499dUV8kHjmh8xhUmBvR8/Cg/UlGrptULNo66epI0sG2i0hXwiSpdSK3KzTPxemVMhZeERj7HxuczDxKPrE6lqeVLbbJWLHODFiF4f4k0atE6piUg6DMNqZGRNKn1OGdx5FAJ+dgx4LJAppC+U5pH2ph/S88FqEGvcrxgwrPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=AB/OO+9g; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=IQpbaJfN; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=oBG9okBu; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=sKwWh8C8; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="AB/OO+9g";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="IQpbaJfN";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="oBG9okBu";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="sKwWh8C8"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 94B971FA93;
	Mon, 31 Aug 2026 06:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1788157215; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=yM/zUL9msvAyF7E5D434ycxCIIRdt7kTGC7qE/4iBvU=;
	b=AB/OO+9g/9ldxE94J4XjsEaUGA7fINlxTtoi5TsILt1SMmW7dcULtFKeMMKLC7WI7LUP1r
	4SZaH6ZcS1R9S+Wv1CWABaiRtYngK7bl6p3s1QM+CWW20TUyltYe69xrG/4GaMHAtRQpz5
	8XXSz2INXrGMFh/fmcBUr02SR8+F8z8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1788157215;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=yM/zUL9msvAyF7E5D434ycxCIIRdt7kTGC7qE/4iBvU=;
	b=IQpbaJfNA7HYu9DaixuwQRzgf3pVKA4otx64ClhEq5W7VOvs8+VpflTNnqfx546R9L9gbI
	s8rZQJwKlOMzG9AA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1788157211; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=yM/zUL9msvAyF7E5D434ycxCIIRdt7kTGC7qE/4iBvU=;
	b=oBG9okBut5gnZwGvMdBRsVcnk74TSVSM1pZdv/2vw/IpgiO7VXitD601zjWgnrbswbARN+
	rsZ4rXV/hCDyHAbI5w+EUX7eB0B4CjSaib2YofZVx1dVAodMLhSNoXMX+HvWWzvF0SGJBD
	M3gT9MmyokiSWqmLmae3WokGpdvOhCM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1788157211;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=yM/zUL9msvAyF7E5D434ycxCIIRdt7kTGC7qE/4iBvU=;
	b=sKwWh8C8RBIrjzQNwR+1tkhDfdZ36Um1OeHl22V38dtuFb4ZGDoz/6D3xn1s2tslX93dn1
	IxNoOnyLZ4cPAvBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1E5EE13515;
	Mon, 31 Aug 2026 06:20:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CVmwBRsdlWo8FAAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Mon, 31 Aug 2026 06:20:11 +0000
Message-ID: <7c199c7f-d89b-48ca-a777-85585d2eb624@suse.de>
Date: Mon, 31 Aug 2026 08:20:10 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: vt: Enlarge the framebuffer glyph size from 16 to 32 bits
To: Alan Mackenzie <acm@muc.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>, Simona Vetter <simona@ffwll.ch>,
 linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
 Helge Deller <deller@gmx.de>, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org
References: <apCEDM2sWv_M354-@MAC.fritz.box>
 <145be2e3-a8c0-4f4f-a701-af2696cec461@suse.de>
 <apGc4y8ApYWh4Yr4@MAC.fritz.box> <2026082938-spray-shimmer-9389@gregkh>
 <apLvO-8YJmQG7T0Z@MAC.fritz.box>
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
In-Reply-To: <apLvO-8YJmQG7T0Z@MAC.fritz.box>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: -4.30
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmx.de];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,ffwll.ch,vger.kernel.org,gmx.de,lists.freedesktop.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:url,suse.de:mid]
X-Spam-Flag: NO

Hi

Am 29.08.26 um 16:39 schrieb Alan Mackenzie:
[...]
>> This has nothing to do with KDE or Gnome, if you have issues with those
>> projects, please take it up with them and contribute to them to resolve
>> those issues.  I know they can always use the help.
> My point is that the kernel's console is rock solid and dependable.

That is a bold statement.  I've spend the last years working on related 
code (fbcon) and it mostly feels dated and unmaintained. Our prime 
implementation (again fbcon) has been de-facto unmaintained for years. 
We recently had contributors who are pushing the ioctls semantics and 
found bugs in fbcon for a number of corner cases.


> Things like kmscon are subject to the vagaries of fashion.
>
>>> As is clear, I think the console's limitations should be eliminated.
>> And the rest of us feel the kernel console's code should be eliminated
>> entirely, when ever possible :)
> The rest of you don't appear to be console users.  It's easy to advocate
> for removal when you don't use it yourself.

FTR I'm not at all interested in eliminating the kernel's console. But 
there are must-have features and nice-to-have features. IMHO for the 
kernel console i18n really belongs in the later category.

Best regards
Thomas


>
>> thanks,
>> greg k-h

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, (HRB 36809, AG Nürnberg)


