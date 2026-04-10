Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE3A17A305
	for <linux-serial@vger.kernel.org>; Fri, 10 Apr 2026 04:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775793697; cv=pass; b=VTqACpxM5HMkKSlOHmCom7mNU9sFWdVysgee1CLJONXwSvcd0sCG/uhR3AlYHLYVmJNDrR2jyWKI1IWXb9Z0tm1P1weQp74+1H1pA1Bg9/fNGbAdkshhWs6H/3iCRWnDaQ5ZjEhgpXH9pI4bmRE9HM6giAA/D+U/S7MUomCN65s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775793697; c=relaxed/simple;
	bh=c81jlwkoT52ivgxBtLV/pUhTYbuYIuOCRdMEcqipB0s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sqB/pVI016mPoEafBo2KGVwByL/7ObTF/5eyCG85zenuGPz8aJ1d6Vx0ZqBKqOAbNNPqB6ywbez5Xt1dEatie5FtcPqdiTfYmIKcbX8oU5UM0uj0IpAe+1NA+Qqh7obVbvOx9oZwerHc0fEMa4m4NIeUovdAvwiV+RrrVhIp108=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aWWhM5xf; arc=pass smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aWWhM5xf"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-79a46ebe2beso16918417b3.2
        for <linux-serial@vger.kernel.org>; Thu, 09 Apr 2026 21:01:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775793696; cv=none;
        d=google.com; s=arc-20240605;
        b=L+ZKyC3nREI0fM53T9DM7omkA0MUPo42A6vPJphd7784YSjOtNH8rf2Jnopwo6rMV7
         ai2jo4Bl1EA1CohQlg7yjbT+voOFMNRrFjMaUcE5lnIkSdidNU/o9JlH0QoS4u4306wy
         nZZkaTwlegcvqHLyAPtE8hEhESuzdG8zb5IhWmLDgLPLLnugmQH3PT2A8jDf0ofSM01W
         zO6jVySdZBeTtoGDKo+Glpk3obvObXvBDXDfcQl4c5dIGAZCnhpJPFDxw79ukSbbnlug
         YVi02xOxyhBv215ZQx1GTffsJ/Jt/4f7J82KQBwylw2nA+6ZxfSulLPVFwHlN1JIPqKD
         5zHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=c81jlwkoT52ivgxBtLV/pUhTYbuYIuOCRdMEcqipB0s=;
        fh=HZrzIZH07V4WaX1SKVyKjVC2JHMoUvgzf4PaAfHMpWU=;
        b=Za5nGCAXZNncELKihHW9zVFXlGeqE8rT7p0OhAsRNLAdxLAlqajV/8pUIHdtOnh9rP
         jLRMfLNtYeY41Mz6jDjCRyexTtNimxzeN3pJ78haVS3VWRWhWaoiXgkY8vnbKh62/5sj
         41Iw8N7AMLQZ+oJ1IGKVNKO07jzZdqH37LOXYN3tHh311ibWIfYO4fhzBp8lEARs6g32
         IDr0+6wjHyGHobs646v+AbKAiXMqF05ft0Qi+d0n7twZqG3dtCEUepfZAhEgDVzmUR2V
         yAZY5Z2G1dv3rUMMdRSNuM4WVUSw8rqruJ0mQBvZOhrTRad4l7DcbkIe76etCGSDknQp
         CC7A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775793696; x=1776398496; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c81jlwkoT52ivgxBtLV/pUhTYbuYIuOCRdMEcqipB0s=;
        b=aWWhM5xf1jI0SHocgPbjo1V7+4WzGeYBQZdVuCZ0nKzdAk+OjA2fsygncCfoJFgjOo
         CcFhTWdAk8pQ7id9H08BL816QQWrFPBdA6WWIloTZG3coP5tViB5j4UZ55htqILr+KDN
         NfBMApKhgYp9CzMB6iak318Z8swPvtZ4JvuephOJo0JtRQSq1rtxZ7/BsGLTfUlkKfv5
         rzRtKw5iy4+E4/mSWCJ7RGBoXlDF21kWP8SWo+75VUKhR3UXgbVjDOiQSHrW8YKDvDnU
         9palGfMbG0NIN/lrOTOoSvSPeUeuJRVuR/XDC4aZHSn41yOac2lKVxfmgyDVgnSFMaFL
         /+oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775793696; x=1776398496;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=c81jlwkoT52ivgxBtLV/pUhTYbuYIuOCRdMEcqipB0s=;
        b=hyKF2BblxxHs1EZUix3ACXI19+ZzmuHXn3p0VTCnqFKV49kQgNJEOHEq7PxfROum/Y
         phJ/hlRxUB89JtscjmG8ZY9TPq+/scRu6dqAMvN8YnNu34kuqmE+yL8zLt0VhEp0PqLg
         DWyIIb/5aDZybCImo+w+D1W5K3Pqha4KLA94q2FS3PClTugjXL67txJ2FknDX6YsKZfe
         WigWplHdos68xNmhskl9LK821dGTEbSO2i6uwdEPhcIKiza0Cq8ip5GDTltPr+/10mRv
         e5ZEdRTF82deFHnSfaKli0Hh0DM+75oTzB4T9Q8cNsW9ftKGyqig7Ywad+tQLOJp5+jT
         DeTg==
