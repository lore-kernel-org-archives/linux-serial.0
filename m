Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F17DC6125;
	Mon, 24 Feb 2025 00:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740356607; cv=none; b=soZSjC03rgWCdoiNmapoI6WHUrs7Nu2BKIqZZKDnNAEW6jmCfexGfvqTFvc8Oehy1isrt164vS75/oCXkN2/Knz5sSt+2coCFPRLUsWsOrzBm5J5RBYsNIgIxYmyP6fAH3gLHtaozHCFZiZ+6jkXQZB+XQfMu8Mn9yllchPftNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740356607; c=relaxed/simple;
	bh=9PfFQv5rpvfO87F+TZBj1QMCFUL8jKYvXjKgV9ecBv0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mq8U/DBEMREPUBbhZ6f8xBXTLgbygH2+ZsOAhuBl7qC3KUxhgqfC7p1ffmdrFyQhxjsyzUr/SyIG+qWPPNC5laIn8+GBKm1v6dEfXGRHSJIbE6G5m+Fc/1YtPb7vDIIr2JF36454MtwOApQpDi2ZmHz3/I6Vw07CcOV+WRg0YMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FDFJ7SmH; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FDFJ7SmH"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7c08b14baa9so365553685a.3;
        Sun, 23 Feb 2025 16:23:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740356605; x=1740961405; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bp8Q3VOPQDS+11tGhMzOHaekmo8JCJ4+f6K7eG8FK5s=;
        b=FDFJ7SmHZYMDTlNQ1V8fgB1KRgE4yPEViBHohF58IU2N8O1zRCNGWxZg/vP7spAeIB
         lQZtBTMi1p1wi9copkXaWeut+seR9Tpcabp+7NNMee063TgidcCTfwKIViT8suCJIrQB
         MaZOaVBuSL5aLTb8YBtbTnSldh+cVvR5aLUJ5tt0xix7o2Vnbz7H/a2yLswuxo+ZcLuo
         BB4fro3xOxWV0CdYDv74ar0u+N8GXdLJl5wHHKi4mF6lzwMvBmjSbzNU0S+i0W0/MxeC
         qxqkhonb2WFBGcQvw4FGpmPYGYYThp50Z5EElpBhoQeZUJW6Z2bWJL6eNQaU8El1GipM
         q87g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740356605; x=1740961405;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bp8Q3VOPQDS+11tGhMzOHaekmo8JCJ4+f6K7eG8FK5s=;
        b=OAXLaLXiFHbh4nAoGGMTc6QnxGBPxXj3Pos2JYXx7btCDMDaWb2KExf9++A5YnZTyG
         Q290i49snzHECkw9DjOxPQzJpPiSS6THZRZqO4XOi4dBSWMXwEAPSqbuftjqhZooyD/m
         noJ55PwPLe6Jw8GGKG2/X9X2uiNbLYTfTbxk9ntsX6KanBHEj+uR1d0h/zV34iLemu8H
         ZsoAS9WhPsB6bYEoRxyj+W5WFskxfvF5/YtZ7Y6WBP9tqxW4Zu/N5DAy0N+2ynWtXW3Q
         JS0XUC7UDyusE0xREOFiVaGPx4bzw9rtcTeHh3ljrO4Erg6zDFy/JktvZ96TMelPAAxt
         N+TA==
X-Forwarded-Encrypted: i=1; AJvYcCUMduRDTMz0ruyDL4xJOr9w+53ZvbIZ5XhJwVjZt4sWfEc9F6sk13PtqR40ClJxodpYH4ffFCeNug2C2BA=@vger.kernel.org
X-Gm-Message-State: AOJu0YziyALGRI3dhTOxwdPHO9oKrvze8iBbstVlSN454Uu0FiWrtUm4
	m8JmSdG7x0j4zO8oACvBnGheO9aVq4IfYl585q/OFQuE6sgREaDz
