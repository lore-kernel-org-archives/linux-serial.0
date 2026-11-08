Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794164398;
	b=HeYlq8MXd+2khGvk8fEmJmWg3PHGeK9o0FRDu0vrOJGTNxbyk9XtNWL/wckm1YU06oz0
	 MzBqGI+e8UN7MLT4bRiNnUzJ6YGK73+SgzFdR4MfuiBMHRg4M4JDRCNt2pUr3sAkXzMq7
	 Vw2lD7rXwy568KG71oqX++sOrPjhv1qZvyydgLBF51oi2Wgqs0sgKzkZQxGw1ZLi2AnID
	 V2Ivose3B7wYDbrkSE2KW5YKS9keYgLz13I0PVWvatxa6IjiL2Gle743RM8O8qkpFUZZH
	 Ib7xBgb8x3ch8HHSmfoloU1oGkEXZgtsQ8NcBaqNkjYejbzsr3/K+pheZWZpYIcb+/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794164398;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=JLhUwzup1lwefYy8NOOFjthYnrByVfTsqIe79kkV+Lk=;
	b=x3HTVAFt3gz2PZW7Y5fY9SgF/jTaPUk68NVUWoNFVvJz2SWakfmRdYpdntEx61UEkleL
	 /2d9MtgxrnwxgBHJFVVdQdNHbi6oqiNx8jBzybiL10PM1hMW2J297/d4xFiTQstPP/Asj
	 A1MgWVISIYsBd2cPKAf876Tya++TvGTHo+M4HF9AOrtvrdXIyQAvnRNrCqUWOOsuCV2qX
	 JdYUJIgFEAXCp6qZGDg32j247JRNSbXNp5UXzLC9xgKu8eIhbnDUnPbtPBNJ57OuvD3N3
	 cFMnPV2qm89kv4OWQ0lFTxr4R646PHWHy/TFJM7BaSqQ28Qey9rJ8xWsXqBSaROQywg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XrEUEgHU;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3575E606A333
	for <linux-serial@vger.kernel.org>; Sun,  8 Nov 2026 18:59:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3575E606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XrEUEgHU
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a35ac4475dso1148465e9.2
        for <linux-serial@vger.kernel.org>; Sun, 08 Nov 2026 10:59:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794164397; x=1794769197; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JLhUwzup1lwefYy8NOOFjthYnrByVfTsqIe79kkV+Lk=;
        b=XrEUEgHUwv+lt2Z0T4RzlOQuYT1yMbnY/MJrtF5HY2pc8m0ujKE+1IGJbqc3A1SsPJ
         Pz+po0Wh7ECcrOl1hyNdZBme+OsO/r11IeCA1lW9KMbstFhlOkC0Hm7Ef+TTavGsfrDk
         7T2AE8nlcorDhYFpLo0KTCt4xOv09AacMRilfH2h4PS2mZ0iBReAF8XAcgtI3iT+qlRY
         EJQPYUIUlDRCCjadf1+24R8V0flZyhCZpLCroCVsidoQ510350k4POOaAcSXgGRrBTWF
         rbpUnz5O6K0TOR8uz/zwLHiObwDAqnCJFWP0+ssCNYCBYnXJwQ2yMfUqdKkv6ro/lp/q
         XMaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794164397; x=1794769197;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JLhUwzup1lwefYy8NOOFjthYnrByVfTsqIe79kkV+Lk=;
        b=DTwSTP1A1I4l3He2nGegkDdN4j+YmhztjXv4LqYacikMv38BO7Er/Fksg443lK7yOC
         pjO+VTVDwHIO8dpM5oQBjaRgk713UAeaF8c/SCKwFJt7sUbld9VtKZfKgvIPe9Ly/dnZ
         DhiOT5fX5t3Ku2ysYd2yrxDYRKEe2OjR6EE/J31eascyY86q24/w4XIhGuJArFSZdkD3
         9+a7MOkqtJbtIoRPW2XqMB+lL96AfEwOPaVMBod4IODEAuX5Jf4tkjjN5Rw2MhcnNsrn
         NmV5KzAV2yWRQj+36Y/dwB965NGJpRCZkx2rEy0r59i6XM4zxek7+wPPnArSBYHBE0fy
         L0rg==
