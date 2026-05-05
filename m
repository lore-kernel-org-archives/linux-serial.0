Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A200B392C4F
	for <linux-serial@vger.kernel.org>; Tue,  5 May 2026 12:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777983327; cv=pass; b=VioPegTqdeFYQgRTbLdMn8QQDtyvA96AW02HHknSKTqUTuYLR/LGA38adW1yGlm8bFpxKlqHF2zVps7ZHDSD2zerh1L53J19Vr8z6otuZQGiPUrYHIWL2BQ4kI4yJBIBUXLC7cmNCh0kK5Bl+jlD4yGyc3TRDDdjBGgeHC3TwuM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777983327; c=relaxed/simple;
	bh=wk+yS5BZP+ECBI7SB46QLVVdhq1zkBFq1D1dBymkO6k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hJBUYj0QMdP4fRBozkT/VPkIGhgrRS+1QSOhBRBiCpUstaw7SMOV+H2cUuh9HKG4PXQ1NVFrTFJyneJsJvbWakicOiBbBpjlPyJcG78lLELOcBm+Nk6lDd74iW9UCa1iiepjRBvjiZt0D1wEV6htj43z9xzq3ld7U8T0CbgmLww=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HRm6WHHb; arc=pass smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HRm6WHHb"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-67b7c71c165so6145406a12.0
        for <linux-serial@vger.kernel.org>; Tue, 05 May 2026 05:15:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777983324; cv=none;
        d=google.com; s=arc-20240605;
        b=Mpxhx8FUPxfQ8/lhhXbMTckPnVNYdi4dggH5pnmIOqFw/cUGREMNHfysnu/FxAvLqh
         VGumRn9+IUD+za/uFFBRh1Iy0d3LL0apAr9IKjeOPsNci/cdHi5CQvsuCsL3e0bTl3RM
         UwnXUENou8Yv8CEPQxs12MbDzDPzgAW5BMrNouNc+xSwelJxfiLUiHlE2nZlzANgh+M4
         FD4hzaIRR/XEMsz2LrqgcBzq0UR2XScyVWkSvdqaYDVgFOG7x8Fn+voYZmE/GqsYUfYw
         8JyMGaEyHqqX9Pkg0htceQHfEUvLzo8AV1gnQo0fR3r7IIqV/1g6DbnA3dv6mxGotYHf
         mZsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wk+yS5BZP+ECBI7SB46QLVVdhq1zkBFq1D1dBymkO6k=;
        fh=PATB/rWJRFBYxprXWQ6aACxjFW3dpAHvLBA8vM58A+o=;
        b=AWmRL6u8ZU2/1xhrehKf5g7Z1Qrb/5MWnRdBssEpxFuB28P506XnJE0eZIGS5M765b
         g/l8xk5Eiz+ghXd8rgmPglm4ZgiIiLQhuGLbAeu2rUoIkDH/12rUlU+vQsISN4zV3Jsx
         1/4mKKv0SRs6Fv6wf/XXRdWEHswH5DPt3pCSSIMp/rhOTC0S6jJf6nSbge4iXU5AXnf7
         UfT0AXeegXWTibN7Sif6qhsMZlZFZZZlFBfZle+7RfCWw/JfPLTP+Edc41KkmQIsfvnL
         hYZ0eKmdy3VK1zXxukgV/OR+mO6DMjkqNRL2ZE2l2985p1vu5A/RxWiFvtYhwgaw0lSj
         d2ew==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777983324; x=1778588124; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wk+yS5BZP+ECBI7SB46QLVVdhq1zkBFq1D1dBymkO6k=;
        b=HRm6WHHbAfdU+OoEe3bk5gzreHnolUqRZnGL1+sF4GUKoTCy8LZtVq0/pPFvjsoNIZ
         wxEtpcyMYuPg5FCPWp6oMgO+ce+js9421edtsNR1rEXGZ0y7I48hGgIj6zckHjIPdID3
         zR3WsYp09F2/Y9DE+3+hymC1R33cUhDjWwk1vrx7reZ01LhLYJJmk32NNLpFhOo7FWUI
         +GKsB1JhLhYe6kGJSOubBA4DrTaSuBCslFv0PtY52V5XnTcV4D67sdJ4qT1fo0Z/GwMM
         1gVbaLimZZ8eV8JJafYM45eQUrd0iaNcbjbLixks+TdWTp45OhsX5M8PZNmPwxFfxXVp
         6e7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777983324; x=1778588124;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wk+yS5BZP+ECBI7SB46QLVVdhq1zkBFq1D1dBymkO6k=;
        b=l8p2cK/oXMg365lLcvk+FucvcIF8meZJPyj4ASu3Kc9ivcUypEMcxstG5a7Zu4//2L
         MsPOGX0HyqtOhdqo/UGkM9Bf+1V6qBgWV1BHmAzGQWi5MHibIWEYvkW0cs9LCS72X6Kz
         lLDjgeLjKk5EE0XQSzJhgn1IOj7etxY9nWbdWoVkrFaft9SpQTQIIgJEk2dhIwvXb1Qn
         AJ23PQnbFYRXQaJwnUF8fkn6rgbG25z99gNJPijLOMVSlzxsDzcAoxIrI2L5mBR78+pJ
         MZVJMqsYMa1EhWJDtNM+W06pTKEDstUUjvsl3hELoqf33ib6QYprnLjsZvlhm5qylXA3
         ma7A==
