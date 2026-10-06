Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BDC43BED1E
	for <linux-serial@vger.kernel.org>; Tue,  6 Oct 2026 11:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791286375; cv=none; b=HMOy+83InWDxt6q27OraQ6jAMVKSd21rHUiA6U3/czJT5qK1047ETPg4mh6NTcD8tD2jH3E/QKTXx0xu9pBFj/p1stUbLDx0MdijzUM/2NTY5BKegHzRCOX+C8jXeF0fvIOg5dE/AVDaxK9LkSDEK8nd1ldvbRf4f5bQFfDtgHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791286375; c=relaxed/simple;
	bh=rJVQWVlBRPTsSgWg/9d5PnkDp77p5gzV4IdCIE71rko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DDyWDiWoWfLRRnOyzx9+HRxKnxOCgAqmE25yKOjA0kYP8oeESPvCwELsOyFnpUdwT7D3cghSOqAPX7ENXS7qANkFmd4nmAS5ur8kQ9+I18MSMAjXxLLUH3XlEbP2HKifytxmcxPOnxgpROKNxCFWhVq6NB6IzlYdSsPEJWZodR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UnmMhD3c; arc=none smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UnmMhD3c"
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-14129667240so276892c88.1
        for <linux-serial@vger.kernel.org>; Tue, 06 Oct 2026 04:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791286373; x=1791891173; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rJVQWVlBRPTsSgWg/9d5PnkDp77p5gzV4IdCIE71rko=;
        b=UnmMhD3c/DemDsW1kzUmTLCcHAhjLksBfrH49KWFTJRNAZV+0RmfqE7UDK3BYdKyPi
         TC30z8PS2AUSkcTV2FSnuFL0TRJa+Rl691xmJtEeAAjZMFhfKS9s9nNpUrwATIr5NIaF
         2edlrETUFRb1hb7iTkttTjS0xClllwb1GYCvt3kKWZawfGg7fptZ+/bnUCuX9BIE0/7l
         N6fImMW0Jf5gsAm7gSx4gaxTVCK9hL/bNTCF+oxcLTL4b8vLmdwcK3HC9pWZl9+1tR84
         137hB0uLjtFewk0LCubpHfbfkAPK4wJG4TwRr5/7MKi9e5tRfC7V1aXGsJ5XoXwNJKtP
         vCBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791286373; x=1791891173;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rJVQWVlBRPTsSgWg/9d5PnkDp77p5gzV4IdCIE71rko=;
        b=LKpZLomknR1e8tMyQfExLXDMVcaFDoKJ53h+a1E5v+whftRM3f6EKC3ZCbKVZl/pFP
         XGn+T7bELA4x1JJkoK8knASlA/xsu0ACTSvvMjSDOMrqaG6U78D90Mv7epGvkCMb6ERg
         z+WGcF0BiDorglyQW/yah9CBGte6mDqjd3khnJqkpuJ0sYdhLWDpIEv2K54la1NAUMln
         lb4FPEe9Nh5dLJekv2J/IW5PQCZYg51NouQ0MCBLi4h+SpJoR/9w7IIXUckkgrJXc+cP
         Z6ZHWUDF67RuhsEqe8q0rI7+j1YaBgr2H9Z30mOOEHdl4Kxu/LYgLtKFdpzv6xtpeKXh
         mz+w==
X-Gm-Message-State: AFuF++kPek1jY+FT1dU9dUBe8LeDrN3Lw2W/alS4t1YMM9RJ+z6iyzCb
	TvM8h7silTuxKcSRZcMr80kcB75lN/4QsRBESd0p+/tE2F9PV8Y+0TRNtJub8tcxBH8=
X-Gm-Gg: AYBFou1wlKxE75uZj4cUt9EwXv0Ui5cwlDZX/cvUCbVMpcQk7nbvDNAFkZdOmaPgjdI
	E6ZnZX3fDFUZpgMQ6qKakfV0HQyPIOu4OXM1jHLgx4DVEM/a4zrhJeB24jB0GNKI3OERYOMfnSp
	ssB3NRylPV9JLNP0LIRkYQysMqSm+CWDkXGZ4nUIGt5yGZKrNY56tSCqVpqdFK/w6yJIc5fZH59
	YcASC+JUnMfrZ8/icoT+N03mS+QOW1zKxRdIIyT8igOq+Z+4RZUqha7736MnCvw9atKsdQ3XRrr
	vfBSgsoyCawLHZOrpclP5pzK5ploND60KFUPVkyd/dbIorsLeG+W7Tz3PwxWooITgr+ExYiYkoW
	PdSEvxvrFxNU0oUq/q41q+jtXo/Ib/6GKf1KhRJexgJzk90su+uFC1KltMrGWAjxokt9UJQe+E7
	/CNtCvwVyk+gJ1xnaFuWVmi7E0O0qnI63RSc57YHx/tXUReFNuh/dNxx0nscMDHrEFtppDPACyD
	EMWJjVI4v+OsavH/BWtyJqdM0mlarI8TaX0kmGn8rk/p9f9lIveYcLMMeBjEydcJr6upcepMvWT
	7910dLKPzhO//Eir
X-Received: by 2002:a05:7022:eb47:10b0:151:2e62:fe4b with SMTP id a92af1059eb24-15eca269596mr1503491c88.23.1791286373021;
        Tue, 06 Oct 2026 04:32:53 -0700 (PDT)
Received: from MaquinaLab.. ([179.179.237.181])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-160677a08fcsm241105c88.3.2026.10.06.04.32.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 04:32:52 -0700 (PDT)
From: Vinicius Pedrosa <vinicius.eduardo.pedrosa@gmail.com>
To: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: linux-serial@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-sunxi@lists.linux.dev,
	Enzo Adriano <enzo.adriano.code@gmail.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/3] serial: 8250_dw: Keep the BUSY-safe divisor hook when DLF is present
Date: Tue,  6 Oct 2026 08:32:35 -0300
Message-ID: <20261006113235.86144-1-vinicius.eduardo.pedrosa@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <e9538164-3565-a702-c26b-bdc0b8cb1c6c@linux.intel.com>
References: <20261005172538.398522-1-vinicius.eduardo.pedrosa@gmail.com> <20261005172538.398522-2-vinicius.eduardo.pedrosa@gmail.com> <e9538164-3565-a702-c26b-bdc0b8cb1c6c@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Ilpo,

On Tue, 6 Oct 2026, Ilpo Järvinen wrote:
> It might be better to add __dw8250_set_divisor() to dwlib to keep the DLF
> setting code in one place.

[...]

> It might be safer approach to NULL check .set_divisor in dwlib before
> setting it as ordering requirements like this are easy to miss.

Agreed on both, I'll do it that way in v2. I reran patch 1 on its own
after the change and the console still survives the termios stress loop.

Thanks,
Vinicius