X-Forwarded-Encrypted: i=1; AL+hErHS+fR8NpaclZJEoGMKTAlww8iSHqOyLfc2aFY7t+q2yw3F5TayRM7zz6typdqzMjrMrTSdGAefE37Hlag=@vger.kernel.org
X-Gm-Message-State: APuU4Z/oRghlh4z94SGqYL80cHLnv4QbEEuEWRzcsL331mytOgOveAVP
	orlRAz5KNI9fuCCRThtQZnjTbveZY0iGtUbNlwnGkl+1nUZ0aVPCHAH4
X-Gm-Gg: AYBFou3VDceU/yCQid3wdgTolOBRgmN98roEw6XTG/N+elgxRChHQ03iI+walrStpJc
	PuhSP1LLXKcKI54aflW2SCL8KKVyPETvg7/AJOZlnVsOXEMuTf4FKBFIIVy/GBW3uc+dNzV06Dk
	LZIUaY27t6sLoBE1cGk2M9EHWv87AlAX1d95lfQYC3aDn+pwxDSDobz89tpxhlvvP6N+058A6gB
	su8b9IUnuU0Db/FB9jtKjLxBSAcgH2px8oNE+VyPAEgodFs0RpUwmcKhkE9Xlnsymb+VTp55Uy7
	q6GOXT7A+6doop17XIMv29hGf2BvCL2qGXHFTgGO1YIQ/yZdRAC1YQjTReZ55CCXutZr3KqL4Tf
	8i4ez6zVvbp4e5ohp1CTdRdPSzAj4NEnnx9tPJulNVqgSdOzdlzUWvoX8BZ3Y2rQK/E34UGvVJZ
	EavlOJBb8lgARk+rbQ34+Jfon069jVXJJZ3GWYYkJ5cN5T8cvXoX+KjdYo7/sr98PO/MlM7Nfcw
	iaV3pkZLa3Z+La9HzRjIaPBKaftSwMeQZBjIf0K0pHBHUbWVBDzRX3tqnPjm1jZL+KVdOnq51yf
	o/h3mV9uc/5fiWeTsOOBQYhTSxsdBJAQ60cwsqX5KMvALsXxQ13yljt2X4at8ua4
X-Received: by 2002:a05:600c:468f:b0:4a1:7e77:c382 with SMTP id 5b1f17b1804b1-4b960d9b170mr35982125e9.5.1794164396406;
        Sun, 08 Nov 2026 10:59:56 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b7efb1f3acsm185228445e9.14.2026.11.08.10.59.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 10:59:56 -0800 (PST)
Date: Sun, 8 Nov 2026 18:59:53 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
 linux-fsdevel@vger.kernel.org, Linus Torvalds
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
Message-ID: <20261108185953.28054fb3@pumpkin>
In-Reply-To: <20261107-akteur-gemieden-eckdaten-21304d085e35@brauner>
References: <20261104-work-procfs-core-v2-14-76ace653a773@kernel.org>
	<CAMuHMdVfakapgBK6TBhO1iWX8qzvLDk8jzRS=t2MVa5G=MCUeg@mail.gmail.com>
	<20261107-akteur-gemieden-eckdaten-21304d085e35@brauner>
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

On Sat, 7 Nov 2026 10:48:35 +0100
Christian Brauner <brauner@kernel.org> wrote:

> > While at it, I think it would be good to use this conversion as an
> > opportunity to replace "char *" by "void *", which will probably let
> > you drop several casts from users.  
> 
> So I tried that too. The thing is it drops exactly one u8 * cast in
> ntfs3's label write. 

Since char is now unsigned that one isn't even needed...

David
