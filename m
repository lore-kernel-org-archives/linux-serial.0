Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4B6611E;
	Mon, 23 Jun 2025 08:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750666810; cv=none; b=bstl89PKnct8nk+Tvwe8NilVqCqZWGGm+PGp3487ioS8xcRhqmPniFM7FUv+QbpRDp+gLJqQcCSjISEvgdtn8Njsg4xKiboBrdjsAAKloCyRmXBAREAmlxIb/x+xy09WR09wYoLGjQPvoIx4N1CTjCRGLWodYsYNMx8P1mCh9PE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750666810; c=relaxed/simple;
	bh=vQ3NdGm6nr4U+9F4Qc3Fz9IFHhP2xxNTl1OqC0Evr9I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tLKHCDKcGQgHF5FWoO1dA1VLXLG5udbtLJ7trikJ3JyQP+/93Y85bnWO9dmGIeVN0FbDGEfYHNDHVu73LvzSybek2AMK1y6kW9aHy48Rr/J+7inEK2nxM+WtQbypikEEzyUxwWNhDMw8hPA/qdjn13SXO9CdSEtZZSiHw8l/7oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A4UIZYUl; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A4UIZYUl"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ad89ee255easo712394066b.3;
        Mon, 23 Jun 2025 01:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750666807; x=1751271607; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vQ3NdGm6nr4U+9F4Qc3Fz9IFHhP2xxNTl1OqC0Evr9I=;
        b=A4UIZYUlqNPqy/UmDQREYiaPMA0so1K+igx85Iv10zfrm4z806+3/bhZhRz2ZanZ6S
         AF5BB2JL2cEdYdKXzaoc1RW2e7qlIrZFIOasneBnFbxnK034t3l3x+erOa9uQMnamniB
         yAu9LSLBJmP2Cqdrk2XbzAE5NonuFLvkpFOXxAulGtDaw4RL+YN5Y04pFNL1dxegS6S/
         6oLmJjcrR90/W/jK/LeLBaLoUEzI1Vau2nIiGZt6SmVCmtUNoBmXpAp/XXKhiga+ro28
         LvwQvok/fHNbG/9yyt+Mh3CnNDWv82jsGAZ8MLAUyIVfY0KAP6QSE7u+bHslYUitbklU
         zg5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750666807; x=1751271607;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vQ3NdGm6nr4U+9F4Qc3Fz9IFHhP2xxNTl1OqC0Evr9I=;
        b=He41UaORQtupPUMJ9fpwhVca8FrKiQbC6yJdO61lnVIhm4o4Qlvo62+/5Dk0zsI3G4
         iw4JbIsHZhaaT6Iht9/48Ueer6tb8wUOT+rm0tvEejCuSORpN1SmGYeAvofs9Ft2XudK
         UTDT0+mJDZxzmyInc+KVxECeuM22RZKOvpLT2bQDI0hhVolX6nZ/4/MODxrUkhw4E4Y1
         30ER5xZ5MwPsKSwZWrjEm90Vz3aA4EPCWZBBRzmFnFeaow+ULLYIZtfmstfKrk61L+aN
         /2znJXP1xsDljlIDvFVrlRPNEKzrp73e4KGLzEF+Pi3bh5VKY47aP1KLFEA6PzteqwFP
         FvZA==
X-Forwarded-Encrypted: i=1; AJvYcCUb1Fsz+scM3Y5RKGpUSz4zBeKXHtzvqDV9dfSTQGgVj8UHNN0osJHQmcr36gOwB6hjE0V6CdfMKil3mUM=@vger.kernel.org, AJvYcCVzlIum0NberZrjbIOOyfCP06vuz1f73Voxkd07ovmWJRAwS9E4ma5bK6+lbwulpUJzSpFlBDVf/dYKhnC8@vger.kernel.org
X-Gm-Message-State: AOJu0Yzd7Mc+C27+NNsnSrMo/zNT56YaFH4K/bW29eXLdcjnzZ6DtRNz
	Kbv2mQxzXHgLc4auakiKJq3d2e9R1SJbjWRhNxO7Q7kSi1cQXfzp4rnkvhhljv+2txN3y0Vo91p
	4ZHiOq6P2fVtQeXZ+aiBgBgWrWyl99nc=
X-Gm-Gg: ASbGncv0ESTiuW6c0alkkMRVB/ACfJrSLRkkFMbV265gWyp9rN5axNsGq2u8owh4N64
	DeiJ+O3Md27bkiwH0GfGOXJsK/GI4Zk8/plm/6a84+JNbv0zz45nB72l7vKHjCouMKYEvUtSnAm
	fCDrny1xSGdElWSSiHuIv3FY383dwFrqLFtZ226o8oYGnSFQ==
X-Google-Smtp-Source: AGHT+IGlfPv+3y0R6hYF+u4HtG1mWOjwQo+JOIVfYpdIvUWKcWjPMT6HJoy6U1k7L2cMnDsMRLfdT6+/IxvW998DPeE=
X-Received: by 2002:a17:907:e846:b0:ade:3eb6:3b0 with SMTP id
 a640c23a62f3a-ae057f34d92mr1154129566b.31.1750666806637; Mon, 23 Jun 2025
 01:20:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250623074606.456532-1-jirislaby@kernel.org> <20250623074606.456532-5-jirislaby@kernel.org>
In-Reply-To: <20250623074606.456532-5-jirislaby@kernel.org>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 23 Jun 2025 11:19:30 +0300
X-Gm-Features: Ac12FXxFda-FDbDzSCXQJ53RDRPriasagqdTqbRXaZDTcU4mUE5f_ygqXy31Jy4
Message-ID: <CAHp75Vd0-cORgEozDcoogYfO=XscFwvbXhseGfdYNqmE3HHWEQ@mail.gmail.com>
Subject: Re: [PATCH 4/5] serial: 8250: document doubled "type ==
 PORT_8250_CIR" check
To: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Cc: gregkh@linuxfoundation.org, linux-serial@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	"Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 23, 2025 at 10:46=E2=80=AFAM Jiri Slaby (SUSE) <jirislaby@kerne=
l.org> wrote:
>
> The check for "port.type =3D=3D PORT_8250_CIR" is present twice in
> serial8250_register_8250_port(). The latter was already tried to be
> dropped by 1104321a7b3b ("serial: Delete dead code for CIR serial
> ports") and then reverted by 9527b82ae3af ("Revert "serial: Delete dead
> code for CIR serial ports"").
>
> Document this weirdness with a reason.

Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>

--=20
With Best Regards,
Andy Shevchenko
