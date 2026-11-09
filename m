Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794260762;
	b=nnWp21xJt42XwcFYuVAAyTkgIi+0T0ETEN4Mgm5XSEFhLhxySMeQ6wo1N0OXL3YHEOGy
	 bouvnUqVFqc+mK+L8GgazjKKF+1VTOwiTgE2qnYz/jK9Sgumzf/hyq1VUJesqgelcvpbK
	 IqULiBlIurIXO3S9abu+FdPqCPxI2w4sxWblHiVrzHKfjcI38IRQSfOF6/M3Z55dxpmbl
	 tpq4JgcgMWjnDEZtb0/TDTM9P03GVyq32tyYHAnDHtBUc+boUaHUdvKjKxnnmUyJqw2D+
	 LsDUruV1Yktq3xjssPOMBfXEwxlsiOK9Z1PIhJFjvpNJx6znpuza4OO1b9c6TLqp2xg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794260762;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=874yjmK9ypxK94+nKOJ/uR1d6HpqK0owgIThZQA8ZUA=;
	b=N7hVkSau2/3vyAF9Ajt9KG/+bKB/pXDx07Xvr0XBRU0BIWtZT02/3SZirfxsuvcKtizf
	 i1mIEsgWBmNsI+TT6sBkcvhVXEUhnTKWQzkkcNVNixO/WEzz/4sm8m0XC78QI7acLGDwI
	 jDkdFzpMKocLvVPzA+rwwbWMm/mS1OaR4i/duyR1L6p+mT6c118eR9YiRva6csy1FMD0i
	 K2ANRNeH2k9N02FLV+10hytFGu60cXxHOSDISOKPqGY7aO5GRWki8jKF6tjwd6TiEK72R
	 2fmcfN8XXCGhHSe7CbYSE5R8eDHl5FSYCp74Oycq9ghQk0v9dBknuBdzssF+Qm3GDHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LaZ0qPv5;
	arc=none smtp.remote-ip=209.85.221.44
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9097C606A32A
	for <linux-serial@vger.kernel.org>; Mon,  9 Nov 2026 21:46:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9097C606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LaZ0qPv5
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-490a0e72588so737596f8f.3
        for <linux-serial@vger.kernel.org>; Mon, 09 Nov 2026 13:46:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794260761; x=1794865561; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=874yjmK9ypxK94+nKOJ/uR1d6HpqK0owgIThZQA8ZUA=;
        b=LaZ0qPv5+whTFQHjIA7oYo021SUS2QeXnWN8ii9Y4im7Ue68o46nz2xh/hHMwIUfQ/
         ICad5fyoXePYl6/8nNVhZk6UxBKiDwJbHcHq6QklDSJskt7Ox2MaUqpcgklbAASOb1WD
         7U13gt1MK2zXHTSuMFiAfjmE40I4QhfpTIR2Mc6nMOBQW6Dg/mqe6U/h69Hyf/QnrKae
         CyKIviPRPYc2tnG0IM8qOylYYY2PKnrUJzf833wY0ZcFYDbyZdAS7ekVESO+FaUUNtdA
         WzN6sPDUCv7pE3hPSGmxzNcqgZM1jmpktE+mpPCXGo9ukB9qCsiBySNit7DIM51G+Ivt
         K68Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794260761; x=1794865561;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=874yjmK9ypxK94+nKOJ/uR1d6HpqK0owgIThZQA8ZUA=;
        b=B0KvVBP/YnlLytUQHuL0azIJLuiftUyefjCDkqzJEPVvzt1ikfLx4jYkpF5Nxlzx+4
         OpBqzkYQfUKn9FhKwyi9nok75HWtj7NwMg7W/Tsy2H0RFNlGldPQyeN7XPxhfwZR1A++
         hsufNyJjO4K5DRcdkyoORvb7foD6p0kM4Cwun/2uj3bh8GmTnugn/LvxG2jcoinmAmhH
         9Vi75UyFm/84guB1Sm0DfObgPColnil+DuhvITtgw+r44grPNVHiCAXbUBeRBrSRtJ8p
         LL3Ik0efZ2RvrsaaYMc4jahaVuFzv+LP4JHebxHNVeryHsSuVfQ5gM0HTK2irsg457Pj
         yFLg==
X-Forwarded-Encrypted: i=1; AL+hErFp2KnoQyDiwjUX8E9ee5XIEQEJj2Xn5e9RgCnWF8fBfiZozubth89HvR2ifQbH1q7aLGG2O3uA9klhrDw=@vger.kernel.org
X-Gm-Message-State: APuU4Z/8URxU5Q6Y4g0kNUPpa0UiLMrjQluQCJYjeN9i8s8WnXfqIvCs
	6osj1F7+2slXM1tONXbFADmWrEKhuU3Bcx+UwlqNd9Ord/h1kwun+zPi
