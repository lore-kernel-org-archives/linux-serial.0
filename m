Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6B24035CD
	for <linux-serial@vger.kernel.org>; Tue, 31 Mar 2026 15:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774970976; cv=none; b=PnG84ZGLNPhGf+VRzOlrJ7hq/cGx4bS8AHajnk/Nr5SwIC5a75crZw/jgHA8G33TtDu3nNqsRz9llqfLO/5BUVBzlnrVmiM+Ps/L3f6pQHnbZ/xLvjaL8Mcbn2QWXe3yz5WuI+/nlU+2Y3N2BohGzW3/+EpYP4AH6kUoLiDSkWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774970976; c=relaxed/simple;
	bh=h6gg5rmmiDDY3PMfEnrLPhHLFUeU77Ypk93onGGgun4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eG11ulzQNOtzhcbQvU6Ql90Q/5DZL58buVSudGxquhE3PohuyLHxUubTNWvhXoDlS0Z2fi41OewUz279S85ehwXzmEFXQO1SVD2ccF0uiSvbKQ9boJ4zMXFaJ4LtL84WOQNv3lXpQG9LNDz/P+cMqFF499txMivjiToTro1HcbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=rKlZOLIQ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=85WjaiIs; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=rKlZOLIQ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=85WjaiIs; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="rKlZOLIQ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="85WjaiIs";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="rKlZOLIQ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="85WjaiIs"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7A0474D284;
	Tue, 31 Mar 2026 15:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1774970971; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=6Y6e434JgzvENBkxqRYIvDtLicskkjZx/jSS6iqhEsM=;
	b=rKlZOLIQvtYgg1BsUXjRQ3VSMGRs175D8LtJS1eFUhPWYFq6yaKO7sl4NPuaLsLquO9sDh
	5uaCnWZrb8nioWKbXHexzTv9Iq0nwj1HI1lWhEOnKWRxjg1c99FUdWs52azo+PmoaSXFJ0
	OFvSXzr+xbca/Hy0CnCyh0AzQIMzf/s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1774970971;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=6Y6e434JgzvENBkxqRYIvDtLicskkjZx/jSS6iqhEsM=;
	b=85WjaiIsjm4X+q8zqpgio1ggtJZ0qPO6zxdy47Hgj4mn+Jx2icb0hmNlmdpkyXODbS0KRY
	Vp+jQCNknJFqNhDQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=rKlZOLIQ;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=85WjaiIs
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1774970971; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=6Y6e434JgzvENBkxqRYIvDtLicskkjZx/jSS6iqhEsM=;
	b=rKlZOLIQvtYgg1BsUXjRQ3VSMGRs175D8LtJS1eFUhPWYFq6yaKO7sl4NPuaLsLquO9sDh
	5uaCnWZrb8nioWKbXHexzTv9Iq0nwj1HI1lWhEOnKWRxjg1c99FUdWs52azo+PmoaSXFJ0
	OFvSXzr+xbca/Hy0CnCyh0AzQIMzf/s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1774970971;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=6Y6e434JgzvENBkxqRYIvDtLicskkjZx/jSS6iqhEsM=;
	b=85WjaiIsjm4X+q8zqpgio1ggtJZ0qPO6zxdy47Hgj4mn+Jx2icb0hmNlmdpkyXODbS0KRY
	Vp+jQCNknJFqNhDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3F76C4A0B0;
	Tue, 31 Mar 2026 15:29:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id TL1MDlvoy2naWQAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Tue, 31 Mar 2026 15:29:31 +0000
Message-ID: <87849268-89f9-4522-8472-af6840747266@suse.de>
Date: Tue, 31 Mar 2026 17:29:30 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/10] fbcon,fonts: Refactor framebuffer console rotation
To: Helge Deller <deller@gmx.de>, gregkh@linuxfoundation.org,
 jirislaby@kernel.org, simona@ffwll.ch, sam@ravnborg.org
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
References: <20260327130431.59481-1-tzimmermann@suse.de>
 <7c963dce-7b39-4047-b0bb-548957852d65@gmx.de>
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
In-Reply-To: <7c963dce-7b39-4047-b0bb-548957852d65@gmx.de>
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
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmx.de];
	FREEMAIL_TO(0.00)[gmx.de,linuxfoundation.org,kernel.org,ffwll.ch,ravnborg.org];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MID_RHS_MATCH_FROM(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:url,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:mid]
