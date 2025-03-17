Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F33233702
	for <linux-serial@vger.kernel.org>; Mon, 17 Mar 2025 10:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742208698; cv=none; b=MrHR1nuaPnpJYFm4gaTMjVDJExzQcRWZIMyyvfyM/czvNYwtj/le8ukRRNdRW1Hksv3ECV+fDbEAhoDJ4Kg6AlzNM5su6/A+5gXVABXMZLFLRnFWVfckSnyYF8Kv853PPL02gF3+EXUiUFmAdbOq9HylbVzkJb4z4wG6xmC9ycg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742208698; c=relaxed/simple;
	bh=G9bGpVVumkh4EkeQ8f+423AnFKXvZJS9Sk4lm4BBydc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DgUt2h65osm0NxDMkvAtQuhZSRlasEginEyyE8xrkm5nOzZNzR++zkCjqAfNSMP/RwRiNk8V7a27Nis1O0A/oMdwiaSRA+HISaLSyllSnlTcr+/FTggw0G2ZWykiwptKgqiFF9A9fl3w67VWVeiYEv2VOFy57BGe4gfe+y5+pF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JFkbfuaE; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JFkbfuaE"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6f47ed1f40dso33243627b3.1
        for <linux-serial@vger.kernel.org>; Mon, 17 Mar 2025 03:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742208695; x=1742813495; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XfVnG4HkUsVDQ5d3JfJrfe7r2SoolZoIbYsONCWi4uo=;
        b=JFkbfuaEHPPFPnEVdlGF7mLpnEi2v0/MwVP90rSOewDXxHN1fIuV2oev9W8p8CcRFQ
         2pLeOf0EmooRC8O0aThuUdl9HNG4YtUCCJL3x4ORe85+gVJ6N//Ne4pv3zEznbPZBksR
         F/61d79m+O07U6asq8eQmhZ2OFlBaHtXzemdAhRiyOMvBGtT6G5SUST5g8CEhoAROEbg
         RGIxMjhXcRhibDQ4GkZpdZs1PTRctaDeqWf43knlnK+PDCn7LaqFZRsrjRpdx5yGpRUR
         8MLCsO3vxdVl2nXFU6P831tYrnmnODgpPcmTfBYjj2ce/pc0pt8nlo3kkpqXHL6niq4B
         8wUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742208695; x=1742813495;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XfVnG4HkUsVDQ5d3JfJrfe7r2SoolZoIbYsONCWi4uo=;
        b=d/tMo598D5CutBQ2W4Gjmp6dxc6488hQ8uBoZvnHo733oYyq7sFIaHkrgJgmM98796
         GQezrkMh/NeQ+J2Xybe/LiNhskYDcva5nL5QXCTgmA6Zkax1YMsuGgAnBo/YSPN8CmOJ
         2wvnEfNgFlXdqeznlGhCqarzaZ3XdxQs2BjOGdXXXftuEtnOCqgeRnCvGto4pA38yCeG
         eT35EoY0Dad0Os7HrFzewtA0qFriWKlm3hUELat6hBeenVnbC67ENDeGLpzvFex0/nwA
         uaghI0HzSDkchYbnWdykBP3GbdJrZPW3NNZ0cxCUu3+SXtNBWfjTGOoV3QuBosHT9S+0
         AyzQ==
X-Forwarded-Encrypted: i=1; AJvYcCXsd4I6LfQUpVf/4znD7KsoP5PjoR8HIoroHUhJSVMiHnAD2jA4wN29MVCaB/A0r5klflGJKa0alMUSO8M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4GnodmcGz6TubBy8XBPUv9t6X1WJ+T5nrZeNmIsyww3a07ghK
	30gXJde9//7qDM8pRcxyjZzVeNbiyEBkBRkn6au3WDYJBrkHf3Uqg947+80JtbAhtNlXfbIKCDE
	r18duMkRVk7dsCzD2h+Ye/oTT2jc2lU3HWhCCfyRYN6IIUcCg
X-Gm-Gg: ASbGncsL3tVFbZjleyxSDU9FLCRh1XyIJbg84260yDABFZP6HZWISGuZjuieHl+9YWO
	hv0F48yymzjYylsuuN8A0/UsaJzZvj3KoQWDGl4976lvbLUVwc8iKcKiE+NxTyxarI8yT66eVof
	u3fhzG1mYpnA0cafZjQqE/76FP3HBILdVkpHji8w==
X-Google-Smtp-Source: AGHT+IHG+hqqY7z4YWoNHFwken+n5F9fRUkOdKWXpn1zIzLsSXAtBJ1qYKxYTQkl9v5HsBxDmf6GRlQfnrNNQji4duU=
X-Received: by 2002:a05:690c:740a:b0:6fb:b2de:a2c3 with SMTP id
 00721157ae682-6ff45f615d8mr143741577b3.9.1742208695401; Mon, 17 Mar 2025
 03:51:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250317070046.24386-1-jirislaby@kernel.org> <20250317070046.24386-18-jirislaby@kernel.org>
In-Reply-To: <20250317070046.24386-18-jirislaby@kernel.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 17 Mar 2025 11:50:59 +0100
X-Gm-Features: AQ5f1JozYMb7s-WMdJg9CTQSW8y02swNli38bn-VGUEE_cdcqwI1tkZFu3cBTsg
Message-ID: <CAPDyKFrwNfd3F5EvXvTJHM4dd+mUuy6jQXxVpq4FtCzPN0X2Qg@mail.gmail.com>
Subject: Re: [PATCH v2 17/31] tty: mmc: sdio: use bool for cts and remove parentheses
To: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Cc: gregkh@linuxfoundation.org, linux-serial@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 17 Mar 2025 at 08:01, Jiri Slaby (SUSE) <jirislaby@kernel.org> wrote:
>
> 'cts' in sdio_uart_check_modem_status() is considered a 'bool', but
> typed as signed 'int'. Make it 'bool' so it is clear the code does not
> care about the masked value, but true/false.
>
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: linux-mmc@vger.kernel.org

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/core/sdio_uart.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/sdio_uart.c b/drivers/mmc/core/sdio_uart.c
> index 6b7471dba3bf..7423a601e1e5 100644
> --- a/drivers/mmc/core/sdio_uart.c
> +++ b/drivers/mmc/core/sdio_uart.c
> @@ -471,7 +471,7 @@ static void sdio_uart_check_modem_status(struct sdio_uart_port *port)
>                 port->icount.cts++;
>                 tty = tty_port_tty_get(&port->port);
>                 if (tty && C_CRTSCTS(tty)) {
> -                       int cts = (status & UART_MSR_CTS);
> +                       bool cts = status & UART_MSR_CTS;
>                         if (tty->hw_stopped) {
>                                 if (cts) {
>                                         tty->hw_stopped = false;
> --
> 2.49.0
>