X-Gm-Gg: ASbGnctONgQvHUCh7bdNBMpxd+mMD82wZ/cI7MAIbI5U3muSQF8sWPGKwos7m+z29Q8
	VdqPPMAN/8fbxjb1p55JX6Tcse9iF7JLf9A1WtrQW+Vt4kIY3mKCDYKQea/l34kyGkD/HAwgdab
	K6qZVajzqmSRe7OGnQEzW0gpKnV6DnJ7aYwof1yzf3A27tnqfjKQOsfVZkYZPJQ+R+9YD1kcnDW
	lfasCYBOrpcCOpLoBxkzvJUsEm/AomGvIlXf0gHTcOvT3hl6eP/OKMLIDNAiJ0D++2NTTltbXPl
	a7Yvdl3MJ389DDONWSIg5qa8Zo7CyM9FCVpzbwmivnZS5w==
X-Google-Smtp-Source: AGHT+IEIE/Ap+XXQ3t7fuy1XUUriR9MDNfKKWNFqQ2eYbmzLNsuSK4UzJMzsPP3xMEPPYDJ2dx+c1w==
X-Received: by 2002:a05:620a:1918:b0:7c0:b103:f252 with SMTP id af79cd13be357-7c0ceee99e0mr2002097985a.8.1740356604811;
        Sun, 23 Feb 2025 16:23:24 -0800 (PST)
Received: from nerdopolis2.localnet ([2600:4040:5e66:a800:7a4:75e2:6847:49c9])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c0ade609easm761851585a.69.2025.02.23.16.23.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2025 16:23:23 -0800 (PST)
From: Adam Simonelli <adamsimonelli@gmail.com>
To: Petr Mladek <pmladek@suse.com>, John Ogness <john.ogness@linutronix.de>,
 Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jiri Slaby <jirislaby@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject:
 Re: [PATCH v4 0/2] Optionally allow ttynull to be selected as a default
 console
Date: Sun, 23 Feb 2025 19:23:21 -0500
Message-ID: <7410687.31r3eYUQgx@nerdopolis2>
In-Reply-To: <Z7uOsqky4Tw9J6QR@surfacebook.localdomain>
References:
 <20250223204456.1913392-1-adamsimonelli@gmail.com>
 <Z7uOsqky4Tw9J6QR@surfacebook.localdomain>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Sunday, February 23, 2025 4:10:10 PM EST Andy Shevchenko wrote:
> Sun, Feb 23, 2025 at 03:44:54PM -0500, adamsimonelli@gmail.com kirjoitti:
> > From: Adam Simonelli <adamsimonelli@gmail.com>
> > 
> > When switching to a CONFIG_VT=n world, at least on x86 systems,
> > /dev/console becomes /dev/ttyS0. This can cause some undesired effects.
> > /dev/console's behavior is now tied to the physical /dev/ttyS0, which when
> > disconnected can cause isatty() to fail when /dev/ttyS0 is disconnected,
> > and users who upgrade to a theoretical vt-less kernel from their
> > distribution who have a device such as a science instrument connected to
> > their /dev/ttyS0 port will suddenly see it receive kernel log messages.
> > 
> > When the new CONFIG_NULL_TTY_CONSOLE option is turned on, this will allow
> > the ttynull device to be leveraged as the default console. Distributions
> > that had CONFIG_VT turned on before will be able to leverage this option
> > to where /dev/console is still backed by a psuedo device, avoiding these
> > issues, without needing to enable the entire VT subsystem.
> 
> This rings a bell of the following
> 
> https://lore.kernel.org/all/20201111135450.11214-1-pmladek@suse.com/
> https://lore.kernel.org/all/20210107164400.17904-1-pmladek@suse.com/
> https://lore.kernel.org/all/20210108114847.23469-1-pmladek@suse.com/
> 
> I don't see any mention in the commit message about these, have you studied the
> cases? Will your change anyhow affect the described there?
> 
> 
I did see that sifting through commits, it looks kind of different though, as
that was to make ttynull more always on, and if I am understanding it correctly
it looks more of a last resort? I could be wrong, but I see it was attempted
and reverted because of conflicts on some hardware platforms?

The scope with this new patch set is much different, as it has to be manually
enabled on top of CONFIG_NULL_TTY, rather than assuming CONFIG_NULL_TTY is
enabled, and adding it to the list of preferred consoles. It is more for
Desktop configs that are looking to disable CONFIG_VT, but still want
/dev/console to not be a physical device by default.