X-Rspamd-Queue-Id: 7A0474D284
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spam-Level: 

Hi

Am 31.03.26 um 17:08 schrieb Helge Deller:
> Hi Thomas,
>
> On 3/27/26 13:49, Thomas Zimmermann wrote:
>> Refactor the framebuffer console rotation into individual components
>> for glyphs, fonts and the overall fbcon state. Right now this is mixed
>> up in fbcon_rotate.{c,h}. Also build cursor rotation on top of the new
>> interfaces.
>>
>> Start with an OOB fix in patch 1. If buffer allocation fails, fbcon
>> currently uses a too-small glyph buffer for output. Avoid that.
>>
>> Patches 2 to 4 make a number of small improvements to the font library
>> and its callers.
>>
>> Patches 5 to 8 refactor the font rotation. Fbcon rotation rotates each
>> individual glphy in a font buffer and uses the rotated buffer's glyphs
>> for output. The result looks like the console buffer has been rotated
>> as a whole. Split this into helpers that rotate individual glyphs and
>> a helper that rotates the font buffer of these. Then reimplement fbcon
>> rotation on top. Document the public font helpers.
>>
>> Patch 9 rebuilds cursor rotation on top of the new glyph helpers. The
>> fbcon cursor is itself a glyph that has to be rotated in sync with the
>> font.
>>
>> Patch 10 moves the state of fbcon rotation into a single place and makes
>> is a build-time conditional.
>>
>> Tested with fbcon under bochs on Qemu.
>>
>> Built upon the fbcon changes at [1].
>>
>> [1] 
>> https://lore.kernel.org/linux-fbdev/20260309141723.137364-1-tzimmermann@suse.de/
>
>
> Thanks a lot for this cleanup work!
>
> I've applied this series to the fbdev git tree.

Thanks a lot.

There's a small typo in patch 2 that I noticed when Greg gave his ack. 
The commit description say <liux/math.h> instead of <linux/math.h>.  Let 
me know whether you can fix it or if I should send an update.

Best regards
Thomas

>
> Helge
>
>
>> Thomas Zimmermann (10):
>>    fbcon: Avoid OOB font access if console rotation fails
>>    vt: Implement helpers for struct vc_font in source file
>>    lib/fonts: Provide helpers for calculating glyph pitch and size
>>    lib/fonts: Clean up Makefile
>>    lib/fonts: Implement glyph rotation
>>    lib/fonts: Refactor glyph-pattern helpers
>>    lib/fonts: Refactor glyph-rotation helpers
>>    lib/fonts: Implement font rotation
>>    fbcon: Fill cursor mask in helper function
>>    fbcon: Put font-rotation state into separate struct
>>
>>   drivers/tty/vt/vt.c                     |  34 +++
>>   drivers/video/fbdev/core/bitblit.c      |  35 +--
>>   drivers/video/fbdev/core/fbcon.c        |  48 ++++-
>>   drivers/video/fbdev/core/fbcon.h        |  14 +-
>>   drivers/video/fbdev/core/fbcon_ccw.c    |  70 ++----
>>   drivers/video/fbdev/core/fbcon_cw.c     |  70 ++----
>>   drivers/video/fbdev/core/fbcon_rotate.c |  88 ++------
>>   drivers/video/fbdev/core/fbcon_rotate.h |  71 ------
>>   drivers/video/fbdev/core/fbcon_ud.c     |  67 ++----
>>   include/linux/console_struct.h          |  30 +--
>>   include/linux/font.h                    |  51 +++++
>>   lib/fonts/Makefile                      |  36 ++--
>>   lib/fonts/font_rotate.c                 | 275 ++++++++++++++++++++++++
>>   lib/fonts/fonts.c                       |   2 +-
>>   14 files changed, 525 insertions(+), 366 deletions(-)
>>   create mode 100644 lib/fonts/font_rotate.c
>>
>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)


