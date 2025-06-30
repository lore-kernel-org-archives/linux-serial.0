Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A1210A3E
	for <linux-serial@vger.kernel.org>; Mon, 30 Jun 2025 00:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751243528; cv=none; b=QDCHc0DUApvmotSl8st/xEGe3IIzJQ0L48wKMDp5VXSnuGQ6D0f2l0ctDPNJQE2SU5zvLONhnGra9POeUyJyoiUCPTMm9t51arahPrfhFsDxZOD0V5XZunQK6nLH/2AbW15bpm7fryB+p+WESw6piUzTecVCH6yqvxV4kraf2HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751243528; c=relaxed/simple;
	bh=KBWEla2Um+3pHERNchD3X3ScXlkOpr2RXl3KsDHufVM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Q3ZsLhV3DKNAfP2ioqz7VbmCAHWeyQmVyZ7ukzjcyxkvulH5Q4FLGuGG4wTWz3EAzoVoBjZJ0V4w47S/zcToeY845USqfxBtWXfb4jbsQhH2P75VpYsJLSGLvUnOKB0Kqns+TEPcoGQUz6U34pkbKzDgcvLNUyQkCdQAnkHzn+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ZFn+amyz; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ZFn+amyz"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3ab112dea41so663073f8f.1
        for <linux-serial@vger.kernel.org>; Sun, 29 Jun 2025 17:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1751243524; x=1751848324; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rz7q/mLSazaciDJjcVPSYcL8l+KzHY3rbvo2kLwMng8=;
        b=ZFn+amyzXKB9Qhg5Is4NUmRYd5wqnacLSKME8HSM6A8Ttsr2/EtBDBeefYWtYGSwEs
         OHbVThvjW2x7j8T/TtqSOVpUN+G4IBp7PEPtEV7FHjCfVNWc83DglEZfUT9a4JkmYK43
         3nxMgHW+Te9IFXATFQ3KEwKOadZTf+efzPqAYOVXlevw7ckoIqhv3u+hg2eDmdafUTlH
         yhSnmgUYgYc9KA0uOozpaENDwsvSqmBi45QmoRqKAQOZr42pLLzMfLbYWVbSh6P685lQ
         lvHNRx6dqwdg408twPquPyhd/lT3bdqLy0CXnwQxqJRXNSa7gtyFTYIOGAVr4g6Q8ci4
         u2uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751243524; x=1751848324;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rz7q/mLSazaciDJjcVPSYcL8l+KzHY3rbvo2kLwMng8=;
        b=JPDFK9uIspbxkMkfqBiYhDMQcB0B7tQuBUYCWEEKqjeFKCCa9rED6aen6IwTN16lH1
         tvUvjCAW7OKVgUEkaBu7WWn7myMklRqWdIpJsAn8AEwpFE/I0fQi0G3MelZR+dj2d93S
         y5KfQouIDauueTIhTiuKgQkQzwgaTwUOsqfk2ksIc5Ra1PG4CSyWnSPWJlrwiS33oy7x
         xliVykhxGWDVhmch5OjkRrdkEw66/9UVG3NSWeMMKk4zq65vAGd5xJM0uAbijS+hOxL5
         +mtXRQT5wTri/mOjCzVMQqnFkeV+IvKjLkJ8Q+YNX78nxVMTAl4RWt+fh7Owe6rQcU60
         9+tg==
X-Forwarded-Encrypted: i=1; AJvYcCU4mlPXbV0UBkgC+qjGUurzaWIqi2PMrSP7jqmZ6qMSQzJGCHpwdHftT7HN2b37qkp4OxTWDEpVwkRHfqk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTi1RKK87XNhuVmIxxWhRUX2+QnWXwRHgFCRfsIhzrMksirbYB
	BERlsMI7cy0vY0wOJHPXTUyh/voX4mePnbhjhFuOcHqo7raYGPlSLXfo34cTKtHcJSo=
X-Gm-Gg: ASbGncvhs73wOIktQ7XDWAZMVGSciymIMLGVlDSSBMYJq5qeDxcPMk5BcCgd4j9dPZs
	FtvduD3kkUB/M/fLulGHroqvQo6d0suijG7K0Z2A4/3pC5D3aH2r5SsmEJTVNR+KIg09yQXwH2a
	Rk06w4aD4biLaIOxQ2hyK0R0V1YJ3A9GYyowjvkLgsLlzqEbDAf4aaAzEq2dfds3ANQA07C0Psy
	d+xLmn0w4sWFGA64oyZoSaFI5lX4u2D3SxJIIqJVJZzLrV9UNuPyUxDksPKRaPZCnoHFEF0Axij
	6tjabvvomoPfGzmui+JsMzbuEHePFQipsVDbRgV71v7FrLITtrvr3xr8DyjPzvJrVkiht9eiQh1
	YFf/5B0oIQclwC7TaNrL8iKkaosyo0419LiE=
