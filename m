Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD96445BF6
	for <linux-serial@vger.kernel.org>; Mon,  8 Jan 2024 14:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JtfHFxws"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704723348;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YxB4hJGUskiSNKv+s1TrmZMXKolMvHe6Ob3/kfn7C0U=;
	b=JtfHFxwsBorPL1DuTmZoZ05J9ZJ7Wxmhk75bYECW4cT0PGBiWw8z+UbKhTgILm2XlU39Hn
	8oQSyR4YhXBITbZpLZxhP6pL4Rc0BlDZMJX74n+s2KBRSozAmjMK7+WzBg8S2AdxW82HYl
	VagwU1kbc3qVPKzSL1uN/fseQftGbl8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-145-5GBpG0Q0Mhu05jEpSJoD_w-1; Mon, 08 Jan 2024 09:15:46 -0500
X-MC-Unique: 5GBpG0Q0Mhu05jEpSJoD_w-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3374e909bf0so1325080f8f.0
        for <linux-serial@vger.kernel.org>; Mon, 08 Jan 2024 06:15:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704723345; x=1705328145;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YxB4hJGUskiSNKv+s1TrmZMXKolMvHe6Ob3/kfn7C0U=;
        b=orgETfPJhphSxFPyKBgO/80klLpxSUMqwxJU/YdRzMG8iLEMHhf1rWNoS6FTnECWN6
         3Llp+s7vEy6LjUj50+pj2GGXlqwV7EZGpi9nxZ3/P0pDB7SiZQxlURFerpX/wCrhZqal
         uUTRo5G9ZUDJAX07iiioDne0jeXoyfNlmFLJ2oLwRlfIEfZzhkoki3D1M5HcfDvMQAra
         qdvKl/aHpI7IZ0J0X2R5DULvcv/r5ePX9KZ9sAfkOvwaSuQ9fUctu1nTTVxYHdW1rmgm
         TUaGre0uCoOCe1zoZPNy+jizryeRFlOWGr/kxcMUnBb7UEscfVmOJJ6fobYutpv6v1rk
         8dtA==
X-Gm-Message-State: AOJu0YxqTzK5z273jbhqIBHFPRPEUYOPnW3hg1P/Gy9KQoL1cVIDx6+Y
	ZMEaqVDPKuKfJMk0hr85HuhnZ7Jz65v9UJ2I/t52mUHZ+sQ4i5x08zn8Mf7EqGWd8NqXneCGZFY
	Q+vqpOMgCrjySC8E4Of17E7bhz9qwP3/7
X-Received: by 2002:a1c:4b10:0:b0:40e:48b5:3349 with SMTP id y16-20020a1c4b10000000b0040e48b53349mr432186wma.25.1704723345536;
        Mon, 08 Jan 2024 06:15:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH6B2nGNQDVdFDm3USpj0QhZ27T8ggPZi0nN4hlsNXsc4GJ1RmAnYI10aMq5+7l7vGing5psw==
X-Received: by 2002:a1c:4b10:0:b0:40e:48b5:3349 with SMTP id y16-20020a1c4b10000000b0040e48b53349mr432170wma.25.1704723344860;
        Mon, 08 Jan 2024 06:15:44 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id v10-20020a05600c470a00b0040d5c58c41dsm11210711wmo.24.2024.01.08.06.15.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 06:15:44 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Lukas Bulwahn <lukas.bulwahn@gmail.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>,
 linux-serial@vger.kernel.org
Cc: linux-fbdev@vger.kernel.org, Helge Deller <deller@gmx.de>, Dmitry
 Torokhov <dmitry.torokhov@gmail.com>, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-m68k@lists.linux-m68k.org, Geert Uytterhoeven
 <geert@linux-m68k.org>, linux-input@vger.kernel.org, Lukas Bulwahn
 <lukas.bulwahn@gmail.com>, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] vt: remove superfluous CONFIG_HW_CONSOLE
In-Reply-To: <20240108134102.601-1-lukas.bulwahn@gmail.com>
References: <20240108134102.601-1-lukas.bulwahn@gmail.com>
Date: Mon, 08 Jan 2024 15:15:43 +0100
Message-ID: <87y1czdi7k.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain

Lukas Bulwahn <lukas.bulwahn@gmail.com> writes:

Hello Lukas,

> The config HW_CONSOLE is always identical to the config VT and is not
> visible in the kernel's build menuconfig. So, CONFIG_HW_CONSOLE is
> redundant.
>
> Replace all references to CONFIG_HW_CONSOLE with CONFIG_VT and remove
> CONFIG_HW_CONSOLE.
>
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---

Makes sense to me.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

