Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BFEA35502E
	for <linux-serial@vger.kernel.org>; Thu, 15 Jan 2026 10:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768472407; cv=none; b=SAkonjE77V7YOYEaaWjPtp01yVUsGO63K3WUjmpa6nx7UMfwRwxfL2TlMnrqiJnkYKZqWNFNuJOq8LtK+MMfL/Znp68XoUP97WkZljvJ83WH+3B0obw9LzfRwS8MbdO6PnfboT9XflMGN5iumwPcXC5u+KHEm/ljjh25PstoBts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768472407; c=relaxed/simple;
	bh=mwoYamMX+C4LOG3qk2bHenfle0rpDp5AHcC+7a69BvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O5gTMo30B/qOJ3mIcMH2RHYl/ymQh15wTwabFEPQkrni/vEe4hLamoB7qDVeUY4odCKlLdI3utnm5UR5dt8WCHCJP/m2IJocK+Jelcw7SEKXdXZMqQ+/+TbG8fVnqNzvH32VK+YBxpOXDlm8CnhvtHYVbMMzs9AKqxuslyhFOrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=POOTpyf2; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="POOTpyf2"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-4327555464cso386650f8f.1
        for <linux-serial@vger.kernel.org>; Thu, 15 Jan 2026 02:20:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1768472404; x=1769077204; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Blw9ol92Adxv0ebGIyoRpKSiGhl8JOSAW1An3S4C+Hw=;
        b=POOTpyf2E8LQhfgcWoVnmGcwTv9cjx7t9nOoTBipWSoduSQDl2DtDEX5jXOGnGpHug
         /vEr3bRycNEF9KDphpixHf8pjEFI6ZYVF8QXfo2/p/K4igsaUNuTuTAXBRonG0hkEw3y
         zjPwl0nXJwH8C//iA7KkpuUuefoo6u/aeL1FN/9mZaiJHPN2asi8Bnj10GOb/8yZxglx
         Mo+8uDhw7wpooLcni7m/NfXXLd+GFxPn8auytjzx3hOMHRSxcVVJJnn1AEDU7nQEhSnb
         pM9pvUeivyUXXZdwnM+CoENtMt4wf2UWt/Iei7G0hU36UOd88kWLwxHkhYgi5FI9j7DC
         cpzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768472404; x=1769077204;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Blw9ol92Adxv0ebGIyoRpKSiGhl8JOSAW1An3S4C+Hw=;
        b=qsB7j48wF36N8hM3eO44VWa3sYoYhD1XwXEpxayW2nWGwVKKgidnbnzMCoYgV3hHA3
         y9rjYZendS9/bAMPQ6xm6ETgadZ27QlTLnozOCo8MP9R7dW/SOMSYaN7btksyexNwje4
         dECjMaFLZRugSDYTPNO5iH9csWd7zsY25FuCxeg2FBhAH1b8TGAHtvFYQzlX5JR6Q0eL
         5pR+LMEQw1MJB8FtWHAl1DUzbb9aP483oAWnWfCmPTv5KdrfD0rkL/IQS4dvkjwYkfKQ
         Sz1LWCvITJ3PG0/GZCP9hY50SqgFBx/IRNy77EmUhkkzEeeH3o2IEFGXW1uVV4BYz/qU
         EMfA==
X-Forwarded-Encrypted: i=1; AJvYcCXQ8eiWe2EsZOGzmBIUU2PmRc3S/Xh+wF+1+U0zlytEhbpIc2WsGflEwFyylJ07Ga6BkuWgn1FSp9l6sbA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzES37KDJgQEogrdhXAA4dBhz8psZeeum/NgCmxjGEcfRXJhDne
	3++2h3W6PpKZjN7wA/zPSqQFt063eftFVKPH5UvqwUv56Z7jCFPVNSSY1bUx8MlwhYc=
X-Gm-Gg: AY/fxX7cKzKE9AQBUSYgSziI2BFFW4IoCiwDLTCngn4ug3TLaWSm7XNkl24dMPIUaGD
	cCggUDty9C+9IBXrMrE262xYVk2/WgfJhbH6zH0s77mtPRHF/+NNuXULVBNnEqTuRQ32JI3KRYE
	biOonuqx7ey+YmDZBtY14gj9CEZvjtsDdE58EiE9h0h1SHv5fpi2B0KCOYgWCPnw7ITimkT7jhs
	XnOiWV8ZuVjXc0J0KguuvaaNVpKZRx0VbIH0lC9KdbYULzN5Dz7iPPefxZxAb21AKKrBb7ZDtSC
	wT56XC3oWbr/BqbdsH+uIQnZlDr70Nz4QGgu6Jy22TSg+CE88S7op4BF7d9dvCzfWfLHg0jjPr/
	pEqRRNay+0W91ysTAQ1+jPnBlTdpzGEhnQdSX6ffbTgsyxxAvNjplHCspk6bYWC3T2965mcfy+1
	fy10SbjjK2DbA5Lg==
X-Received: by 2002:a5d:6b41:0:b0:432:a9db:f99d with SMTP id ffacd0b85a97d-4342c535db3mr5505744f8f.36.1768472403629;
        Thu, 15 Jan 2026 02:20:03 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-434af653632sm5139931f8f.11.2026.01.15.02.20.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 02:20:02 -0800 (PST)
Date: Thu, 15 Jan 2026 11:20:00 +0100
From: Petr Mladek <pmladek@suse.com>
To: Marcos Paulo de Souza <mpdesouza@suse.com>
Cc: Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jason Wessel <jason.wessel@windriver.com>,
	Daniel Thompson <danielt@kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jiri Slaby <jirislaby@kernel.org>, Breno Leitao <leitao@debian.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Andreas Larsson <andreas@gaisler.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jacky Huang <ychuang3@nuvoton.com>,
	Shan-Chun Hung <schung@nuvoton.com>,
	Laurentiu Tudor <laurentiu.tudor@nxp.com>,
	linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
	kgdb-bugreport@lists.sourceforge.net, linux-serial@vger.kernel.org,
	netdev@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
	linux-hardening@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	sparclinux@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 08/19] debug: debug_core: Migrate to
 register_console_force helper
Message-ID: <aWi_UJcrphO9Esxw@pathway.suse.cz>
References: <20251227-printk-cleanup-part3-v1-0-21a291bcf197@suse.com>
 <20251227-printk-cleanup-part3-v1-8-21a291bcf197@suse.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251227-printk-cleanup-part3-v1-8-21a291bcf197@suse.com>

On Sat 2025-12-27 09:16:15, Marcos Paulo de Souza wrote:
> The register_console_force function was introduced to register consoles
> even on the presence of default consoles, replacing the CON_ENABLE flag
> that was forcing the same behavior.
> 
> No functional changes.
> 
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>

LGTM, nice cleanup!

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
