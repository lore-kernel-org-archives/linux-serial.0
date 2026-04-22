Received: from ultrarisc.com (unknown [218.76.62.146])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A9F12D7BF;
	Wed, 22 Apr 2026 09:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.76.62.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776850820; cv=none; b=WAcsPznnUnAEsu++ZaXfTPi3rJg7o9FZIMT4RXmeb8HGnZCf0pqKEUiIDbyGYahdQb9ne3bmyhwTpEL2d6mbADVvmsmGHRO5iYJMu597egSHYx6Ld+jsB1fwDgosNpWyahClETrbIs5YltQaY7KQsit9Na1iR4mS0j1jFjRZAB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776850820; c=relaxed/simple;
	bh=/sSF/6KnPX46G3W0/83UVoWHCgXMVyaJn54X61E/PdA=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=ACIW4JzF1DAMIFKDHSfGol/cCCQKsfttSWf4Cq/P3RxwF7WV9VEDLM97T01vyjy7ECNqBHX0S3POFISxvbGTu3REYLBcPydM3S9nlGIJk3ThiHaT901cs8DJQTCKNuVeoQdBNKpiMfCtBL7KPQRdRz1Vlx/9BqVP0sElsbXaErM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultrarisc.com; spf=none smtp.mailfrom=ultrarisc.com; dkim=pass (1024-bit key) header.d=ultrarisc.com header.i=@ultrarisc.com header.b=KKk7Nyhq; arc=none smtp.client-ip=218.76.62.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ultrarisc.com header.i=@ultrarisc.com header.b="KKk7Nyhq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ultrarisc.com; s=dkim; h=Received:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:
	References:Date:Message-Id; bh=dmP7ZaHB64U7ys4IfwlhMNPCsnVDYMS74
	p08LUPcoio=; b=KKk7NyhqNjknXtzgoAC3hCikoq5w1lT7q2PD0DfZYyAHcpZe1
	lqo3inwFanPlb8S6AUJ3gVoB5b7Ooq4cDLQ5vcr1PtOarEZk87lOwc6Nh+nAa4W+
	HOSS15aNC4Xbx2T/FERNjPOu122Zkw3WksRQ6iFgjqtYLnteEyz9hW9w9Q=
Received: from [127.0.0.1] (unknown [192.168.100.1])
	by localhost.localdomain (Coremail) with SMTP id AQAAfwA3cUKKl+hpkqQCAA--.1625S2;
	Wed, 22 Apr 2026 17:40:27 +0800 (CST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 2/2] serial: 8250_dw: Use a fixed CPR value for
 UltraRISC DP1000 UART
From: Jia Wang <wangjia@ultrarisc.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jia Wang <wangjia@ultrarisc.com>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
 linux-serial <linux-serial@vger.kernel.org>, 
 linux-riscv@lists.infradead.org, devicetree@vger.kernel.org
In-Reply-To: <aeiK-350Uozq3pVa@ashevche-desk.local>
References: <20260421-ultrarisc-serial-v3-0-3d7f09c2420e@ultrarisc.com>
 <20260421-ultrarisc-serial-v3-2-3d7f09c2420e@ultrarisc.com>
 <979c9543-3ea0-25de-f97b-9c6d2fa3ac61@linux.intel.com>
 <177681947637.2697678.10937675549830278979.b4-reply@b4>
 <aeiKsv3bFPJ94InI@ashevche-desk.local>
 <aeiK-350Uozq3pVa@ashevche-desk.local>
Date: Wed, 22 Apr 2026 17:39:41 +0800
Message-Id: <177685078199.768471.14774992461649696859.b4-reply@b4>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776850782; l=1125;
 i=wangjia@ultrarisc.com; s=20260309; h=from:subject:message-id;
 bh=/sSF/6KnPX46G3W0/83UVoWHCgXMVyaJn54X61E/PdA=;
 b=+p7a/VWJK3ydtMjmUT+oU0zV7nW0LXW4uCDTVsx9FgpNUQMDN7xHWqRV7of9SccuSBUHcZMlO
 yVTLt6YKuolCRIAgsU+/bkJkqGpCxgY+7FvVxzS3uxm/FYp1l/uzGXb
X-Developer-Key: i=wangjia@ultrarisc.com; a=ed25519;
 pk=XvYkrelqJIIzobY7j+nIg8rsfv5kzaOzuc1UPhd087U=
X-CM-TRANSID:AQAAfwA3cUKKl+hpkqQCAA--.1625S2
X-Coremail-Antispam: 1UD129KBjvdXoWrtFyUtw45WFWDKF4kAFWxXrb_yoWDCrgE9F
	WUua9293W8Aa9rX3Z7Aw13uFZ0vay0vr15J3s5XFnFyr1Utr98Wws8Cw13Za4Fyry8KFsx
	Kr4Fgryrtw12kjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUUUUUUU
X-CM-SenderInfo: pzdqwylld63zxwud2x1vfou0bp/1tbiAQAFEWnoRb4ACQALst

On 2026-04-22 11:46 +0300, Andy Shevchenko wrote:
> On Wed, Apr 22, 2026 at 11:45:44AM +0300, Andy Shevchenko wrote:
> > On Wed, Apr 22, 2026 at 08:57:56AM +0800, Jia Wang wrote:
> 
> ...
> 
> > > Just to confirm: since you mentioned that the preparatory patch moving
> > > the DW_UART register defines is already in place, I don't need to move
> > > them again, correct?
> > > 
> > > I will update my patch to use the DW_UART_CPR_* macros and
> > > FIELD_PREP_CONST() accordingly, and I’m happy to add a separate patch in
> > > the next revision to convert the Renesas .cpr_value as well.
> > 
> > My understanding that you want to send a patch series of 3 patches:
> > - moving DW_UART_CPR_* values from C-file to h-file
> > - modify existing Renesas case
> 
> - DT binding for new HW (patch 1 of this series)
> 
> > - add support for your HW (this patch in updated form)
>

Yes, I will follow this order and resend the series in v4.
 
> And I forgot that you have a DT binging one... So 4 patches after all.
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
>

Regards,
Jia Wang 


