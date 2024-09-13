Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997C45FBBA
	for <linux-serial@vger.kernel.org>; Fri, 13 Sep 2024 15:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726240717; cv=none; b=tRDesTM7CKo68ry6rVE/LT7p03gGIx9Evs5UN7g4aXPAySHlkQKpOpHnJHRbmw49ZcuLSPzDVFzESHq3G4KdXhgD83f2nHM5Jh0VGVaJkzu4garI4J/HxECPx1wF4oNcNSKEY0+JIxaHIo4kgQ7mamyX5VwkekJDV9VR9l4tvHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726240717; c=relaxed/simple;
	bh=ofnY92BfWw/2QKucsnWYXMioD0wxXc4P7xS9iiziCDc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SBd4ZxoFBLwPUFG3KhF9cAXTotvjkKwReH9gPLr0kDeDEiFCxZxAMWiz6gYSoPyMObxlpDZpU/nfOD1FGlYdVSXYNm7YE6QdQTYCVdhIpmmeUXpVzF5DdIuWqNzm0ALc8HRMi+NdtYZjvP1FnLeltRwte5bGi8mMSuDzUSF2pCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Tq6rXw6A; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Tq6rXw6A"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-53653682246so2859599e87.1
        for <linux-serial@vger.kernel.org>; Fri, 13 Sep 2024 08:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1726240714; x=1726845514; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=erENPJZ+5RHEuuZ4KGIlZ8duewTsHT/YiKKhan9XJ38=;
        b=Tq6rXw6ARLaST9Fl0oZQCoJFyd+rkbTnEGL8IoSzM5X86XOB29AOt3lXQu8NwfgBbL
         rBGsi0102AxekSeNA1yJ7xO8U5F6MERbLsXHxADedfHrLJKevwUDx1o1Nz2fxHwi7KRH
         ij3DBML1Mn1U4Aj5U1fstmpVY15j6N+0klkFzwVi3TTUaFo4v10IXvxeP6bK3Gf+UbST
         KXX7U9RmnHAabYfHZaYuqW46GCYQ5LNZIK5eReGrqCyWoihoR6QBGxTGs0rJzR56aL1d
         dTw5khAGrSHR1SzKZJaRfUrqTcBMnO9m6fISWHyB2P/Hbf0WRmSnqLMtLH1nuN9DCu6y
         Sjug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726240714; x=1726845514;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=erENPJZ+5RHEuuZ4KGIlZ8duewTsHT/YiKKhan9XJ38=;
        b=t73s0/Sl1gf1YxkzfCv12QobXFXSLWB4bGYhdK7dbcTZoXGt/YOanCHmB7MrsX05MM
         ShoK5Q/p3URhABHj09Hw+pWkiQghLzkSihXKiNTU5wt9aX/hJwiHDMTe3t30xXLptJBq
         k3Z28WRspJYPEms41LfxK5uK7+7YyB/N9rlAKDH6EPOXqU1JU0QQ0px4j14dQpyG4hve
         7uVrEAcrrcZJVOo9qEVHd+LE6raOLN/GVQf+4t9jlpjNjXHqyDNDmJ4SqjcpaRSicpu2
         p8Q1UdGWf+QpRkwjLKD3dLzBDP2ZAJy6cI6crVuw9kY652/AZOFE7wMHffYkWIYM9YbQ
         FMTw==
X-Gm-Message-State: AOJu0YzCpqLgxIucamvUM5F1gtT5l/h/zIzFaCW1Vgw2JyNqX/A42bZo
	T7BuZ+b41oCV3ft08TP4X0XcvtVH9g7HJagJf+Sk6lklPk8Jq0AqRlX3tCA7jxo=
X-Google-Smtp-Source: AGHT+IG1lNEaUhJt5g/N8BT5UA8mh5OVuIjbuvsCvrvD8rUXsejxN4URMYPbo267vlp/W/YFHYcWBQ==
X-Received: by 2002:ac2:5683:0:b0:536:7cc4:1313 with SMTP id 2adb3069b0e04-5367cc416f8mr4231936e87.19.1726240713432;
        Fri, 13 Sep 2024 08:18:33 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25c74068sm876024566b.131.2024.09.13.08.18.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 08:18:33 -0700 (PDT)
Date: Fri, 13 Sep 2024 17:18:31 +0200
From: Petr Mladek <pmladek@suse.com>
To: Raul E Rangel <rrangel@chromium.org>
Cc: linux-serial@vger.kernel.org, rafael.j.wysocki@intel.com,
	ribalda@chromium.org, Adrian Ratiu <adrian.ratiu@collabora.com>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Ingo Molnar <mingo@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Xiongwei Song <xiongwei.song@windriver.com>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] Documentation: kernel-parameters: Add uartclk to
 console=uart
Message-ID: <ZuRXxzjctzwOCTNA@pathway.suse.cz>
References: <20240912173901.3969597-1-rrangel@chromium.org>
 <20240912113616.1.Ic8770cb6e660110359b245808105e5310d3fa528@changeid>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240912113616.1.Ic8770cb6e660110359b245808105e5310d3fa528@changeid>

On Thu 2024-09-12 11:36:19, Raul E Rangel wrote:
> The console=uartXXXXX parameter is just an alias for earlycon=uartXXXX.
> This means it also accepts the uartclk parameter.
> 
> Signed-off-by: Raul E Rangel <rrangel@chromium.org>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
