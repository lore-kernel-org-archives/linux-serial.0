Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 874CA490BF8;
	Wed, 23 Sep 2026 13:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790170217; cv=none; b=hQgt2e3lwOWHTJHKlWpNr9TaZfVj4fccB2bklR+HD3ptZH9sCXs8VVkCN39CbfZ8tTbH6X/RcSBbN+o2hxkblw41iXpL0+ur3Whf7W7oCBKjc4/jjkK4lLtnA5pna4EEXknk59WwmjP2UjlDX8ichHxH7Gh8yb2E9S9NYENJM+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790170217; c=relaxed/simple;
	bh=p7cWrz6rn5SogIHVI+ZJpKP8PBqIMdGUotO0FpW/XGE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZA3qq9MmKfnMuWY3BRy/Si5zX4X1w8PxBR5kjmz8dJLnCLkJZAMPgCyR/kbN6om1Zcn/6Ba/txPgP89PGWPvoL9Tw1svPBuQyuXqGL1i13E248VFPqcuY96w465bgkxIJk4xsehl3NyIgD9AFKyfIzWZlhJzNsTdNm5QfKNRLII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Nky7tt5q; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=kDgfB1G1; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=rekdm16k; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=d/nk7Ka7; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Nky7tt5q";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="kDgfB1G1";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="rekdm16k";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="d/nk7Ka7"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3DC9D21D79;
	Wed, 23 Sep 2026 13:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1790170209; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=3Hq0v5VBFDF3TXbxclB5+CyIeTc5tQ4PQXj7ReNQkIE=;
	b=Nky7tt5qMtEactjLDeJY9MgD+mpavC4FaPqT5HpNV/H67RWWnZZu6RpwH6HbubV/1+sIfY
	zg5P4HZMOVibeeX5k5KPaCmNqS30JgacmJ5zYHp58pS80k1Eu+Z3HldbfjlfjDByLfBVPh
	IFsOR4a7rZZzSMJTrKHDwHa/whJzMEc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790170209;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=3Hq0v5VBFDF3TXbxclB5+CyIeTc5tQ4PQXj7ReNQkIE=;
	b=kDgfB1G1P1PL8fbSZjw+2Uc3QNQt/sCcM4ogSQhiBJrMHIpvIZ5Ni8xbdHWzdhbjfElkjf
	34CDgrPYdS4oeeCQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=rekdm16k;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="d/nk7Ka7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1790170205; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=3Hq0v5VBFDF3TXbxclB5+CyIeTc5tQ4PQXj7ReNQkIE=;
	b=rekdm16k3Ii9UHugUzrj25XDtseZeAPhgSHzI2niHNsjlIrDPtqY0pMZSRcUXtSwW6HINU
	AiIOaLR8LNVl71/l2Tms68fCaR9jXbN4NLimfoBDhupL8gXyqKdWliEI4/OI9nU1qvpevQ
	nmi6izQLUTwnu3F6mcK4RJyEq94JJnw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790170205;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=3Hq0v5VBFDF3TXbxclB5+CyIeTc5tQ4PQXj7ReNQkIE=;
	b=d/nk7Ka7gbDf1WCMCamnHndFpIt6NgkprWOjSiH9HxGaJjZHFOEf2NBKz59tSw1Yb7hugZ
	s1emSLygQlBGMXCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D3DF5134E8;
	Wed, 23 Sep 2026 13:30:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mEsmKlzUs2qZKAAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Wed, 23 Sep 2026 13:30:04 +0000
Message-ID: <24cf3f9b-bc81-4f55-8ae2-416a2c46b881@suse.de>
Date: Wed, 23 Sep 2026 15:30:04 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] vt: Add cursor-size helpers
To: Greg KH <gregkh@linuxfoundation.org>
Cc: deller@gmx.de, jirislaby@kernel.org, simona@ffwll.ch,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-serial@vger.kernel.org, sashiko-reviews@lists.linux.dev
References: <20260915123304.1027277-1-tzimmermann@suse.de>
 <20260915123304.1027277-2-tzimmermann@suse.de>
 <2026092347-try-railroad-7b00@gregkh>
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
In-Reply-To: <2026092347-try-railroad-7b00@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: -4.51
X-Rspamd-Queue-Id: 3DC9D21D79
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
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmx.de];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmx.de,kernel.org,ffwll.ch,vger.kernel.org,lists.freedesktop.org,lists.linux.dev];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:mid,suse.com:url];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Flag: NO

Hi

Am 23.09.26 um 14:57 schrieb Greg KH:
[...]
>> + * Returns:
>> + * The index of the cursor's first scanline within the character cell
>> + */
>> +unsigned int vc_cursor_start(unsigned int cell_height, unsigned int cursor_size)
>> +{
>> +	const unsigned int cursor_default_size = CUR_SIZE(READ_ONCE(cur_default));
>> +
>> +retry:
>> +	switch (cursor_size) {
>> +	case CUR_NONE:
>> +		return cell_height;
>> +	case CUR_UNDERLINE:
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
>> +	default:
>> +		pr_warn_once("Unknown cursor %u\n", cursor_size);
> Can userspace trigger this?  If not, who can?

Yes. There's the "vt.cur_default" parameter on the kernel's command line 
[1], and apparently there's some escape sequence. [2]  The cursor size 
is the lowest 4 bits of that value, while

[1] https://elixir.bootlin.com/linux/v7.2.6/source/drivers/tty/vt/vt.c#L167
[2] https://elixir.bootlin.com/linux/v7.2.6/source/drivers/tty/vt/vt.c#L2523

Apart from that, I just noticed that this switch should certainly handle 
CUR_DEF without printing a warning.


>
>> +		if (cursor_size != cursor_default_size)
>> +			cursor_size = cursor_default_size;
>> +		else
>> +			cursor_size = CUR_UNDERLINE;
> Why underline as a default?

This has been the default all along. It is the default value of the 
cur_default parameter and picked up by vt when starting up a console. 
[3] VGA BIOSes tend to default to underline as well AFAICT. Only the old 
cursor code in fbcon falls back to full-size blocks if nothing else 
works. Using underline harmonizes behavior across components.

[3] https://elixir.bootlin.com/linux/v7.2.6/source/drivers/tty/vt/vt.c#L2297

Best regards
Thomas

>
> thanks,
>
> greg k-h

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Stefan Gaiser, Jochen Jaser, Abhinav Puri, (HRB 36809, AG Nürnberg)


