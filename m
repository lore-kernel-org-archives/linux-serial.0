Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF9716BE15
	for <linux-serial@vger.kernel.org>; Wed,  4 Sep 2024 21:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725486688; cv=none; b=WgceHYGxHVDmLw5u26pqK9Uz6Uvhv6nQAXy1qXbwjvsPbA/yDpTGVfsSiUxUv0xrPI2vu/p+Oyr9koQaaj2kTFm2nPUNZ2BWVRWDE9Q0AHmF7FaoV/TzLqcoKTNm/O15oN4nKKp4XWkFzVMvG0w9KHZpGIiQm3HFfLD/34O36Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725486688; c=relaxed/simple;
	bh=knUk5g8ScG6jaMqCjtTQXGlVYSsfYw20xNj43ODq8mA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rgzIs0dvZ9PkSRMd+eMpSRrSjJ2ZN8ykT+ghbQI4gWDmPiXzsdQP3tdUYlb+gFNsSSr3mHh6c+Ok2ejQVx0cv8frFkm7dEYBL5NcZjynpESaBT8ba/C7rwrS6azZWXZmB2umy8H9+1Hx+Kz3HVHw+EDgu3wwI45Gyyd5L/HWxFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=DlszaVA3; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DlszaVA3"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6c34c02ff1cso516766d6.2
        for <linux-serial@vger.kernel.org>; Wed, 04 Sep 2024 14:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1725486682; x=1726091482; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BXSA8W0aVMFFsXPo/UPncBkp5lzvV+GsF0QFk8bga9s=;
        b=DlszaVA3pc39dP3y6svZw5AbMh28YA+4knB6wXI01V1q60JaAToWfPIx4x3SxhV3wo
         AjxTN7QcZb3V6TikS6UQrso/elfzS8/zKBsK3ldocCDZetDv3sbNO7KVjvYCEN/PN1oD
         vw8UuyZiVYUwQKtsRKsxKnTBJncIuXIvjwMiE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725486682; x=1726091482;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BXSA8W0aVMFFsXPo/UPncBkp5lzvV+GsF0QFk8bga9s=;
        b=myrfPU/1/L1s5qttjljIP1fffrz2SyqxVZWBJSlV68mJ+L8e9H2gQjAKiBbW0soXsh
         r4kEnFQUytga3tZ3ijanRKyIfcvf5ctIevn4f+yE0TkRuyD35smm+CjCY9R2Xr6KKy/n
         s1o7AcTD/IehELRcIUM01cMpzKMTgc+VrAiPMEjiKwOgQaDTry0p97eo0n5uxqglsXux
         goh/Q9iyh23WRI+FU2N4+n4HgUT1Zh+jfFEH0ChBAWGzqhOL5A528afECbSxW+wvXJou
         O8k4DfuuD4Yb88N2/rAXERskaaEMT7+xAd3elmjoUrQNqa5qCeMgGC6RqhIOP+J+Ugm8
         H2Uw==
X-Forwarded-Encrypted: i=1; AJvYcCXY/F8aKuEKov1yQx95KXPTfDjrvantUbOW8/7MW8ky000OcjCSACdve0XKnSVJDoedtJsfve/91yneRFE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNWvJ6WRsfvqyBMQiHp0ToFDgXHC2v3OXAMsW6Sme05Dk8lFDS
	OXf3WNX8dXgSjYvkjnU9jptGRfU98ltjw4/HCPWyO2z/sOCksav4JpaCYpVw/QuvLW7oT/pirIY
	=
X-Google-Smtp-Source: AGHT+IH1BAolHmEakpgP1c2I9tqaH6YEJCTaF2Pih5oBPcgaS97C3Fai5BwXLkgJX+YqpHwJoOzpAQ==
X-Received: by 2002:a05:6214:338a:b0:6b5:eba0:d0ab with SMTP id 6a1803df08f44-6c355684df7mr144949306d6.15.1725486681789;
        Wed, 04 Sep 2024 14:51:21 -0700 (PDT)
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com. [209.85.219.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c520515c2fsm2188586d6.145.2024.09.04.14.51.20
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Sep 2024 14:51:21 -0700 (PDT)
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6c352bcb569so581836d6.0
        for <linux-serial@vger.kernel.org>; Wed, 04 Sep 2024 14:51:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVWlA7VDTqC02GGCmg6AUBpSaJJq01qXNX0D0cHhUgvBbFSd4REs6wmrI5WjNIKfrNIfHRA3UHk+Miz66g=@vger.kernel.org
X-Received: by 2002:a05:6214:5d0c:b0:6c3:5aec:4504 with SMTP id
 6a1803df08f44-6c35aec461emr191088526d6.28.1725486680181; Wed, 04 Sep 2024
 14:51:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240902152451.862-1-johan+linaro@kernel.org> <20240902152451.862-3-johan+linaro@kernel.org>
In-Reply-To: <20240902152451.862-3-johan+linaro@kernel.org>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 4 Sep 2024 14:51:05 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UH8dLB6ebCXGeF2t5Bi5EhYrumLDnSV68fg7qzdPCQMg@mail.gmail.com>
Message-ID: <CAD=FV=UH8dLB6ebCXGeF2t5Bi5EhYrumLDnSV68fg7qzdPCQMg@mail.gmail.com>
Subject: Re: [PATCH 2/8] serial: qcom-geni: fix false console tx restart
To: Johan Hovold <johan+linaro@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	=?UTF-8?B?TsOtY29sYXMgRiAuIFIgLiBBIC4gUHJhZG8=?= <nfraprado@collabora.com>, 
	linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Sep 2, 2024 at 8:26=E2=80=AFAM Johan Hovold <johan+linaro@kernel.or=
g> wrote:
>
> Commit 663abb1a7a7f ("tty: serial: qcom_geni_serial: Fix UART hang")
> addressed an issue with stalled tx after the console code interrupted
> the last bytes of a tx command by reenabling the watermark interrupt if
> there is data in write buffer. This can however break software flow
> control by re-enabling tx after the user has stopped it.
>
> Address the original issue by not clearing the CMD_DONE flag after
> polling for command completion. This allows the interrupt handler to
> start another transfer when the CMD_DONE interrupt has not been disabled
> due to flow control.
>
> Fixes: c4f528795d1a ("tty: serial: msm_geni_serial: Add serial driver sup=
port for GENI based QUP")
> Fixes: 663abb1a7a7f ("tty: serial: qcom_geni_serial: Fix UART hang")
> Cc: stable@vger.kernel.org      # 4.17
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  drivers/tty/serial/qcom_geni_serial.c | 13 +++----------
>  1 file changed, 3 insertions(+), 10 deletions(-)

This seems reasonable. I guess this can end up causing a spurious
"done" interrupt to sometimes occur but that looks to be harmless.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
