Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793000484;
	b=2Gc2mss2GRMSeUIy0SUQ72Vubln0rP6UtRYy7isl8T8CtYb3HgCcjF6dO1PrFAVslMCF
	 Lk2cxp9nHWGNFJmAyA7PSRRlHsIA/sKIl5seizRNaW0M6U1Hld+Pz21CdrMmsUHiK/eK/
	 8fM4IXjUuHC8S7S7fATmrvdWVFHhc5SMPNHz7a9K67AV1PNU8fkD4bAaVhVPT5vbpG7qk
	 Nfn/o3Bxqt9NMGFE+YIvb0LnPC8pBnG/4hqlMv8T7s4JQgX1e3uFZySOP02W25ATIl1Gi
	 nKiM3eOJoKsmfiuYKz18c7ijLCM/QXPfGi8uJ6W4c7kfncy2EPiZv1XBDvlF9utnLPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793000484;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:Autocrypt:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Spamd-Result:
	 X-Spam-Score:X-Spam-Level:X-Spam-Flag;
	bh=sWrkcP/yBVW3JGHMD8FsWZTL1fQHiKFs8LimUVOooqU=;
	b=xqST7GMV15ii+0jtc2UMllMZenVHAIH5MaDy9eZFc5AnFZOmt3m1j+zCvSed9S7thHhR
	 56ecJV4AuL6b1xONE6V0OnetjF1GvaeONMReENPleHBjzkV0iBp/nEtzMZ3rbwfNbA8Af
	 c2K5UDqT5V1sTMAtD2hql6Jqn72XLcHlbmDlRip1cTe4XKyq6UTCGDn2IHBUY5AzmEOYn
	 PxGD7YEZWY2c8yj+jDauCRJ4NrzaAWedDMdtXGlDRT74Tah8vX6Nz+W2psc+496l2e6sZ
	 faL5J/TEUkHw97oQjI0Pyh3cfH/ZllY36peIvAkyyLSGrh+yVT3y7gXrG/cvmjbhCBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=IMSjQOaC;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=FedeyjtJ;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=IMSjQOaC;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=FedeyjtJ;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB12606A321;
	Mon, 26 Oct 2026 07:41:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CBB12606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=IMSjQOaC;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=FedeyjtJ;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=IMSjQOaC;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=FedeyjtJ
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0FF47222C7;
	Mon, 26 Oct 2026 07:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793000482; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=sWrkcP/yBVW3JGHMD8FsWZTL1fQHiKFs8LimUVOooqU=;
	b=IMSjQOaCYWrZu7o5oVeTyU5bR+QO2aHnpndiTERI5WvKhqz750d5ghV49LPUysNNNTkC9h
	0zAl5CtbyfEov4yIlVzmrfTc2ykbkwfbaYGf1ExI9csxqZKV/TXReZztxrbvbw8xI43yLz
	eF4XcUzEWGDs4UbBJFUgDeFyWlakNNg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793000482;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=sWrkcP/yBVW3JGHMD8FsWZTL1fQHiKFs8LimUVOooqU=;
	b=FedeyjtJmYr8yfqpxxZ7nqWPJCLWdfeDsrXcaVNhFTgOWJQTS7/yvJss8Yb3TZmacB+Gny
	HxldMtmc75DcbzBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793000482; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=sWrkcP/yBVW3JGHMD8FsWZTL1fQHiKFs8LimUVOooqU=;
	b=IMSjQOaCYWrZu7o5oVeTyU5bR+QO2aHnpndiTERI5WvKhqz750d5ghV49LPUysNNNTkC9h
	0zAl5CtbyfEov4yIlVzmrfTc2ykbkwfbaYGf1ExI9csxqZKV/TXReZztxrbvbw8xI43yLz
	eF4XcUzEWGDs4UbBJFUgDeFyWlakNNg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793000482;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=sWrkcP/yBVW3JGHMD8FsWZTL1fQHiKFs8LimUVOooqU=;
	b=FedeyjtJmYr8yfqpxxZ7nqWPJCLWdfeDsrXcaVNhFTgOWJQTS7/yvJss8Yb3TZmacB+Gny
	HxldMtmc75DcbzBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A324F13319;
	Mon, 26 Oct 2026 07:41:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MKHHESEE32qkBgAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Mon, 26 Oct 2026 07:41:21 +0000
Message-ID: <4baeea95-1628-485e-bee7-925849a867d2@suse.de>
Date: Mon, 26 Oct 2026 08:41:20 +0100
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/7] vt: Remove old-style con_blank
To: Helge Deller <deller@gmx.de>, Greg KH <gregkh@linuxfoundation.org>
Cc: jirislaby@kernel.org, James.Bottomley@hansenpartnership.com,
 simona@ffwll.ch, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 linux-fbdev@vger.kernel.org, linux-parisc@vger.kernel.org,
 sashiko-reviews@lists.linux.dev
References: <20261023132448.115747-1-tzimmermann@suse.de>
 <20261023132448.115747-8-tzimmermann@suse.de>
 <2026102312-chute-proud-204a@gregkh>
 <68342b92-0e12-4aa1-a215-efb623418696@gmx.de>
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
In-Reply-To: <68342b92-0e12-4aa1-a215-efb623418696@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-13.29 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_TO(0.00)[gmx.de,linuxfoundation.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmx.de];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:url]
X-Spam-Score: -13.29
X-Spam-Level: 
X-Spam-Flag: NO

Hi

Am 25.10.26 um 08:48 schrieb Helge Deller:
> On 10/23/26 15:37, Greg KH wrote:
>> On Fri, Oct 23, 2026 at 03:16:17PM +0200, Thomas Zimmermann wrote:
>>> All consoles implement the new con_blank plus con_unblank. Remove
>>> the old semantics from con_blank. Always pass a VESA blank mode to
>>> the blank parameter.
>>>
>>> v3:
>>> - keep con_blank's mode_switch parameter
>>
>> Shouldn't the "v3:" stuff go below the --- line?

Force of habit. Putting the change log in the commit description is 
common for DRM patches.

I'll do better next time.


> Series applied to fbdev git tree.
> While at it, I dropped the v3: stuff lines, so no need to resend.

Thanks Helge.

Best regards
Thomas

>
> Helge

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Stefan Gaiser, Jochen Jaser, Abhinav Puri, (HRB 36809, AG Nürnberg)


