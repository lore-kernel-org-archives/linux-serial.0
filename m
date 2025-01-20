Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E4163D;
	Mon, 20 Jan 2025 03:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737344064; cv=none; b=rIEp69YzL5uG9wz2coiNlHK+2AbTKbCAcoZnTB1q4wDJHSDHDuNVhNzLbPKIACo/KrehMaxd1sJnR+qXraM6C8Myg3+aqJztwmnnBVwtUFNuX7HrUuIsB5EDR3cnQEEesZUfzgAJ8gx/NJdcgl6OR2gg/VwHEWWGV77xQnqEX0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737344064; c=relaxed/simple;
	bh=rE3eRWu8oQ1IWF3sO0CNbeQUpAQL4jSUUgUWpOIVt7g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lzlIGe4q5KaOu/ZfPtiZwGpOdJMPdN7q2GFrTVpZITBBuRShaJUpsipxzMf/BqQNOz0Z0pxhMeM25VT+D36yBQ/wNWHKi2CTD0m0xidZ5oj2GEtXDT9+/jbME2ja/K8ABSqcKoL49Pj31Er4dpV4/xLgn97ARiQtM/UWZNC/Qzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S142CehG; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S142CehG"
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-2164b662090so72450065ad.1;
        Sun, 19 Jan 2025 19:34:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737344062; x=1737948862; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=35P6qa6qPeWzyfLSHSb8M7/bdcuaFGBT8KSNFxJl9gI=;
        b=S142CehGlh/LAgbPwQ0nPNH9MW1OsfQp7DTeQcyqn+ZerHdOZLlBvDJQLECawFtci0
         HZGEpOvbACh/MOJ8pv1gbMS5JFamUwXRtt/t3c7gigPqL5OZT8sPIdP3NocY+IwDoJKj
         NM6U0+utg9UEhBOUcSHlhchIyN4/Tu2LBSRnw6bPKjxFA7KzGJ+2q3F4kNvMvzjujfmC
         4O6Z4XkpGL2Dvv9BY+/7oNDP/oXC58HSad1Hp4HA96Vm9wKQsFOwhgJnBd6DnDbbpsgB
         F0GjuI1fX3rLMK/NMAyiOBrmsDYm7GEEoNFWdI57yreGjNJOBKu1UJ4QMRxvWl2zBOxZ
         tEuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737344062; x=1737948862;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=35P6qa6qPeWzyfLSHSb8M7/bdcuaFGBT8KSNFxJl9gI=;
        b=WA9HX1wZk4cKgWZT4eeJ6fO6myTqGy0yMKRri7hU50XuXQMcmfgjGJzT3/IGfevdmb
         jJO7vVlUi3DBWEK/fcsA9BfqXbSzqa4YXcH7/DDNiMtwQeFiym+JRzcqaIKkMvP5bPPQ
         uwwJRQLUSOzgIQmlNkU9mHrpIjLzL0SfcZs/2nNCin2SMDDhbfImruFhOW+1UIWycv4J
         4FFrhLw1YYIsSzFpe0guvmXlykfu02r8yl5Pul6vJLIBjjc+WDra/Q486asT2eZj8nNq
         f085Dk5PoZxvAsIhD5RpVlOosVQsNM4bdTbP5VOyQiucaWNOPgg3iI2mjQbDt9QO1sUP
         3mvQ==
X-Forwarded-Encrypted: i=1; AJvYcCULH3S4547FTg6VUAq2WNCN9iyIZjew7BiDKGoMKT8srhr8TUy4/AR0/XlsQYSC8MDp4LafBt8zkX/wZgBf@vger.kernel.org, AJvYcCVnP8GTiIq7UhxrNzsowRqf9ZhV/KfScI1qKd+1ZPwjUB0/fAlC25SkmUvKDC8KbSDsjZb0zjzHuOa9ad7m@vger.kernel.org, AJvYcCXMfrHiF4zPfid4z4f1GzU310Mf2C8AGgRjPun8W11vdR3S1nBi1yMNfrrDsYbhwPGqJXA2V3dm7383@vger.kernel.org
X-Gm-Message-State: AOJu0YzB/dcKWTujq5WneU+IZOaFmRL6u6u9XisT/lM+OVjTrP0JVnmL
	PxQipOZKd83f0WoSN6wx7wJ4Y/+2p3voXNK/ttr7cIkFr+iXsJm/n1dBvUipU8NGydtwKhscBFo
	L+MW3nvz9oUI0jNO+LdRPFxSch98=
X-Gm-Gg: ASbGncsvzBjOFPPmpTbGZvFc93WT+62IST875QcwVvlufnH0Ar8QBMMgkcnNbOVlmwI
	/y6gVPY+kg77eLQDn/Gn/EVyfwOYOW9/TY/XEe/exgRPpN9wGblOd
X-Google-Smtp-Source: AGHT+IHjDhSIxrS5cApTojuGyCn+bQ2a7O5GF0rEQdoousI36pvazPb5tyVBHXSxzPYN65HI2ppfwc+TbVjicE1fR8o=
X-Received: by 2002:a05:6a20:6a0b:b0:1e1:aa10:5491 with SMTP id
 adf61e73a8af0-1eb214b3e10mr20010034637.24.1737344062289; Sun, 19 Jan 2025
 19:34:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250114054553.3376837-1-Wenhua.Lin@unisoc.com>
 <4591ac0a-80fc-4922-b463-79395c9f41d1@kernel.org> <32151d45-2f9f-4f94-82f0-ac0a0b45a290@kernel.org>
In-Reply-To: <32151d45-2f9f-4f94-82f0-ac0a0b45a290@kernel.org>
From: wenhua lin <wenhua.lin1994@gmail.com>
Date: Mon, 20 Jan 2025 11:34:10 +0800
X-Gm-Features: AbW1kvZjVtbABbOmcJ-0IKTlAmi5hdPi_wEkxs13y1_lTS_N1jdJV4Dp1vzdpjc
Message-ID: <CAB9BWheNnHD7OANqYXtV1oBd6N95B+BCuLPkrqQ=XmXLhTSUsw@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: serial: Add a new compatible string for UMS9632
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Wenhua Lin <Wenhua.Lin@unisoc.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Orson Zhai <orsonzhai@gmail.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Chunyan Zhang <zhang.lyra@gmail.com>, Cixi Geng <cixi.geng@linux.dev>, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, devicetree@vger.kernel.org, 
	Xiongpeng Wu <xiongpeng.wu@unisoc.com>, Zhaochen Su <Zhaochen.Su@unisoc.com>, 
	Zhirong Qiu <Zhirong.Qiu@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 14, 2025 at 3:40=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On 14/01/2025 08:38, Krzysztof Kozlowski wrote:
> >
> >>                - sprd,sc9860-uart
> >>                - sprd,sc9863a-uart
> >>                - sprd,ums512-uart
> >>                - sprd,ums9620-uart
> >>            - const: sprd,sc9836-uart
> >>        - const: sprd,sc9836-uart
> >> +      - items:
> >> +          - enum:
> >> +              - sprd,sc9632-uart
> >> +          - const: sprd,sc9632-uart
> >
> > This means nothing. Device cannot be compatible with itself.
>
> And probably will fail testing, so please respond here with pasted
> results of dt_binding_check and dtbs_check as proof that you actually
> run them.
>
>
Hi Krzysztof:
   We made a very elementary mistake. Thank you for your reminder.
   We will modify it on PATCH V2 and provide dt_binding_check results.
Thanks

> Best regards,
> Krzysztof
