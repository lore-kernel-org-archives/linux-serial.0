Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2ECC3C7696;
	Fri, 28 Aug 2026 06:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787897550; cv=none; b=mA1Agn8wOn2kSz+VIqZarKSN7GOOiS5G+J1nYgjWcVZcy2cUyJLbgen2aH2/QGv/vs29FrCjfE9FJyOxNEvpaAsF4BxDTYkQ6f3d/Sja1BDKb1+sILQFOrfb2VLgxHFtlNZtBRu3lIkFulIGubl3qAD2S3qgeGwFApQSEaYivl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787897550; c=relaxed/simple;
	bh=4NOQl6WUldbvXMXZJgOK3BZRXaHzlKhXuueqQHr7Wlk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=FbATaCaqWoaZDKwhycKQX7kPcKpW0uAUiKZXJsGIxOZorZMwJ04/HT64XVEI1974BgD1UWWICBZc6vbgNsBIstsQQx8icos1wx4WiqmMQBIt4OWF7WnmprLHw3LCCBev76bCG+G6xCAOXuk94d1Uqargp6BtAQcr0wKmjHy9+bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=qtCxUTXx; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=CslFLiOa; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=bJAyS/ua; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=HfIx40kz; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qtCxUTXx";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="CslFLiOa";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="bJAyS/ua";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="HfIx40kz"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 11CB721F11;
	Fri, 28 Aug 2026 06:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1787897541; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=I4dSBMGwcIerf9j1CQ0qBd6QBhr5hUlvM77P4+2Q0Xg=;
	b=qtCxUTXxEY2lq5ThlUnSaODL+owJqT9fOttUIgafKqicEUo3VcqL+Xivcsu+J0CSs9AaqH
	OUqtCYTiwk7q2tP7AYgKbZ/GWpKO2Whbkw5WCzn1fvWvGcle1R8uFoohIbSRbfhd+SNJ1n
	6J1hOWbKzQ+BwkBq2lTvMzrfd+JsUsI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1787897541;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=I4dSBMGwcIerf9j1CQ0qBd6QBhr5hUlvM77P4+2Q0Xg=;
	b=CslFLiOaGTJ08ROpwdsGSa2vK73Xqlrom/B4FdE9E9MWireAMZ6ADqvWDv3QAekYiU5w7x
	uO20oGl68DOyVZAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1787897537; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=I4dSBMGwcIerf9j1CQ0qBd6QBhr5hUlvM77P4+2Q0Xg=;
	b=bJAyS/uaqCQewxBrARaVg/m9xeWkfNrb5QKjdJeiRFwGbVn1o+fXQxexLxr+bnJHbrgR2z
	JRJtJi+QGtcUIipqg26oEFjq3ptlzHKf0kfFr1uQDL47hjKZomklT4DM38rOR5yYZH+ldK
	fn4t2UOEgl6O1H4UPVmJBGOWFQ/vgGw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1787897537;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=I4dSBMGwcIerf9j1CQ0qBd6QBhr5hUlvM77P4+2Q0Xg=;
	b=HfIx40kzT4Cbi2xk9xi2zF4fsLa0fQkEXkd+yDmBicqT5wKVjVbKIAAZaiRc1deotzDJoL
	jZmVtBPHZSAbEeDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A96821352D;
	Fri, 28 Aug 2026 06:12:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id XNmwJ8AmkWqMNwAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Fri, 28 Aug 2026 06:12:16 +0000
Message-ID: <145be2e3-a8c0-4f4f-a701-af2696cec461@suse.de>
Date: Fri, 28 Aug 2026 08:12:16 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: vt: Enlarge the framebuffer glyph size from 16 to 32 bits
To: Alan Mackenzie <acm@muc.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Simona Vetter <simona@ffwll.ch>,
 linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
 Helge Deller <deller@gmx.de>, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org
References: <apCEDM2sWv_M354-@MAC.fritz.box>
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
In-Reply-To: <apCEDM2sWv_M354-@MAC.fritz.box>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: -4.30
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[muc.de,linuxfoundation.org,kernel.org,ffwll.ch,vger.kernel.org,gmx.de,lists.freedesktop.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmx.de];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.com:url]
X-Spam-Flag: NO

Hi

Am 27.08.26 um 20:38 schrieb Alan Mackenzie:
> vt: Enlarge the framebuffer glyph size from 16 to 32 bits.
>
> This allows:
>    o - More than 256/512 distinct half-width glyphs (in fact, up to 2^21).
>    o - Unicode code points >0xffff (outside the Basic Multilingual Plane).
>    o - Coloured glyphs (as before).

