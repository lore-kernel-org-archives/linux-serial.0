Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93836215F49;
	Tue, 11 Mar 2025 19:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741722682; cv=none; b=i2K4YtU/uk7j96okLsTGst6daiQ7Lwe4O+U7bReBlTk8q9Wma10Tbzmw6MuVhizh4kVc633AICXHV7fCPUyqqJ1oBf46tY16Xcd54k2RkGrdifyz/NG+/nXsb/Er532RgaNt+0dYoDTWrSxFvH9DBLJHXNvTCPvT7eP9fy4+zWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741722682; c=relaxed/simple;
	bh=1XiiyhSjIdMN+KQ9YVpU4/OpuAaFsN5JjzysntZdja4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gP2qoM1QyGbOZ6JiYn2HwIwN/xQrdDKlXmjiU12MztaprhA0RFay9L7UvNpq2vNVBsckZLunq2uS9INS76PzdQA9hWpMJ4F3CjUeYSYdogj+eOQ232SdaFMspEHw4qxKIh1DStvtq1BQs9IYbkT/rl42xHeOxNN/2KquDoUB9pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PhdOjElb; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PhdOjElb"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ac286d4ed05so457321366b.3;
        Tue, 11 Mar 2025 12:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741722670; x=1742327470; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1XiiyhSjIdMN+KQ9YVpU4/OpuAaFsN5JjzysntZdja4=;
        b=PhdOjElbAGdP/CRLZDRVjDacCCnT+SXTMJa6L3AdMJ6DLcL5YWzNWteppJ+cqyrs1W
         gjMpUyomDKo8y5hD6eMgjliFjZ+U/sQMtGi+wjLadha9/9ZOWYOzVDfy6gVUODHMe+99
         Lht0zP3Z5T4+pvVLAYCO4GJ0QGDiHdtUaJYB6Do7zU5wcRAle913fiN7cOwl12gw//N6
         UuM6y9xnWkqHkKgi4cES8tau9PGNqT2e09eDAh5SNABzj/aDf8QKn8WoKzk7NRcoCfLg
         qYqGgy5dHUqcV9th/9+Ef90yq8fzff3P7FFE8jt3mOTKmKtbsomN3sGhTXlSJtAgKC3+
         bR7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741722670; x=1742327470;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1XiiyhSjIdMN+KQ9YVpU4/OpuAaFsN5JjzysntZdja4=;
        b=ie5IANxtRHXPTxlQRfHHzkEQpkNcSiCdHqSQNo1q6Vm1aX6FN8QQsiq0MIjmNJ+0Li
         yf5G3HzPteVILF8Pc5MfVOjvjHmNdCgxfBj3dtYGPnR5eLXjE+5K8QUpCwnfk4vm8WgC
         KMllYEbb1SG0istetcz2WhHWJ3qtbs8FctP0lvvnmYUVwQfu+ZYQ+e9upE3fc39mv0Cf
         YHEuLRlS4EygXIAeN3Xh6ealVPtZysg3XoaHngr6Py+RvKtGRlfy4NBLc6DyYnXPV8hC
         +HWC9o0JKyfMMRvKqd7opP2jF44d/CrcfGEYa/5qHpuEpbbVsThbzYYb2ezasl0C6EW3
         u2vA==
X-Forwarded-Encrypted: i=1; AJvYcCV+gpirtf/OohYoKwMZGZnpEEys471bgqZ1PMyBiXcJm/R0E+5HsWWVf83bcKV2rhTsxt4zbNasoQkNkGc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+je6qCbaU06TiKu3g7T+4G6i7XRwhS9Iy1hCFM4+dNe0gKCf/
	CTKDHrIjKbNRWOmSLMIzfFZIKh7MTlKXTiONraoGY6RB7Xs2YsyvS4+f6MtHKolpToIYMr3kpiW
	U8MppS4X3bNyTXLfCettoXh797MI=
X-Gm-Gg: ASbGncvDL89yxihItvUdqGlygOjZkSxuasLTL/JIoh8+25B9QD3gg98dw7/x8B2+W/E
	kLCnMOz0WMg2CaCqoUyvt7sGgfmHjuTHFUJXGbB+ETb8Q2gocjSD3o/krQ0rE1Gz6Lxs2OKg8CY
	R9zJ1pdXDIm/hGgClx3Awco4H1zg==
X-Google-Smtp-Source: AGHT+IG9Gr1f8rMm05j79B4xLtmxoVY4LlRAvD16TsWK67Pl6XdwpWS/CUFHEptIDAtRdxRwqE0Xt0lyx450BCpcePQ=
X-Received: by 2002:a17:907:a193:b0:abf:51b7:6071 with SMTP id
 a640c23a62f3a-ac2525f212emr1665065466b.13.1741722669555; Tue, 11 Mar 2025
 12:51:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250311033133.1859963-1-adamsimonelli@gmail.com>
In-Reply-To: <20250311033133.1859963-1-adamsimonelli@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 11 Mar 2025 21:50:31 +0200
X-Gm-Features: AQ5f1Jp-oemBgR9FgNx9-Y7GGuBjTL7vhQ4QSfTx-DLhGAsuMi-CmV3LSov53-A
Message-ID: <CAHp75VfLk7_79akWb=t1BMii1jtBxzcEcYoBH7AmA8+Gh03icQ@mail.gmail.com>
Subject: Re: [PATCH v8 0/4] Optionally allow ttynull to be selected as a
 default console
To: adamsimonelli@gmail.com
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jiri Slaby <jirislaby@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Steven Rostedt <rostedt@goodmis.org>, John Ogness <john.ogness@linutronix.de>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Petr Mladek <pmladek@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 11, 2025 at 5:31=E2=80=AFAM <adamsimonelli@gmail.com> wrote:
>
> From: Adam Simonelli <adamsimonelli@gmail.com>
>
> When switching to a CONFIG_VT=3Dn world, at least on x86 systems,
> /dev/console becomes /dev/ttyS0. This can cause some undesired effects.
> /dev/console's behavior is now tied to the physical /dev/ttyS0, which whe=
n
> disconnected can cause isatty() to fail when /dev/ttyS0 is disconnected,
> and users who upgrade to a theoretical vt-less kernel from their
> distribution who have a device such as a science instrument connected to
> their /dev/ttyS0 port will suddenly see it receive kernel log messages.
>
> When the new CONFIG_NULL_TTY_DEFAULT_CONSOLE option is turned on, this wi=
ll
> allow the ttynull device to be leveraged as the default console. Distribu=
tions
> that had CONFIG_VT turned on before will be able to leverage this option
> to where /dev/console is still backed by a psuedo device, avoiding these

pseudo

> issues, without needing to enable the entire VT subsystem.

LGTM, so FWIW,
Acked-by: Andy Shevchenko <andy@kernel.org>

--=20
With Best Regards,
Andy Shevchenko
