Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6056D31AABF
	for <linux-serial@vger.kernel.org>; Mon,  3 Aug 2026 15:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785772026; cv=pass; b=ID+AZlbXrNDIkRmUQIT0EhbXR/EGFC2wuLIRH1M5m6rBm6tHZ3PZZptuDGWVU5ry8HGY/kiRLq8OwlQ7/CelXhWnf30hgHvyBfyP7vNR8TAc/iIgNo6VZRboWynkN4XA+9zHZCW5mSt6SU7tO/6jLWXqA5tcuJDRFIF9sApBxig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785772026; c=relaxed/simple;
	bh=f9j7LG29CWoYTu6tfO78YEbBNKOeC6jsIJJlx8TGfV0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YJvIS+G5PAmkhFLucgQ1q5WOgKAWHm66o68wPHpLB6DD70kzIBK+WG83mmaqj0pTYwHCCQN2skcT0KHdQxx+gX06/NkWIjJfkKRKhk9Fe8ehKc+CG3ViKEl/aN7F3+sKgAqH4qZHcU/5KVMZj4XSU8p+CMvECbnIbWrBdP5fAGg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fIrNE2dr; arc=pass smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fIrNE2dr"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6a09571dd5cso575732a12.2
        for <linux-serial@vger.kernel.org>; Mon, 03 Aug 2026 08:47:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785772022; cv=none;
        d=google.com; s=arc-20260327;
        b=DwBKGf1+d6jCfD+h1+w9omH9afqBVXUweqluy1Zk1iRuIdMAW4QqBXES4dZ/l1VYco
         92UjhhiLexJ3kHPIibwe/7MrnXuPjBcWv0dHAiuvD0obxrXs5kpRUQjULDe4MMRSyNp9
         PD83yrVCULhF54CQHkJU6Y6lYdoYhQ58b5geb3KdqJx+76VSZYAK0QR2wMYHpMt38Fna
         HHVT/KBv58Hjw7MkCuIX6A2fAk3a5PEEzn+KSJBj5qO261l8TgLCaMvfLkrLHOQlnjiQ
         8iCRG+CMzIRDbGbghp4UvPQb/+6U3qEcySF9OoDrPLAS8fawXgpYYfW2ZJ6KrOXhmvVz
         IzZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=f9j7LG29CWoYTu6tfO78YEbBNKOeC6jsIJJlx8TGfV0=;
        fh=aI2k0Z6U32F25dTviigFH041lH16oivL1kEgKB78qNQ=;
        b=WUGSsjiokpGNTnty1zYRPaworJh4dPqyE3dsF17GsuiXtZOcSbz3+7yNr8ajxqL6Sq
         ooI95qzIfpsAwfS3tiEMSV1l6pL9hzOppIKZ1REVjxLWgpdMbO52kS6AxHj1p0Xll2cQ
         6QpPLf2YOzMwkK70eZzsW110z39/yljOnyBWPZnesWaoFDSYiroGRACKEyknTtWju2eS
         br2ujxid97lBt/jbCCfJi7hqsn5QtVAbOMe4htxaDmx8BGjLnk1hUqqvieUm21wPN8gu
         F8RkVG7ZpyY+/tdq9adkB8ghu8wXbWD2+la3VTuQOXVBv7cZeRAvD6B3lMdCdcccJq/5
         VNGA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785772022; x=1786376822; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=f9j7LG29CWoYTu6tfO78YEbBNKOeC6jsIJJlx8TGfV0=;
        b=fIrNE2drkrs+Hej3dREqqzeCTqKFtunVLL57kdi7pCxzFU4J1EpDA2gBEn3XxNItF/
         p7sCGRlZIV9smkHiA6X/yG7JxjoV+VEgjMGwcgxIqGQ1sW65DSx6UL82kLkoGYhVnKTO
         g/estd3Wq81aCxrT4HViUW4Yhllu6p2kicVcRakbVxMqXFB6Fhbx11/Qn0cfvdtVhF70
         4LBLCzm2gG/bLPMVSHQeHNrPvJcqTCx3f+/pDeCIVRUEaRhfZROBIA50zFQX+oIrIlQ6
         +b/OabrQp2FkCzGcfzz/n9bvgbdxySxT8yJTzgkO4Ew4MmHi/CDE04zlRmcH6wYRt5Ag
         6hvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785772022; x=1786376822;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=f9j7LG29CWoYTu6tfO78YEbBNKOeC6jsIJJlx8TGfV0=;
        b=GYAO9CVfaaDYYFSxbb0Al23ZGQpFRraQdhYixlZAdcVpYOUqwvV1BccTNNk0QnpYR2
         LIVWzVsaF+iuR9cRlBe+HfDlPs17KUf0LQa9dWAilZHMrX/e3WiE5FaE3I1nQpCjjh1d
         aQDzH0sNwaVJOCC/hQNCgSBR2iej69ubChlIZEPdQiB0DOVflUyRmu5EP6PwTUCLM0TJ
         GPzPOsMHktV7Zt+ohWgneTsK2hP3vEQgp4zDcn+IjGGlugkMnt5peKXu+RHeU/pfLYug
         4L6bFwdIM1EKYcHUWcM62W7+CYwzmyKcQQ1fiB+BOkKPrWRhpu/m+n3ZUDbhz2T9vE5L
         abiw==
