Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D056719CC11
	for <linux-serial@vger.kernel.org>; Mon, 23 Jun 2025 18:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750704346; cv=none; b=m/KJDpH0kt126jLzFo09T0RcPtN4d9T0hl4czJZTPxF5BcEeQj0aQ4NvMsqVIYlXfX8EwqzvGIIIYBe8h4Qbjuvl/9z3nowNNFf8giZuQYsNpx5Z/mUT2tsOb/c04DMU+C6fehUE8uQYu43AI0muIyuyDu12ilY3tYk6yx3/9kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750704346; c=relaxed/simple;
	bh=jB4MKuZY+Ffi3QK7qpUEThxOxdtk8engxwoxg/tQK+M=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=snZNb8D88DHcJOYB4WfbDeg+Oh6hiUlxVYZklOXD6UIjcP1mL87teJ4zBgdXVz0IQaRHVDZqXLSd1X8Pxl+c7Br8IKO+jNgBo1KYtvm9TwXoPFaY3Ngur6mI4TJRDK6tfJLkAXe6qHxIg7ScWthN8Yej40igh8ERuCbVgfmZ0ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=WmORnRdQ; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="WmORnRdQ"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3a4fd1ba177so2926818f8f.0
        for <linux-serial@vger.kernel.org>; Mon, 23 Jun 2025 11:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1750704343; x=1751309143; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jB4MKuZY+Ffi3QK7qpUEThxOxdtk8engxwoxg/tQK+M=;
        b=WmORnRdQ1bRXiW339VIWESeowWbm3d1kwGgrd3eGg2E7BAkkyCo0+ONJxnV5iX83/2
         rkjAYl19WKJUesKyZF3cH69dmzqPrl7r1l6gPcu7Yf7pNKYQfxKsBzFqiomy871HFTk2
         IsM0FBgb5884ryFQsSR2GU0mmARJWoWxbhkxcDfVvhgrDF4ciPS2mvUplIAr3waUmh1k
         NFWrzTTVEX7Ybq+pxGLStlsH4d9QDGuhX8p5IgTKRLi6nviVhgEIf2E6b/OOd4DRxYN+
         kpvZzsJXzDEu6WN0asWvbQk6FI2ZUtvKXby8qv3fCR/Wx1zkv1fZWUlA5HlhtQSRFJNZ
         yNxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750704343; x=1751309143;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jB4MKuZY+Ffi3QK7qpUEThxOxdtk8engxwoxg/tQK+M=;
        b=MBMx17oET9t4bjmT/NvQ4IJ+sevDYBB9/XxKhkc3L+qz3RX7MiozR/F4rAneTiRE70
         Lzc5nD9qfAAISzVAh3O2+tMnTcOA2XMIkMtnJY86hWzhwTRHvzvFSPQjvA8Nd5jYLG0e
         jRuU7VYJH8V4M1tgrqA5kpbYG6K2DrgWgVJ+FEZYcIKhd6hj3SnziK+f8XxLs3TF1lep
         GmpkoL/2fKDQu9+pJf8or13vnIcfdvkyKckvd24iWWcU0Y1URNKG8cfOY4gDzJPWbaRK
         K+SQ5utf9w9TmOtzC6E/Jem3bgskgMX5Nnu/fkgBObbVBJ6ymW8Qbf/AgaiORar85ok+
         Bliw==
X-Forwarded-Encrypted: i=1; AJvYcCU8qfmD9lgp7lNHZoQToCUqfxXMVfexE7TsJUUWvAnd5JGyhzMS3e/hzPAy52Y+VEg5J3Nza7dkckIfsNM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7QapGNhQWk9vywQ79WcCMC/8Sz+jwiWd4NNtS5Ut+b27tD4Ih
	HsHvTH7+i5PHrHoq2TzJp1+69acxMfEE8+ucvnTE2OzxyafN2SRFVzpZFLEBnkJArOwR2nOBnIb
	3R2EUJ72OzA==
X-Gm-Gg: ASbGncuyQOC/zb5yyEm1Cvh3k90NqgtTtLRDsAmoHg6X4ttF5K9DwB7I+SxOblsIsdA
	E7QHYWAFPt6LbB+rNJnpqzExFCs4Lmul03F/po4wFSOowYtqEUy362fwq26ps/tA/cU/kf2Ice7
	0wcIFB96E7dUSnf+9ZC2jck25l5+AchzLkK1JboTRC3KKXbmzv2rAAkfhovCd3RnnQf4d0kaUVj
	KnIe/kxjKg/pH8RVWqGGtvkyVlR+yIF+08hy/JiC4j+l/IlKapGjVjBEm6B8e2rp1XolvbKlWZV
	3zMmuwQLGUzCMSdkTo+V6bxCpGaGOvoJB4ySWYTjxl7/Cncq1jX93m6DHTCDQChWCPuwMEaGedW
	0yTAuAJKldXpChFZhH/o8EWXv
