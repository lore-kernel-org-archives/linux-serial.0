Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21D821CA0D
	for <linux-serial@vger.kernel.org>; Wed, 26 Nov 2025 13:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764162746; cv=none; b=YWhFvMfyc9nfC/LKeGEbuVrUBWfln7W2b/z0eI49+ZeWkkgAhMMXCYLwl7K/1BiBO0khc5bVOaSeeyIOQ6tyJ6Eq4lce4nlVJOyxygsFsytlzxakbZHHBIBsLFRtWHnJIuXIvT39f30ihSgxZM+rfq6pF832KX1vPQovkBwFc8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764162746; c=relaxed/simple;
	bh=Rv4FJgnug7MT27zvDvDPacsYboDa76Y1pxEBVDzA/WM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=isqX7zU/TGTu3RsDY7+txfEwnYPAFfucvzf1wVSW9QN+fkpKCUvZYUtW9LXy3debUUxIFTblo+UM1t8x9LBpBmfzJSTh9OvNcALwJLKBVia7+3GKYsD7dnskoK0Gxf2w9LJji6uw4KMhQrra/rxKtCqtFJ2H4ia2/ecUA6lx0u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Iwk85+da; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Iwk85+da"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-477b5e0323bso4982055e9.0
        for <linux-serial@vger.kernel.org>; Wed, 26 Nov 2025 05:12:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1764162743; x=1764767543; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=azsrhZgWyYhx6NRpCHGgrx0NKRpo3MJZPtnrDvh+H7E=;
        b=Iwk85+daZY41KQ0FQQPhkcQtKlJwzksbrh9oItXlzCSGI7qTVAt0ffJL88guSUXAG1
         1cn/OHbdU5nl9FhUWe0IeoyPW6k6ssBnauynWrd+iQeBJAwEHJBifR6N+3gXWRFEcRPl
         LOY9012DbHIg5fnWXvWZwPPlpv91DkLz2+8YjQcJnJV43UGo3i0Lq3LvaUSFQyxtXbMm
         RYxh9206Usb/Ld/2MZWUEfxUVmW2cdRW1gi2kLkyqmeICurQL/eZITgOQf4RJSlK9jMG
         ibh17xRrQ3E3d/Zy7f1V2h0eUh1dlEcQHYSHPbQ5SU2f5jzep2giIIdf49CUYuNsAHtY
         K7dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764162743; x=1764767543;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=azsrhZgWyYhx6NRpCHGgrx0NKRpo3MJZPtnrDvh+H7E=;
        b=YSYyagJVcn0vZxefVb5//MAql6kf4IdYuJ1NeW1xej8RVakd6WpDLWYwR9VogBrdUY
         eLBvN9ZgYWhspedF2uoOT5NwQIlzNlfmlF7pSUDJlxpb2X7ZZy4k8vcvdIPplFswTdLG
         eSWhk4EcfY/TQr6MXSDeNcqaUlYjsdpY716t1+9zFRMRyLAny4lKQCesKY9iS7I7VACK
         w5A7Sk51Q+3LqKhfBwaOmKp84OJOx1QjbMi/NXmW7p4AvF1k4T2J0droyb8yzaD+HFDZ
         wQo4qDspFgx690FiihGUth33CGLrYDvwBw400RHehHVCz4PBUES9w0KaLkt4lJgBRoiC
         jpgg==
X-Forwarded-Encrypted: i=1; AJvYcCW0TQjRxmsGevRthpEhbTjs5ufFWYVwwy/EjzyhVtyWaNuF1QQYiROphdoIfpaMAsb/zu44l16zBT8ipyI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2GoL4R46yot6kARDO6wpq9FpAbYoBj3hqMtxoh8iERvZSxAjH
	rIsMqsXcNHBr/OvWjZIKCR5pB7sqZNZlsKxiqDe/0EVvtsFBVZnIb+eFQLOF97lQwZQ=
X-Gm-Gg: ASbGnct6mh+RGfb834E+8UeGXSu+k2+Tx5w7xOukyilZyfFfzlA2TO9er1mFl8AsI0C
	cayBB0AyImBIqUox92XE57xmZprNXR1XPMAc6V8F7Pq2/hyyOpCOpD5Ik0zbhNV6a9QOiKXiZfQ
	JJE4F4znPefGfCzFcxwcz1vG/WWhW5SnwZ2J6fupuEPHpQHqzKvQq8kSUsvVH8ly/sT8b4lbmW8
	sw7/cKXouGe2DQroczphhRuZXzjg0LVzZudEuJ1MleBXqsmtk13PPvVEr+ECR4fw1HvzQMqlKzj
	wXRhTPVi9sM0IxqeB6KMx9Bj06AR5qFOJFrHsNIOHjHYCRkpphLnGcnn2KGllDxOcSQJD0wIEv4
	tQld5hWn6c25il34YLDqBhJ44gpom4OVhTNHG8GvKv9fVe/wH+Q+BBOwANHdXEA0Zkns14HFWuj
	mQi8pK74n5vbBuFw==
X-Google-Smtp-Source: AGHT+IFEYv6UMcwGn4taVzPLuUnJBcIZRl4prj8V/wWkXOqPExh69hNsmDyiZhSbwf/siv21g/oC8w==
X-Received: by 2002:a05:600c:1e89:b0:477:a1bb:c58e with SMTP id 5b1f17b1804b1-477c04cfddcmr213170355e9.7.1764162743079;
        Wed, 26 Nov 2025 05:12:23 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7f34fe8sm40473140f8f.15.2025.11.26.05.12.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 05:12:22 -0800 (PST)
Date: Wed, 26 Nov 2025 14:12:19 +0100
From: Petr Mladek <pmladek@suse.com>
To: Marcos Paulo de Souza <mpdesouza@suse.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Jason Wessel <jason.wessel@windriver.com>,
	Daniel Thompson <danielt@kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	kgdb-bugreport@lists.sourceforge.net, linux-um@lists.infradead.org
Subject: Re: [PATCH v2 1/4] drivers: serial: kgdboc: Drop checks for
 CON_ENABLED and CON_BOOT
Message-ID: <aSb8s_N4Pc0yTk9f@pathway.suse.cz>
References: <20251121-printk-cleanup-part2-v2-0-57b8b78647f4@suse.com>
 <20251121-printk-cleanup-part2-v2-1-57b8b78647f4@suse.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251121-printk-cleanup-part2-v2-1-57b8b78647f4@suse.com>

On Fri 2025-11-21 15:50:33, Marcos Paulo de Souza wrote:
> The original code tried to find a console that has CON_BOOT _or_
> CON_ENABLED flag set. The flag CON_ENABLED is set to all registered
> consoles, so in this case this check is always true, even for the
> CON_BOOT consoles.
> 
> The initial intent of the kgdboc_earlycon_init was to get a console
> early (CON_BOOT) or later on in the process (CON_ENABLED). The
> code was using for_each_console macro, meaning that all console structs
> were previously registered on the printk() machinery. At this point,
> any console found on for_each_console is safe for kgdboc_earlycon_init
> to use.
> 
> Dropping the check makes the code cleaner, and avoids further confusion
> by future readers of the code.
> 
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>

I agree that the check is superfluous and can be removed:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
