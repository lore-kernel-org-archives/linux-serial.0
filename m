Received: from ultrarisc.com (unknown [218.76.62.146])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B628037FF67;
	Mon, 20 Apr 2026 05:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.76.62.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776662906; cv=none; b=O8h1+rFqOZkbpQtCUKpxILe23ToBbM6fOgAC7qnMKFihhOWuvYBYWeuIcCVQG7rErjX0PWX5YpPhb2WrtVo7uT6839npDcVftsEiGLLy5+c04aFgik8ZoKhYXZNdJt5hgbjiVR3i174bFJzy82QlT0cfs/xZubuwhxVjlI6Ly68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776662906; c=relaxed/simple;
	bh=P9/Oiu3kQIkJb/NpuqfPAVmLxhp49AvaTmRzYpwIzRw=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=mZFgkVylg04Z4bCegXNi41B6C9+tzhCxjLCWFWzgc6I/+IP+/NxIfDJ0YjvZ9vTNFbWqnCip+6IeLV7CqM7DFGhhr5hty6cfh7XJLZnUxIpl5gB4rvT9RsZhPo++/aXK+4O1bNSSRySEXGj56GUnrpvK+MHhpPQcKIyPa33BY5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultrarisc.com; spf=pass smtp.mailfrom=ultrarisc.com; dkim=pass (1024-bit key) header.d=ultrarisc.com header.i=@ultrarisc.com header.b=qVLtq1Wk; arc=none smtp.client-ip=218.76.62.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ultrarisc.com header.i=@ultrarisc.com header.b="qVLtq1Wk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ultrarisc.com; s=dkim; h=Received:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:
	References:Date:Message-Id; bh=yD0tFhjGk4Iefxd2PfqrqTCyGwJWD+2Ym
	vsrWstWyM0=; b=qVLtq1WkugPR87AefPywq8IdU5NYeaG/ll+NdwaZVr3iLU565
	yoZAhQXWgfuBhvf4cJyw0VTaruH/R2OoG8k4NWyMSxq+UVCiltO7wwTpMji04dzr
	cegWIz3f27SXZ6GUO+tYwcvb0V9mxYqyvP4NYtZyQoI2p9Of5Pmd1aNHT8=
Received: from [127.0.0.1] (unknown [192.168.100.1])
	by localhost.localdomain (Coremail) with SMTP id AQAAfwA3cUKLueVpsH8CAA--.1560S2;
	Mon, 20 Apr 2026 13:28:43 +0800 (CST)
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
Cc: Jia Wang <wangjia@ultrarisc.com>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-serial@vger.kernel.org, linux-riscv@lists.infradead.org, 
 devicetree@vger.kernel.org, Zhang Xincheng <zhangxincheng@ultrarisc.com>
In-Reply-To: <aeHlaTIKm1wl0J0_@ashevche-desk.local>
References: <20260316-ultrarisc-serial-v2-0-6ab3e7fa891c@ultrarisc.com>
 <20260316-ultrarisc-serial-v2-2-6ab3e7fa891c@ultrarisc.com>
 <abfrDBeJrValJR9a@ashevche-desk.local>
 <177641113786.3193169.8990532982066985425.b4-reply@b4>
 <aeHlaTIKm1wl0J0_@ashevche-desk.local>
Date: Mon, 20 Apr 2026 13:27:58 +0800
Message-Id: <177666287849.426965.12290556566565086842.b4-reply@b4>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776662878; l=1328;
 i=wangjia@ultrarisc.com; s=20260309; h=from:subject:message-id;
 bh=P9/Oiu3kQIkJb/NpuqfPAVmLxhp49AvaTmRzYpwIzRw=;
 b=eIKQch2jGWuWKaIN6LzclmglnfU2Z5aymgJwTpPw/uDrkz0XSZsnJ/NFzKdeVAj+mU+F0J9ZE
 nQxwV7EMb6HD+aXy1Xq8v8B6sqJ1rE8lOInPIN/hC51y/XXxF3UCMkh
X-Developer-Key: i=wangjia@ultrarisc.com; a=ed25519;
 pk=XvYkrelqJIIzobY7j+nIg8rsfv5kzaOzuc1UPhd087U=
X-CM-TRANSID:AQAAfwA3cUKLueVpsH8CAA--.1560S2
X-Coremail-Antispam: 1UD129KBjvJXoWrZw13JrW8Kr43WF15Gr4Uurg_yoW8Jr4DpF
	W5Ja15ta97Kr12vryvvF1Svr1Fgan7G34Yqr15Wry5ta1Ykwnaqr47tayY9F97urn8Aw1Y
	va4YqFZxXwsxuaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnUUvcSsGvfC2KfnxnUUI43ZEXa7xR_UUUUUUUUU==
X-CM-SenderInfo: pzdqwylld63zxwud2x1vfou0bp/1tbiAQAAEWnhrj0AIAADso

On 2026-04-17 10:46 +0300, Andy Shevchenko wrote:
> On Fri, Apr 17, 2026 at 03:32:17PM +0800, Jia Wang wrote:
> > On 2026-03-16 13:35 +0200, Andy Shevchenko wrote:
> > > On Mon, Mar 16, 2026 at 02:33:23PM +0800, Jia Wang via B4 Relay wrote:
> 
> ...
> 
> > > > +#define DW_UART_QUIRK_FIXED_TYPE	BIT(6)
> > > 
> > > Seems unrequired.
> > > 
> > > But to make sure, can you elaborate what's going on here?
> > > What is the reads from UCV and CPR registers?
> > 
> > Apologies for the delayed response.
> > 
> > Our DW UART implementation on DP1000 does not provide the CPR/UCV capability
> > registers, and reads from both registers always return 0. As a result, the
> > autodetection logic in 8250_dw cannot obtain meaningful capability
> > information.
> > 
> > To handle this, the current approach is to skip autodetection and rely on
> > fixed configuration via a quirk.
> > 
> > If there is a preferred or more appropriate way to support DW UART instances
> > without CPR/UCV, I would be happy to adjust the implementation based on your
> > suggestions.
> 
> Why can't you provide a CPR value via the existing quirk?
>

Thanks for the feedback.

I will switch to using DW_UART_QUIRK_CPR_VALUE in v3.
 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
>

Best Regards,
Jia Wang 


