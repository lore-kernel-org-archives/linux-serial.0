Received: from ultrarisc.com (unknown [218.76.62.146])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85FC537475B;
	Fri, 17 Apr 2026 07:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.76.62.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776411166; cv=none; b=MEhaONem7JzAtwZDX0pA3lhUqwkA6XW/W0eJMR7zgXETlAWbgwaq+GOgbMbqAPadeoOnBnjziUrjwBogxPpF0uCTyOrcmcFLXcyLSIho5zmUqkLnhN/eeU8/Mv0c1IJ4UQ7g+i3G6Q4SnUdC9umVq8MaL6ev2D42kMzGISlClxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776411166; c=relaxed/simple;
	bh=aN0rsJ4q1zoaahR2+BdQHCBQHbLtaeNxlxoCu0kF838=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=SnZMeILAozd4w1pkU4Oc9NjbSqNByFmjUVOel0Z83CF3C8ebzAmGxywpT4p/iAUpccX2fL2PhZJtzIbcJsW5b31ZcwpCdn6T3KfojY59Y5ggVB1BS6uBkYUHN0Oe2yOAA0sE6ETXMLqa+CRuDFokg6qzW7KMb0yLftwc5E/x1MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultrarisc.com; spf=pass smtp.mailfrom=ultrarisc.com; dkim=pass (1024-bit key) header.d=ultrarisc.com header.i=@ultrarisc.com header.b=moc7a95j; arc=none smtp.client-ip=218.76.62.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ultrarisc.com header.i=@ultrarisc.com header.b="moc7a95j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ultrarisc.com; s=dkim; h=Received:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:
	References:Date:Message-Id; bh=gmUV+DodizzV2u9yaPhetrXhfBThW2qF7
	dbOjOhNN/U=; b=moc7a95jcKXvNdMeqN/HsxkRWZtNpFZbfATEPuOKBEruWTJnv
	fvaJ9Se+9HUY5FVHtTWziySwri9zQLywhPTPYsoWw9vmY2OJTSuZ1t2vgYEsGF1T
	6LmGWBNRtvRh95NJbAmGaazMLKWpR1NCam/8nxFR6PQJSu2JCkQxIqCfnw=
Received: from [127.0.0.1] (unknown [192.168.100.1])
	by localhost.localdomain (Coremail) with SMTP id AQAAfwDXEEIv4uFpAk0CAA--.1242S2;
	Fri, 17 Apr 2026 15:33:03 +0800 (CST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 2/2] riscv: ultrarisc: 8250_dw: support DP1000 uart
From: Jia Wang <wangjia@ultrarisc.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: wangjia@ultrarisc.com, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-serial@vger.kernel.org, linux-riscv@lists.infradead.org, 
 devicetree@vger.kernel.org, Zhang Xincheng <zhangxincheng@ultrarisc.com>
In-Reply-To: <abfrDBeJrValJR9a@ashevche-desk.local>
References: <20260316-ultrarisc-serial-v2-0-6ab3e7fa891c@ultrarisc.com>
 <20260316-ultrarisc-serial-v2-2-6ab3e7fa891c@ultrarisc.com>
 <abfrDBeJrValJR9a@ashevche-desk.local>
Date: Fri, 17 Apr 2026 15:32:17 +0800
Message-Id: <177641113786.3193169.8990532982066985425.b4-reply@b4>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776411138; l=1182;
 i=wangjia@ultrarisc.com; s=20260309; h=from:subject:message-id;
 bh=aN0rsJ4q1zoaahR2+BdQHCBQHbLtaeNxlxoCu0kF838=;
 b=B4bHvKk8PNqvwjIq+0ZMbJsa8wFgeiPY8fRDGOjEiLRPApBTQxvvWTiA6uBlHe7boCo8uJkh0
 rhTDJoGZtWkB2gbU/A0VozITHxqPCRt4MmUBSfMmSvnTzGHwhmro4MQ
X-Developer-Key: i=wangjia@ultrarisc.com; a=ed25519;
 pk=XvYkrelqJIIzobY7j+nIg8rsfv5kzaOzuc1UPhd087U=
X-CM-TRANSID:AQAAfwDXEEIv4uFpAk0CAA--.1242S2
X-Coremail-Antispam: 1UD129KBjvdXoWrZFy5Ary5CF1rKryfXrykAFb_yoWkGwb_ur
	yFkryqvaykWrsxtw45CFW3JrWYka10qryDGrW8Xr9rK348AayDGw1q9ryav3WfX347tF9F
	vr98uFy3Gana9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUUUUUUU
X-CM-SenderInfo: pzdqwylld63zxwud2x1vfou0bp/1tbiAQAAEWnhrj0AGQAAsS

On 2026-03-16 13:35 +0200, Andy Shevchenko wrote:
> On Mon, Mar 16, 2026 at 02:33:23PM +0800, Jia Wang via B4 Relay wrote:
> 
> > The UART of DP1000 does not support automatic detection of
> > buffer size. skip_autocfg needs to be set to true
> 
> Missed period at the end.
> 

Thanks, I will fix the missing period.

> 
> ...
> 
> > +#define DW_UART_QUIRK_FIXED_TYPE	BIT(6)
> 
> Seems unrequired.
> 
> But to make sure, can you elaborate what's going on here?
> What is the reads from UCV and CPR registers?
>

Apologies for the delayed response.

Our DW UART implementation on DP1000 does not provide the CPR/UCV capability
registers, and reads from both registers always return 0. As a result, the
autodetection logic in 8250_dw cannot obtain meaningful capability
information.

To handle this, the current approach is to skip autodetection and rely on
fixed configuration via a quirk.

If there is a preferred or more appropriate way to support DW UART instances
without CPR/UCV, I would be happy to adjust the implementation based on your
suggestions.
 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
>

Best Regards,
Jia Wang 


