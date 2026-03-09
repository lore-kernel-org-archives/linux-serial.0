Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B3936920E
	for <linux-serial@vger.kernel.org>; Mon,  9 Mar 2026 07:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773042310; cv=pass; b=bDYIQst39xydKe5ZY21agD4Vk3DVI9+voxjJ36J1g33OSl+6oETUmcDDZSFfQfldzvkBZRJvPIzBVscrP6wIM85WE9E3jPGz1gdDN49nsk8BI1sAJDlkadrm1laZUE4ZAFPqUTPBAPD3pOBd7L6HHgt/KWALpZdE9oX/eo6rt5A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773042310; c=relaxed/simple;
	bh=6mDtFQtIV7hWPkA02q2hxE8rclBrjnmuzHeD/PSKnVE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j3WCVzCNfL1XyHGKESCg3TYp/Mf5uNZPauQ4gEQ9n4vwhJZj+x8S4DwfO/ICUJ5DWFcJKKuchk4FEcnjpk9i1dYUqZn6P5CvCaL24aRFj5R69HnztjC3Tffgy79J5+f4lKctPcf4CJZYJwrRDcu31yAxlymaare7OhNnUBzbD4Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DqAlTyUv; arc=pass smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DqAlTyUv"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-8cd8c6e365eso44072785a.0
        for <linux-serial@vger.kernel.org>; Mon, 09 Mar 2026 00:45:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773042308; cv=none;
        d=google.com; s=arc-20240605;
        b=U6Hru6VtT20QrmoKskUjYn67mYjRflxlZpFLMbUEZvPaWtFTgPoSnuWNZOHeIlqO5k
         FUmZTAWXNdDPEI0mkX7G3GZkg9h+YNHOHnuz//x8D/3CjE6glOFeYYZd7icLXDbRyjlf
         yieQMtOwH7E5XTJN8/HBxH97Zq0N997CA55oiHbenVh45b1SX7pGdHQ/RM9nLafXPsM0
         +1PfBsqNbDut0+r1cU6CU8HV20kfa7djOZTYpxGzrwtvoj6q5nQSpqQgKUylvbi7IISL
         4YXFTbd9bpRH2EAo7oWzlg5auxcVuZbORj6/UMQHHc++UTBUfIRRoixP6kJEXZks1F+R
         DW+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6mDtFQtIV7hWPkA02q2hxE8rclBrjnmuzHeD/PSKnVE=;
        fh=6Ltss5eQT7bxmiM4hbIEw5LfZkpwZ07FwvrzpeSjOc8=;
        b=hIDOAfgswNxXwen0G+6LnLFh6qlZFb+OQmxcv2t1lnrECEViSvkC8cUSv8MyYn36Ch
         ldxos/zYxm7zaSG5kSgZnspU7rAC07NS5sJ5ehRTR+w1PWMgq1/1aXhGCKWV+qm30JWv
         78jWnO8c8o+UEozhWAXcZbq7ne1G8zZy303KCb/xTqrS/cLBIRIXcBN9a13qqxcOsDM1
         YtNCtbe34FASJXlsNreOI7+ELWchj8VYgEyrdRx/lD5eofUWLPoX7nutVekcFvP1a6+a
         5Lqf3zA54ROeoUMmohf42X+kC2F9D97X3QHqExYJqC6quUhhTZj40YGFITfOaOsX35s/
         Pazg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773042308; x=1773647108; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6mDtFQtIV7hWPkA02q2hxE8rclBrjnmuzHeD/PSKnVE=;
        b=DqAlTyUvkcq1yqYqGjGoxq32ZPIk2yBF3/gkjSVXC3BlTy7ivILTGXaL3bae+Jp1FS
         kyIqW9Fg9w0gxTdmuKd+UbZC2zgBkGVI5nC8INBgQXrrc4aSdq1iUH2rZIUFFD30wPMA
         KvQvMt15jCR6JIxmcw1CKNdSCsXRq1ooePvmjnQ0w6mJozDv/eFpi8Zc33KqJvKHsoJ+
         RmVkM928so+xOlcbDd1TIcrE8uYVRenxigQE+DL6bXXdLeW7D1mCXZPyCOPwvPpJ3Vo2
         zMSgXAd90eoRjpX4oTuabfTjvh9wYNBrSTP33JBLSZMKNSwtE3pcmLaUHMRASm5NppeX
         O4EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773042308; x=1773647108;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6mDtFQtIV7hWPkA02q2hxE8rclBrjnmuzHeD/PSKnVE=;
        b=EFw6dN9Pg0HkOcTkz//b8zDwQHbiF0hU0v8osH/OfzslFg7aKKUiaDXiflsA385CUK
         Az5B3snkrfPS82ztlXj5qXkdKFjrxgcJhpVQMABIKG52fk33qvwO4AqQFJbH08Zq2xdW
         LzYvBTt/vK4NHw4BzR8Wvi1tH5FfMnb8PN7vLj+DBRQ9ILqe/yQWuUiZk0Q9TK4ILrNX
         XyTdOZckvPWdZ8XazdueQ5KtRQoO2mhzHZ8Q5vBJQ8HrXVkmLx9nvQcITi5U/HEnR3T2
         oo205/ACBxSgOJI14Wbg9e1/v7TFw4gFoWiFectGWD/v0foYvao2Xz6M0AOuOERKiWv6
         3Mkw==
