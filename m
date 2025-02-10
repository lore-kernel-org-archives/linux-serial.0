Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0E21F8BA4;
	Mon, 10 Feb 2025 14:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739198719; cv=none; b=BWI476bB/QHFzWiX7iY1n7hp3SW2J00R/z1iFt0igRcn0TLi1ch2vQROMv759jLeazDdhqZ4kZHPTKNcLyAluhhzhz2rymrOim+8oaSw36s5jTwztkBSeE8InkeRBr3k8/XwHdNohbOJwl5nSxQGjcEDZTBYtElptpl2ladoftQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739198719; c=relaxed/simple;
	bh=nhr7hpK1VIvrvV+z1ur/qKnGF8vyc+TGKnlWmKdWXeQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lh+xjpVgmE3uwlewFjnRIoq4TojM26u1xPK8vJGuFREW1k20S2taSU9CII/TwYoFfDtXZGgH/z22h5UptZg1w0Qxewh/uXxcdHOUYtAEH2ZLjESL/W29OO/R+WVFHrVOkB+UuuNBvulLPpSrnuwqWGS2zojXuqrAiNtxmM+YJQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-51f227e8bf6so981151e0c.2;
        Mon, 10 Feb 2025 06:45:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739198716; x=1739803516;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uAJLVUtV1uNk8a8Qt0AzYeA1T74JqitGZuvVYe9BX6U=;
        b=bVU0TP5t2JilJdL6aATSD6HBjRs8QGe9Ct0AFHSPgR+RKfuqjjMsMEvmR0Y1fNLiez
         0UJIUOBPNGBd2SwkLmAEsdz623UlbC5NZYqlZU1ke01IQA/eZ4n4S/KWN5ROfCsox0bZ
         70r/p2NHtiJnU0uEWFh5ZE6hJmOsAyK0UZ+xxToiNq9YMCBbiZ+SYGaRvftRwyAtivQt
         pRk0NVd8+sbQdRlNECh0yhSDOv6HOzlYWBdtJD/0PiMfezCKrGBzjKEtjtwcha7p/BN0
         VNhs9LyF43OSgy3/bFEw9MKOiHpa2c/eyYBaEboyLJLTwTIib6lyqq3sgtiYlEAxw4Hp
         NZgw==
X-Forwarded-Encrypted: i=1; AJvYcCVj3eDU7D11a+QjHSEoZ+u4f9ut8xTlqAZtcVc7jRguMMdCTx9yqG+0OBiJRlAiofo+2fY0YohBSq2LKi+0@vger.kernel.org, AJvYcCXNfki/3I5Ma4yjduqsKExqLo8f7o4hK8Y8zLLRbjhjoBh/R94DrnaNQf66gH3rzqgAC0g/gjmsK06Kt5Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJiBxyQ2ga+7+lwwK4c4efI79t//tMtZLLLSw84zOOZHdfTV7i
	k7BG912Kb7mMhdXqZNNMrlS93515bxG1MvoyB6xwkgCBScaCFIhsLHlKKsXt
X-Gm-Gg: ASbGncu5ceUCVcIUZ3MevjoMrZuu0KzKuSpRqYfUxWKK0qNCUwrW0AttbQ1etJF3Cwq
	cEka1MtHl9Q3e9eWPpAr4K0zGLw7oHEFpjXy7cufi1bWwbYBp103q95/D+U85wTgBSEarpX05N4
	W+gwU+z1u9N8ZkRPAUwZdffs9lOv6r3EEdXlVtvbFJYpWdMgdCoY05cbNH3/u77he1t9AzMMvXs
	hh5nSEmHdT4Cm9KAESOKYiqnvPAATwy5sZRE0K38CktQf6XmPngEOPEtBznTlB7gvygbi/g16tC
	pWU4k1CAldPt46M3UqxjXVFhiMMAImgQzdN5YdZAWX0R3D1FBDliBw==
X-Google-Smtp-Source: AGHT+IEcHfxqaN3rWEXMOjU/PbxokS9siLxZQ6IMkqhUcZXlwk9XMsdJuSw6tMmeE0bJzAEMfuRy8g==
X-Received: by 2002:a05:6122:794:b0:518:7ab7:afbc with SMTP id 71dfb90a1353d-51f2e251f93mr9142946e0c.7.1739198715593;
        Mon, 10 Feb 2025 06:45:15 -0800 (PST)
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com. [209.85.222.46])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-51f2295a7fcsm1350817e0c.46.2025.02.10.06.45.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Feb 2025 06:45:15 -0800 (PST)
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-86112ab1ad4so1301329241.1;
        Mon, 10 Feb 2025 06:45:15 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVuR3B2oQiOaVkEHoBc4WYbM1x0AfyuJeOcZuoFvfrvNeBzz1i0LQA48tt4EKuHchWA2sQMD2/XIOrIroAo@vger.kernel.org, AJvYcCXGeiGrZFbguClmHjpZbpwfpzVCp5irnpoypJPCp0SYqgotL8Xxunj5OU8Gbg41BKYL1wcLPHaiTvjOGWY=@vger.kernel.org
X-Received: by 2002:a05:6102:5089:b0:4bb:b809:36c6 with SMTP id
 ada2fe7eead31-4bbb8093b3amr4440243137.11.1739198714935; Mon, 10 Feb 2025
 06:45:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250129165122.2980-1-thierry.bultel.yh@bp.renesas.com> <20250129165122.2980-10-thierry.bultel.yh@bp.renesas.com>
In-Reply-To: <20250129165122.2980-10-thierry.bultel.yh@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 10 Feb 2025 15:45:02 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVD1dLP53V_zOhxpqazDdPDVafJ6iohY8u6WPQrmYH5Sw@mail.gmail.com>
X-Gm-Features: AWEUYZkLBpiXQf6Zr-W1Pn76AhNH67cEtoc5GxK0GOKzsykkyraYzk22LHV8nZo
Message-ID: <CAMuHMdVD1dLP53V_zOhxpqazDdPDVafJ6iohY8u6WPQrmYH5Sw@mail.gmail.com>
Subject: Re: [PATCH 09/14] serial: sh-sci: Introduced function pointers
To: Thierry Bultel <thierry.bultel.yh@bp.renesas.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset="UTF-8"

Hi Thierry,

On Wed, 29 Jan 2025 at 18:03, Thierry Bultel
<thierry.bultel.yh@bp.renesas.com> wrote:
> The aim here is to prepare support for new sci controllers like
> the T2H/RSCI whose registers are too much different for being
> handled in common code.
>
> This named serial controller also has 32 bits register,
> so some return types had to be changed.
>
> The needed generic functions are no longer static, with prototypes
> defined in sh-sci-common.h so that they can be used from specific
> implementation in a separate file, to keep this driver as little
> changed as possible.
>
> For doing so, a set of 'ops' is added to struct sci_port.
>
> Signed-off-by: Thierry Bultel <thierry.bultel.yh@bp.renesas.com>

Thanks for your patch!

I can't say I am super-enthusiastic about this approach.
The SCI variant in RZ/T2 seems to differ a lot from the already
supported SCI, SCIF, SCIFA, SCIFB, and HSCIF variants. The latter
are very similar, but usually have just more features/registers, and
further differ in a few different register offsets and bit locations.
If you compare the RZ/T2 SCI block diagram with the SH7751 SCI block
diagram (or even the R-Car SCIF block diagram), the most striking
similarity is that both have a baud rate generator that can divide
Pclk by 1, 4, 16, or 64 ;-)
So perhaps you're better off adding a completely new driver?

What do other people think?
Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
