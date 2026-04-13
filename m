Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9D4B156677;
	Mon, 13 Apr 2026 04:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776052991; cv=none; b=kBH6Whefja/c7gFep5CQvCp8UbEfZN+332+n8iIQnTunr3kd5ivuo0PNnULHIMCnx2d8w/hhKsWJwXRU/tt4SdeneH7VFc2RpjDYySnmV8kJLC5T8vNz2ywaV2522tIcUaBvRmRw/juUs8+oWw++CYKaqFXTTZyivs/aqnXFJMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776052991; c=relaxed/simple;
	bh=vjN8HmC5YMVUyIV59xFNbmlxN+h0QIFMrdoQTeizOt8=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=KQ/0YshMKyeINqCFnQrCi4e4m3qIs/p/AIdMkBsK5ekIpqC3mVrb4YTO+xDs2nM2UzFKp0KvJ2DtqKG+NyGk51HM65mxHXpfjct53xRanvBuDGXbJ7CN1TmU32qDeogJJ1gpYgrIwBDarB2ZNHN97LgW0hJO1TG+nma4QLi5phY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 8917A92009C; Mon, 13 Apr 2026 06:03:07 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 81B7192009B;
	Mon, 13 Apr 2026 05:03:07 +0100 (BST)
Date: Mon, 13 Apr 2026 05:03:07 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>
cc: Elena Reshetova <elena.reshetova@intel.com>, 
    David Windsor <dwindsor@gmail.com>, Kees Cook <kees@kernel.org>, 
    Hans Liljestrand <ishkamiel@gmail.com>, linux-mips@vger.kernel.org, 
    linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/4] MIPS: SiByte: Fix serial device regressions
Message-ID: <alpine.DEB.2.21.2604130453400.29980@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

Hi,

 This v2 of the series discards a stray `i' local variable from 3/4 that 
causes a compiler warning missed in verification.  No functional change.

 Starting from commit 84a9582fd203 ("serial: core: Start managing serial 
controllers to enable runtime PM") the driver for the SiByte onchip DUART 
has stopped working due to a null pointer dereference in the serial core, 
which means a kernel crash at bootstrap if the driver has been enabled, as 
is usually the case for the system console.

 This patch series addresses the issue by switching the driver away from 
legacy probing to using platform devices.  A notable consequence of this 
is the serial console is only switched from the bootconsole handler that 
uses firmware calls over to our serial driver at the time the driver is 
being properly brought up.  This causes messages to be produced to the 
console between the device reset and console setup, which in turn causes 
the firmware still being called via the bootconsole handler to loop 
forever owing to the transmitter having been disabled.

 Therefore introductory change 2/4 is included to fix the issue by doing a 
rudimentary device setup right after reset, using parameters compatible 
with those used by the firmware (115200n8).  There is auxiliary change 1/4 
included as well that prevents message corruption from happening at reset, 
which becomes more prominent due to the change in timing, with the driver 
switch to the platform device, of messages produced to the console.

 Additionally there is a revert included as change 4/4 for a regression 
introduced by an earlier change that caused previously good code to fail 
requesting the control register resource shared between DUART channels, 
and issue a warning to the kernel log.  Not to be backported as strictly 
speaking the driver works just fine despite the missing reservation.

 See individual change descriptions for details.  Verified with a SWARM
(BCM91250A) system.

 Please apply.

  Maciej
