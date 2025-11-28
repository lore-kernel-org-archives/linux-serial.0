Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF422329C5D
	for <linux-serial@vger.kernel.org>; Fri, 28 Nov 2025 12:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764334775; cv=none; b=YUComtZRctbNQ0OS2FY3q8Snzfp4nCntqJPkwdjKyV0hKNxx38CPfXhovsFPef1Wi1nxmO23ldtNEGByHiVX2fLzKX4h89AhkAh44UKmbOHzxoJwPmCVw8y7QPGc7mdx03u240Nk2hfK5dW7PRRbq6QGY1kqZaohyLnR9cQ23eM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764334775; c=relaxed/simple;
	bh=0aBIuYE4nd+BYCFFHUQwg9DXqTRyApw0XxRj/xzcbAQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=slo0R01corbzZK8VFmSK9Umij9IrjTfLKOzAgxquZf2EcQPez+c7qIkOGAcQC9LtMk+FecszgGQOt731a4aabGUFD5R3QoLB597jSH2YgsH1ivw//dpP5qX4PZeg9IVtAo7Kf4bQsSfjizNMxkTRVVb4LgKyHuc9bdhrK3svmAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=f5pvmOPO; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="f5pvmOPO"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-42bb288c17bso1215737f8f.2
        for <linux-serial@vger.kernel.org>; Fri, 28 Nov 2025 04:59:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1764334772; x=1764939572; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0aBIuYE4nd+BYCFFHUQwg9DXqTRyApw0XxRj/xzcbAQ=;
        b=f5pvmOPOu+4JI7MLYETXibPQr6l+KXCQTxQ9B67srs3XcM5wKN2VRWT+fvO7zyTjef
         WEuiWLuSISfKLYoVhbRb//o/Dd8w2EWkxi8xtAmREpdKGuPe9DFaaA9AsUnkz1kH3PJv
         vEfEqUVMZcE7q53eW3kL4WPsThuXpcCOL05GBPyIEZ8VilI4WINT2HDfvQ84uEADWMpL
         g270AXGJfaoIZd49EKcvP4/kPQmwrI0SEJTYj4ye7bjOgkkZGuKmrewTNxvCHZ7XQ7QS
         jpG4Ur/A5I/SW3XzsJi/UKIjYMD5nSXKLhLzL3OXGLLcO36Ho8FSOwCFubr13xbSTffg
         lW5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764334772; x=1764939572;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0aBIuYE4nd+BYCFFHUQwg9DXqTRyApw0XxRj/xzcbAQ=;
        b=hfiaoQ2YTTuGlq7vHUDxHNZ1W50+mJpM86mYmxKyVnjANL+MtMrAUcr6+91ldfh2Id
         zFAyHS/YOm2BNuJDRzqknHgM8+TwufEafIL60hFBXA900moA615ln5CXW32GPoPXqdft
         +acFlOdYZ/p0/gbaXSxY6+g//4nxMa4QGTCTqLXya1oNZhkao5Eob4L3f5tV6A7UhyEz
         K2ISaR2JFkuEuFGcGgTcr4iNZzG/+tPEXh2qw8sHhElHSyxDhj4xMrc9oCLY1GMZ5WH4
         ZgwetEZdqnmZAfwMjpJav94eVfE8x9hypN6nlrLSbie7AgCnJLDh+Srrv3UZ68V/Vu2o
         ZQqA==
X-Forwarded-Encrypted: i=1; AJvYcCVurOV6DbxbfvzWLnfU3dY2UZwBIRcNipbZX/b7mM5XObv9GmPYT2N6Daa/AMGfhimFGvnfxvzYG0/2FK4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvdmbuA464C9Cdm3AuxrhobUFNzzUet9gTO4L7b1tjANGsB3XX
	AFyjGJghE23WN4o+2tlAiV+F9HLv9ujUseB3BmTDgEQmDUB1VBWwuI6wmBQiFCcBNO8=
X-Gm-Gg: ASbGnctvPVB27Ab9JdLLXYJM6bR7JnpLrk59+IlRDML0V5tAbAG+33amuwWau0BanMb
	AY7J6uqKMgoxISR1TXwvgW+/vVW0Gk+Aof9kSXegkpOsmtx/4J9CfuMMe6A4+k0gbGb5FpcbtPI
	s7/dszR7kn27KfzPYcU2F/7XNNsZS/Z/NMGp+e7zPT5+AuLlCICUfVTsHwLsJJHwqXQ5C30xlcW
	uILnxKhZFc4WS2/HUzHLsVviatb6YemsRD4vsSVvPLILbCL9hU7kwCUg35fSbUkCjaJMWy637HQ
	FVf1ZeRtG213v6YkfhK0tHqU799b9VIA2p9UXL5j473d2j7H9rnpYi4pdXruXwco/DO4zBBOvOJ
	xvVnR20n7/wT6ilEbDw4L+PEIRXx/5P6NUTLdwvodeS/QiWvemQHvu8ir1aWqjalHRfGjv8ZiiP
	qS0pINnUOPjF1hf6+LFI+93HbunMnvhLg3I9YdpX4=