X-Forwarded-Encrypted: i=1; AFNElJ9D3HkMI9LLAdvzPZ+XyVH/nyo+w93r4D4g9a0R6G4/eS2AmetWWZsnazWVCS91FLOesJDfTlLLPLHsqzc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIr2iNTXr8FD2x/WQJt6TmXEhI3FXIMSuRaVRDt+OmPny7YrLj
	nshJNAeM9azSwqU3RWl4h0YW3zQg9dUuWYjOLYOEzbf5WyHaAeycdoxeNF6aJBuAigywPby/Nli
	iFNKLFspAdbfk2GQq/u3Rr4NuSZmbDvU=
X-Gm-Gg: AeBDies0X82JNJVbnRjaosvuOKM9rHf+IZfOH0be8XMuFbKXDU2CQQtCu07HbeDXfCc
	VARetYndDBjdoj0CBwq9leQjeOWCjXwA7l+rQFUpui+TkWOp1F33TdAqFW5WFeoSemj4btKn38q
	QzXE/yc8TEzcTQRbnvLCWqwcwtE7t0YStN/daI3fOtvxzFhSbuFzPo69tP6UnUjLw+Cf2x83hxn
	kydSlCz7eYIF2WMmhnXroeHkLBuceK50PKJAzTrR1QDK2w17NUjOrFGYpdzbFmYUVAt6slxU/Zg
	jj+7dDYeTDI4VryhqSc=
X-Received: by 2002:a17:907:98a:b0:bb5:8503:fb03 with SMTP id
 a640c23a62f3a-bbffcf917eamr681877266b.28.1777983323315; Tue, 05 May 2026
 05:15:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260424210525.1574497-1-a.shimko.dev@gmail.com> <ae8J6uqgOarcduas@ashevche-desk.local>
In-Reply-To: <ae8J6uqgOarcduas@ashevche-desk.local>
From: Artem Shimko <a.shimko.dev@gmail.com>
Date: Tue, 5 May 2026 15:15:11 +0300
X-Gm-Features: AVHnY4I2p6Zh8B8bq4pqlx80R8LKDyCt8-VWssiRVMsNxhzRdIaHRB4XEi-PwUY
Message-ID: <CAOPX74411Sr2NkLpDaYqAWpbfs61n1_B2FPFVA3HLkD6XKvBwA@mail.gmail.com>
Subject: Re: [PATCH] serial: 8250_dw: Clean up register macros and error handling
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: sashal@kernel.org, miquel.raynal@bootlin.com, phil.edworthy@renesas.com, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

HI Andy,

On Mon, Apr 27, 2026 at 10:02=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> https://lore.kernel.org/linux-serial/20260424-ultrarisc-serial-v4-0-1765a=
0b4c4a0@ultrarisc.com/

Yes, now I see...

Thank you for review =3D)

Regards,
Artem
