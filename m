Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98F46A33F
	for <linux-serial@vger.kernel.org>; Thu,  3 Oct 2024 18:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727980230; cv=none; b=lFlaHRo4NdLembAHtjxUwQto2Ko65O4/MXiQSmwqpgdPaGAGk3HocIdubtlpzYaqWaA/D2rBfga9ME95ZR3Q1pg8bs9jdgN/C8ay6VAk6TTGag5n4rr//FoS3d5LsniXYR5Jb/dj4y6kVCGXdM9+IIMooiHgq+1ql3Z4JysNelk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727980230; c=relaxed/simple;
	bh=c++Lte/udt0jLRhLlSKN7fA6Bnq9Rxf2y0Cj+HWhPvA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lUnm+No6DEotqxsYjEi5rT+tLkhYvAwT0mCUp8JkleX2egsGnB7MwQ74U7Wi5g2nQfcVUdfr+HZQSrJD1QnKDmKyoZkpQlOEFm+Ab9ziWnBPsPWPv4RAwKieHp4BMg+RCj/e18mYgiFe+MVeKirHCBJP77TqxsKY/n3GodtmadQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Ky77V5bT; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ky77V5bT"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5398e33155fso1680970e87.3
        for <linux-serial@vger.kernel.org>; Thu, 03 Oct 2024 11:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727980226; x=1728585026; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c++Lte/udt0jLRhLlSKN7fA6Bnq9Rxf2y0Cj+HWhPvA=;
        b=Ky77V5bT+NZ4VKyF9ecjsztDbl4sUMB85rtmpfY9RbzwnC9mgGcmj+VCeya9/gfnUu
         dyeApDNXP4EzK5xS0sx9OcCA1EB/sW1vMMo7woNGNnrzb5fVQWX5HTn5Q0A53nVjxPwj
         xyC5C9AstbYoLyVC1pWI8F/WGgnbGJQ4QrH48=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727980226; x=1728585026;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c++Lte/udt0jLRhLlSKN7fA6Bnq9Rxf2y0Cj+HWhPvA=;
        b=gqbSPCVHp++X4WzT1xPKykuOV+dQApxFpFWseFnHma4iJ16qj1mR1kC1u8lAiey6LH
         +dqjYaGRyJNG5h2Fdgw2sBLOFT8c0cjqvQGWMGmySaV2N8uJ7d6u+t8Q6tJP5nrgo2Sh
         8CX8RuWH8ppJ4WxBgHsJwKG9JxBfIp7AFSQZwQ1ffcB9WhBJ9UkBMi1Xx6zykcELrYwF
         tJSfagzQMSJaQ06WSOCgIu5fAxO1ZdL7wauGovXP8PpOF6uVMxbHb51jEt+TjLX/S+rh
         ffHnTcEf6T6JEkmKcmHlKHeIkuRmHkMfejses/c/X9E+QcpijdsEYeOg15eJ+1umVxVx
         IJ/A==
X-Forwarded-Encrypted: i=1; AJvYcCX1N/MUGj9GgSVKZTphEJhYF5zK2gZe7PWnBjh5GA9eYkDEseDYw36csHqdo7WCEy6dviPNJ3sM94IAlik=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5a4UJJ5ypyhsnEPMrGPT8kTLx4ZqMof2Bq82BMCTSQ05ZFrWH
	t/UKY44TpfTwhStSPw/3Or+VgM1zyANeGcK1XIjsex+Z6Wb804oUEmKPN/liWRnTNWJfCUTisTG
	LoYMe
X-Google-Smtp-Source: AGHT+IFZcKKHLUgw+7wIlphmaCCDZy5hYhHOaATEM534WD0+Xiq7SrTC9n96kkGYaBt/Y9WRxvyrJg==
X-Received: by 2002:a05:6512:b2a:b0:536:553f:3eec with SMTP id 2adb3069b0e04-539ab85bfb8mr203896e87.5.1727980225845;
        Thu, 03 Oct 2024 11:30:25 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-539a82a3945sm232433e87.221.2024.10.03.11.30.24
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Oct 2024 11:30:25 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-53959a88668so1676520e87.2
        for <linux-serial@vger.kernel.org>; Thu, 03 Oct 2024 11:30:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW1c87cEzdBNloGFrY4pIinZLFzEWxebDNTBSb8e2lEl0/llREca6sMNyvVGAw77k0fhSmmhRA0xWfdvWM=@vger.kernel.org
X-Received: by 2002:a05:6512:2211:b0:539:9155:e8b4 with SMTP id
 2adb3069b0e04-539ab85c137mr174931e87.2.1727980224394; Thu, 03 Oct 2024
 11:30:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241001125033.10625-1-johan+linaro@kernel.org> <20241001125033.10625-3-johan+linaro@kernel.org>
In-Reply-To: <20241001125033.10625-3-johan+linaro@kernel.org>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 3 Oct 2024 11:30:08 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UoU5Nd7sW66cjQzor+BP+W_f7uw0MGRaF6y7PH7KRN_g@mail.gmail.com>
Message-ID: <CAD=FV=UoU5Nd7sW66cjQzor+BP+W_f7uw0MGRaF6y7PH7KRN_g@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] serial: qcom-geni: fix shutdown race
To: Johan Hovold <johan+linaro@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, stable@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Oct 1, 2024 at 5:51=E2=80=AFAM Johan Hovold <johan+linaro@kernel.or=
g> wrote:
>
> A commit adding back the stopping of tx on port shutdown failed to add
> back the locking which had also been removed by commit e83766334f96
> ("tty: serial: qcom_geni_serial: No need to stop tx/rx on UART
> shutdown").

Hmmm, when I look at that commit it makes me think that the problem
that commit e83766334f96 ("tty: serial: qcom_geni_serial: No need to
stop tx/rx on UART shutdown") was fixing was re-introduced by commit
d8aca2f96813 ("tty: serial: qcom-geni-serial: stop operations in
progress at shutdown"). ...and indeed, it was. :(

I can't interact with kgdb if I do this:

1. ssh over to DUT
2. Kill the console process (on ChromeOS stop console-ttyMSM0)
3. Drop in the debugger (echo g > /proc/sysrq-trigger)

This bug predates your series, but since it touches the same code
maybe you could fix it at the same time? I will note that commit
e83766334f96 ("tty: serial: qcom_geni_serial: No need to stop tx/rx on
UART shutdown") mentions that it wasn't required for FIFO mode--only
DMA...

Aside from the pre-existing bug, I agree that the locking should be there.


-Doug
