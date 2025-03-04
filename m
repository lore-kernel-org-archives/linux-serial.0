Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF44E1F4264;
	Tue,  4 Mar 2025 06:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741068109; cv=none; b=ZBbgqvtUosaFsxMDqF1Nb6PR2WXrcE5fC3wrbN4wp0WcLQwtnEUPVxHe05zhZgts/unrjG/Z0nCyxE+7P6loUlVFk71bNKs1DpH0SpWNzFVFXIG2YIQ/QouU8jlvNgGYaA7nWqVnnsX6BN2sox4TA/vMSwp9VrTAvi7yfbVT2ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741068109; c=relaxed/simple;
	bh=M8f3XUCGhLEqewiDBod1VFbj1G6E8rBSx/l2zcFt65U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iEeHfnZQ2w1b/y/MBXXGfpYfA7JRjJ/Qku1WCWDBh7gRkTDv2HqyTrhTywqVL6Bt+/A/fbWAfMPsY3IBdfJMgPlnYoHnrftVElpaMW5zLa8X3bZTU2xVc6H5JipesJS4epMqVjXYnx23Ta35m/+vtRjtMzqaWOHhngzEvmYCct0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GuyKfwRJ; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GuyKfwRJ"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5e51e3274f1so5292176a12.0;
        Mon, 03 Mar 2025 22:01:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741068106; x=1741672906; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M8f3XUCGhLEqewiDBod1VFbj1G6E8rBSx/l2zcFt65U=;
        b=GuyKfwRJ7KjQ/Q8G1yf5LmDiTKgLIzFrQ7S1HoWCc0vZ38TWM1Bdw5tRJSPLR0zyjq
         Z6PC0vMu5EuB9Rj+ElnehTlGGqnP5xnLUFLzmpJZZiaXisgfjrSItuPCrgrE2Q4nEP5m
         j+0diUAzZ/k5Gp/ZIJAQozDm3ti89x9klVV07DMbyFdihgPKHzlK3aqW37CBWGbxui68
         SQktDybDd0/rbswf8ROJ5z2fNcYhjAtlRQA8tNbl5olNLtfN6uFS08dwRCcylWenQfCu
         i9miSFQxmlBPM8IXOVq4J/omX0agLI9PbW9D0i4KFMb5L/fIF5AuehHoZg2llY5LcZgN
         UYiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741068106; x=1741672906;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M8f3XUCGhLEqewiDBod1VFbj1G6E8rBSx/l2zcFt65U=;
        b=LhQwfT4ULGKzybO3BX7KuUsd17gRLwMuPMmnA+EMeZrr3X0QpSnpATNFseVKs8ypBJ
         QW3vcr5UO6dUaR6VyzlEldEpKxty4l9ShdrR1lqGcd/N4HKhKpsi4/bhpXtta54ch7xf
         JuxWbHHw+FJ14E77Xnbb2ZShQ1Qh94RLltGzkZxXA0R8yWpzc1P2zjX49+InYmMwwcKd
         XCUfTJhydJR4bkdJDmb7L8+SXrOgfGXqHSilQ7XQrXfccJ0o1uuk1xjUTSaB7c92TT/Y
         i8iVU4LsiBHT3zOCND7o2gQFYUsqf0j8akMC3UispwDGw62c/uj4NyVsms9xtJY6XOCA
         V03g==
X-Forwarded-Encrypted: i=1; AJvYcCUNRDolpAfZU/8HzWD5cuncS1QVdtrNxgPXNhwMY2X9sAH2w7F05zkYbTPqr9k28UQb+DZteLUfgVa+EDg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxwdh/kjq3l1qX5ItSfHx8LYWl47JsTt4Yl8kJsgEClx+9rMUGq
	r6836wSuovtYpNGSnFCQbshlFJtY42/Tb2SAy/8stxcGifpfDdFBPmKZBJiq/ns/DW+z+A7qXQQ
	OUph/1KRDm7RQLcumDhcgO0hjGEc=
X-Gm-Gg: ASbGncuwxSfHemPFtlN7EHFH1D6CfRI/ceTimyHCZobgIO/BtP7wsJHWrckWuSrLYpl
	Sk1L80utqs03vSpHMUphcAmS0Bxk038IYa/z534yV5C/WmmRRVL4Mc2ka7YtQF5sK4FnD7Zq/CI
	Ik6vwoqgV9shxlNCdexuigrzH4UA==
X-Google-Smtp-Source: AGHT+IFmSHDaW+D8y9mLaAEaFXmeW/xzgvtHJ4EobvOHYC2UVdyDaTlljcJs1/wxeyqh/u/uFz0j1ht26OhGEnDZwec=
X-Received: by 2002:a17:907:1c90:b0:abf:663b:22c2 with SMTP id
 a640c23a62f3a-abf663b273cmr1079907566b.51.1741068106121; Mon, 03 Mar 2025
 22:01:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250304035447.3138221-1-adamsimonelli@gmail.com> <20250304035447.3138221-2-adamsimonelli@gmail.com>
In-Reply-To: <20250304035447.3138221-2-adamsimonelli@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 4 Mar 2025 08:01:10 +0200
X-Gm-Features: AQ5f1JqymILfGcNEM4X4di_XTN-xfSkevWbj_Z43am5oV1UXemdjFSPi4H6R-r4
Message-ID: <CAHp75VdYOWkDj0VTa5H9V7jV=Sr5O4=L-1TN55MJU=ownOAJ1Q@mail.gmail.com>
Subject: Re: [PATCH v6 1/3] ttynull: Always initialize console index to -1
To: adamsimonelli@gmail.com
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jiri Slaby <jirislaby@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Steven Rostedt <rostedt@goodmis.org>, John Ogness <john.ogness@linutronix.de>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Petr Mladek <pmladek@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 4, 2025 at 5:55=E2=80=AFAM <adamsimonelli@gmail.com> wrote:
>
> From: Adam Simonelli <adamsimonelli@gmail.com>

In general we do not accept empty commit messages (yes, it was done in
the past and in some exceptional cases, but should be taken as a very
bad practice).

Should it also have Suggested-by: ?

> Signed-off-by: Adam Simonelli <adamsimonelli@gmail.com>

--=20
With Best Regards,
Andy Shevchenko
