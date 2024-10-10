Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A8881E6DD5
	for <linux-serial@vger.kernel.org>; Thu, 10 Oct 2024 22:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728599812; cv=none; b=uJDNzcTxbQYN8lTMe0oFWLtojoMpI7O2jy8O8Nfwo6Fjfa63hnh2wQHK1GwzanjlK7rEfcSfRkf3JrelfT+X+dlgdYyDnaoOmqOqA9dbM5tZLnmGAJyw8a5mbT9MqATsCBN13sdKci5IwC01HhxQ5g8Xm+f2chqEuxdZvjXIjqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728599812; c=relaxed/simple;
	bh=S8MzrVyVXYrrKDN3sreSlr2FvATE3GpWfAgeOexSlnw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pbWW9UuVG4IxihJArGdWY841i0cUABgHIC9LE5ISWlM0hOLvBFR7f91m4snPppRY29gNxU/e9443o5PiMtFmenqmBx1gD+JEr7UGGs2VUlpCM3a+3cOu7Jo2foew0AfUfG1zJe2dnBKj6gePdERgJgNu3p/2cXlKOT7tHqdXqWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=FsKFA8us; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FsKFA8us"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5398cc2fcb7so1819385e87.1
        for <linux-serial@vger.kernel.org>; Thu, 10 Oct 2024 15:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1728599808; x=1729204608; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wWMUsztqHY1RJBiR4O9/uVA8A37ER1fCtc2N/7pUsd0=;
        b=FsKFA8usXRJX97+bdZbl6ozfWfzewEPBAlxnb52EG3I9UHvlGeUj6DyrSUfmcKVzX0
         xKXM/qK+hxStXMtt3j6viWeHQ2j4RMnhKFJ/F+nYrVwNslaYW86cdqgAhFt5IPkTULvf
         vca2/f3JgNNzauQtYeC1M5tJ9iXmKZPV7qGmQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728599808; x=1729204608;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wWMUsztqHY1RJBiR4O9/uVA8A37ER1fCtc2N/7pUsd0=;
        b=biWlP58+4nOOifnL5kDEnZcQmDb6/Jn9RpAUtHMU4KdzWa/0oqgrIZZEL0zFuXjRAt
         RElgBMYjuDu95uFgcWrJ60F/p7PDfjcf2zLjdiX2xs7ODl0xDy6G7rPMnBNddFBl5+lv
         cR1OWQU2AnunUw7gayBjz4upzGoOkwDSKbKso3dUHU3VqJYLeSNprL9TUh0pNL2byfyT
         5RG5uKwAU5XwFyqy0ZWwWIRpEJAN8G3pLTR6LYzKbp+tfuv4tokAWCO5N2EhcIFCydtC
         Z9lYSVlMMRYw4u7JGy96hYyrwf2RddqCiJiC74Py5ZqcER9dDJ9rwjwPHiQgWdIHwL9j
         KQbw==
X-Forwarded-Encrypted: i=1; AJvYcCU0u3joYsv1miDPYOCO7HhLcP61SJcrT5RcWCC68aIS0GrpiGRK43AbNxH1/OjTOxFjaoWk/QG41MTA0pc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGFrVUlFILR0qnhxRQQs2gGv4k8LOK0XuaPAkNyFe0mHTMDqqN
	yui69QSJZgE5uISveNEYMML40ANnU2umtPCkyVWuxnl4lVTVR+Af/djbjMyyoZy60/u1YbOS8UO
	kvgkr
X-Google-Smtp-Source: AGHT+IF+VPLsK0sDboqGwOinwoZ4jDcOfAU8lvqSnhbfN8wbCKMYgotfbaKxLAEIhVdUuZ/j1aeB5A==
X-Received: by 2002:a05:6512:3408:b0:535:6992:f2c3 with SMTP id 2adb3069b0e04-539da5479b9mr159203e87.41.1728599808442;
        Thu, 10 Oct 2024 15:36:48 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-539cb905362sm405059e87.288.2024.10.10.15.36.47
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Oct 2024 15:36:47 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-53993564cb1so1793483e87.2
        for <linux-serial@vger.kernel.org>; Thu, 10 Oct 2024 15:36:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW+WOd+KDFcE4fdpkaAK5vi+bwLq8F5CgeWYIlvD9vnu2y1DHu3NRO3byYuIF7g9eXfQuOwo2a45KpVhiw=@vger.kernel.org
X-Received: by 2002:a05:6512:3091:b0:52e:9f6b:64 with SMTP id
 2adb3069b0e04-539da4e09a3mr158626e87.34.1728599806982; Thu, 10 Oct 2024
 15:36:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009145110.16847-1-johan+linaro@kernel.org> <20241009145110.16847-4-johan+linaro@kernel.org>
In-Reply-To: <20241009145110.16847-4-johan+linaro@kernel.org>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 10 Oct 2024 15:36:30 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WdxCbQm36sq4RtPMGyi+ZefPYoOQortAN+SDYTAY_m9g@mail.gmail.com>
Message-ID: <CAD=FV=WdxCbQm36sq4RtPMGyi+ZefPYoOQortAN+SDYTAY_m9g@mail.gmail.com>
Subject: Re: [PATCH v3 3/9] serial: qcom-geni: fix shutdown race
To: Johan Hovold <johan+linaro@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	stable@vger.kernel.org, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Oct 9, 2024 at 7:51=E2=80=AFAM Johan Hovold <johan+linaro@kernel.or=
g> wrote:
>
> A commit adding back the stopping of tx on port shutdown failed to add
> back the locking which had also been removed by commit e83766334f96
> ("tty: serial: qcom_geni_serial: No need to stop tx/rx on UART
> shutdown").
>
> Holding the port lock is needed to serialise against the console code,
> which may update the interrupt enable register and access the port
> state.
>
> Fixes: d8aca2f96813 ("tty: serial: qcom-geni-serial: stop operations in p=
rogress at shutdown")
> Fixes: 947cc4ecc06c ("serial: qcom-geni: fix soft lockup on sw flow contr=
ol and suspend")
> Cc: stable@vger.kernel.org      # 6.3
> Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  drivers/tty/serial/qcom_geni_serial.c | 2 ++
>  1 file changed, 2 insertions(+)

Though this doesn't fix the preexisting bug I talked about [1] that
we'll need to touch the same code to fix:

Reviewed-by: Douglas Anderson <dianders@chromium.org>

[1] https://lore.kernel.org/r/CAD=3DFV=3DUZtZ1-0SkN2sOMp6YdU02em_RnK85Heg5z=
0jkH4U30eQ@mail.gmail.com
