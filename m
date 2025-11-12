Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573CF332EBA
	for <linux-serial@vger.kernel.org>; Wed, 12 Nov 2025 12:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762951427; cv=none; b=oco90BEw3ssV+zedPXLPksUd2wG+M4BBNo/SlXaXQ8OIDKuwuV0rJe+t/TY36T1x4p3e793IL6lrQKAMMNsA/17MJydskXEvH6AwcoAWoxEzQY6GRi7AOH98oZG2FO2Se0BC2apjdowYj1PXZcakHMUOr2XMoPj9bGkrfq5OCcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762951427; c=relaxed/simple;
	bh=oDG71wLkZH6zNZ8BBmCy1cYzzKvLo2hY7GqxG8NdDxk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fVvh2zBf3j8FHhySs9NPz9ez760YhXUiUL+E8yZGSIjzlbqeuB+Avli81nl8XvRVt0v3BjAC/O5XkEraa4lGsHgu7uZVw/RzHAzgYhAUeYLY5fJpShpEFdtaMzoGvHOC8YNxGjolL5LhhMmFeiPPGzNV5D7m/vE6LkGJzN26pQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uxo36mmt; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uxo36mmt"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5942a631c2dso671457e87.2
        for <linux-serial@vger.kernel.org>; Wed, 12 Nov 2025 04:43:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762951423; x=1763556223; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oDG71wLkZH6zNZ8BBmCy1cYzzKvLo2hY7GqxG8NdDxk=;
        b=uxo36mmtj8Hh+wII3sTWzpG8uou1bkkJCbYDvyvOcxOOpzOUM7cmRMlItxiPTpT3lA
         0G3JQ0olpAdjQaaMDHrN4TDKa9GjJx7tk6u6pd3Mc2Txjn7ROQuK4pSzF8Gq7fX4YyOk
         MZjPar6m400HZLMhAqlqqVEBOJxUwcjMmfTtUkAK9CMhlolvzTw3+2VH+L4mzl1GdxMZ
         qr8/FIgPcanmRg1Oen4DdUs9Iryg673YXkKnJj6U2FDyOB0MPjflGMfZpKyT9PHjSijc
         u+lPz5943ICxpmNykEHYHxTVJeIAbR2JReXirkb5hro76hxAHTHg91ciWg2dX/tjksOM
         AkWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762951423; x=1763556223;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oDG71wLkZH6zNZ8BBmCy1cYzzKvLo2hY7GqxG8NdDxk=;
        b=PjxqjDHq8ANNY1Om50kFvMwTpeUP9lR1NeKpMiyCOWiNBv5dJTIvKKHDjxI7TTITdL
         KbV/5Mby1ur2MqVOMQ6qv3V+stZ+dfiroZZ3SM+W1dWrbx/YxQJi4BNv6P5GMvUR6DVc
         /96lrmEbuHn4kvGQ/3jVuTELTYONbA9g0Ky2Zd0tLH4YAYbIUwUbG8Ml+4gKs04VwHtj
         JY7Y2jqpmDkww9Z2w+rVoBHnPlH1AVPxdxaKN0sr5il6HFcs/HyshEhVk1VRKGIArbno
         2yHJ0ZDW0ODu1xTDPoOSpcpfOLbVb6AWAz1Bf7Noi0dJciU1QS+QYTopE8eep7mSZcuD
         2ugA==
X-Forwarded-Encrypted: i=1; AJvYcCWFLplkJXm5aYugA219VgcA9Hy5yhu9QyqmJISxtE0zxatoRaviE4fx0jpqtdvHgY6dQ4U22zzHH7Kq4S4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUVzihq6f9FCO3wBvJsMzFNpprDaECLeavvcfYTmG8RKuAmbgd
	YTssWvJeu7wxwMaZrRfuEXaGu6J9IMm7orMtbA1E70t3V5Gv1TfXdkpn+de2VlXZYtKDaGMvEqV
	cOZn7vjmnsn+QJVSVCRSIQxXOdFA7SYNNvsENqC4jFA==