X-Forwarded-Encrypted: i=1; AJvYcCUuMrhrcLhcL8Fb1qWHxq1x86/vmCFQ4JKyhhlYkVaWboMxOBOzBB2iOU4S+WUafYE6E9Ch6VyBrn0UVrk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3de5RAlevlg2pyKZPYFgnMVRoHY2KEYqoEOxrk84mtmeFhXVs
	deNVSmB0cTgCKYv5YrQV2BVwIjQxRYdLeCh4aBYYR7F6qimhCp6PT3RumueaFzVRzWSglACAxPq
	ViUt1XluO2WRLEIfJq103xvzZ/KwNs0Q=
X-Gm-Gg: ATEYQzxx4Shzrk2IpjNqOdeLXIbFEIzHecztSh9GYOFiwAVGaNrEu2MEe7Ga+yYDy5E
	5JT3rwPDbdgKNfmA4Ji5l8nP9uexoNk4rQY3NR4dTw/a8F4WSohvDsUs/tXkn7at4kexYkD35tr
	asjwz9ZobYG/qxwMEUypL8cpnjt4ulFrERSCo3Aj7Ja7FShhwGgEL1+dwn2WKXBs352tPB2hbZk
	ZIgRO3oCvKwNxii31KR5jxBGrgLIrycpXPVv6RqvMzZngIuSuV+A47RwTvrtiZeEVfB+RWis+rl
	2PjG3vy30sa//+l9LXsQgWa/PA+MjPEw4nOWs9agSRPSEkj3hJ1fsZvmj90Uek5TaBI=
X-Received: by 2002:a05:620a:1a93:b0:8cd:8072:8722 with SMTP id
 af79cd13be357-8cd80728affmr542236185a.0.1773042308458; Mon, 09 Mar 2026
 00:45:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260308131412.1102749-1-julianbraha@gmail.com> <2026030845-chastise-briskness-3317@gregkh>
In-Reply-To: <2026030845-chastise-briskness-3317@gregkh>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Mon, 9 Mar 2026 00:44:57 -0700
X-Gm-Features: AaiRm50F4EdiuatwMyJUQSJnjLtoBuBq23eYvbRM47sOLulCLkJhaUvU5Sr25xE
Message-ID: <CAMo8BfLAS_SEr2kFu+kj3gLTDkTxfXJ3fdc8Mgt4PP9yjUr8ZQ@mail.gmail.com>
Subject: Re: [PATCH] drivers/tty/serial: move ESP32 UART drivers into staging
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Julian Braha <julianbraha@gmail.com>, rdunlap@infradead.org, 
	ilpo.jarvinen@linux.intel.com, conor+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org, jirislaby@kernel.org, 
	linux-serial@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 8, 2026 at 7:16=E2=80=AFAM Greg KH <gregkh@linuxfoundation.org>=
 wrote:
> On Sun, Mar 08, 2026 at 01:14:12PM +0000, Julian Braha wrote:
> > These drivers were added about 3 years ago, and depend on the
> > XTENSA_PLATFORM_ESP32 config option which has never existed,
> > so no device can actually use them.
> > They can only be compiled with COMPILE_TEST.
> >
> > As you can see, this config option is still undefined
> > in the downstream tree:
> > https://github.com/search?q=3Drepo%3Ajcmvbkbc%2Flinux-xtensa%20XTENSA_P=
LATFORM_ESP32&type=3Dcode
> >
> > I propose moving these drivers into staging
> > until there is a device that can boot the mainline kernel and use them.
>
> Why not just delete them?

I agree, it should go. I haven't had a chance to get back to it in 2 years,
and it doesn't look like I will any time soon.

--=20
Thanks.
-- Max