X-Google-Smtp-Source: AGHT+IHDRPumMTiGBj2bKfNpuQzAm+7VlyB5Tr2Ge/4ynqkxj9vUq5oRX4iaFtPKRy4untvXuea0VQ==
X-Received: by 2002:a05:6000:40e1:b0:3a4:f607:a5ad with SMTP id ffacd0b85a97d-3a6e7206acfmr430150f8f.19.1750704343074;
        Mon, 23 Jun 2025 11:45:43 -0700 (PDT)
Received: from ?IPv6:2804:5078:805:6b00:58f2:fc97:371f:2? ([2804:5078:805:6b00:58f2:fc97:371f:2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7490a6ca165sm9303644b3a.172.2025.06.23.11.45.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 11:45:42 -0700 (PDT)
Message-ID: <49eed036f3c230d066ff44620c222fe5a2c3da1a.camel@suse.com>
Subject: Re: [PATCH 1/7] printk: Make console_{suspend,resume} handle
 CON_SUSPENDED
From: Marcos Paulo de Souza <mpdesouza@suse.com>
To: Petr Mladek <pmladek@suse.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, John Ogness	
 <john.ogness@linutronix.de>, Sergey Senozhatsky <senozhatsky@chromium.org>,
  Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
 <jirislaby@kernel.org>, Jason Wessel	 <jason.wessel@windriver.com>, Daniel
 Thompson <danielt@kernel.org>, Douglas Anderson <dianders@chromium.org>,
 Richard Weinberger <richard@nod.at>, Anton Ivanov	
 <anton.ivanov@cambridgegreys.com>, Johannes Berg
 <johannes@sipsolutions.net>, 	linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, 	kgdb-bugreport@lists.sourceforge.net,
 linux-um@lists.infradead.org
Date: Mon, 23 Jun 2025 15:45:37 -0300
In-Reply-To: <aEq9_kOoLSQwuYBq@pathway.suse.cz>
References: <20250606-printk-cleanup-part2-v1-0-f427c743dda0@suse.com>
	 <20250606-printk-cleanup-part2-v1-1-f427c743dda0@suse.com>
	 <aEq9_kOoLSQwuYBq@pathway.suse.cz>
Autocrypt: addr=mpdesouza@suse.com; prefer-encrypt=mutual;
 keydata=mDMEZ/0YqhYJKwYBBAHaRw8BAQdA4JZz0FED+JD5eKlhkNyjDrp6lAGmgR3LPTduPYGPT
 Km0Kk1hcmNvcyBQYXVsbyBkZSBTb3V6YSA8bXBkZXNvdXphQHN1c2UuY29tPoiTBBMWCgA7FiEE2g
 gC66iLbhUsCBoBemssEuRpLLUFAmf9GKoCGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 QemssEuRpLLWGxwD/S1I0bjp462FlKb81DikrOfWbeJ0FOJP44eRzmn20HmEBALBZIMrfIH2dJ5eM
 GO8seNG8sYiP6JfRjl7Hyqca6YsE
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-06-12 at 13:46 +0200, Petr Mladek wrote:
> On Fri 2025-06-06 23:53:43, Marcos Paulo de Souza wrote:
> > Since commit 9e70a5e109a4 ("printk: Add per-console suspended
> > state") the
> > CON_SUSPENDED flag was introced, and this flag was being checked on
> > console_is_usable function, which returns false if the console is
> > suspended.
> >=20
> > No functional changes.
>=20
> I double checked potential functional changes. In particular, I
> checked where the CON_ENABLED and CON_SUSPENDED flags were used.
>=20
> Both flags seems to have the same effect in most situations,
> for example, in console_is_usable() or console_unblank().
>=20
> But there seems to be two exceptions: kdb_msg_write() and
> show_cons_active(). These two functions check only
> the CON_ENABLED flag. And they think that the console is
> usable when the flag is set.
>=20
> The change in this patch would change the behavior of the two
> functions during suspend. It is later fixed by the 3rd and 4th
> patch. But it might cause regressions during bisections.
>=20
> It is probably not a big deal because the system is not much
> usable during the suspend anyway. But still, I would feel more
> comfortable if we prevented the "temporary" regression.
>=20
> I see two possibilities:
>=20
> =C2=A0=C2=A0 1. Merge the 3rd and 4th patch into this one. It would chang=
e
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 the semantic in a single patch.

I liked the suggestion, I'll do it in the next revision. Thanks for
looking into it!

>=20
> =C2=A0=C2=A0 2. First update kdb_msg_write() and show_cons_active()
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 to check both CON_ENABLE and CON_SUSPENDED=
 flags.
>=20
> The 1st solution probably makes more sense because we are going
> to remove the CON_ENABLE flag in the end. And even the merged
> patch is small enough.
>=20
> Best Regards,
> Petr
