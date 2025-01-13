Received: from mail-pj1-f66.google.com (mail-pj1-f66.google.com [209.85.216.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B490F136347;
	Mon, 13 Jan 2025 02:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736735390; cv=none; b=USA0xnzul9zQHASOt1pnqRHbwoQR8CReqKpQwWqi83lvTQwumK8Tmcf6ZZ0NcZwxopzbT03RLic7VdZkr2v5zYu8AYGfyV679SQ6vVAwLshptGVSJ90kYMaoHvVWwn8+u5XJWE8znVIlbmzM50O5YghHp80trOHzZR/XslNk+oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736735390; c=relaxed/simple;
	bh=pt6GPMGLe5Kb81/TUUohFfqWaMK5qSUqlYEjzGxyuu8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JCakt8kKg4C/t46fCooY4h+MRCoAAWN90WhjbwkwGlWZr6084cePYwkCuI91XuvGiqeK+jFhQF8S/t4U+btk+dARTtEO9ERD4uEuXDWTHl1c/xTf9CGC3ne8CnzphO7JgfEiD1dvIJkToP0HByskFBkPYBoOd9eOxK3QUa8NN3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X88e1V6v; arc=none smtp.client-ip=209.85.216.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X88e1V6v"
Received: by mail-pj1-f66.google.com with SMTP id 98e67ed59e1d1-2ef748105deso4746358a91.1;
        Sun, 12 Jan 2025 18:29:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736735388; x=1737340188; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vUrVH4aacFdJVjPDW/MycxVSTi2OTOawDpwvP4n0QFI=;
        b=X88e1V6vbDt/nt4+TOsaMx5mSB//nAkI9F80p7OWckp0mry1P4Z0OJfKq88sYmlPM7
         KDrT9OpuZG4nUM5hg2GNfz1TUmSicWqry+vX2ZMSYiJ+3M3UHXZZmrfrj0sg+8PG8dM1
         mC1s9FN//TQyELCVJBoh223pb5d+Mk/uhvp0EksP5QUCO2DVPuEsSnjiHDVgjcfMx1Vh
         QbGcIMXGX4k/mpkps6UbQ2sAtCAv3ad7ZpCxTk4Y7JN6sbnHTnI72jtqfvyHdo6LVPeL
         uNnRAdiTvPZwMDonnxMNHKsJbkeYmPONSfFMOioFyix0vKvADXf24w+6g/Byv2o25ypP
         oeeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736735388; x=1737340188;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vUrVH4aacFdJVjPDW/MycxVSTi2OTOawDpwvP4n0QFI=;
        b=TecOavmbgOjqwMMKVkK3tQczpSPbGuCysWZ4Ifj2g+KHprUSH6HHE236hjdSy0MT77
         DoVPGkub1nxLNy88KOPJgs859asoFyrUb/f4q3aNl8rnDN4MvDLpUB4xsPLieyG3OXbc
         S1w22S3GbXGUTI838/jZh0hSer0ka8plKLqW5ScqmPx2JkgxK6f6n1kpy48Y5q1pyhyi
         +AQ+S9XzS9/GItNul0tSWwUAFDIEM7OzmUOQuFnfxCh4XJ0FGwi05t6A9XgsmauTwyJ9
         s4rioH7v1IG5/aVZNF86t+Lbb/A3hvNAzymyCkroQFYN74oU10eqJ1PQWQU7H/P9WnPz
         EhSg==
X-Forwarded-Encrypted: i=1; AJvYcCWeXwvbaCpIQBOIUyZJMVNaIOPZNedf9nP+o8W5xxAxLVDPPZtdiqwGRYt4HJZCgetgLgACLvjU+Sq5HqoX@vger.kernel.org, AJvYcCXgOzFlwaMdYvOX66N7KdPo2cHbhk0kKRM0sSMqgchcELNkfTl+v7QdV2PP4BTxcuKNaxJr9ELUeXNB5hUq@vger.kernel.org, AJvYcCXjSARKf9RTR7SLTyErVn6jX4oHbY1V5tl5AwO4eADfEgekWcpa0FpWv7z+VP42LUzP2Il0T4tIDPNe@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+kUFKRmKGbPCwrntdLLuiVKJ/2mPks48OMXXK/qvXiBUiwUA2
	52ybPj3WUdAthJfg6bsAjC3iA5zN8oV6MvzXSzbcCnCLaF8gDPKndrWPjfbnDOavQH6F2VeoaSK
	pAiCqkFrMZ1D8hV0fUb1aM4Q3o0g=
X-Gm-Gg: ASbGncu8D7tjdJEqToQdearjvErx05Tl/ubVxZQB6igEzVRi17IdgGPOmPqXmvBkMSe
	gRu5DWMgdAzI8JF1+0hdJQcP6KoiI4h5hWWTkVcI=
X-Google-Smtp-Source: AGHT+IGSBqLF2gMSSKpnLuPyUjSJuGAnKMldnTKDMIUwHKTo2nYEudWI5KUm8FLAiLH2+I5BtJ1w75UqTk4O9P3Mcao=
X-Received: by 2002:a17:90b:5146:b0:2ee:c457:bf83 with SMTP id
 98e67ed59e1d1-2f548eca259mr25990074a91.19.1736735387990; Sun, 12 Jan 2025
 18:29:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241113110516.2166328-3-Wenhua.Lin@unisoc.com> <Zz8m8PqHX_7VzgoP@standask-GA-A55M-S2HP>
In-Reply-To: <Zz8m8PqHX_7VzgoP@standask-GA-A55M-S2HP>
From: wenhua lin <wenhua.lin1994@gmail.com>
Date: Mon, 13 Jan 2025 10:29:36 +0800
X-Gm-Features: AbW1kvaWPG3bYWfRi9sb9ReJAZ79gNzowAv629eYn2MdbVyE7wCkorXnVrhYdAQ
Message-ID: <CAB9BWheKNoA9u_TL4=5G5NCioJ2wHbrg3wZFZPZ=-nzXf4dyzA@mail.gmail.com>
Subject: Re: [PATCH 2/2] dt-bindings: serial: Add a new compatible string for ums9632
To: Stanislav Jakubek <stano.jakubek@gmail.com>
Cc: wenhua.lin@unisoc.com, Zhaochen.Su@unisoc.com, Zhirong.Qiu@unisoc.com, 
	baolin.wang@linux.alibaba.com, brgl@bgdev.pl, cixi.geng@linux.dev, 
	conor+dt@kernel.org, devicetree@vger.kernel.org, gregkh@linuxfoundation.org, 
	jirislaby@kernel.org, krzk+dt@kernel.org, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, orsonzhai@gmail.com, robh@kernel.org, 
	xiongpeng.wu@unisoc.com, zhang.lyra@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 21, 2024 at 8:26=E2=80=AFPM Stanislav Jakubek
<stano.jakubek@gmail.com> wrote:
>
> Correct me if I'm wrong, but this patch seems incorrect to me.
> The 1st patch suggets that the sc9632-uart is incompatible with sc9836-ua=
rt,
> but here you make it fallback to it anyway.
>
> Also, both of the patches seem to have made it to linux-next without the
> reviews/Acks from maintainers. Maybe Greg was a bit too fast here :)
>
> Regards,
> Stanislav

Hi Stanislav:
   Thank you very much for your review, we will correct it in patch v2.
Thanks
