Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793642354;
	b=40YmJ79kFAqlVd3e4K0TTv7MPgPToj0ZRVpOYxzRfRhvqO1ed83gccx71KpwAxPfIq0o
	 VFzceIF0NkCKUeb83s4JDM6sql/eQ7vlqSKkqFglbMZHxY2d6opDVVjcgu8U0/yyRJwE+
	 mdlbQPJo6rJbsnQA/64rS5wYvEfgb7a8nhUk0mUcwj/czHhBKyMy/IntY8gz8ErY3++YS
	 jakB/inyfxtxK2F53u1YKvSqJVcj5fdSlVJ+wMfZh7gg1cfXyb6q2LcP4l/BkJrF53T+A
	 ap81j7VibIZQoyHn1XcS1X/wP/egaWZGkInl78qImE3hRdKr/YfwbWABUF9v1NeiHIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793642354;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:X-Forwarded-Encrypted:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=/vXXDZI2TLqXD/tqTZGHj/cF0YcMq0fXP1TpWYkM2ME=;
	b=kkKtCuVJPeBMa9JLh43g6VN7aXeQyRcwGGbk9A9jCnMY8FmqYjAFATxi0fYJTCAnV7vb
	 dyz2XbCw+nO8GGgrMg5y33ZSmIXhFX1Va4fvyRd69quY84WPHw7sAnjuyxf6Q4OPfsoj9
	 bJVfPYSZerGFwXuJj3DsRNNjFD/Raz5aCS20lNy4zmE3IpJEMj2c9Bgd3Vy5Z+web5UF+
	 uqQkryL7cm6aw5go+Ad3C/2Gzcl8bhLVDTl2vK7crRr7FOmhat3utT1DZ0UusX8BvMHp1
	 Y3jITWaLsFYCbxzTGRJ604Rs/0GE7tmHRjLVphthBFv5Ca7ZiGgdWri03ji7LS22T2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-foundation.org;
	spf=pass smtp.mailfrom=linuxfoundation.org;
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=IKGXYRIR;
	arc=none smtp.remote-ip=209.85.218.50
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6BFA6072C49
	for <linux-serial@vger.kernel.org>; Mon,  2 Nov 2026 17:59:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B6BFA6072C49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=IKGXYRIR
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c40e30c26a4so833836766b.0
        for <linux-serial@vger.kernel.org>; Mon, 02 Nov 2026 09:59:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1793642352; x=1794247152; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/vXXDZI2TLqXD/tqTZGHj/cF0YcMq0fXP1TpWYkM2ME=;
        b=IKGXYRIR11LfaJEEDatmG7xY0AFGYIHx7livxaKR5SIoINaZawhLa2GVcF0UFLtpJT
         b8PDqIOzeR4//kzLDtnUtVYXyOzJEhyY9wFRiLuEeY+KGpmZYEiC80QTG300A1Ue9yoF
         l+51cuKgFgM1JkqZzSb/qh8d0A1WYtX5NVxdg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793642352; x=1794247152;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/vXXDZI2TLqXD/tqTZGHj/cF0YcMq0fXP1TpWYkM2ME=;
        b=2JTNbsm57XuB7Vdtq16MoBfx1Vcftb5RSZySYsUY2VR4/xpzwY5XblsrlrYTBhufEa
         Xgy8hq7em0AJiElHMWBKI+FXZlFVOZhoJidtKCw2RA49Bs9L2jcKOJYrWlaXaxAvgZrM
         zfJ+teVY+2WJ+MvDLVheVSf7nG9eOTQTMg4rmCcj4dpf5SCorzpXdMk0KfCi19PkZXFv
         kiWWA/CVldtVtb1hF7BhlVC95zadXLEFPLDCpPz6Eb0nP0g4Fir4jkwejpENT/LEppWu
         i27mikJaBBT7PBes6V5QfMV3FNjzFyCNMTg+LYc8aMmkqrd8FWWT/GLzY2zu7etcwnUD
         9k1g==
X-Forwarded-Encrypted: i=1; AKwUvBwOZzLAFyaV0QLVYmnm2tyYSnhlIfOA0vtAQTV5FZkRJTSV4QfHR56PtU32u9WofkQL7+9PJ1dYXYzEX+8=@vger.kernel.org
X-Gm-Message-State: APuU4Z/ggEag8RcMIYS0nKAwj12vDRj6MnpDkE8MhyVBjeHKStd5jx8e
	hGPruF3mEwUEOlWKHQB2HrE2rqNR7K3rckR51aTbHpIN7YxEqRbDNP4T83MX+Tq/Vm6SZ4+TfG+
	U72p1CtE=
