Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.231.202
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793261862;
	b=eoB88RdjDuHoXPs14ppMq+jDwPwvQ/7JFMdixcvSvXbJrNgIwvZoUBfdwaNJ/ekP2rGZ
	 gsO1GUyzoXI98J/8rpu2ghCG9q2oZZD85r836kysh5luhPqMen8Oku+tUKKRVzKLzbqzJ
	 UEwHSKMaFQCCoNRz0GiztJbn9tnm+y+TKm26eeUI0EgEaa+ppSIlnFVaM2QjBK0F1FkCe
	 eX2pa1F9ma7apg9U7KBbE0uMxzC8E5zJF9hOl7NNAD1K9/MK3kt7VfNnu21OZp0FiS5P8
	 wDP0xlHK2uBxS+V74VuQ1ga+FSWOLNeuHpT0j6BpZfePYrF8s4/FpyMP+W4ted17t2g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793261862;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=iSkrbIstxlkKChRqbas/gx987t4mdbKYwafViP0ImKY=;
	b=RYGc3wPA4XuNwl1UbZz+HuQMqpTuffGImjKhy75rPpuoLxchnM4Y/vopU236gyBt49bz
	 KpUn5kIx+N59EYuBAC7vtAQkdfX228NAeLnP9kmYmI2Hpyd0H+l54JTAj+bN1q4zi/SEg
	 5Fjh6CyO9TxRv2tIyKsJWHPfWZCBdC2v3I+c6yt1lO4O2X8FYdWRIG5BL+6WP09S5/KUX
	 KO8ovhJ4nruASd8mmNJbYZm+kFsiZltitIhbX0nDKSh+n4u5vBAvmDml3Cnt/YYWSowcL
	 0pGCgiWVu6hcaEGhvxFeQzwta7C1OfSRfWbCM/Uq9ElwizIMCwxNElwuHtV5oPrv0Dw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=J8pszI30;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.231.202
Received: from mail-oi2-f10.google.com (mail-oi2-f10.google.com [74.125.231.202])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 946A0606A31A
	for <linux-serial@vger.kernel.org>; Thu, 29 Oct 2026 08:17:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 946A0606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=J8pszI30
Received: by mail-oi2-f10.google.com with SMTP id 5614622812f47-4c3bb46aaf0so624407b6e.1
        for <linux-serial@vger.kernel.org>; Thu, 29 Oct 2026 01:17:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793261860; cv=none;
        d=google.com; s=arc-20260327;
        b=nfSYzcIPVg3ntOoZTBh6kOD30WSVDOHLLGI/2zeUgDrUxiSaJuH+iZr9xBMF+kYh5n
         dl0mCT6gKEkygw/cgxMhF77gGz6Ua8sWrIqr0x+BUTQnzct2/ROtwK9jk/VY8mS9vC7R
         rEXUYsOVaeLIV3aok6ZoPXeKNacLogMQpKzH1mWIRELh6UqzgyixbEtjmYHK3fF/lj6w
         R7R1rsnl/yEOD7jVngIJ1PLfu4kWWt5n18lUzuL4Hm+NGUWGezJRBp0toQ5Lk/+6hZSB
         pc5tZ8ZQbOx7TgKYv2O1EKRu+q94MOHxb+W6fa9owPeV/Q9+9bF7kzcSDFeycqkK+f2a
         eVhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=iSkrbIstxlkKChRqbas/gx987t4mdbKYwafViP0ImKY=;
        fh=cVbPc2TdMFLmh2cNAVeaNQ5bE3EG2q44yaokGPSiViM=;
        b=EMk9SeuMV0mGCmcqN71GbD/3ayKPD9CRf6Bn6swZf1/c4mCaSqmQqn/3WYSA7TVs2j
         433D/iNQW/dSbG1tksu1T1L5F9HQX5lZf+WVDScAI5OxxxOSYUwwCIL1TJEN99ViZo9e
         n8Jj6sGUeaaQVv5ufBSl6fAi0xVo5ecREY30Kh/e0tecqbIpo7GbTlUZPeiLSiQ+qxxg
         Z7Bb8XmlPsbSMRN3cO0OgiN6wvAdc0Ccrm9iVAEloSjqOahFTb/uktVw14+bFQE0i5jz
         bwfhINUjEsrDvsgmf8FN/WKZFvarz4PKPOThtgjUhGgS61g0RCDLQl4MimwMKglBEA6Z
         JPmQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793261860; x=1793866660; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iSkrbIstxlkKChRqbas/gx987t4mdbKYwafViP0ImKY=;
        b=J8pszI30Ao9sGIAOHUXan59+UKcfPex1h+4PJknj07CpqLRXxhEXpE+4IgWrSsZxER
         8waRLfmLBd5fAtTsZbBrkFo5epI0PEC8kX41EzOh6ZEtI1wsG4UI6GepbZuQjIOAu4Uk
         lQaKgx81IQqS9Uo9ZEkfDSRvxFkBWevTadKa/C6jkThz2Gl+Le2+T1RUPnpnlIaqvlye
         a2V4bMonEONQ47kRWbdpgfHg2j3FoIH67lm6/2lNn3avvYnB+82EO3IuaGterv9SKvoN
         XJqlChedzxTNuYS/S/m0r/776KyKA3TG4plfzBqhEEDcdlXBr/8C/7jcNVzu4oDNnVie
         XPqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793261860; x=1793866660;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=iSkrbIstxlkKChRqbas/gx987t4mdbKYwafViP0ImKY=;
        b=z5GAzFPYZFw+mUPJIaZMfmCfc3DJgxmb87lex52Mjw5WAuXh1Jb2UbnmvdvqguoVge
         KSKZ7lYSy9m3BHNOSA3LP/MhHCLIu8ko3ZKGbhC7PV6yVPOBi30kXeRUCeQQd2UoXu51
         EwK6u7tdseMHgM8ggDqCJ6Qy2T7pVUh0iXs0O42OUTXBBJaswyAhvyMllky51dUphCH6
         uwxroTSGMEbnN6Eq9WZeehUU4wh5yt1V08d+YB4oisqn4XQ4V21nUN7gTU1q+NgxEy03
         TXIVaDH6IbyN12cMqI2r4FuWF24DBlMcuVpn7ZMiEEPXCeHZ2LvFXsuqtNe+/FOYONyR
         4N2w==