X-Gm-Gg: ASbGncvoEM/rRzxLQOznqq+7GDNDXlLFu5PC1iFmzuoGld6plOPY/AIQFlexQgafsbz
	0JdzZ2FJV1b1H4yW41LFuThERmgeFDuPQuZ3x2f+4uB+OtJlYyL1rcFES6dnSOWB/LZv8NMBZ6N
	2ILElLUJQhzj0Ou0R1CLBS34Idy/Z5CKJycoXpzqnG6W/w7zWB8gSCtEo+J2wDolBgrkCtZ8QX/
	XRQnCEi7RhC27NFRdOM8abdnjTsQGTrdh/jjtwF57FKf88RHlL45dahb6fD
X-Google-Smtp-Source: AGHT+IFKrAN2G2zTZh4SCpeU6gZa9GThIvhb7rVDTGkR/MLZ+R0xImuA8WoUYuizes16PmjbOY9KlVCaKR3Fm5qO6C8=
X-Received: by 2002:a05:6512:b9d:b0:595:7e01:6b3a with SMTP id
 2adb3069b0e04-5957e016e6emr28072e87.14.1762951423456; Wed, 12 Nov 2025
 04:43:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251110101043.2108414-1-praveen.talari@oss.qualcomm.com> <20251110101043.2108414-3-praveen.talari@oss.qualcomm.com>
In-Reply-To: <20251110101043.2108414-3-praveen.talari@oss.qualcomm.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 12 Nov 2025 13:43:30 +0100
X-Gm-Features: AWmQ_blw_0zZEbC2wTIU0HIhaE3Pg5Px5M6V4b6IhL47o7V7zMZgJkY7fz-LNV8
Message-ID: <CACRpkdYEbxtjoi8KQxS5fY6xr3UZwQmG-yKvT3L8fRcCXDaAwQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/4] pinctrl: qcom: msm: Fix potential deadlock in
 pinmux configuration
To: Praveen Talari <praveen.talari@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Dmitry Baryshkov <lumag@kernel.org>, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org, 
	alexey.klimov@linaro.org, krzk@kernel.org, bryan.odonoghue@linaro.org, 
	jorge.ramirez@oss.qualcomm.com, dmitry.baryshkov@oss.qualcomm.com, 
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, psodagud@quicinc.com, djaggi@quicinc.com, 
	quic_msavaliy@quicinc.com, quic_vtanuku@quicinc.com, 
	quic_arandive@quicinc.com, quic_shazhuss@quicinc.com, 
	quic_cchiluve@quicinc.com, Prasad Sodagudi <prasad.sodagudi@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Praveen,

thanks for your patch!

On Mon, Nov 10, 2025 at 11:11=E2=80=AFAM Praveen Talari
<praveen.talari@oss.qualcomm.com> wrote:

> Replace disable_irq() with disable_irq_nosync() in msm_pinmux_set_mux()
> to prevent potential deadlock when wakeup IRQ is triggered on the same
> GPIO being reconfigured.
>
> The issue occurs when a wakeup IRQ is triggered on a GPIO and the IRQ
> handler attempts to reconfigure the same GPIO's pinmux. In this scenario,
> msm_pinmux_set_mux() calls disable_irq() which waits for the currently
> running IRQ handler to complete, creating a circular dependency that
> results in deadlock.
>
> Using disable_irq_nosync() avoids waiting for the IRQ handler to
> complete, preventing the deadlock condition while still properly
> disabling the interrupt during pinmux reconfiguration.
>
> Suggested-by: Prasad Sodagudi <prasad.sodagudi@oss.qualcomm.com>
> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>

I applied this patch 2/4 to the pin control tree for fixes.

I removed the word "potential" from subject and text so as to
reflect what Bjorn is saying: it's a very real issue.

Thanks for fixing this!
Linus Walleij