X-Google-Smtp-Source: AGHT+IHV8BL/WZwTciQ5tTsBYvp9HevklHMpopzWboeYBsH4XCwqK0uP1k7gV+5QrCOrwBU+rea1EA==
X-Received: by 2002:adf:c793:0:b0:3a5:2182:bd11 with SMTP id ffacd0b85a97d-3a8fe4bc774mr6503870f8f.20.1751243523771;
        Sun, 29 Jun 2025 17:32:03 -0700 (PDT)
Received: from ?IPv6:2804:5078:805:6b00:58f2:fc97:371f:2? ([2804:5078:805:6b00:58f2:fc97:371f:2])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a7fc139713sm51320431cf.22.2025.06.29.17.31.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jun 2025 17:32:03 -0700 (PDT)
Message-ID: <d8c2b6d6c992ae222413fd19c1b93360297903e8.camel@suse.com>
Subject: Re: [PATCH 6/7] debug: kgd_io: Don't check for CON_ENABLED
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
Date: Sun, 29 Jun 2025 21:31:57 -0300
In-Reply-To: <aFAiq3IEic8DuATR@pathway.suse.cz>
References: <20250606-printk-cleanup-part2-v1-0-f427c743dda0@suse.com>
	 <20250606-printk-cleanup-part2-v1-6-f427c743dda0@suse.com>
	 <aFAiq3IEic8DuATR@pathway.suse.cz>
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

On Mon, 2025-06-16 at 15:56 +0200, Petr Mladek wrote:
> On Fri 2025-06-06 23:53:48, Marcos Paulo de Souza wrote:
> > All consoles found on for_each_console_srcu are registered, meaning
> > that all of
> > them are CON_ENABLED. The code tries to find an active console, so
> > check if the
> > console is not suspended instead.
> >=20
> > Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
> > ---
> > =C2=A0kernel/debug/kdb/kdb_io.c | 2 +-
> > =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/kernel/debug/kdb/kdb_io.c b/kernel/debug/kdb/kdb_io.c
> > index
> > 9b11b10b120cf07e451a7a4d92ce50f9a6c066b2..cdc1ee81d7332a9a00b967af7
> > 19939f438f26cef 100644
> > --- a/kernel/debug/kdb/kdb_io.c
> > +++ b/kernel/debug/kdb/kdb_io.c
> > @@ -589,7 +589,7 @@ static void kdb_msg_write(const char *msg, int
> > msg_len)
> > =C2=A0	 */
> > =C2=A0	cookie =3D console_srcu_read_lock();
> > =C2=A0	for_each_console_srcu(c) {
> > -		if (!(console_srcu_read_flags(c) & CON_ENABLED))
> > +		if (console_srcu_read_flags(c) & CON_SUSPENDED)
> > =C2=A0			continue;
>=20
> I think that this is similar to the 5th patch. We should check
> here is_console_usable(con, console_srcu_read_flags(c), true)
> because it checks more conditions:
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0 + the global console_suspended flag. The console=
s drivers should
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 not be used when it is set...
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0 + whether NBCON console driver has con->write_at=
omic
>=20

Makes sense, I'll work on it first then.

> and we should also fix kdb_msg_write() to actually use
> con->write_atomic() when it is a NBCON console driver.
> There is hard-coded con->write() at the moment.
>=20
> But it might get more complicated. It would be nice to do it
> correctly
> and use con->write_atomit() only when nbcon_context_try_acquire()
> succeeds. We probably should use a context with NBCON_PRIO_EMERGENCY.
>=20

I'll check how that can be done by looking at Docs.

> And this should be fixed at the beginning of the patchset because
> it actually fixes the support of the new NBCON console drivers.

I'll try to send patches for this case first, and then come back with
this series once this one is fixed, so I can start converting the other
places like you suggested later.

Thanks a lot for the suggestion!

>=20
> Best Regards,
> Petr
>=20
> > =C2=A0		if (c =3D=3D dbg_io_ops->cons)
> > =C2=A0			continue;
> >=20
> > --=20
> > 2.49.0