But what is the use case here? We have excellent support for text and 
font rendering in graphical userspace for I18N and L10N.

In contrast, the kernel's text-mode support is limited and a hotbed for 
bugs. IMHO we shouldn't add features, but try to simplify that code base.

Best regards
Thomas

>
> The patch doesn't improve the handling of full-width glyphs.
>
> To maximise backward compatibility:
>    o - The enlarged glyph size must be positively configured in the kernel by
>      enabling CONFIG_FB_GLYPH_21BIT.  Without this, the glyph size remains 16
>      bits as before.
>    o - Existing console fonts can still be loaded and used.
>    o - The console keyboard handling remains unchanged.
>
> The format of PSFU font files remains unchanged, and the utility programs
> txt2psf and psf2txt (from package psftools) work unchanged on the new fonts.
>
> An enhanced protocol is needed for the up-/downloading of fonts, and thus
> enhanced versions of the utility programs setfont and showconsolefont.
>
> The new kernel requires two new ioctl codes, which have been provisionally
> given these values in include/uapi/linux/kd.h:
>    o - #define GIO_UNIMAP21 0x4B6E
>    o - #define PIO_UNIMAP21 0x4B6F.
> These are like GIO_UNIMAP and PIO_UNIMAP but work with 21-bit code point and
> glyph numbers.  They are used to get and put the new font format, and are
> needed by setfont and showconsolefont.
>
> Some pertinent code has not yet been amended for the new feature.  In
> particular, the files fbcon_cw.c, fbcon_ud.c, fbcon_ccw.c (which display
> rotated output on the screen) still need amendment.
>
> For the time being, CONFIG_A11Y_BRAILLE_CONSOLE and CONFIG_SPEAKUP have been
> disabled when CONFIG_FB_GLYPH_21BIT is set, until it becomes clear how to
> integrate them.
>
> The new code has been tested only on an AMD64 system.  In particular, it
> hasn't been tested on a big-endian system.
>
> For the avoidance of doubt, no LLM has been used in the preparation of this
> change.
>
> #########################################################################
>
> Building the Kernel
> -------------------
>
> Apply the patch series.
>
> The new option CONFIG_FB_GLYPH_21BIT can be found in the make menuconfig tree
> under Device Drivers/Graphics support/Direct Rendering Manager/Supported DRM
> clients/Enable legacy fbdev support .../Enable 21-bit glyphs ....  Enable
> CONFIG_DRM_FBDEV_EMULATION and CONFIG_FB_GLYPH_21BIT.
>
> [ Note: the kernel can alternatively be built with CONFIG_FB_GLYPH_21BIT
> unset, in which case it uses the well known 16-bit glyphs, essentially
> unchanged from the current kernel. ]
>
> Also enable CONFIG_HEADERS_INSTALL, so that the user side version of kd.h will
> get built in usr/include/linux/kd.h.  This is needed by the enhanced version
> of the kbd package.  After building, ensure it gets copied to where the
> compiler will find it.
>
> Build the kernel in the usual way, and install it into your boot loader.
>
> #########################################################################
>
> Testing
> -------
>
> To try out the new features, you will need a console font with glyphs outside
> the Basic Multilingual Plane, and an enhanced setfont program (which uses one
> of the new ioctl codes above) to load it with.
>
> The font latn-16-unifont-base+upper.psfu.gz attached to this post has 11,240
> glyphs, and its source code can be inspected by gunzipping it and feeding it
> through the program psf2txt from the package psftools.  This font was hacked
> together from the standard fonts lat<n>-16 and parts of GNU Unifont.  Examples
> of code points outside the Basic Multilingual Plane are U+1fbf0 to U+1fbf9,
> variants of the decimal digits.
>
> To enter a Unicode code point on the keyboard, the partial keymap
> /usr/share/keymaps/i386/include/keypad.map.gz is useful.  With it, one can
> hold down the AltGr key and type in the codepoint in hex using 16 of the
> keypad keys.
>
> An enhanced version of setfont, built for AMD64, is also attached.  The source
> code for this, in the form of a unified diff from the commit with tag v2.9.0
> in the repository
> git://git.kernel.org/pub/scm/linux/kernel/git/legion/kbd.git, is at the end of
> this post.  Before building this version of kbd, ensure that the kernel has
> been build with CONFIG_HEADERS_INSTALL set, and that the newly generated
> usr/include/linux/kd.h has been copied to somewhere the compiler will find it.
>
> #########################################################################
>
> Kernel Patches
> --------------
>
> The series of patches applies cleanly to:
>
> commit 8b0b29fdcb47907ae0296b8fe829e918e05e300f
> (HEAD -> tty-testing, origin/tty-testing, origin/tty-next)
> Author: Karl Mehltretter <kmehltretter@gmail.com>
> Date:   Fri Jul 31 20:18:44 2026 +0200rts[] lifetimert in imx_uart_ports[]ntryt)gnamic")
>
> in branch origin/testing of repository
> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git.
>
> This series of patches is essentially a single atomic patch; no partial
> application of them will result in a useful kernel.  The 3,500 line patch from
> git diff has been divided according to theme, although this is approximate
> since not all larger diff hunks have been split into "components".
>
> These files get changed by the patches:
> drivers/accessibility/Kconfig
> drivers/accessibility/speakup/Kconfig
> drivers/gpu/drm/clients/Kconfig
>
> drivers/tty/vt/consolemap.c
> drivers/tty/vt/keyboard.c
> drivers/tty/vt/selection.c
> drivers/tty/vt/vc_screen.c
> drivers/tty/vt/vt.c
> drivers/tty/vt/vt_ioctl.c
>
> drivers/video/fbdev/core/bitblit.c
> drivers/video/fbdev/core/fbcon.c
> drivers/video/fbdev/core/fbcon.h
>
> include/linux/console_struct.h
> include/linux/consolemap.h
> include/linux/selection.h
> include/linux/vt_buffer.h
> include/linux/vt_kern.h
> include/uapi/linux/kd.h
>
> The patches are as follows:
> (i) 1 "Make consolemap.c handle Unicode planes outside BMP" contains the
>    enhancements to drivers/tty/vt/consolemap.c to handle 21 bit codepoints
>    (outside the BMP).
> (ii) 2 "Glyph size: Use GLYPH_SZ/HW rather than hardcoded 2, 1" substitutes
>    the #defines GLYPH_SZ and GLYPH_HW, the size of a glyph in bytes and half
>    words, for the previously hard coded and implicit values of 2 and 1.
> (iii) 3 "Replace scr_readw/writew by scr_readg/writeg, etc" is the replacement
>    of the macros scr_readw/writew with scr_readg, scr_writeg,
>    scr_readg_plusplus, scr_writeg_plusplus (where "g" stands for "glyph").
>    Also one or two other similar macros are replaced.
> (iv) 4 "Amend internal manipulation of glyph structure" contains amendments to
>    the manipulations of the internal structure of the now 32 bit glyph from the
>    previous 16 bit glyph.
> (v) 5 "Amend three Kconfig files" has the changes to three Kconfig files.  One
>    of these introduces CONFIG_FB_GLYPH_21BIT, the other two mask accessibility
>    features of the terminal until it becomes clear how to integrate them.
> (vi) 6 "Use u32 and typedef u1632 to handle whole glyphs" introduces the
>    typedef u1632 (which is either u16 or u32 depending on
>    CONFIG_FB_GLYPH_21BIT) and contains the changes for its use, and needed
>    changes from u16 to u32.
> (vii) 7 "Handle up to 2^21 glyphs, rather than 256/512" handles the change in
>    the maximum number of glyphs from 256/512 to 0x110000.
> (viii) 8 "Enhancements to the VT ioctl interface" contains the changes to
>    drivers/tty/vt/vt_ioctl.c including the handling of GIO_UNIMAP21 and
>    PIO_UNIMAP21, and the conversion of userspace data (whether 16 or 21 bit) to
>    the new internal 21 bit format.
> (ix) 9 "Misc changes, e.g. to #include directives" Miscellaneous changes which
>    didn't fit anywhere else, including reordering some #include directives in
>    the .c files.
>
> #########################################################################
>
> Enhancements to git://git.kernel.org/pub/scm/linux/kernel/git/legion/kbd.git,
> -----------------------------------------------------------------------------
> tag v2.9.0, for setfont.
> ------------------------
>
> diff --git a/src/include/kbd/kfont.h b/src/include/kbd/kfont.h
> index 67ad917..570b5f0 100644
> --- a/src/include/kbd/kfont.h
> +++ b/src/include/kbd/kfont.h
> @@ -211,7 +211,9 @@ int kfont_get_unicodemap(struct kfont_context *ctx, int consolefd,
>   	KBD_ATTR_NONNULL(1, 3);
>   
>   int kfont_put_unicodemap(struct kfont_context *ctx, int consolefd,
> -		struct unimapinit *ui, struct unimapdesc *ud)
> +			 struct unimapinit *ui,
> +			 int bit21,
> +			 struct unimapdesc *ud, struct unimapdesc21 *ud21)
>   	KBD_ATTR_NONNULL(1);
>   
>   /* setfont.c */
> @@ -269,7 +271,8 @@ int kfont_read_psffont(struct kfont_context *ctx,
>   		unsigned char **fontbufp, unsigned int *fontszp,
>   		unsigned int *fontwidthp, unsigned int *fontheightp,
>   		unsigned int *fontlenp, unsigned int fontpos0,
> -		struct unicode_list **uclistheadsp)
> +		       struct unicode_list **uclistheadsp,
> +		       int *bit21)
>   	KBD_ATTR_NONNULL(1);
>   
>   int kfont_write_psffont(struct kfont_context *ctx,
> diff --git a/src/libkbdfile/kbdfile.c b/src/libkbdfile/kbdfile.c
> index 5b1ee6d..50b117f 100644
> --- a/src/libkbdfile/kbdfile.c
> +++ b/src/libkbdfile/kbdfile.c
> @@ -337,7 +337,8 @@ static int
>   findfile_in_dir(const char *fnam, const char *dir, const int recdepth, const char *const *suf, struct kbdfile *fp)
>   {
>   	char errbuf[200];
> -	char *ff, *fdir, *path;
> +	const char *ff;
> +	char *fdir, *path;
>   	int rc = 1, secondpass = 0;
>   	size_t dir_len;
>   
> diff --git a/src/libkfont/kdmapop.c b/src/libkfont/kdmapop.c
> index b868f7b..5be0b88 100644
> --- a/src/libkfont/kdmapop.c
> +++ b/src/libkfont/kdmapop.c
> @@ -179,7 +179,9 @@ kfont_get_unicodemap(struct kfont_context *ctx, int fd, struct unimapdesc *ud0)
>   }
>   
>   int
> -kfont_put_unicodemap(struct kfont_context *ctx, int fd, struct unimapinit *ui, struct unimapdesc *ud)
> +kfont_put_unicodemap(struct kfont_context *ctx, int fd, struct unimapinit *ui,
> +		     int bit21,
> +		     struct unimapdesc *ud, struct unimapdesc21 *ud21)
>   {
>   	struct unimapinit advice;
>   
> @@ -202,10 +204,26 @@ again:
>   			KFONT_ERR(ctx, "ioctl(PIO_UNIMAPCLR): %m");
>   		return -1;
>   	}
> -	if (ud == NULL)
> +	if ((bit21 && !ud21) ||
> +	    (!bit21 && !ud))
>   		return 0;
>   
> -	if (ioctl(fd, PIO_UNIMAP, ud)) {
> +	if (bit21) {
> +		if (ioctl(fd, PIO_UNIMAP21, ud21)) {
> +			if (errno == ENOMEM && advice.advised_hashlevel < 100) {
> +				advice.advised_hashlevel++;
> +				goto again;
> +			}
> +#ifdef ENOIOCTLCMD
> +			if (errno == ENOIOCTLCMD)
> +				errno = EINVAL; /* 21-bit Unicode table
> +						 * invalid for older kernel */
> +#endif
> +			KFONT_ERR(ctx, "ioctl(PIO_UNIMAP21): %m");
> +			return -1;
> +		}
> +	}
> +	else if (ioctl(fd, PIO_UNIMAP, ud)) {
>   		if (errno == ENOMEM && advice.advised_hashlevel < 100) {
>   			advice.advised_hashlevel++;
>   			goto again;
> diff --git a/src/libkfont/loadunimap.c b/src/libkfont/loadunimap.c
> index e2cfa05..06015c5 100644
> --- a/src/libkfont/loadunimap.c
> +++ b/src/libkfont/loadunimap.c
> @@ -281,7 +281,8 @@ kfont_load_unicodemap(struct kfont_context *ctx, int fd, const char *tblname)
>   	} else {
>   		descr.entry_ct = listct;
>   		descr.entries  = list;
> -		if ((ret = kfont_put_unicodemap(ctx, fd, NULL, &descr)) < 0)
> +		if ((ret = kfont_put_unicodemap(ctx, fd, NULL, 0, &descr,
> +						NULL)) < 0)
>   			goto err;
>   		listct = 0;
>   	}
> diff --git a/src/libkfont/psffontop.c b/src/libkfont/psffontop.c
> index 3f94028..179a271 100644
> --- a/src/libkfont/psffontop.c
> +++ b/src/libkfont/psffontop.c
> @@ -147,7 +147,7 @@ read_fontfile(struct kfont_context *ctx, FILE *fontf, unsigned char **inputbuf,
>   {
>   	unsigned char *buf = NULL;
>   	unsigned int buflth = 0;
> -	unsigned int chunksz = MAXFONTSIZE / 4; /* random */
> +	unsigned int chunksz = MAXFONTSIZE / 4; /* 1 MB; random */
>   	int ret = 0;
>   	size_t n = 0;
>   
> @@ -174,12 +174,6 @@ read_fontfile(struct kfont_context *ctx, FILE *fontf, unsigned char **inputbuf,
>   			ret = -EX_DATAERR;
>   			goto end;
>   		}
> -
> -		if (n > MAXFONTSIZE) {
> -			KFONT_ERR(ctx, _("Font is too big"));
> -			ret = -EX_DATAERR;
> -			goto end;
> -		}
>   	}
>   
>   	*inputbuf = buf;
> @@ -197,12 +191,14 @@ kfont_read_psffont(struct kfont_context *ctx,
>   		unsigned char **fontbufp, unsigned int *fontszp,
>   		unsigned int *fontwidthp, unsigned int *fontheightp,
>   		unsigned int *fontlenp, unsigned int fontpos0,
> -		struct unicode_list **uclistheadsp)
> +		   struct unicode_list **uclistheadsp,
> +		   int *bit21)
>   {
>   	unsigned char *inputbuf;
>   	unsigned int inputlth;
>   	int ret;
>   
> +	*bit21 = 0;
>   	/*
>   	 * We used to look at the length of the input file
>   	 * with stat(); now that we accept compressed files,
> @@ -225,7 +221,8 @@ kfont_read_psffont(struct kfont_context *ctx,
>   		inputlth = *allszp;
>   	}
>   
> -	unsigned int fontlen, fontwidth, fontheight, charsize, hastable, ftoffset;
> +	unsigned int fontlen, fontwidth, fontheight, charsize, hastable,
> +		ftoffset;
>   	int utf8;
>   
>   	if (inputlth >= sizeof(struct psf1_header) && PSF1_MAGIC_OK(inputbuf)) {
> @@ -317,11 +314,29 @@ kfont_read_psffont(struct kfont_context *ctx,
>   		inptr  = inputbuf + ftoffset + fontlen * charsize;
>   		endptr = inputbuf + inputlth;
>   
> +		if (fontlen > 0xffff)
> +			*bit21 = 1;
>   		for (i = 0; i < fontlen; i++) {
>   			ret = get_uni_entry(ctx, &inptr, &endptr,
>   					&(*uclistheadsp)[fontpos0 + i], utf8);
>   			if (ret < 0)
>   				return ret;
> +			{
> +				struct unicode_list *list = &(*uclistheadsp)[fontpos0 + i];
> +				struct unicode_seq *seq;
> +
> +				while (list) {
> +					seq = list->seq;
> +					while (seq) {
> +						if (seq->uc > 0xffff)
> +							*bit21 = 1;
> +						seq = seq->next;
> +					}
> +					list = list->prev;
> +					if (list == &(*uclistheadsp)[fontpos0 + i])
> +						break;
> +				}
> +			}
>   		}
>   		if (inptr != endptr) {
>   			KFONT_ERR(ctx, _("Input file: trailing garbage"));
> diff --git a/src/libkfont/setfont.c b/src/libkfont/setfont.c
> index 45652c0..f6f0560 100644
> --- a/src/libkfont/setfont.c
> +++ b/src/libkfont/setfont.c
> @@ -185,21 +185,25 @@ err:
>   static int
>   do_loadfont(struct kfont_context *ctx, int fd, const unsigned char *inbuf,
>   		unsigned int width, unsigned int height, unsigned int hwunit,
> -		unsigned int fontsize, const char *filename)
> +	    unsigned int fontsize, const char *filename)
>   {
>   	if (height <= 32 && width <= 32)
>   		/* This can work with pre-6.2 kernels and its size and vpitch limitations */
> -		return try_loadfont(ctx, fd, inbuf, width, height, 32, hwunit, fontsize, filename);
> +		return try_loadfont(ctx, fd, inbuf, width, height, 32, hwunit,
> +				    fontsize, filename);
>   	else
> -		return try_loadfont(ctx, fd, inbuf, width, height, height, hwunit, fontsize, filename);
> +		return try_loadfont(ctx, fd, inbuf, width, height, height,
> +				    hwunit, fontsize, filename);
>   }
>   
>   static int
>   do_loadtable(struct kfont_context *ctx, int fd, struct unicode_list *uclistheads,
> -		unsigned int fontsize)
> +	     unsigned int fontsize, int bit21)
>   {
>   	struct unimapdesc ud;
>   	struct unipair *up = NULL;
> +	struct unimapdesc21 ud21;
> +	struct unipair21 *up21 = NULL;
>   	unsigned int i, ct = 0, maxct;
>   	struct unicode_list *ul;
>   	struct unicode_seq *us;
> @@ -215,11 +219,19 @@ do_loadtable(struct kfont_context *ctx, int fd, struct unicode_list *uclistheads
>   			ul = ul->next;
>   		}
>   	}
> -
> -	up = malloc(maxct * sizeof(*up));
> -	if (!up) {
> -		KFONT_ERR(ctx, "malloc: %m");
> -		return -EX_OSERR;
> +	if (bit21) {
> +		up21 = malloc(maxct * sizeof(*up21));
> +		if (!up21) {
> +			KFONT_ERR(ctx, "malloc: %m");
> +			return -EX_OSERR;
> +		}
> +	}
> +	else {
> +		up = malloc(maxct * sizeof(*up));
> +		if (!up) {
> +			KFONT_ERR(ctx, "malloc: %m");
> +			return -EX_OSERR;
> +		}
>   	}
>   
>   	for (i = 0; i < fontsize; i++) {
> @@ -229,8 +241,14 @@ do_loadtable(struct kfont_context *ctx, int fd, struct unicode_list *uclistheads
>   		while (ul) {
>   			us = ul->seq;
>   			if (us && !us->next) {
> -				up[ct].unicode = (unsigned short) us->uc;
> -				up[ct].fontpos = (unsigned short) i;
> +				if (bit21) {
> +					up21[ct].unicode = (unsigned) us->uc;
> +					up21[ct].fontpos = (unsigned) i;
> +				}
> +				else {
> +					up[ct].unicode = (unsigned short) us->uc;
> +					up[ct].fontpos = (unsigned short) i;
> +				}
>   				ct++;
>   				if (ctx->verbose > 1)
>   					printf(" %04x", us->uc);
> @@ -250,7 +268,7 @@ do_loadtable(struct kfont_context *ctx, int fd, struct unicode_list *uclistheads
>   			printf("\n");
>   	}
>   
> -	if (ct > USHRT_MAX || ct != maxct) {
> +	if (ct != maxct) {
>   		KFONT_ERR(ctx, _("bug in do_loadtable"));
>   		ret = -EX_SOFTWARE;
>   		goto err;
> @@ -258,17 +276,26 @@ do_loadtable(struct kfont_context *ctx, int fd, struct unicode_list *uclistheads
>   
>   	KFONT_INFO(ctx, _("Loading Unicode mapping table..."));
>   
> -	ud.entry_ct = (unsigned short) ct;
> -	ud.entries  = up;
> +	if (bit21) {
> +		ud21.entry_ct = ct;
> +		ud21.entries = up21;
> +	}
> +	else {
> +		ud.entry_ct = (unsigned short) ct;
> +		ud.entries  = up;
> +	}
>   
> -	if (kfont_put_unicodemap(ctx, fd, NULL, &ud) < 0) {
> +	if (kfont_put_unicodemap(ctx, fd, NULL, bit21, &ud, &ud21) < 0) {
>   		ret = -EX_OSERR;
>   		goto err;
>   	}
>   
>   	ret = 0;
>   err:
> -	free(up);
> +	if (bit21)
> +		free(up21);
> +	else
> +		free(up);
>   	return ret;
>   }
>   
> @@ -286,6 +313,7 @@ kfont_load_fonts(struct kfont_context *ctx,
>   	struct kbdfile *fp = NULL;
>   	int i;
>   	int ret = 0;
> +	int bit21 = 0;
>   
>   	if (ifilct == 1)
>   		return kfont_load_font(ctx, fd, ifiles[0], iunit, hwunit, no_m, no_u);
> @@ -321,12 +349,18 @@ kfont_load_fonts(struct kfont_context *ctx,
>   
>   		if (kfont_read_psffont(ctx, kbdfile_get_file(fp), &inbuf,
>   			&inputlth, &fontbuf, &fontbuflth, &width, &height, &fontsize,
> -			bigfontsize, no_u ? NULL : &uclistheads)) {
> +				       bigfontsize, no_u ? NULL : &uclistheads,
> +				       &bit21)) {
>   			KFONT_ERR(ctx, _("When loading several fonts, all must be psf fonts - %s isn't"),
>   			    kbdfile_get_pathname(fp));
>   			ret = -EX_DATAERR;
>   			goto end;
>   		}
> +		if (bit21) {
> +			KFONT_ERR(ctx, _("Full Unicode fonts aren't (yet) handled by this program."));
> +			ret = -EX_DATAERR;
> +			goto end;
> +		}
>   
>   		if (!height) {
>   			unsigned int bytewidth;
> @@ -372,10 +406,10 @@ kfont_load_fonts(struct kfont_context *ctx,
>   	}
>   
>   	ret = do_loadfont(ctx, fd, bigfontbuf, bigwidth, bigheight, hwunit,
> -		bigfontsize, NULL);
> +			  bigfontsize, NULL);
>   
>   	if (!ret && uclistheads && !no_u)
> -		ret = do_loadtable(ctx, fd, uclistheads, bigfontsize);
> +		ret = do_loadtable(ctx, fd, uclistheads, bigfontsize, 0);
>   
>   end:
>   	free(bigfontbuf);
> @@ -398,6 +432,7 @@ kfont_load_font(struct kfont_context *ctx, int fd, const char *ifil,
>   	unsigned char *inbuf, *fontbuf;
>   	unsigned int inputlth, fontbuflth, fontsize, offset;
>   	struct unicode_list *uclistheads;
> +	int bit21 = 0;
>   	int ret;
>   
>   	if (!(fp = kbdfile_new(NULL))) {
> @@ -447,10 +482,13 @@ kfont_load_font(struct kfont_context *ctx, int fd, const char *ifil,
>   	height = 0;
>   	uclistheads = NULL;
>   
> -	if (!kfont_read_psffont(ctx, kbdfile_get_file(fp), &inbuf, &inputlth,
> -		&fontbuf, &fontbuflth, &width, &height, &fontsize, 0,
> -		no_u ? NULL : &uclistheads)) {
> -
> +	ret = kfont_read_psffont(ctx, kbdfile_get_file(fp), &inbuf, &inputlth,
> +				 &fontbuf, &fontbuflth, &width, &height, &fontsize, 0,
> +				 no_u ? NULL : &uclistheads,
> +				 &bit21) ;
> +	if (ret)
> +		KFONT_ERR(ctx, "Non-zero RET from kfont_read_psffont: %d, %m\n", ret);
> +	else {
>   		/* we've got a psf font */
>   		if (!height) {
>   			unsigned int bytewidth;
> @@ -459,12 +497,13 @@ kfont_load_font(struct kfont_context *ctx, int fd, const char *ifil,
>   		}
>   
>   		ret = do_loadfont(ctx, fd, fontbuf, width, height, hwunit,
> -			fontsize, kbdfile_get_pathname(fp));
> +				  fontsize, kbdfile_get_pathname(fp));
>   		if (ret < 0)
>   			goto end;
>   
>   		if (uclistheads && !no_u) {
> -			ret = do_loadtable(ctx, fd, uclistheads, fontsize);
> +			ret = do_loadtable(ctx, fd, uclistheads, fontsize,
> +					   bit21);
>   			if (ret < 0)
>   				goto end;
>   		}
> diff --git a/src/psfxtable.c b/src/psfxtable.c
> index 9886ad4..2a8fdf4 100644
> --- a/src/psfxtable.c
> +++ b/src/psfxtable.c
> @@ -45,6 +45,7 @@ int main(int argc, char **argv)
>   	unsigned char *inbuf, *fontbuf;
>   	unsigned int inbuflth, fontbuflth;
>   	struct unicode_list *uclistheads = NULL;
> +	int bit21 = 0;
>   
>   	setuplocale();
>   
> @@ -143,9 +144,12 @@ int main(int argc, char **argv)
>   		kbd_error(EX_CANTCREAT, 0, _("Unable to open file: %s: %m"), otname);
>   
>   	if (kfont_read_psffont(kfont, ifil, &inbuf, &inbuflth, &fontbuf,
> -				&fontbuflth, &width, &height, &fontlen, 0,
> -				itab ? NULL : &uclistheads) < 0)
> +			       &fontbuflth, &width, &height, &fontlen, 0,
> +			       itab ? NULL : &uclistheads,
> +			       &bit21) < 0)
>   		kbd_error(EX_DATAERR, 0, _("Bad magic number on %s"), ifname);
> +	if (bit21)
> +		kbd_error(EX_DATAERR, 0, _("Full Unicode fonts aren't (yet) handled by this program."));
>   
>   	fclose(ifil);
>   
> diff --git a/src/readpsfheader.c b/src/readpsfheader.c
> index 2d87e59..7c1b406 100644
> --- a/src/readpsfheader.c
> +++ b/src/readpsfheader.c
> @@ -29,6 +29,7 @@ int main(int argc, char **argv)
>   	char *inbuf, *fontbuf;
>   	int inbuflth, fontbuflth;
>   	struct unicode_list *uclistheads = NULL;
> +	int bit21 = 0;
>   
>   	const char *short_opts = "hV";
>   	const struct option long_opts[] = {
> @@ -73,8 +74,12 @@ int main(int argc, char **argv)
>   	if ((ret = kfont_init(program_invocation_short_name, &kfont)) < 0)
>   		return -ret;
>   
> -	if (kfont_read_psffont(kfont, f, &inbuf, &inbuflth, &fontbuf, &fontbuflth, &width, &fontlen, 0, &uclistheads) < 0)
> +	if (kfont_read_psffont(kfont, f, &inbuf, &inbuflth, &fontbuf,
> +			       &fontbuflth, &width, &fontlen, 0, &uclistheads,
> +			       &bit21) < 0)
>   		kbd_error(EX_DATAERR, 0, "Bad magic number");
> +	if (bit21)
> +		kbd_error(EX_DATAERR, 0, "Full Unicode fonts aren't (yet) handled by this program");
>   
>   	close(f);
>   
> diff --git a/src/showconsolefont.c b/src/showconsolefont.c
> index 9230e2b..27c04ec 100644
> --- a/src/showconsolefont.c
> +++ b/src/showconsolefont.c
> @@ -36,7 +36,8 @@ leave(struct kfont_context *ctx, int n)
>   		kbd_warning(0, _("failed to restore original translation table"));
>   		n = EXIT_FAILURE;
>   	}
> -	if (have_ounimap && kfont_put_unicodemap(ctx, fd, NULL, &ounimap)) {
> +	if (have_ounimap && kfont_put_unicodemap(ctx, fd, NULL, 0,
> +						 &ounimap , NULL)) {
>   		kbd_warning(0, _("failed to restore original unimap"));
>   		n = EXIT_FAILURE;
>   	}
> @@ -92,7 +93,7 @@ setnewunicodemap(struct kfont_context *ctx, unsigned int *list, int cnt)
>   	for (i = 0; i < cnt; i++)
>   		nunimap.entries[list[i]].unicode = (unsigned short) (BASE + i);
>   
> -	if (kfont_put_unicodemap(ctx, fd, NULL, &nunimap))
> +	if (kfont_put_unicodemap(ctx, fd, NULL, 0, &nunimap, NULL))
>   		leave(ctx, EXIT_FAILURE);
>   }
>   
> @@ -111,7 +112,7 @@ usage(int rc, const struct kbd_help *options)
>   int main(int argc, char **argv)
>   {
>   	int c, ret;
> -	unsigned int cols, rows, nr, n, i, j, k;
> +	int cols = 0, rows = 0, nr = 0, n, i, j, k;
>   	int mode;
>   	const char *space, *sep;
>   	char *console = NULL;
> @@ -176,19 +177,22 @@ int main(int argc, char **argv)
>   		kbd_warning(errno, _("Unable to read keyboard mode"));
>   		leave(kfont, EX_OSERR);
>   	}
> -	if (mode == K_UNICODE)
> -		space = "\xef\x80\xa0"; /* U+F020 (direct-to-font space) */
> -	else
> -		space = " ";
> -
> -	if (info) {
> -		nr = rows = cols = 0;
> -
> -		ret = kfont_get_font(kfont, fd, NULL, &nr, &rows, &cols, NULL);
> -		if (ret != 0)
> -			leave(kfont, EXIT_FAILURE);
> -
> -		if (kfont_get_verbosity(kfont)) {
> +	/* TEMP COMMENTED OUT STUFF, 2026-05-20.  What is this F020 for? */
> +	/* if (mode == K_UNICODE) */
> +	/* 	space = "\xef\x80\xa0"; /\* U+F020 (direct-to-font space) *\/ */
> +	/* else */
> +	/* END OF TC STUFF */
> +	space = " ";
> +
> +	ret = kfont_get_font(kfont, fd, NULL, &nr, &rows, &cols, NULL);
> +	if (ret != 0)
> +		leave(kfont, EXIT_FAILURE);
> +
> +	if (!info && nr > 512)
> +		printf(_("Too many characters to print individually\n"));
> +	if (info || nr > 512) {
> +		if (kfont_get_verbosity(kfont)
> +		    || (!info && nr > 512)) {
>   			printf(_("Character count: %u\n"), nr);
>   			printf(_("Font width     : %u\n"), rows);
>   			printf(_("Font height    : %u\n"), cols);
>
>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, (HRB 36809, AG Nürnberg)


