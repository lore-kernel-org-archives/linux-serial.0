Received: from ultrarisc.com (unknown [218.76.62.146])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFF4833EAF9;
	Wed, 22 Apr 2026 09:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.76.62.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776851510; cv=none; b=aJlQsy/phvs5nCul2TpWyYV7k8SvNZNWAOJBE4QHVxnof2x6ZfI1xL9eljyb+5s5RvopRuukffcazmw3D5dW+gOZgDM0nJTcTTD0GIXZiA/4HP0eKMLsM1NBcjo/gvZ+bsj4sxv8oCaTxnDrCFeUDj/d9MCsCMtkKBVImWphtmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776851510; c=relaxed/simple;
	bh=PP6AHgmpH1XCDhT3rzVmkbEs9J97prw7sKGs06DkRFY=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=eae0ODQDWGTo7V8qudLqhYFFSaHYyHIUaOnkuxc2zRPo6IjpaB4VGTeHc5Q48d5a9zq8MjeIHHxGLEqcBqhAMYm2subXDKaDZA+AbSFdQqNUDPBmTZtSVGGGOM7uXPBUC98VLsghntc+cPkQ0FvElz/uwnUAhrjxPrJ/wrlHYL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultrarisc.com; spf=pass smtp.mailfrom=ultrarisc.com; dkim=pass (1024-bit key) header.d=ultrarisc.com header.i=@ultrarisc.com header.b=Spj/0Nuc; arc=none smtp.client-ip=218.76.62.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ultrarisc.com header.i=@ultrarisc.com header.b="Spj/0Nuc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ultrarisc.com; s=dkim; h=Received:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:
	References:Date:Message-Id; bh=EtRd6D/CF3RVrZvVz0/gBH672srYMoqzc
	SaYXBbAJkg=; b=Spj/0Nucf/j0sVVZfIeJZ3xs3PIrYUzncceQdrl5hBQ+B9xBB
	Po9SDW+Fg8HEjsOGWaro4fEEI1f0zVqsEmaWdimKBX3hzF2cehSc0uvYH2CFIRlE
	P8VhRjZHUkRg9fvh56XisMJnfmiGAVj9CFIRvWmBaRt2/wmOMqdgy8zuwo=
Received: from [127.0.0.1] (unknown [192.168.100.1])
	by localhost.localdomain (Coremail) with SMTP id AQAAfwAnYUJUmuhptqQCAA--.1546S2;
	Wed, 22 Apr 2026 17:52:21 +0800 (CST)
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
In-Reply-To: <aeiYLLXTprlzmcpF@ashevche-desk.local>
References: <20260421-ultrarisc-serial-v3-0-3d7f09c2420e@ultrarisc.com>
 <20260421-ultrarisc-serial-v3-2-3d7f09c2420e@ultrarisc.com>
 <979c9543-3ea0-25de-f97b-9c6d2fa3ac61@linux.intel.com>
 <177681947637.2697678.10937675549830278979.b4-reply@b4>
 <aeiKsv3bFPJ94InI@ashevche-desk.local>
 <aeiK-350Uozq3pVa@ashevche-desk.local>
 <177685078199.768471.14774992461649696859.b4-reply@b4>
 <aeiYLLXTprlzmcpF@ashevche-desk.local>
Date: Wed, 22 Apr 2026 17:51:36 +0800
Message-Id: <177685149611.768471.11403282263671013638.b4-reply@b4>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776851496; l=1505;
 i=wangjia@ultrarisc.com; s=20260309; h=from:subject:message-id;
 bh=PP6AHgmpH1XCDhT3rzVmkbEs9J97prw7sKGs06DkRFY=;
 b=0TzUGSw04gbT4BOOvnfyRG1x4X1EQrhcNfVgdZaR5WDLTaZB9xepnsQv0eOTTtyZt+Y7wJhXt
 RC/ltJox1UuB9PXTESDOnFrO7wFyX1XpHKBJ/TKVTvl95oaQiK6u/li
X-Developer-Key: i=wangjia@ultrarisc.com; a=ed25519;
 pk=XvYkrelqJIIzobY7j+nIg8rsfv5kzaOzuc1UPhd087U=
X-CM-TRANSID:AQAAfwAnYUJUmuhptqQCAA--.1546S2
X-Coremail-Antispam: 1UD129KBjvJXoW7CFyxXr1rtw4rAr1rArWDJwb_yoW8GrWUpa
	yrJFW3Ka9rKrnayrnFkF1DAF4Fq3Z3Ka4UXw1qgry7t3Wqyr1YqrWvqrW5uF9rWw15Gw4I
	vw48X3y3W3WUAaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnUUvcSsGvfC2KfnxnUUI43ZEXa7xR_UUUUUUUUU==
X-CM-SenderInfo: pzdqwylld63zxwud2x1vfou0bp/1tbiAQAFEWnoRb4ACQASs0

On 2026-04-22 12:43 +0300, Andy Shevchenko wrote:
> On Wed, Apr 22, 2026 at 05:39:41PM +0800, Jia Wang wrote:
> > On 2026-04-22 11:46 +0300, Andy Shevchenko wrote:
> > > On Wed, Apr 22, 2026 at 11:45:44AM +0300, Andy Shevchenko wrote:
> > > > On Wed, Apr 22, 2026 at 08:57:56AM +0800, Jia Wang wrote:
> 
> ...
> 
> > > > > Just to confirm: since you mentioned that the preparatory patch moving
> > > > > the DW_UART register defines is already in place, I don't need to move
> > > > > them again, correct?
> > > > > 
> > > > > I will update my patch to use the DW_UART_CPR_* macros and
> > > > > FIELD_PREP_CONST() accordingly, and I’m happy to add a separate patch in
> > > > > the next revision to convert the Renesas .cpr_value as well.
> > > > 
> > > > My understanding that you want to send a patch series of 3 patches:
> > > > - moving DW_UART_CPR_* values from C-file to h-file
> > > > - modify existing Renesas case
> > > 
> > > - DT binding for new HW (patch 1 of this series)
> > > 
> > > > - add support for your HW (this patch in updated form)
> > 
> > Yes, I will follow this order and resend the series in v4.
> 
> Thanks, and since Ilpo mentioned, move all DW_UART_* register offsets/bitfields
> to the header file (in patch 1 of a new series).
>

Thanks, got it. I’ll follow this in v4.
 
> > > And I forgot that you have a DT binging one... So 4 patches after all.
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
> 

Regards,
Jia Wang


