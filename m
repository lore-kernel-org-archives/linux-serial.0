Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3976088F
	for <linux-serial@vger.kernel.org>; Wed,  6 Nov 2024 01:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730855075; cv=none; b=a3rMhzp3okHBBiTHMgdr/efTVYh1xxMtebHIOUjXyfIguGqS0UKOH6nLiAt7Izk3a95eEdgZFr1nuSQB7gNfv0KL1f6uZ20iG4U6uhGDyL55pWEVBrjF7FcJB82FNTNf3QsHjmuW0yefEBlxMtPFHeiLy0GuXywMBq5H0dQ/LLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730855075; c=relaxed/simple;
	bh=YnoaJCxB5vOK8s2KcVyw92yWkZc9UtsTKiI3HljFdQQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GMz8wz2niF22RKVkUN6FL9YfMw80kZEQGJEM8ha+amZyk77TfPJ3pNdzj1Q1OtVpAizXQB3m6tMh47iAbB5Wd1b1XC65whZbqhGUrBaaatWXJnK0v3nEjZ0PNlyHoa8z4Nlic8mWm4MCQhw8csUxwW4NhHFfPOrfj//es05BLM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=c41xDwVr; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="c41xDwVr"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a9a0ef5179dso1002915966b.1
        for <linux-serial@vger.kernel.org>; Tue, 05 Nov 2024 17:04:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1730855070; x=1731459870; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CzyAiZwV3zI1ErKNO9AeIxWpczJPkU1EIgTXrkb5ePk=;
        b=c41xDwVrbFmnx3VSoiYJBddq0qK9ZqRLYDzWvwe2u1hd7g6X4CnyTt04pVfwftxK++
         knSQDIKj/4rI0NWbRFrYTAjnCVBOktYWSqV87jwMiFR0QkIfOpYTwpcC9S+aRZRB+jz3
         EX5gB1LDVEsMm4PZMfxEdJcpHste75J7H4L9EtClmhN2gT/EzdXM12VCbrBmCqKkpVXX
         vQzl1v1MjNd1TaCX/3NdCU1rRJu8agVhfRLCtAhxjbq2Q5pLK0V8OdQRPKnC37d1P2U5
         jneTnz4yiT1QxGlxm7xjTIBAzsJ0wfZHnf67oAF+HouKkGqmVMhldkHyFDJDI9IRVfRm
         26GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730855070; x=1731459870;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CzyAiZwV3zI1ErKNO9AeIxWpczJPkU1EIgTXrkb5ePk=;
        b=oEwx9ALewTsqxx45zYO0W+98N3p2KlEp9EUWgY/ZusK6kOIPoTSNBvLb/ewNsk01Hz
         H4P9fmb1gtVbHPOPQdVRnP4KKu7zDv1mUdSAYft0JFJ3tcg4jYzlg/SnDvSo6jH+Q5Az
         1vEacbV6pavqLuMEHbsg8ts39TCJ26qM5fdO7s/riq0aTkjYQZrD+wfLefMzlgpz4VhU
         24LbPBaGfe51wMaeq3LxMpgIkx6VzfA10d42DUKbe0cLk/as2YLcJjl9nZDg0vl82Tu/
         ZfGCM31fU+4sNbYH81smpCLTftG/7YlLyMHMj4IhXuNkfGCtVCGzda1LuiH/2dOU1d40
         f4Dw==
X-Forwarded-Encrypted: i=1; AJvYcCXiaIvjUGquBSCCCqEAWxxsrAmWz2zNhneCCkKz8j71AgUfCm7R+J1wxhTxnBahKrajNNQqt9Dsh4ZhjDY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGk3xl9jwlS+bKKltHnMvmD8xbpGl74CrvqE+rE03mjIeILX95
	Hwnzri3l5Qbatm+v3Aq3JN9rVDGxV3961us+ssxXvfv2eEFQIXW82z329+w1VR4=
X-Google-Smtp-Source: AGHT+IElOCmPLOjo0CUxsQSOVDdfLh9JrCt9HIGcbmrxqY3QMS+TsHFtKnTg70HjlF5k6jITqyCyvw==
X-Received: by 2002:a17:907:7d88:b0:a9a:c57f:9634 with SMTP id a640c23a62f3a-a9de61d1a97mr3901538966b.42.1730855070450;
        Tue, 05 Nov 2024 17:04:30 -0800 (PST)
Received: from [192.168.3.33] (69.36.160.45.gramnet.com.br. [45.160.36.69])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9eb17cf8bdsm204479566b.123.2024.11.05.17.04.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 17:04:29 -0800 (PST)
Message-ID: <32c882534566f0a9ef578cc0fef20e5aab77eee6.camel@suse.com>
Subject: Re: [PATCH v2 1/2] printk: Introduce FORCE_CON flag
From: Marcos Paulo de Souza <mpdesouza@suse.com>
To: John Ogness <john.ogness@linutronix.de>, Petr Mladek <pmladek@suse.com>,
  Steven Rostedt <rostedt@goodmis.org>, Sergey Senozhatsky
 <senozhatsky@chromium.org>, Greg Kroah-Hartman	
 <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Date: Tue, 05 Nov 2024 22:04:24 -0300
In-Reply-To: <84ses5e55o.fsf@jogness.linutronix.de>
References: <20241105-printk-loud-con-v2-0-bd3ecdf7b0e4@suse.com>
	 <20241105-printk-loud-con-v2-1-bd3ecdf7b0e4@suse.com>
	 <84ses5e55o.fsf@jogness.linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.1 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-11-05 at 22:40 +0106, John Ogness wrote:
> On 2024-11-05, Marcos Paulo de Souza <mpdesouza@suse.com> wrote:
> > @@ -2947,6 +2953,7 @@ bool printk_get_next_message(struct
> > printk_message *pmsg, u64 seq,
> > =C2=A0	struct printk_info info;
> > =C2=A0	struct printk_record r;
> > =C2=A0	size_t len =3D 0;
> > +	bool force_con;
> > =C2=A0
> > =C2=A0	/*
> > =C2=A0	 * Formatting extended messages requires a separate
> > buffer, so use the
> > @@ -2965,9 +2972,13 @@ bool printk_get_next_message(struct
> > printk_message *pmsg, u64 seq,
> > =C2=A0
> > =C2=A0	pmsg->seq =3D r.info->seq;
> > =C2=A0	pmsg->dropped =3D r.info->seq - seq;
> > +	force_con =3D r.info->flags & LOG_FORCE_CON;
> > =C2=A0
> > -	/* Skip record that has level above the console loglevel.
> > */
> > -	if (may_suppress && suppress_message_printing(r.info-
> > >level))
> > +	/*
> > +	 * Skip records that are not forced to be printed on
> > consoles and that
> > +	 * has level above the console loglevel.
> > +	 */
> > +	if (!force_con && may_suppress &&
> > suppress_message_printing(r.info->level))
> > =C2=A0		goto out;
>=20
> Rather than adding a new local variable, setting it, and expanding
> the
> condition, it might be cleaner to just update @may_suppress before
> the
> condition check?
>=20
> 	/* Records forced to be printed on consoles must not be
> skipped. */
> 	may_suppress &=3D !(r.info->flags & LOG_FORCE_CON);

Well, your suggestion seems clever than what I did :)

IHMO, I would prefer the new variable as it's easier to read (for me at
least), but I can change if you think it's better..

>=20
> Feel free to ignore this suggestion if you think having an extra
> variable is easier to follow.
>=20
> With or without suggested change:
>=20
> Reviewed-by: John Ogness <john.ogness@linutronix.de>

Thanks John!
