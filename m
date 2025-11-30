Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1639E2C0F9A
	for <linux-serial@vger.kernel.org>; Sun, 30 Nov 2025 19:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764530670; cv=none; b=IF+FpA3rlx6LTq7j3PgK4a9yneIGPnSM0NDwa+4/imPGZ0dA447662onbRQzL9VNYN/Suu+VxfbMuxs4h2I/dCoEtQcYO5qbRPuEyBEhVUSRsu4IeC27Q/epCwfcgABb+mMY1kgHfebiocUzWmpVooTvmPJ6vXIZjXJEd+m4FZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764530670; c=relaxed/simple;
	bh=iEA8BfmPTEPrAXky1vVg5GGWr2J6dHFK1f5PPvtOLXk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B3n1Sw/qF3jZb7h1PjDq7JSjfU5Qn4iJBt90tEG9e/z9AgcqHEQuQqZzDCXiCZOeEDY2nb/kQiKfu+C6UkRv6TgPedfql6BH0ZkxXTsKcIUjIqZiMK4UcJLmtGxNcTjPSKevFKTNeYtubmzAjk0iOE7EC2tuz6vCKvWHv8D9pDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GamZlT7b; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GamZlT7b"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b713c7096f9so559615366b.3
        for <linux-serial@vger.kernel.org>; Sun, 30 Nov 2025 11:24:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764530667; x=1765135467; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iEA8BfmPTEPrAXky1vVg5GGWr2J6dHFK1f5PPvtOLXk=;
        b=GamZlT7b1D2qW+h5MyiBCKSfYBVvNWwxgs6lJg22nohySznJ24mH8LkwoQV5vhj0mt
         5KytENWkZD4ttg3X8CVrpHPi6rXy+L+q+rzQkSUrQ4KsFAIOqVPJhVj3RdA+e5FrVaSC
         T8iTvNfQvb5RS3jOrr/T7Sr1sx0Sj4ct7N+kapG6MyvkprXHLrWD6MWIAKw1htwG8w5K
         cvRYMVx5FAB5x9ULho1C5rEvwLhhsY+QPI3AIrub2PWjQ3bfjAENQV7fZMDSnWnUZeL4
         hhPPi+eKKL25vQ+v2yb+LUz+9MPMZ2rtMtGGao3S964VT+Ydcmd3pjTaex15D8M0QMfn
         /r4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764530667; x=1765135467;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iEA8BfmPTEPrAXky1vVg5GGWr2J6dHFK1f5PPvtOLXk=;
        b=h8PDOz01q6WZd2+NxLbf6HkNbkFYmpFPFakgQqGDbA7NKD+8p7ldZRHzycKadeFjis
         PuXjaQ4ZSTB+afVW6ErCQ0AX2FqN8UaJ2aBQiae5lATysl7iIa9AqadlVSDUGPAN0Llj
         tntBJS4NWMS7TeU3l0RpTKmLXQP9FXnrRSkqF5XxHe8gbJHtne1A3qlDCh9sEdqVGAaL
         f4W4oe9WIHceDydV3wYa5Jy5iXKyQ9lNEMRFSLD6UCnaTUvmCTcLJ8QRkq92aQ3pesm/
         vaOX99QfiEZQTvnXWiz7dk/q/e8QP9Wgc9d8sIf3wndL7KPNBNLm+PQqRo7qf6qhv35o
         QuBA==
X-Forwarded-Encrypted: i=1; AJvYcCXaAl0w3TYuuT5F85tcVnsuL4xxPIQ8sena2Nhxu0pb4NTPu1qospfT6Z+jGvPWR5OvBQ00xNqwl72p+P0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzG+ao7XG7r2shxwMlHE0wxRksyNE+lUWnhGNBLcs733E2k/Xvl
	pNnviKDfRxGYbzZvnHsjxBeV3ICvc3LqQ2ToM3Hv7Txh5hBmRw3MOaLtQMxPglcluVwoT5ROmSO
	rU6+yvYcFLrL2BSXfaD0YGnsJrvLCf8qsbKVV8w8=
X-Gm-Gg: ASbGnctbTSCxBMWmWScUM3yk5HRBrJmPJWBFAVznzLU+y8e4TE7eorFWn+p5VInrZUR
	ZsrUMsadqTs+Up1+3DKzhUmKhOBO84+6Heo14xr3GUve0NqSh3ZNSuOCzPiDQiprVYWj9AUdsgu
	DnZF6wIvOOONYBn9cc6nRU5XYVwZypLQFz2IwMz/3e0KU0uyn+YiwQ/vT8S5DQUWJQj7zb//ILF
	2OFZgRHnEncju8IKu5W8ShR6qYJb8nAx3xGAVusji9MZ+cfMPpX0P+ECOVbnTE1vHc6aH0zf9QJ
	rIQphV9zs6eeOtChRxVNcAuNg0zL+jdx3drfsMI9+Dbofp1f6MC8aYo5KekhzpjWsYzDMc90WD8
	G7/y3wTJM7jmiqOjwyQ==
X-Google-Smtp-Source: AGHT+IFTeWuwwEH00tAdhZ4SWgcl5/L+ikjyAOftov3Z6jNJjdwiRH641ILBXr94igQhyMGeNGVo1IDCtTsLm1xZq8M=
X-Received: by 2002:a17:907:7213:b0:b73:301c:b158 with SMTP id
 a640c23a62f3a-b7671549d14mr3995853766b.6.1764530667278; Sun, 30 Nov 2025
 11:24:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251130104222.63077-1-crescentcy.hsieh@moxa.com> <20251130104222.63077-11-crescentcy.hsieh@moxa.com>
In-Reply-To: <20251130104222.63077-11-crescentcy.hsieh@moxa.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 30 Nov 2025 21:23:51 +0200
X-Gm-Features: AWmQ_bkdn5SKV0_T6fvqH4G-pgw4EvL26PyOZ-i3PuNEM2pSR6UWP7N0-1FDw9w
Message-ID: <CAHp75VdyA+fcoRBHO7_i0N3AgQ0Kja1cpNkoxttfzZvjv3qH8Q@mail.gmail.com>
Subject: Re: [PATCH v1 10/31] serial: 8250: add MUEx50 UART configuration
To: Crescent Hsieh <crescentcy.hsieh@moxa.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	ilpo.jarvinen@linux.intel.com, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 30, 2025 at 12:44=E2=80=AFPM Crescent Hsieh
<crescentcy.hsieh@moxa.com> wrote:
>
> The MUEx50 UART does not fully conform to PORT_16550A or other standard
> UART configurations.

Same Q, what are the differences?

> This patch introduces a new UART configuration to accurately represent

Imperative voice.

> the MUEx50 hardware capabilities and applies it to Moxa PCIe serial
> boards.
>
> Signed-off-by: Crescent Hsieh <crescentcy.hsieh@moxa.com>

>
> s

Stray line.

> ---

--=20
With Best Regards,
Andy Shevchenko