X-Forwarded-Encrypted: i=1; AHgh+Rp/1IkKn3Z83tBzWmx972rmdbvDuilS8yMm7MZT9yMuYpHPx9krS6B8Tju8PpO7wCm6BwRnX4t0NSB+cA8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6vhnbju28YELUOKi84NXMASWp3bQcMvIA1E3i2YWdTZDa9DrN
	TVo67pexhL4z0Bhi0at+4yVb3K/7ZJSkdnHgO7ZFFsOlJsVaFTBnVeqPoYJGqcLWhrQ7DWZmYUq
	Uj7dX8HgDPSKdShNDQroFXOoVNWGtEAhzrpwAXaE=
X-Gm-Gg: AR+sD13cGQsNshg+huPesoH6B/eGsiJ+G/BzROz0GJLJD7ikjArzLsyiCpf1H9KUMUJ
	kI514kAQe1W4pCtayGg85RY7MS+WWqSDnuG7JdGJrxRHuuVCnx6lLdsAHsqFEU0RHshdiXgcn4X
	6Y45BTqUUD1oj+ViFn0esG1haFKuwFo+9w8ja0nozqho6jtm8/hzmGRkLOYXWLbmUMVsJXId1vM
	IBNepP1EweRXD3SULS60LFhctlHzkPTB10qGonKYeS4QY+u+3d8bIdAyWBFwtUkr7dE1b0sOOrq
	1E09hyu70ymAKBRehCKMsZ5306X3OBleWEoKbD3iSfvmf1E/EFwIAzfryx0AaR+RefeDYjsWnA=
	=
X-Received: by 2002:a05:6402:28c5:b0:6a0:4e35:deaa with SMTP id
 4fb4d7f45d1cf-6a0a7c66dd9mr4790179a12.1.1785772021709; Mon, 03 Aug 2026
 08:47:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260731142220.3000214-1-nicoyip.dev@gmail.com> <2026080347-marsupial-clothing-b083@gregkh>
In-Reply-To: <2026080347-marsupial-clothing-b083@gregkh>
From: Chengfeng Ye <nicoyip.dev@gmail.com>
Date: Mon, 3 Aug 2026 23:46:50 +0800
X-Gm-Features: AUfX_mxNdEwX8xfmOVCyXhNGM2l1XfvLV34VZ7QqIAlDAto2-nGRnPOrK2ukLPQ
Message-ID: <CAAo+4rVBDYfhJU0-KOQz=XDHpgc7mnSB9ciUQgdrcG6Ec6NafA@mail.gmail.com>
Subject: Re: [PATCH] tty: serialize device registration and removal
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>, Richard Watts <rrw@kynesim.co.uk>, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Greg,

On Mon, Aug 3, 2026 at 10:20=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> Hah, that's funny :)
>
> Look in the mailing list archives for why we don't touch n_gsm issues,
> ESPECIALLY by changing core tty code to work around the known
> bugs/problems in that code base.

Thanks for the clarification, and sorry for the noise this patch caused.

> Your LLM should know not to run this code, please tell it to never do
> so.
>
> Also, you forgot to add an Assisted-by: tag :(
>
> thanks,
>
> greg k-h

No problem, I will be more careful when sending LLM-assisted
bug-fixing patches next time.

Best regards,
Chengfeng