X-Gm-Gg: AYBFou10TRIGsznI3hvM+twj3Xvn3GXq677jnHCV4ljgOpcKdSjJQmYQ6hp55aXjtZN
	z7y44EAxXC8KB1dhmK/7ATo6Kw9xV1fIQUJhXB+YNZ0+nRzsWM4eWg6EH1mjKQvpLIx8YVUFjaj
	AYpapTNTa+IMWpSgUHRbalaws0ZiLNCk1WelvSqmzvQyLEAZ9hgEc7t/WsDV1bBSUt1asufWw6g
	0Y+vven3LAgdtMPZ6M2xSmdiYtnbbh2UgNbf6UivnW+kek6UlHcDCP08E0zy5BGPBXtQQHV/D44
	ovgUTUlwIhbOQs08WGwrBlZ0cHReTZwfpGPgUoM9D2qXWwaryokEZfgynV6gu8mAqfQLxnVkJVy
	wSFFESpX0csaA9S94vnoS4UBwHrnp1EAScpymqg1XmE5JDHJhehyA/SiUtfxEgqHBgImGpf61ix
	yww7+hTsQTpPBiYs8GJEd/00ZLO1Z1nxTr/JuOyowW2gOMFliZV52/zBx/SNgXH6mXrNoCle1Q9
	25yA74MGb1k2WytAbbQSLnHNmhYnGgeH+7kTKL6qVbquUpbC3Ve+de1/zVvwosH6v6SVrTwMgSj
	jvXjvkyA6iaiWx747ZtSPE8PLBymDQIuvf/xF1AmVgLQuvp92cu7IA3n1+GnQy7eNQ==
X-Received: by 2002:a05:6000:288d:b0:48e:25e1:5eb8 with SMTP id ffacd0b85a97d-4982b28aa42mr1487213f8f.3.1794260760763;
        Mon, 09 Nov 2026 13:46:00 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4983585c4fdsm1213644f8f.10.2026.11.09.13.45.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 13:46:00 -0800 (PST)
Date: Mon, 9 Nov 2026 21:45:58 +0000
From: David Laight <david.laight.linux@gmail.com>
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: Christian Brauner <brauner@kernel.org>, Geert Uytterhoeven
 <geert@linux-m68k.org>, linux-fsdevel@vger.kernel.org, Linus Torvalds
 <torvalds@linux-foundation.org>, Jann Horn <jannh@google.com>, Josef Bacik
 <josef@toxicpanda.com>, Chris Mason <mason@kernel.org>, Jeff Layton
 <jlayton@kernel.org>, NeilBrown <neil@brown.name>, Eric Dumazet
 <edumazet@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Al Viro
 <viro@zeniv.linux.org.uk>, Jonathan Corbet <corbet@lwn.net>, Christoph
 Hellwig <hch@lst.de>, Greg Kroah-Hartman <gregkh@suse.de>, Joel Granados
 <joel.granados@kernel.org>, Kees Cook <kees@kernel.org>, Jan Kara
 <jack@suse.cz>, Jan Kara <jack@suse.com>, linux-kernel@vger.kernel.org,
 linux-nfs@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-um@lists.infradead.org,
 linux-wireless@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 netdev@vger.kernel.org, ntfs3@lists.linux.dev,
 platform-driver-x86@vger.kernel.org, coreteam@netfilter.org,
 kexec@lists.infradead.org, linux-pci@vger.kernel.org,
 linux-sound@vger.kernel.org, netfilter-devel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, ibm-acpi-devel@lists.sourceforge.net,
 jfs-discussion@lists.sourceforge.net, linux-alpha@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-cifs@vger.kernel.org,
 linux-fbdev@vger.kernel.org, linux-hwmon@vger.kernel.org,
 linux-mm@kvack.org, linux-sh@vger.kernel.org, linux-usb@vger.kernel.org,
 samba-technical@lists.samba.org, sparclinux@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, linux-doc@vger.kernel.org,
 linux-serial@vger.kernel.org, linux-atm-general@lists.sourceforge.net,
 Takashi Iwai <tiwai@suse.de>, linux-input@vger.kernel.org,
 linux-raid@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-modules@vger.kernel.org, linux-debuggers@vger.kernel.org, Chuck Lever
 <cel@kernel.org>
Subject: Re: [PATCH RESEND v2 14/23] proc: let procfs copy in writes before
 pinning the entry
Message-ID: <20261109214558.0d9d5228@pumpkin>
In-Reply-To: <alpine.DEB.2.21.2611090504170.17804@angie.orcam.me.uk>
References: <20261104-work-procfs-core-v2-14-76ace653a773@kernel.org>
	<CAMuHMdVfakapgBK6TBhO1iWX8qzvLDk8jzRS=t2MVa5G=MCUeg@mail.gmail.com>
	<20261107-akteur-gemieden-eckdaten-21304d085e35@brauner>
	<20261108185953.28054fb3@pumpkin>
	<alpine.DEB.2.21.2611090504170.17804@angie.orcam.me.uk>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 9 Nov 2026 05:05:57 +0000 (GMT)
"Maciej W. Rozycki" <macro@orcam.me.uk> wrote:

> On Sun, 8 Nov 2026, David Laight wrote:
> 
> > > > While at it, I think it would be good to use this conversion as an
> > > > opportunity to replace "char *" by "void *", which will probably let
> > > > you drop several casts from users.    
> > > 
> > > So I tried that too. The thing is it drops exactly one u8 * cast in
> > > ntfs3's label write.   
> > 
> > Since char is now unsigned that one isn't even needed...  
> 
>  Please excuse me missing the context, but what circumstances does your 
> claim refer to?

Just that the cast would have to be:
	u8 *foo = (u8 *)bar;
where 'bar' is 'char *', and I don't think you need a cast there when
char is unsigned.

David
 
> 
>   Maciej
> 