X-Google-Smtp-Source: AGHT+IFwsjx1VXfBjmNiHK7aZcDtaWRNmdnPkV/Hi/q/9IXbn+xyWp7WtryWuxt5fSFV2BCqurib+Q==
X-Received: by 2002:a5d:64c7:0:b0:429:edd0:29c with SMTP id ffacd0b85a97d-42cc1ac91edmr29116796f8f.19.1764334771958;
        Fri, 28 Nov 2025 04:59:31 -0800 (PST)
Received: from [192.168.3.33] (99.36.160.45.gramnet.com.br. [45.160.36.99])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42e1c5d613esm9859184f8f.11.2025.11.28.04.59.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 04:59:31 -0800 (PST)
Message-ID: <aa78f0418ca2f408cdc31b478963ddeab797faa7.camel@suse.com>
Subject: Re: [PATCH v2 0/4] printk cleanup - part 2
From: Marcos Paulo de Souza <mpdesouza@suse.com>
To: Daniel Thompson <daniel@riscstar.com>, Petr Mladek <pmladek@suse.com>
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
Date: Fri, 28 Nov 2025 09:59:25 -0300
In-Reply-To: <aSlw2AHo_AWzjH-s@aspen.lan>
References: <20251121-printk-cleanup-part2-v2-0-57b8b78647f4@suse.com>
	 <aShr0DZRmpDnL0nz@pathway.suse.cz> <aSlw2AHo_AWzjH-s@aspen.lan>
Autocrypt: addr=mpdesouza@suse.com; prefer-encrypt=mutual;
 keydata=mDMEZ/0YqhYJKwYBBAHaRw8BAQdA4JZz0FED+JD5eKlhkNyjDrp6lAGmgR3LPTduPYGPT
 Km0Kk1hcmNvcyBQYXVsbyBkZSBTb3V6YSA8bXBkZXNvdXphQHN1c2UuY29tPoiTBBMWCgA7FiEE2g
 gC66iLbhUsCBoBemssEuRpLLUFAmf9GKoCGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 QemssEuRpLLWGxwD/S1I0bjp462FlKb81DikrOfWbeJ0FOJP44eRzmn20HmEBALBZIMrfIH2dJ5eM
 GO8seNG8sYiP6JfRjl7Hyqca6YsE
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-11-28 at 09:52 +0000, Daniel Thompson wrote:
> On Thu, Nov 27, 2025 at 04:18:40PM +0100, Petr Mladek wrote:
> > On Fri 2025-11-21 15:50:32, Marcos Paulo de Souza wrote:
> > > The first part can be found here[1]. The proposed changes do not
> > > change the functionality of printk, but were suggestions made by
> > > Petr Mladek. I already have more patches for a part 3 ,but I
> > > would like
> > > to see these ones merged first.
> > >=20
> > > I did the testing with VMs, checking suspend and resume cycles,
> > > and it worked
> > > as expected.
> > >=20
> > > Thanks for reviewing!
> >=20
> > > Marcos Paulo de Souza (4):
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 drivers: serial: kgdboc: Drop checks f=
or CON_ENABLED and
> > > CON_BOOT
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 arch: um: kmsg_dump: Use console_is_us=
able
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 printk: Use console_is_usable on conso=
le_unblank
> >=20
> > These three patches were simple, straightforward, and ready for
> > linux
> > next.
> >=20
> > I have comitted them into printk/linux.git, branch rework/nbcon-in-
> > kdb.
> > I am going to push them for 6.19.
>=20
> I pointed the kgdb test suite at this branch (as I did for the
> earlier
> part of the patchset, although I think I forgot to post about it).
>=20
> The console coverage is fairly modest (I think just 8250 and PL011
> drivers, with and without earlycon) and the suite exercises features
> rather than crash resilience. Nevertheless and FWIW, the tests didn't
> pick up any regressions. Yay!

Thanks Daniel! I remember that you said that you would run the
testsuite in the previous patchset, but didn't want to bother asking
you (I believe that if you found anything you would point it out either
way :) ).

>=20
>=20
> Daniel.
