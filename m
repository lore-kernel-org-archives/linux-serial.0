Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3344B1802D9;
	Wed, 12 Jun 2024 15:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718206363; cv=none; b=b7wphDWFJUCnqGFAfD3wFwYHiNyoaxHQPMH15HwE5+cf+emXaprgPneen2Xn5XYtxZjIfUT9pxj0DjSKPFj77OGeWrDULbWA/70iwSoq0UkTkPh9gb9jtHB6Oi8tnh3cltQhlbmpHS2nde+xtetP04NBOepcwEVLRhaS35jc/20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718206363; c=relaxed/simple;
	bh=ifRzRxf1rrmcvnfimIiSxsCywCmMXk1id3TTD2HQxtg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K9vH3ad7FGunF4V/1mC1ksZErLEyQnDZlXOUzq8AiQ3dQjeSpFrVFfXgXp1Gpu9wb6kqUBWHDVPJ2BdiqWg59VjqwN+EO0S01EEo+Lz4SMwz2jFGwFW/Sh4G2uAxENfIiNP0ZsOYrGHX0HxiERx1u1jIZfMeYOgAE6jhaf3kmRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NS2Q5BtM; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NS2Q5BtM"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-57c61165af6so6617408a12.2;
        Wed, 12 Jun 2024 08:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718206359; x=1718811159; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ifRzRxf1rrmcvnfimIiSxsCywCmMXk1id3TTD2HQxtg=;
        b=NS2Q5BtMEFGhSJS2+CKp51OxRpnwWFWfkY5AYgZNtbtkYO/ND2KMEzXkGSnCp7/6hu
         iOpe6wZ0XEyin0bB2I9MbYncNWAcPiDp4zCmWRN6y/XfZ65SwZZs226OBmSBqwbkhCX7
         LRmlFMmMtiyqummQ06O3A477qRfeX/300geqd2tBvuZCsSMniycuCF5YQIHzTZRhCJ0A
         Quqzl5JtuMI4Gh40YnWPuDcbOaguSXPshR7JRJI1ial7oij5ZWbdNJ0aJwHiw51AiOoO
         Bdyf74lqvsStlKEtMg/Kwus2TsiLTsmAs7wpYWdoh4LlHtySpKDxDkBWoITF7KnbSPIe
         gcfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718206359; x=1718811159;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ifRzRxf1rrmcvnfimIiSxsCywCmMXk1id3TTD2HQxtg=;
        b=cN5ZNnxZNI+QdoJKiLHk2LamuW2u7gALLwS9ru4EyiyJTwNxzxVLYvGrkz75z7YF2L
         WxE45I6GXaO72cKeQGkriyYaBVTDz58jiYGLSznavle/jEiR8tcQ0GUnqIdrBjaJNv7O
         2pgPSk81Q/LR7DyUoLOVV0DTgGC+TaETg4DAc/y+w3ndXAmNP7iv25LGjApTmp8gI3VV
         xZJTg5dj4/p28vTP0v1fOy7HSNNyqhJqNRaRF7uZDSKeIe8UeeQfJD79cnBS7QRQSjb3
         ueelupmJ22bwbjEjNzrIuImx1wXI2jOv4ySMB3y9BaDRcvFjdzvmnvzI/72zw8O8Vvu+
         rn3Q==
X-Forwarded-Encrypted: i=1; AJvYcCX07ZClAUDVAmgyeAAs7o10CX3E7b2Gswq/jQc8Hd4iWwN5x7WLIzvfDHQ0/swaRAz4yqIoNhy/GG6x6hSHh/HJKeYZ+9bht8ts5rmRJEnF/BlZmgAC+uSlNU9EGNzaUDKVij8uuORS0zFVUPkQp58jgWPWmqDrB0aOB8PEcUi81h8LS6YrHA==
X-Gm-Message-State: AOJu0YwzvqgHy6d+E69nR0ykPkXAGtvx/F+7HsQqoXZMlOIUyCP//4+g
	+o67A6/9mQv/PIbuTKUsARl2Om3qw22DrdTTvP4cprRygM8P/1oC7Yr/F/Ise3Pkoo4C9zcroEX
	UUEOsiAH4KGyq84w+yvA3YSTKOEc=
X-Google-Smtp-Source: AGHT+IElaL2Bh5AGgHhl64jF1fLtnm4lTPWXn5/I3eAW+jWB96be+8eLrTB1DmW3qgp3ngxWnHbaPGIZmacUz33mK8U=
X-Received: by 2002:a50:8d54:0:b0:57c:60f0:98bc with SMTP id
 4fb4d7f45d1cf-57ca9754f1amr1507418a12.11.1718206359224; Wed, 12 Jun 2024
 08:32:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240612142951.37259-1-kanakshilledar@gmail.com> <dd529de8-07b0-444d-83c3-4b8c3424a7ef@kernel.org>
In-Reply-To: <dd529de8-07b0-444d-83c3-4b8c3424a7ef@kernel.org>
From: Kanak Shilledar <kanakshilledar@gmail.com>
Date: Wed, 12 Jun 2024 21:02:27 +0530
Message-ID: <CAGLn_=s=LtCJsP-BWFG9vJp_hQfQ_hnAtB6oKdTW68YxLLE_mg@mail.gmail.com>
Subject: Re: [PATCH v2] dt-bindings: serial: vt8500-uart: convert to json-schema
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Kanak Shilledar <kanakshilledar111@protonmail.com>, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Sorry for the confusion. I will fix the maintainers part quickly.
I have one question that if I find any area for the SoC is not
maintained or orphaned,
how can I find out who is the maintainer for that area, or the one who
last contributed
for that specific area?

Thanks and Regards,
Kanak Shilledar