X-Forwarded-Encrypted: i=1; AJvYcCUVpBUgh45HQvOyPeAlL/VQqxbNPuDe49SFwYF30xFnt5a7uQyfcUvlsXCD230FeWOMnuvzFU20VfSd9ig=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywqd1P/u3gjp05bbSpkj4O/nSFgd3DVgfL7Gsq7h3/oqeNxqH9W
	gXcdEgInjbrAcVzmB92LPEOcvuhRJV8qQArzv3i5WA5bfl0J2quK2502miMN4LNmY7fz9Fxub0r
	jyuSSHnf57rZhwUsczazh3VYfajkSvP4=
X-Gm-Gg: AeBDiesR4whLtbhhh2sL9C3Yq1wCSiD8/2JGJOGFE638zVssChgmEU1GNq3oLAgUzuU
	XwygMTfQX+K3VcquFhGK/hmudI2aM3cUchu14oYcSmTGsyeSNGEHINYvKhJNxSxfpuR0VLtoXDu
	Nydrl8tr4ktqgz+2K1NrYIYJYSzkH0aOUWBNKvQlpqtugnAkQdHf3Ehs4PKF2Z5WA1vn+ShrnOq
	FD+XcTqFcTSNd9eaZT7URKHEch17jrzl6CQLIMZecIgeBAd61qaqPOb+lEFI6+7hwQzSh6AKeAg
	vL0cuklw+EM=
X-Received: by 2002:a05:690c:7107:b0:79b:e24e:e2f8 with SMTP id
 00721157ae682-7af6ba5c131mr19081017b3.0.1775793695597; Thu, 09 Apr 2026
 21:01:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260306034058.386747-1-dqfext@gmail.com> <20260312120036.GF5735@suse.cz>
In-Reply-To: <20260312120036.GF5735@suse.cz>
From: Qingfang Deng <dqfext@gmail.com>
Date: Fri, 10 Apr 2026 12:01:23 +0800
X-Gm-Features: AQROBzBNyIPd0i0SJNHwjTwparsm0ql4G8ebtjevqd-KI_EvSGYWLss5UzCUY78
Message-ID: <CALW65jY1qjiLNd_viqgiXodwGe1VzQx_qKUU2rRHMUp8TK7j_g@mail.gmail.com>
Subject: Re: [PATCH] tty: ipwireless: fix memory leak in do_go_offline()
To: dsterba@suse.cz
Cc: Jiri Kosina <jikos@kernel.org>, David Sterba <dsterba@suse.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Stephen Blackheath <stephen@symmetric.co.nz>, Ben Martel <benm@symmetric.co.nz>, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Greg and David,

On Thu, Mar 12, 2026 at 8:00=E2=80=AFPM David Sterba <dsterba@suse.cz> wrot=
e:
>
> Thanks, but the driver is going to be deleted.

Even if this is being removed from tty-next, the fix should be applied
and backported to -stable.

Regards,
Qingfang