X-Gm-Gg: AYBFou2kot8OAoAD2+kpMJmBUrzMLKRAf8CQwlqIJzAZI5KPZwElMc88JnHWAHo1Khi
	27fmAh4TkVCrjKXmEsUvuGqieOzCgaCUw7iGacUBuAmiKBxWGBnPSIbbtH05YYkaKYuaAOy56fT
	V836kcRVE7ZQF5Lf/kN18gGFjd/2baD/bS+7N+nj1l0BKXXtSoLkaoyRFXe+f1jgPPKtExGv6Aq
	pTVaLMB5qA46KiShG0ffZl0Ry/8kz9o02kvady/2gODgtrq5ndJy33DiDSFkMoc3Racp/Fo2k4G
	YtCVBFSlodfQNxjc1qQmZrqjRATlf7y285L8aJN5yS2V4Bfh8QSYRSdc4xWNDQ3tV00IUIrBqQE
	VyLdMgnOYaJYyEnhkLRdBD6OGOdsZdy1ZVK2TC3N8kkcuwNtOZnYoszmKsSQWatpYgDTkxixNRp
	S6LUJyTBRgoSeOqmC4xOi8RWHqSXi2pe7Bsyk6XsmBGpoEB1HxocPlmaHSbDpNmN+N2foUAYChm
	PKyQu9CS06mniKm5FsHJV01Gkt4OVffaUeJgcrbTmolGLVEFn5qmN0JHJJQBF5LgTfqCiGwJira
	65pCZ9hZCYhBf+9BEuVs1txoLGZQ4Lkc8SNqxbt072f0jwLOHmsuGNy6+hbZVg54+31h0zJtIUI
	x1g==
X-Received: by 2002:a17:907:3f25:b0:c46:9711:e30e with SMTP id a640c23a62f3a-c49d14dbc5emr1144036966b.29.1793642352169;
        Mon, 02 Nov 2026 09:59:12 -0800 (PST)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com. [209.85.218.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b4eca21356sm3618715a12.35.2026.11.02.09.59.09
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2026 09:59:11 -0800 (PST)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c434376dbebso693422666b.1
        for <linux-serial@vger.kernel.org>; Mon, 02 Nov 2026 09:59:09 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBzjdOxKsETtj7fH7f2fTjWz4bYqV92rJroLf18uSri9I8iBgjcxOo7zKkidxmvb96qnvbYE4Rwr/niUZ5E=@vger.kernel.org
X-Received: by 2002:a17:907:d94:b0:c2d:c80e:8366 with SMTP id
 a640c23a62f3a-c4ca7426f6emr874452266b.0.1793642348398; Mon, 02 Nov 2026
 09:59:08 -0800 (PST)
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261102-work-procfs-bugfixes-v1-0-59422ed3e465@kernel.org> <20261102-work-procfs-bugfixes-v1-1-59422ed3e465@kernel.org>
In-Reply-To: <20261102-work-procfs-bugfixes-v1-1-59422ed3e465@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 2 Nov 2026 09:58:51 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiSA7-mqmAjTQDaU7UjUyWt0TxYwXHafL8ZAPudy+B_uQ@mail.gmail.com>
X-Gm-Features: AclHuK_qZTBVsLQIdymgRHScSFenC6XsGggUDmcuOugjrSTbuVkeASUmC_hYPZo
Message-ID: <CAHk-=wiSA7-mqmAjTQDaU7UjUyWt0TxYwXHafL8ZAPudy+B_uQ@mail.gmail.com>
Subject: Re: [PATCH RFC 01/38] PCI/proc: don't truncate the position of config
 space accesses
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jann Horn <jannh@google.com>, 
	Josef Bacik <josef@toxicpanda.com>, Chris Mason <mason@kernel.org>, 
	Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, Eric Dumazet <edumazet@kernel.org>, 
	Thomas Gleixner <tglx@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Jonathan Corbet <corbet@lwn.net>, Christoph Hellwig <hch@lst.de>, Greg Kroah-Hartman <gregkh@suse.de>, 
	Joel Granados <joel.granados@kernel.org>, Kees Cook <kees@kernel.org>, Jan Kara <jack@suse.cz>, 
	Jan Kara <jack@suse.com>, linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org, 
	linux-um@lists.infradead.org, linux-wireless@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org, ntfs3@lists.linux.dev, 
	platform-driver-x86@vger.kernel.org, coreteam@netfilter.org, 
	kexec@lists.infradead.org, linux-pci@vger.kernel.org, 
	linux-sound@vger.kernel.org, netfilter-devel@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, ibm-acpi-devel@lists.sourceforge.net, 
	jfs-discussion@lists.sourceforge.net, linux-alpha@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-cifs@vger.kernel.org, 
	linux-fbdev@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-mm@kvack.org, 
	linux-sh@vger.kernel.org, linux-usb@vger.kernel.org, 
	samba-technical@lists.samba.org, sparclinux@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linux-doc@vger.kernel.org, 
	linux-serial@vger.kernel.org, linux-atm-general@lists.sourceforge.net, 
	Takashi Iwai <tiwai@suse.de>, linux-input@vger.kernel.org, linux-raid@vger.kernel.org, 
	linux-ext4@vger.kernel.org, linux-modules@vger.kernel.org, 
	linux-debuggers@vger.kernel.org, Chuck Lever <cel@kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 2 Nov 2026 at 06:22, Christian Brauner <brauner@kernel.org> wrote:
>
> proc_bus_pci_write() truncates the file position to an int. A pwrite()
> at an offset like 0xfffff000 turns it negative [..]

I think this would actually be better with rw_verify_area() just
checking a per-file maxbytes.

We already have that logic for lseek and friends - using that fairly
hacky combination of s_maxbytes and !unsigned_offsets().

We should combine s_maxbytes and unsigned_offsets() at file open time
into f_maxbytes and check that not just at lseek but in
rw_verify_area.

And then things like proc_bus_pci could set it's size limit in one single place.

Hmm?

                   Linus