X-Forwarded-Encrypted: i=1; AKwUvByoLvWlZ27RGptw4ig9LmXfhiCmIKO5+DmyOSFPXb3aOW5ZmDGMXeZbcHtMPna6ofYfQVh7T3cYf6+jgNQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYI0uwTx2qySwcKzjCMzcRQdUqBc0TnxnraCM2wAwU2idWlt+pi1
	ZnPDqomqR4xBfvb8PmS+7Ii91/SS0JR5KumxF7ythX3Wpy9TTIWdNvjM+s5Lrxglf1lxhUy7n8s
	sBj/Tq3pr4TMWn2VtNtUEzMdlcuSSFJk=
X-Gm-Gg: AYBFou1hqt/Tu71L+kgPrClYU0Bbr6RLSOjobrnp+SNQrOxpF88zidTSbkbFHJ5UCDe
	sg2cv+hHnMLolC3JrF2jA8DGSlMrQxfW358vSRSUgcVadhXAHsmvMEQ7WHbvXQmEBxkxkXDxnqn
	UHNV/EqY31j9g839mczZQrR9jXxd7A5x23lsLbMmEcQUoZmGoHsXGYwviT9Mbv7nCz4hiedA+CA
	+Gcv7p0RXmr+cXETThXdq4kXp1KpbJ4uy+9d6CwbjPstPYUardEefK0ObfodznQ2JYsD0a5T83U
	V5AgPMMtKILlmqj5xp3u89J2eSE6rWrfLhFVvtEIDlp+WUjH90NzMn0iGsMrgpSIkEiL8sSS9Es
	0UkvLl+prcbp7XVhIwTOFb+7BOeZoLDz7dqfVhVSQr+CUuRaJUTBbYVTvoaGYJ0JRlrUIoQA=
X-Received: by 2002:a05:6808:1686:b0:50a:6fcf:d287 with SMTP id
 5614622812f47-5638328b713mr3288551b6e.37.1793261860445; Thu, 29 Oct 2026
 01:17:40 -0700 (PDT)
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261029002052.54117-1-dennylin0707@gmail.com>
 <2026102957-suitable-gesture-be83@gregkh> <CAGEkeHft5gqu1Kq0saC1O0hg+ZE9AEO1tOgeXmd-g10uk2obgQ@mail.gmail.com>
 <2026102930-underwire-manmade-8083@gregkh> <CAGEkeHfTRiRmb-SpLUZeBkUrmRmq-bHLhD=CWnqsrvpbnymuYQ@mail.gmail.com>
 <2026102915-trailside-easiest-08fa@gregkh>
In-Reply-To: <2026102915-trailside-easiest-08fa@gregkh>
From: Hungyu Lin <dennylin0707@gmail.com>
Date: Thu, 29 Oct 2026 01:17:29 -0700
X-Gm-Features: AclHuK-WVhUSOg0jZmjo5mGtZ4Ngjdkua4t1GssTsLZaglPf9GZnyVAIGNGOVJg
Message-ID: <CAGEkeHfv5RHfkF9rSXUGBcvoRE-HT-xU8FTFFT6NASA_7HXiyQ@mail.gmail.com>
Subject: Re: [PATCH] tty: n_tty: convert the full VTIME interval to jiffies
To: Greg KH <gregkh@linuxfoundation.org>
Cc: jirislaby@kernel.org, linux-serial@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> Unless you can prove that this is causing a problem, I would suggest
> leaving this as-is please.  Modifying user-visable behaviour is very
> tricky.

Understood. I'll leave this as-is.

Thanks,
Hungyu
